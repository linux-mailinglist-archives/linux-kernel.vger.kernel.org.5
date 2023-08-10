Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2889B777D15
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 18:01:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232404AbjHJQBQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 12:01:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236300AbjHJQBD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 12:01:03 -0400
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D65C2713;
        Thu, 10 Aug 2023 09:00:49 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 13F5C635D2A4;
        Thu, 10 Aug 2023 18:00:48 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id bugUimCkv4m6; Thu, 10 Aug 2023 18:00:47 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 9720F635D2A2;
        Thu, 10 Aug 2023 18:00:47 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id NfQzJITzRPaO; Thu, 10 Aug 2023 18:00:47 +0200 (CEST)
Received: from foxxylove.corp.sigma-star.at (unknown [82.150.214.1])
        by lithops.sigma-star.at (Postfix) with ESMTPSA id 386F5635D296;
        Thu, 10 Aug 2023 18:00:47 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     linux-mtd@lists.infradead.org
Cc:     Christoph Hellwig <hch@infradead.org>,
        Stephan Wurm <stephan.wurm@a-eberle.de>,
        Richard Weinberger <richard@nod.at>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Oliver Neukum <oliver@neukum.org>,
        Ali Akcaagac <aliakc@web.de>,
        Jamie Lenehan <lenehan@twibble.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: [PATCH 6/7] ubi: block: Switch to kmap_sg
Date:   Thu, 10 Aug 2023 18:00:17 +0200
Message-Id: <20230810160019.16977-7-richard@nod.at>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230810160019.16977-1-richard@nod.at>
References: <20230810160019.16977-1-richard@nod.at>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,T_SPF_PERMERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove our copy of scsi_kmap_atomic_sg() and use the new helper
kmap_sg(). Since it is based on kmap_local() we can remove the
bounce buffer and perform IO while we hold the mapping.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 drivers/mtd/ubi/eba.c | 59 +++++--------------------------------------
 1 file changed, 6 insertions(+), 53 deletions(-)

diff --git a/drivers/mtd/ubi/eba.c b/drivers/mtd/ubi/eba.c
index 82c54bf7c2067..650eacab27f03 100644
--- a/drivers/mtd/ubi/eba.c
+++ b/drivers/mtd/ubi/eba.c
@@ -731,44 +731,6 @@ int ubi_eba_read_leb(struct ubi_device *ubi, struct =
ubi_volume *vol, int lnum,
 	return err;
 }
=20
-/*
- * Basically a copy of scsi_kmap_atomic_sg().
- * As long scsi_kmap_atomic_sg() is not part of lib/scatterlist.c have
- * our own version to avoid a dependency on CONFIG_SCSI.
- */
-static void *ubi_kmap_atomic_sg(struct scatterlist *sgl, int sg_count,
-			  size_t *offset, size_t *len)
-{
-	int i;
-	size_t sg_len =3D 0, len_complete =3D 0;
-	struct scatterlist *sg;
-	struct page *page;
-
-	for_each_sg(sgl, sg, sg_count, i) {
-		len_complete =3D sg_len; /* Complete sg-entries */
-		sg_len +=3D sg->length;
-		if (sg_len > *offset)
-			break;
-	}
-
-	if (WARN_ON_ONCE(i =3D=3D sg_count))
-		return NULL;
-
-	/* Offset starting from the beginning of first page in this sg-entry */
-	*offset =3D *offset - len_complete + sg->offset;
-
-	/* Assumption: contiguous pages can be accessed as "page + i" */
-	page =3D nth_page(sg_page(sg), (*offset >> PAGE_SHIFT));
-	*offset &=3D ~PAGE_MASK;
-
-	/* Bytes in this sg-entry from *offset to the end of the page */
-	sg_len =3D PAGE_SIZE - *offset;
-	if (*len > sg_len)
-		*len =3D sg_len;
-
-	return kmap_atomic(page);
-}
-
 /**
  * ubi_eba_read_leb_sg - read data into a scatter gather list.
  * @ubi: UBI device description object
@@ -789,17 +751,6 @@ int ubi_eba_read_leb_sg(struct ubi_device *ubi, stru=
ct ubi_volume *vol,
 {
 	size_t map_len, map_offset, cur_offset;
 	int ret, to_read =3D len;
-	char *bounce_buf;
-
-	bounce_buf =3D kvmalloc(to_read, GFP_KERNEL);
-	if (!bounce_buf) {
-		ret =3D -ENOMEM;
-		goto out;
-	}
-
-	ret =3D ubi_eba_read_leb(ubi, vol, lnum, bounce_buf, offset, to_read, c=
heck);
-	if (ret < 0)
-		goto out;
=20
 	cur_offset =3D 0;
 	while (to_read > 0) {
@@ -808,9 +759,12 @@ int ubi_eba_read_leb_sg(struct ubi_device *ubi, stru=
ct ubi_volume *vol,
 		map_len =3D to_read;
 		map_offset =3D cur_offset + sgl->tot_offset;
=20
-		dst =3D ubi_kmap_atomic_sg(sgl->sg, sgl->len, &map_offset, &map_len);
-		memcpy(dst + map_offset, bounce_buf + cur_offset, map_len);
-		kunmap_atomic(dst);
+		dst =3D kmap_sg(sgl->sg, sgl->len, &map_offset, &map_len);
+		ret =3D ubi_eba_read_leb(ubi, vol, lnum, dst + map_offset, offset + cu=
r_offset,
+				       map_len, check);
+		if (ret < 0)
+			goto out;
+		kunmap_sg(dst);
=20
 		cur_offset +=3D map_len;
 		to_read -=3D map_len;
@@ -818,7 +772,6 @@ int ubi_eba_read_leb_sg(struct ubi_device *ubi, struc=
t ubi_volume *vol,
=20
 	ret =3D 0;
 out:
-	kvfree(bounce_buf);
 	return ret;
 }
=20
--=20
2.35.3


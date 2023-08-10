Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9DAD777D0F
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 18:01:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236316AbjHJQAu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 12:00:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235089AbjHJQAn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 12:00:43 -0400
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F4FD26B9;
        Thu, 10 Aug 2023 09:00:40 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id CC647635D290;
        Thu, 10 Aug 2023 18:00:38 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 98qcvanlYtQc; Thu, 10 Aug 2023 18:00:38 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 34314635D2A1;
        Thu, 10 Aug 2023 18:00:38 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id xBBmf1iN98Fa; Thu, 10 Aug 2023 18:00:38 +0200 (CEST)
Received: from foxxylove.corp.sigma-star.at (unknown [82.150.214.1])
        by lithops.sigma-star.at (Postfix) with ESMTPSA id C5849635D290;
        Thu, 10 Aug 2023 18:00:37 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     linux-mtd@lists.infradead.org
Cc:     Christoph Hellwig <hch@infradead.org>,
        Stephan Wurm <stephan.wurm@a-eberle.de>,
        Richard Weinberger <richard@nod.at>, stable@vger.kernel.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Oliver Neukum <oliver@neukum.org>,
        Ali Akcaagac <aliakc@web.de>,
        Jamie Lenehan <lenehan@twibble.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: [PATCH 1/7] ubi: block: Refactor sg list processing for highmem
Date:   Thu, 10 Aug 2023 18:00:12 +0200
Message-Id: <20230810160019.16977-2-richard@nod.at>
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

Currently sg_virt() is used while filling the sg list from LEB data.
This approach cannot work with highmem.

Refactor ubi_eba_read_leb_sg() to use kmap_atomic() for sg list
access.
Since kmap_atomic() disables preempt a bounce buffer is needed.
kmap_local_page() is not used to allow easy backporting of this patch
to older kernels.

The followup patches in this series will switch to kmap_sg()
and we can remove our own helper and the bounce buffer.

Cc: stable@vger.kernel.org
Fixes: 9ff08979e1742 ("UBI: Add initial support for scatter gather")
Reported-by: Stephan Wurm <stephan.wurm@a-eberle.de>
Signed-off-by: Richard Weinberger <richard@nod.at>
---
 drivers/mtd/ubi/block.c | 11 ++---
 drivers/mtd/ubi/eba.c   | 95 ++++++++++++++++++++++++++++-------------
 include/linux/mtd/ubi.h | 12 +++---
 3 files changed, 76 insertions(+), 42 deletions(-)

diff --git a/drivers/mtd/ubi/block.c b/drivers/mtd/ubi/block.c
index 437c5b83ffe51..5b2e6c74ac5a8 100644
--- a/drivers/mtd/ubi/block.c
+++ b/drivers/mtd/ubi/block.c
@@ -193,13 +193,10 @@ static blk_status_t ubiblock_read(struct request *r=
eq)
=20
 	blk_mq_start_request(req);
=20
-	/*
-	 * It is safe to ignore the return value of blk_rq_map_sg() because
-	 * the number of sg entries is limited to UBI_MAX_SG_COUNT
-	 * and ubi_read_sg() will check that limit.
-	 */
 	ubi_sgl_init(&pdu->usgl);
-	blk_rq_map_sg(req->q, req, pdu->usgl.sg);
+	ret =3D blk_rq_map_sg(req->q, req, pdu->usgl.sg);
+	ubi_assert(ret > 0 && ret < UBI_MAX_SG_COUNT);
+	pdu->usgl.len =3D ret;
=20
 	while (bytes_left) {
 		/*
@@ -212,7 +209,7 @@ static blk_status_t ubiblock_read(struct request *req=
)
 		ret =3D ubi_read_sg(dev->desc, leb, &pdu->usgl, offset, to_read);
 		if (ret < 0)
 			break;
-
+		pdu->usgl.tot_offset +=3D to_read;
 		bytes_left -=3D to_read;
 		to_read =3D bytes_left;
 		leb +=3D 1;
diff --git a/drivers/mtd/ubi/eba.c b/drivers/mtd/ubi/eba.c
index 655ff41863e2b..82c54bf7c2067 100644
--- a/drivers/mtd/ubi/eba.c
+++ b/drivers/mtd/ubi/eba.c
@@ -31,6 +31,7 @@
 #include <linux/slab.h>
 #include <linux/crc32.h>
 #include <linux/err.h>
+#include <linux/highmem.h>
 #include "ubi.h"
=20
 /* Number of physical eraseblocks reserved for atomic LEB change operati=
on */
@@ -730,6 +731,44 @@ int ubi_eba_read_leb(struct ubi_device *ubi, struct =
ubi_volume *vol, int lnum,
 	return err;
 }
=20
+/*
+ * Basically a copy of scsi_kmap_atomic_sg().
+ * As long scsi_kmap_atomic_sg() is not part of lib/scatterlist.c have
+ * our own version to avoid a dependency on CONFIG_SCSI.
+ */
+static void *ubi_kmap_atomic_sg(struct scatterlist *sgl, int sg_count,
+			  size_t *offset, size_t *len)
+{
+	int i;
+	size_t sg_len =3D 0, len_complete =3D 0;
+	struct scatterlist *sg;
+	struct page *page;
+
+	for_each_sg(sgl, sg, sg_count, i) {
+		len_complete =3D sg_len; /* Complete sg-entries */
+		sg_len +=3D sg->length;
+		if (sg_len > *offset)
+			break;
+	}
+
+	if (WARN_ON_ONCE(i =3D=3D sg_count))
+		return NULL;
+
+	/* Offset starting from the beginning of first page in this sg-entry */
+	*offset =3D *offset - len_complete + sg->offset;
+
+	/* Assumption: contiguous pages can be accessed as "page + i" */
+	page =3D nth_page(sg_page(sg), (*offset >> PAGE_SHIFT));
+	*offset &=3D ~PAGE_MASK;
+
+	/* Bytes in this sg-entry from *offset to the end of the page */
+	sg_len =3D PAGE_SIZE - *offset;
+	if (*len > sg_len)
+		*len =3D sg_len;
+
+	return kmap_atomic(page);
+}
+
 /**
  * ubi_eba_read_leb_sg - read data into a scatter gather list.
  * @ubi: UBI device description object
@@ -748,40 +787,38 @@ int ubi_eba_read_leb_sg(struct ubi_device *ubi, str=
uct ubi_volume *vol,
 			struct ubi_sgl *sgl, int lnum, int offset, int len,
 			int check)
 {
-	int to_read;
-	int ret;
-	struct scatterlist *sg;
+	size_t map_len, map_offset, cur_offset;
+	int ret, to_read =3D len;
+	char *bounce_buf;
=20
-	for (;;) {
-		ubi_assert(sgl->list_pos < UBI_MAX_SG_COUNT);
-		sg =3D &sgl->sg[sgl->list_pos];
-		if (len < sg->length - sgl->page_pos)
-			to_read =3D len;
-		else
-			to_read =3D sg->length - sgl->page_pos;
-
-		ret =3D ubi_eba_read_leb(ubi, vol, lnum,
-				       sg_virt(sg) + sgl->page_pos, offset,
-				       to_read, check);
-		if (ret < 0)
-			return ret;
-
-		offset +=3D to_read;
-		len -=3D to_read;
-		if (!len) {
-			sgl->page_pos +=3D to_read;
-			if (sgl->page_pos =3D=3D sg->length) {
-				sgl->list_pos++;
-				sgl->page_pos =3D 0;
-			}
+	bounce_buf =3D kvmalloc(to_read, GFP_KERNEL);
+	if (!bounce_buf) {
+		ret =3D -ENOMEM;
+		goto out;
+	}
=20
-			break;
-		}
+	ret =3D ubi_eba_read_leb(ubi, vol, lnum, bounce_buf, offset, to_read, c=
heck);
+	if (ret < 0)
+		goto out;
+
+	cur_offset =3D 0;
+	while (to_read > 0) {
+		char *dst;
=20
-		sgl->list_pos++;
-		sgl->page_pos =3D 0;
+		map_len =3D to_read;
+		map_offset =3D cur_offset + sgl->tot_offset;
+
+		dst =3D ubi_kmap_atomic_sg(sgl->sg, sgl->len, &map_offset, &map_len);
+		memcpy(dst + map_offset, bounce_buf + cur_offset, map_len);
+		kunmap_atomic(dst);
+
+		cur_offset +=3D map_len;
+		to_read -=3D map_len;
 	}
=20
+	ret =3D 0;
+out:
+	kvfree(bounce_buf);
 	return ret;
 }
=20
diff --git a/include/linux/mtd/ubi.h b/include/linux/mtd/ubi.h
index a529347fd75b2..521e0e8b3ede3 100644
--- a/include/linux/mtd/ubi.h
+++ b/include/linux/mtd/ubi.h
@@ -115,8 +115,8 @@ struct ubi_volume_info {
=20
 /**
  * struct ubi_sgl - UBI scatter gather list data structure.
- * @list_pos: current position in @sg[]
- * @page_pos: current position in @sg[@list_pos]
+ * @list_len: number of elemtns in @sg[]
+ * @tot_offset: current position the scatter gather list
  * @sg: the scatter gather list itself
  *
  * ubi_sgl is a wrapper around a scatter list which keeps track of the
@@ -124,8 +124,8 @@ struct ubi_volume_info {
  * it can be used across multiple ubi_leb_read_sg() calls.
  */
 struct ubi_sgl {
-	int list_pos;
-	int page_pos;
+	int len;
+	int tot_offset;
 	struct scatterlist sg[UBI_MAX_SG_COUNT];
 };
=20
@@ -138,8 +138,8 @@ struct ubi_sgl {
  */
 static inline void ubi_sgl_init(struct ubi_sgl *usgl)
 {
-	usgl->list_pos =3D 0;
-	usgl->page_pos =3D 0;
+	usgl->len =3D 0;
+	usgl->tot_offset =3D 0;
 }
=20
 /**
--=20
2.35.3


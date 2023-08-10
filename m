Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 132A5777D19
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 18:01:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236378AbjHJQBT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 12:01:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236347AbjHJQBG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 12:01:06 -0400
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D7D2271E;
        Thu, 10 Aug 2023 09:00:51 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id D890A635D2A8;
        Thu, 10 Aug 2023 18:00:49 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id id0-MKyNRELX; Thu, 10 Aug 2023 18:00:49 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 7B8F6635D2A2;
        Thu, 10 Aug 2023 18:00:49 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id NtQ5uhq1a5o1; Thu, 10 Aug 2023 18:00:49 +0200 (CEST)
Received: from foxxylove.corp.sigma-star.at (unknown [82.150.214.1])
        by lithops.sigma-star.at (Postfix) with ESMTPSA id 10ECD635D29F;
        Thu, 10 Aug 2023 18:00:49 +0200 (CEST)
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
Subject: [PATCH 7/7] scsi: core: Remove scsi_kmap_atomic_sg()
Date:   Thu, 10 Aug 2023 18:00:18 +0200
Message-Id: <20230810160019.16977-8-richard@nod.at>
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

All users have been migrated to use kmap_sg(), let's kill
this helper.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 drivers/scsi/scsi_lib.c  | 60 ----------------------------------------
 include/scsi/scsi_cmnd.h |  4 ---
 2 files changed, 64 deletions(-)

diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index ad9afae49544a..70469502aeb76 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -3001,66 +3001,6 @@ scsi_host_unblock(struct Scsi_Host *shost, int new=
_state)
 }
 EXPORT_SYMBOL_GPL(scsi_host_unblock);
=20
-/**
- * scsi_kmap_atomic_sg - find and atomically map an sg-elemnt
- * @sgl:	scatter-gather list
- * @sg_count:	number of segments in sg
- * @offset:	offset in bytes into sg, on return offset into the mapped ar=
ea
- * @len:	bytes to map, on return number of bytes mapped
- *
- * Returns virtual address of the start of the mapped page
- */
-void *scsi_kmap_atomic_sg(struct scatterlist *sgl, int sg_count,
-			  size_t *offset, size_t *len)
-{
-	int i;
-	size_t sg_len =3D 0, len_complete =3D 0;
-	struct scatterlist *sg;
-	struct page *page;
-
-	WARN_ON(!irqs_disabled());
-
-	for_each_sg(sgl, sg, sg_count, i) {
-		len_complete =3D sg_len; /* Complete sg-entries */
-		sg_len +=3D sg->length;
-		if (sg_len > *offset)
-			break;
-	}
-
-	if (unlikely(i =3D=3D sg_count)) {
-		printk(KERN_ERR "%s: Bytes in sg: %zu, requested offset %zu, "
-			"elements %d\n",
-		       __func__, sg_len, *offset, sg_count);
-		WARN_ON(1);
-		return NULL;
-	}
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
-EXPORT_SYMBOL(scsi_kmap_atomic_sg);
-
-/**
- * scsi_kunmap_atomic_sg - atomically unmap a virtual address, previousl=
y mapped with scsi_kmap_atomic_sg
- * @virt:	virtual address to be unmapped
- */
-void scsi_kunmap_atomic_sg(void *virt)
-{
-	kunmap_atomic(virt);
-}
-EXPORT_SYMBOL(scsi_kunmap_atomic_sg);
-
 void sdev_disable_disk_events(struct scsi_device *sdev)
 {
 	atomic_inc(&sdev->disk_events_disable_depth);
diff --git a/include/scsi/scsi_cmnd.h b/include/scsi/scsi_cmnd.h
index 526def14e7fb7..919ac97229481 100644
--- a/include/scsi/scsi_cmnd.h
+++ b/include/scsi/scsi_cmnd.h
@@ -163,10 +163,6 @@ void scsi_done_direct(struct scsi_cmnd *cmd);
=20
 extern void scsi_finish_command(struct scsi_cmnd *cmd);
=20
-extern void *scsi_kmap_atomic_sg(struct scatterlist *sg, int sg_count,
-				 size_t *offset, size_t *len);
-extern void scsi_kunmap_atomic_sg(void *virt);
-
 blk_status_t scsi_alloc_sgtables(struct scsi_cmnd *cmd);
 void scsi_free_sgtables(struct scsi_cmnd *cmd);
=20
--=20
2.35.3


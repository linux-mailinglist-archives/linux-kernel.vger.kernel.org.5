Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67104777D13
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 18:01:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236306AbjHJQAs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 12:00:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235255AbjHJQAn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 12:00:43 -0400
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C82602702;
        Thu, 10 Aug 2023 09:00:41 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 88BAB622F562;
        Thu, 10 Aug 2023 18:00:40 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id EDfStOmQ8fP8; Thu, 10 Aug 2023 18:00:40 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 1C754635D2A1;
        Thu, 10 Aug 2023 18:00:40 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id yaVTxL2OMKCP; Thu, 10 Aug 2023 18:00:40 +0200 (CEST)
Received: from foxxylove.corp.sigma-star.at (unknown [82.150.214.1])
        by lithops.sigma-star.at (Postfix) with ESMTPSA id AF6E1635D295;
        Thu, 10 Aug 2023 18:00:39 +0200 (CEST)
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
Subject: [PATCH 2/7] scatterlist: Add kmap helpers
Date:   Thu, 10 Aug 2023 18:00:13 +0200
Message-Id: <20230810160019.16977-3-richard@nod.at>
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

kmap_sg() is basically scsi_kmap_atomic_sg() but uses kmap_local()
and does not enforce disabled interrupts.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 include/linux/scatterlist.h |  3 ++
 lib/scatterlist.c           | 55 +++++++++++++++++++++++++++++++++++++
 2 files changed, 58 insertions(+)

diff --git a/include/linux/scatterlist.h b/include/linux/scatterlist.h
index 77df3d7b18a61..dd25a87609491 100644
--- a/include/linux/scatterlist.h
+++ b/include/linux/scatterlist.h
@@ -692,4 +692,7 @@ bool sg_miter_skip(struct sg_mapping_iter *miter, off=
_t offset);
 bool sg_miter_next(struct sg_mapping_iter *miter);
 void sg_miter_stop(struct sg_mapping_iter *miter);
=20
+void *kmap_sg(struct scatterlist *sgl, int sg_count, size_t *offset, siz=
e_t *len);
+void kunmap_sg(void *virt);
+
 #endif /* _LINUX_SCATTERLIST_H */
diff --git a/lib/scatterlist.c b/lib/scatterlist.c
index e86231a44c3de..7428d9461711d 100644
--- a/lib/scatterlist.c
+++ b/lib/scatterlist.c
@@ -1364,3 +1364,58 @@ ssize_t extract_iter_to_sg(struct iov_iter *iter, =
size_t maxsize,
 	}
 }
 EXPORT_SYMBOL_GPL(extract_iter_to_sg);
+
+/**
+ * kmap_sg - find and kmap an sg-elemnt
+ * @sgl:	scatter-gather list
+ * @sg_count:	number of segments in sg
+ * @offset:	offset in bytes into sg, on return offset into the mapped ar=
ea
+ * @len:	bytes to map, on return number of bytes mapped
+ *
+ * Returns virtual address of the start of the mapped page
+ */
+void *kmap_sg(struct scatterlist *sgl, int sg_count, size_t *offset, siz=
e_t *len)
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
+	if (WARN_ON_ONCE(i =3D=3D sg_count)) {
+		pr_err("%s: Bytes in sg: %zu, requested offset %zu, elements %d\n",
+		       __func__, sg_len, *offset, sg_count);
+		return NULL;
+	}
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
+	return kmap_local_page(page);
+}
+EXPORT_SYMBOL(kmap_sg);
+
+/**
+ * kunmap_sg - atomically unmap a virtual address, previously mapped wit=
h kmap_sg
+ * @virt:	virtual address to be unmapped
+ */
+void kunmap_sg(void *virt)
+{
+	kunmap_local(virt);
+}
+EXPORT_SYMBOL(kunmap_sg);
--=20
2.35.3


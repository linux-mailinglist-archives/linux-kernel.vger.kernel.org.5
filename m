Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9BB078E23F
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 00:21:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343775AbjH3WVL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 18:21:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343738AbjH3WVG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 18:21:06 -0400
X-Greylist: delayed 3360 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 30 Aug 2023 15:20:45 PDT
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 766B0CE7
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 15:20:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4F4EEB8201B
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 21:23:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24FFBC433C8;
        Wed, 30 Aug 2023 21:23:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693430588;
        bh=WNWg7VP05g6kGXkXozvlUrP9YXpC0uBWHnqinPizuqQ=;
        h=From:To:Cc:Subject:Date:From;
        b=BVN4reKnzN3NNsB/Gz28AQmjOkNAsuAeGqKRq8BcxVMTIrxb/jWaRUfJ13AEqHKnQ
         HQPGcREwKPjdjY0u6Nm+EBi74Hz6iRmTAA0L5l6lgDH54jogtqfw0tsAbxGodhwZAw
         klzhptnEypYGk6uhTisqDlQhIVv9YjnzSSyEd84talsSGlswDnRsaH++HNks9akQsO
         gdRKLdMapITMIAsdUX4LMuDhB1YphtxApd8SeuARlzgDO0tbiZvdruXdHTIMjZAgwR
         9k1IdMyiLM2wN/7y451D8Vsq9S9uGtJ7+DzRmUlLpSNOkBNMNnfP4e7+gHr4KgKLR8
         FnCmVQqLaZkaw==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Eric Biggers <ebiggers@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH] pstore: Base compression input buffer size on estimated compressed size
Date:   Wed, 30 Aug 2023 23:22:38 +0200
Message-Id: <20230830212238.135900-1-ardb@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6123; i=ardb@kernel.org; h=from:subject; bh=WNWg7VP05g6kGXkXozvlUrP9YXpC0uBWHnqinPizuqQ=; b=owGbwMvMwCFmkMcZplerG8N4Wi2JIeX9ZtlTTOKX2Jd9UzZfIv9tvWTdpPqbs+7+tC5adXzJ3 qTpN+8qdZSyMIhxMMiKKbIIzP77bufpiVK1zrNkYeawMoEMYeDiFICJbP7E8E//z/ZQ1+O93FGb fgfP6p6fu9NUTEKwNp6rXSl1nqrMCnVGhr5vn1tjFTaVSy+JFPap+yArd1oohd/v1PKUVFv1dWt EWAA=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 1756ddea6916 ("pstore: Remove worst-case compression size logic")
removed some clunky per-algorithm worst case size estimation routines on
the basis that we can always store pstore records uncompressed, and
these worst case estimations are about how much the size might
inadvertently *increase* due to encapsulation overhead when the input
cannot be compressed at all. So if compression results in a size
increase, we just store the original data instead.

However, it seems that the the original code was misinterpreting these
calculations as an estimation of how much uncompressed data might fit
into a compressed buffer of a given size, and it was using the results
to consume the input data in larger chunks than the pstore record size,
relying on the compression to ensure that what ultimately gets stored
fits into the available space.

One result of this, as observed and reported by Linus, is that upgrading
to a newer kernel that includes the given commit may result in pstore
decompression errors reported in the kernel log. This is due to the fact
that the existing records may unexpectedly decompress to a size that is
larger than the pstore record size.

Another potential problem caused by this change is that we may
underutilize the fixed sized records on pstore backends such as ramoops.
And on pstore backends with variable sized records such as EFI, we will
end up creating many more entries than before to store the same amount
of compressed data.

So let's fix both issues, by bringing back the typical case estimation of
how much ASCII text captured from the dmesg log might fit into a pstore
record of a given size after compression. The original implementation
used the computation given below for zlib, and so simply taking 2x as a
ballpark number seems appropriate here.

  switch (size) {
  /* buffer range for efivars */
  case 1000 ... 2000:
  	cmpr = 56;
  	break;
  case 2001 ... 3000:
  	cmpr = 54;
  	break;
  case 3001 ... 3999:
  	cmpr = 52;
  	break;
  /* buffer range for nvram, erst */
  case 4000 ... 10000:
  	cmpr = 45;
  	break;
  default:
  	cmpr = 60;
  	break;
  }

  return (size * 100) / cmpr;

While at it, rate limit the error message so we don't flood the log
unnecessarily on systems that have accumulated a lot of pstore history.

Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Eric Biggers <ebiggers@kernel.org>
Cc: Kees Cook <keescook@chromium.org>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 fs/pstore/platform.c | 30 +++++++++++++++++++++++-------
 1 file changed, 23 insertions(+), 7 deletions(-)

diff --git a/fs/pstore/platform.c b/fs/pstore/platform.c
index 62356d542ef67f60..a866b70ea5933a1d 100644
--- a/fs/pstore/platform.c
+++ b/fs/pstore/platform.c
@@ -98,7 +98,14 @@ MODULE_PARM_DESC(kmsg_bytes, "amount of kernel log to snapshot (in bytes)");
 
 static void *compress_workspace;
 
+/*
+ * Compression is only used for dmesg output, which consists of low-entropy
+ * ASCII text, and so we can assume a 2x compression factor is achievable.
+ */
+#define DMESG_COMP_FACTOR	2
+
 static char *big_oops_buf;
+static size_t max_uncompressed_size;
 
 void pstore_set_kmsg_bytes(int bytes)
 {
@@ -216,7 +223,7 @@ static void allocate_buf_for_compression(void)
 	 * uncompressed record size, since any record that would be expanded by
 	 * compression is just stored uncompressed.
 	 */
-	buf = kvzalloc(psinfo->bufsize, GFP_KERNEL);
+	buf = kvzalloc(DMESG_COMP_FACTOR * psinfo->bufsize, GFP_KERNEL);
 	if (!buf) {
 		pr_err("Failed %zu byte compression buffer allocation for: %s\n",
 		       psinfo->bufsize, compress);
@@ -233,6 +240,7 @@ static void allocate_buf_for_compression(void)
 
 	/* A non-NULL big_oops_buf indicates compression is available. */
 	big_oops_buf = buf;
+	max_uncompressed_size = DMESG_COMP_FACTOR * psinfo->bufsize;
 
 	pr_info("Using crash dump compression: %s\n", compress);
 }
@@ -246,6 +254,7 @@ static void free_buf_for_compression(void)
 
 	kvfree(big_oops_buf);
 	big_oops_buf = NULL;
+	max_uncompressed_size = 0;
 }
 
 void pstore_record_init(struct pstore_record *record,
@@ -305,7 +314,7 @@ static void pstore_dump(struct kmsg_dumper *dumper,
 		record.buf = psinfo->buf;
 
 		dst = big_oops_buf ?: psinfo->buf;
-		dst_size = psinfo->bufsize;
+		dst_size = max_uncompressed_size ?: psinfo->bufsize;
 
 		/* Write dump header. */
 		header_size = snprintf(dst, dst_size, "%s#%d Part%u\n", why,
@@ -326,8 +335,15 @@ static void pstore_dump(struct kmsg_dumper *dumper,
 				record.compressed = true;
 				record.size = zipped_len;
 			} else {
-				record.size = header_size + dump_size;
-				memcpy(psinfo->buf, dst, record.size);
+				/*
+				 * Compression failed, so the buffer is most
+				 * likely filled with binary data that does not
+				 * compress as well as ASCII text. Copy as much
+				 * of the uncompressed data as possible into
+				 * the pstore record, and discard the rest.
+				 */
+				record.size = psinfo->bufsize;
+				memcpy(psinfo->buf, dst, psinfo->bufsize);
 			}
 		} else {
 			record.size = header_size + dump_size;
@@ -583,7 +599,7 @@ static void decompress_record(struct pstore_record *record,
 	}
 
 	/* Allocate enough space to hold max decompression and ECC. */
-	workspace = kvzalloc(psinfo->bufsize + record->ecc_notice_size,
+	workspace = kvzalloc(max_uncompressed_size + record->ecc_notice_size,
 			     GFP_KERNEL);
 	if (!workspace)
 		return;
@@ -591,11 +607,11 @@ static void decompress_record(struct pstore_record *record,
 	zstream->next_in	= record->buf;
 	zstream->avail_in	= record->size;
 	zstream->next_out	= workspace;
-	zstream->avail_out	= psinfo->bufsize;
+	zstream->avail_out	= max_uncompressed_size;
 
 	ret = zlib_inflate(zstream, Z_FINISH);
 	if (ret != Z_STREAM_END) {
-		pr_err("zlib_inflate() failed, ret = %d!\n", ret);
+		pr_err_ratelimited("zlib_inflate() failed, ret = %d!\n", ret);
 		kvfree(workspace);
 		return;
 	}
-- 
2.39.2


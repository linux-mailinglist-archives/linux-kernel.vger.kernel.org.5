Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A112778F456
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 23:01:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347473AbjHaVBg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 17:01:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345052AbjHaVBe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 17:01:34 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6A49FF
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 14:01:31 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1bc0d39b52cso9537645ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 14:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1693515691; x=1694120491; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fWpFWDJT2+LpVO7mSwGG21NXDpOKixMY4mi0VY93uuY=;
        b=aq09DfrB94135F1DSv94+gbxrovCDg2etrzOZVLil6dZwvzGdmAhGZ6+xx3yR6tUCx
         QP/JQzktlzeQs7e6JSsDKkL89Znqq5QdOfCS8QeWo/xBqlJ4lFdSocUciK9/E6ttcnFE
         a6TS4/Uw34D+7qWnIXflESWd/iZtuLxUpdKlk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693515691; x=1694120491;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fWpFWDJT2+LpVO7mSwGG21NXDpOKixMY4mi0VY93uuY=;
        b=k9Rwzo9CD6GiyeVBda2jttOBvX2ZMZEDilRr+oaiCyX8Y/21fvc+UBjA6tipFFyMbK
         wfahNLWih16X5Ap2vqsDNdySUgXuq559D7U9T/oM7vB2LhxLCoK7UYXsERAZ5P9CvNfN
         RnyA0fTNyb0tgoeUGCltPQTnJnW7eoKu0BNV55EteaBNqcjV/x2Je7f5aavnVWOLGKnW
         DJAgT6dn/9LOnB0DxHg4eK9qx6jyyrTQ/hcarwnI0pFd2i8tjB4mqqhUgiLeEYfbx3Zd
         nwlVNPh3KWg7GrkL1LK8nVaU/WkyXDu9AOHlaRVL3yQjOzlrX8dumjZW5QnVZZnhvsf8
         Ahkg==
X-Gm-Message-State: AOJu0YxcE3oGdHcaY1vHKwtK4kQ63ah8PHu85bva8FGSxnjH45/SZCuh
        qRPAaCCMxdSxut7wR+pWx2t0Rg==
X-Google-Smtp-Source: AGHT+IE92lVSPrZRJsC/qf3bc6ySeB3GZv8J+2fi3SJsb+iAb142MsWoI+pUmo3RNvzCzhqeIEwB7Q==
X-Received: by 2002:a17:903:245:b0:1bf:3c10:1d70 with SMTP id j5-20020a170903024500b001bf3c101d70mr859998plh.6.1693515691049;
        Thu, 31 Aug 2023 14:01:31 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id ja20-20020a170902efd400b001bdc6ca748esm1640343plb.185.2023.08.31.14.01.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Aug 2023 14:01:30 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Eric Biggers <ebiggers@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Tony Luck <tony.luck@intel.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH v2] pstore: Base compression input buffer size on estimated compressed size
Date:   Thu, 31 Aug 2023 14:01:29 -0700
Message-Id: <20230831210125.gonna.173-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7087; i=keescook@chromium.org;
 h=from:subject:message-id; bh=08rQ65NmN7AKINJfj5K5sjGCEO2d6SyOG1A8TI9/ha0=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBk8P+oQ68Qv77Ri7W+Nyf+HhjSOMI67h/f/sqjY
 8GyNij9EPOJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZPD/qAAKCRCJcvTf3G3A
 JrKeEACh3QAAJIydjiaTvOUH/qrJeiwjUP5PjBWRv12TDEOk6Y/HTrWChB3HFp7t9l/34fEuj8r
 20U2TU1IFGrl0ioSUj/zf8i0BEfSa0utOfLnG3QEU14qHXYaY3ZeBx5lWei7FL6qCG1Oy1T7zfF
 uaIGgMxdgN7r21S/rI0Nf5aXiDvBshLVuBISBbwsV1xL2CiK62gg6zy+Pv0UgqCoWJ60cidZO++
 3p5LNZSIpnj99zOUJU+stK31hmNiCTjx8EjA2gc+Yapg5XCsyThBsxN+g6e5E4QjSQKo2K4Jmt1
 LF24an4utCkwJeFGO4/1gmR2peoOI0c7LAGeKFrr6Y6eHEmyx6Fju3L/nKicI4/kgHfF6570ene
 l1KuITxfkdcrs00qaeLpWPc/jo+neN3dLRi64a1YvbL0bwib2qhFjqr89fSEtHFqwuBuZvqrzjo
 Bv/I6b79d0kyOl1dyvnGZZl8YrqwwYdd0m/ThIKLH6l+iMr3+N2GKhQCHCDi/q85jDs4qVsBnes
 kuO9MzNFP+E/nE7bWtI+zp7Y0eI9UZ18rdmXtp35HyKz34biskfLYEBKHaG/OAMRifqKHESkAU+
 VaIVQWcZLejzWH1vK3YiTR7eif6wfKuiILqbh/p4Rx6sLQCnQUIOMKRGxXnYJjlWLtm3VPBMRk/
 5E+1H2T tRmLBsPQ==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ard Biesheuvel <ardb@kernel.org>

Commit 1756ddea6916 ("pstore: Remove worst-case compression size logic")
removed some clunky per-algorithm worst case size estimation routines on
the basis that we can always store pstore records uncompressed, and
these worst case estimations are about how much the size might
inadvertently *increase* due to encapsulation overhead when the input
cannot be compressed at all. So if compression results in a size
increase, we just store the original data instead.

However, it seems that the original code was misinterpreting these
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
used the computation given below for zlib:

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

We will use the previous worst-case of 60% for compression. For
decompression go extra large (3x) so we make sure there's enough space
for anything.

While at it, rate limit the error message so we don't flood the log
unnecessarily on systems that have accumulated a lot of pstore history.

Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Eric Biggers <ebiggers@kernel.org>
Cc: Kees Cook <keescook@chromium.org>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Link: https://lore.kernel.org/r/20230830212238.135900-1-ardb@kernel.org
Co-developed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
v2:
 - reduce compression buffer size to 1.67x from 2x
 - raise decompression buffer size to 3x
v1: https://lore.kernel.org/all/20230830212238.135900-1-ardb@kernel.org
---
 fs/pstore/platform.c | 34 +++++++++++++++++++++++++++-------
 1 file changed, 27 insertions(+), 7 deletions(-)

diff --git a/fs/pstore/platform.c b/fs/pstore/platform.c
index 62356d542ef6..e5bca9a004cc 100644
--- a/fs/pstore/platform.c
+++ b/fs/pstore/platform.c
@@ -98,7 +98,14 @@ MODULE_PARM_DESC(kmsg_bytes, "amount of kernel log to snapshot (in bytes)");
 
 static void *compress_workspace;
 
+/*
+ * Compression is only used for dmesg output, which consists of low-entropy
+ * ASCII text, and so we can assume worst-case 60%.
+ */
+#define DMESG_COMP_PERCENT	60
+
 static char *big_oops_buf;
+static size_t max_compressed_size;
 
 void pstore_set_kmsg_bytes(int bytes)
 {
@@ -196,6 +203,7 @@ static int pstore_compress(const void *in, void *out,
 
 static void allocate_buf_for_compression(void)
 {
+	size_t compressed_size;
 	char *buf;
 
 	/* Skip if not built-in or compression disabled. */
@@ -216,7 +224,8 @@ static void allocate_buf_for_compression(void)
 	 * uncompressed record size, since any record that would be expanded by
 	 * compression is just stored uncompressed.
 	 */
-	buf = kvzalloc(psinfo->bufsize, GFP_KERNEL);
+	compressed_size = (psinfo->bufsize * 100) / DMESG_COMP_PERCENT;
+	buf = kvzalloc(compressed_size, GFP_KERNEL);
 	if (!buf) {
 		pr_err("Failed %zu byte compression buffer allocation for: %s\n",
 		       psinfo->bufsize, compress);
@@ -233,6 +242,7 @@ static void allocate_buf_for_compression(void)
 
 	/* A non-NULL big_oops_buf indicates compression is available. */
 	big_oops_buf = buf;
+	max_compressed_size = compressed_size;
 
 	pr_info("Using crash dump compression: %s\n", compress);
 }
@@ -246,6 +256,7 @@ static void free_buf_for_compression(void)
 
 	kvfree(big_oops_buf);
 	big_oops_buf = NULL;
+	max_compressed_size = 0;
 }
 
 void pstore_record_init(struct pstore_record *record,
@@ -305,7 +316,7 @@ static void pstore_dump(struct kmsg_dumper *dumper,
 		record.buf = psinfo->buf;
 
 		dst = big_oops_buf ?: psinfo->buf;
-		dst_size = psinfo->bufsize;
+		dst_size = max_compressed_size ?: psinfo->bufsize;
 
 		/* Write dump header. */
 		header_size = snprintf(dst, dst_size, "%s#%d Part%u\n", why,
@@ -326,8 +337,15 @@ static void pstore_dump(struct kmsg_dumper *dumper,
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
@@ -560,6 +578,7 @@ static void decompress_record(struct pstore_record *record,
 	int ret;
 	int unzipped_len;
 	char *unzipped, *workspace;
+	size_t max_uncompressed_size;
 
 	if (!IS_ENABLED(CONFIG_PSTORE_COMPRESS) || !record->compressed)
 		return;
@@ -583,7 +602,8 @@ static void decompress_record(struct pstore_record *record,
 	}
 
 	/* Allocate enough space to hold max decompression and ECC. */
-	workspace = kvzalloc(psinfo->bufsize + record->ecc_notice_size,
+	max_uncompressed_size = 3 * psinfo->bufsize;
+	workspace = kvzalloc(max_uncompressed_size + record->ecc_notice_size,
 			     GFP_KERNEL);
 	if (!workspace)
 		return;
@@ -591,11 +611,11 @@ static void decompress_record(struct pstore_record *record,
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
2.34.1


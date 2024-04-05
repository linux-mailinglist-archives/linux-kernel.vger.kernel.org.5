Return-Path: <linux-kernel+bounces-132443-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F08908994FB
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 08:10:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 56D9AB22ED0
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 06:10:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6A5D36103;
	Fri,  5 Apr 2024 06:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xkf2IljW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99AFB33996;
	Fri,  5 Apr 2024 06:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712297332; cv=none; b=jpARkMFhgp9BE352Uk8GmjNQ/jN68VjGkisIJBvZdJ1Id/zc+b6Kp4/N4LN0+wz7x0hMqQ/m537YxmcgDd3mVbMuttWZW/Sg4er/CtWQDeqDa/q8SdtLwqfh5GHYEICeB6vScGfv1mZso4Pg6IUF9IQUGU/44BvpZtLzp2r18Ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712297332; c=relaxed/simple;
	bh=81kSItd/o4NqMgG84+lHlFfM/mnipKp82YxNEsxBMec=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gzhf/fl2DLaUZSLlwHpxKVOPmyYCQluZvgatbmwsAVtHDVkXcK3jr1XrkW70s8lR9gjnnvjPJa8yR28RjheOYNzXGkGB6SUEP/GhYGPqTDvWWXr5/IPk2guVlEVFZHAYvxbG75OgI0nelfqi75Ji3nIz6M3SYDU5JhKL9qSg0Io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xkf2IljW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C80DAC433B2;
	Fri,  5 Apr 2024 06:08:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712297332;
	bh=81kSItd/o4NqMgG84+lHlFfM/mnipKp82YxNEsxBMec=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Xkf2IljWP58KF2uJNYswpaqzh26UbLRctFXr9K98QsLg2oSBwCXgBuOjpvTV3XCEr
	 IbLmPpJV2SFpvf2AiXWYK/x1Vl7N6V5TOXKLMPrN5lukMWismYH05pL6QdalDLhVO6
	 fq057CLXPZzxxdTrqWybUh7VhWKwsUthveGSxHbGkHPQNMyzcosWt3KrMnlDYTWtKJ
	 TZToJYZ+AXp1GKlGBOubV7VhvDVhsAwFuiZIAJ8bkz8OgYZgw5QXGfZ1xW47281oN4
	 eTb4sfaYLZi33HxDhm82YOJZQ2awBQnEcH+XxiQ4R+XpFZTyYLX9vlwHq0XAlMkub2
	 i8ZorJKDyVXLg==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Stefani Seibold <stefani@seibold.net>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 07/15] kfifo: add kfifo_dma_out_prepare_mapped()
Date: Fri,  5 Apr 2024 08:08:18 +0200
Message-ID: <20240405060826.2521-8-jirislaby@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240405060826.2521-1-jirislaby@kernel.org>
References: <20240405060826.2521-1-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the kfifo buffer is already dma-mapped, one cannot use the kfifo
API to fill in an SG list.

Add kfifo_dma_in_prepare_mapped() which allows exactly this. A mapped
dma_addr_t is passed and it is filled into provided sgl too. Including
the dma_len.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Cc: Stefani Seibold <stefani@seibold.net>
Cc: Andrew Morton <akpm@linux-foundation.org>
---
 include/linux/kfifo.h | 37 +++++++++++++++++++++++++------------
 lib/kfifo.c           | 34 ++++++++++++++++++++++------------
 2 files changed, 47 insertions(+), 24 deletions(-)

diff --git a/include/linux/kfifo.h b/include/linux/kfifo.h
index 3def70e1a3e3..c7cc25b2808b 100644
--- a/include/linux/kfifo.h
+++ b/include/linux/kfifo.h
@@ -36,6 +36,7 @@
  * to lock the reader.
  */
 
+#include <linux/dma-mapping.h>
 #include <linux/kernel.h>
 #include <linux/spinlock.h>
 #include <linux/stddef.h>
@@ -709,11 +710,12 @@ __kfifo_int_must_check_helper( \
 )
 
 /**
- * kfifo_dma_in_prepare - setup a scatterlist for DMA input
+ * kfifo_dma_in_prepare_mapped - setup a scatterlist for DMA input
  * @fifo: address of the fifo to be used
  * @sgl: pointer to the scatterlist array
  * @nents: number of entries in the scatterlist array
  * @len: number of elements to transfer
+ * @dma: mapped dma address to fill into @sgl
  *
  * This macro fills a scatterlist for DMA input.
  * It returns the number entries in the scatterlist array.
@@ -721,7 +723,7 @@ __kfifo_int_must_check_helper( \
  * Note that with only one concurrent reader and one concurrent
  * writer, you don't need extra locking to use these macros.
  */
-#define	kfifo_dma_in_prepare(fifo, sgl, nents, len) \
+#define	kfifo_dma_in_prepare_mapped(fifo, sgl, nents, len, dma) \
 ({ \
 	typeof((fifo) + 1) __tmp = (fifo); \
 	struct scatterlist *__sgl = (sgl); \
@@ -730,10 +732,14 @@ __kfifo_int_must_check_helper( \
 	const size_t __recsize = sizeof(*__tmp->rectype); \
 	struct __kfifo *__kfifo = &__tmp->kfifo; \
 	(__recsize) ? \
-	__kfifo_dma_in_prepare_r(__kfifo, __sgl, __nents, __len, __recsize) : \
-	__kfifo_dma_in_prepare(__kfifo, __sgl, __nents, __len); \
+	__kfifo_dma_in_prepare_r(__kfifo, __sgl, __nents, __len, __recsize, \
+				 dma) : \
+	__kfifo_dma_in_prepare(__kfifo, __sgl, __nents, __len, dma); \
 })
 
+#define kfifo_dma_in_prepare(fifo, sgl, nents, len) \
+	kfifo_dma_in_prepare_mapped(fifo, sgl, nents, len, DMA_MAPPING_ERROR)
+
 /**
  * kfifo_dma_in_finish - finish a DMA IN operation
  * @fifo: address of the fifo to be used
@@ -758,11 +764,12 @@ __kfifo_int_must_check_helper( \
 })
 
 /**
- * kfifo_dma_out_prepare - setup a scatterlist for DMA output
+ * kfifo_dma_out_prepare_mapped - setup a scatterlist for DMA output
  * @fifo: address of the fifo to be used
  * @sgl: pointer to the scatterlist array
  * @nents: number of entries in the scatterlist array
  * @len: number of elements to transfer
+ * @dma: mapped dma address to fill into @sgl
  *
  * This macro fills a scatterlist for DMA output which at most @len bytes
  * to transfer.
@@ -772,7 +779,7 @@ __kfifo_int_must_check_helper( \
  * Note that with only one concurrent reader and one concurrent
  * writer, you don't need extra locking to use these macros.
  */
-#define	kfifo_dma_out_prepare(fifo, sgl, nents, len) \
+#define	kfifo_dma_out_prepare_mapped(fifo, sgl, nents, len, dma) \
 ({ \
 	typeof((fifo) + 1) __tmp = (fifo);  \
 	struct scatterlist *__sgl = (sgl); \
@@ -781,10 +788,14 @@ __kfifo_int_must_check_helper( \
 	const size_t __recsize = sizeof(*__tmp->rectype); \
 	struct __kfifo *__kfifo = &__tmp->kfifo; \
 	(__recsize) ? \
-	__kfifo_dma_out_prepare_r(__kfifo, __sgl, __nents, __len, __recsize) : \
-	__kfifo_dma_out_prepare(__kfifo, __sgl, __nents, __len); \
+	__kfifo_dma_out_prepare_r(__kfifo, __sgl, __nents, __len, __recsize, \
+				  dma) : \
+	__kfifo_dma_out_prepare(__kfifo, __sgl, __nents, __len, dma); \
 })
 
+#define	kfifo_dma_out_prepare(fifo, sgl, nents, len) \
+	kfifo_dma_out_prepare_mapped(fifo, sgl, nents, len, DMA_MAPPING_ERROR)
+
 /**
  * kfifo_dma_out_finish - finish a DMA OUT operation
  * @fifo: address of the fifo to be used
@@ -905,10 +916,10 @@ extern int __kfifo_to_user(struct __kfifo *fifo,
 	void __user *to, unsigned long len, unsigned int *copied);
 
 extern unsigned int __kfifo_dma_in_prepare(struct __kfifo *fifo,
-	struct scatterlist *sgl, int nents, unsigned int len);
+	struct scatterlist *sgl, int nents, unsigned int len, dma_addr_t dma);
 
 extern unsigned int __kfifo_dma_out_prepare(struct __kfifo *fifo,
-	struct scatterlist *sgl, int nents, unsigned int len);
+	struct scatterlist *sgl, int nents, unsigned int len, dma_addr_t dma);
 
 extern unsigned int __kfifo_out_peek(struct __kfifo *fifo,
 	void *buf, unsigned int len);
@@ -930,13 +941,15 @@ extern int __kfifo_to_user_r(struct __kfifo *fifo, void __user *to,
 	unsigned long len, unsigned int *copied, size_t recsize);
 
 extern unsigned int __kfifo_dma_in_prepare_r(struct __kfifo *fifo,
-	struct scatterlist *sgl, int nents, unsigned int len, size_t recsize);
+	struct scatterlist *sgl, int nents, unsigned int len, size_t recsize,
+	dma_addr_t dma);
 
 extern void __kfifo_dma_in_finish_r(struct __kfifo *fifo,
 	unsigned int len, size_t recsize);
 
 extern unsigned int __kfifo_dma_out_prepare_r(struct __kfifo *fifo,
-	struct scatterlist *sgl, int nents, unsigned int len, size_t recsize);
+	struct scatterlist *sgl, int nents, unsigned int len, size_t recsize,
+	dma_addr_t dma);
 
 extern unsigned int __kfifo_len_r(struct __kfifo *fifo, size_t recsize);
 
diff --git a/lib/kfifo.c b/lib/kfifo.c
index 3a249ce4f281..75ce9225548a 100644
--- a/lib/kfifo.c
+++ b/lib/kfifo.c
@@ -6,6 +6,7 @@
  */
 
 #include <linux/kernel.h>
+#include <linux/dma-mapping.h>
 #include <linux/export.h>
 #include <linux/slab.h>
 #include <linux/err.h>
@@ -307,7 +308,7 @@ EXPORT_SYMBOL(__kfifo_to_user);
 
 static unsigned int setup_sgl_buf(struct __kfifo *fifo, struct scatterlist *sgl,
 				  unsigned int data_offset, int nents,
-				  unsigned int len)
+				  unsigned int len, dma_addr_t dma)
 {
 	const void *buf = fifo->data + data_offset;
 
@@ -316,11 +317,16 @@ static unsigned int setup_sgl_buf(struct __kfifo *fifo, struct scatterlist *sgl,
 
 	sg_set_buf(sgl, buf, len);
 
+	if (dma != DMA_MAPPING_ERROR) {
+		sg_dma_address(sgl) = dma + data_offset;
+		sg_dma_len(sgl) = len;
+	}
+
 	return 1;
 }
 
 static unsigned int setup_sgl(struct __kfifo *fifo, struct scatterlist *sgl,
-		int nents, unsigned int len, unsigned int off)
+		int nents, unsigned int len, unsigned int off, dma_addr_t dma)
 {
 	unsigned int size = fifo->mask + 1;
 	unsigned int esize = fifo->esize;
@@ -335,14 +341,15 @@ static unsigned int setup_sgl(struct __kfifo *fifo, struct scatterlist *sgl,
 	}
 	len_to_end = min(len, size - off);
 
-	n = setup_sgl_buf(fifo, sgl, off, nents, len_to_end);
-	n += setup_sgl_buf(fifo, sgl + n, 0, nents - n, len - len_to_end);
+	n = setup_sgl_buf(fifo, sgl, off, nents, len_to_end, dma);
+	n += setup_sgl_buf(fifo, sgl + n, 0, nents - n, len - len_to_end, dma);
 
 	return n;
 }
 
 unsigned int __kfifo_dma_in_prepare(struct __kfifo *fifo,
-		struct scatterlist *sgl, int nents, unsigned int len)
+		struct scatterlist *sgl, int nents, unsigned int len,
+		dma_addr_t dma)
 {
 	unsigned int l;
 
@@ -350,12 +357,13 @@ unsigned int __kfifo_dma_in_prepare(struct __kfifo *fifo,
 	if (len > l)
 		len = l;
 
-	return setup_sgl(fifo, sgl, nents, len, fifo->in);
+	return setup_sgl(fifo, sgl, nents, len, fifo->in, dma);
 }
 EXPORT_SYMBOL(__kfifo_dma_in_prepare);
 
 unsigned int __kfifo_dma_out_prepare(struct __kfifo *fifo,
-		struct scatterlist *sgl, int nents, unsigned int len)
+		struct scatterlist *sgl, int nents, unsigned int len,
+		dma_addr_t dma)
 {
 	unsigned int l;
 
@@ -363,7 +371,7 @@ unsigned int __kfifo_dma_out_prepare(struct __kfifo *fifo,
 	if (len > l)
 		len = l;
 
-	return setup_sgl(fifo, sgl, nents, len, fifo->out);
+	return setup_sgl(fifo, sgl, nents, len, fifo->out, dma);
 }
 EXPORT_SYMBOL(__kfifo_dma_out_prepare);
 
@@ -547,7 +555,8 @@ int __kfifo_to_user_r(struct __kfifo *fifo, void __user *to,
 EXPORT_SYMBOL(__kfifo_to_user_r);
 
 unsigned int __kfifo_dma_in_prepare_r(struct __kfifo *fifo,
-	struct scatterlist *sgl, int nents, unsigned int len, size_t recsize)
+	struct scatterlist *sgl, int nents, unsigned int len, size_t recsize,
+	dma_addr_t dma)
 {
 	BUG_ON(!nents);
 
@@ -556,7 +565,7 @@ unsigned int __kfifo_dma_in_prepare_r(struct __kfifo *fifo,
 	if (len + recsize > kfifo_unused(fifo))
 		return 0;
 
-	return setup_sgl(fifo, sgl, nents, len, fifo->in + recsize);
+	return setup_sgl(fifo, sgl, nents, len, fifo->in + recsize, dma);
 }
 EXPORT_SYMBOL(__kfifo_dma_in_prepare_r);
 
@@ -570,7 +579,8 @@ void __kfifo_dma_in_finish_r(struct __kfifo *fifo,
 EXPORT_SYMBOL(__kfifo_dma_in_finish_r);
 
 unsigned int __kfifo_dma_out_prepare_r(struct __kfifo *fifo,
-	struct scatterlist *sgl, int nents, unsigned int len, size_t recsize)
+	struct scatterlist *sgl, int nents, unsigned int len, size_t recsize,
+	dma_addr_t dma)
 {
 	BUG_ON(!nents);
 
@@ -579,7 +589,7 @@ unsigned int __kfifo_dma_out_prepare_r(struct __kfifo *fifo,
 	if (len + recsize > fifo->in - fifo->out)
 		return 0;
 
-	return setup_sgl(fifo, sgl, nents, len, fifo->out + recsize);
+	return setup_sgl(fifo, sgl, nents, len, fifo->out + recsize, dma);
 }
 EXPORT_SYMBOL(__kfifo_dma_out_prepare_r);
 
-- 
2.44.0



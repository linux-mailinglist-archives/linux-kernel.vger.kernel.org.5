Return-Path: <linux-kernel+bounces-78255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C1A28610D1
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 12:52:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C74641F25936
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 11:52:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FBC67CF27;
	Fri, 23 Feb 2024 11:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sLd5+eve"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 852AF7C6D4
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 11:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708689123; cv=none; b=gitFHneDKf1+QgzLZVyHVEWz2G/Qq20ITataIJXr/4Af+0LdfMtL4QqutAiWPue7COOGvPzQONJzah7RMysiAIFOnIpzQcfoGfY60UPtzOv47zJftPR60v8NrW7PwBqpQ/RpJHh/8jPncLsIs4ToeWmicVnUNfv1w+UVrnLRAHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708689123; c=relaxed/simple;
	bh=deFyJ8OYCh9my5qGUB1HBB8ENRS08AcwthOwt9dAcZE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FzmTdi77LsUY8EXKCBQ83x0BXRjjylwf6k47Ab7AJ72+QfG7JIS4UUoXKROHyqqIHGbgXnVoVX9duUVhBHyQwFp2P6D2fz8wHsIG0cfI3GGhc3itGAkK8KW41D7YODcFd5mdTqLBT6vpM6A+X1jknBzCEDBTLUn6S9GcnN2spuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sLd5+eve; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1121EC433A6;
	Fri, 23 Feb 2024 11:52:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708689123;
	bh=deFyJ8OYCh9my5qGUB1HBB8ENRS08AcwthOwt9dAcZE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sLd5+eve5ubmzq9nTyF7ESHZMUlcMXxv05amHg2Rgc92mjiTnyQPPKHm7rPcYdj5e
	 87uRTDAp3Ts8f+3vRroeBLRPc7dfESbMBKq7T07EwVazD0zr3ulios1+BO9/7bJ+Xp
	 tyhJZ9QZ8tuul99NMOLafsw0nURZ38ZqF6Kxzz7nHUyLqNFPkhw9eryeJwkrCAYXjX
	 JvLqIYFaJTo41cZb5nr/ep6eENsSFNRFCB9eTZMwGS4bD07UlHMfTRKCJkyf+OjC5P
	 OTCeDvJuWJw5gcBvX3EyNZfGGx9n8g7z3lEhEfRDVK5U+50AtGkE9Jf83s0wV8DUNS
	 CcFuuJv3T0aYg==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: stefani@seibold.net
Cc: linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 3/4] kfifo: add kfifo_out_linear{,_ptr}()
Date: Fri, 23 Feb 2024 12:51:54 +0100
Message-ID: <20240223115155.8806-4-jirislaby@kernel.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240223115155.8806-1-jirislaby@kernel.org>
References: <20240223115155.8806-1-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These are helpers which are going to be used in the serial layer. We
need a wrapper around kfifo which provides us with a tail (sometimes
"tail" offset, sometimes a pointer) to the kfifo data. And which returns
count of available data -- but not larger than to the end of the buffer
(hence _linear in the names). I.e. something like CIRC_CNT_TO_END() in
the legacy circ_buf.

This patch adds such two helpers.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Cc: Stefani Seibold <stefani@seibold.net>
Cc: Andrew Morton <akpm@linux-foundation.org>
---
 include/linux/kfifo.h | 64 +++++++++++++++++++++++++++++++++++++++++++
 lib/kfifo.c           | 28 +++++++++++++++++++
 2 files changed, 92 insertions(+)

diff --git a/include/linux/kfifo.h b/include/linux/kfifo.h
index 9e64eb03c535..0491bc526240 100644
--- a/include/linux/kfifo.h
+++ b/include/linux/kfifo.h
@@ -827,6 +827,64 @@ __kfifo_uint_must_check_helper( \
 }) \
 )
 
+/**
+ * kfifo_out_linear - gets a tail of/offset to available data
+ * @fifo: address of the fifo to be used
+ * @tail: pointer to an unsigned int to store the value of tail
+ * @n: max. number of elements to point at
+ *
+ * This macro obtains the offset (tail) to the available data in the fifo
+ * buffer and returns the
+ * numbers of elements available. It returns the available count till the end
+ * of data or till the end of the buffer. So that it can be used for linear
+ * data processing (like memcpy() of (@fifo->data + @tail) with count
+ * returned).
+ *
+ * Note that with only one concurrent reader and one concurrent
+ * writer, you don't need extra locking to use these macro.
+ */
+#define kfifo_out_linear(fifo, tail, n) \
+__kfifo_uint_must_check_helper( \
+({ \
+	typeof((fifo) + 1) __tmp = (fifo); \
+	unsigned int *__tail = (tail); \
+	unsigned long __n = (n); \
+	const size_t __recsize = sizeof(*__tmp->rectype); \
+	struct __kfifo *__kfifo = &__tmp->kfifo; \
+	(__recsize) ? \
+	__kfifo_out_linear_r(__kfifo, __tail, __n, __recsize) : \
+	__kfifo_out_linear(__kfifo, __tail, __n); \
+}) \
+)
+
+/**
+ * kfifo_out_linear_ptr - gets a pointer to the available data
+ * @fifo: address of the fifo to be used
+ * @ptr: pointer to data to store the pointer to tail
+ * @n: max. number of elements to point at
+ *
+ * Similarly to kfifo_out_linear(), this macro obtains the pointer to the
+ * available data in the fifo buffer and returns the numbers of elements
+ * available. It returns the available count till the end of available data or
+ * till the end of the buffer. So that it can be used for linear data
+ * processing (like memcpy() of @ptr with count returned).
+ *
+ * Note that with only one concurrent reader and one concurrent
+ * writer, you don't need extra locking to use these macro.
+ */
+#define kfifo_out_linear_ptr(fifo, ptr, n) \
+__kfifo_uint_must_check_helper( \
+({ \
+	typeof((fifo) + 1) ___tmp = (fifo); \
+	unsigned int ___tail; \
+	unsigned int ___n = kfifo_out_linear(___tmp, &___tail, (n)); \
+	struct __kfifo *___kfifo = &___tmp->kfifo; \
+	*(ptr) = ___kfifo->data + ___tail * kfifo_esize(___tmp); \
+	___n; \
+}) \
+)
+
+
 extern int __kfifo_alloc(struct __kfifo *fifo, unsigned int size,
 	size_t esize, gfp_t gfp_mask);
 
@@ -856,6 +914,9 @@ extern unsigned int __kfifo_dma_out_prepare(struct __kfifo *fifo,
 extern unsigned int __kfifo_out_peek(struct __kfifo *fifo,
 	void *buf, unsigned int len);
 
+extern unsigned int __kfifo_out_linear(struct __kfifo *fifo,
+	unsigned int *tail, unsigned int n);
+
 extern unsigned int __kfifo_in_r(struct __kfifo *fifo,
 	const void *buf, unsigned int len, size_t recsize);
 
@@ -885,6 +946,9 @@ extern void __kfifo_skip_r(struct __kfifo *fifo, size_t recsize);
 extern unsigned int __kfifo_out_peek_r(struct __kfifo *fifo,
 	void *buf, unsigned int len, size_t recsize);
 
+extern unsigned int __kfifo_out_linear_r(struct __kfifo *fifo,
+	unsigned int *tail, unsigned int n, size_t recsize);
+
 extern unsigned int __kfifo_max_r(unsigned int len, size_t recsize);
 
 #endif
diff --git a/lib/kfifo.c b/lib/kfifo.c
index 958099cc4914..9f1d8f68deb8 100644
--- a/lib/kfifo.c
+++ b/lib/kfifo.c
@@ -163,6 +163,21 @@ unsigned int __kfifo_out_peek(struct __kfifo *fifo,
 }
 EXPORT_SYMBOL(__kfifo_out_peek);
 
+unsigned int __kfifo_out_linear(struct __kfifo *fifo,
+		unsigned int *tail, unsigned int n)
+{
+	unsigned int size = fifo->mask + 1;
+	unsigned int off = fifo->out & fifo->mask;
+
+	n = min3(n, fifo->in - fifo->out, size - off);
+
+	if (tail)
+		*tail = off;
+
+	return n;
+}
+EXPORT_SYMBOL(__kfifo_out_linear);
+
 unsigned int __kfifo_out(struct __kfifo *fifo,
 		void *buf, unsigned int len)
 {
@@ -473,6 +488,19 @@ unsigned int __kfifo_out_peek_r(struct __kfifo *fifo, void *buf,
 }
 EXPORT_SYMBOL(__kfifo_out_peek_r);
 
+unsigned int __kfifo_out_linear_r(struct __kfifo *fifo,
+		unsigned int *tail, unsigned int n, size_t recsize)
+{
+	if (fifo->in == fifo->out)
+		return 0;
+
+	if (tail)
+		*tail = fifo->out + recsize;
+
+	return min(n, __kfifo_peek_n(fifo, recsize);
+}
+EXPORT_SYMBOL(__kfifo_out_linear_r);
+
 unsigned int __kfifo_out_r(struct __kfifo *fifo, void *buf,
 		unsigned int len, size_t recsize)
 {
-- 
2.43.2



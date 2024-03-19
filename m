Return-Path: <linux-kernel+bounces-107335-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D470C87FB2F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 10:54:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03C401C21C52
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 09:54:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F35FD7E78A;
	Tue, 19 Mar 2024 09:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gXQj2wKW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F1ED7D419;
	Tue, 19 Mar 2024 09:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710842014; cv=none; b=o8sXyplJmzMO5CsyOPXW9MAJFsf0teRDScooH3tLxX4TdJ8ufYX0StrUCCgoChCWILSuxqCQ4aUlZzbCZRvQI49IE8CJpCVJgsj+xy5D1rKcuN8rim0kIBkxQNO8XC46f6pMlPkScpZWuDLYUN4gO6fH0J+OWxKM8Y5iKFPIDVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710842014; c=relaxed/simple;
	bh=Y5yr2WoT18t+omb36hLfYnGJAHFNVuXaCL5M5ighc1g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hok/YEoghrZqv95yvn/mHO35OkR61qLvFXXedQ3rpGIL1RIorzrj3cINtnvBh5I6AWVnRK8HMgoJfY1GYgQ6kdm8Z0lYK0pNR4YvgtjRzg14ANqqkTvFJxrBv2xbv02ftLP3pISGWp+d6X+c6rv6oGdq5j0+gV0tHhfMQZ819IE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gXQj2wKW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 564B7C43394;
	Tue, 19 Mar 2024 09:53:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710842013;
	bh=Y5yr2WoT18t+omb36hLfYnGJAHFNVuXaCL5M5ighc1g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gXQj2wKW28B+ES+inRotEsdEFbGSdL+TtwMPNHPH6P37Qj9yVLvSLgfPuiLJ9vRAZ
	 fhGXhUEwijAH1ZEp4Y5bfYj0k52fY/+bPDylqz9fKCfkaIUYfPaa1xq0dANadd5KOV
	 C1ucYpD2NOSbxJWleQZVc98ilDNNxooGDToxANEwYSmNSdlKLFx0s+UTZI3yLKTKym
	 /lHHfULsBEIwOouEmykKcuq3hCO9BFX58OuayuhawUjndhEXOB4ljCFMwx2/ikYTbW
	 Fx1hHIALjjhbEmc69+y3vT+vI5J6wt/nVgsT+fYqu0w9o9fq/g+9xgJPJhKzccMX/O
	 eN94KwvJXcIDQ==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: linux-serial@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Stefani Seibold <stefani@seibold.net>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [RFT 03/15] kfifo: add kfifo_out_linear{,_ptr}()
Date: Tue, 19 Mar 2024 10:53:02 +0100
Message-ID: <20240319095315.27624-4-jirislaby@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240319095315.27624-1-jirislaby@kernel.org>
References: <20240319095315.27624-1-jirislaby@kernel.org>
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

Notes:
    [v2]
      * added Andrew's fix -- missing right parenthesis
      * simplify __kfifo_out_linear() -- min3() results can be returned
        directly.

 include/linux/kfifo.h | 63 +++++++++++++++++++++++++++++++++++++++++++
 lib/kfifo.c           | 26 ++++++++++++++++++
 2 files changed, 89 insertions(+)

diff --git a/include/linux/kfifo.h b/include/linux/kfifo.h
index 8f3369ec528b..3def70e1a3e3 100644
--- a/include/linux/kfifo.h
+++ b/include/linux/kfifo.h
@@ -827,6 +827,63 @@ __kfifo_uint_must_check_helper( \
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
+	*(ptr) = ___tmp->kfifo.data + ___tail * kfifo_esize(___tmp); \
+	___n; \
+}) \
+)
+
+
 extern int __kfifo_alloc(struct __kfifo *fifo, unsigned int size,
 	size_t esize, gfp_t gfp_mask);
 
@@ -856,6 +913,9 @@ extern unsigned int __kfifo_dma_out_prepare(struct __kfifo *fifo,
 extern unsigned int __kfifo_out_peek(struct __kfifo *fifo,
 	void *buf, unsigned int len);
 
+extern unsigned int __kfifo_out_linear(struct __kfifo *fifo,
+	unsigned int *tail, unsigned int n);
+
 extern unsigned int __kfifo_in_r(struct __kfifo *fifo,
 	const void *buf, unsigned int len, size_t recsize);
 
@@ -885,6 +945,9 @@ extern void __kfifo_skip_r(struct __kfifo *fifo, size_t recsize);
 extern unsigned int __kfifo_out_peek_r(struct __kfifo *fifo,
 	void *buf, unsigned int len, size_t recsize);
 
+extern unsigned int __kfifo_out_linear_r(struct __kfifo *fifo,
+	unsigned int *tail, unsigned int n, size_t recsize);
+
 extern unsigned int __kfifo_max_r(unsigned int len, size_t recsize);
 
 #endif
diff --git a/lib/kfifo.c b/lib/kfifo.c
index 958099cc4914..a36bfdbdb17d 100644
--- a/lib/kfifo.c
+++ b/lib/kfifo.c
@@ -163,6 +163,19 @@ unsigned int __kfifo_out_peek(struct __kfifo *fifo,
 }
 EXPORT_SYMBOL(__kfifo_out_peek);
 
+unsigned int __kfifo_out_linear(struct __kfifo *fifo,
+		unsigned int *tail, unsigned int n)
+{
+	unsigned int size = fifo->mask + 1;
+	unsigned int off = fifo->out & fifo->mask;
+
+	if (tail)
+		*tail = off;
+
+	return min3(n, fifo->in - fifo->out, size - off);
+}
+EXPORT_SYMBOL(__kfifo_out_linear);
+
 unsigned int __kfifo_out(struct __kfifo *fifo,
 		void *buf, unsigned int len)
 {
@@ -473,6 +486,19 @@ unsigned int __kfifo_out_peek_r(struct __kfifo *fifo, void *buf,
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
+	return min(n, __kfifo_peek_n(fifo, recsize));
+}
+EXPORT_SYMBOL(__kfifo_out_linear_r);
+
 unsigned int __kfifo_out_r(struct __kfifo *fifo, void *buf,
 		unsigned int len, size_t recsize)
 {
-- 
2.44.0



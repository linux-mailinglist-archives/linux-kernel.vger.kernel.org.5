Return-Path: <linux-kernel+bounces-132438-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF2BC8994F1
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 08:09:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 141EA285D61
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 06:09:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20F9D2869B;
	Fri,  5 Apr 2024 06:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JMmOe0cX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C0AE24B29;
	Fri,  5 Apr 2024 06:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712297323; cv=none; b=igB6R2lV2yU326ECygAs9jAfsHEkUzOx7ZELODXnJ8Mvs5zu/6134e2MHAOWh/irpYIJg1td4/xie9qIKAae1xQ77O+Zx0fKwpxrKJLEdkINQ6y7v5LtVEwgnwuXgDR/wWIqX2o90xAvddOLKdXH92kImUnLPGGoMvYUP3zsxDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712297323; c=relaxed/simple;
	bh=KpvXM0m/85JJFUZQJjj5/8MSyKNFhxWQze2FnjfAWBU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bg+1ZcKtZGB2UvA4T2y/GdMniJf6NHDOpKtNxFj3GSalBn4ITu+lvlup1BuqhaxSe9NmhvOilM1bDfH5Lm+/VkbR8BlDP5BvZZY9x+xwnVsTAVPoy8QDPz1aQfyq6/pWntld6ncehBnP8PI/k826F8Z7t7DwVCtsUBmwrDLvrBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JMmOe0cX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C283C43390;
	Fri,  5 Apr 2024 06:08:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712297322;
	bh=KpvXM0m/85JJFUZQJjj5/8MSyKNFhxWQze2FnjfAWBU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JMmOe0cXQktXL2SSUQMXdDothE13nceL5nN6ltxMWpxoL54V+KsiT5r2MIC8x64xW
	 Y+UyYOR1uvdJZORCr1uOtI+PTI6LQ5691256kn6hpXL58qIYgmLRbU9itoQ94mGLGf
	 EG87S57fgzYHRp/HHuitiRL/cLRaspd79NZPADCsVDps39utulAMCpoGVNR/7a71yU
	 0TYZVKqWjI60ALAxuZEjCyTYCwmkKVIqcK0yKYCYuMIvZ/4w37ygIaLf9Mazusv6YK
	 6Rmn246q4YIPMXUk5RxdXhQJJa4Xufwh9XhUnOsxZJCLNCPR5QQho2Kv4uhpFS2bBs
	 ZYqtOkwXNNYeQ==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Stefani Seibold <stefani@seibold.net>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 02/15] kfifo: introduce and use kfifo_skip_count()
Date: Fri,  5 Apr 2024 08:08:13 +0200
Message-ID: <20240405060826.2521-3-jirislaby@kernel.org>
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

kfifo_skip_count() is an extended version of kfifo_skip(), accepting
also count. This will be useful in the serial code later.

Now, it can be used to implement both kfifo_skip() and
kfifo_dma_out_finish(). In the latter, 'len' only needs to be divided by
'type' size (as it was until now).

And stop using statement expressions when the return value is cast to
'void'. Use classic 'do {} while (0)' instead.

Note: perhaps we should skip 'count' records for the 'recsize' case, but
the original (kfifo_dma_out_finish()) used to skip only one record. So
this is kept unchanged and 'count' is still ignored in the recsize case.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Cc: Stefani Seibold <stefani@seibold.net>
Cc: Andrew Morton <akpm@linux-foundation.org>
---

Notes:
    [v2] rename __tmp to ___tmp to fix initialization in the nested macro

 include/linux/kfifo.h | 31 +++++++++++++++----------------
 1 file changed, 15 insertions(+), 16 deletions(-)

diff --git a/include/linux/kfifo.h b/include/linux/kfifo.h
index bc7a1f5bb0ce..8f3369ec528b 100644
--- a/include/linux/kfifo.h
+++ b/include/linux/kfifo.h
@@ -304,19 +304,25 @@ __kfifo_uint_must_check_helper( \
 )
 
 /**
- * kfifo_skip - skip output data
+ * kfifo_skip_count - skip output data
  * @fifo: address of the fifo to be used
+ * @count: count of data to skip
  */
-#define	kfifo_skip(fifo) \
-(void)({ \
+#define	kfifo_skip_count(fifo, count) do { \
 	typeof((fifo) + 1) __tmp = (fifo); \
 	const size_t __recsize = sizeof(*__tmp->rectype); \
 	struct __kfifo *__kfifo = &__tmp->kfifo; \
 	if (__recsize) \
 		__kfifo_skip_r(__kfifo, __recsize); \
 	else \
-		__kfifo->out++; \
-})
+		__kfifo->out += (count); \
+} while(0)
+
+/**
+ * kfifo_skip - skip output data
+ * @fifo: address of the fifo to be used
+ */
+#define	kfifo_skip(fifo)	kfifo_skip_count(fifo, 1)
 
 /**
  * kfifo_peek_len - gets the size of the next fifo record
@@ -790,17 +796,10 @@ __kfifo_int_must_check_helper( \
  * Note that with only one concurrent reader and one concurrent
  * writer, you don't need extra locking to use these macros.
  */
-#define kfifo_dma_out_finish(fifo, len) \
-(void)({ \
-	typeof((fifo) + 1) __tmp = (fifo); \
-	unsigned int __len = (len); \
-	const size_t __recsize = sizeof(*__tmp->rectype); \
-	struct __kfifo *__kfifo = &__tmp->kfifo; \
-	if (__recsize) \
-		__kfifo_skip_r(__kfifo, __recsize); \
-	else \
-		__kfifo->out += __len / sizeof(*__tmp->type); \
-})
+#define kfifo_dma_out_finish(fifo, len) do { \
+	typeof((fifo) + 1) ___tmp = (fifo); \
+	kfifo_skip_count(___tmp, (len) / sizeof(*___tmp->type)); \
+} while (0)
 
 /**
  * kfifo_out_peek - gets some data from the fifo
-- 
2.44.0



Return-Path: <linux-kernel+bounces-107334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E6AD87FB2D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 10:54:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60E561C21B14
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 09:54:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7064E7E599;
	Tue, 19 Mar 2024 09:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dun0jY2z"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96AB57E579;
	Tue, 19 Mar 2024 09:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710842012; cv=none; b=RyWeGWW98HIJgNxNVoYKSdc5SdB1bRa2fg9JpJxw0qXXz+6+zh/EOg3TZ6w4Lwcq7XW7N7LBfp2IEwYXTrN+QLbfMzgE11dOVk9ak34nImIqHf8Q+NkN45cbn6eJFKSsacju1IuPWROiekdYgAdfytW756bJtQNqoWOhUkAFaZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710842012; c=relaxed/simple;
	bh=KpvXM0m/85JJFUZQJjj5/8MSyKNFhxWQze2FnjfAWBU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kjvv5CsTdwAQXW846G9YaNJMPaqAgOu5ro648Jf4Ezsq0S3J7TFfnJzSxdNEMeX/2a82bajXAPb69KAEhydxkZF85iQn8oa/gnMVdXJnIEAWTl7eqpPJK0t8elg34TSDF6ulzUxTHUXwnSdHFuH5rRTAzLqdRrrYgDdpWPSFhVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dun0jY2z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 911A8C433F1;
	Tue, 19 Mar 2024 09:53:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710842011;
	bh=KpvXM0m/85JJFUZQJjj5/8MSyKNFhxWQze2FnjfAWBU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dun0jY2z+KiNTGEtlwx4nzC+Pm/y177xISr4T8axvByUeIY7IpWu52bF2mCRNH0xL
	 XHfzPS3rhnty+nvhB/LYCGDOTOnb2yVfGI9bwUmP72KzGZPUQTCCeTZ8M9Okzi4LyW
	 yLBXCZ3Kt3v1loMz6ycMcVXVRA1c8JUI+zqXY0rsK1Fuj4pOLQahzVAQQ9M6xkkhbz
	 KX+ibVG/V9NTdzdnVufA6W2p7EilA7a+SVBmdWvQEKZhLmwwmhUZU6CvZI8Q0Dqj6K
	 OHMxlz910RUan2Z+4qJIqS8/0IBAVvRuxuKxGvEVdIyeCnKpLjh1Mk7U6hEt1/X8Fd
	 tNe7QuHsHlO3Q==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: linux-serial@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Stefani Seibold <stefani@seibold.net>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [RFT 02/15] kfifo: introduce and use kfifo_skip_count()
Date: Tue, 19 Mar 2024 10:53:01 +0100
Message-ID: <20240319095315.27624-3-jirislaby@kernel.org>
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



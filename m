Return-Path: <linux-kernel+bounces-132437-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D51308994EF
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 08:08:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 59F62B228F3
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 06:08:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D45823746;
	Fri,  5 Apr 2024 06:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lUYrmVhY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FBE222EF2;
	Fri,  5 Apr 2024 06:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712297321; cv=none; b=QBorl35GrqS9cdQGVvGHGHAOg+eh0zZwf9yZRGPbXPUlsl7h8lSeukZhA0zmLAGrAk3SY6awf28kHSGcb65982N7TpDgh80g/4qgBr2W/m/MAbLNzzvLK6zW0oUASq5EklJupUI5vW0tLP8jWSxYkwEaHBd4uFvYwM8hPF4krDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712297321; c=relaxed/simple;
	bh=Ucf0yaa98ebsbPc/z4MUwkKuOaXzJW6HowXlsm7quf0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lPbn/OATX93WX8h3iltgQ+s1xcqlZgUhErOHLTomDKxyvMeRoHNAwjKwHMkR2GQZVm20scZJ/bJBbaprxlY6C9QbaMg+SG30D1uBluXHc8rq5fV957JN0ddEKzGu+7q446sjkIXJEF3STS2KfUcpThBnZFdgya9KfcY5xAwhIAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lUYrmVhY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A712C433B2;
	Fri,  5 Apr 2024 06:08:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712297321;
	bh=Ucf0yaa98ebsbPc/z4MUwkKuOaXzJW6HowXlsm7quf0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lUYrmVhYsEzqYf9uFTSGvcQWYGCNXA+66IP/YMVvqloh7/tg9OOV6otqBPxSTfLs5
	 0oxVkc3BxRBJ4YeofTTPwAsMcpJmLqJcbzD2ntydTfDql7SA2YUDOXn+TlX/W+M7H1
	 L51qLIWyzhJbiEp77X2Kqg4o1q9mHsEkfZM+KHpwGQWBQ1tqRlNaxYU1ZfiGyAZ8ef
	 Xz//8y9R8bIRtxmSmv8W21mCtFgOxVvnwlBwrLSTqsHScrbslHdzcUjkSFAHPI3k60
	 t7awOkjG9TcCL3HneNHIbLOoq/ZyYKTdmm+KPZuIegsDSq3uZ3Yn5v22Cl3bbhpHIV
	 uOw+WRI56gqcQ==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Stefani Seibold <stefani@seibold.net>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 01/15] kfifo: drop __kfifo_dma_out_finish_r()
Date: Fri,  5 Apr 2024 08:08:12 +0200
Message-ID: <20240405060826.2521-2-jirislaby@kernel.org>
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

It is the same as __kfifo_skip_r(), so:
* drop __kfifo_dma_out_finish_r() completely, and
* replace its (only) use by __kfifo_skip_r().

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Cc: Stefani Seibold <stefani@seibold.net>
Cc: Andrew Morton <akpm@linux-foundation.org>
---
 include/linux/kfifo.h | 4 +---
 lib/kfifo.c           | 8 --------
 2 files changed, 1 insertion(+), 11 deletions(-)

diff --git a/include/linux/kfifo.h b/include/linux/kfifo.h
index 0b35a41440ff..bc7a1f5bb0ce 100644
--- a/include/linux/kfifo.h
+++ b/include/linux/kfifo.h
@@ -797,7 +797,7 @@ __kfifo_int_must_check_helper( \
 	const size_t __recsize = sizeof(*__tmp->rectype); \
 	struct __kfifo *__kfifo = &__tmp->kfifo; \
 	if (__recsize) \
-		__kfifo_dma_out_finish_r(__kfifo, __recsize); \
+		__kfifo_skip_r(__kfifo, __recsize); \
 	else \
 		__kfifo->out += __len / sizeof(*__tmp->type); \
 })
@@ -879,8 +879,6 @@ extern void __kfifo_dma_in_finish_r(struct __kfifo *fifo,
 extern unsigned int __kfifo_dma_out_prepare_r(struct __kfifo *fifo,
 	struct scatterlist *sgl, int nents, unsigned int len, size_t recsize);
 
-extern void __kfifo_dma_out_finish_r(struct __kfifo *fifo, size_t recsize);
-
 extern unsigned int __kfifo_len_r(struct __kfifo *fifo, size_t recsize);
 
 extern void __kfifo_skip_r(struct __kfifo *fifo, size_t recsize);
diff --git a/lib/kfifo.c b/lib/kfifo.c
index 12f5a347aa13..958099cc4914 100644
--- a/lib/kfifo.c
+++ b/lib/kfifo.c
@@ -582,11 +582,3 @@ unsigned int __kfifo_dma_out_prepare_r(struct __kfifo *fifo,
 }
 EXPORT_SYMBOL(__kfifo_dma_out_prepare_r);
 
-void __kfifo_dma_out_finish_r(struct __kfifo *fifo, size_t recsize)
-{
-	unsigned int len;
-
-	len = __kfifo_peek_n(fifo, recsize);
-	fifo->out += len + recsize;
-}
-EXPORT_SYMBOL(__kfifo_dma_out_finish_r);
-- 
2.44.0



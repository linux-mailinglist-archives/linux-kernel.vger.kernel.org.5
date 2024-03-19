Return-Path: <linux-kernel+bounces-107333-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E340087FB2A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 10:53:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83C701F225D8
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 09:53:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 164DD7D41D;
	Tue, 19 Mar 2024 09:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q2RkDZP3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A06F7E112;
	Tue, 19 Mar 2024 09:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710842011; cv=none; b=uF6SaeV13+CSyNWfEi3GU136UYNcWvGfCKOdF48TMo8tSXFdbq/TaGmjw3r3tO0gV7+mJDP4Xw5SnIIt+LmrZ8Bv2NsLmopGS5z7BkYNeExzzx6Srx/kCqXqCb7Y0Ekob8MtWQPfBr344ZhiRmWirBeKW1m+HmVPUYp1FvrIJBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710842011; c=relaxed/simple;
	bh=Ucf0yaa98ebsbPc/z4MUwkKuOaXzJW6HowXlsm7quf0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M2+yXPNEg+DJPqomgS5PDiZS/0TIDa8mlu1ZP33M5yf2+cdvwkEHTXbfl5WIWWFxFo6/VuBsyoZoKlyiBF051Kgk0Yvphkgvnog4VuT1pJ/UPNfk3K11x7FKYg5a0t9+wL5yxQqkcXgrJ6APhEEcyHFo4S41XrGXofSO2cWVsrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q2RkDZP3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDB8AC433A6;
	Tue, 19 Mar 2024 09:53:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710842010;
	bh=Ucf0yaa98ebsbPc/z4MUwkKuOaXzJW6HowXlsm7quf0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=q2RkDZP34dEzUgsJBm5XFPmFhXHfsfKiF4IChT+sJxkyV3tkP7mmb7OUhvMzbohXd
	 MNC4+urQrsCqrvpjw9lTMfNgWE+K31PCr0JL2dUbmU8wvYXqOWf3yTZDFW9F3K+FvI
	 v6D6kFP9dS07igtcY14R2bnT6Kk35nbfCzVI+Y/BBXGsxuEzsa17wEWsXURLtAvIxR
	 fIfk+084h7a+8gGsDVwj2JbjyeC0hCv3vxizIDE0d/nMk5RpSpIoOZoZuZgcd669si
	 j44lCQzkQYIa4LrDvAW/X9WET2khvEDRKuO/tuVkJ9orVGpyf/e5lVTpXZwMtmbaLN
	 tEkLzp27Lc67Q==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: linux-serial@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Stefani Seibold <stefani@seibold.net>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [RFT 01/15] kfifo: drop __kfifo_dma_out_finish_r()
Date: Tue, 19 Mar 2024 10:53:00 +0100
Message-ID: <20240319095315.27624-2-jirislaby@kernel.org>
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



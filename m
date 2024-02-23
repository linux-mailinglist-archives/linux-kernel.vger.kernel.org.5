Return-Path: <linux-kernel+bounces-78253-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C6FDF8610CE
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 12:52:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 811C728657A
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 11:52:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 420D07B3E3;
	Fri, 23 Feb 2024 11:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mCGeHbF9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 882CA7AE72
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 11:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708689120; cv=none; b=tWn96exIYox3qyUpKwxWoBXw1cHczMGTiVivmICUPTwJILrqxvJp5GHtKPwHA1tqfWTsepaxrQjEWc79gZh5ksKbe9WC8vMQaY058Ypyd+huGO4/hO0bJ9O/2DLDwoqqwUs31+XYaw5gYmRodAU8M+OabnRC1KnMaDIdSCwJ4BQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708689120; c=relaxed/simple;
	bh=VsACx/BCa3XtWDoMNVc71XrU2WWQ9BG6/Ja5X5GaJvs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OBa3MYzyCV7de1RWG+VSQbxm8/UZY7GJZTULqr5vZgJKyvCeEggGPj3e5t1VqzqxVAfcqEsNF5/nWNRIbMP+H2VhPW3TJBhsWfOC2t+ZqXde14KZ5mrpGT7oiIUb8Ge7YtdZkUpJgOlos3UUKw5ZGjYSRVC+L3g2bnaPs82VJmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mCGeHbF9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 082E3C433C7;
	Fri, 23 Feb 2024 11:51:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708689120;
	bh=VsACx/BCa3XtWDoMNVc71XrU2WWQ9BG6/Ja5X5GaJvs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mCGeHbF9fdejLLUoPOAvN3DkRK9WSq7b5ef7IjBHRCw/RVcFnkwSiPTO9OFdLvVKi
	 y0r8sFvi5sKdLh292HbOFTl83c8gstQuBLhppb3rwIRoo/JqiL0E6z/ySnug0isgOM
	 br/tLbAyxv8Aap/nrfYmemA1dICRHNQflaIKPYlVzc93/fbJLfLrv94DpCPY5x6N72
	 ln1feHpBE571k28UkXqTb9zQ24K1AQTCOiFQhF5s1VIX7Eyx29gDXFUXmEBU5wK67t
	 FsPdd5VH/HUKPbsRBlAY0+WXDxUysjbkrb29f0z1soffdXUD6s8Ta9Y5IzZr3y9A/9
	 blNjrJ4Hnwm6A==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: stefani@seibold.net
Cc: linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 1/4] kfifo: drop __kfifo_dma_out_finish_r()
Date: Fri, 23 Feb 2024 12:51:52 +0100
Message-ID: <20240223115155.8806-2-jirislaby@kernel.org>
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
2.43.2



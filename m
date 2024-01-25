Return-Path: <linux-kernel+bounces-38803-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 45A2B83C62F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 16:12:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0FDC1F21C0C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 15:12:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD4FC745C1;
	Thu, 25 Jan 2024 15:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nSXdWtBR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FC4C73175
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 15:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706195519; cv=none; b=aJg/fH88/Cz3hmnRqk7ygPLaFfX78XyMcOld6VrGJKqF8Xu0qE/aUqiVpr1FX1YelGk8Az5XOMcYqIMSwUzDSLzteHwM0p24IKxp5iYqyt9ex/LDD1rsGBQZziNHuBvQyTq+FrVLK728M5rC57zdiK1PefCUfpyG/cQSqOhF5UE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706195519; c=relaxed/simple;
	bh=qaC0W89Ij+l6ejUX971u7DsedKgRmIMuV9AHu7Mxo8U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u6DukLqw02jP4JWaT2gkFSmqArklwz5O8v/Z4woQJWBZRiDsou/+POqZdf/0B4HzOnHr9MdjcyC2fyRGFbbTOH8PHRQJF71GGess7r1bLR4227Ph6o0cgdSHm7gwmq6lyOJcAZsi5Xzr/ENVcfzoo7NQ8THyQ8iXmAh1O6YuCOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nSXdWtBR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FBD0C43390;
	Thu, 25 Jan 2024 15:11:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706195518;
	bh=qaC0W89Ij+l6ejUX971u7DsedKgRmIMuV9AHu7Mxo8U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nSXdWtBRn7k/oWkIm7gkawOUKqSN1OL4w9QeB24Fl8ZRHsLgAjoCIHhFWXd79Mp/k
	 3Ywru/xCQb2wY60k7l+yyuii5qOHoNUPxJY9OA4fDUB9tsBI4CKKLva81H4c5Npxko
	 soBi2N+5Uw7UwkYTWpLpjdPKPQ0wBM3LM74JmxAgiScgs4je9bRGpVKtSOL7XfqcrF
	 qK+tHIU3yLfbf+4jshsQqPu95ovDWv9J+0QvFX4IW5ZFrIZ/pWLLCKym8nubIjGZDb
	 ItQ+fc24J9ME0sCIyGDYtuTdbnutgAEV9mcG2Qrx1ywShbrYa9g7szY7BW8Otb0SZs
	 axAz+H2EwRvfA==
From: Jisheng Zhang <jszhang@kernel.org>
To: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>
Cc: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Andrea Parri <parri.andrea@gmail.com>
Subject: [PATCH v3 1/2] riscv: select ARCH_USE_CMPXCHG_LOCKREF
Date: Thu, 25 Jan 2024 22:59:06 +0800
Message-ID: <20240125145908.968-2-jszhang@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240125145908.968-1-jszhang@kernel.org>
References: <20240125145908.968-1-jszhang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Select ARCH_USE_CMPXCHG_LOCKREF to enable the cmpxchg-based lockless
lockref implementation for riscv.

Using Linus' test case[1] on TH1520 platform, I see a 11.2% improvement.
On JH7110 platform, I see 12.0% improvement.

Link: http://marc.info/?l=linux-fsdevel&m=137782380714721&w=4 [1]
Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
Reviewed-by: Andrea Parri <parri.andrea@gmail.com>
---
 arch/riscv/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index fdd1a595ebd8..248cea3e2749 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -51,6 +51,7 @@ config RISCV
 	select ARCH_SUPPORTS_PAGE_TABLE_CHECK if MMU
 	select ARCH_SUPPORTS_PER_VMA_LOCK if MMU
 	select ARCH_SUPPORTS_SHADOW_CALL_STACK if HAVE_SHADOW_CALL_STACK
+	select ARCH_USE_CMPXCHG_LOCKREF if 64BIT
 	select ARCH_USE_MEMTEST
 	select ARCH_USE_QUEUED_RWLOCKS
 	select ARCH_USES_CFI_TRAPS if CFI_CLANG
-- 
2.43.0



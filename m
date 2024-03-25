Return-Path: <linux-kernel+bounces-116931-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EA4488A546
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 15:52:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8D1528FCFA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 14:52:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7761B1BCFCA;
	Mon, 25 Mar 2024 11:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WDstMSAU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9914515ADB0
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 11:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711365836; cv=none; b=kvJw9+/ohXgJCS7BLkEv7SvTO41VIMFe3wbrI426yw3BTmMVMGIw9wqhvng9ahrIqj3ov/XQT6qGdei3eJMOAUtt1bDicVmIsjAov3216JLHr7YQm/kF19+G65k2bXrJWF7PfMNyTsErXYua3rQ4GiwUBw42WxjZRfndswTYAS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711365836; c=relaxed/simple;
	bh=TkQFAl0y/SHZ/rPLxSlv1JjtbvVld+zmq7CDJ3afisw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O/fS0858dJqqdJ2ThJ4Qeldx6joFou/ydtpwz+nXmgzpvreHSO+QBsd745kUkyh1QHeirss7qyZU96Lx05bkXTqRw39QKpk7sSDkcNzePt2fhN3bxSOPhnyLjYT8oWzoO7cNE3+5rO9Q0VhoaCgnSy/kguMkI4SVy8SJJUX71Os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WDstMSAU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D14AC433F1;
	Mon, 25 Mar 2024 11:23:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711365836;
	bh=TkQFAl0y/SHZ/rPLxSlv1JjtbvVld+zmq7CDJ3afisw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WDstMSAUtMz3dbEcVm+KLj1GR9k7r52hnpVzlF2STimuRRvPFMDaOrFV7Ov/86urM
	 zkXfEq9MVCWVOD9OWWqn7Drl8ilkELX/EqjZG6TzDk7LfjGKaAs+wfBGaUDX3u2v5i
	 KeSkxzv2cEv+9KJbpqxro/uYf9da5AiVxCu71SIB86Fx2MsLQI3kZDailyNKwl1VIl
	 BT++7eVE+OcTA6uRxlJuy3a5oLyc8cTSBl6kJ0AEkSYOp4+4pkwrdvzfJgv9eGXoQ3
	 1HCQ4zA7BRYic/5jofv/E1MRs15h7yHC0sJZZdCB1JdpRT4JkkZZJ2FWTZzQRLlsES
	 41Wunpx0FrcUg==
From: Jisheng Zhang <jszhang@kernel.org>
To: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>
Cc: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Andrea Parri <parri.andrea@gmail.com>
Subject: [PATCH v3 RESEND 1/2] riscv: select ARCH_USE_CMPXCHG_LOCKREF
Date: Mon, 25 Mar 2024 19:10:37 +0800
Message-ID: <20240325111038.1700-2-jszhang@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240325111038.1700-1-jszhang@kernel.org>
References: <20240325111038.1700-1-jszhang@kernel.org>
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
index aba42b2bf660..7895c77545f1 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -58,6 +58,7 @@ config RISCV
 	select ARCH_SUPPORTS_PAGE_TABLE_CHECK if MMU
 	select ARCH_SUPPORTS_PER_VMA_LOCK if MMU
 	select ARCH_SUPPORTS_SHADOW_CALL_STACK if HAVE_SHADOW_CALL_STACK
+	select ARCH_USE_CMPXCHG_LOCKREF if 64BIT
 	select ARCH_USE_MEMTEST
 	select ARCH_USE_QUEUED_RWLOCKS
 	select ARCH_USES_CFI_TRAPS if CFI_CLANG
-- 
2.43.0



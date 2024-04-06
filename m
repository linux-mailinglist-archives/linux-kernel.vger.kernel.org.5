Return-Path: <linux-kernel+bounces-133912-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E4CE89AA9D
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 13:35:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1C931F21B9F
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 11:35:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2A312DF92;
	Sat,  6 Apr 2024 11:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O4CTEJzK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB65D2CCA0
	for <linux-kernel@vger.kernel.org>; Sat,  6 Apr 2024 11:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712403323; cv=none; b=o7b/I3YMWgHhhEf5I5YqpGfYj8ndkKfGTwF3tlO3LJNaV6hagPRiGb2e8VZ6x7dEBYpvFrCIkjmLvh1demuouBY7Py015TYGY1qOUKLF+JInYwY4ISxhQa8oWi4jM2yzXDyE/dpWf2CL4pF3ileUjqf5LwKY4yiiEbZCRcaVXd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712403323; c=relaxed/simple;
	bh=pFynrsYJOJ+5eJpGClthQv/4eVfcqNbrm44H7lrcyi4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U90cNSHPniHs5NeU70BkC3SsjbWNyEEkch/TOrwhtujiLtR1iAMh10S9dI9JoMCcgSviJB92EX34/XmT1OysOVFe4GeBc12z8D8yHGSlnzOGXtjdozmY2JxoOA6ZjtIPgPCB7JTQ+qXfsdLmQMQwqQFdn5cA/awjOz0XZHn2siY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O4CTEJzK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC128C433F1;
	Sat,  6 Apr 2024 11:35:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712403322;
	bh=pFynrsYJOJ+5eJpGClthQv/4eVfcqNbrm44H7lrcyi4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=O4CTEJzKCq0QwjZWEpBOFtuASv2SkLVYz3MRBuGvJ/ReH8U04k7rSV78aUSwyEF2T
	 EUk5pA29fS13562QJZU0NtHAGQ32uu7l+DdUSlHiC1D+AV2dDvxTqf/7g1KaIykefB
	 65cui7Iijh+o2G8aJgRr9JLhvMFEmpDebc5+nGBwGM5ERDP9THwjgohpHVKObDK1hM
	 SLtq9iGP9iLvceLdcxMPnFgQxvbpaLgTy6D1BadHVFetf+Fr8y178JZ0n1gvso++l5
	 RsW7Aiz79I7Bt0nyO44hKEruFP401sfXpPxcA7tzx0JVRznNJb1XiceDWr/DA/luOQ
	 nT1hhTtWK7M1Q==
From: Jisheng Zhang <jszhang@kernel.org>
To: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Samuel Holland <samuel.holland@sifive.com>
Cc: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] riscv: nommu: remove PAGE_OFFSET hardcoding
Date: Sat,  6 Apr 2024 19:21:57 +0800
Message-ID: <20240406112159.1634-2-jszhang@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240406112159.1634-1-jszhang@kernel.org>
References: <20240406112159.1634-1-jszhang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, PAGE_OFFSET is hardcoded as 0x8000_0000, it works fine since
there's only one nommu platform in the mainline. However, there are
many cases where the (S)DRAM base address isn't 0x8000_0000, so remove
the hardcoding value, and introduce DRAM_BASE which will be set by
users during configuring. DRAM_BASE is 0x8000_0000 by default.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 arch/riscv/Kconfig | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 7895c77545f1..b4af1df86352 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -247,10 +247,16 @@ config MMU
 	  Select if you want MMU-based virtualised addressing space
 	  support by paged memory management. If unsure, say 'Y'.
 
+if !MMU
+config DRAM_BASE
+	hex '(S)DRAM Base Address'
+	default 0x80000000
+endif
+
 config PAGE_OFFSET
 	hex
 	default 0xC0000000 if 32BIT && MMU
-	default 0x80000000 if !MMU
+	default DRAM_BASE if !MMU
 	default 0xff60000000000000 if 64BIT
 
 config KASAN_SHADOW_OFFSET
-- 
2.43.0



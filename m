Return-Path: <linux-kernel+bounces-79767-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9504186266E
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 18:42:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4EF01C20F85
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 17:42:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AA374C615;
	Sat, 24 Feb 2024 17:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TRg3FNRX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F2BA481C6;
	Sat, 24 Feb 2024 17:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708796547; cv=none; b=h7bo6VneFcAoDDLKYQ0rFRvxfovH0yXvJGGweqpO2IaFLMD5ZCrXcluWDtAGR17MGxPS2k5nVvOhKkvOp/SuferOuB8FTvOvyxylrkfUlAbskhVCFSRTLiNVF3VvQfVLJribdrE2IAaRgpZNW8b/CssMi/Cr6FAp3xwPdrhK780=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708796547; c=relaxed/simple;
	bh=mvWrNAqQfzrlCBLUO5SP77modfdYW8iRs5f0ks8WiYM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CZw6Ee7ZESsD9vvZwuZf3687TcrFcZVMtRkVshlD1Jp7E9aAJ7SHJ1Z2znnCtn5JY1oKHlHzJAdkU3jobJhXRzOi9tMyOvIONG4LRStWJ+XgbcxVME8j82DTAr7pR2hhf4QJjTwhO7kUPrwyG0yZULPWaY7mgI2hDCfsrlgx7s8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TRg3FNRX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 194CBC43399;
	Sat, 24 Feb 2024 17:42:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708796547;
	bh=mvWrNAqQfzrlCBLUO5SP77modfdYW8iRs5f0ks8WiYM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=TRg3FNRXQk/dYRUqBb81VFFqX2O9FBHEUOTkyFKhmU5G0Qy8NkLxBTtg1HpDxI1YE
	 U/DJDyeN4SC0RthrLs9UjcYGbn0CvHwgXwMeAaIhESq5x5Cn05EIDFApr7JO8XNjop
	 SfIO5pD7e8qmk9adENcW/Z1QBJTTujB+rhOn/Xy3OtI1O4M8PMDD5hFMp+s9MIvvlv
	 Bpq3TPtab7eZcxRUPYk6hmXZJXbwC7FspvQKZSFu1dlXRYH/nqgsluRVx24BvoMp58
	 PjdUFXSJ9PsuTyo5B11UUoPItrFzFMb5Dn18Eez2tbFLx4nxuvcD6mOM1m5StVP4oE
	 YTIyXVUwBPYFw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08FA0C5478C;
	Sat, 24 Feb 2024 17:42:27 +0000 (UTC)
From: Sam Ravnborg via B4 Relay <devnull+sam.ravnborg.org@kernel.org>
Date: Sat, 24 Feb 2024 18:42:25 +0100
Subject: [PATCH v2 4/7] sparc32: Do not select ZONE_DMA
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id:
 <20240224-sam-fix-sparc32-all-builds-v2-4-1f186603c5c4@ravnborg.org>
References:
 <20240224-sam-fix-sparc32-all-builds-v2-0-1f186603c5c4@ravnborg.org>
In-Reply-To:
 <20240224-sam-fix-sparc32-all-builds-v2-0-1f186603c5c4@ravnborg.org>
To: "Maciej W. Rozycki" <macro@orcam.me.uk>, sparclinux@vger.kernel.org, 
 Andreas Larsson <andreas@gaisler.com>, Randy Dunlap <rdunlap@infradead.org>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>, 
 linux-parport@lists.infradead.org, "David S. Miller" <davem@davemloft.net>, 
 Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, 
 Sam Ravnborg <sam@ravnborg.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708796545; l=1855;
 i=sam@ravnborg.org; s=20230107; h=from:subject:message-id;
 bh=e4J0zd9pY2ujVasdD/OCfxLoCPAiNjhFop1a9KlpN8Y=; =?utf-8?q?b=3DMVGnDmkOPaAA?=
 =?utf-8?q?7gRzYjqyp6PXBzdF71VyxCP8e0uInzrhjO9FFoFgAN2oOm0ccll9Qw/OROQJGh0b?=
 tBxygqh1CQrVXFSrK/1kydoqp55XdUlRYUubtHR+KhsaSKdOG8NN
X-Developer-Key: i=sam@ravnborg.org; a=ed25519;
 pk=R0+pqV7BRYOAeOIGkyOrSNke7arx5y3LkEuNi37YEyU=
X-Endpoint-Received: by B4 Relay for sam@ravnborg.org/20230107 with auth_id=22
X-Original-From: Sam Ravnborg <sam@ravnborg.org>
Reply-To: <sam@ravnborg.org>

From: Sam Ravnborg <sam@ravnborg.org>

sparc32 has no limited DMA zone so there is no need to select ZONE_DMA.

Based on analysis from Marciej:
"
    Actually I think ZONE_DMA should go too (it's linked to GENERIC_ISA_DMA,
    isn't it? -- cf. commit 5ac6da669e24 ("[PATCH] Set CONFIG_ZONE_DMA for
    arches with GENERIC_ISA_DMA")), and the whole thing use:

    Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")

    The GENERIC_ISA_DMA option itself was added to arch/sparc/config.in with
    2.5.31 as:

        define_bool CONFIG_GENERIC_ISA_DMA y

    despite of:

        define_bool CONFIG_ISA n
"

The sparc32 code did not differ between ZONE_NORMAL and ZONE_DMA,
which confirms the above. This patch drop ZONE_DMA.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Reported-by: "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc: Andreas Larsson <andreas@gaisler.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Randy Dunlap <rdunlap@infradead.org>
Cc: Maciej W. Rozycki <macro@orcam.me.uk>
Cc: Arnd Bergmann <arnd@arndb.de>
---
 arch/sparc/Kconfig    | 1 -
 arch/sparc/mm/srmmu.c | 1 -
 2 files changed, 2 deletions(-)

diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index 734f23daecca..bdbde506c01e 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -62,7 +62,6 @@ config SPARC32
 	select HAVE_UID16
 	select LOCK_MM_AND_FIND_VMA
 	select OLD_SIGACTION
-	select ZONE_DMA
 
 config SPARC64
 	def_bool 64BIT
diff --git a/arch/sparc/mm/srmmu.c b/arch/sparc/mm/srmmu.c
index 852085ada368..7aae2f6f4973 100644
--- a/arch/sparc/mm/srmmu.c
+++ b/arch/sparc/mm/srmmu.c
@@ -975,7 +975,6 @@ void __init srmmu_paging_init(void)
 	{
 		unsigned long max_zone_pfn[MAX_NR_ZONES] = { 0 };
 
-		max_zone_pfn[ZONE_DMA] = max_low_pfn;
 		max_zone_pfn[ZONE_NORMAL] = max_low_pfn;
 		max_zone_pfn[ZONE_HIGHMEM] = highend_pfn;
 

-- 
2.34.1



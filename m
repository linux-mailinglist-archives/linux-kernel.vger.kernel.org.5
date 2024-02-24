Return-Path: <linux-kernel+bounces-79768-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0480A862672
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 18:43:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 365061C20D05
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 17:43:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C5AA4E1BC;
	Sat, 24 Feb 2024 17:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pCZSbrwk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 709B3481D0;
	Sat, 24 Feb 2024 17:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708796547; cv=none; b=jwM1l/7KJQVNopp3tQfekbjP1vb71dPHVEtc8V9qVeWldwYl/Hluy6A2NS6T+aCwg/UtZlcRqDIj7vKWQ/r1uV+x6N3pK1WBAKWN8EDzNT+d2nLr3Xx5JCRTYxebLPl2+TqVX9udyrwJE5ANhGVfKnYmew6K1HYTIaMKDiamvlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708796547; c=relaxed/simple;
	bh=u0AAmcTQTypGp4uSwwmS/uHNMvpmNjjwLex7HeF5FKw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OIcKlnm78ckSUNfnsmqToafOa7LA0KrTUpFhW5svbUE/JPH17pj9z59MMGH8Y69M27huBWAzB/3oXslrHaJy3fIAwEhQor8/hjShwe7N/qROR4XFsZ6ndGKrBi4xSefODq5kHNGYlBEp4MCyxwwqDbRDc3Zp6hykig720QFhsXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pCZSbrwk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 27307C433B1;
	Sat, 24 Feb 2024 17:42:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708796547;
	bh=u0AAmcTQTypGp4uSwwmS/uHNMvpmNjjwLex7HeF5FKw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=pCZSbrwkL9/e642Vk6RPAVvF4CN8L+fJ6tAFLW54+TMFala7V6bWP1I69Pu3mEmFF
	 JPoheV03sIOIngy8axzqi0bzjnF8iq6KtA3LQUXaK0SkUkYFDc9VVL9rjD/NFSd8Q2
	 V29KQSL+7vlctvLgtH3n3GkKhxgwBMFZbvWWxKBOaG+P1ZbfsiZWIOJKRk01/3CuF3
	 Z2O9Db3r2ANcm+FX7jTIQJnf/Ewv3gD91LEGZOPJqZQp3JewvfPtgacdKlyGYzzykb
	 HUYpFbB//sX7UKx+PaBGDgW97YvMo5nTLlH9V+NLx+d5bGA87hffoL6waZWpZtarTi
	 6AqtkiDnIPiMw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15956C48BF6;
	Sat, 24 Feb 2024 17:42:27 +0000 (UTC)
From: Sam Ravnborg via B4 Relay <devnull+sam.ravnborg.org@kernel.org>
Date: Sat, 24 Feb 2024 18:42:26 +0100
Subject: [PATCH v2 5/7] sparc32: Do not select GENERIC_ISA_DMA
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id:
 <20240224-sam-fix-sparc32-all-builds-v2-5-1f186603c5c4@ravnborg.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708796545; l=1135;
 i=sam@ravnborg.org; s=20230107; h=from:subject:message-id;
 bh=OWAinB5URH3jM/Z4sqc7e9m3++OQMwYINtdPlTPG+3w=; =?utf-8?q?b=3DIarfFy+3MHxh?=
 =?utf-8?q?NsZ6KvRnK2UXkA3EcCfDklgPPW35n08X0QuMF3S7OCNXV+xsMYB11dgu5G8uxlWu?=
 oHxA3Ud3BP7eCnoq1lfEMf3GTDc4b3d1ofPjxcyUBNxO04uvCIoj
X-Developer-Key: i=sam@ravnborg.org; a=ed25519;
 pk=R0+pqV7BRYOAeOIGkyOrSNke7arx5y3LkEuNi37YEyU=
X-Endpoint-Received: by B4 Relay for sam@ravnborg.org/20230107 with auth_id=22
X-Original-From: Sam Ravnborg <sam@ravnborg.org>
Reply-To: <sam@ravnborg.org>

From: Sam Ravnborg <sam@ravnborg.org>

sparc32 do not support generic isa dma, so do not select the symbol.

This fixes the following warnings:
dma.c:70:5: error: no previous prototype for 'request_dma' [-Werror=missing-prototypes]
dma.c:88:6: error: no previous prototype for 'free_dma' [-Werror=missing-prototypes]

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Fixes: 0fcb70851fbf ("Makefile.extrawarn: turn on missing-prototypes globally")
Acked-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org> # build-tested
Cc: Andreas Larsson <andreas@gaisler.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Randy Dunlap <rdunlap@infradead.org>
Cc: Maciej W. Rozycki <macro@orcam.me.uk>
---
 arch/sparc/Kconfig | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index bdbde506c01e..440e53d37d20 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -137,10 +137,6 @@ config HIGHMEM
 	default y if SPARC32
 	select KMAP_LOCAL
 
-config GENERIC_ISA_DMA
-	bool
-	default y if SPARC32
-
 config PGTABLE_LEVELS
 	default 4 if 64BIT
 	default 3

-- 
2.34.1



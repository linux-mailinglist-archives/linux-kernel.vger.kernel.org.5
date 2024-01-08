Return-Path: <linux-kernel+bounces-19365-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DDD4826BF8
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 12:01:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 093EDB20AB5
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 11:01:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4B2A14019;
	Mon,  8 Jan 2024 11:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pm4pDsfl"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2251A1400B
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 11:01:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38684C433C8;
	Mon,  8 Jan 2024 11:01:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704711662;
	bh=XdZBpta2RKAreU6xhq4nrkVq0nZqPyvWZ2OtajFyBkM=;
	h=From:List-Id:To:Cc:Subject:Date:From;
	b=Pm4pDsflDMA7uIvbHW9k8GGsnojRyox6hLOyU6w5ZkId/JY+nfNulQJ0A/RdwNnjw
	 6IzbJaAQcthO7vXCtfuw0cNDJepslwkdl98UAu0/GOsyeYtjqs/+fnRAwQ7R4XEGHx
	 9smYMmRnMRSBFiTAEcloXbmdPjy5yxD9xGissIGieOnnSANAbRu44XjG2HY54ScQdO
	 4Zfj+9NEiGH39+rtF8NMzhNYmc+rASxtiwe+IDw5HT87u9TEvX6slFLQQq0JUbAilM
	 HGxxq337RQRG+Ia10hLsor9cnq7JJsOK1mB01st9SL+8/PoAPbFC03Euc67htsF/yq
	 Mxaw4gjgmqEJQ==
From: Arnd Bergmann <arnd@kernel.org>
To: soc@kernel.org,
	Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Sekhar Nori <nsekhar@ti.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: davinci: always select CONFIG_CPU_ARM926T
Date: Mon,  8 Jan 2024 12:00:36 +0100
Message-Id: <20240108110055.1531153-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

The select was lost by accident during the multiplatform conversion.
Any davinci-only

arm-linux-gnueabi-ld: arch/arm/mach-davinci/sleep.o: in function `CACHE_FLUSH':
(.text+0x168): undefined reference to `arm926_flush_kern_cache_all'

Fixes: f962396ce292 ("ARM: davinci: support multiplatform build for ARM v5")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
I ran into this today for the first time after five years of randconfig testing
with the bug in place, so it is clearly very hard to hit.

It's an obvious fix, so I'm applying it to the soc/arm branch directly
for this week's pull requests.


 arch/arm/mach-davinci/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-davinci/Kconfig b/arch/arm/mach-davinci/Kconfig
index 1c8bf56982e5..2a8a9fe46586 100644
--- a/arch/arm/mach-davinci/Kconfig
+++ b/arch/arm/mach-davinci/Kconfig
@@ -4,6 +4,7 @@ menuconfig ARCH_DAVINCI
 	bool "TI DaVinci"
 	depends on ARCH_MULTI_V5
 	depends on CPU_LITTLE_ENDIAN
+	select CPU_ARM926T
 	select DAVINCI_TIMER
 	select ZONE_DMA
 	select PM_GENERIC_DOMAINS if PM
-- 
2.39.2



Return-Path: <linux-kernel+bounces-144182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B78DC8A42D1
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 16:09:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 40836B211C2
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 14:09:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FFD15D917;
	Sun, 14 Apr 2024 14:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NVzWBU4P"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2AFD5D752;
	Sun, 14 Apr 2024 14:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713103684; cv=none; b=UvoRksaaglOEk9Trgu3xJVI0ZHTgz0+59VM3Ai9DwopexPyxhxE99PBlz75yNt1tEv6U0W5DNA9sQLUsJitLRICEFgSu+lgrV3wWg12RiPM7BdZdFNEHpyX7lKxZliqdazpO1FA/x2+54gwHcg0mdUWViSFIEZsUW/CbUev0DrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713103684; c=relaxed/simple;
	bh=+gq8/HaBFcrh+lOjt/oiQ6thVO5EDI++3a+IpmyHbZs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aj31/YlgadofGs4MrS8W2C7esSaIx/U6G4UFONQ4cPIcka7P7R5qbAmVYapTGle/yL40vu90akGg8Qb3p6rQFVly4GRd1xXnRoJeOV/KyfbaJje5LdwfsNGr3oT3n5rG/oX5tFGVAE/hTEmsD4uCSXVbBeRhGfDZx5qUABBTC4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NVzWBU4P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE5E4C2BD11;
	Sun, 14 Apr 2024 14:07:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713103683;
	bh=+gq8/HaBFcrh+lOjt/oiQ6thVO5EDI++3a+IpmyHbZs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=NVzWBU4PN/xiazJK0sW/Bbtr17AGruIVuVKnYeLRP2DSDcaxGqCOTF2XufT6w3WgK
	 Em2a4m73XkZdJCzytrGeejY0f2cEdfAtyIq04ojGiwjpn72tEiJGTKh3ufe4f0tNE0
	 ah4kXsazgPP8N9uKm0qsWkAci8NjZuKCU55NmPtjqBWvR3HLKoMdgklrilj0Ld68nr
	 pUceJB0GPLlHJtxplHHveA2x9oFT64Q6sX6vrh3MTyOyyyylG+G6IzT/ug6/RJf27f
	 cozDRoMkFR6eYb/UP1GY7O+vUZh/C8TTI156WraOwQeo9LMLWbfcXAesFyzIEpvJdU
	 3eddmo2D6994g==
From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Sun, 14 Apr 2024 16:07:32 +0200
Subject: [PATCH v2 2/5] mmc: sdhci-omap: Constify struct sdhci_ops
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240414-mmc-const-sdhci-ops-v2-2-262f81faadac@kernel.org>
References: <20240414-mmc-const-sdhci-ops-v2-0-262f81faadac@kernel.org>
In-Reply-To: <20240414-mmc-const-sdhci-ops-v2-0-262f81faadac@kernel.org>
To: Adrian Hunter <adrian.hunter@intel.com>, 
 Angelo Dureghello <adureghello@baylibre.com>, 
 Ulf Hansson <ulf.hansson@linaro.org>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Orson Zhai <orsonzhai@gmail.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Chunyan Zhang <zhang.lyra@gmail.com>, Ben Dooks <ben-linux@fluff.org>, 
 Jaehoon Chung <jh80.chung@samsung.com>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzk@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=754; i=krzk@kernel.org;
 h=from:subject:message-id; bh=+gq8/HaBFcrh+lOjt/oiQ6thVO5EDI++3a+IpmyHbZs=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmG+M0sMmroVOABrRU18XGA8lkH5YvcXp5tj6yr
 Xem1IzN++uJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZhvjNAAKCRDBN2bmhouD
 12LiEACPENmr/f55rPy2PNYmBSKMIE92z0bbRpP/zs4tSn5dvx6xTsS3SHhRHhJod8y5Lfld9Xk
 dyP8bLzPX670WDi51FvbmNQ6TLqWOc+ZVAXtjpMJ278yuy+jSN2qwkafy1kC5O2QUpi9sSLorM3
 yXsBPXWW63QE+HbVsrngT9TrxaFUZOEQ9fxgjYWKOdFkwV9ZuUDiu84F6hTHD82YzGI4WYjuFGy
 3F+hHkSbtIzYPC7D3tm2DavRCwtORM8cwdX52APhog5l2vfX1cskjCQJRq2dCbbh20p5WIf8Vym
 pbwmN6nt0m+hDtBKHkkY3EJTqxaLJtCfSdHaKQbIHNEojSmrMl3jOVWeErO/9O4nJeVYoyPyHv/
 /AAaXSYDnXmxToW65oj/aoq66JDuogTbMVMLGt8H0bDEsmSq4B7RIjr/bSrbDMhNDDeyuSDBaT9
 UOenre7DQ5IywQbkJZh9kMNyklgdb1ENlPrsGnQuc86KARgS/cq0rwBi/uasHt4xasUMShVizNF
 P0hUOdtSXkACyiFdCm50lwmqjVy489PUucnpqALDwJHm3+hzpcrFVwK+2apPzfkWPxvSgrNk2Rm
 Pte4gXYfZGFcPEtiRtEeb0mbFjONXtcU/KmY8iPJmVJi46x/ATPRw/TyzhsEKa8Ub9BEZEfzktd
 WNx/72UFo4Norww==
X-Developer-Key: i=krzk@kernel.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

The local struct sdhci_ops can be made const for code safety.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/mmc/host/sdhci-omap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-omap.c b/drivers/mmc/host/sdhci-omap.c
index 94076b095571..5841a9afeb9f 100644
--- a/drivers/mmc/host/sdhci-omap.c
+++ b/drivers/mmc/host/sdhci-omap.c
@@ -925,7 +925,7 @@ static void sdhci_omap_set_timeout(struct sdhci_host *host,
 	__sdhci_set_timeout(host, cmd);
 }
 
-static struct sdhci_ops sdhci_omap_ops = {
+static const struct sdhci_ops sdhci_omap_ops = {
 	.set_clock = sdhci_omap_set_clock,
 	.set_power = sdhci_omap_set_power,
 	.enable_dma = sdhci_omap_enable_dma,

-- 
2.34.1



Return-Path: <linux-kernel+bounces-113904-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87C1F888747
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:55:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42C42294243
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:55:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DB92210878;
	Sun, 24 Mar 2024 23:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AsHQ+c06"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4127D1ED71B;
	Sun, 24 Mar 2024 22:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320989; cv=none; b=pf8NULwh+zG8ktPi2jc54ugBfWw7XX8U/ekH2CWs3BJ/tYRlKny7ZJ57jwcIqTLoS7jUTO1PiaFQR/M17MYx2AqT5fNhwu5rUgg3TaxNda3jgr5H6A+yhVsdLlDwwFhita/mfECoiOJqkLZD1EhxmK8/zImnD3DM/VtAjx26Vtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320989; c=relaxed/simple;
	bh=F+WnyX1dM7yyvbEYpvwspvjG+I3TNKFtsHAdgv0gaHY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Mf9eT17vZein/uZ8K0kJGeBWqLbWvaLA2DD7roJ55d4Li4A0EzEuuPK+AKnN5X/GjezBPGKDuCP6QD6BzX2qLDTfL/jy6rCcx1q+XBRdD/GU89M2szY/N0wSQyaMJSUJqpn6q76W/B0Fg9U8FO8j2zQvA6o+5Y172CkyISwVvIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AsHQ+c06; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4529FC43399;
	Sun, 24 Mar 2024 22:56:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320988;
	bh=F+WnyX1dM7yyvbEYpvwspvjG+I3TNKFtsHAdgv0gaHY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AsHQ+c06K5Sru/eXioh3PF9pgJmNRcoG0AM8j0IQeDOQGCsDhteWwYpx8kHrgAy2m
	 c55bY7+/6dvpas73n+30eGfp5a1bbl5yOJuWpOvE5kF5632QNPWDalP9DEbIlfCfvs
	 AU006BN9DBxvze4YOY1KuSjyELYSREBduG39Ty5MNG0HJBfCteT+71faSPCr3AF0kO
	 DGfHW22KHFGEFkl1Fn95VM+bCEQa+WfCN9dMCCD4ydH3emsqPRKTlZCEv4vEu98dcy
	 x0x9FPCOhcBQDcSgmnjgZ+dGolgrJzLg+A8dSF2lb8pV/paUtivWCCxUuIiIMgAg8v
	 pFiW3vCUSeGcA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jonathan Bell <jonathan@raspberrypi.com>,
	Stefan Wahren <wahrenst@gmx.net>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 551/713] PCI: brcmstb: Fix broken brcm_pcie_mdio_write() polling
Date: Sun, 24 Mar 2024 18:44:37 -0400
Message-ID: <20240324224720.1345309-552-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324224720.1345309-1-sashal@kernel.org>
References: <20240324224720.1345309-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Jonathan Bell <jonathan@raspberrypi.com>

[ Upstream commit 039741a8d7c9a01c1bc84a5ac5aa770a5e138a30 ]

The MDIO_WT_DONE() macro tests bit 31, which is always 0 (== done) as
readw_poll_timeout_atomic() does a 16-bit read. Replace with the readl
variant.

[kwilczynski: commit log]
Fixes: ca5dcc76314d ("PCI: brcmstb: Replace status loops with read_poll_timeout_atomic()")
Link: https://lore.kernel.org/linux-pci/20240217133722.14391-1-wahrenst@gmx.net
Signed-off-by: Jonathan Bell <jonathan@raspberrypi.com>
Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
Signed-off-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
Acked-by: Florian Fainelli <florian.fainelli@broadcom.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/controller/pcie-brcmstb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
index f9dd6622fe109..e47a77f943b1e 100644
--- a/drivers/pci/controller/pcie-brcmstb.c
+++ b/drivers/pci/controller/pcie-brcmstb.c
@@ -330,7 +330,7 @@ static int brcm_pcie_mdio_write(void __iomem *base, u8 port,
 	readl(base + PCIE_RC_DL_MDIO_ADDR);
 	writel(MDIO_DATA_DONE_MASK | wrdata, base + PCIE_RC_DL_MDIO_WR_DATA);
 
-	err = readw_poll_timeout_atomic(base + PCIE_RC_DL_MDIO_WR_DATA, data,
+	err = readl_poll_timeout_atomic(base + PCIE_RC_DL_MDIO_WR_DATA, data,
 					MDIO_WT_DONE(data), 10, 100);
 	return err;
 }
-- 
2.43.0



Return-Path: <linux-kernel+bounces-114373-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 005B7889150
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:38:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 42CECB35632
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:02:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B7421741D3;
	Sun, 24 Mar 2024 23:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZjF2eDVt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 366C314A61C;
	Sun, 24 Mar 2024 23:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321767; cv=none; b=l1otddf/auwJ0G0JrqcoMYOqz3xEEOIHm8M2/Q+QTIWhXPy5T+iSWNUP3XgFPFmzAeg+vDquK3GnbVPeWGusdK8oiW00OworPjHyczWGesjY3nlRFH90BEX+AUQL3n5xDSfGNe22i2JzJJa3aj/Ln1CUyjnE8wUImzhjOa1G+2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321767; c=relaxed/simple;
	bh=F+WnyX1dM7yyvbEYpvwspvjG+I3TNKFtsHAdgv0gaHY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j/tbzpzJVInIiBSve2r1I2dIfoF6qWrvdzQIYqbm2ypRQga8/4uO2njrR3G/sMGQOTymWo94Bd0gPfDxEaS2u6dGgCm0BbEp5bDsulZBs38FoinK1mlWK6XgCvhq5HWNEqXnova19xqR4iNxHM/3r2IPP3gWdRy11coyvggpciw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZjF2eDVt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4545FC43394;
	Sun, 24 Mar 2024 23:09:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321766;
	bh=F+WnyX1dM7yyvbEYpvwspvjG+I3TNKFtsHAdgv0gaHY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZjF2eDVt6VTAa6Y4aV4AzChjyllgyx79kIeuWrv5aLBsijmeyee7CLX8KHUccXw4l
	 KbuWXK/KKqAa7DnJaBAlBpshjd2prPv6l0n3WifF6er19sgsgcI1P5mx80wRvkYHWB
	 SuwnAZ+AHu7ceTRTZkt8Po8gJr8lAkF9hNZ9+ov4HvIIdj8uPZs2SEgLBbjRwNtc3x
	 A2+5QxyW65al1onGSZed8hK/BhqHewXPQojfYGCqspW+Cugfp2JUOOn2zufJnIxu9d
	 rFjUk7dbiHSsfGLFQa70tzOvZ3hx+eClubp4YxNsol2VVKyzVVj6mCSm4l2rGJW+02
	 2AKO62WLZ3GAg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jonathan Bell <jonathan@raspberrypi.com>,
	Stefan Wahren <wahrenst@gmx.net>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 494/638] PCI: brcmstb: Fix broken brcm_pcie_mdio_write() polling
Date: Sun, 24 Mar 2024 18:58:51 -0400
Message-ID: <20240324230116.1348576-495-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324230116.1348576-1-sashal@kernel.org>
References: <20240324230116.1348576-1-sashal@kernel.org>
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



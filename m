Return-Path: <linux-kernel+bounces-113427-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B50288843C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:34:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35FB6284186
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:33:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 377DF1A9954;
	Sun, 24 Mar 2024 22:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YDDD6gNE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71E171A9938;
	Sun, 24 Mar 2024 22:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320229; cv=none; b=fo2OCfnJHiIPUQGDI8Pgabs1et9UgwC2dCqHmVpAHObLQrzMG4uwsQTcURjC5FZcKYko3nxh+aprk5iNRAuYabsbw+MRxHFeixJ60jIDiGEicajaDJZUsF9Jdw+QNHWR2gFiGV5GS6dw1BCsQocE4QBhPpnpswMQdm1/LNwTGdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320229; c=relaxed/simple;
	bh=UG2h6+XvryN6gQ9vdCGtSG/zCgIX9zu7saPtncgrqOM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q4FvWCrL9FVOvCOdarDcNthCy+PIzu7QZBsajTxkxsMJYdUzdLrOKQ7NZzMsH4ep6ow5H6JQIoRAr/6DO+o+ro7eBpwB2UYlhMYnGqef2D7/UCCN00xJZVjsRZ41WREDATROC5f9zMOmgPOJN0hDkEXCGOZJIS0pB33GEtF8+M0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YDDD6gNE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81506C433C7;
	Sun, 24 Mar 2024 22:43:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320229;
	bh=UG2h6+XvryN6gQ9vdCGtSG/zCgIX9zu7saPtncgrqOM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YDDD6gNE1IvR2SFWm/AlFyebtDMaxcb3eQG25fcIhQg8LMORXoPwnJP5pMjJw17tg
	 x1yuikMr6lXaaleoT3ur7i56Vs4NnHAQhGTokJsvp8LzILg/0ZA1z/lBqsGYl56V0+
	 8iBOuC60HMKkU+yd9QDJcLRrcWL34a/qyL2tV6nOooyIHeKmSJZbAVCaZxQBSNBo0v
	 mcSLQG5ZKY5vVb7ZxTOOJKNxBycNxU3V/UH7fN4W3o7YcRkT0+64ulNQnUF0hC9/Cp
	 MTEXjkcDqaV0CboVwzn7Yd0IwqREJ1+9d+FrqKfpjTTg8ch/cic8+aEk0z8n9DpOVT
	 OaqbMdskxUT5Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jonathan Bell <jonathan@raspberrypi.com>,
	Stefan Wahren <wahrenst@gmx.net>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 536/715] PCI: brcmstb: Fix broken brcm_pcie_mdio_write() polling
Date: Sun, 24 Mar 2024 18:31:55 -0400
Message-ID: <20240324223455.1342824-537-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
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
index 5b0730c3891b8..c08683febdd40 100644
--- a/drivers/pci/controller/pcie-brcmstb.c
+++ b/drivers/pci/controller/pcie-brcmstb.c
@@ -336,7 +336,7 @@ static int brcm_pcie_mdio_write(void __iomem *base, u8 port,
 	readl(base + PCIE_RC_DL_MDIO_ADDR);
 	writel(MDIO_DATA_DONE_MASK | wrdata, base + PCIE_RC_DL_MDIO_WR_DATA);
 
-	err = readw_poll_timeout_atomic(base + PCIE_RC_DL_MDIO_WR_DATA, data,
+	err = readl_poll_timeout_atomic(base + PCIE_RC_DL_MDIO_WR_DATA, data,
 					MDIO_WT_DONE(data), 10, 100);
 	return err;
 }
-- 
2.43.0



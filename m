Return-Path: <linux-kernel+bounces-50396-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AA17847873
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 19:52:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D88E1C2503D
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 18:52:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 136DB154BFF;
	Fri,  2 Feb 2024 18:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gBHfxOYX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51D4B13C1F5;
	Fri,  2 Feb 2024 18:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706899269; cv=none; b=qr0thfdEWjP6iHaZTff+gkj7L5ZgZlAsyVorIVZaKfg668e9t6PFxig4PBP+Z54nnoCep3WxbTlbyBCIwZkvsxhqXz5iCm1EaEQRzRT64XRqIMsMJUe52WvSR8czDJNuGv59TfYygxvdDfMT4aWulEdpPqZD0SawN3ANF+13xAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706899269; c=relaxed/simple;
	bh=8xd+HaBx8HFhxNoJoDn2ZaWc9Aydn6hKsS84wUq5FCI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YQ7cDclfelMT0AOXXBV+wYRhddA5m1PovQyUgN26kJ7yjdJ/E97L6M503Pex78W6l5HHFdzCgCjnHhTcuBA1vXuuSW+jcxRrXrIG1N8nzEDesIrybI7KZQDvswswaNnIKjthFH9iA7CSe/pnRaW6B308XoRsV3Y0NRaxSmiNDWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gBHfxOYX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54E35C43390;
	Fri,  2 Feb 2024 18:41:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706899269;
	bh=8xd+HaBx8HFhxNoJoDn2ZaWc9Aydn6hKsS84wUq5FCI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gBHfxOYXFSdSO9xWX2gOj08p69eE9prMXQPGZK3eSOrhHkbf1gHo7bjxrlWBruwox
	 aTcSNE33dA87Io+A7NVhjX9X0zjAyPrGnHfTWngxz0SS6o0uZDaaMx2BR1HBk+Cuh3
	 6RFb6Z9u4xZydezDJ966HhdPU8BdE2gCdxBEK+LTyRS7HrQ2rwdP5Z74AQCtc0UqxA
	 V794zIo2ptH/2MrK7+zEtSVGLv1Dp9RMjbXCIDcZ2vdnITZNbg4agKSZ/AgCytySis
	 sCYvaZoJfeEum93cq1IwUgSPhvyazf0OuDFYIASwzBm5F8sX3t30a/KHzEogqSALdQ
	 wV1ajNhStzftw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Devyn Liu <liudingyuan@huawei.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	f.fangjian@huawei.com,
	linux-spi@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 06/15] spi: hisi-sfc-v3xx: Return IRQ_NONE if no interrupts were detected
Date: Fri,  2 Feb 2024 13:40:43 -0500
Message-ID: <20240202184057.541411-6-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240202184057.541411-1-sashal@kernel.org>
References: <20240202184057.541411-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.76
Content-Transfer-Encoding: 8bit

From: Devyn Liu <liudingyuan@huawei.com>

[ Upstream commit de8b6e1c231a95abf95ad097b993d34b31458ec9 ]

Return IRQ_NONE from the interrupt handler when no interrupt was
detected. Because an empty interrupt will cause a null pointer error:

    Unable to handle kernel NULL pointer dereference at virtual
  address 0000000000000008
    Call trace:
        complete+0x54/0x100
        hisi_sfc_v3xx_isr+0x2c/0x40 [spi_hisi_sfc_v3xx]
        __handle_irq_event_percpu+0x64/0x1e0
        handle_irq_event+0x7c/0x1cc

Signed-off-by: Devyn Liu <liudingyuan@huawei.com>
Link: https://msgid.link/r/20240123071149.917678-1-liudingyuan@huawei.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-hisi-sfc-v3xx.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/spi/spi-hisi-sfc-v3xx.c b/drivers/spi/spi-hisi-sfc-v3xx.c
index d3a23b1c2a4c..61bf00dfe9c3 100644
--- a/drivers/spi/spi-hisi-sfc-v3xx.c
+++ b/drivers/spi/spi-hisi-sfc-v3xx.c
@@ -377,6 +377,11 @@ static const struct spi_controller_mem_ops hisi_sfc_v3xx_mem_ops = {
 static irqreturn_t hisi_sfc_v3xx_isr(int irq, void *data)
 {
 	struct hisi_sfc_v3xx_host *host = data;
+	u32 reg;
+
+	reg = readl(host->regbase + HISI_SFC_V3XX_INT_STAT);
+	if (!reg)
+		return IRQ_NONE;
 
 	hisi_sfc_v3xx_disable_int(host);
 
-- 
2.43.0



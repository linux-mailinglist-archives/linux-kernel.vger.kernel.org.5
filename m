Return-Path: <linux-kernel+bounces-36708-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F21A83A55A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 10:26:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B7157B2C30B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 09:24:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0F471B817;
	Wed, 24 Jan 2024 09:22:19 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54EC6182DD
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 09:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706088139; cv=none; b=nkrA8PqaSeF/lrCESrlfelInC9Y8mWPXJdF1LE+cB/6vko0wpPpmlpY+rxn3ZLcMtrONEQO52oB+m2CmeDGxDcXrwwmGLaHlErkzqsTXBtTQ+ew2q7rq2Na3HsxvwMZaVEycMZQNHo8q4N39H09veqfno5Z+3BS6rMgqDlocX1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706088139; c=relaxed/simple;
	bh=gTxMQ79WM4+Bgd8zZMM56EUrCyCWvyJbnhR1hUQbHe4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dHXsjuguaWcYy8OirtYu261HCVjeGPIuXsKcYe4R9kUceNYjPiDUMGZRkyBI9BwPpMkKuZEEJbCPJXgtirD1GYEE6yIG7Pdpr9BtCJh6+kkHrQyRRGN8WombELeZtV5eZvpcow7kVxkjoEV2ykmVQbcLsvWkqJpina+5OsTK09E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from dude05.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::54])
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1rSZSW-0002bS-S0; Wed, 24 Jan 2024 10:22:12 +0100
From: Philipp Zabel <p.zabel@pengutronix.de>
Date: Wed, 24 Jan 2024 10:22:09 +0100
Subject: [PATCH 2/2] drm/etnaviv: Disable SH_EU clock gating on VIPNano-Si+
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240124-etnaviv-npu-v1-2-a5aaf64aec65@pengutronix.de>
References: <20240124-etnaviv-npu-v1-0-a5aaf64aec65@pengutronix.de>
In-Reply-To: <20240124-etnaviv-npu-v1-0-a5aaf64aec65@pengutronix.de>
To: Lucas Stach <l.stach@pengutronix.de>, 
 Russell King <linux+etnaviv@armlinux.org.uk>, 
 Christian Gmeiner <christian.gmeiner@gmail.com>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
Cc: etnaviv@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Philipp Zabel <p.zabel@pengutronix.de>
X-Mailer: b4 0.13-dev-f0463
X-SA-Exim-Connect-IP: 2a0a:edc0:0:1101:1d::54
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

Disable SH_EU clock gating for the VIPNano-Si+ NPU on i.MX8MP.
Taken from linux-imx lf-6.1.36-2.1.0, specifically [1].

[1] https://github.com/nxp-imx/linux-imx/blob/lf-6.1.36-2.1.0/drivers/mxc/gpu-viv/hal/kernel/arch/gc_hal_kernel_hardware.c#L2747-L2761

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 drivers/gpu/drm/etnaviv/etnaviv_gpu.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
index 9b8445d2a128..e28332a2560d 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
@@ -641,6 +641,10 @@ static void etnaviv_gpu_enable_mlcg(struct etnaviv_gpu *gpu)
 		pmc |= VIVS_PM_MODULE_CONTROLS_DISABLE_MODULE_CLOCK_GATING_SE |
 		       VIVS_PM_MODULE_CONTROLS_DISABLE_MODULE_CLOCK_GATING_RA;
 
+	/* Disable SH_EU clock gating on affected core revisions. */
+	if (etnaviv_is_model_rev(gpu, GC8000, 0x8002))
+		pmc |= VIVS_PM_MODULE_CONTROLS_DISABLE_MODULE_CLOCK_GATING_SH_EU;
+
 	pmc |= VIVS_PM_MODULE_CONTROLS_DISABLE_MODULE_CLOCK_GATING_RA_HZ;
 	pmc |= VIVS_PM_MODULE_CONTROLS_DISABLE_MODULE_CLOCK_GATING_RA_EZ;
 

-- 
2.39.2



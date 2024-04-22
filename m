Return-Path: <linux-kernel+bounces-154301-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 915AF8ADA78
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 02:13:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 87B38B29464
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 00:13:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB5A917F39D;
	Mon, 22 Apr 2024 23:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kI8ZsfEZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2706817F38B;
	Mon, 22 Apr 2024 23:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713830265; cv=none; b=AXvYtyA/LmYzx3dCUG8+hnQjxHE4bGBWyjNQ8mmUROj4ybIrV0ej92DKNABC8jXgfX/2oxFNoA6WFhjzMcHbULjN2gj0+IvilAFxrV6cTh+5oxjO2NK16WKj5CMy5vBpERnamAJX0dZLtfLHIlrV6XYUcnC60LVhnhQt+uoBNA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713830265; c=relaxed/simple;
	bh=PYllO4P0w1bEO6gQFn/31ZkUIJ2oyI8dlVzxp96YQDA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JuDyahwr42jvg6hI35EVY+2mSQezvIaS/7aUziFyWq3UEW2wpz8LpbQi9cPDlg2HR2YqOL/JL4w9M5n589/FLfxEqAb+zcff9T7WMLBojm5vu+l16CBosPyf4dpqZ5BP65ePjPGFD+kOpP04QL0FWlp+rLDruQNyUbiDGtx3TnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kI8ZsfEZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCB3BC113CC;
	Mon, 22 Apr 2024 23:57:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713830265;
	bh=PYllO4P0w1bEO6gQFn/31ZkUIJ2oyI8dlVzxp96YQDA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kI8ZsfEZE0fg7doLG+t1Ex1eCrNEs5E4Ec2X+ZZLoavUygj3N/OjCFbplfflYLE87
	 L/CVE3F/UQlEDhuprpnrEhMqf3l1ucJByDcpQSE4qr+zzFltfSKFI3FyTy/mtZre7j
	 QVEomNY2v2iy/6MhV96KsF4lqJFdxqt8Ju6no+hRie4k8HuIF3ZPE76CavM0TSiwWy
	 QqTtU1xJpWwAjZ2lWQZ/iofghh4auXWljT6bfjTcXga2APNruQImKXyu8ssiuA5i/V
	 C6o2y5vcQNuTMDNxNn2EtPjXFhx8g16frvmGsVPOiAAXg9yV03QC9ZJQqpSD+JALGY
	 1tugQqpG1WD9A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Thierry Reding <treding@nvidia.com>,
	Jon Hunter <jonathanh@nvidia.com>,
	Sasha Levin <sashal@kernel.org>,
	thierry.reding@gmail.com,
	mperttunen@nvidia.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	dri-devel@lists.freedesktop.org,
	linux-tegra@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 11/19] gpu: host1x: Do not setup DMA for virtual devices
Date: Mon, 22 Apr 2024 19:18:25 -0400
Message-ID: <20240422231845.1607921-11-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240422231845.1607921-1-sashal@kernel.org>
References: <20240422231845.1607921-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.87
Content-Transfer-Encoding: 8bit

From: Thierry Reding <treding@nvidia.com>

[ Upstream commit 8ab58f6841b19423231c5db3378691ec80c778f8 ]

The host1x devices are virtual compound devices and do not perform DMA
accesses themselves, so they do not need to be set up for DMA.

Ideally we would also not need to set up DMA masks for the virtual
devices, but we currently still need those for legacy support on old
hardware.

Tested-by: Jon Hunter <jonathanh@nvidia.com>
Acked-by: Jon Hunter <jonathanh@nvidia.com>
Signed-off-by: Thierry Reding <treding@nvidia.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20240314154943.2487549-1-thierry.reding@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/host1x/bus.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/gpu/host1x/bus.c b/drivers/gpu/host1x/bus.c
index bdee16a0bb8e2..ba622fb5e4822 100644
--- a/drivers/gpu/host1x/bus.c
+++ b/drivers/gpu/host1x/bus.c
@@ -368,11 +368,6 @@ static int host1x_device_uevent(struct device *dev,
 	return 0;
 }
 
-static int host1x_dma_configure(struct device *dev)
-{
-	return of_dma_configure(dev, dev->of_node, true);
-}
-
 static const struct dev_pm_ops host1x_device_pm_ops = {
 	.suspend = pm_generic_suspend,
 	.resume = pm_generic_resume,
@@ -386,7 +381,6 @@ struct bus_type host1x_bus_type = {
 	.name = "host1x",
 	.match = host1x_device_match,
 	.uevent = host1x_device_uevent,
-	.dma_configure = host1x_dma_configure,
 	.pm = &host1x_device_pm_ops,
 };
 
@@ -475,8 +469,6 @@ static int host1x_device_add(struct host1x *host1x,
 	device->dev.bus = &host1x_bus_type;
 	device->dev.parent = host1x->dev;
 
-	of_dma_configure(&device->dev, host1x->dev->of_node, true);
-
 	device->dev.dma_parms = &device->dma_parms;
 	dma_set_max_seg_size(&device->dev, UINT_MAX);
 
-- 
2.43.0



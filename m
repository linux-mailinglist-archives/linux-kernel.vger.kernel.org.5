Return-Path: <linux-kernel+bounces-154334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C38758ADADE
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 02:22:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 629601F22C62
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 00:22:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF7F4158DC1;
	Mon, 22 Apr 2024 23:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MN9vH5OU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34CE61C6891;
	Mon, 22 Apr 2024 23:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713830350; cv=none; b=omM28ZuCerTvq3+lKfiTc+dWgb5zwS4VUZ7D+/8YSQ0S8LuDmdSp5peGF2x5F6tL3JBUMikHawlIx1tkkqq62sh5v0oGt+S9bpQ2jEfm6Qkgjyc0MUJozun8bhqcnzuPhsHkG4P3d9ETy/ekl5kP0DyIcTQj3+bjCNM0AcQVuCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713830350; c=relaxed/simple;
	bh=r67qrCl5MZZldL87dF/H0Wd7C0fpUbYDKx3KNgX6cFo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N/59cD5mtHULGnAgm9u05fC4WMfpXmFbUUNezYGqdF24zzTgNK4dumLSiRvbarQJsYHkzHH1VPyIMpefsEzA83Tx+9uBJFZqYOG+uFzx/ZkNAOcoZYeWlXX56iufeDfiaEyG3hA4N9uR3sDjQY32x9Iw02avyRDG0ubdqc9cm3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MN9vH5OU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D66FFC32782;
	Mon, 22 Apr 2024 23:59:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713830350;
	bh=r67qrCl5MZZldL87dF/H0Wd7C0fpUbYDKx3KNgX6cFo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MN9vH5OUCpHDV0WX9q5hRLdQYfDuWLvgs1YJbor7E9U++iBX5XPeiPvZXciTWMOTC
	 R6JYU8JLuzYQ+oz9z18tGZzfn003k8uBzT/5hNIeHDR9nqFauYOwrqTplmgbsQ+cG+
	 hOahwQ1Tw84cGSHsQNoExWyA84Al78opUPfRVXVSuH6xvITXvlpf6GHJoqqYZQzqSG
	 sfiH5zNsJgMCUjahhfouy/b25VAzMC44TBupxHw2iGD7e1cDFIos7V4xx+Dg6SRsBu
	 MOk1kyWb8CKqdOUSBAMCB7Y9gKnrVLgVRUki0g/69Z4OYKSnKlN6mBqMUgKtQ9JY+q
	 DJuJ8fVtA3wPA==
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
Subject: [PATCH AUTOSEL 5.4 6/9] gpu: host1x: Do not setup DMA for virtual devices
Date: Mon, 22 Apr 2024 19:20:11 -0400
Message-ID: <20240422232020.1615476-6-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240422232020.1615476-1-sashal@kernel.org>
References: <20240422232020.1615476-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.274
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
index fcda8621ae6f9..5a1bf59be7341 100644
--- a/drivers/gpu/host1x/bus.c
+++ b/drivers/gpu/host1x/bus.c
@@ -335,11 +335,6 @@ static int host1x_device_uevent(struct device *dev,
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
@@ -353,7 +348,6 @@ struct bus_type host1x_bus_type = {
 	.name = "host1x",
 	.match = host1x_device_match,
 	.uevent = host1x_device_uevent,
-	.dma_configure = host1x_dma_configure,
 	.pm = &host1x_device_pm_ops,
 };
 
@@ -442,8 +436,6 @@ static int host1x_device_add(struct host1x *host1x,
 	device->dev.bus = &host1x_bus_type;
 	device->dev.parent = host1x->dev;
 
-	of_dma_configure(&device->dev, host1x->dev->of_node, true);
-
 	device->dev.dma_parms = &device->dma_parms;
 	dma_set_max_seg_size(&device->dev, SZ_4M);
 
-- 
2.43.0



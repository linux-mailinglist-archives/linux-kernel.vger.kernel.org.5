Return-Path: <linux-kernel+bounces-154316-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DB7D8ADAA2
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 02:17:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF5201F20C3A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 00:17:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE119199E86;
	Mon, 22 Apr 2024 23:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t/pwF3kU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B251184103;
	Mon, 22 Apr 2024 23:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713830301; cv=none; b=TzgihDPx+K/gBgXg2X6ArQmivZX1SDNlFie+q11V0PI6Jjlflw15YCsrUrPVr80OLX9Lh4sHi/wLQRJNhlzuprX+MH6qnu12dJ1jD8HZdrRFYBeheiCGAGl3q4oFXrTKzp9HpLJXrsCrS9ehuDTKSAlSXMgdMtzrEJdwXZrsUYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713830301; c=relaxed/simple;
	bh=dAATtIO+PHk+nCVuy1FR/y8lxxhRnQCB9SvS8GX/v3o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hOa2SKpyXl6rCATjTDzIknsmrSGMONTWiGrhMbRCr1GDthuD2e+FgTifU7M9K36UhcptaNoYCRIhXIzH+ygsCrGyex1jn+SZOzzuZihEFKxKIjpvDpReJB2CwMMiwGT9MskA5ckMD7j/pxzdtmwu/lGuI0h5wVN86ktYl8pUOsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t/pwF3kU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C227BC2BD11;
	Mon, 22 Apr 2024 23:58:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713830301;
	bh=dAATtIO+PHk+nCVuy1FR/y8lxxhRnQCB9SvS8GX/v3o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=t/pwF3kUBgLGaRE6clVEPwwZhmC3JaIUseVFBD+LIpINSGnMmktYvARCJBxmQ48FD
	 XVkQqNaL7TP+t2ffFwBYp+bInPmiEYrINPorvhM2pz++ViLplMosbZEt0KpXnWFkjf
	 BH2NyyO9N7f4El5eVirXgFX/Tz0hs5pbSurKWaGMjko9T3xns/WVraganHQlm8+6H1
	 eFw0cY0oZA/KzQZiv3W1mE19BKB0IPf9n7f9zpTCRKCw9xy7MZ51zVNpT7yQxJX4pJ
	 7mZoKHodUX+mXvttbLY3Dl19GmbsvG8JSAoLEo7uj1+YBLzwfM5eKmAHjc6wknJByA
	 GZzMFSzf0lEkw==
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
Subject: [PATCH AUTOSEL 5.15 07/10] gpu: host1x: Do not setup DMA for virtual devices
Date: Mon, 22 Apr 2024 19:19:20 -0400
Message-ID: <20240422231929.1611680-7-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240422231929.1611680-1-sashal@kernel.org>
References: <20240422231929.1611680-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.156
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
index 218e3718fd68c..96737ddc81209 100644
--- a/drivers/gpu/host1x/bus.c
+++ b/drivers/gpu/host1x/bus.c
@@ -367,11 +367,6 @@ static int host1x_device_uevent(struct device *dev,
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
@@ -385,7 +380,6 @@ struct bus_type host1x_bus_type = {
 	.name = "host1x",
 	.match = host1x_device_match,
 	.uevent = host1x_device_uevent,
-	.dma_configure = host1x_dma_configure,
 	.pm = &host1x_device_pm_ops,
 };
 
@@ -474,8 +468,6 @@ static int host1x_device_add(struct host1x *host1x,
 	device->dev.bus = &host1x_bus_type;
 	device->dev.parent = host1x->dev;
 
-	of_dma_configure(&device->dev, host1x->dev->of_node, true);
-
 	device->dev.dma_parms = &device->dma_parms;
 	dma_set_max_seg_size(&device->dev, UINT_MAX);
 
-- 
2.43.0



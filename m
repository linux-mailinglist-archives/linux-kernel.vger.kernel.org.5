Return-Path: <linux-kernel+bounces-154326-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B71628ADAC1
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 02:20:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DA2D1F20D3A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 00:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FDF41BF6F5;
	Mon, 22 Apr 2024 23:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a0WSWj0S"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E7251BF6E2;
	Mon, 22 Apr 2024 23:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713830327; cv=none; b=DXsyrIJczcmm6k+TnMWkXy0NEZjCkACfXT1+4C++TacwcWWYKFHWrekSo0P5OIanb8MYfjFelmG6CsGF11azi64qkxCEn5EqhZ5JgAa39bf1ZM7Z05QpAntX3pwMR+v3g0PTKegT39zVHFI/bhHHpYTTz/3udgsvrtFtyynuiV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713830327; c=relaxed/simple;
	bh=JKVsaxJo/pKtxdhByvwKTlGoDkDpTOFdoHcj/OwxayA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HUuixBFHtk9g4NrQTVhe/N6nAUEqnCDrEzJ897h16coqX8lJNLbMUzBgzBPlWo3k0iLSoGLgNqwfNS/pI5/j0dJrWxShm0L87lZ1BDRd4mfYGbuLjQY5OoBn4T3yAuOg7HjG1kRRFkUBow9ip5Yl+b046H06te0JdT77w5dd56k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a0WSWj0S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0B6BC2BD11;
	Mon, 22 Apr 2024 23:58:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713830327;
	bh=JKVsaxJo/pKtxdhByvwKTlGoDkDpTOFdoHcj/OwxayA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=a0WSWj0SW3qzA7D/RxuSId0O5pjTIEvISrvpCYI4wh1NF4+xWYv36pq3UsGxi3YRk
	 HiYQ7aSqGYjYu7MC1Rj/FJsiLgNBiyqfuAJUrZDT2VOmVGnVYiXWd0n+IsNwX/zCh9
	 tU7JnIEOYe73CEBQhgbvhjAfNZZso6h4hHP0QGsIT9ljcf8pFqsZtFDDvPpntMrEMe
	 vqPkCtWUGSjsn4pdnQyyZdxi+smGz2hdUQb5T1MGZP/a/kj6it++Ge1VEl9Nd4JYt+
	 FJUpJaHUFp2DokG9yekPsaMptkgiRNLvweuMTikigW48cPHvxR4rNf1xWbnPfIjtKr
	 7eDkaFLR+IFWw==
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
Subject: [PATCH AUTOSEL 5.10 7/9] gpu: host1x: Do not setup DMA for virtual devices
Date: Mon, 22 Apr 2024 19:19:48 -0400
Message-ID: <20240422231955.1613650-7-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240422231955.1613650-1-sashal@kernel.org>
References: <20240422231955.1613650-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.215
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
index 6e3b49d0de66d..b113c8e0acd02 100644
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
 	dma_set_max_seg_size(&device->dev, UINT_MAX);
 
-- 
2.43.0



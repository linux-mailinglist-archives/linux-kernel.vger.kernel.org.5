Return-Path: <linux-kernel+bounces-154275-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B14B48ADA2C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 02:07:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FDBD1F21265
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 00:07:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F67747773;
	Mon, 22 Apr 2024 23:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N7mDDBcP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 761D616D4C5;
	Mon, 22 Apr 2024 23:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713830194; cv=none; b=uSHzKtcfpV/T8GW2vv7W2n7e6fDV4/+GhAJKtjv5ENYDXTNGZDRtukt2Z0u/DYibYQzmer355QTofLIyrkyWLihajNhSkaCE3njzRBdLc7ta5zymmJ4AAu8OYfQtzxwe/HL7vI2qko4VgCJhkQCfk0UkMMlhuHvyWed/V/YWJ/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713830194; c=relaxed/simple;
	bh=GEpnhiSTG1TbEnLT97kCT5VbQj9dur5yP9sjIze/XLU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TkO3Fe3NoTmxVk6KWH3lydPHoqT8z8MRS9UFnasOVBUBOF1n8BMZLDKN+8BO7ScjIChUGlBYgbp+q7EhZB3lKez42Tkmo0qiLr2WiGeyLwt0w7SmZltcoU8F75oB5QJaVXpyDD/RvItcWK/LrycEHIoja5/yuUnuOqTsyOFsquo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N7mDDBcP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D329C113CC;
	Mon, 22 Apr 2024 23:56:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713830194;
	bh=GEpnhiSTG1TbEnLT97kCT5VbQj9dur5yP9sjIze/XLU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=N7mDDBcPgCrZw+vB2Gm0H7cXzvXIjDpGazSB3YgNek7efWdn3gIUUnYDbivPG6zd2
	 6fVio7GDYYTcI9ZKMcrNCoBGUnT7OOUROu1htr3lhP3JT/Y4d6vdZL+vFW/iATrIuJ
	 aVEG3vUr00rhFGq9HQV3u0MWVfuzQ63+Q8qrqFjh7yJ23vtQsuWYRGYbHcwcqBeDOb
	 Ww3cexKpczJd8cm3QwHnxS3sLCB2RcgC04VImXi57VsnNhJ8fdS8HyahPIvoqSCDjU
	 LjFZXc6YnczsqyN5NR/OKzjY2lvxsZPjiGJpnt7z1LQ1p6eYLTOulQMPdFVYdzIsMn
	 Usz6VNFHwH1Ow==
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
Subject: [PATCH AUTOSEL 6.6 14/29] gpu: host1x: Do not setup DMA for virtual devices
Date: Mon, 22 Apr 2024 19:16:55 -0400
Message-ID: <20240422231730.1601976-14-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240422231730.1601976-1-sashal@kernel.org>
References: <20240422231730.1601976-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.28
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
index 84d042796d2e6..3937889fa912d 100644
--- a/drivers/gpu/host1x/bus.c
+++ b/drivers/gpu/host1x/bus.c
@@ -351,11 +351,6 @@ static int host1x_device_uevent(const struct device *dev,
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
@@ -369,7 +364,6 @@ struct bus_type host1x_bus_type = {
 	.name = "host1x",
 	.match = host1x_device_match,
 	.uevent = host1x_device_uevent,
-	.dma_configure = host1x_dma_configure,
 	.pm = &host1x_device_pm_ops,
 };
 
@@ -458,8 +452,6 @@ static int host1x_device_add(struct host1x *host1x,
 	device->dev.bus = &host1x_bus_type;
 	device->dev.parent = host1x->dev;
 
-	of_dma_configure(&device->dev, host1x->dev->of_node, true);
-
 	device->dev.dma_parms = &device->dma_parms;
 	dma_set_max_seg_size(&device->dev, UINT_MAX);
 
-- 
2.43.0



Return-Path: <linux-kernel+bounces-71099-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7C8985A096
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 11:10:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A5336B22555
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 10:10:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB6412561D;
	Mon, 19 Feb 2024 10:09:43 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D63322C1B9
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 10:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708337383; cv=none; b=X32KfxvDhRdtpJfPju8IRVgdFGEjp85kNaNKRHdOni0zOWZxbv8lKorxHb1QYhCnh03k3nR6DZkWLYYdF+p563+DSP6iVnxpfK9d5DouiKznjNJj46DzCGIC81tibmPasahlAnsv5uwnGsradqF6/baiYf3l/v7al2U+Ny9WhTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708337383; c=relaxed/simple;
	bh=4p55QVB0gwo1Fy/Ce5qntjkMuucso5JioyXwkvgEAIw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZXoqhyJQbsdbGsADU4co3DjPzK6hBuk4sMT5gJHp036Eb965dfeha6yBiWXUNYlgEAecz6IlytSUqGNGOsPlg4fnF6orvP5izapuZsocHRw9rD4lnCz2dSLtZpy+DvtyFzqxEXYSpmnIGoOyDl9KycOPbanDdB8L6lTqNJhDyAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0E9ECFEC;
	Mon, 19 Feb 2024 02:10:21 -0800 (PST)
Received: from a077854.blr.arm.com (a077854.arm.com [10.162.41.80])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 45ED93F762;
	Mon, 19 Feb 2024 02:09:38 -0800 (PST)
From: Faiz Abbas <faiz.abbas@arm.com>
To: linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Cc: liviu.dudau@arm.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	daniel@ffwll.ch,
	Amjad Ouled-Ameur <amjad.ouled-ameur@arm.com>,
	Faiz Abbas <faiz.abbas@arm.com>
Subject: [PATCH 3/3] drm/arm/komeda: update DMA mask to 40 bits
Date: Mon, 19 Feb 2024 15:39:15 +0530
Message-Id: <20240219100915.192475-4-faiz.abbas@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240219100915.192475-1-faiz.abbas@arm.com>
References: <20240219100915.192475-1-faiz.abbas@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Amjad Ouled-Ameur <amjad.ouled-ameur@arm.com>

Each layer in the DPU has a 40-bit base address register, which indicates
start of frame buffer data for that layer. Komeda driver does not set
its DMA mask, which makes it 32-bit by default which does not use
the entire available possible supported by the DPU.

Update the DMA mask to align with DPU Architecture v1.0 spec.

Signed-off-by: Amjad Ouled-Ameur <amjad.ouled-ameur@arm.com>
Signed-off-by: Faiz Abbas <faiz.abbas@arm.com>
---
 drivers/gpu/drm/arm/display/komeda/komeda_drv.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_drv.c b/drivers/gpu/drm/arm/display/komeda/komeda_drv.c
index cc57ea4e13ae..fea5a4818f33 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_drv.c
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_drv.c
@@ -59,6 +59,10 @@ static int komeda_platform_probe(struct platform_device *pdev)
 	struct komeda_drv *mdrv;
 	int err;
 
+	err = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(40));
+	if (err)
+		return dev_err_probe(dev, err, "DMA mask error\n");
+
 	mdrv = devm_kzalloc(dev, sizeof(*mdrv), GFP_KERNEL);
 	if (!mdrv)
 		return -ENOMEM;
-- 
2.25.1



Return-Path: <linux-kernel+bounces-33475-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4CFC836A1E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 17:19:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FEA528717D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 16:19:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B9AC1339AA;
	Mon, 22 Jan 2024 15:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p+o2EqLK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E45E3FB04;
	Mon, 22 Jan 2024 15:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705936431; cv=none; b=Wxzh3RM6Z+9B15e3rBkmw6ToYuOI9rG6nPjI6hGk6Qqrb+xQXDv+qQ5QEwrtlZE4yOcl9caV0jouE/OheDe8ktTdy7R8dES4hE1fhzJLEMW3J1G/lfUWzdxPVybLZ3fRdklY9qauZ8pOF+lrhI/BCpoNA89q+OsEffwBsnkD8dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705936431; c=relaxed/simple;
	bh=6Kv7gJZBOWBZLuCsxITniTN+E+NwKG0Os4iFWCyMUsk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u4Tqts78ZUYPj8MUGDk3tv+sH3YS+aJfNHrDJYUsQcKK6TaFsm4MFECtOfqAwh2peVMyRRuhNH2SmWLeNh5gaVWTrfUoR+d1PPLBP5ZWInclqheWkPAp0ycPF8tfp8EOrVVVnej7OuO0QHTf1EAvA00LM0kpF3sIuWw7fcEp5vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p+o2EqLK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CA3AC43390;
	Mon, 22 Jan 2024 15:13:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705936431;
	bh=6Kv7gJZBOWBZLuCsxITniTN+E+NwKG0Os4iFWCyMUsk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=p+o2EqLKUI2qu9sc9Pp6tqPzbdnRgQnkvyaDkNZZvNHuiylhSjhA7M9vxjtxztSSc
	 d1mgnZzCUyO/QjEPDuOXfXYqGM1qAckhDLChoEChmkDo437J1hZy0J5ipcdwaUruco
	 EQfA0ZElbshrQ3fpd63KA71sW0E4sLMbuqf7NI4ckQk1njLjYBnV3h4tv7f4vRI4+n
	 xzfZA0nd4mNZL+gW8rDKxEs0xPEP/bJj3VLjoyCaBkm0o2WtB+LsfzIgtyAucY43mX
	 31M3iqaGSMbGE6tcgNJiQcYOQRZi0Q83PaUVlHjix5TnlxSyA+HlkkcZ4ppoxp7c3U
	 p5Q02FRWGpsrQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
	Adam Ford <aford173@gmail.com>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	dafna@fastmail.com,
	heiko@sntech.de,
	linux-media@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 5.15 18/35] media: rkisp1: Drop IRQF_SHARED
Date: Mon, 22 Jan 2024 10:12:15 -0500
Message-ID: <20240122151302.995456-18-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122151302.995456-1-sashal@kernel.org>
References: <20240122151302.995456-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.147
Content-Transfer-Encoding: 8bit

From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>

[ Upstream commit 85d2a31fe4d9be1555f621ead7a520d8791e0f74 ]

In all known platforms the ISP has dedicated IRQ lines, but for some
reason the driver uses IRQF_SHARED.

Supporting IRQF_SHARED properly requires handling interrupts even when
our device is disabled, and the driver does not handle this. To avoid
adding such code, and to be sure the driver won't accidentally be used
in a platform with shared interrupts, let's drop the IRQF_SHARED flag.

Link: https://lore.kernel.org/r/20231207-rkisp-irq-fix-v3-1-358a2c871a3c@ideasonboard.com

Tested-by: Adam Ford <aford173@gmail.com>  #imx8mp-beacon
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/platform/rockchip/rkisp1/rkisp1-dev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/rockchip/rkisp1/rkisp1-dev.c b/drivers/media/platform/rockchip/rkisp1/rkisp1-dev.c
index 560f928c3752..036458542627 100644
--- a/drivers/media/platform/rockchip/rkisp1/rkisp1-dev.c
+++ b/drivers/media/platform/rockchip/rkisp1/rkisp1-dev.c
@@ -482,7 +482,7 @@ static int rkisp1_probe(struct platform_device *pdev)
 	if (irq < 0)
 		return irq;
 
-	ret = devm_request_irq(dev, irq, rkisp1_isr, IRQF_SHARED,
+	ret = devm_request_irq(dev, irq, rkisp1_isr, 0,
 			       dev_driver_string(dev), dev);
 	if (ret) {
 		dev_err(dev, "request irq failed: %d\n", ret);
-- 
2.43.0



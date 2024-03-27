Return-Path: <linux-kernel+bounces-121748-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EB7E88ED39
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 18:54:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7827295068
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 17:54:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABB70154C05;
	Wed, 27 Mar 2024 17:47:51 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F3FB1509AE;
	Wed, 27 Mar 2024 17:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711561671; cv=none; b=YdoEvssdZNGvSmIwk93amOaS4d90h/aeKkk0jX75471Hxwckb63MWTm3uIzA+C/zp69xeQqIeoQUDCcCrBTu9usUK90V56eSWskIH0/dJUjb1ZbdnVmAL1w0IGkSnfqAjVAOFwJaC7E/IUVCkwuXfCLTP+DMVe4DVou/qtjoISI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711561671; c=relaxed/simple;
	bh=xjLWHNxPPqvtq4hDxG/01PcuOt2wyTvdwe2jE0ankYs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VrK+fX+K5zE3NG7rPK1UhV3EpD3I32kPC4CUrLm0zEk58v68LmXLfV/pkvF/rQYtXDWx1W3RByikQAMb1cDfWa/0lWpVugpkaHMZrpgpaGau6oB6gKbRL97R8qo5XFTSWUi6OiWzgrrCPSJ2azjuAJuqpTlsegEqPM0E6HYrdJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38F91C43390;
	Wed, 27 Mar 2024 17:47:48 +0000 (UTC)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Mark Brown <broonie@kernel.org>,
	Vladimir Oltean <olteanv@gmail.com>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 3/3] spi: fsl-dspi: drop driver owner assignment
Date: Wed, 27 Mar 2024 18:47:37 +0100
Message-Id: <20240327174737.519637-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240327174737.519637-1-krzysztof.kozlowski@linaro.org>
References: <20240327174737.519637-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Core in platform_driver_register() already sets the .owner, so driver
does not need to.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/spi/spi-fsl-dspi.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index 38defdcf9370..0a2730cd07c6 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -1458,7 +1458,6 @@ static void dspi_shutdown(struct platform_device *pdev)
 static struct platform_driver fsl_dspi_driver = {
 	.driver.name		= DRIVER_NAME,
 	.driver.of_match_table	= fsl_dspi_dt_ids,
-	.driver.owner		= THIS_MODULE,
 	.driver.pm		= &dspi_pm,
 	.probe			= dspi_probe,
 	.remove_new		= dspi_remove,
-- 
2.34.1



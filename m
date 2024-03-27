Return-Path: <linux-kernel+bounces-121747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 98E4188ED36
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 18:54:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA7141C32275
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 17:54:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68476154BE3;
	Wed, 27 Mar 2024 17:47:49 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F25B71514C7;
	Wed, 27 Mar 2024 17:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711561669; cv=none; b=Tu7hn+Q3MOhq4edvTsCz26/Gr5OBc88B+h5eS+wfJSE3tP//M38K9l2IOYb5ePIgcXm+hMR/G24Wy+uXYJKfJ/rr327dmqp+2AHjJ1DxxrDRx/+qWh3QlniST/LNmHTQ+Z15VjSMd+ogoFtMQrARv1xxtTkKD5DXqiyI77z4x+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711561669; c=relaxed/simple;
	bh=WeQzKgxc8dKZiZ+6T0aVNEq+iwBGVNSfWWV2RgoHaPk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qbpc+T3wnFJ9XXLiAxHxTRnFanuyUcuiyEIqGTlJiscWgnAbQgeviRIwDG0bB7bFH92iRAISsbn8AaVRo8/GDb5b6sK3wQlAwIjDMXRhUw9IPN3VXbGInJZHW1uFBPv/l0J8trmFY3FfJ0QIjBSnaQzeHtFWQMFpvVQTK/AdhJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41E8CC43390;
	Wed, 27 Mar 2024 17:47:45 +0000 (UTC)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Mark Brown <broonie@kernel.org>,
	Vladimir Oltean <olteanv@gmail.com>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 2/3] spi: coldfire-qspi: drop driver owner assignment
Date: Wed, 27 Mar 2024 18:47:36 +0100
Message-Id: <20240327174737.519637-2-krzysztof.kozlowski@linaro.org>
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
 drivers/spi/spi-coldfire-qspi.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/spi/spi-coldfire-qspi.c b/drivers/spi/spi-coldfire-qspi.c
index b341b6908df0..e83cd0510f20 100644
--- a/drivers/spi/spi-coldfire-qspi.c
+++ b/drivers/spi/spi-coldfire-qspi.c
@@ -500,7 +500,6 @@ static const struct dev_pm_ops mcfqspi_pm = {
 
 static struct platform_driver mcfqspi_driver = {
 	.driver.name	= DRIVER_NAME,
-	.driver.owner	= THIS_MODULE,
 	.driver.pm	= &mcfqspi_pm,
 	.probe		= mcfqspi_probe,
 	.remove_new	= mcfqspi_remove,
-- 
2.34.1



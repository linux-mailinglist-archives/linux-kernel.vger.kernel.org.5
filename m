Return-Path: <linux-kernel+bounces-121746-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9091088ED34
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 18:53:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C274B1C32289
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 17:53:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A1901514D9;
	Wed, 27 Mar 2024 17:47:45 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CC901514C7;
	Wed, 27 Mar 2024 17:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711561664; cv=none; b=mR4IwsWQ7uY3VWYQAajPDhix7ch9FMBiLla0Wp6HwBzODx6WIEkIY+/S/gHcPGBtA8GcMXv0OymjW+z/Ud48uqXmzxIpgzArbH1R5fctLQdqVa+7goGx8elBAs4nIBVCry4NIDBBHdPv9whm6JtgiuDAmbTgXuvFE+K2njIv7Tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711561664; c=relaxed/simple;
	bh=xP9FydB8xXIWXesRFSB+5DvWHbO9DhVvtGU1jGx3NU8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hZCKhfbn83TZpGx4frvHVQ0vDPiko4H98tiDzaKpFkPGnN4Bu0arJ1L5+tEvkNhq6FzoCwlh7KquET8MZrnzfYtWfIFIQBT4Ra+5rPL3W1sr7rgaijFMz8dsEqTmNI7rAwGTkLR3nZbfwnmsgcnV2KinnVjmoFcUjISF3y/aexk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 104F3C433F1;
	Wed, 27 Mar 2024 17:47:41 +0000 (UTC)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Mark Brown <broonie@kernel.org>,
	Vladimir Oltean <olteanv@gmail.com>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 1/3] spi: loopback-test: drop driver owner assignment
Date: Wed, 27 Mar 2024 18:47:35 +0100
Message-Id: <20240327174737.519637-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Core in spi_register_driver() already sets the .owner, so driver
does not need to.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/spi/spi-loopback-test.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/spi/spi-loopback-test.c b/drivers/spi/spi-loopback-test.c
index fee8893d2751..31a878d9458d 100644
--- a/drivers/spi/spi-loopback-test.c
+++ b/drivers/spi/spi-loopback-test.c
@@ -396,7 +396,6 @@ MODULE_DEVICE_TABLE(of, spi_loopback_test_of_match);
 static struct spi_driver spi_loopback_test_driver = {
 	.driver = {
 		.name = "spi-loopback-test",
-		.owner = THIS_MODULE,
 		.of_match_table = spi_loopback_test_of_match,
 	},
 	.probe = spi_loopback_test_probe,
-- 
2.34.1



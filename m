Return-Path: <linux-kernel+bounces-78717-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 87D5F8617BF
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 17:24:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 401B6282C2C
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 16:24:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D77CB133991;
	Fri, 23 Feb 2024 16:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dTIvL9xA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 249C912E1FC;
	Fri, 23 Feb 2024 16:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708705310; cv=none; b=kCaT2ZCeSis/XTV+BY0810a3lTlWR706gABmv3RAj+No9p9LYfd9WQXqtoc/Q3OxxkWGFssHlwiNiqWb/6AJWyCwtw2Nl2SgrLc4XWjpNBILHimX+prgO1EQqKfpS93lywYOd8XMZM8GMPnRgkkYtg/RK67NDcDmuNo6d2GB2lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708705310; c=relaxed/simple;
	bh=jbwiQKAcTZW+OF+UocDdv05N53uW5wLX6hkKOMBTcOM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jUzpBxmEe0bfPxFMpVdyH7pSLDtKzzHxaYpMHFq/IUtgZ+2BuBIMprOwnKU4a6YmQLBDere7dIoQDwrGk8PDGwDJOQm0FT0sgJtfxvckhGkc8ozPCRsRct/RFGyrT8sgVuE87Bjq0lnGCMQm3EZfDZIEGzF//ZyQPs3FMSqhOxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dTIvL9xA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65F04C43390;
	Fri, 23 Feb 2024 16:21:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708705309;
	bh=jbwiQKAcTZW+OF+UocDdv05N53uW5wLX6hkKOMBTcOM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dTIvL9xAKYzJdtJJl+Ix/2HOVcMOsQU7G28axnq7a+CL65sIgFuZsJIlluGUeIkWM
	 ZtpLCZJbcaMFmJgHNX3Whbu6pnP/3ophsAP2Y/82Mcnt6LfGUO7tcizXvVp4c2R5gA
	 OQ2DryRFGSfsQWLZfJJ/DtQKHuc/aQmswPsTnlwOac/5/fNaModp2T8DBy7QXgmmQ5
	 o/c4YRSGshfFBRoUHJh4MymSHJy1A4+qKa4d/h6E+RBTcJAyvPMEGlgfyVQS+PGq6A
	 4Auiq06PqG9UpocQ69cVdr1gKGBo/IKIrCs87IPysVAFEPURO14EbuIeSpAHz7yN4D
	 i7BtcwpSEjo4w==
From: Conor Dooley <conor@kernel.org>
To: linux@roeck-us.net
Cc: conor@kernel.org,
	Conor Dooley <conor.dooley@microchip.com>,
	Jean Delvare <jdelvare@suse.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Zev Weiss <zev@bewilderbeest.net>,
	Patrick Rudolph <patrick.rudolph@9elements.com>,
	Peter Yin <peteryin.openbmc@gmail.com>,
	Alexander Stein <alexander.stein@ew.tq-group.com>,
	linux-hwmon@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Naresh Solanki <naresh.solanki@9elements.com>
Subject: [PATCH v2 4/5] hwmon: (pmbus/lm25066) Use PMBUS_REGULATOR_ONE to declare regulator
Date: Fri, 23 Feb 2024 16:21:08 +0000
Message-ID: <20240223-player-buckskin-01405c5889c4@spud>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240223-moonrise-feminist-de59b9e1b3ba@spud>
References: <20240223-moonrise-feminist-de59b9e1b3ba@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=989; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=pvEzR+gA96CLf2ByeujTgLZ57PfkfC8+QPdFFNSWXgs=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDKk3jv7gz06I0cheuEdus3LXUs8VHOcbHY3E2+fbzz/8K MS5rnxSRykLgxgHg6yYIkvi7b4WqfV/XHY497yFmcPKBDKEgYtTACbCrMnI0DVRsNCUvTao7sf2 mos/klY288iwVgWHCPJfMjqwP1jtDMN/p2exUl/Z/R38lhRLrjlzI32jzbo/33cnSvKnz2Kom9H PAwA=
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit

From: Guenter Roeck <linux@roeck-us.net>

If a chip only provides a single regulator, it should be named 'vout'
and not 'vout0'. Declare regulator using PMBUS_REGULATOR_ONE() to make
that happen.

Cc: Conor Dooley <conor@kernel.org>
Cc: Naresh Solanki <naresh.solanki@9elements.com>
Cc: Zev Weiss <zev@bewilderbeest.net>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 drivers/hwmon/pmbus/lm25066.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/pmbus/lm25066.c b/drivers/hwmon/pmbus/lm25066.c
index 3a20df5a43ec..cfffa4cdc0df 100644
--- a/drivers/hwmon/pmbus/lm25066.c
+++ b/drivers/hwmon/pmbus/lm25066.c
@@ -437,7 +437,7 @@ static int lm25066_write_word_data(struct i2c_client *client, int page, int reg,
 
 #if IS_ENABLED(CONFIG_SENSORS_LM25066_REGULATOR)
 static const struct regulator_desc lm25066_reg_desc[] = {
-	PMBUS_REGULATOR("vout", 0),
+	PMBUS_REGULATOR_ONE("vout"),
 };
 #endif
 
-- 
2.43.0



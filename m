Return-Path: <linux-kernel+bounces-78352-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FAB3861250
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 14:11:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 041D31F230C4
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 13:11:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D841C7E77C;
	Fri, 23 Feb 2024 13:11:41 +0000 (UTC)
Received: from smtp-bc0e.mail.infomaniak.ch (smtp-bc0e.mail.infomaniak.ch [45.157.188.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C5B65DF00
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 13:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708693901; cv=none; b=L6wpV3D6mC/l7duemZ4lBIWYruV0IB4437wO2vMBGh2RT4d9I327f/NkQtPnPEj21HfBHnpnS3KLr0kvSftNa/ok9cu+oZ+IojPXQ+4TmUbY6zNsC2sd0oQTTlgW/X7JviYqLVAPm+59+/Ok0W0q9Qj104NhTkVQY8O2D5t/IcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708693901; c=relaxed/simple;
	bh=0EmZbA6Z/VNF5c7++YIeS8HzXck5oR/WMMWqA0pYtD0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qOCWM4Za/TNl2nck9LW2ri7Qyr8HQNAvPseeVLzHrOmLqZSd4MjbNb1Jlmtlaunw0BkepO/6/TCP9lXJRB9PQ4HgktiKWlvyoYWVMhinO9oOdcENyxwqrR1svPJXlD9nZMGBd1n2O4G+Rof9O1DZkcvUWg4eb2FFB0sIjbDWrHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0leil.net; spf=pass smtp.mailfrom=0leil.net; arc=none smtp.client-ip=45.157.188.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0leil.net
Received: from smtp-4-0001.mail.infomaniak.ch (unknown [10.7.10.108])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Th9Q03TwQzMs1Yf;
	Fri, 23 Feb 2024 14:11:36 +0100 (CET)
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4Th9Q005gGzbZW;
	Fri, 23 Feb 2024 14:11:35 +0100 (CET)
From: Quentin Schulz <foss+kernel@0leil.net>
Date: Fri, 23 Feb 2024 14:11:23 +0100
Subject: [PATCH 2/2] regulator: rk808: fix LDO range on RK806
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240223-rk806-regulator-ranges-v1-2-3904ab70d250@theobroma-systems.com>
References: <20240223-rk806-regulator-ranges-v1-0-3904ab70d250@theobroma-systems.com>
In-Reply-To: <20240223-rk806-regulator-ranges-v1-0-3904ab70d250@theobroma-systems.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Matti Vaittinen <mazziesaccount@gmail.com>, 
 shengfei Xu <xsf@rock-chips.com>, 
 Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: linux-kernel@vger.kernel.org, 
 Quentin Schulz <quentin.schulz@theobroma-systems.com>, 
 Quentin Schulz <foss+kernel@0leil.net>
X-Mailer: b4 0.13.0
X-Infomaniak-Routing: alpha

From: Quentin Schulz <quentin.schulz@theobroma-systems.com>

The linear ranges aren't really matching what they should be. Indeed,
the range is inclusive of the min value, so it makes sense the previous
range does NOT include the max step value representing the min value of
the range in question.

Since 3.4V is represented by the decimal value 232, the previous range
max step value should be 231 and not 232.

No expected change in behavior since 3.4V was mapped with step 232 from
the first range but is now mapped with step 232 from the second range.

While at it, remove the incorrect comment from the second range.

Fixes: f991a220a447 ("regulator: rk808: add rk806 support")
Cc: Quentin Schulz <foss+kernel@0leil.net>
Signed-off-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>
---
 drivers/regulator/rk808-regulator.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/regulator/rk808-regulator.c b/drivers/regulator/rk808-regulator.c
index bfab5468cc54..d89ae7f16d7a 100644
--- a/drivers/regulator/rk808-regulator.c
+++ b/drivers/regulator/rk808-regulator.c
@@ -1023,8 +1023,8 @@ static const struct linear_range rk806_buck_voltage_ranges[] = {
 };
 
 static const struct linear_range rk806_ldo_voltage_ranges[] = {
-	REGULATOR_LINEAR_RANGE(500000, 0, 232, 12500), /* 500mV ~ 3400mV */
-	REGULATOR_LINEAR_RANGE(3400000, 233, 255, 0), /* 500mV ~ 3400mV */
+	REGULATOR_LINEAR_RANGE(500000, 0, 231, 12500), /* 500mV ~ 3400mV */
+	REGULATOR_LINEAR_RANGE(3400000, 232, 255, 0),
 };
 
 static const struct regulator_desc rk806_reg[] = {

-- 
2.43.2



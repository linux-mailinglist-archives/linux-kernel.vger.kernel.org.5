Return-Path: <linux-kernel+bounces-78355-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 57949861254
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 14:12:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06D87282719
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 13:12:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B82B7F496;
	Fri, 23 Feb 2024 13:11:47 +0000 (UTC)
Received: from smtp-190a.mail.infomaniak.ch (smtp-190a.mail.infomaniak.ch [185.125.25.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE5F47E788
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 13:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708693906; cv=none; b=Wu1r3vlfaIt/wqkJx40mZlDcf141Ljey1tbgTO6OP9wxCpiiE8BFDG4gfMUT45Q5G9eP18jtpdyGCgHF9BcWyAn1JAKBGi8Ai5JP7UFkoTf17P+d9xHlEPw7nex4oQ6RY4VlTS6ZDyv4hO35L16JgDWxYbF0LEgrplXLdX+hfOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708693906; c=relaxed/simple;
	bh=reQj/nsF+RmKEtkFyH7pgxQDw40tPWvRL4LNlxg2m2s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CMHB2oAIc889taJCCEhHpLtAoAN0kMvkIFQP3AH0H9YF3AAHbwrxbviiwYF0axMlKFUtaF6EnyQt4ccmuh47YmiKPqWWZvWkYh8OzYLJpcBu+Ejq+DhBPQ2q2DjMtdLUuEfSFPgRFxxLmCQMyPLR+em4jQc/WFHDPvXkuDKGYfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0leil.net; spf=pass smtp.mailfrom=0leil.net; arc=none smtp.client-ip=185.125.25.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0leil.net
Received: from smtp-4-0001.mail.infomaniak.ch (unknown [10.7.10.108])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Th9Q00ClVzMqvPr;
	Fri, 23 Feb 2024 14:11:36 +0100 (CET)
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4Th9Pz1pwczb8Z;
	Fri, 23 Feb 2024 14:11:35 +0100 (CET)
From: Quentin Schulz <foss+kernel@0leil.net>
Date: Fri, 23 Feb 2024 14:11:22 +0100
Subject: [PATCH 1/2] regulator: rk808: fix buck range on RK806
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240223-rk806-regulator-ranges-v1-1-3904ab70d250@theobroma-systems.com>
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

Since 1.5V is represented by the decimal value 160, the previous range
max step value should be 159 and not 160. Similarly, 3.4V is represented
by the decimal value 236, so the previous range max value should be 235
and not 237.

The only change in behavior this makes is that this actually modeled
the ranges to map step with decimal value 237 with 3.65V instead of
3.4V (the max supported by the HW).

Fixes: f991a220a447 ("regulator: rk808: add rk806 support")
Cc: Quentin Schulz <foss+kernel@0leil.net>
Signed-off-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>
---
 drivers/regulator/rk808-regulator.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/regulator/rk808-regulator.c b/drivers/regulator/rk808-regulator.c
index e374fa6e5f28..bfab5468cc54 100644
--- a/drivers/regulator/rk808-regulator.c
+++ b/drivers/regulator/rk808-regulator.c
@@ -1017,9 +1017,9 @@ static const struct regulator_desc rk805_reg[] = {
 };
 
 static const struct linear_range rk806_buck_voltage_ranges[] = {
-	REGULATOR_LINEAR_RANGE(500000, 0, 160, 6250), /* 500mV ~ 1500mV */
-	REGULATOR_LINEAR_RANGE(1500000, 161, 237, 25000), /* 1500mV ~ 3400mV */
-	REGULATOR_LINEAR_RANGE(3400000, 238, 255, 0),
+	REGULATOR_LINEAR_RANGE(500000, 0, 159, 6250), /* 500mV ~ 1500mV */
+	REGULATOR_LINEAR_RANGE(1500000, 160, 235, 25000), /* 1500mV ~ 3400mV */
+	REGULATOR_LINEAR_RANGE(3400000, 236, 255, 0),
 };
 
 static const struct linear_range rk806_ldo_voltage_ranges[] = {

-- 
2.43.2



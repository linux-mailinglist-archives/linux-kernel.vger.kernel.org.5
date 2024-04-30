Return-Path: <linux-kernel+bounces-163732-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBA9C8B6EEF
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 11:59:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A5AD1C22980
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 09:59:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 452DB13D881;
	Tue, 30 Apr 2024 09:58:54 +0000 (UTC)
Received: from mg.richtek.com (mg.richtek.com [220.130.44.152])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3FCC128833
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 09:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.130.44.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714471133; cv=none; b=ZATor0FXauMj0ScIj7nhq60G8dntL4A8WzMAMMr9TLqGxiOwUhuI8F0vzD39I5xUbNkgzfW0YOGJKmSYEZS7hi1eBPj8kNArDNlIM0A9eYFbarnC4y8wmaUTdbd1fihDOhZPY+/UBLnwx+hw7kUEnuRpOBP1GamRsCxOgwr4rLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714471133; c=relaxed/simple;
	bh=aLW+hLhtsKefh2Nh1SYqXbYSstdwqst9ixv2hu0e2fg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HzF6hVdVxTFwkYyZmUrTYaHXD29rFi/ky8rVjH4o3AQqxDBj3uCYijca/cUwBSrk6+Tl/X9yh15HXxGcWvCUP1XXc71oHYYHQqk9hwTXEMlnZP3rimhtxHFsy8t0v+023wDZ8eysfzB/7n40LpTSHYTFD4Vclet7U0eM9qOjWO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=richtek.com; spf=pass smtp.mailfrom=richtek.com; arc=none smtp.client-ip=220.130.44.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=richtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=richtek.com
X-MailGates: (SIP:2,PASS,NONE)(compute_score:DELIVER,40,3)
Received: from 192.168.10.46
	by mg.richtek.com with MailGates ESMTPS Server V6.0(3367343:0:AUTH_RELAY)
	(envelope-from <alina_yu@richtek.com>)
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256/256); Tue, 30 Apr 2024 17:58:31 +0800 (CST)
Received: from ex4.rt.l (192.168.10.47) by ex3.rt.l (192.168.10.46) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 30 Apr
 2024 17:58:30 +0800
Received: from linuxcarl2.richtek.com (192.168.10.154) by ex4.rt.l
 (192.168.10.45) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 30 Apr 2024 17:58:30 +0800
From: Alina Yu <alina_yu@richtek.com>
To: <lgirdwood@gmail.com>, <broonie@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <alina_yu@richtek.com>,
	<johnny_lai@richtek.com>, <cy_huang@richtek.com>
Subject: [PATCH v2 3/4] regulator: rtq2208: Fix invalid memory access when devm_of_regulator_put_matches is called
Date: Tue, 30 Apr 2024 17:58:26 +0800
Message-ID: <a1e19b4026d7fea27526ba94c398500a3826b282.1714467553.git.alina_yu@richtek.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1714467553.git.alina_yu@richtek.com>
References: <cover.1714467553.git.alina_yu@richtek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

In this patch, a software bug has been fixed.
rtq2208_ldo_match is no longer a local variable.
It prevents invalid memory access when devm_of_regulator_put_matches
is called.

Signed-off-by: Alina Yu <alina_yu@richtek.com>
---
 drivers/regulator/rtq2208-regulator.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/drivers/regulator/rtq2208-regulator.c b/drivers/regulator/rtq2208-regulator.c
index 80a4d2f..97a97a4 100644
--- a/drivers/regulator/rtq2208-regulator.c
+++ b/drivers/regulator/rtq2208-regulator.c
@@ -246,6 +246,11 @@ static const unsigned int rtq2208_ldo_volt_table[] = {
 	3300000,
 };
 
+static struct of_regulator_match rtq2208_ldo_match[] = {
+	{.name = "ldo2", },
+	{.name = "ldo1", },
+};
+
 static unsigned int rtq2208_of_map_mode(unsigned int mode)
 {
 	switch (mode) {
@@ -340,8 +345,7 @@ static irqreturn_t rtq2208_irq_handler(int irqno, void *devid)
 	return IRQ_HANDLED;
 }
 
-static int rtq2208_of_get_ldo_dvs_ability(struct device *dev,
-					struct of_regulator_match *rtq2208_ldo_match, int n_fixed)
+static int rtq2208_of_get_ldo_dvs_ability(struct device *dev)
 {
 	struct device_node *np;
 	struct of_regulator_match *match;
@@ -356,14 +360,14 @@ static int rtq2208_of_get_ldo_dvs_ability(struct device *dev,
 	if (!np)
 		np = dev->of_node;
 
-	ret = of_regulator_match(dev, np, rtq2208_ldo_match, n_fixed);
+	ret = of_regulator_match(dev, np, rtq2208_ldo_match, ARRAY_SIZE(rtq2208_ldo_match));
 
 	of_node_put(np);
 
 	if (ret < 0)
 		return ret;
 
-	for (i = 0; i < n_fixed; i++) {
+	for (i = 0; i < ARRAY_SIZE(rtq2208_ldo_match); i++) {
 		match = rtq2208_ldo_match + i;
 		init_data = match->init_data;
 		desc = (struct regulator_desc *)match->desc;
@@ -413,8 +417,7 @@ static const struct linear_range rtq2208_vout_range[] = {
 	REGULATOR_LINEAR_RANGE(1310000, 181, 255, 10000),
 };
 
-static void rtq2208_init_regulator_desc(struct rtq2208_regulator_desc *rdesc, int mtp_sel,
-					int idx, struct of_regulator_match *rtq2208_ldo_match, int *ldo_idx)
+static void rtq2208_init_regulator_desc(struct rtq2208_regulator_desc *rdesc, int mtp_sel, int idx)
 {
 	struct regulator_desc *desc;
 	static const struct {
@@ -486,8 +489,7 @@ static void rtq2208_init_regulator_desc(struct rtq2208_regulator_desc *rdesc, in
 static int rtq2208_parse_regulator_dt_data(int n_regulator, const unsigned int *regulator_idx_table,
 		struct rtq2208_regulator_desc *rdesc[RTQ2208_LDO_MAX], struct device *dev)
 {
-	struct of_regulator_match rtq2208_ldo_match[2];
-	int mtp_sel, ret, i, idx, ldo_idx = 0;
+	int mtp_sel, i, idx, ret;
 
 	/* get mtp_sel0 or mtp_sel1 */
 	mtp_sel = device_property_read_bool(dev, "richtek,mtp-sel-high");
@@ -499,14 +501,14 @@ static int rtq2208_parse_regulator_dt_data(int n_regulator, const unsigned int *
 		if (!rdesc[i])
 			return -ENOMEM;
 
-		rtq2208_init_regulator_desc(rdesc[i], mtp_sel, idx, rtq2208_ldo_match, &ldo_idx);
+		rtq2208_init_regulator_desc(rdesc[i], mtp_sel, idx);
 
 		/* init ldo dvs ability */
 		if (idx >= RTQ2208_LDO2)
 			rtq2208_ldo_match[idx - RTQ2208_LDO2].desc = &rdesc[i]->desc;
 	}
 
-	ret = rtq2208_of_get_ldo_dvs_ability(dev, rtq2208_ldo_match, ldo_idx);
+	ret = rtq2208_of_get_ldo_dvs_ability(dev);
 	if (ret)
 		return dev_err_probe(dev, ret, "Failed to get ldo fixed_uV\n");
 
-- 
2.7.4



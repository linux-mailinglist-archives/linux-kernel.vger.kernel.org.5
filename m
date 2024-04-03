Return-Path: <linux-kernel+bounces-130564-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C44D78979FB
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 22:39:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80028287B5C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 20:39:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13A22157497;
	Wed,  3 Apr 2024 20:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="tL8k3L59"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82D00156F45;
	Wed,  3 Apr 2024 20:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712176625; cv=none; b=H9B3GxeZIqkmG+mCRzYU8dgD1vMkHx308zgtPLPTFMyiVllOYAbSD+M1ogst7BxZzdm0i4XHiaBiFgKQayBeckdTC2nU989kwTtWrRrWyoa6hzpjerZ4amKhbKEIIxDeE/zQ97ImmOoBayqlPAuwJzp7hkpsEN5U+2qclg1B8Ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712176625; c=relaxed/simple;
	bh=dd77OrNZL5J3wZAkMZdRnvSHJ1xLyAd8ySxxVnUvM9M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hlRghMeqyhlnPhD6O47uZ64mnFdK+qDchcR5+VyGxm25BFMpk/F374Urr54aolvgbf/h1CbjYhDM+cMpTzhbnuvZis+JmvNHsUg0r8kZZnwNuZrILSxISS4sdF9F08Cr6kII1lAEhuYQdx7Uplps+xVJCH4hDlti9NOaQ2s71VA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=tL8k3L59; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 433Kaewl076324;
	Wed, 3 Apr 2024 15:36:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1712176600;
	bh=6DEGN4nAIfd3RQhP5Fz/NRZUeXyTFS4FPVxxybZT31Y=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=tL8k3L59ZZ1D7VSEcLOL4NCYJmux4djtub4yGFuRjcY9tnfaNEwcLmGxJD+b8g2AI
	 umXjc9WX6QfPA9Vj5fqHhA5HuMZvi7Ob1DpErhNLWj4BYFA0fiNH9cgyPUP6tB41uS
	 0lqktePlPsiKlJK10bhfavwxwS+k1FAIw66GEag4=
Received: from DFLE110.ent.ti.com (dfle110.ent.ti.com [10.64.6.31])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 433KaecH115284
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 3 Apr 2024 15:36:40 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 3
 Apr 2024 15:36:40 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 3 Apr 2024 15:36:40 -0500
Received: from fllvsmtp8.itg.ti.com ([10.249.42.149])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 433KaYFx080324;
	Wed, 3 Apr 2024 15:36:40 -0500
From: Andrew Davis <afd@ti.com>
To: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>,
        Juerg Haefliger <juergh@proton.me>, Riku Voipio <riku.voipio@iki.fi>
CC: <linux-hwmon@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Andrew
 Davis <afd@ti.com>
Subject: [PATCH 18/31] hwmon: (lm95234) Remove use of i2c_match_id()
Date: Wed, 3 Apr 2024 15:36:20 -0500
Message-ID: <20240403203633.914389-19-afd@ti.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240403203633.914389-1-afd@ti.com>
References: <20240403203633.914389-1-afd@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

The function i2c_match_id() is used to fetch the matching ID from
the i2c_device_id table. This is often used to then retrieve the
matching driver_data. This can be done in one step with the helper
i2c_get_match_data().

This helper has a couple other benefits:
 * It doesn't need the i2c_device_id passed in so we do not need
   to have that forward declared, allowing us to remove those or
   move the i2c_device_id table down to its more natural spot
   with the other module info.
 * It also checks for device match data, which allows for OF and
   ACPI based probing. That means we do not have to manually check
   those first and can remove those checks.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 drivers/hwmon/lm95234.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/hwmon/lm95234.c b/drivers/hwmon/lm95234.c
index 67b9d7636ee42..be00a374632d3 100644
--- a/drivers/hwmon/lm95234.c
+++ b/drivers/hwmon/lm95234.c
@@ -677,10 +677,9 @@ static int lm95234_init_client(struct i2c_client *client)
 	return 0;
 }
 
-static const struct i2c_device_id lm95234_id[];
-
 static int lm95234_probe(struct i2c_client *client)
 {
+	enum chips type = (uintptr_t)i2c_get_match_data(client);
 	struct device *dev = &client->dev;
 	struct lm95234_data *data;
 	struct device *hwmon_dev;
@@ -699,7 +698,7 @@ static int lm95234_probe(struct i2c_client *client)
 		return err;
 
 	data->groups[0] = &lm95234_common_group;
-	if (i2c_match_id(lm95234_id, client)->driver_data == lm95234)
+	if (type == lm95234)
 		data->groups[1] = &lm95234_group;
 
 	hwmon_dev = devm_hwmon_device_register_with_groups(dev, client->name,
-- 
2.39.2



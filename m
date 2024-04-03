Return-Path: <linux-kernel+bounces-130574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDB55897A0F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 22:40:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 757C328C624
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 20:40:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A97B1586F7;
	Wed,  3 Apr 2024 20:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="V+1ThZhV"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 190F6157E94;
	Wed,  3 Apr 2024 20:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712176631; cv=none; b=Gte++P23FYfW+7+wR/jBM9NhNwSw8WFHzxhyJjETp2obS4k46iLl77PslYmEt0nc5vILL2dvMNp8BJVEb3fuXeCk5rP0seS1I9IIQw+xW0IzdWapvX08Iah/6PG1z8V806eyuUl4jVqKHcGZO8fSvnPPe+wOGeQGT7TJVs7yqEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712176631; c=relaxed/simple;
	bh=mmTedkf3Yxggn4Mjpl92QBl602HEnBhNNX9xKAhwius=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WfI5y2I76Y9pst5XPgPr6uip0Nw+HTmNSDgEw5wODFLekSBB9Mv2RICfSbUl61KUOS4L4D+kEaClJp1frP/JNTa6AZo6MWitncYS0mqT04KUOPtQPLdNsqqeIj/wECMVCD67FD3wCUIkgztmJuuOohWFJ763Lov13CzzTlgwr0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=V+1ThZhV; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 433Kai7o079603;
	Wed, 3 Apr 2024 15:36:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1712176604;
	bh=OXUYHMCPCR+ILoa5f5nPvFCmbq17Wv2VgNu98FPrtQQ=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=V+1ThZhV5XQwfj3vUaJQ2fSpYazdPXUZQt288WxrMHmefVrxlOuJGH0LPFqVANNuC
	 T9QliqvCgjVhRLxzpIG1eSlxkQz/oAIKMxBeySCzREjOOVjKq/mbS7TZVSc4V3N0/C
	 RlzzQ0qMWW+ms1n+O5p3HxNqVXi3GiNjmbO5g7gM=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 433Kais5000584
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 3 Apr 2024 15:36:44 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 3
 Apr 2024 15:36:44 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 3 Apr 2024 15:36:44 -0500
Received: from fllvsmtp8.itg.ti.com ([10.249.42.149])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 433KaYGC080324;
	Wed, 3 Apr 2024 15:36:44 -0500
From: Andrew Davis <afd@ti.com>
To: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>,
        Juerg Haefliger <juergh@proton.me>, Riku Voipio <riku.voipio@iki.fi>
CC: <linux-hwmon@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Andrew
 Davis <afd@ti.com>
Subject: [PATCH 31/31] hwmon: (w83795): Remove use of i2c_match_id()
Date: Wed, 3 Apr 2024 15:36:33 -0500
Message-ID: <20240403203633.914389-32-afd@ti.com>
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
 drivers/hwmon/w83795.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/hwmon/w83795.c b/drivers/hwmon/w83795.c
index c446e00db6586..5174db69db5e1 100644
--- a/drivers/hwmon/w83795.c
+++ b/drivers/hwmon/w83795.c
@@ -2134,8 +2134,6 @@ static void w83795_apply_temp_config(struct w83795_data *data, u8 config,
 	}
 }
 
-static const struct i2c_device_id w83795_id[];
-
 static int w83795_probe(struct i2c_client *client)
 {
 	int i;
@@ -2149,7 +2147,7 @@ static int w83795_probe(struct i2c_client *client)
 		return -ENOMEM;
 
 	i2c_set_clientdata(client, data);
-	data->chip_type = i2c_match_id(w83795_id, client)->driver_data;
+	data->chip_type = (uintptr_t)i2c_get_match_data(client);
 	data->bank = i2c_smbus_read_byte_data(client, W83795_REG_BANKSEL);
 	mutex_init(&data->update_lock);
 
-- 
2.39.2



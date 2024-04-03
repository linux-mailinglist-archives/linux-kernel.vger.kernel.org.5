Return-Path: <linux-kernel+bounces-130578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CDA02897A18
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 22:41:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87741287EEA
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 20:41:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BB5F158A3C;
	Wed,  3 Apr 2024 20:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="cIe/bl2b"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1B14158217;
	Wed,  3 Apr 2024 20:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712176632; cv=none; b=SvqLjT/9fK7fbctaO6nUTqyayegdMMqdSNXGVQ1i131+FYaEUDsQhCnQ9z0smLVs+D+hE/nzdLf+ttCIHhOSaGiR9NyDSjJ3mPc4+HYq9Tqp7Xt35SBlGn6tob6mxjvqZeNr46dNZEbEQ9k3XMzYl2/HrRPpUkHqrobepSEot/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712176632; c=relaxed/simple;
	bh=E9bFIR5SpjVV84IZy6kaVztu+KCin9Ht/6XEc9VQ12c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iurTk5tXNNtY9VJUgZfh/RR63UXGHNGDqgsVTDqG5mNljCuIccGOAiQwNt4eaDF2nnAuLEcw/D9Xh1CC2p8FFQmcCK5j27rjeUArNYjlcpGr4br9KH+oYnCt7ZiF9nl7yGlQ5FO/L2WYjeA5WTCl10av+VBbWMGvkhj9otlq6ZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=cIe/bl2b; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 433KadHv038541;
	Wed, 3 Apr 2024 15:36:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1712176599;
	bh=XVj71wD/7PWW0dpzaejTO7zWBmJkCbE64MGWBAT9sQc=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=cIe/bl2bZn7L2B2prAKiHdUXe4vP5h8Tw4ZtZBF7QtwkBUPtBiP78gB2E5DJFsl+Q
	 x6jvGmfTWU+TfUmZRF76rGcsAaozVXu+RW6On9jwNrojCj4HlcL2QT61aGPuRX7y8Y
	 x4xBA/f/+Ux93gaqpRfC/Bx8TlWfXlKv4Qn0VOFw=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 433KadKk052101
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 3 Apr 2024 15:36:39 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 3
 Apr 2024 15:36:39 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 3 Apr 2024 15:36:39 -0500
Received: from fllvsmtp8.itg.ti.com ([10.249.42.149])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 433KaYFt080324;
	Wed, 3 Apr 2024 15:36:39 -0500
From: Andrew Davis <afd@ti.com>
To: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>,
        Juerg Haefliger <juergh@proton.me>, Riku Voipio <riku.voipio@iki.fi>
CC: <linux-hwmon@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Andrew
 Davis <afd@ti.com>
Subject: [PATCH 14/31] hwmon: (lm78) Remove use of i2c_match_id()
Date: Wed, 3 Apr 2024 15:36:16 -0500
Message-ID: <20240403203633.914389-15-afd@ti.com>
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
 drivers/hwmon/lm78.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/hwmon/lm78.c b/drivers/hwmon/lm78.c
index b739c354311b0..8b53bb3120693 100644
--- a/drivers/hwmon/lm78.c
+++ b/drivers/hwmon/lm78.c
@@ -627,8 +627,6 @@ static int lm78_i2c_detect(struct i2c_client *client,
 	return -ENODEV;
 }
 
-static const struct i2c_device_id lm78_i2c_id[];
-
 static int lm78_i2c_probe(struct i2c_client *client)
 {
 	struct device *dev = &client->dev;
@@ -640,7 +638,7 @@ static int lm78_i2c_probe(struct i2c_client *client)
 		return -ENOMEM;
 
 	data->client = client;
-	data->type = i2c_match_id(lm78_i2c_id, client)->driver_data;
+	data->type = (uintptr_t)i2c_get_match_data(client);
 
 	/* Initialize the LM78 chip */
 	lm78_init_device(data);
-- 
2.39.2



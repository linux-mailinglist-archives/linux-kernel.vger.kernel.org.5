Return-Path: <linux-kernel+bounces-130586-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D22C6897A26
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 22:42:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7389BB2A8DE
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 20:42:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E58D115957F;
	Wed,  3 Apr 2024 20:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="MXQFFmnY"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E283158A1E;
	Wed,  3 Apr 2024 20:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712176636; cv=none; b=cpFfgpQDKmxtltPECW/vBxxn3FBY0MsHDyZGrfup5L33Wuf2/mfkIIG4kzI18ujMQXKUz/CRHEdhXvqLqNdIVdmsmyZblzYorWbBKlC6nkM/dWP/cdrGmr+g2ItoN96PosEE0uf3CKL7/zIAnf0HLWMZFWlcIbgT4ogy1CsStSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712176636; c=relaxed/simple;
	bh=fzyLAkMdkIrE2Q23ti0Q/YYONcNNwXtFsQNshTq6LZk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Es3GiZ58x5N26/a1aiU5zJHC9XsOOmqfMNTcJiP0T8ru2/5b2lD+nNzdeWZifMZoCApeQx5uwZDl3CczdUrW1CKyn+XDwtulfFSk+g8SfQem3vFkaOeHwapyPDv93Z/oxEZUEkVyHc7o0V/r7D0atq8fEDuykbYbisikQz+vvdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=MXQFFmnY; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 433Kai2g038561;
	Wed, 3 Apr 2024 15:36:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1712176604;
	bh=jE+XpwhEwJZiBSyUsuAdan5u7cm38Ho/3/4bJnKGkAc=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=MXQFFmnY+6FLfB+5fzw+jt1gKUjpj5NXrRlq3AIb+gc36CbadS1UD+6uSUBIr6fGH
	 ++DGdbblczRFeqRz0lHgbHb0x/y9yTwJrW3OHEy4q0HRcyQb9wLJsKzTG7loLfOg44
	 nLIP3oknAbYq1P38PaXHhCg5GTMgMIIl/vvwH8fk=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 433KaiFo052164
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 3 Apr 2024 15:36:44 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 3
 Apr 2024 15:36:43 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 3 Apr 2024 15:36:43 -0500
Received: from fllvsmtp8.itg.ti.com ([10.249.42.149])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 433KaYGA080324;
	Wed, 3 Apr 2024 15:36:43 -0500
From: Andrew Davis <afd@ti.com>
To: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>,
        Juerg Haefliger <juergh@proton.me>, Riku Voipio <riku.voipio@iki.fi>
CC: <linux-hwmon@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Andrew
 Davis <afd@ti.com>
Subject: [PATCH 29/31] hwmon: (tmp464) Remove use of i2c_match_id()
Date: Wed, 3 Apr 2024 15:36:31 -0500
Message-ID: <20240403203633.914389-30-afd@ti.com>
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
 drivers/hwmon/tmp464.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/hwmon/tmp464.c b/drivers/hwmon/tmp464.c
index f58ca4c6acb6e..3ee1137533d63 100644
--- a/drivers/hwmon/tmp464.c
+++ b/drivers/hwmon/tmp464.c
@@ -666,10 +666,7 @@ static int tmp464_probe(struct i2c_client *client)
 
 	mutex_init(&data->update_lock);
 
-	if (dev->of_node)
-		data->channels = (int)(unsigned long)of_device_get_match_data(&client->dev);
-	else
-		data->channels = i2c_match_id(tmp464_id, client)->driver_data;
+	data->channels = (int)(unsigned long)i2c_get_match_data(client);
 
 	data->regmap = devm_regmap_init_i2c(client, &tmp464_regmap_config);
 	if (IS_ERR(data->regmap))
-- 
2.39.2



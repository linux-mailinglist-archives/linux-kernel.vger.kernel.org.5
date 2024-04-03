Return-Path: <linux-kernel+bounces-130573-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 34F71897A0B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 22:40:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9C871F21678
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 20:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54ECA1586C8;
	Wed,  3 Apr 2024 20:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="J66E1eHM"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF003157E82;
	Wed,  3 Apr 2024 20:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712176630; cv=none; b=C8fuIVLU6fDWFxKyXakmycYZZT7bgpgtsYgf+pYpGq0v7MyJGeayQwcq1ZQGJkk/hSfuPmMKp4D+Ts72s8K5hRCEKIDiRou00Y/yxNyjN+N7EvdbJHH0KQ58QilEx7JlIMNbbU9KFEkH1RpDp5c5PcP3eX77sj9LAXOt3ahujSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712176630; c=relaxed/simple;
	bh=fXNWup7IqUtwG+h2QdV+4YHz275hWWLttyi3VSXmXvQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PcZT3YRosEPLSc7HVugvmPBrxfNDZK98oLnkU/+6VXqY7CxgE3niMW0cpY9tdDP++Fn7AR2Zsu1ul8XrMwM1KWDnTZyGKi5/J9aQrYMYeINkjjsNFld2LPO+E8VYy7gTogh4MKwkujq5ngAggjgI4sQtIvaqm4YX1RD1sanGfT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=J66E1eHM; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 433Kac01038536;
	Wed, 3 Apr 2024 15:36:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1712176598;
	bh=GhjMPqWjizYvmOhLZfcTimybIrBQOrbz030kml+/JwI=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=J66E1eHMaZweZm6W4HiKoIP6GODnXoJLAqoKyG3Hr5LF2OoAZuMZzeYr5SgoiJHGp
	 0ph4+aHM7I9vyZgVRT5KwFGQ6Kn2vWKcPv0E9+YQyBRJ3vXqSK6bLeo4XsIcRot0jv
	 OcqbAjMWU345NRgC1s8Le3A3h/BCgTJVTQLGk6+g=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 433KacQR115258
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 3 Apr 2024 15:36:38 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 3
 Apr 2024 15:36:38 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 3 Apr 2024 15:36:38 -0500
Received: from fllvsmtp8.itg.ti.com ([10.249.42.149])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 433KaYFp080324;
	Wed, 3 Apr 2024 15:36:37 -0500
From: Andrew Davis <afd@ti.com>
To: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>,
        Juerg Haefliger <juergh@proton.me>, Riku Voipio <riku.voipio@iki.fi>
CC: <linux-hwmon@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Andrew
 Davis <afd@ti.com>
Subject: [PATCH 10/31] hwmon: (fschmd) Remove use of i2c_match_id()
Date: Wed, 3 Apr 2024 15:36:12 -0500
Message-ID: <20240403203633.914389-11-afd@ti.com>
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
 drivers/hwmon/fschmd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/fschmd.c b/drivers/hwmon/fschmd.c
index b30512a705a79..1811f84d835ef 100644
--- a/drivers/hwmon/fschmd.c
+++ b/drivers/hwmon/fschmd.c
@@ -1087,7 +1087,7 @@ static int fschmd_probe(struct i2c_client *client)
 				"Heracles", "Heimdall", "Hades", "Syleus" };
 	static const int watchdog_minors[] = { WATCHDOG_MINOR, 212, 213, 214, 215 };
 	int i, err;
-	enum chips kind = i2c_match_id(fschmd_id, client)->driver_data;
+	enum chips kind = (uintptr_t)i2c_get_match_data(client);
 
 	data = kzalloc(sizeof(struct fschmd_data), GFP_KERNEL);
 	if (!data)
-- 
2.39.2



Return-Path: <linux-kernel+bounces-130572-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A3101897A0C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 22:40:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D39411C22F2A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 20:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57C6B1586CA;
	Wed,  3 Apr 2024 20:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="CJEheemc"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 930CE15667F;
	Wed,  3 Apr 2024 20:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712176630; cv=none; b=G70pC2ax7IBcRnx4q8MxY+f9B9fKPjUZLFzGE02McT212oxE+vTwaXnJ8FEY4RulEt0ls0hZ8ltuxDtlMPyFcQ/8MsQ/lbukL46JqwR4qJw8tji4HYyUBY+o1Agw/g8HWPcVJLIa26Ad3LYfl5SqFuIuHzDh6n7qlRn/3wbozoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712176630; c=relaxed/simple;
	bh=EE3a8uO56b5AjvgZkW4+i7o39kuxOHrCqwj/XV5bbCA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y9OzM9jXj49T6T50yP0vtUxm5/7DvHxhzbzWFCuM9Ca+ktwGTkLgqwWRXSdrVVnbYEDKhAe0bbVbANFlQIrawndiPIhrj49N/SrxpTD1C3MjjOfuGkYs150nm9PzyzOLs95MGbp6HGseAiOwgwIoyb85mqvAqZ2lxbOBTVxstk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=CJEheemc; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 433Kadpf079578;
	Wed, 3 Apr 2024 15:36:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1712176599;
	bh=dVdAD6dEacyKbRyPVKVduhBCWH1pxa9uMiYmpMWe6uo=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=CJEheemcRjPis+CZMhVuwBBAQmV4QPkV9z+tRv7vg2a8DwmrEwa3EqsHuFAQF4/2Q
	 ZgaPoJSRdYnLhEMQjzyp0P73sXAQPy0EAGusC5YO01Rrok51SMUgc0XTYRGL9WBnap
	 8RR63+2lyN4Ly8eCwj+SSGM8RW71YZgiQvKvQHKI=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 433Kad2R052095
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 3 Apr 2024 15:36:39 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 3
 Apr 2024 15:36:38 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 3 Apr 2024 15:36:38 -0500
Received: from fllvsmtp8.itg.ti.com ([10.249.42.149])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 433KaYFr080324;
	Wed, 3 Apr 2024 15:36:38 -0500
From: Andrew Davis <afd@ti.com>
To: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>,
        Juerg Haefliger <juergh@proton.me>, Riku Voipio <riku.voipio@iki.fi>
CC: <linux-hwmon@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Andrew
 Davis <afd@ti.com>
Subject: [PATCH 12/31] hwmon: (lm63) Remove use of i2c_match_id()
Date: Wed, 3 Apr 2024 15:36:14 -0500
Message-ID: <20240403203633.914389-13-afd@ti.com>
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
 drivers/hwmon/lm63.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/hwmon/lm63.c b/drivers/hwmon/lm63.c
index 0878a044dd8ef..035176a98ce9c 100644
--- a/drivers/hwmon/lm63.c
+++ b/drivers/hwmon/lm63.c
@@ -1104,10 +1104,7 @@ static int lm63_probe(struct i2c_client *client)
 	mutex_init(&data->update_lock);
 
 	/* Set the device type */
-	if (client->dev.of_node)
-		data->kind = (uintptr_t)of_device_get_match_data(&client->dev);
-	else
-		data->kind = i2c_match_id(lm63_id, client)->driver_data;
+	data->kind = (uintptr_t)i2c_get_match_data(client);
 	if (data->kind == lm64)
 		data->temp2_offset = 16000;
 
-- 
2.39.2



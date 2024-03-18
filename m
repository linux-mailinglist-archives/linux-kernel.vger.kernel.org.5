Return-Path: <linux-kernel+bounces-105730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2088187E391
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 07:07:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9BCCAB202EC
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 06:07:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AB7022337;
	Mon, 18 Mar 2024 06:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ZC4ig9+P"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B0CD2206B;
	Mon, 18 Mar 2024 06:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710742010; cv=none; b=RDCHiXgiaPUZdXleXz8PSNz/1NwDcKctz358rAB91BgfPdGSN7X3nUS7sNXZz1KXiNsk6YjLQb5QlTxcQr5lJUyYKq4fRK6uokDWJCSMGXmQZM4QUdbuxnzId+TOvyqRP3Yek5PqTBaflAFjw5d2Ld/BblXsiNxMo02X7iOh8ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710742010; c=relaxed/simple;
	bh=3m20nb+0fwc41U7YJQ9XAzJmFBzXIOodTQ3VpSG1EFc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jnqlmDGITTCjyA01NcfGOUD740529/R0Y23wWRz97Lz2TZJ6qI9tx4thWDC4J4ts/RGw8Z5Y6C188+wufhSaEQjwKnaeVHlKXTsDl4YodwkW8HkzXBbbhhkhhf6yW7rMqOrc5NE8gqd+xskOlVuIUoccJukK64zPY1Vq6gEerT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=ZC4ig9+P; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 42I5te7v053540;
	Mon, 18 Mar 2024 00:55:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1710741340;
	bh=dBZehhRkwqiGdVM7akbnBQ3ei6Ss2qkowGyOhsxBVUY=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=ZC4ig9+PieoM6nGPOI5B8WHPapayBcSHh6QUEua2Pb8luGMyec0EQsWN1ns0Om5LM
	 sZn5gD3Ryj5TWg5HJ0wAIsyd55/QdnWN7DbE4AjAv5xHLP1nOqGI9m6CX48cfWoA5o
	 OR8CUXCWN7/0iCNzsF1TbQeFe6gDNsqZOC0RZxAA=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 42I5ter6027858
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 18 Mar 2024 00:55:40 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 18
 Mar 2024 00:55:39 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 18 Mar 2024 00:55:39 -0500
Received: from dhruva.dhcp.ti.com (dhruva.dhcp.ti.com [172.24.227.68])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 42I5tKiG082113;
	Mon, 18 Mar 2024 00:55:36 -0500
From: Dhruva Gole <d-gole@ti.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J. Wysocki"
	<rafael@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>
CC: Tony Lindgren <tony@atomide.com>, Len Brown <len.brown@intel.com>,
        Pavel
 Machek <pavel@ucw.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Viresh Kumar <viresh.kumar@linaro.org>, <theo.lebrun@bootlin.com>,
        Dhruva
 Gole <d-gole@ti.com>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mmc@vger.kernel.org>
Subject: [PATCH 2/3] PM: wakeup: Remove unnecessary else from device_init_wakeup
Date: Mon, 18 Mar 2024 11:20:53 +0530
Message-ID: <20240318055054.1564696-3-d-gole@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240318055054.1564696-1-d-gole@ti.com>
References: <20240318055054.1564696-1-d-gole@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Checkpatch warns that else is generally not necessary after a return
condition which exists in the if part of this function. Hence, just to
abide by what checkpatch recommends, follow it's guidelines.

Signed-off-by: Dhruva Gole <d-gole@ti.com>
---
 include/linux/pm_wakeup.h | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/include/linux/pm_wakeup.h b/include/linux/pm_wakeup.h
index 428803eed798..76cd1f9f1365 100644
--- a/include/linux/pm_wakeup.h
+++ b/include/linux/pm_wakeup.h
@@ -234,11 +234,10 @@ static inline int device_init_wakeup(struct device *dev, bool enable)
 	if (enable) {
 		device_set_wakeup_capable(dev, true);
 		return device_wakeup_enable(dev);
-	} else {
-		device_wakeup_disable(dev);
-		device_set_wakeup_capable(dev, false);
-		return 0;
 	}
+	device_wakeup_disable(dev);
+	device_set_wakeup_capable(dev, false);
+	return 0;
 }
 
 #endif /* _LINUX_PM_WAKEUP_H */
-- 
2.34.1



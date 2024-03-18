Return-Path: <linux-kernel+bounces-106283-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C54E87EBE7
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 16:19:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCE67283FF1
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 15:19:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49E534F206;
	Mon, 18 Mar 2024 15:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="kLV6nTZu"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6C3352F62;
	Mon, 18 Mar 2024 15:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710775082; cv=none; b=Wz3Jzt8xnKGKuyhWlaEqZMTFcRN7r/fjeTK+xs1ggyiWGycAy89gZYbvlMtGynwF2mlpj5ywcoT0KHrPiEZp+NgGiTXlor0Wm7WOu+9EnEWefokevuIf2wu5W4D4jP/1KUh1Mn7DPwAKLm5PA17+3qar5qrwJP1/ObshvNWwwbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710775082; c=relaxed/simple;
	bh=3m20nb+0fwc41U7YJQ9XAzJmFBzXIOodTQ3VpSG1EFc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sBAefLi3mVVpKBRUTitld6oAjrcUSoahz8H839OFfG2Zrmb8RpkLVsA2MXPS/wI+YcGFI4XW6h3/s9OjNYvZGRfTD2oVHrgU0j+rjrN3+KG7J9RZW2dwHlGIqRpSEZ1Bs5m6fI7RSNJlOfIhm+tgN8vMkXgzx+F/Nqb4Z+2Ydl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=kLV6nTZu; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 42IFHgCt094553;
	Mon, 18 Mar 2024 10:17:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1710775062;
	bh=dBZehhRkwqiGdVM7akbnBQ3ei6Ss2qkowGyOhsxBVUY=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=kLV6nTZuZ7rOrkBYm95SViN4U2pn2qO8IjKLfdXRpoaKCfwUPPEFsBMmSf4qXnUQU
	 4kdT30QN9R6qCNnhGAgTOK9hXV7qkUmTAPgLepCYu3819agO0IY3mF2oCSsdV/UlD8
	 kWN4vIr/h74Rva165jjxpL2UYfPHP7sLmcuDjGbE=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 42IFHgme111710
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 18 Mar 2024 10:17:42 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 18
 Mar 2024 10:17:42 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 18 Mar 2024 10:17:42 -0500
Received: from dhruva.dhcp.ti.com (dhruva.dhcp.ti.com [172.24.227.68])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 42IFH8GT095329;
	Mon, 18 Mar 2024 10:17:39 -0500
From: Dhruva Gole <d-gole@ti.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>
CC: Tony Lindgren <tony@atomide.com>, Len Brown <len.brown@intel.com>,
        Pavel
 Machek <pavel@ucw.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Viresh Kumar <viresh.kumar@linaro.org>, <theo.lebrun@bootlin.com>,
        Dhruva
 Gole <d-gole@ti.com>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mmc@vger.kernel.org>
Subject: [PATCH V2 2/2] PM: wakeup: Remove unnecessary else from device_init_wakeup
Date: Mon, 18 Mar 2024 20:46:33 +0530
Message-ID: <20240318151631.1621881-3-d-gole@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240318151631.1621881-1-d-gole@ti.com>
References: <20240318151631.1621881-1-d-gole@ti.com>
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



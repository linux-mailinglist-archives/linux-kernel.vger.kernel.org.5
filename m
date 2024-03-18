Return-Path: <linux-kernel+bounces-105731-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD5D787E394
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 07:07:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E18DB20BFC
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 06:07:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8661522F02;
	Mon, 18 Mar 2024 06:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="eyXT3Kgj"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 215CC2231A;
	Mon, 18 Mar 2024 06:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710742012; cv=none; b=PWAIrCaObAcmhHjCG5z8MEsO+dHvuxFj/Vdbjjhvb0IxyLhfS81tjQ/dE/q+l2BjvhkgEq5m2J8FMcrZU6GaxGCTGLxDZ6Z5q8LbPYWaO+x+qhLtJ7pwBfEhfo2DIifZ3rzlxgOaZgLRGX9ofm0TJLNOoiR7Vo5DkpkuRM2EgTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710742012; c=relaxed/simple;
	bh=/8870Dm7p0rzChEjvnJzeI0cna0UOQm4+Lk6NWHpQ4w=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jsDffqke07ZT3Z3SJq3D3cBeJfYK0Frcu7rqLQA1ixKkRhLAD5GkFrjrHUeHE6mvkv5qdffGZGUTf1Hy7bTYRyokZl0l6+u9B4wxTNVMZOZFUGsWs6dqX0jHvk5fdGmioAB7H0Kh2vwwd8+yd6ni0AUCR+2/Vc28w95e0MQCBQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=eyXT3Kgj; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 42I5tjdm053565;
	Mon, 18 Mar 2024 00:55:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1710741345;
	bh=ZnWHo1ylR1YM6vl9GkHOqIy0gOs+L02Pz8cQsQr87ao=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=eyXT3KgjturL8Km09bHGM9ezo7KnEBaoezEJ0Jo7OH5z+LPxmT++bxf91VRHPw4VW
	 mVzTL7oWoGdvHOrHUhYb7YLDnc0xYJt3e+JxN7v+OT3l/cI6n3iCA4WX54MosAt/1x
	 S0bQIDCqevLWHIIMB5uJgeSRjkDU4+8MFFsaNOBs=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 42I5tjIt086260
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 18 Mar 2024 00:55:45 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 18
 Mar 2024 00:55:45 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 18 Mar 2024 00:55:45 -0500
Received: from dhruva.dhcp.ti.com (dhruva.dhcp.ti.com [172.24.227.68])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 42I5tKiH082113;
	Mon, 18 Mar 2024 00:55:41 -0500
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
Subject: [PATCH 3/3] mmc: sdhci-pci: Use device_set_wakeup_enable for en/disable wakeups
Date: Mon, 18 Mar 2024 11:20:54 +0530
Message-ID: <20240318055054.1564696-4-d-gole@ti.com>
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

There exists device_set_wakeup_enable for wrapping device_wakeup_enable
and device_wakeup_disable. Use that instead to avoid confusion in
returning from a void vs int function.

Signed-off-by: Dhruva Gole <d-gole@ti.com>
---

I do not have the hardware to test out this driver, hence requesting
someone to review/ test it if atall you suspect that this change can
break existing functionality.

 drivers/mmc/host/sdhci-pci-core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
index 025b31aa712c..db614389a5fc 100644
--- a/drivers/mmc/host/sdhci-pci-core.c
+++ b/drivers/mmc/host/sdhci-pci-core.c
@@ -61,9 +61,9 @@ static int sdhci_pci_init_wakeup(struct sdhci_pci_chip *chip)
 	}
 
 	if ((pm_flags & MMC_PM_KEEP_POWER) && (pm_flags & MMC_PM_WAKE_SDIO_IRQ))
-		return device_wakeup_enable(&chip->pdev->dev);
+		return device_set_wakeup_enable(&chip->pdev->dev, true);
 	else if (!cap_cd_wake)
-		return device_wakeup_disable(&chip->pdev->dev);
+		return device_set_wakeup_enable(&chip->pdev->dev, false);
 
 	return 0;
 }
-- 
2.34.1



Return-Path: <linux-kernel+bounces-102954-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B02B87B8FD
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 08:56:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4CF41F21521
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 07:56:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 224865D47F;
	Thu, 14 Mar 2024 07:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="PSs45KsS"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDEF95CDD0;
	Thu, 14 Mar 2024 07:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710402961; cv=none; b=CTTlMGuDICfyFoSMfqDesOs4FIwA6A7ES9V1ZrQWZKY+ew89mCOu+uwnFdzlk81UlTPNwfAhhk+rVmnb4yQhupctBIhFEF0e91HK0lNZHmaCnwFBzQLNsutUA1kKsrhZr7y6Oq2DPpTuQ6JU3IAtWTpFvF9eaYU4rPASYSvn/yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710402961; c=relaxed/simple;
	bh=+gCNw/gViVCA4efaztjNveTgU74u33JPDfPh4UoRLWY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=iZinvHcxgk1ueNmepBNc0AdHdzT3GSyBccyLikggYgz5Mt17sNJ/HlrQfR7IT/zTiM4Iqlc8zoEt57rdqmfq7YjLRtKqZp5iP90svscl//LRBYugStK3E4JUCwIuQw9uU4zYB5dujUzNknMJxNNCq8ig6H6E6pfAqax9ulJqVJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=PSs45KsS; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 42E7tnpA073082;
	Thu, 14 Mar 2024 02:55:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1710402949;
	bh=2zejXuullfxzo5V55VCYT5B8ajO6/eBhyQJAMGV39No=;
	h=From:To:CC:Subject:Date;
	b=PSs45KsSNTb4r/V0Y/otu/98Dn4rxaZLbcw49OAZX0Dz9HVXk3ex6akI6+UG3uFbz
	 z6ErwpdG0WVdZq8iReDgKRKHDzt3AMCFV87L2GzGIBQU60D2iyMwa2821SH7MCmSm0
	 nvPbIQ0GsmKQ3E1RKTIZ/vljh+ui5slPf15UNZ1g=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 42E7tnEM114984
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 14 Mar 2024 02:55:49 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 14
 Mar 2024 02:55:49 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 14 Mar 2024 02:55:49 -0500
Received: from dhruva.dhcp.ti.com (dhruva.dhcp.ti.com [172.24.227.68])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 42E7tj9B029562;
	Thu, 14 Mar 2024 02:55:46 -0500
From: Dhruva Gole <d-gole@ti.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
CC: Tony Lindgren <tony@atomide.com>, <theo.lebrun@bootlin.com>,
        Sibi Sankar
	<quic_sibis@quicinc.com>,
        Viresh Kumar <viresh.kumar@linaro.org>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Dhruva Gole
	<d-gole@ti.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH] PM: wakeup: Add a missing return case in init_wakeup
Date: Thu, 14 Mar 2024 13:24:30 +0530
Message-ID: <20240314075429.1164810-1-d-gole@ti.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

The device_wakeup_disable call can return an error if no dev exists
however this was being ignored. Catch this return value and propagate it
onward in device_init_wakeup.

Signed-off-by: Dhruva Gole <d-gole@ti.com>
---
 include/linux/pm_wakeup.h | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/include/linux/pm_wakeup.h b/include/linux/pm_wakeup.h
index 6eb9adaef52b..64c7db35e693 100644
--- a/include/linux/pm_wakeup.h
+++ b/include/linux/pm_wakeup.h
@@ -232,14 +232,15 @@ static inline void pm_wakeup_hard_event(struct device *dev)
  */
 static inline int device_init_wakeup(struct device *dev, bool enable)
 {
+	int ret;
 	if (enable) {
 		device_set_wakeup_capable(dev, true);
-		return device_wakeup_enable(dev);
+		ret = device_wakeup_enable(dev);
 	} else {
-		device_wakeup_disable(dev);
+		ret = device_wakeup_disable(dev);
 		device_set_wakeup_capable(dev, false);
-		return 0;
 	}
+	return ret;
 }
 
 #endif /* _LINUX_PM_WAKEUP_H */

base-commit: 9bb9b28d0568991b1d63e66fe75afa5f97ad1156
-- 
2.34.1



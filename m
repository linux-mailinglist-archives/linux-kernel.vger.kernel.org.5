Return-Path: <linux-kernel+bounces-35658-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B61F28394E6
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 17:38:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6622A1F29074
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 16:38:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FB4880042;
	Tue, 23 Jan 2024 16:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="V5Zeaq+W"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C49487FBA9;
	Tue, 23 Jan 2024 16:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706027825; cv=none; b=qIyq+a8vRJq7JY40EXciq4cYeDZd2fsxeyeepNq1C+AQALEiTpElLUgY4pYr+lbsaOoP8+LHRT07SrnhlmM7wMZciHaBGs4bJkduLXZa5hT4OPT0SXd8yjWJ6swWULVTCKfAb6V7mVH4w6npiGae/3kZmcXo5h3g0S5XdzLwZmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706027825; c=relaxed/simple;
	bh=pWH8NAHtrCvFVSYAPVsf9lKe7zVZF7vWQZ1xReqHAuY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=AQ84sQhtPJYqNoMslH2dP/qsQqrHwHyg+/qHGoh0I3u3kgqMLEpTqUTtmY976Ml1mJ1sq8eLBfdIt4YEkn1PdUumHJqIxJwPOqy5zLcSkEkriN550Y2XhjTSE+vZNUa7xefKZ7bLlng3lSyhwXOZ1jQbdbiXPL4xrxPVL7DxqJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=V5Zeaq+W; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40NGasLk077073;
	Tue, 23 Jan 2024 10:36:54 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1706027814;
	bh=q7pRp5x0RG+L6or32Q9nmMCN27zczX+N7SM2pF7W3VM=;
	h=From:To:CC:Subject:Date;
	b=V5Zeaq+WPMJp9Zw0v/NXFVWhBsUpMgB0ankkefCZPSaH5bKFd156fx3V2SYT/9v/4
	 /f2ckNyaCkNIAxuJ2PA5pIlxZeN8HI963n5y3HLyXit7jKIWkuNtn8Ea9v9jslLRvS
	 AfOvNsoOjqYdf0jEFKwIhydGWeamoblA5Ph5C79I=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40NGasnq000545
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 23 Jan 2024 10:36:54 -0600
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 23
 Jan 2024 10:36:54 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 23 Jan 2024 10:36:54 -0600
Received: from lelvsmtp6.itg.ti.com ([10.249.42.149])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40NGarrm123403;
	Tue, 23 Jan 2024 10:36:54 -0600
From: Andrew Davis <afd@ti.com>
To: Sebastian Reichel <sre@kernel.org>,
        Support Opensource
	<support.opensource@diasemi.com>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski@linaro.org>,
        =?UTF-8?q?Pali=20Roh=C3=A1r?=
	<pali@kernel.org>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Andrew Davis
	<afd@ti.com>
Subject: [PATCH 00/21] Power supply register with devm
Date: Tue, 23 Jan 2024 10:36:32 -0600
Message-ID: <20240123163653.384385-1-afd@ti.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hello all,

This is a semi-automated series converting several drivers
under power/supply over to using devm_power_supply_register().
The more trivial cases are first, the last 3 drivers needed
a little pre-work to convert their IIO uses over to devm before
power_supply_register() could be switched.

Thanks,
Andrew

Andrew Davis (21):
  power: supply: da9030: Use devm_power_supply_register() helper
  power: supply: da9052: Use devm_power_supply_register() helper
  power: supply: ds2760: Use devm_power_supply_register() helper
  power: supply: goldfish: Use devm_power_supply_register() helper
  power: supply: lp8727: Use devm_power_supply_register() helper
  power: supply: lp8788: Use devm_power_supply_register() helper
  power: supply: max14577: Use devm_power_supply_register() helper
  power: supply: max77693: Use devm_power_supply_register() helper
  power: supply: max8925: Use devm_power_supply_register() helper
  power: supply: pcf50633: Use devm_power_supply_register() helper
  power: supply: rt5033: Use devm_power_supply_register() helper
  power: supply: tps65090: Use devm_power_supply_register() helper
  power: supply: wm831x: Use devm_power_supply_register() helper
  power: supply: wm831x: Use devm_power_supply_register() helper
  power: supply: wm8350: Use devm_power_supply_register() helper
  power: supply: da9150: Use devm_iio_channel_get() helper
  power: supply: da9150: Use devm_power_supply_register() helper
  power: supply: rx51: Use devm_iio_channel_get() helper
  power: supply: rx51: Use devm_power_supply_register() helper
  power: supply: twl4030_madc: Use devm_iio_channel_get() helper
  power: supply: twl4030_madc: Use devm_power_supply_register() helper

 drivers/power/supply/da9030_battery.c       |  6 +-
 drivers/power/supply/da9052-battery.c       |  4 +-
 drivers/power/supply/da9150-charger.c       | 72 ++++++---------------
 drivers/power/supply/ds2760_battery.c       |  4 +-
 drivers/power/supply/goldfish_battery.c     | 24 ++-----
 drivers/power/supply/lp8727_charger.c       | 35 ++--------
 drivers/power/supply/lp8788-charger.c       | 21 ++----
 drivers/power/supply/max14577_charger.c     |  6 +-
 drivers/power/supply/max77693_charger.c     |  8 +--
 drivers/power/supply/max8925_power.c        | 36 +++--------
 drivers/power/supply/pcf50633-charger.c     | 23 +++----
 drivers/power/supply/rt5033_battery.c       | 14 +---
 drivers/power/supply/rx51_battery.c         | 57 ++++------------
 drivers/power/supply/tps65090-charger.c     | 18 ++----
 drivers/power/supply/twl4030_madc_battery.c | 59 ++++-------------
 drivers/power/supply/wm831x_backup.c        | 13 +---
 drivers/power/supply/wm831x_power.c         | 24 +++----
 drivers/power/supply/wm8350_power.c         | 29 ++-------
 18 files changed, 121 insertions(+), 332 deletions(-)

-- 
2.39.2



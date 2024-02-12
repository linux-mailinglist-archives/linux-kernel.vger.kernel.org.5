Return-Path: <linux-kernel+bounces-61957-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D515E851923
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 17:29:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B2DD1F222CD
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 16:29:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD1703D568;
	Mon, 12 Feb 2024 16:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="gkharXyj"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46BD63D0DD;
	Mon, 12 Feb 2024 16:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707755327; cv=none; b=S7r5ljifXVPow4nsFuD7vChH+4+vCa/dDTWhVXcahB5xzZt/Y33iCJENMB/l2h+GQMNjJSzy08JPLvGsllllS2lXCluYrutVh0b/n7D64JvFmlpkFEsW38l1f2aZeehoBJ3AOb886uFP3VZWaRKJNveUvfdXK1oMnAeOKmEeX9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707755327; c=relaxed/simple;
	bh=I2MpepqswomHCVb5FtmVYpczlffOVMKkP0FDjf0skWM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HHWjW8iXJOvTt5P6wou6b3aIBIRt8iqnn/HBQu40kRL6PCFhimnTCq0Lgv10MnvYYHxaX6SjewRKN3pDU4dZU9qrgmdOLglq8LFlFzSBXBzoY5NdkXNDPu0c4foF/iA9WOPAjEipq7LKda0jjs0OJ0e+qyz+Rpfmouo6sd5K7Uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=gkharXyj; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41CGSXeS045183;
	Mon, 12 Feb 2024 10:28:33 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1707755313;
	bh=zXYO7lK1k6ZbLMjJ3atq6vexiEb/Ht/2UM7FiDOlEBw=;
	h=From:To:CC:Subject:Date;
	b=gkharXyjdkRePbJdX8y5/s7In1GP+q0Lak59nwSfxcScDtvZML9ASF2/tkje/wPRv
	 Vo0rNqc2ec9rbBW2HLX35FNsXb7b22AJcBP0edi4pIwbTTR59Eu5jw0qya/4mXHlMk
	 nVUIZ4GNiULWS7hItIoG5lC8qAX7uPeAIfcg4SX8=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41CGSXwG008638
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 12 Feb 2024 10:28:33 -0600
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 12
 Feb 2024 10:28:33 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 12 Feb 2024 10:28:33 -0600
Received: from lelvsmtp5.itg.ti.com ([10.249.42.149])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41CGSWQu090688;
	Mon, 12 Feb 2024 10:28:32 -0600
From: Andrew Davis <afd@ti.com>
To: Sebastian Reichel <sre@kernel.org>,
        Manivannan Sadhasivam
	<manivannan.sadhasivam@linaro.org>,
        Cristian Ciocaltea
	<cristian.ciocaltea@gmail.com>,
        Florian Fainelli
	<florian.fainelli@broadcom.com>,
        Ray Jui <rjui@broadcom.com>, Scott Branden
	<sbranden@broadcom.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad
 Dybcio <konrad.dybcio@linaro.org>,
        Sean Wang <sean.wang@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-actions@lists.infradead.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, Andrew Davis <afd@ti.com>
Subject: [PATCH v4 00/19] Remove pm_power_off use in drivers/power/reset
Date: Mon, 12 Feb 2024 10:28:12 -0600
Message-ID: <20240212162831.67838-1-afd@ti.com>
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

Use of pm_power_off is considered legacy and should be replaced with
register_sys_off*(). Same for register_restart_handler(). Do this
for the drivers/power/reset subsystem for all trivial cases.

Thanks,
Andrew

Changes for v4:
 - Fix sparse warning in [12/19] and [13/19]
 - Move data allocate from [19/19] to [18/19]
 - Add review tags in patches [7/19] and [11/19]
 - Rebase on v6.8-rc4

Changes for v3:
 - Use dev_err_probe() in patch [11/19]
 - Add review tags in patches [18/19] and [19/19]

Changes for v2:
 - Fix sparse warning in 7/19 and 10/19
 - Add new patch fixing an already existing sparse warning (3/19)
 - Rebase on v6.8-rc3

Andrew Davis (19):
  power: reset: atc260x-poweroff: Use
    devm_register_sys_off_handler(RESTART)
  power: reset: atc260x-poweroff: Use
    devm_register_sys_off_handler(POWER_OFF)
  power: reset: xgene-reboot: Use devm_platform_ioremap_resource()
    helper
  power: reset: xgene-reboot: Use devm_register_sys_off_handler(RESTART)
  power: reset: tps65086-restart: Use
    devm_register_sys_off_handler(RESTART)
  power: reset: tps65086-restart: Remove unneeded device data struct
  power: reset: brcm-kona-reset: Use
    devm_register_sys_off_handler(RESTART)
  power: reset: axxia-reset: Use devm_register_sys_off_handler(RESTART)
  power: reset: rmobile-reset: Use devm_platform_ioremap_resource()
    helper
  power: reset: rmobile-reset: Use
    devm_register_sys_off_handler(RESTART)
  power: reset: mt6323-poweroff: Use
    devm_register_sys_off_handler(POWER_OFF)
  power: reset: msm-poweroff: Use
    devm_register_sys_off_handler(POWER_OFF)
  power: reset: msm-poweroff: Use devm_register_sys_off_handler(RESTART)
  power: reset: regulator-poweroff: Use
    devm_register_sys_off_handler(POWER_OFF)
  power: reset: as3722-poweroff: Use
    devm_register_sys_off_handler(POWER_OFF)
  power: reset: gemini-poweroff: Use
    devm_register_sys_off_handler(POWER_OFF)
  power: reset: restart-poweroff: Use
    devm_register_sys_off_handler(POWER_OFF)
  power: reset: syscon-poweroff: Move device data into a struct
  power: reset: syscon-poweroff: Use
    devm_register_sys_off_handler(POWER_OFF)

 drivers/power/reset/as3722-poweroff.c    | 30 ++++-------
 drivers/power/reset/atc260x-poweroff.c   | 55 ++++++++------------
 drivers/power/reset/axxia-reset.c        | 16 +++---
 drivers/power/reset/brcm-kona-reset.c    | 11 ++--
 drivers/power/reset/gemini-poweroff.c    | 16 +++---
 drivers/power/reset/msm-poweroff.c       | 21 +++-----
 drivers/power/reset/mt6323-poweroff.c    | 26 +++++-----
 drivers/power/reset/regulator-poweroff.c | 36 +++++--------
 drivers/power/reset/restart-poweroff.c   | 25 +++------
 drivers/power/reset/rmobile-reset.c      | 35 ++++---------
 drivers/power/reset/syscon-poweroff.c    | 66 ++++++++++++------------
 drivers/power/reset/tps65086-restart.c   | 58 ++++-----------------
 drivers/power/reset/xgene-reboot.c       | 21 +++-----
 13 files changed, 150 insertions(+), 266 deletions(-)

-- 
2.39.2



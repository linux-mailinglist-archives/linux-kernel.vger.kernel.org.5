Return-Path: <linux-kernel+bounces-53837-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B8D0984A726
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 22:24:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E25551C26B90
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 21:24:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C13564A80;
	Mon,  5 Feb 2024 19:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="IVJ9WWfl"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3393A634F9;
	Mon,  5 Feb 2024 19:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707162298; cv=none; b=T0xC0gCs37rSlRH5KLV1Ya7IpOFEmgg3ot5//OQO9uHhQZiSXt0J+eKcpdO/p9zKvvwVXXhhMar3nVUq5VczOYo80WKMQQSHCdg3sNz9gBaPUY4EEST89GxPYKKmIOXblH/KUdFLh0ZQXOjB52fqMgL/xXjHsqEM5YNkqBj/f60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707162298; c=relaxed/simple;
	bh=6FZWkOFT7WKgccnoPgI4xt1xCedhQt6VkcInqPcK5yA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jdRSfAEyI+ZYD5/1UT0G2u4QLtsNLOPTaUFC5GBsOdy1ZBpU87ZPPMXaN03VJXhIzQ6K685JC2q+E7iIKmlgr0BkqPP3MXleB+nxvlqFaMgw+6DbgqE/Kf84863wE06vOiNPbQD2wRP43wjaFH+MPUlYg5KQeYrawYOtkTHlwNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=IVJ9WWfl; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 415JidWl016337;
	Mon, 5 Feb 2024 13:44:39 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1707162279;
	bh=I2VglAtdv1vuqLTP4/IxTbXu7umNiNc+hKIhHdGfH0E=;
	h=From:To:CC:Subject:Date;
	b=IVJ9WWflrLwutF++zW8zY7/bau/svLyN2jC85tuPzOzq42diYRXOKezzRDESQf90B
	 nchO1ahoi+5DdZ4ig7eR1ci1IaQUFxEVZaJVi7tFUZXnowK35uo7odueLy94fxGxFw
	 VEh19aVVQZuzEa+7kwhQogEIDcKBNVENO+Nih4sI=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 415JidJk073094
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 5 Feb 2024 13:44:39 -0600
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 5
 Feb 2024 13:44:39 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 5 Feb 2024 13:44:39 -0600
Received: from lelvsmtp5.itg.ti.com ([10.249.42.149])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 415JicQN028467;
	Mon, 5 Feb 2024 13:44:38 -0600
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
Subject: [PATCH v2 00/19] Remove pm_power_off use in drivers/power/reset
Date: Mon, 5 Feb 2024 13:44:18 -0600
Message-ID: <20240205194437.180802-1-afd@ti.com>
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
 drivers/power/reset/msm-poweroff.c       | 25 ++++-----
 drivers/power/reset/mt6323-poweroff.c    | 28 +++++-----
 drivers/power/reset/regulator-poweroff.c | 36 +++++--------
 drivers/power/reset/restart-poweroff.c   | 25 +++------
 drivers/power/reset/rmobile-reset.c      | 35 ++++---------
 drivers/power/reset/syscon-poweroff.c    | 66 ++++++++++++------------
 drivers/power/reset/tps65086-restart.c   | 58 ++++-----------------
 drivers/power/reset/xgene-reboot.c       | 21 +++-----
 13 files changed, 154 insertions(+), 268 deletions(-)

-- 
2.39.2



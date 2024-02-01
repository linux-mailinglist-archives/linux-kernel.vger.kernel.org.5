Return-Path: <linux-kernel+bounces-48634-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA134845F1B
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 19:01:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D87D71C2A35C
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 18:01:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B974779F8;
	Thu,  1 Feb 2024 18:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="swQ2TjJ1"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3022084FB3;
	Thu,  1 Feb 2024 18:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706810486; cv=none; b=anF8+RmgvSJEXBZAQ7HKTxHEaCd3/EThK6hA1FTwDyX4nfUjqp2CN+B+pWeahUeFPPRnUQQRLLDZlLwJEpVkNPO+xPh7QMTtsgE7N6pMe9NaJr2HOcCLHGXVo7178t9X6+fYodIpP8U0uNXCu2eXb7BW3OPVIz0XDiirmnh5lmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706810486; c=relaxed/simple;
	bh=fOkFOHa374/LO9IaXA3l/fKl43nv9S1ZgQc0wBQpkcg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ajlnWZ+lXNE8sjUOCV/gAZU43iwixtj9ORZhTmfkWBk9VIMGG99uVgkOev61wg9ETI+K4ksutg6LXSOnnNWnUNP88iSHDAb20W4F6mrXQ25rHJodBuuVsLO3ogOcKOYPG/G3LAfRUkKfQ/IJEJabTgWs7VoxlZpLcJ+m7eVxhNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=swQ2TjJ1; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 411I13Ro049520;
	Thu, 1 Feb 2024 12:01:03 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1706810463;
	bh=F62P9tp+eb7Ee4fh8Chen/6wW2u3qcpN9ys5GlRy8Xs=;
	h=From:To:CC:Subject:Date;
	b=swQ2TjJ1hhA0pJzR/Zxn6yfEVD3zp5aUl9+2D/q0jUTdZV4J5b51Oe9k2xJewBsCS
	 /4+4C9dkWyG+z/pztyx1wGd6cQfiyS8M3y20k+jNfY2A68FoAZ3twB2BSOsUct9zJK
	 OksPIH7oj2E0FSeNH11tCorzpB/PdHnI5CZPpjRY=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 411I13d7120298
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 1 Feb 2024 12:01:03 -0600
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 1
 Feb 2024 12:01:03 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 1 Feb 2024 12:01:03 -0600
Received: from lelvsmtp6.itg.ti.com ([10.249.42.149])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 411I12Ge117221;
	Thu, 1 Feb 2024 12:01:02 -0600
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
Subject: [PATCH 00/18] Remove pm_power_off use in drivers/power/reset
Date: Thu, 1 Feb 2024 12:00:44 -0600
Message-ID: <20240201180102.70395-1-afd@ti.com>
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

Andrew Davis (18):
  power: reset: atc260x-poweroff: Use
    devm_register_sys_off_handler(RESTART)
  power: reset: atc260x-poweroff: Use
    devm_register_sys_off_handler(POWER_OFF)
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
 drivers/power/reset/brcm-kona-reset.c    | 18 +++----
 drivers/power/reset/gemini-poweroff.c    | 16 +++---
 drivers/power/reset/msm-poweroff.c       | 25 ++++-----
 drivers/power/reset/mt6323-poweroff.c    | 28 +++++-----
 drivers/power/reset/regulator-poweroff.c | 36 +++++--------
 drivers/power/reset/restart-poweroff.c   | 25 +++------
 drivers/power/reset/rmobile-reset.c      | 38 +++++---------
 drivers/power/reset/syscon-poweroff.c    | 66 ++++++++++++------------
 drivers/power/reset/tps65086-restart.c   | 58 ++++-----------------
 drivers/power/reset/xgene-reboot.c       | 13 ++---
 13 files changed, 158 insertions(+), 266 deletions(-)

-- 
2.39.2



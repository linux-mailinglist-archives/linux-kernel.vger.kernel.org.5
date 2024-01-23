Return-Path: <linux-kernel+bounces-35694-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F86183953B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 17:49:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A482D1F2ED6C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 16:49:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FC437FBB3;
	Tue, 23 Jan 2024 16:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="CcUkZJOd"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 387517F7D0;
	Tue, 23 Jan 2024 16:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706028314; cv=none; b=ASAQ7rtFaKKAXHdRqVNCFKBAtU+NB7WF1JLNEjiGbOZs56AoYNrEY6lrfEWpEZzXhcoB4yZwtB0UIkxrON2YEh6OkMHuqLwQlemTX4YdDRO8XmRSHjkV57WggToMy/bxXx0Q51JIrz+oHYSwd+s3mnkLl+5ZM8uyNmUv4w52zz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706028314; c=relaxed/simple;
	bh=SbwaXJ2LokzxJeyXqmR0gOIwPNDrZ4SnI/C0mtmoAho=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RmCMOfaC2xr//0mvNNcqFmBFdH57ieI57zyAD4N3Iv1QxRScuqh4KuDHEow6ZF89efC4/mW5kNtM2CdDKY5Uu8lGw2rScGaLviKaUEdiXyCJvn7RlXbSG74EjsrqReYIVEPN2sc2Y3QCWI74d7Q9gleedV6tjXgXtruG+vWHf2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=CcUkZJOd; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40NGijEM051145;
	Tue, 23 Jan 2024 10:44:45 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1706028285;
	bh=FYhKHSteNkiUQ1HlpJw9fATm7aWNU1ENmrjsQkgidq0=;
	h=From:To:CC:Subject:Date;
	b=CcUkZJOdU/U3GWFgIZsAoORx6jXbs4kRKUHMIqvAALxN/7Xc1KeHQuVuKNVUxY1BI
	 MQlFcT3J9LWaKxKFZUl5msk0yEcN7dIfjeTF0OYlp8jXrhiPliwmvKEzKA5QtttoMD
	 inq5fN9k3Qr4Vu1/THV9zBbN35PhiiKwAhW5AvbQ=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40NGijPQ011478
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 23 Jan 2024 10:44:45 -0600
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 23
 Jan 2024 10:44:45 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 23 Jan 2024 10:44:45 -0600
Received: from lelvsmtp5.itg.ti.com ([10.249.42.149])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40NGiiKF022038;
	Tue, 23 Jan 2024 10:44:44 -0600
From: Andrew Davis <afd@ti.com>
To: Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi
	<lpieralisi@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        Karol Gugala
	<kgugala@antmicro.com>,
        Mateusz Holenko <mholenko@antmicro.com>,
        Gabriel
 Somlo <gsomlo@gmail.com>, Joel Stanley <joel@jms.id.au>,
        Mark Brown
	<broonie@kernel.org>, Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang
	<baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>, Lee
 Jones <lee@kernel.org>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        Andrew Davis
	<afd@ti.com>
Subject: [PATCH 0/4] Deprecate register_restart_handler()
Date: Tue, 23 Jan 2024 10:44:39 -0600
Message-ID: <20240123164443.394642-1-afd@ti.com>
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

Explanation is in patch #1.

The rest of this series is a set of representative examples of converting
away from the old API. They should be valid and can be taken by their
respective maintainers even if patch #1 doesn't find acceptance.

Thanks,
Andrew

Changes from RFC:
 - Add Reviewed-by tag
 - Rebase on v6.8-rc1 and drop taken patch

Andrew Davis (4):
  kernel/reboot: Deprecate register_restart_handler()
  drivers/soc/litex: Use devm_register_restart_handler()
  firmware: psci: Use register_sys_off_handler(SYS_OFF_MODE_RESTART)
  firmware: ti_sci: Use devm_register_restart_handler()

 drivers/firmware/psci/psci.c       | 10 ++--------
 drivers/firmware/ti_sci.c          | 14 +++++---------
 drivers/soc/litex/litex_soc_ctrl.c | 23 +++++------------------
 include/linux/reboot.h             |  8 ++++++--
 kernel/reboot.c                    |  3 +++
 5 files changed, 21 insertions(+), 37 deletions(-)

-- 
2.39.2



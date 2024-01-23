Return-Path: <linux-kernel+bounces-35696-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39CB0839540
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 17:50:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF30F1F2F28D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 16:50:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62AC18004C;
	Tue, 23 Jan 2024 16:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="XQ+TBGu7"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21FA78003C;
	Tue, 23 Jan 2024 16:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706028335; cv=none; b=vC3jzeOv6HOHQtWiV4I7WZWkcnquoytVhquJK547TEDJS9Y9IpfHYUrie3QTeYmD2lYeDotu/SGopO8o96ddZyqxOZ0j+ub+XPdQvUSPTiJ6U59YEH35DGmzsuOmnU2ZM06hlt8x9YjWc44bk8PCu10R01mv/pcpSmHBPLmF6t8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706028335; c=relaxed/simple;
	bh=ZglZxMe91KASK/v+IW0btwDbCnQ9sigjhDoQmmAsN6M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Mq2x/jOUtAza2Khw/3zIQeV8RoFr5gBoTW4830ZMRueaqa4tb3nKNUcaxH1Hmf2M6ZfipNrkpZ1r+0jGkQN70lFPX6R9uUSSs8qmfYU6HHxR2D9S0hMG8zURKEt6V1a5Fw1HQ8SxhuFbTnfSO+kzA/xEtFmNRCbBEDjwr/f8ODc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=XQ+TBGu7; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40NGilni101831;
	Tue, 23 Jan 2024 10:44:47 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1706028287;
	bh=oKxZn4Uy08vRh9Z4twvXFEfHH30BeCJ4RW0dN5sv5z8=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=XQ+TBGu7qpd8prpUtoiX4QquV6MDTGYJkGA99SBthNePlOtrETBsqqBYkjwRr5Z+7
	 GCrpHTHIp03tWeQXOuVYFiCBETiGlwmkIaID9YgM4lzjqgYyUR8g0trLctCvyhNz1j
	 Et7+isys2JxBKFURnMNl5KMzSq6jduv09RPdz3mo=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40NGilFK041335
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 23 Jan 2024 10:44:47 -0600
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 23
 Jan 2024 10:44:47 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 23 Jan 2024 10:44:47 -0600
Received: from lelvsmtp5.itg.ti.com ([10.249.42.149])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40NGiiKI022038;
	Tue, 23 Jan 2024 10:44:46 -0600
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
Subject: [PATCH 3/4] firmware: psci: Use register_sys_off_handler(SYS_OFF_MODE_RESTART)
Date: Tue, 23 Jan 2024 10:44:42 -0600
Message-ID: <20240123164443.394642-4-afd@ti.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240123164443.394642-1-afd@ti.com>
References: <20240123164443.394642-1-afd@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Function register_restart_handler() is deprecated. Using this new API
removes our need to keep and manage a struct notifier_block.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 drivers/firmware/psci/psci.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/firmware/psci/psci.c b/drivers/firmware/psci/psci.c
index d9629ff878619..767a5af5384b4 100644
--- a/drivers/firmware/psci/psci.c
+++ b/drivers/firmware/psci/psci.c
@@ -305,8 +305,7 @@ static int get_set_conduit_method(const struct device_node *np)
 	return 0;
 }
 
-static int psci_sys_reset(struct notifier_block *nb, unsigned long action,
-			  void *data)
+static int psci_sys_reset(struct sys_off_data *data)
 {
 	if ((reboot_mode == REBOOT_WARM || reboot_mode == REBOOT_SOFT) &&
 	    psci_system_reset2_supported) {
@@ -323,11 +322,6 @@ static int psci_sys_reset(struct notifier_block *nb, unsigned long action,
 	return NOTIFY_DONE;
 }
 
-static struct notifier_block psci_sys_reset_nb = {
-	.notifier_call = psci_sys_reset,
-	.priority = 129,
-};
-
 static void psci_sys_poweroff(void)
 {
 	invoke_psci_fn(PSCI_0_2_FN_SYSTEM_OFF, 0, 0, 0);
@@ -623,7 +617,7 @@ static void __init psci_0_2_set_functions(void)
 		.migrate_info_type = psci_migrate_info_type,
 	};
 
-	register_restart_handler(&psci_sys_reset_nb);
+	register_sys_off_handler(SYS_OFF_MODE_RESTART, 129, psci_sys_reset, NULL);
 
 	pm_power_off = psci_sys_poweroff;
 }
-- 
2.39.2



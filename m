Return-Path: <linux-kernel+bounces-158403-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 946758B1F51
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 12:38:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF5741C219F6
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 10:38:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE93723746;
	Thu, 25 Apr 2024 10:37:51 +0000 (UTC)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC011210E6;
	Thu, 25 Apr 2024 10:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714041471; cv=none; b=GgEuBCqzhmPrA9aQpjgJBG+Is7rB1IB+O4CnzPMKPdERpWbf+0VWma0xdou/XWYK4H9XSgpt8RZIzh5SV5Q+wPdI5J+SgwWl3WbA37/gXNKpe6KbbvZJxXQ1JIvS2cDOZK/TMBcHPEyu809QHaUhzDylQj7+GWOJ0nz7HFBXIOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714041471; c=relaxed/simple;
	bh=CFoH42OIvTROq01T7YqM+I62dzAY/y5oN09zfkoGmHY=;
	h=From:To:Cc:Subject:Date:Message-Id; b=mtzhNwl8C71xl+thUrRRdGCitn3vA+7e328lHyM66OoT7cyW4tfLTGjna0LsycqOi43bN+Y98JV+Bh1FyuoNCmYRfZHEEmvwrYK0k+9nx0vebNWJ8PalAs/D/4qFmmWhrzMmoN969QLtn9cays1aku1cMKL8qlQpD3NkVd4kWZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva020.nxp.com (localhost [127.0.0.1])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 0B0311A0276;
	Thu, 25 Apr 2024 12:37:47 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 7DE961A0258;
	Thu, 25 Apr 2024 12:37:46 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 8F8D3181D0FB;
	Thu, 25 Apr 2024 18:37:44 +0800 (+08)
From: Shengjiu Wang <shengjiu.wang@nxp.com>
To: abelvesa@kernel.org,
	peng.fan@nxp.com,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	imx@lists.linux.dev,
	shengjiu.wang@gmail.com
Cc: linux-clk@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] clk: imx: imx8mp: Add delay after power up
Date: Thu, 25 Apr 2024 18:19:24 +0800
Message-Id: <1714040364-17127-1-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

According to comments in drivers/pmdomain/imx/gpcv2.c:

	/* request the ADB400 to power up */
	if (domain->bits.hskreq) {
		regmap_update_bits(domain->regmap, domain->regs->hsk,
				   domain->bits.hskreq, domain->bits.hskreq);

		/*
		 * ret = regmap_read_poll_timeout(domain->regmap, domain->regs->hsk, reg_val,
		 *				  (reg_val & domain->bits.hskack), 0,
		 *				  USEC_PER_MSEC);
		 * Technically we need the commented code to wait handshake. But that needs
		 * the BLK-CTL module BUS clk-en bit being set.
		 *
		 * There is a separate BLK-CTL module and we will have such a driver for it,
		 * that driver will set the BUS clk-en bit and handshake will be triggered
		 * automatically there. Just add a delay and suppose the handshake finish
		 * after that.
		 */
	}

The BLK-CTL module needs to add delay to wait for a handshake request finished
before accessing registers, which is just after the enabling of power domain.

Otherwise there is error:

[    2.180834] SError Interrupt on CPU1, code 0x00000000bf000002 -- SError
[    2.180849] CPU: 1 PID: 48 Comm: kworker/u16:2 Not tainted 6.9.0-rc5-next-20240424-00003-g21cec88845c6 #171
[    2.180856] Hardware name: NXP i.MX8MPlus EVK board (DT)
[    2.180861] Workqueue: events_unbound deferred_probe_work_func
[    2.180878] pstate: 80000005 (Nzcv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[    2.180885] pc : clk_imx8mp_audiomix_runtime_resume+0x34/0x44
[    2.180900] lr : pm_generic_runtime_resume+0x2c/0x44
[    2.180910] sp : ffff800083423a20
[    2.180913] x29: ffff800083423a20 x28: 0000000000000000 x27: 0000000000000000
[    2.180922] x26: ffff0000c0e4e410 x25: 0000000000000000 x24: 0000000000000000
[    2.180935] x23: 0000000000000000 x22: ffff0000c02afd20 x21: 0000000000000000
[    2.180945] x20: ffff0000c162a000 x19: ffff0000c0e52810 x18: ffffffffffffffff
[    2.180959] x17: 0000000000000000 x16: 0000000000000100 x15: ffff8000834239f0
[    2.180970] x14: ffff0000c03d0a1c x13: ffff0000c0a03440 x12: 00000000000003c7
[    2.180982] x11: 0000000000000000 x10: ffff8000825010ba x9 : 0000000000000008
[    2.180993] x8 : 0000000000000008 x7 : 0000000000000000 x6 : 0000000000000000
[    2.181005] x5 : ffff8000838b0000 x4 : ffff0000c0e66088 x3 : ffff8000813852c0
[    2.181018] x2 : 0000000000000000 x1 : 0000000000000004 x0 : ffff8000838b0300
[    2.181035] Kernel panic - not syncing: Asynchronous SError Interrupt
[    2.181038] CPU: 1 PID: 48 Comm: kworker/u16:2 Not tainted 6.9.0-rc5-next-20240424-00003-g21cec88845c6 #171
[    2.181047] Hardware name: NXP i.MX8MPlus EVK board (DT)
[    2.181050] Workqueue: events_unbound deferred_probe_work_func
[    2.181064] Call trace:
[    2.181066]  dump_backtrace+0x90/0xe8
[    2.181080]  show_stack+0x18/0x24
[    2.181091]  dump_stack_lvl+0x34/0x8c
[    2.181104]  dump_stack+0x18/0x24
[    2.181117]  panic+0x39c/0x3d0
[    2.181129]  nmi_panic+0x48/0x94
[    2.181142]  arm64_serror_panic+0x6c/0x78
[    2.181149]  do_serror+0x3c/0x70
[    2.181157]  el1h_64_error_handler+0x30/0x48
[    2.181164]  el1h_64_error+0x64/0x68
[    2.181171]  clk_imx8mp_audiomix_runtime_resume+0x34/0x44
[    2.181183]  __genpd_runtime_resume+0x30/0x80
[    2.181195]  genpd_runtime_resume+0x110/0x244
[    2.181205]  __rpm_callback+0x48/0x1d8
[    2.181213]  rpm_callback+0x68/0x74
[    2.181224]  rpm_resume+0x468/0x6c0
[    2.181234]  __pm_runtime_resume+0x50/0x94
[    2.181243]  pm_runtime_get_suppliers+0x60/0x8c
[    2.181258]  __driver_probe_device+0x48/0x12c
[    2.181268]  driver_probe_device+0xd8/0x15c
[    2.181278]  __device_attach_driver+0xb8/0x134
[    2.181290]  bus_for_each_drv+0x84/0xe0
[    2.181302]  __device_attach+0x9c/0x188
[    2.181312]  device_initial_probe+0x14/0x20
[    2.181323]  bus_probe_device+0xac/0xb0
[    2.181334]  deferred_probe_work_func+0x88/0xc0
[    2.181344]  process_one_work+0x150/0x290
[    2.181357]  worker_thread+0x2f8/0x408
[    2.181370]  kthread+0x110/0x114
[    2.181381]  ret_from_fork+0x10/0x20
[    2.181391] SMP: stopping secondary CPUs
[    2.181400] Kernel Offset: disabled
[    2.181403] CPU features: 0x0,00000040,00100000,4200421b
[    2.181407] Memory Limit: none
[    2.463040] ---[ end Kernel panic - not syncing: Asynchronous SError Interrupt ]---

Fixes: 1496dd413b2e ("clk: imx: imx8mp: Add pm_runtime support for power saving")
Reported-by: Francesco Dolcini <francesco@dolcini.it>
Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 drivers/clk/imx/clk-imx8mp-audiomix.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/clk/imx/clk-imx8mp-audiomix.c b/drivers/clk/imx/clk-imx8mp-audiomix.c
index e4231e9c8f05..cb44c460548e 100644
--- a/drivers/clk/imx/clk-imx8mp-audiomix.c
+++ b/drivers/clk/imx/clk-imx8mp-audiomix.c
@@ -6,6 +6,7 @@
  */
 
 #include <linux/clk-provider.h>
+#include <linux/delay.h>
 #include <linux/device.h>
 #include <linux/io.h>
 #include <linux/mod_devicetable.h>
@@ -362,6 +363,12 @@ static int clk_imx8mp_audiomix_runtime_suspend(struct device *dev)
 
 static int clk_imx8mp_audiomix_runtime_resume(struct device *dev)
 {
+	/*
+	 * According to the drivers/pmdomain/imx/gpcv2.c
+	 * need to wait for handshake request to propagate
+	 */
+	udelay(5);
+
 	clk_imx8mp_audiomix_save_restore(dev, false);
 
 	return 0;
-- 
2.34.1



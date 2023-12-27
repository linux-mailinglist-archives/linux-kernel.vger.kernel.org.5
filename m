Return-Path: <linux-kernel+bounces-11769-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C305281EB6B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 03:01:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3218BB209F9
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 02:01:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A96A20EB;
	Wed, 27 Dec 2023 02:01:26 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from out28-81.mail.aliyun.com (out28-81.mail.aliyun.com [115.124.28.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0F1B1FC8
	for <linux-kernel@vger.kernel.org>; Wed, 27 Dec 2023 02:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sjterm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sjterm.com
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.1100688|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0502652-0.000180865-0.949554;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047206;MF=fuyao@sjterm.com;NM=1;PH=DS;RN=9;RT=9;SR=0;TI=SMTPD_---.VtpmuEK_1703642477;
Received: from localhost(mailfrom:fuyao@sjterm.com fp:SMTPD_---.VtpmuEK_1703642477)
          by smtp.aliyun-inc.com;
          Wed, 27 Dec 2023 10:01:18 +0800
Date: Wed, 27 Dec 2023 10:01:17 +0800
From: Fuyao Kashizuku <fuyao@sjterm.com>
To: Lee Jones <lee@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Andre Przywara <andre.przywara@arm.com>
Cc: Jianzhang Mai <maijianzhang@allwinnertech.com>
Subject: [PATCH] mfd: sun4i-gpadc: adaptation interrupt number
Message-ID: <ZYuFbUUus9apiCpq@debian.cyg>
Mail-Followup-To: Lee Jones <lee@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Andre Przywara <andre.przywara@arm.com>,
	Jianzhang Mai <maijianzhang@allwinnertech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: work_work_work

The identifiers are used as IRQ resource numbers, where 0 is treated
specially.

This fixes sun4i-gpadc-iio probe failed when request irq.

The backstack:
	WARNING: CPU: 3 PID: 1 at drivers/base/platform.c:451
	__platform_get_irq_byname+0xb8/0xc4
	0 is an invalid IRQ number
	Modules linked in:
	CPU: 3 PID: 1 Comm: swapper/0 Not tainted 6.7.0-rc6 #9
	Hardware name: Allwinner sun8i Family
	 unwind_backtrace
	 show_stack
	 dump_stack_lvl
	 __warn
	 warn_slowpath_fmt
	 __platform_get_irq_byname
	 platform_get_irq_byname
	 sun4i_irq_init
	 sun4i_gpadc_probe
	 platform_probe
	 really_probe
	 __driver_probe_device
	 driver_probe_device
	 __driver_attach
	 bus_for_each_dev
	 bus_add_driver
	 driver_register
	 do_one_initcall
	 do_initcall_level
	 do_initcalls
	 kernel_init_freeable
	 kernel_init

Log reports:
sun4i-gpadc-iio sun6i-a31-gpadc-iio.0: error -EINVAL: IRQ FIFO_DATA_PENDING
not found
sun4i-gpadc-iio: probe of sun6i-a31-gpadc-iio.0 failed with error -22

Signed-off-by: Fuyao Kashizuku <fuyao@sjterm.com>
---
Changes in v2:
 - Fix the commit message.
 - Add the backstack.
 - Add the log reports.
 - Use the correct full name and email address.
 - Correct the subsystem to mfd.
 - Link to v1: https://lore.kernel.org/lkml/YwdhTlk+9h+9Mrwm@scg/

 include/linux/mfd/sun4i-gpadc.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/mfd/sun4i-gpadc.h b/include/linux/mfd/sun4i-gpadc.h
index ea0ccf33a459..021f820f9d52 100644
--- a/include/linux/mfd/sun4i-gpadc.h
+++ b/include/linux/mfd/sun4i-gpadc.h
@@ -81,8 +81,8 @@
 #define SUN4I_GPADC_TEMP_DATA				0x20
 #define SUN4I_GPADC_DATA				0x24
 
-#define SUN4I_GPADC_IRQ_FIFO_DATA			0
-#define SUN4I_GPADC_IRQ_TEMP_DATA			1
+#define SUN4I_GPADC_IRQ_FIFO_DATA			1
+#define SUN4I_GPADC_IRQ_TEMP_DATA			2
 
 /* 10s delay before suspending the IP */
 #define SUN4I_GPADC_AUTOSUSPEND_DELAY			10000
-- 
2.39.2



Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 396157EE24D
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 15:05:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344618AbjKPOFW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 09:05:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230427AbjKPOFU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 09:05:20 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98977A7
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 06:05:16 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-40a4848c6e1so6064535e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 06:05:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700143515; x=1700748315; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1vMs8HGBAcfn9XgWAa8ABXfBZHUiDNDm55hIR5DhrNE=;
        b=eRLfUUv4tmMa5m2mfFm9FVpn/XqTHShfAB1STVZaWC7p5oK/3FLqUvXuCeoSXKc3XZ
         5yc5AX2+tQE9Qp5NuLDRiB/poz4kQ/icmFypmEYLIGENCPJBMZDui3gaBCkgStAO6+KQ
         I36BocixTqZliIXiFDQ+xCnRUPll1TqSyrWEMHGP1ywdNoeHLN1urcBvXXEDRdAc/2yr
         d3h0IIyvHElIFvb3I8rc0/7O+3Ae3TRf5SG6Oiy2gXj1aAqWlbRNuQuOMzRk+Yp5NAj9
         WMdJL3+yNpM1JMjSwl0S29sK9ZJE+sm9cjV/ukPX94B21JgQGMatxvhpwrjTUfLR0KPY
         tPkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700143515; x=1700748315;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1vMs8HGBAcfn9XgWAa8ABXfBZHUiDNDm55hIR5DhrNE=;
        b=Puj4NMZBFjW7by6Kt5bhIP6KdDw8wGMUgEPgmDog2gMOM291CRcyq42opBbHDV8XID
         I/ROWNGcg0uk8yz0MabHYSyw4I1A9cx9jc3nCC6zWSrU/qnDq0j0nY5h8inGwPEMjFaG
         d9eoCP+/8gffU2CIrRA538gXANQEnkYiXXRBGDdQHv7S7Qei07UgqtXOk+323l7BhqqC
         3uekE7QgKTUaJ+rwcwxlbeBM4j/IKpSFp0ayjMPL2vXT5qKcfqvjR2MKWBo5UJk229Sp
         E1DDXH/s+d96npWqAQqgarYJ+UkrvmGfrmQmECLPE3PAGI0+gR6C9Mvt+/QAwgYcjUbC
         RZHw==
X-Gm-Message-State: AOJu0Yyz/wojzTI0xDl/w/BC/DvblwVXCo1/sxfWPyKM7RiVnKzYJ5m/
        eNmuChpjTLPHTaydJBH0lTjpOg==
X-Google-Smtp-Source: AGHT+IF920xQnW/3zl/68Fg/wc71MidH8O9hkK7uPSynjwca94aFpGRPXsKG1HSx5K1phWROKHenJQ==
X-Received: by 2002:a05:600c:1f96:b0:40a:3e41:7d6f with SMTP id je22-20020a05600c1f9600b0040a3e417d6fmr1114198wmb.32.1700143514771;
        Thu, 16 Nov 2023 06:05:14 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id n10-20020a05600c304a00b004080f0376a0sm3626749wmh.42.2023.11.16.06.05.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Nov 2023 06:05:14 -0800 (PST)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Thu, 16 Nov 2023 15:05:13 +0100
Subject: [PATCH v2] mfd: rk8xx: fixup devices registration with
 PLATFORM_DEVID_AUTO
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231116-topic-amlogic-upstream-fix-rk8xx-devid-auto-v2-1-3f1bad68ab9d@linaro.org>
X-B4-Tracking: v=1; b=H4sIAJghVmUC/52NQQ6CMBBFr0K6dgwFa5GV9zAsBlpgIlAyLQRDu
 LuVI7j6eT8//+3CWybrRZnsgu1KntwUIbskoulx6iyQiSyyNMullHcIbqYGcBxcF3OZfWCLI7S
 0Ab+LbQMTXwzgEhyoR2NTI2udFyji48w27k7bq4rckw+OP6d8lb/2P88qQYJWLd5ypRXW+jnQh
 OyujjtRHcfxBdQPPyPnAAAA
To:     Lee Jones <lee@kernel.org>,
        Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     linux-kernel@vger.kernel.org, Adam Green <greena88@gmail.com>,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=6074;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=dHqVZNyr6lBdq+apH1bgHEAMAKOIoAjYiGUXIR+X3z0=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBlViGZaSED/xN2gPrUYVyul7daw/wqGBCQjBKHu+Je
 +cNiy9eJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZVYhmQAKCRB33NvayMhJ0Sp/D/
 91rNKBZvwAvvAc6+p904OiHApBVv/np3ILKGaR3I8Rv3CwJuEjh72Ut7ExSXP5CrnUfoHM4pS9BDeA
 d+Z05yNvz4o9RVOOefwaqy/P3hHbOBbrhjXHz3+ogB4UmzIwrNDofo0KD+xArxLy2GXJURFthCeWPJ
 pQpTOU5qH3fSr5WWbogveyc+M3ZWmhRlZKuIiXp0+sG2l2DL/LDRvX0AwVXxah2KTOQSsA4K9wnYu4
 atyj0aX0y7f+eAWwaU5Gt84t7NM38jxDXcFkVx5oVmJcc7nbVJUY9vhegZkFW1wVH6AgRbpTCwUzyK
 NDWwim77l5/wyZPCgh5S6f4BPz43Hz3N3UsJ56X8QX2NpO1mKz1D+E8kOmp0RFXio6HVkQ23teJN/1
 sOt+kjtZCUUfNVgm1t8MNAT2fh87QyJO2OhdR0fz3XS8fmjngIJU6ebI1ZOu8Xd8ZNKqmaXVLvPwXn
 eJuo73jT8RAUMotq53Y1NIDbUWDXBUKd1PZgNV/5ovVMk8K3IYpduIxQ9fupJTVPYFZSmPUk98Yh1v
 iX8YAcEPOWzlTeL/76xoiFz2y89dz+bE6f/cEgaHTi4yJJLE3js21KysH39IVAaEJ11oN9Xj+yojyt
 kkKFsbONe125lkDzypO7sy82Qwh8tvw1BLH8/vY7p+qu3Aam7oducaqlGMog==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 210f418f8ace ("mfd: rk8xx: Add rk806 support"), devices are
registered with "0" as id, causing devices to not have an automatic device id
and prevents having multiple RK8xx PMICs on the same system.

Properly pass PLATFORM_DEVID_AUTO to devm_mfd_add_devices() and since
it will ignore the cells .id with this special value, also cleanup
by removing all now ignored cells .id values.

Now we have the same behaviour as before rk806 introduction and rk806
retains the intented behavior.

This fixes a regression while booting the Odroid Go Ultra on v6.6.1:
sysfs: cannot create duplicate filename '/bus/platform/devices/rk808-clkout'
CPU: 3 PID: 97 Comm: kworker/u12:2 Not tainted 6.6.1 #1
Hardware name: Hardkernel ODROID-GO-Ultra (DT)
Workqueue: events_unbound deferred_probe_work_func
Call trace:
dump_backtrace+0x9c/0x11c
show_stack+0x18/0x24
dump_stack_lvl+0x78/0xc4
dump_stack+0x18/0x24
sysfs_warn_dup+0x64/0x80
sysfs_do_create_link_sd+0xf0/0xf8
sysfs_create_link+0x20/0x40
bus_add_device+0x114/0x160
device_add+0x3f0/0x7cc
platform_device_add+0x180/0x270
mfd_add_device+0x390/0x4a8
devm_mfd_add_devices+0xb0/0x150
rk8xx_probe+0x26c/0x410
rk8xx_i2c_probe+0x64/0x98
i2c_device_probe+0x104/0x2e8
really_probe+0x184/0x3c8
__driver_probe_device+0x7c/0x16c
driver_probe_device+0x3c/0x10c
__device_attach_driver+0xbc/0x158
bus_for_each_drv+0x80/0xdc
__device_attach+0x9c/0x1ac
device_initial_probe+0x14/0x20
bus_probe_device+0xac/0xb0
deferred_probe_work_func+0xa0/0xf4
process_one_work+0x1bc/0x378
worker_thread+0x1dc/0x3d4
kthread+0x104/0x118
ret_from_fork+0x10/0x20
rk8xx-i2c 0-001c: error -EEXIST: failed to add MFD devices
rk8xx-i2c: probe of 0-001c failed with error -17

Fixes: 210f418f8ace ("mfd: rk8xx: Add rk806 support")
Reported-by: Adam Green <greena88@gmail.com>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
Finally a full cleanup is required to fix the regression because rk806 had
a special treatment still allowing DEVID_AUTO while all the other cells
regressed to DEVID_NONE.

[1] https://lore.kernel.org/all/20231115180050.5r5xukttz27vviyi@mercury.elektranox.org/
---
Changes in v2:
- Do a full cleanup instead of simply changing the id value passed to register
- Link to v1: https://lore.kernel.org/r/20231116-topic-amlogic-upstream-fix-rk8xx-devid-auto-v1-1-75fa43575ab7@linaro.org
---
 drivers/mfd/rk8xx-core.c | 34 +++++++++++++---------------------
 1 file changed, 13 insertions(+), 21 deletions(-)

diff --git a/drivers/mfd/rk8xx-core.c b/drivers/mfd/rk8xx-core.c
index c47164a3ec1d..b1ffc3b9e2be 100644
--- a/drivers/mfd/rk8xx-core.c
+++ b/drivers/mfd/rk8xx-core.c
@@ -53,76 +53,68 @@ static const struct resource rk817_charger_resources[] = {
 };
 
 static const struct mfd_cell rk805s[] = {
-	{ .name = "rk808-clkout", .id = PLATFORM_DEVID_NONE, },
-	{ .name = "rk808-regulator", .id = PLATFORM_DEVID_NONE, },
-	{ .name = "rk805-pinctrl", .id = PLATFORM_DEVID_NONE, },
+	{ .name = "rk808-clkout", },
+	{ .name = "rk808-regulator", },
+	{ .name = "rk805-pinctrl", },
 	{
 		.name = "rk808-rtc",
 		.num_resources = ARRAY_SIZE(rtc_resources),
 		.resources = &rtc_resources[0],
-		.id = PLATFORM_DEVID_NONE,
 	},
 	{	.name = "rk805-pwrkey",
 		.num_resources = ARRAY_SIZE(rk805_key_resources),
 		.resources = &rk805_key_resources[0],
-		.id = PLATFORM_DEVID_NONE,
 	},
 };
 
 static const struct mfd_cell rk806s[] = {
-	{ .name = "rk805-pinctrl", .id = PLATFORM_DEVID_AUTO, },
-	{ .name = "rk808-regulator", .id = PLATFORM_DEVID_AUTO, },
+	{ .name = "rk805-pinctrl", },
+	{ .name = "rk808-regulator", },
 	{
 		.name = "rk805-pwrkey",
 		.resources = rk806_pwrkey_resources,
 		.num_resources = ARRAY_SIZE(rk806_pwrkey_resources),
-		.id = PLATFORM_DEVID_AUTO,
 	},
 };
 
 static const struct mfd_cell rk808s[] = {
-	{ .name = "rk808-clkout", .id = PLATFORM_DEVID_NONE, },
-	{ .name = "rk808-regulator", .id = PLATFORM_DEVID_NONE, },
+	{ .name = "rk808-clkout", },
+	{ .name = "rk808-regulator", },
 	{
 		.name = "rk808-rtc",
 		.num_resources = ARRAY_SIZE(rtc_resources),
 		.resources = rtc_resources,
-		.id = PLATFORM_DEVID_NONE,
 	},
 };
 
 static const struct mfd_cell rk817s[] = {
-	{ .name = "rk808-clkout", .id = PLATFORM_DEVID_NONE, },
-	{ .name = "rk808-regulator", .id = PLATFORM_DEVID_NONE, },
+	{ .name = "rk808-clkout", },
+	{ .name = "rk808-regulator", },
 	{
 		.name = "rk805-pwrkey",
 		.num_resources = ARRAY_SIZE(rk817_pwrkey_resources),
 		.resources = &rk817_pwrkey_resources[0],
-		.id = PLATFORM_DEVID_NONE,
 	},
 	{
 		.name = "rk808-rtc",
 		.num_resources = ARRAY_SIZE(rk817_rtc_resources),
 		.resources = &rk817_rtc_resources[0],
-		.id = PLATFORM_DEVID_NONE,
 	},
-	{ .name = "rk817-codec", .id = PLATFORM_DEVID_NONE, },
+	{ .name = "rk817-codec", },
 	{
 		.name = "rk817-charger",
 		.num_resources = ARRAY_SIZE(rk817_charger_resources),
 		.resources = &rk817_charger_resources[0],
-		.id = PLATFORM_DEVID_NONE,
 	},
 };
 
 static const struct mfd_cell rk818s[] = {
-	{ .name = "rk808-clkout", .id = PLATFORM_DEVID_NONE, },
-	{ .name = "rk808-regulator", .id = PLATFORM_DEVID_NONE, },
+	{ .name = "rk808-clkout", },
+	{ .name = "rk808-regulator", },
 	{
 		.name = "rk808-rtc",
 		.num_resources = ARRAY_SIZE(rtc_resources),
 		.resources = rtc_resources,
-		.id = PLATFORM_DEVID_NONE,
 	},
 };
 
@@ -684,7 +676,7 @@ int rk8xx_probe(struct device *dev, int variant, unsigned int irq, struct regmap
 					     pre_init_reg[i].addr);
 	}
 
-	ret = devm_mfd_add_devices(dev, 0, cells, nr_cells, NULL, 0,
+	ret = devm_mfd_add_devices(dev, PLATFORM_DEVID_AUTO, cells, nr_cells, NULL, 0,
 			      regmap_irq_get_domain(rk808->irq_data));
 	if (ret)
 		return dev_err_probe(dev, ret, "failed to add MFD devices\n");

---
base-commit: f31817cbcf48d191faee7cebfb59197d2048cd64
change-id: 20231116-topic-amlogic-upstream-fix-rk8xx-devid-auto-59ce0d1b738a

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>


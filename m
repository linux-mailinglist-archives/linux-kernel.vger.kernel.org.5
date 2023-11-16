Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50AB17EDD26
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 09:53:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344948AbjKPIxP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 03:53:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbjKPIxN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 03:53:13 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69BABA1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 00:53:09 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-407c3adef8eso4641985e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 00:53:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700124788; x=1700729588; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=77Wv6Janf9I+Ebub5++O5x2Tpb5uzcszxRyW+cXDnIo=;
        b=mAQ6dP4Hq4FsMoLyw1dLyoY5irhaTLBHndewBd1/7zsbqmTuXA/WmT8BVCF9tyu/D1
         Y0UMjgAng6JOi5i7GuhhjD8ZvcbxR+liNqoltgZuH6P8yu8tTtSuXthjmfDx7v4xXszH
         1eHT/4TOS8bhmrb8bWwlBzktgz4OyTh4rlXGdNY0ro4yFqPNCJ/VzV+K7EQ+hJd5s+fx
         qGRYNnaVfIlSrzdUCeTHkcnoHPRcEGhy+pNAKerXt/mjwWBrJk7mqIr2kkNawBZmbHY5
         sgmeSZP/N9LmdiL5e4aWCDPEXw3QlpgBO2l61dVS/Jm+Qiob/IeifsNSq1R5QMpu1y0p
         OhuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700124788; x=1700729588;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=77Wv6Janf9I+Ebub5++O5x2Tpb5uzcszxRyW+cXDnIo=;
        b=gZY6owEaoLsXN6mJwCiOe99J79Up25bR5x/qFr1edc/8nCiNGWFCW62b7Z/i8anwbe
         H3Xm19qMXs4aoDBEcMwpA8k+4/iqRLJJk8gLrGtbwZB/1L+Nqt1gifKzbAt4y3aQ7FcZ
         uLwcjsDiDSxhk8QaeHmDNLbbnoLmH9Huiif0NnsiN/itHjVqJ3LwwiLNJAR7eZrYGSj3
         n/XT/WiV7fl5jMzQPy0rG5s5Hs0Og4foDkbEtVL18YY0FwkVz63C7QowF6dtPQ7qjxcq
         vMsG0UATxeiHxAVKIIl6BHAzEsVZsRmdqGsdvOVpYMytGTTNo9b+ORBVd3Rp36lqKdtY
         SL7g==
X-Gm-Message-State: AOJu0Ywd9jl8Gtwz3ezxV8lzyn1JQ1HwFXMafUDma4qEu3woHS+bdhss
        Tm9r9CUyVE34j+naY01NmlqDww==
X-Google-Smtp-Source: AGHT+IERW0Bh1Ea4ptTOvMf+GlHW2FpC7J8b8r+fHjAQhzG+LDSew3jZDFz30AF22QOu5heEEpLOQw==
X-Received: by 2002:a05:600c:4445:b0:402:ee71:29 with SMTP id v5-20020a05600c444500b00402ee710029mr13298465wmn.10.1700124787829;
        Thu, 16 Nov 2023 00:53:07 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id t14-20020a05600c198e00b004090ca6d785sm2715775wmq.2.2023.11.16.00.53.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Nov 2023 00:53:07 -0800 (PST)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Thu, 16 Nov 2023 09:53:05 +0100
Subject: [PATCH] mfd: rk8xx: register devices again with
 PLATFORM_DEVID_NONE
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231116-topic-amlogic-upstream-fix-rk8xx-devid-auto-v1-1-75fa43575ab7@linaro.org>
X-B4-Tracking: v=1; b=H4sIAHDYVWUC/x2N0QrCMAxFf2Xk2cC6oU5/RXyIbZxBt5a0k8LYv
 y/s6XLgcs4KmVU4w71ZQfkvWeJs4E4N+A/NI6MEY+jarnfOXbDEJB5p+sXRdkm5KNOEb6mo36F
 WDGYJSEuJeL55boN7XfuBwIxJ2X5H7fHcth0xeTwofQAAAA==
To:     Lee Jones <lee@kernel.org>,
        Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     linux-kernel@vger.kernel.org, Adam Green <greena88@gmail.com>,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2802;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=pDKfqUtEIcwC2aA/sBQY7rXnix+QjOhar8dtUN8Jklo=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBlVdhysR2YJOK43s4kEEgvVXkLxhqads355OHpAv7X
 VFflo4GJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZVXYcgAKCRB33NvayMhJ0cxIEA
 CedxQ/R6cKRve6Xk4ga6HUfugKhlkwpFJfPZEKJEzOl/RunQAWHQJZQpdr83FliFMi3H4cb5W3TIoa
 p3AxJnjiXTAMKq2qG386Y6ORsYn8PwjCQN7jsWgiFpVtoDRLHs8HQmnALP3wnwiUsRRj3gsBYMG5VF
 b87FP9ZmEVVXamUL5R2PxU1nku+f9/gajObAz+N40GwaPLhSdN9eicpR+0XqUx3Ny2/2hkXoK9g79N
 FWWJBCgRPFFNgfjorOlDExNXsM3mIbLbpQpFvTpIB/QQfqTveoSmPwtzRa9rZ84wjp+ZpkrQeHF0Mv
 4FEkmGEWOiQQSwUsF5ExnH0+awABAO2/aDDElfizqXFTkIhBqpXkTXRrRdFEvKwMTTyq7/ewqpm95E
 t+lm5O968cghg+QHYx2tF5Pjte0JqQ6uM6/t+nLqmn6gAFuLbXXWoDSC4EMtHXNdCB1xz2cdKw8umR
 I6qml8VMcA2pk04zSN15zcvKm9zyEg+ioRBS6Iu5sMfIfJPnKOrew6inVsgiGnmdePwiBwEJyp38/9
 SJolEvHCCUMFisiKNFOD+BwHUCvwevWpNZMwiRI9CWFIK86S64REi9X+IJ5G6Gj/SNxnlzjZTF9WFM
 fEqZo6e6He7GoeD8QApsgUtu0W0LPAW0q23j+8sD4/3B1ogtFqo7RGoApgVQ==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
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
Lee, This is only a fix for the regression, as discussed with Sebastian at [1],
the driver would require some more cleanup to cleanly register all devices with
PLATFORM_DEVID_AUTO. I plan to send this later on.

[1] https://lore.kernel.org/all/20231115180050.5r5xukttz27vviyi@mercury.elektranox.org/
---
 drivers/mfd/rk8xx-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/rk8xx-core.c b/drivers/mfd/rk8xx-core.c
index c47164a3ec1d..58d8dec7ac02 100644
--- a/drivers/mfd/rk8xx-core.c
+++ b/drivers/mfd/rk8xx-core.c
@@ -684,7 +684,7 @@ int rk8xx_probe(struct device *dev, int variant, unsigned int irq, struct regmap
 					     pre_init_reg[i].addr);
 	}
 
-	ret = devm_mfd_add_devices(dev, 0, cells, nr_cells, NULL, 0,
+	ret = devm_mfd_add_devices(dev, PLATFORM_DEVID_NONE, cells, nr_cells, NULL, 0,
 			      regmap_irq_get_domain(rk808->irq_data));
 	if (ret)
 		return dev_err_probe(dev, ret, "failed to add MFD devices\n");

---
base-commit: f31817cbcf48d191faee7cebfb59197d2048cd64
change-id: 20231116-topic-amlogic-upstream-fix-rk8xx-devid-auto-59ce0d1b738a

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D11337F0D94
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 09:31:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232112AbjKTIbc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 03:31:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232081AbjKTIba (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 03:31:30 -0500
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8ED1BE5;
        Mon, 20 Nov 2023 00:31:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=MCmCD
        t45NRngfCoOECBSc53ms9KrOALmsj4F6y7aqMc=; b=Lew0v0AGm9H1mLgxK84IU
        2Cz4VfP/Bwxbtnfs6Xv8iD/myWweROJYczti/VxXjUEN91OU0skB3Xvd3EG5Lx/4
        cxC3lxhQWXbjQYoR0fwDy699RoLBxmOi7c+EaXcbP2CNGeLbRcadzI1ucSqK9N9h
        EX9cXiYqJRIBs5ARtIB7ic=
Received: from localhost.localdomain (unknown [39.144.137.207])
        by zwqz-smtp-mta-g3-2 (Coremail) with SMTP id _____wDH52myFVtlTcE1Dg--.30221S3;
        Mon, 20 Nov 2023 16:15:48 +0800 (CST)
From:   Xing Tong Wu <xingtong_wu@163.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     xingtong.wu@siemens.com, tobias.schaffner@siemens.com,
        gerd.haeussler.ext@siemens.com
Subject: [PATCH v2 1/2] hwmon: (nct6775) Fix incomplete register array
Date:   Mon, 20 Nov 2023 16:15:41 +0800
Message-Id: <20231120081542.3174-2-xingtong_wu@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231120081542.3174-1-xingtong_wu@163.com>
References: <20231120081542.3174-1-xingtong_wu@163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wDH52myFVtlTcE1Dg--.30221S3
X-Coremail-Antispam: 1Uf129KBjvJXoW7ur1fXr1Dtry8uF1xtFW8WFg_yoW8tFyrp3
        4kXr4fAFW7Jr1aqr45KFs5ua1Ikw1ftFyrAws7CwsayF1ktry7Xr43tFZ8tr90yFWxta42
        9ryDAFyYq3WDCrUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jqhFxUUUUU=
X-Originating-IP: [39.144.137.207]
X-CM-SenderInfo: p0lqw35rqjs4rx6rljoofrz/1tbiFhUu0F44X5n24gAAsJ
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_BL,RCVD_IN_MSPIKE_L4,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xing Tong Wu <xingtong.wu@siemens.com>

The nct6116 specification actually includes 5 PWMs, but only 3
PWMs are present in the array. To address this, the missing 2
PWMs have been added to the array.

Signed-off-by: Xing Tong Wu <xingtong.wu@siemens.com>
---
 drivers/hwmon/nct6775-core.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/hwmon/nct6775-core.c b/drivers/hwmon/nct6775-core.c
index d928eb8ae5a3..c24b2c312911 100644
--- a/drivers/hwmon/nct6775-core.c
+++ b/drivers/hwmon/nct6775-core.c
@@ -844,6 +844,9 @@ static const u16 NCT6116_REG_FAN_PULSES[] = { 0xf6, 0xf6, 0xf6, 0xf6, 0xf5 };
 static const u16 NCT6116_FAN_PULSE_SHIFT[] = { 0, 2, 4, 6, 6 };
 
 static const u16 NCT6116_REG_PWM[] = { 0x119, 0x129, 0x139, 0x199, 0x1a9 };
+static const u8 NCT6116_REG_PWM_MODE[] = { 0xf3, 0xf3, 0xf3, 0xf3, 0xf3 };
+static const u8 NCT6116_PWM_MODE_MASK[] = { 0x01, 0x02, 0x04, 0x04, 0x04 };
+static const u16 NCT6116_REG_PWM_READ[] = { 0x4a, 0x4b, 0x4c, 0xd8, 0xd9 };
 static const u16 NCT6116_REG_FAN_MODE[] = { 0x113, 0x123, 0x133, 0x193, 0x1a3 };
 static const u16 NCT6116_REG_TEMP_SEL[] = { 0x110, 0x120, 0x130, 0x190, 0x1a0 };
 static const u16 NCT6116_REG_TEMP_SOURCE[] = {
@@ -3595,7 +3598,7 @@ int nct6775_probe(struct device *dev, struct nct6775_data *data,
 		break;
 	case nct6116:
 		data->in_num = 9;
-		data->pwm_num = 3;
+		data->pwm_num = 5;
 		data->auto_pwm_num = 4;
 		data->temp_fixed_num = 3;
 		data->num_temp_alarms = 3;
@@ -3629,9 +3632,9 @@ int nct6775_probe(struct device *dev, struct nct6775_data *data,
 		data->REG_PWM[2] = NCT6116_REG_FAN_STOP_OUTPUT;
 		data->REG_PWM[5] = NCT6106_REG_WEIGHT_DUTY_STEP;
 		data->REG_PWM[6] = NCT6106_REG_WEIGHT_DUTY_BASE;
-		data->REG_PWM_READ = NCT6106_REG_PWM_READ;
-		data->REG_PWM_MODE = NCT6106_REG_PWM_MODE;
-		data->PWM_MODE_MASK = NCT6106_PWM_MODE_MASK;
+		data->REG_PWM_READ = NCT6116_REG_PWM_READ;
+		data->REG_PWM_MODE = NCT6116_REG_PWM_MODE;
+		data->PWM_MODE_MASK = NCT6116_PWM_MODE_MASK;
 		data->REG_AUTO_TEMP = NCT6116_REG_AUTO_TEMP;
 		data->REG_AUTO_PWM = NCT6116_REG_AUTO_PWM;
 		data->REG_CRITICAL_TEMP = NCT6116_REG_CRITICAL_TEMP;
-- 
2.25.1


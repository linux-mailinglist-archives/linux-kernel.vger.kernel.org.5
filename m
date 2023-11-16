Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 445997ED959
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 03:25:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344582AbjKPCZE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 21:25:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235725AbjKPCYx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 21:24:53 -0500
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DDA841B2;
        Wed, 15 Nov 2023 18:24:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=hijft
        SCcjG/9boz0oEYP+nVxe7rLA+Dx/w2RlM3IhcM=; b=QgdDwbXnbs69uyuHTiUNJ
        9QLs+wt31XmvrnsGpX600Qy2/SACwcUHp3oPVFnAu8ZnVns2jlP/ldoe4VqxnAgt
        Oo2oW+GOOWmr2GsYzZPUy+jtC0zn0OoVTcqalz/geFI44Uli0IQKu7MBUvBRLely
        hFfmysW/EC8bqBShNZUv9Q=
Received: from localhost.localdomain (unknown [39.144.137.125])
        by zwqz-smtp-mta-g4-4 (Coremail) with SMTP id _____wD3H2U+fVVl5bnXDA--.19779S3;
        Thu, 16 Nov 2023 10:24:07 +0800 (CST)
From:   Xing Tong Wu <xingtong_wu@163.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     xingtong.wu@siemens.com, tobias.schaffner@siemens.com,
        gerd.haeussler.ext@siemens.com
Subject: [PATCH 1/3] hwmon: (nct6775) Fix incomplete register array
Date:   Thu, 16 Nov 2023 10:23:28 +0800
Message-Id: <20231116022330.2696-2-xingtong_wu@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231116022330.2696-1-xingtong_wu@163.com>
References: <20231116022330.2696-1-xingtong_wu@163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wD3H2U+fVVl5bnXDA--.19779S3
X-Coremail-Antispam: 1Uf129KBjvJXoW7ur1fXr1Dtry8uF1xur4xXrb_yoW8Gr1kpF
        ykXrWSy3Wrt3WavF43Ga1ru3W3Cwn7ArWIyw1UCw4SkFn5tFyxXF43KFyqywn0yFWfJa42
        9FykJFWYg3Z8CF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jqxRhUUUUU=
X-Originating-IP: [39.144.137.125]
X-CM-SenderInfo: p0lqw35rqjs4rx6rljoofrz/1tbiEAsq0F8YMgZlaQAAse
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_BL,RCVD_IN_MSPIKE_L4,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
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
 drivers/hwmon/nct6775-core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hwmon/nct6775-core.c b/drivers/hwmon/nct6775-core.c
index d928eb8ae5a3..2111f0cd9787 100644
--- a/drivers/hwmon/nct6775-core.c
+++ b/drivers/hwmon/nct6775-core.c
@@ -769,7 +769,7 @@ static const u16 NCT6106_FAN_PULSE_SHIFT[] = { 0, 2, 4 };
 
 static const u8 NCT6106_REG_PWM_MODE[] = { 0xf3, 0xf3, 0xf3 };
 static const u8 NCT6106_PWM_MODE_MASK[] = { 0x01, 0x02, 0x04 };
-static const u16 NCT6106_REG_PWM_READ[] = { 0x4a, 0x4b, 0x4c };
+static const u16 NCT6106_REG_PWM_READ[] = { 0x4a, 0x4b, 0x4c, 0xd8, 0xd9 };
 static const u16 NCT6106_REG_FAN_MODE[] = { 0x113, 0x123, 0x133 };
 static const u16 NCT6106_REG_TEMP_SOURCE[] = {
 	0xb0, 0xb1, 0xb2, 0xb3, 0xb4, 0xb5 };
@@ -3595,7 +3595,7 @@ int nct6775_probe(struct device *dev, struct nct6775_data *data,
 		break;
 	case nct6116:
 		data->in_num = 9;
-		data->pwm_num = 3;
+		data->pwm_num = 5;
 		data->auto_pwm_num = 4;
 		data->temp_fixed_num = 3;
 		data->num_temp_alarms = 3;
-- 
2.25.1


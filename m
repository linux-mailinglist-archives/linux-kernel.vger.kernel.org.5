Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D426B80223A
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Dec 2023 10:26:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233258AbjLCJZv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Dec 2023 04:25:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjLCJZt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Dec 2023 04:25:49 -0500
Received: from m15.mail.163.com (m15.mail.163.com [45.254.50.219])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 46AA5E8;
        Sun,  3 Dec 2023 01:25:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=WiReZGbdyXdM2Brh1y
        yxhHq+j+ZmAyhep9YRbr+YaAk=; b=fPp9aPxWZzgKmPZmx2gLz8ieKRnZ6MlGrg
        GLlW5YME/uqQXXkABbbXdLXOkHMfE+8ISbR7iPrvNVq0WZGlCAoRiQoAqzVjUtXT
        Twbw8hnHSRSQdTk8jChC/FTUzVEeUbH0uEwQAvx67BR8C/LLK5Eh3l2uYUg+Z6kW
        Z9jDT8fqw=
Received: from localhost.localdomain (unknown [39.144.190.5])
        by zwqz-smtp-mta-g1-4 (Coremail) with SMTP id _____wC3fxuLSWxlCBn1EQ--.215S2;
        Sun, 03 Dec 2023 17:25:31 +0800 (CST)
From:   Haoran Liu <liuhaoran14@163.com>
To:     jdelvare@suse.com
Cc:     linux@roeck-us.net, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, Haoran Liu <liuhaoran14@163.com>
Subject: [PATCH] [hwmon] pcf8591: Add error handling for i2c_smbus_write_byte
Date:   Sun,  3 Dec 2023 01:25:18 -0800
Message-Id: <20231203092518.38479-1-liuhaoran14@163.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: _____wC3fxuLSWxlCBn1EQ--.215S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7AF1DAr43Gw4UCF4fJw4kCrg_yoW8Ar43p3
        yDGws0kF1UJa17uan7tF48Wr13t3y8XrW7GrWDK3s5ZF45ZF92gFW8Ka4Fga4Uur93Z3W7
        Zw10qryY9F1UAFUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zifgA3UUUUU=
X-Originating-IP: [39.144.190.5]
X-CM-SenderInfo: xolxxtxrud0iqu6rljoofrz/1tbiZQc7gl8ZaX6O9QAAsx
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds error handling to the out0_enable_store function in
drivers/hwmon/pcf8591.c for the i2c_smbus_write_byte call. This issue was
identified through static analysis, which indicated that the function
previously did not handle potential failures of i2c_smbus_write_byte.
The lack of error handling could lead to silent failures and unpredictable
behavior in the PCF8591 driver.

Although the error addressed by this patch may not occur in the current
environment, I still suggest implementing these error handling routines
if the function is not highly time-sensitive. As the environment evolves
or the code gets reused in different contexts, there's a possibility that
these errors might occur. In case you find this addition unnecessary, I
completely understand and respect your perspective. My intention was to
enhance the robustness of the code, but I acknowledge that practical
considerations and current functionality might not warrant this change
at this point.

Signed-off-by: Haoran Liu <liuhaoran14@163.com>
---
 drivers/hwmon/pcf8591.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/hwmon/pcf8591.c b/drivers/hwmon/pcf8591.c
index 66c76b28c9e0..2a12b024214c 100644
--- a/drivers/hwmon/pcf8591.c
+++ b/drivers/hwmon/pcf8591.c
@@ -147,8 +147,12 @@ static ssize_t out0_enable_store(struct device *dev,
 		data->control |= PCF8591_CONTROL_AOEF;
 	else
 		data->control &= ~PCF8591_CONTROL_AOEF;
-	i2c_smbus_write_byte(client, data->control);
+	err = i2c_smbus_write_byte(client, data->control);
 	mutex_unlock(&data->update_lock);
+
+	if (err)
+		return err;
+
 	return count;
 }
 
-- 
2.17.1


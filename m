Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ACEF7D0AF7
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 10:55:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376539AbjJTIz4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 04:55:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376546AbjJTIzy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 04:55:54 -0400
Received: from mail.nfschina.com (unknown [42.101.60.195])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 96248D57;
        Fri, 20 Oct 2023 01:55:48 -0700 (PDT)
Received: from localhost.localdomain (unknown [180.167.10.98])
        by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPA id F1F88604889BB;
        Fri, 20 Oct 2023 16:55:35 +0800 (CST)
X-MD-Sfrom: suhui@nfschina.com
X-MD-SrcIP: 180.167.10.98
From:   Su Hui <suhui@nfschina.com>
To:     avifishman70@gmail.com, tmaimon77@gmail.com, tali.perry1@gmail.com,
        venture@google.com, yuenn@google.com, benjaminfair@google.com,
        jdelvare@suse.com, linux@roeck-us.net, thierry.reding@gmail.com,
        u.kleine-koenig@pengutronix.de
Cc:     Su Hui <suhui@nfschina.com>, openbmc@lists.ozlabs.org,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] hwmon: npcm750-pwm: add an error code check in npcm7xx_en_pwm_fan
Date:   Fri, 20 Oct 2023 16:55:19 +0800
Message-Id: <20231020085518.198477-1-suhui@nfschina.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

npcm7xx_pwm_config_set() can return '-ENODEV' for failed. So check
the value of 'ret' after calling npcm7xx_pwm_config_set().

Signed-off-by: Su Hui <suhui@nfschina.com>
---
 drivers/hwmon/npcm750-pwm-fan.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/hwmon/npcm750-pwm-fan.c b/drivers/hwmon/npcm750-pwm-fan.c
index 10ed3f4335d4..4702e4edc662 100644
--- a/drivers/hwmon/npcm750-pwm-fan.c
+++ b/drivers/hwmon/npcm750-pwm-fan.c
@@ -875,6 +875,8 @@ static int npcm7xx_en_pwm_fan(struct device *dev,
 	data->pwm_present[pwm_port] = true;
 	ret = npcm7xx_pwm_config_set(data, pwm_port,
 				     NPCM7XX_PWM_CMR_DEFAULT_NUM);
+	if (ret)
+		return ret;
 
 	ret = of_property_count_u8_elems(child, "cooling-levels");
 	if (ret > 0) {
-- 
2.30.2


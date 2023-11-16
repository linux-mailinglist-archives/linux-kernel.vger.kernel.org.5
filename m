Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DACB07ED9A7
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 03:39:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344494AbjKPCjo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 21:39:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235571AbjKPCjm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 21:39:42 -0500
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.216])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 02F6C19F;
        Wed, 15 Nov 2023 18:39:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=cHgkt
        6wFw4yulka3yAnNtGtv/ycgWvgfCPluWVrqKrA=; b=kzXMORIJgWIWLtVcRBc6+
        CHeJZmWclLrJHzUWHTD+48VXG07e45AXH1BXU+NO/pGWL7xLsEDaknuskHNX+f/W
        KOgLW4dXiv7qJfKdb+CRmIIygvCNbOEOhVNFbHJzS9ZrAIwaxMUXUIHczM5GU0Me
        CJcOEsJLJOxemzngAD7zUc=
Received: from localhost.localdomain (unknown [39.144.137.125])
        by zwqz-smtp-mta-g4-4 (Coremail) with SMTP id _____wD3H2U+fVVl5bnXDA--.19779S4;
        Thu, 16 Nov 2023 10:24:09 +0800 (CST)
From:   Xing Tong Wu <xingtong_wu@163.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     xingtong.wu@siemens.com, tobias.schaffner@siemens.com,
        gerd.haeussler.ext@siemens.com
Subject: [PATCH 2/3] hwmon: (nct6775) Fix logic error for PWM enable
Date:   Thu, 16 Nov 2023 10:23:29 +0800
Message-Id: <20231116022330.2696-3-xingtong_wu@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231116022330.2696-1-xingtong_wu@163.com>
References: <20231116022330.2696-1-xingtong_wu@163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wD3H2U+fVVl5bnXDA--.19779S4
X-Coremail-Antispam: 1Uf129KBjvdXoW7Wry8Kr4xXw17trWfGF4Uurg_yoWkKFX_Ww
        4rGrZ7Zw1Y9r13CF4jgF4rtFW2ka1UWr17Jw1xKa98J347AFn5Cr1kXrZxZrnru3yDZF93
        Xa1DAr4Iy342vjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUeo7K5UUUUU==
X-Originating-IP: [39.144.137.125]
X-CM-SenderInfo: p0lqw35rqjs4rx6rljoofrz/1tbiTA4q0GI0cSnRZAAAsD
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

The determination of the "pwm_enable" should be based solely on the mode,
regardless of the pwm value.
According to the specification, the default values for pwm and pwm_enable
are 255 and 0 respectively. However, there is a bug in the code where the
fan control is actually enabled, but the file "pwm_enable" incorrectly
displays "off", indicating that fan control is disabled. This contradiction
needs to be addressed and resolved.
Solution: Update the logic so that "pwm_enable" is determined by mode + 1,
remove the "off" value for "pwm_enable" since it is not specified in the
documentation.

Signed-off-by: Xing Tong Wu <xingtong.wu@siemens.com>
---
 drivers/hwmon/nct6775-core.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/hwmon/nct6775-core.c b/drivers/hwmon/nct6775-core.c
index 2111f0cd9787..575db6cb96e9 100644
--- a/drivers/hwmon/nct6775-core.c
+++ b/drivers/hwmon/nct6775-core.c
@@ -900,8 +900,6 @@ static const u16 NCT6116_REG_TSI_TEMP[] = { 0x59, 0x5b };
 
 static enum pwm_enable reg_to_pwm_enable(int pwm, int mode)
 {
-	if (mode == 0 && pwm == 255)
-		return off;
 	return mode + 1;
 }
 
-- 
2.25.1


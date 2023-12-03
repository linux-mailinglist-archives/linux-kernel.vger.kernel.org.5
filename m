Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C591480211D
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Dec 2023 06:33:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231392AbjLCFcL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Dec 2023 00:32:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjLCFcJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Dec 2023 00:32:09 -0500
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 54FE0FA;
        Sat,  2 Dec 2023 21:32:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=ahHhTIoYSuW4oEicRP
        fZHV0EEIBQvulbWrXXGWxCOmM=; b=XvUNJYkqX6ES1MpGQU5tjupJCMhggBgbx9
        JsJ844kAK5zlGURHSsHHO2wkH2EssxUt4n1uJvUcYEa7TW3f7BPvg07JuinM6XVJ
        cyukBIGDrZlB0oei2XvKNq+MIGEw/Wa35Qzu/k753g9njzuMFde2HxQ3UCepH50+
        Z5r5U/FOs=
Received: from localhost.localdomain (unknown [39.144.190.5])
        by zwqz-smtp-mta-g5-4 (Coremail) with SMTP id _____wDH11fPEmxlBd11CA--.4371S2;
        Sun, 03 Dec 2023 13:32:00 +0800 (CST)
From:   Haoran Liu <liuhaoran14@163.com>
To:     andi.shyti@kernel.org
Cc:     linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
        Haoran Liu <liuhaoran14@163.com>
Subject: [PATCH] [i2c] robotfuzz-osif: Add error handling for i2c_add_adapter in osif_probe
Date:   Sat,  2 Dec 2023 21:31:42 -0800
Message-Id: <20231203053142.37453-1-liuhaoran14@163.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: _____wDH11fPEmxlBd11CA--.4371S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Cw4xuryfGFy8AF1DJw1fJFb_yoW8Aw43pw
        4DKw4DCryUXwna93ZrJa18XryY93yrGFW7CF9rCws3Zan8JFyqqrWftFyS9a48GrZ7Za13
        Xryqv347CF1UAaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zifWr_UUUUU=
X-Originating-IP: [39.144.190.5]
X-CM-SenderInfo: xolxxtxrud0iqu6rljoofrz/1tbiwhA7glc668iM4AAAsJ
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_BL,
        RCVD_IN_MSPIKE_L4,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch introduces error handling for the i2c_add_adapter. This missing
error handling was identified through static analysis, revealing that the
function did not properly address potential failures of i2c_add_adapter.
Previously, such a failure could result in incomplete initialization of
the I2C adapter, leading to erratic behavior.

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
 drivers/i2c/busses/i2c-robotfuzz-osif.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-robotfuzz-osif.c b/drivers/i2c/busses/i2c-robotfuzz-osif.c
index 66dfa211e736..0f4d84449050 100644
--- a/drivers/i2c/busses/i2c-robotfuzz-osif.c
+++ b/drivers/i2c/busses/i2c-robotfuzz-osif.c
@@ -161,7 +161,12 @@ static int osif_probe(struct usb_interface *interface,
 		return ret;
 	}
 
-	i2c_add_adapter(&(priv->adapter));
+	ret = i2c_add_adapter(&(priv->adapter));
+	if (ret) {
+		dev_err(&interface->dev, "i2c_add_adapter failed: %d\n", ret);
+		usb_put_dev(priv->usb_dev);
+		return ret;
+	}
 
 	version = le16_to_cpu(priv->usb_dev->descriptor.bcdDevice);
 	dev_info(&interface->dev,
-- 
2.17.1


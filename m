Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AA8F767303
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 19:12:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233669AbjG1RMq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 13:12:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231792AbjG1RMg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 13:12:36 -0400
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C466035A9;
        Fri, 28 Jul 2023 10:12:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
        ; s=x; h=Subject:Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Cc:To
        :From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date
        :Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
        References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
        List-Owner:List-Archive; bh=iapXccHtapXvoYza5A60N8Syh4OAAzH77Y1/wEH0vXk=; b=I
        0VWY96Jm2YDqvFYQSB7OI5DXRYWy7LOpq1Ke+wKgqqr+Y7tow0tB3yUWkuOLthqrsDaLWjJnZ1huM
        xbXMA/qrT85Ez5dRVcrL1Xbl3lp/85pSVERXmZuVeGT5s0KZNqf8sJzNISb1zmxUz0AnmqRU8EH51
        LjlOdGXfEKBPdEUU=;
Received: from modemcable061.19-161-184.mc.videotron.ca ([184.161.19.61]:53782 helo=localhost.localdomain)
        by mail.hugovil.com with esmtpa (Exim 4.92)
        (envelope-from <hugo@hugovil.com>)
        id 1qPR0u-0003RD-Nz; Fri, 28 Jul 2023 13:12:29 -0400
From:   Hugo Villeneuve <hugo@hugovil.com>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     hugo@hugovil.com, Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 28 Jul 2023 13:12:12 -0400
Message-Id: <20230728171211.3016019-1-hugo@hugovil.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 184.161.19.61
X-SA-Exim-Mail-From: hugo@hugovil.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
Subject: [RESEND PATCH v2] rtc: pcf2127: add error checking when disabling POR0
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

If PCF2127 device is absent from the I2C bus, or if there is a
communication problem, disabling POR0 may fail silently and we
still continue with probing the device. In that case, abort probe
operation.

Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
---
V1 -> V2: Removed error message
---
 drivers/rtc/rtc-pcf2127.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-pcf2127.c b/drivers/rtc/rtc-pcf2127.c
index 78141bb06ab0..3387afe93417 100644
--- a/drivers/rtc/rtc-pcf2127.c
+++ b/drivers/rtc/rtc-pcf2127.c
@@ -1192,8 +1192,10 @@ static int pcf2127_probe(struct device *dev, struct regmap *regmap,
 	 * The "Power-On Reset Override" facility prevents the RTC to do a reset
 	 * after power on. For normal operation the PORO must be disabled.
 	 */
-	regmap_clear_bits(pcf2127->regmap, PCF2127_REG_CTRL1,
+	ret = regmap_clear_bits(pcf2127->regmap, PCF2127_REG_CTRL1,
 				PCF2127_BIT_CTRL1_POR_OVRD);
+	if (ret < 0)
+		return ret;
 
 	ret = regmap_read(pcf2127->regmap, pcf2127->cfg->reg_clkout, &val);
 	if (ret < 0)

base-commit: 3c87b351809f220294aec3c0df7b078ff5c5b15b
-- 
2.30.2


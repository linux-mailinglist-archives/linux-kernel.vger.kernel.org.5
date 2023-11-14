Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A95A37EB705
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 20:53:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232262AbjKNTxU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 14:53:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbjKNTxS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 14:53:18 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FAF1EB
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 11:53:14 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 473DBC433C8;
        Tue, 14 Nov 2023 19:53:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699991592;
        bh=p5bXNYWZQPXVZtSAziETIAWqwitA5MwvAafu84FIsRc=;
        h=Date:From:To:Cc:Subject:From;
        b=Xu1CUwPsb8NHywQsuf0ZjveiUXv6X56buMrIIKqhntvic2H0v69ZAGSIpnJd4JGXq
         x62nDwx5EpPDgApZdmHcRyahh3cgVMVMcqSQuN0tHGMd5q9TjcJIwdd/AJWnvOybct
         BxyPFjHQ59HKLzh3aSNwATPGQCZXSmpoR6nVlFQUmAr7+xOGmRx3sX2RfXekyk5/gt
         +j28UfzElp+1DtYEdQl6NrFRsLL/3A9eJGxe64yy2d+x6FMpIrgIhI3mVMPK7Dt7jN
         wbXRG4wrJ9T76vOS1vvmbqI5iODtF/BUyde4KI/XcWhpaW/SpEkp2mTjDlnDjaMqCo
         VYw7dCdZvPMYQ==
Date:   Tue, 14 Nov 2023 13:53:08 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@codeconstruct.com.au>
Cc:     linux-hwmon@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org
Subject: [PATCH v2][next] hwmon: (aspeed-pwm-tacho) Fix -Wstringop-overflow
 warning in aspeed_create_fan_tach_channel()
Message-ID: <ZVPQJIP26dIzRAr6@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Based on the documentation below, the maximum number of Fan tach
channels is 16:

Documentation/devicetree/bindings/hwmon/aspeed-pwm-tacho.txt:45:
 45 - aspeed,fan-tach-ch : should specify the Fan tach input channel.
 46                 integer value in the range 0 through 15, with 0 indicating
 47                 Fan tach channel 0 and 15 indicating Fan tach channel 15.
 48                 At least one Fan tach input channel is required.

However, the compiler doesn't know that, and legitimaly warns about a potential
overwrite in array `u8 fan_tach_ch_source[16]` in `struct aspeed_pwm_tacho_data`,
in case `index` takes a value outside the boundaries of the array:

drivers/hwmon/aspeed-pwm-tacho.c:
179 struct aspeed_pwm_tacho_data {
...
184         bool fan_tach_present[16];
...
193         u8 fan_tach_ch_source[16];
196 };

In function ‘aspeed_create_fan_tach_channel’,
    inlined from ‘aspeed_create_fan’ at drivers/hwmon/aspeed-pwm-tacho.c:877:2,
    inlined from ‘aspeed_pwm_tacho_probe’ at drivers/hwmon/aspeed-pwm-tacho.c:936:9:
drivers/hwmon/aspeed-pwm-tacho.c:751:49: warning: writing 1 byte into a region of size 0 [-Wstringop-overflow=]
  751 |                 priv->fan_tach_ch_source[index] = pwm_source;
      |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~
drivers/hwmon/aspeed-pwm-tacho.c: In function ‘aspeed_pwm_tacho_probe’:
drivers/hwmon/aspeed-pwm-tacho.c:193:12: note: at offset [48, 255] into destination object ‘fan_tach_ch_source’ of size 16
  193 |         u8 fan_tach_ch_source[16];
      |            ^~~~~~~~~~~~~~~~~~

Fix this by sanity checking `index` before using it to index arrays of
size 16 elements in `struct aspeed_pwm_tacho_data`. Also, pass `dev` as
argument to function `aspeed_create_fan_tach_channel()`, and add an error
message in case `index` is out-of-bounds, in which case return `-EINVAL`.

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
Changes in v2:
 - Pass `dev` to function aspeed_create_fan_tach_channel() and return
   -EINVAL in case of error. (Guenter)
 - Update changelog text.

v1:
 - Link: https://lore.kernel.org/linux-hardening/ZVJ7JBFoULzY3VGx@work/

 drivers/hwmon/aspeed-pwm-tacho.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/hwmon/aspeed-pwm-tacho.c b/drivers/hwmon/aspeed-pwm-tacho.c
index 997df4b40509..9a209e064e46 100644
--- a/drivers/hwmon/aspeed-pwm-tacho.c
+++ b/drivers/hwmon/aspeed-pwm-tacho.c
@@ -166,6 +166,8 @@
 
 #define MAX_CDEV_NAME_LEN 16
 
+#define MAX_ASPEED_FAN_TACH_CHANNELS 16
+
 struct aspeed_cooling_device {
 	char name[16];
 	struct aspeed_pwm_tacho_data *priv;
@@ -181,7 +183,7 @@ struct aspeed_pwm_tacho_data {
 	struct reset_control *rst;
 	unsigned long clk_freq;
 	bool pwm_present[8];
-	bool fan_tach_present[16];
+	bool fan_tach_present[MAX_ASPEED_FAN_TACH_CHANNELS];
 	u8 type_pwm_clock_unit[3];
 	u8 type_pwm_clock_division_h[3];
 	u8 type_pwm_clock_division_l[3];
@@ -190,7 +192,7 @@ struct aspeed_pwm_tacho_data {
 	u16 type_fan_tach_unit[3];
 	u8 pwm_port_type[8];
 	u8 pwm_port_fan_ctrl[8];
-	u8 fan_tach_ch_source[16];
+	u8 fan_tach_ch_source[MAX_ASPEED_FAN_TACH_CHANNELS];
 	struct aspeed_cooling_device *cdev[8];
 	const struct attribute_group *groups[3];
 };
@@ -737,7 +739,8 @@ static void aspeed_create_pwm_port(struct aspeed_pwm_tacho_data *priv,
 	aspeed_set_pwm_port_fan_ctrl(priv, pwm_port, INIT_FAN_CTRL);
 }
 
-static void aspeed_create_fan_tach_channel(struct aspeed_pwm_tacho_data *priv,
+static int aspeed_create_fan_tach_channel(struct device *dev,
+					   struct aspeed_pwm_tacho_data *priv,
 					   u8 *fan_tach_ch,
 					   int count,
 					   u8 pwm_source)
@@ -746,11 +749,17 @@ static void aspeed_create_fan_tach_channel(struct aspeed_pwm_tacho_data *priv,
 
 	for (val = 0; val < count; val++) {
 		index = fan_tach_ch[val];
+		if (index >= MAX_ASPEED_FAN_TACH_CHANNELS) {
+			dev_err(dev, "Invalid Fan Tach input channel %u\n.", index);
+			return -EINVAL;
+		}
 		aspeed_set_fan_tach_ch_enable(priv->regmap, index, true);
 		priv->fan_tach_present[index] = true;
 		priv->fan_tach_ch_source[index] = pwm_source;
 		aspeed_set_fan_tach_ch_source(priv->regmap, index, pwm_source);
 	}
+
+	return 0;
 }
 
 static int
@@ -874,7 +883,10 @@ static int aspeed_create_fan(struct device *dev,
 					fan_tach_ch, count);
 	if (ret)
 		return ret;
-	aspeed_create_fan_tach_channel(priv, fan_tach_ch, count, pwm_port);
+
+	ret = aspeed_create_fan_tach_channel(dev, priv, fan_tach_ch, count, pwm_port);
+	if (ret)
+		return ret;
 
 	return 0;
 }
-- 
2.34.1


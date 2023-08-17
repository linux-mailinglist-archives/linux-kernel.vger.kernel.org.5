Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2D8378015A
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 00:57:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355930AbjHQW4g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 18:56:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355929AbjHQW4E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 18:56:04 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FF6B35B1;
        Thu, 17 Aug 2023 15:55:45 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-689f4fb1c29so251043b3a.0;
        Thu, 17 Aug 2023 15:55:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692312945; x=1692917745;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LCpfZdhHwN0cJ+dKIsv8sSvOZjIO9PxxqA+4oQjnM2c=;
        b=ilxaw/kk+wQ56M9gruMq3WlbQMjm1mlNVsiS3TpqtyhI+7ws52oiYRWnDpo1TiEnoO
         NjAHeoLjz3bPI1N9II6wjG5JIN/6fFdZHpUcIdrm7XOACBuijD6CEu2YBKowx8y1WavM
         9B6srPxqHmYx++F+X0MmUX8x7YFROoJA4jpK26jVUcsl9qBphNywWMeEmG+h7rpyW548
         SUYB/aoOJC6ZryQn1CuLHKQUNLKxqDAhL23Dcn8Ws9viS7DHbHWSJoRmGuOnOWB92h3f
         heZH7AjuKz2kh3i0PpnoSHNBbvN5lRuFWp4rHPErmQR12jefTMSMemuIswI1+jzxuC1D
         3nsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692312945; x=1692917745;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LCpfZdhHwN0cJ+dKIsv8sSvOZjIO9PxxqA+4oQjnM2c=;
        b=CVqJG7zf1N4clVI/5L29azsuRxhkAwIlPu029tAbKowjJuTBByEWO93foJahaBPDAw
         M1A1hH81Wb6/L8jMo1LPXebCvAEV9pOYFAhJtzQcvw7v4yI1wdWIZ7CzyzavRXFvgOlz
         SYFSiTRjtc5Hjbg9hXSOS1NgiYMFzMo8u+yOrYGKsCC5k2af/PJnLZU2vY0/naUNshVo
         sAf8oGlKiw+BAzs7NjrGfvyDofcrX3t0RBsuVPqV5q/lrtGtNW81DGNA3LsYuh7IKwM6
         zeHQNizN2lznNmLu/bE1gGC1acgd5G+9iUhAhxp5jAJ5FHpkeDHsgZGBQfTqNEbbNqxX
         thAQ==
X-Gm-Message-State: AOJu0Yw2CwPhLgwHvfSXx+YG5JlTG43h9zbT4juF2bRE36ZoEkt6ENhB
        5GjsX38VHpUtJv6CmmnprkcMpDkMXl8=
X-Google-Smtp-Source: AGHT+IETSID4NTxh1GiMk0DRJbSIuuhVaQubNKekj5/hyAnYhj29A0UccByf7pSk/0VFXkGd5NbmDA==
X-Received: by 2002:a62:87c2:0:b0:688:66e0:2ea2 with SMTP id i185-20020a6287c2000000b0068866e02ea2mr4526903pfe.14.1692312944557;
        Thu, 17 Aug 2023 15:55:44 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id x8-20020aa793a8000000b00640ddad2e0dsm273722pff.47.2023.08.17.15.55.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Aug 2023 15:55:44 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Benson Leung <bleung@chromium.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        John Stultz <jstultz@google.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Brian Norris <briannorris@chromium.org>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH v2 3/7] rtc: cros-ec: Detect and report supported alarm window size
Date:   Thu, 17 Aug 2023 15:55:33 -0700
Message-Id: <20230817225537.4053865-4-linux@roeck-us.net>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230817225537.4053865-1-linux@roeck-us.net>
References: <20230817225537.4053865-1-linux@roeck-us.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The RTC on some older Chromebooks can only handle alarms less than
24 hours in the future. The only way to find out is to try to set
an alarm further in the future. If that fails, assume that the RTC
connected to the EC can only handle less than 24 hours of alarm
window, and report that value to the RTC core.

After that change, it is no longer necessary to limit the alarm time
when setting it. Report any excessive alarms to the caller instead.

Cc: Brian Norris <briannorris@chromium.org>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v2: Rename range_max_offset -> alarm_offset_max

 drivers/rtc/rtc-cros-ec.c | 38 +++++++++++++++++++++++---------------
 1 file changed, 23 insertions(+), 15 deletions(-)

diff --git a/drivers/rtc/rtc-cros-ec.c b/drivers/rtc/rtc-cros-ec.c
index 998ab8606f0b..0cd397c04ff0 100644
--- a/drivers/rtc/rtc-cros-ec.c
+++ b/drivers/rtc/rtc-cros-ec.c
@@ -182,21 +182,15 @@ static int cros_ec_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alrm)
 
 	ret = cros_ec_rtc_set(cros_ec, EC_CMD_RTC_SET_ALARM, alarm_offset);
 	if (ret < 0) {
-		if (ret == -EINVAL && alarm_offset >= SECS_PER_DAY) {
-			/*
-			 * RTC chips on some older Chromebooks can only handle
-			 * alarms up to 24h in the future. Try to set an alarm
-			 * below that limit to avoid suspend failures.
-			 */
-			ret = cros_ec_rtc_set(cros_ec, EC_CMD_RTC_SET_ALARM,
-					      SECS_PER_DAY - 1);
-		}
-
-		if (ret < 0) {
-			dev_err(dev, "error setting alarm in %u seconds: %d\n",
-				alarm_offset, ret);
-			return ret;
-		}
+		dev_err(dev, "error setting alarm in %u seconds: %d\n",
+			alarm_offset, ret);
+		/*
+		 * The EC code returns -EINVAL if the alarm time is too
+		 * far in the future. Convert it to the expected error code.
+		 */
+		if (ret == -EINVAL)
+			ret = -ERANGE;
+		return ret;
 	}
 
 	return 0;
@@ -355,6 +349,20 @@ static int cros_ec_rtc_probe(struct platform_device *pdev)
 	cros_ec_rtc->rtc->ops = &cros_ec_rtc_ops;
 	cros_ec_rtc->rtc->range_max = U32_MAX;
 
+	/*
+	 * The RTC on some older Chromebooks can only handle alarms less than
+	 * 24 hours in the future. The only way to find out is to try to set an
+	 * alarm further in the future. If that fails, assume that the RTC
+	 * connected to the EC can only handle less than 24 hours of alarm
+	 * window.
+	 */
+	ret = cros_ec_rtc_set(cros_ec, EC_CMD_RTC_SET_ALARM, SECS_PER_DAY * 2);
+	if (ret == -EINVAL)
+		cros_ec_rtc->rtc->alarm_offset_max = SECS_PER_DAY - 1;
+
+	(void)cros_ec_rtc_set(cros_ec, EC_CMD_RTC_SET_ALARM,
+			      EC_RTC_ALARM_CLEAR);
+
 	ret = devm_rtc_register_device(cros_ec_rtc->rtc);
 	if (ret)
 		return ret;
-- 
2.39.2


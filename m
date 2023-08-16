Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7480277E2CF
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 15:40:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245644AbjHPNkG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 09:40:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245607AbjHPNjs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 09:39:48 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCE3726A9;
        Wed, 16 Aug 2023 06:39:46 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id 98e67ed59e1d1-2685bcd046eso3603934a91.3;
        Wed, 16 Aug 2023 06:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692193186; x=1692797986;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ihRosdJY/MK1unL/lNrVSe4a2dGQokFzFvZLgmQopPI=;
        b=j+6XEUXTsqdJvltiCc3RvWq8Xnv9msec9ucrjipAkY0kRTmSTVx1T+O1TOMiifO6gO
         5ktmZjLTQ0wfS2qlhKcLhyaDF8ms++nZySlKpH0U8rCiL6w00YSSgDEhFONND6VolTPL
         byWnVQpd0HOLTjzONjNZnhsK+hdKRWALNz9jrC6o4KVNqRbkrOQOX0EqswwMaX8RTqpr
         6dWmqO7P78sQAoW5hhY+gBI9AKlLchnhV42KqNC8Lw+fFO+UWJSDKhuY6+PiRojLRVnr
         vaqQ4Qdc4KL7h8Qjyfa2r4WeiwhCSXKrEHV15v2NyCu7rkV3B9hPq7bDeLKxEFtS3c5U
         fwmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692193186; x=1692797986;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ihRosdJY/MK1unL/lNrVSe4a2dGQokFzFvZLgmQopPI=;
        b=IbMA74ZnaFSApDT0iK0stNFQGdxj8etBA9uumiQsoq4fwHwsU6c9kXsNhIA07EszC1
         rd8Xffltr8zwUSRyVe2yO0nj79z93/FaTl3JR0Jdt34Ddz07tn51uNuiBrhydNqfX/qr
         PTngcLl/biGNHVtdvzCyAquPqXytuObw5CRH2E3AndYhiWEjO+sXrgJeaM7jwRcHGKmP
         Ym4G0o3EgLhbVOJBNK/4x0BJXsQzmio2ifDBKEH4OG+Ia/OkZmXd6rmSPb4/KqdhOc5C
         NihNr/ErRP1VngDLDslr0kWvrzGE8c9sZY3Jjt3WpATMXA/hgfPM7Jj9yJzr5nTeriCr
         z0jQ==
X-Gm-Message-State: AOJu0YxwBaWwjLonozAKtEP27meVQgxldsMHC8v1mheCsfxvjMcesLJW
        QnJ9iElTgE8KU0sDfhKQ4dE=
X-Google-Smtp-Source: AGHT+IGMO4nj1foQwnCaomc9HozibnzXeEy7aZNnvHy+1Ii11lxEc3obNmdcpHAYsL1dtgB28BTMRw==
X-Received: by 2002:a17:90b:144:b0:26b:5334:5ee9 with SMTP id em4-20020a17090b014400b0026b53345ee9mr1273363pjb.36.1692193186333;
        Wed, 16 Aug 2023 06:39:46 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id pj1-20020a17090b4f4100b002696bd123e4sm11244252pjb.46.2023.08.16.06.39.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Aug 2023 06:39:45 -0700 (PDT)
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
Subject: [PATCH 3/7] rtc: cros-ec: Detect and report supported alarm window size
Date:   Wed, 16 Aug 2023 06:39:32 -0700
Message-Id: <20230816133936.2150294-4-linux@roeck-us.net>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230816133936.2150294-1-linux@roeck-us.net>
References: <20230816133936.2150294-1-linux@roeck-us.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
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
 drivers/rtc/rtc-cros-ec.c | 38 +++++++++++++++++++++++---------------
 1 file changed, 23 insertions(+), 15 deletions(-)

diff --git a/drivers/rtc/rtc-cros-ec.c b/drivers/rtc/rtc-cros-ec.c
index 998ab8606f0b..a257a24e8223 100644
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
+		cros_ec_rtc->rtc->range_max_offset = SECS_PER_DAY - 1;
+
+	(void)cros_ec_rtc_set(cros_ec, EC_CMD_RTC_SET_ALARM,
+			      EC_RTC_ALARM_CLEAR);
+
 	ret = devm_rtc_register_device(cros_ec_rtc->rtc);
 	if (ret)
 		return ret;
-- 
2.39.2


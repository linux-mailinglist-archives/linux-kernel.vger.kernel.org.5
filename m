Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1C05780158
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 00:56:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355922AbjHQW4C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 18:56:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356014AbjHQWz7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 18:55:59 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66C7835A9;
        Thu, 17 Aug 2023 15:55:42 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-688731c6331so266544b3a.3;
        Thu, 17 Aug 2023 15:55:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692312942; x=1692917742;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Afm+NiQNwJNxgSHXManGFdzn5pURQHFJTt32TcppGRs=;
        b=Qyi6pFUNh1WiwiFaT6NtB8p7aE8o7i4rTB8QYfHdMQ/sLh+XSnK6f17r3EM7sUwhBm
         PSA+Lw1/nH6QnJXHJO5b2JBdcugJB/CSCeLSrBdYZ0l8ZGyCy08FkCFTyG+zTzL5C8fj
         O2tEE1eD3wgL+ICyx8tgmCLAexobW8h+qBzyhv7Il8ECcofWNNgOy86Ekza3hlANGdVs
         sO8BsNRqtEpcvWskRb8YtO6YDe1sNyR21G7UkC0Y26eG49SqMj4Giw3wWz+dJZ6aglbW
         C76yOTNalvw8ehBCltWjEO3LNDo1cLiq/nZqAURLjGkRymCFH397a7dB03igx/QUiouW
         KPuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692312942; x=1692917742;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Afm+NiQNwJNxgSHXManGFdzn5pURQHFJTt32TcppGRs=;
        b=UM6oLNAGt8UuIUYZzN9kLvDJtHPY61VaOrLDcSqC7yNmYSIhZyRINYdvxBeqdmFTKn
         jwKUTpWwri76jjqqFEwxudbV3jBpMJ6L1g4CuMoiFQx++2DZ4j3tSwibKWtrh2I8ZAR/
         RvAJB0AWIYQ+RZLjRF984wC2I66tlriE9bEnTAX5ZYv2xnSZwuy10EXflJ4T5WTR5HXw
         /SvTor1FcV3JEMluAS3UUIg4D4AvYGNqDg6qrW0km2ZwQWw1H5/HAWggHclVrsToKSpU
         ezHzGjcxYCE2kx6i1KdsWwikKaYzz3tuuaz+IyuZTIgPWE2Yi1IwC9r/UyGj99vpnTw/
         mwZA==
X-Gm-Message-State: AOJu0YwonPwCWdvkyynoo7I2mJLyBhKU48u7SGq1gTHQIT8ediCZ/TMg
        19aPKlV4f1NLQCoG095wjVg=
X-Google-Smtp-Source: AGHT+IHXh5+8SBzcT5WXArnodjpAZ7fEmqjKq7ISWtld10M57mTeB1UG1Kpm+3MdJ8wt65OdEJxe4Q==
X-Received: by 2002:a05:6a20:3d84:b0:135:4858:681 with SMTP id s4-20020a056a203d8400b0013548580681mr1423362pzi.9.1692312941837;
        Thu, 17 Aug 2023 15:55:41 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id a21-20020aa780d5000000b00689f10adef9sm275424pfn.67.2023.08.17.15.55.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Aug 2023 15:55:41 -0700 (PDT)
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
Subject: [PATCH v2 1/7] rtc: Add support for limited alarm timer offsets
Date:   Thu, 17 Aug 2023 15:55:31 -0700
Message-Id: <20230817225537.4053865-2-linux@roeck-us.net>
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

Some alarm timers are based on time offsets, not on absolute times.
In some situations, the amount of time that can be scheduled in the
future is limited. This may result in a refusal to suspend the system,
causing substantial battery drain.

Some RTC alarm drivers remedy the situation by setting the alarm time
to the maximum supported time if a request for an out-of-range timeout
is made. This is not really desirable since it may result in unexpected
early wakeups.

To reduce the impact of this problem, let RTC drivers report the maximum
supported alarm timer offset. The code setting alarm timers can then
decide if it wants to reject setting alarm timers to a larger value, if it
wants to implement recurring alarms until the actually requested alarm
time is met, or if it wants to accept the limited alarm time.

Only introduce the necessary variable into struct rtc_device.
Code to set and use the variable will follow with subsequent patches.

Cc: Brian Norris <briannorris@chromium.org>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v2: Rename range_max_offset -> alarm_offset_max

 include/linux/rtc.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/rtc.h b/include/linux/rtc.h
index 1fd9c6a21ebe..4c0bcbeb1f00 100644
--- a/include/linux/rtc.h
+++ b/include/linux/rtc.h
@@ -146,6 +146,7 @@ struct rtc_device {
 
 	time64_t range_min;
 	timeu64_t range_max;
+	timeu64_t alarm_offset_max;
 	time64_t start_secs;
 	time64_t offset_secs;
 	bool set_start_time;
-- 
2.39.2


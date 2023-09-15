Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 343227A2240
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 17:23:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236078AbjIOPWy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 11:22:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236057AbjIOPWw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 11:22:52 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23380E6D;
        Fri, 15 Sep 2023 08:22:45 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id e9e14a558f8ab-34df2a961a0so7823285ab.2;
        Fri, 15 Sep 2023 08:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694791364; x=1695396164; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZAtiGPafozJ8Gn4LX27neNus+M3+xNnQ73f695UuZME=;
        b=ajnQ1nhkcm0HF8oqx83ps/MEr7N1R/VpBouAEz7GCKA/06uPYQpKxyMaVEvG/yCWjC
         508LqvzkbIojmjpRMDMJw5wndiM1g39r74SO60kQnbfQW5KjM0d+W7Pcfc/vp5iwnjWk
         BsXBcu75aHEOkjtKpTwHGDyNQRxmV1LqAd2K6chmGix9MROtkBFMGbqKIgtAG7XwlEqw
         DXZrgfpx5nolRS0utcjMbt5Tl7bl8aIEhHpvwBnUh7UXx+Iap9hamXEw9SxZOktN9CMT
         OXrgsSlFNGsv6vGDxL6YpRRQ2faOIcpB2jL5tZRODZEGCRpKyngXuCSEgH10yh+x8laQ
         KPEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694791364; x=1695396164;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZAtiGPafozJ8Gn4LX27neNus+M3+xNnQ73f695UuZME=;
        b=KOTBiLdpWVZD0jHs7viN96ajlwi74rI1Cfex5jgoFglTDvH9Xh4PsMgOuOX2AjF1je
         IhsaJ1g/T4XUXZnZMmlTeZyXYzzViagakOsBhv0KNHup6QaHRZhXEt7tA6Et9wsXqzyu
         9pJ6HHhryT/Lr9o1Q2Cl9jhvrfIGGhEUugFxU349IQNBZelBZ75v6L4XdTGPkclc+JKg
         qCXtk3q8KTQCnsLrwgXx7FeSMh3MGI9nlViwBYqqqjxHtoEl2ZMrkV9IWUtk63PJMXvd
         +lcsPP7IVY+wSfk/Chh1TK1WLBXARW7kj7DQkTtPIQQry0sRuOSyqGyQKJf5Jt+X/JF9
         ZOcA==
X-Gm-Message-State: AOJu0Yzaw7M+Zi0ZJXnmbAbfKZ/pFu67nufCSfTNn3oVZRp8pQmoxN/n
        V8UYxDrcMip0e/gWBtl3Mso=
X-Google-Smtp-Source: AGHT+IEMqvYGXPpyp187DW4V6iZ++iiCMH1c3qvl7ut2JsEYbu4dBNCiR6ZaxeRPkwugv/AjtsSMIw==
X-Received: by 2002:a05:6e02:1546:b0:34f:6f44:aec4 with SMTP id j6-20020a056e02154600b0034f6f44aec4mr2940164ilu.8.1694791364381;
        Fri, 15 Sep 2023 08:22:44 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id s27-20020a02cc9b000000b0043321a50c29sm1085612jap.93.2023.09.15.08.22.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 08:22:44 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        John Stultz <jstultz@google.com>
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Brian Norris <briannorris@chromium.org>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH v2 1/2] rtc: Add API function to return alarm time bound by rtc limit
Date:   Fri, 15 Sep 2023 08:22:37 -0700
Message-Id: <20230915152238.1144706-2-linux@roeck-us.net>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230915152238.1144706-1-linux@roeck-us.net>
References: <20230915152238.1144706-1-linux@roeck-us.net>
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

Add rtc_bound_alarmtime() to return the requested alarm timeout
bound by the maxmum alarm timeout that is supported by a given rtc.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v2: Added patch to provide API function

 include/linux/rtc.h | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/include/linux/rtc.h b/include/linux/rtc.h
index 4c0bcbeb1f00..5f8e438a0312 100644
--- a/include/linux/rtc.h
+++ b/include/linux/rtc.h
@@ -225,6 +225,23 @@ static inline bool is_leap_year(unsigned int year)
 	return (!(year % 4) && (year % 100)) || !(year % 400);
 }
 
+/**
+ * rtc_bound_alarmtime() - Return alarm time bound by rtc limit
+ * @rtc: Pointer to rtc device structure
+ * @requested: Requested alarm timeout
+ *
+ * Return: Alarm timeout bound by maximum alarm time supported by rtc.
+ */
+static inline ktime_t rtc_bound_alarmtime(struct rtc_device *rtc,
+					  ktime_t requested)
+{
+	if (rtc->alarm_offset_max &&
+	    rtc->alarm_offset_max * MSEC_PER_SEC < ktime_to_ms(requested))
+		return ms_to_ktime(rtc->alarm_offset_max * MSEC_PER_SEC);
+
+	return requested;
+}
+
 #define devm_rtc_register_device(device) \
 	__devm_rtc_register_device(THIS_MODULE, device)
 
-- 
2.39.2


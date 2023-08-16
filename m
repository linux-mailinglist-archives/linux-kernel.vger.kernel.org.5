Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBEB577E2CD
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 15:40:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245626AbjHPNkE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 09:40:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245603AbjHPNjo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 09:39:44 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9BD7B9;
        Wed, 16 Aug 2023 06:39:43 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1bdf4752c3cso15352565ad.2;
        Wed, 16 Aug 2023 06:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692193183; x=1692797983;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cPyeOQTHUIBx8cc+Tlz/Akt92G3Epi3WuhjRpP+czGE=;
        b=QgSe0DICMVH4IRWluBGO8+2roayy19LAu2pzIAEfoOXM9/KUE+DK17tR/W7tBbYDzN
         Z6D4KoHxn5GZgQ1nhLeseANBQ3XfnmKv/tgNOcoPRdFO3ovB1/W9Y8kBvvjMJzajxhET
         7+/Q6v3m9FZW3Aiw3IApFrlBXl3ocGZSUtJnL66sP6YiyCpirPV9vy6hwG+dqk5nO/sP
         CbrSgay46oSwBjrRiEl3VS1ac2g6L5qZG+qmCQaS/0eCjBBAz7Xd5aHJk8Y1/FRJOUrN
         OitiJrGWGJTYG1sWh2yn8oETYxbAYHXrOlsvz0739sQzToQskoQM3cnIW3cnZA0s7kot
         xZHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692193183; x=1692797983;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cPyeOQTHUIBx8cc+Tlz/Akt92G3Epi3WuhjRpP+czGE=;
        b=ZY0NUvv8NkyODcsrxHXd1MjSExUoib4Xv7Ex77FlSvupjZnTsNbslaoiBpSzQUB3d1
         gozbJuaJOgIdl7+MAblzh9pLLukvBIoISPsUYzb5osHBEc4kePaZHEwUa5EGr33KEV/a
         PCKx45LY+LxoeZaG8gKtpzPzDysrxNcafjbanmGx+ah9Vm0IBnnAacv+7xn+qqJdTd6T
         eUGQ0yPA7irFY0L08/3/vnbBAl8yK99ITuCALLdVfyia6oe95nG9GT791HANfp3VKE0m
         zH3gUdGDr3lPntWrHemXKglnqysliSsQ4O3HzjNosTAtpn5Uv2gb8oLV1WvAmYJmmTIm
         nJUA==
X-Gm-Message-State: AOJu0YwYxHBWOXK3pLz2EXHCd28iIIhCrKcL2F3GQjJ143F9Zlk4ph1o
        ffB0J6HAIGzI/o9L/5IdQbM=
X-Google-Smtp-Source: AGHT+IFAKTyPIvG2X5mhnjPAwP1/DDgYxP4XOiqgVhuJxWMcc5SaOG0HL7HBB90p8koUe9URm+73Aw==
X-Received: by 2002:a17:902:f687:b0:1bc:239:a7e3 with SMTP id l7-20020a170902f68700b001bc0239a7e3mr1873820plg.44.1692193183233;
        Wed, 16 Aug 2023 06:39:43 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id z17-20020a170903019100b001bbb25dd3a7sm13109199plg.187.2023.08.16.06.39.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Aug 2023 06:39:42 -0700 (PDT)
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
Subject: [PATCH 1/7] rtc: Add support for limited alarm timer offsets
Date:   Wed, 16 Aug 2023 06:39:30 -0700
Message-Id: <20230816133936.2150294-2-linux@roeck-us.net>
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
 include/linux/rtc.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/rtc.h b/include/linux/rtc.h
index 1fd9c6a21ebe..b6d000ab1e5e 100644
--- a/include/linux/rtc.h
+++ b/include/linux/rtc.h
@@ -146,6 +146,7 @@ struct rtc_device {
 
 	time64_t range_min;
 	timeu64_t range_max;
+	timeu64_t range_max_offset;
 	time64_t start_secs;
 	time64_t offset_secs;
 	bool set_start_time;
-- 
2.39.2


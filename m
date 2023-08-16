Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F041077E2D3
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 15:40:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245689AbjHPNkM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 09:40:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245614AbjHPNjx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 09:39:53 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79718B9;
        Wed, 16 Aug 2023 06:39:52 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1bdbbede5d4so43268625ad.2;
        Wed, 16 Aug 2023 06:39:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692193192; x=1692797992;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d76yf0kkuPRC+AKKl4TWbiPw6wxbxULc4AbwlRwABp4=;
        b=ofao/P4CjXWnKglZi97/m/ldfLwEYmeJpsXEgm7iicojJ3kBRebh/1vvCmwoBXXF/8
         cSVzLXbJtOZlNzHGWCoDKIFPYKCWfPhcJndcZScTasqitnrju39Zcp5VtvhoTSC3byZ1
         JiSAQf/ZsU9KrQ755WkaOAFsQA5WP6PIBDdw6nlC4yGn4jgf2i08f/F6RRNZrCJqa/FI
         Q3io3+ha2Jv5OcvQVkGTFP4hRDJsqHmWwJKj38gTx+M59Oqx17R4crASBxO154cFnFT8
         eUKQAN67DT8g6cpuwgUPuB37j1fF19G9dTCyo/NdNpsHYLdtUUhmRy9pO6IB9Ei5NJaN
         y3JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692193192; x=1692797992;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=d76yf0kkuPRC+AKKl4TWbiPw6wxbxULc4AbwlRwABp4=;
        b=ORLiyIQr/0NJUbQFeOGuYVoNz/wMNzSewh+l3iy89qy+87Kry3AsIsVxvBZ7CT8/qy
         aBe1zPT0LXmpFZYDClZ8JA0RkkCBt6NDwfzbsh2CT2PJuh5TZxwWNKJYhwg9nOIsZ0Pi
         SEQoGvpWm+NXsWij64pGzUUYNWkJeUkkk6gan+tKl5/I+nVic6dTMBiXXqKnVEoY2kfp
         o2SJGOuLaLx51wIagddfpSx6hnCKAzBEnmXmCLAFTx+G5q0yrRJoY3tcaHABtja0QPwc
         o3FDIx6uJ09GO0+qmuHl2eijmcjdyiz35ejCuLtC8K5XIDxdY6q0Rgbzpa+/sxG6g65u
         oPlA==
X-Gm-Message-State: AOJu0YytodPJ93WD9NMtowgKbmAJIEJWYC24TartIZgxNEovX5vN9urg
        zHLpYrcFw6O1QHeNUpd/djI=
X-Google-Smtp-Source: AGHT+IFD5zg4/aOd5Hc54/80YC6ZfwUPWqQT0UFrjbGHBB+jwT4nylLCL6IFSKVOJfuFyOkdH3deNw==
X-Received: by 2002:a17:902:c245:b0:1be:f53c:7d0e with SMTP id 5-20020a170902c24500b001bef53c7d0emr1326538plg.17.1692193191918;
        Wed, 16 Aug 2023 06:39:51 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id q23-20020a170902bd9700b001b03f208323sm13136251pls.64.2023.08.16.06.39.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Aug 2023 06:39:51 -0700 (PDT)
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
Subject: [PATCH 7/7] rtc: rzn1: Report maximum alarm limit to rtc core
Date:   Wed, 16 Aug 2023 06:39:36 -0700
Message-Id: <20230816133936.2150294-8-linux@roeck-us.net>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230816133936.2150294-1-linux@roeck-us.net>
References: <20230816133936.2150294-1-linux@roeck-us.net>
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

RZN1 only supports alarms up to one week in the future.
Report the limit to the RTC core.

Cc: Brian Norris <briannorris@chromium.org>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/rtc/rtc-rzn1.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/rtc/rtc-rzn1.c b/drivers/rtc/rtc-rzn1.c
index dca736caba85..c2cc3774ebb8 100644
--- a/drivers/rtc/rtc-rzn1.c
+++ b/drivers/rtc/rtc-rzn1.c
@@ -351,6 +351,7 @@ static int rzn1_rtc_probe(struct platform_device *pdev)
 
 	rtc->rtcdev->range_min = RTC_TIMESTAMP_BEGIN_2000;
 	rtc->rtcdev->range_max = RTC_TIMESTAMP_END_2099;
+	rtc->rtcdev->range_max_offset = 7 * 86400;
 	rtc->rtcdev->ops = &rzn1_rtc_ops;
 	set_bit(RTC_FEATURE_ALARM_RES_MINUTE, rtc->rtcdev->features);
 	clear_bit(RTC_FEATURE_UPDATE_INTERRUPT, rtc->rtcdev->features);
-- 
2.39.2


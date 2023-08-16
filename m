Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6F6E77E2D2
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 15:40:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245331AbjHPNkK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 09:40:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245613AbjHPNjv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 09:39:51 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2078AB9;
        Wed, 16 Aug 2023 06:39:51 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1bc0d39b52cso40934825ad.2;
        Wed, 16 Aug 2023 06:39:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692193190; x=1692797990;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gfkxgCro4+L45RC2QsVAG3wTRHrrj5/vZOr+R6i9gWw=;
        b=DUz9cIY+fwZ2URaZU3pCgx+LgQ6oNQI4z44tjyMxO0IxdmMXMSwoDiCqUaj/zDFH0l
         O/bjrvn7M9uZguMH6udcSjeBq9QWSavVweUwykwtgYyf60xQi9kScBH78i9FloiTKWKx
         6jpTJY71jy1bbw/IQGWGYzuGJmgVL0cw+Z8SFzwnvQsDwuq3Tkwd9AyPX/dB6/2+6pf0
         1D0eRbV9pFboS+Md2/SBZ4U6oS/ttaF+nNOnK4bIS+4OgosjmSh1lpJ6bl95/VufEltu
         EPR+aj4fj65RNtxSEisnrdKWIX9IScDR8gUnjaCf665WNZ122gUj2uaZ01YCLZTyReVe
         5cNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692193190; x=1692797990;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gfkxgCro4+L45RC2QsVAG3wTRHrrj5/vZOr+R6i9gWw=;
        b=RrLCgmeFPIMiPo+sAJGgvFF7ted19Gt23f8o5ozefsDOAKMsp0jgIVhVVll/mvLxbC
         LB2EmYtN9/p2TC7/OkUVLNjOfZLQ1vfIsMHYhTxWgBuiIFAjNCFIqfdJJCWacjlatZwh
         hE95hrcJ+MZzyxsvBgiF8QWabzXJLfA7CvDLobSgzTDre7aR9AhBye3Fuj36Rh7LJN5p
         31190cEd0ulBBohlhXe2tRa4p7Ow31a/qzAiyF0/aU6ifNLwx7MBoAyPabW0cbVpUZ0P
         Esbe/uZN+khlS9+okXxqqV/u5VHqKqaeFYTP2HQn/Sf9qho8FvnEP149gcZYHmkAfTRc
         PuyQ==
X-Gm-Message-State: AOJu0Yz5ErzLQvD283johkdX0CKW9qMm4HOI1S1Lx6kMxFNIk4nZ5fdM
        SuFAVQjZn2o9ThA5lGRpBjY=
X-Google-Smtp-Source: AGHT+IFj6fQJuykGL8H52OYKdULc3bpM1hqabBo/wnKyxLuffi6wgNK/fMzNTtsy9xxHDq9AJm6PAg==
X-Received: by 2002:a17:902:bc41:b0:1be:e8d4:19ae with SMTP id t1-20020a170902bc4100b001bee8d419aemr1668262plz.36.1692193190575;
        Wed, 16 Aug 2023 06:39:50 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id x20-20020a170902ea9400b001b9de67285dsm13203209plb.156.2023.08.16.06.39.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Aug 2023 06:39:50 -0700 (PDT)
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
Subject: [PATCH 6/7] rtc: ds1305: Report maximum alarm limit to rtc core
Date:   Wed, 16 Aug 2023 06:39:35 -0700
Message-Id: <20230816133936.2150294-7-linux@roeck-us.net>
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

DS1305 only supports alarms up to 24 hours in the future.
Report the limit to the RTC core.

If the alarm is too large when trying to set an alarm, return -ERANGE
instead of -EDOM to align with error codes returned by other rtc drivers.

Cc: Brian Norris <briannorris@chromium.org>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/rtc/rtc-ds1305.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-ds1305.c b/drivers/rtc/rtc-ds1305.c
index ed9360486953..1d9bbf4e06cb 100644
--- a/drivers/rtc/rtc-ds1305.c
+++ b/drivers/rtc/rtc-ds1305.c
@@ -337,7 +337,7 @@ static int ds1305_set_alarm(struct device *dev, struct rtc_wkalrm *alm)
 	if (later <= now)
 		return -EINVAL;
 	if ((later - now) > 24 * 60 * 60)
-		return -EDOM;
+		return -ERANGE;
 
 	/* disable alarm if needed */
 	if (ds1305->ctrl[0] & DS1305_AEI0) {
@@ -691,6 +691,7 @@ static int ds1305_probe(struct spi_device *spi)
 	ds1305->rtc->ops = &ds1305_ops;
 	ds1305->rtc->range_min = RTC_TIMESTAMP_BEGIN_2000;
 	ds1305->rtc->range_max = RTC_TIMESTAMP_END_2099;
+	ds1305->rtc->range_max_offset = 24 * 60 * 60;
 
 	ds1305_nvmem_cfg.priv = ds1305;
 	status = devm_rtc_register_device(ds1305->rtc);
-- 
2.39.2


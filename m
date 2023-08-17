Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5ADB5780165
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 00:57:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355992AbjHQW4o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 18:56:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355940AbjHQW4I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 18:56:08 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EB823594;
        Thu, 17 Aug 2023 15:55:49 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1bf1935f6c2so2389855ad.1;
        Thu, 17 Aug 2023 15:55:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692312948; x=1692917748;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t6uAKnykE3/ora4oCsRY4juR6xwaJtjAdt7QYyhHpdk=;
        b=dc79vIJ/WE76Iq/R8Hs//FI+ZVKEBsQG/wRy6+H3AS3pjo5mxFFWHPjcr+uC0+9SZV
         O0LQHcTD3LaoAcJ3St+DFoNawCOow0fdMF3SRtxiPJ9LZs+SfXyloexmeYD7u8PT+qe5
         ExTUHE80thV6RImHv4GQ4Q+yZWDYLfY6SMn8JhfSFqPDvcFDDBRBfEkwMNlFnCnKMGrb
         SCovuXYCH6b4HOa99WCrHQppVyzffxzYRU7Ftvjg+gKXfizlWEEYIflT24IiVYnJHoCe
         B2rAkPP4XBKm3+GzAzPYWryR2jorrEye1wj079OmczNuBlIligdNxkV4zjD+MGp0+nw5
         9MlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692312948; x=1692917748;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=t6uAKnykE3/ora4oCsRY4juR6xwaJtjAdt7QYyhHpdk=;
        b=b7421w9u12KkF4Rw7/Up4PtVSIeeAM9KhxA5A72E6vtZhjoYdNU2kYFkUtFRW2yx/G
         cHIQDxhdXyCMeu4UUKiHy4UL3tSXoBZTEM1T6CZTAXrowN1k3BZg2CkOsJWEHsQJFZTb
         tBsgVpSSy/h5joV6360sIFB+eEYAM6HNwO4eRS5eNd0D1iNdPMSNkBlMzPGF7KNqtDaU
         XKLWEGhAUrCRNqXTFRNaIRNsXJ9qDr+q2gTn3dNj6k8q/YZ+m5ce5qfIZsgkcSz5D5lk
         5t26SqQ4X9cPUjG0mgbXUdTIDRejHQ+bS9j9Bzx5kyC6BfECqwKNmaLfCUEHXIcYPgNx
         p2ZA==
X-Gm-Message-State: AOJu0YzKYXQiIoXt+eDGUL6Ss6eAHpzV/RrSwJBOPfhK4fDzkbCEGiPo
        ep2vUMX00+ZNPim3c5SlykA=
X-Google-Smtp-Source: AGHT+IHxHgBCh+okSlstB38ITdbHEzRb7AOaLFKIZ6UTfREW8hAnGtFjaVRP6mnij4jiZY9TIvb8Sw==
X-Received: by 2002:a17:902:f0c4:b0:1bb:cd5a:ba53 with SMTP id v4-20020a170902f0c400b001bbcd5aba53mr3814702pla.14.1692312948529;
        Thu, 17 Aug 2023 15:55:48 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id y23-20020a170902b49700b001bb9aadfb04sm282269plr.220.2023.08.17.15.55.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Aug 2023 15:55:48 -0700 (PDT)
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
Subject: [PATCH v2 6/7] rtc: ds1305: Report maximum alarm limit to rtc core
Date:   Thu, 17 Aug 2023 15:55:36 -0700
Message-Id: <20230817225537.4053865-7-linux@roeck-us.net>
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

DS1305 only supports alarms up to 24 hours in the future.
Report the limit to the RTC core, and use the reported limit
to validate the requested alarm time when setting it.

If the alarm is too large when trying to set an alarm, return -ERANGE
instead of -EDOM to align with error codes returned by other rtc drivers.

Cc: Brian Norris <briannorris@chromium.org>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v2: Rename range_max_offset -> alarm_offset_max
    Use the new variable to validate the limit when setting the alarm

 drivers/rtc/rtc-ds1305.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/rtc/rtc-ds1305.c b/drivers/rtc/rtc-ds1305.c
index ed9360486953..d4de401548b4 100644
--- a/drivers/rtc/rtc-ds1305.c
+++ b/drivers/rtc/rtc-ds1305.c
@@ -336,8 +336,8 @@ static int ds1305_set_alarm(struct device *dev, struct rtc_wkalrm *alm)
 	/* make sure alarm fires within the next 24 hours */
 	if (later <= now)
 		return -EINVAL;
-	if ((later - now) > 24 * 60 * 60)
-		return -EDOM;
+	if ((later - now) > ds1305->rtc->alarm_offset_max)
+		return -ERANGE;
 
 	/* disable alarm if needed */
 	if (ds1305->ctrl[0] & DS1305_AEI0) {
@@ -691,6 +691,7 @@ static int ds1305_probe(struct spi_device *spi)
 	ds1305->rtc->ops = &ds1305_ops;
 	ds1305->rtc->range_min = RTC_TIMESTAMP_BEGIN_2000;
 	ds1305->rtc->range_max = RTC_TIMESTAMP_END_2099;
+	ds1305->rtc->alarm_offset_max = 24 * 60 * 60;
 
 	ds1305_nvmem_cfg.priv = ds1305;
 	status = devm_rtc_register_device(ds1305->rtc);
-- 
2.39.2


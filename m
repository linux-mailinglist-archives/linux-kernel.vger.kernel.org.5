Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B810C7CD0CD
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 01:33:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344288AbjJQXdI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 19:33:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230219AbjJQXdH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 19:33:07 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 488A692;
        Tue, 17 Oct 2023 16:33:06 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id 5614622812f47-3af604c3f8fso3893212b6e.1;
        Tue, 17 Oct 2023 16:33:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697585585; x=1698190385; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jjkHOk4Tl+PMz9btl3eeh+G4Ft68VD7L+21fdtBMWng=;
        b=ERyDOGyL/HopseXcs9wRWTtq9HZ09RM/nXnTM1/hAPi4+h/U/Snh+xb36+jWPiEwrd
         HS7JiQpeFQSVytJEsl/HoC56CJmRHu/34+KPUw+EwoxQOdVrXTT/2UrZaBRc19jtl8M+
         ILr0JK3Yb15dCEWaYP2cHBzkniRoXcC6t8NaZNkDMHTyzFllQeqpjPMjwns1T57euX2O
         LtIs19/8mShia4glY+xh4j3NUbvwFyen0Y0O8A7Stmnbd21xi2hj9RBgt5IWHV1/5gTf
         WZfg2b+ryFIOvwmPBBd4kKVyEBITfLuwcFJfpdK04OAwyTjdLhCHmFHVo6Be3JE47uDM
         LDpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697585585; x=1698190385;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jjkHOk4Tl+PMz9btl3eeh+G4Ft68VD7L+21fdtBMWng=;
        b=uOWsVEqUD7V/TzGpjfwsWW1JEKyRnfsyzALvc7TdwGePr4cEe+6dBJPuKALrPeRD85
         nuP0AHqyMTaAC0j0RBGHxET0B75npItrYU6oYg8LUOOWEqv//+26Gt/m6tkPeCh0JzqX
         /c/fmCatmhR80nJ73sHMGZ0NHm/OHPQZWVDBI02CSh41FOnSPWqmskl49cHqsZim2vme
         S2FS5pEuVC2E6EkhPeN5BgvjZVVsl9hNRFqrx+weOE3mFztRNCAhvZoTdbBS24mR9zQM
         im8GDMuFjfZF8M5+ayAvO8q6Li/LS4gw0BwEUJZfRudIp8kK6GBn+fxYk8M7/dSiMi9D
         K7tw==
X-Gm-Message-State: AOJu0YytrEKvDVCrr1WE0co9aFFM6N6hBVdcF7AFXd9ABKv2YUzgbAYk
        +T6mQvW58RyJiD5I8oAldRM=
X-Google-Smtp-Source: AGHT+IH6LQzdxhx6NuPouGkt6n49J3Xq8AODkPSJHAU/07oU3fWko2bM3AKlZ8s4Bm3ghLIMCot5dA==
X-Received: by 2002:a05:6808:683:b0:3ae:126b:8c2b with SMTP id k3-20020a056808068300b003ae126b8c2bmr3845643oig.30.1697585585476;
        Tue, 17 Oct 2023 16:33:05 -0700 (PDT)
Received: from lanran-u22.. ([169.235.25.167])
        by smtp.googlemail.com with ESMTPSA id s132-20020a63778a000000b005897bfc2ed3sm425848pgc.93.2023.10.17.16.33.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 16:33:04 -0700 (PDT)
From:   Haonan Li <lihaonan1105@gmail.com>
To:     Sergey Shtylyov <s.shtylyov@omp.ru>,
        Damien Le Moal <dlemoal@kernel.org>,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Haonan Li <lihaonan1105@gmail.com>
Subject: [PATCH] pata_lagacy: Handle failed ATA timing computation in opti82c46x_set_piomode
Date:   Tue, 17 Oct 2023 23:32:34 +0000
Message-Id: <20231017233234.2170437-1-lihaonan1105@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function opti82c46x_set_piomode utilizes the ata_timing_compute()
to determine the appropriate ATA timings for a given device. However,
in certain conditions where the ata_timing_find_mode() function does
not find a valid mode, ata_timing_compute() returns an error (-EINVAL),
leaving the tp struct uninitialized.

This patch checks the return value of ata_timing_compute().
This avoids any potential use of uninitialized `tp` struct in the
opti82c46x_set_piomode function.

Signed-off-by: Haonan Li <lihaonan1105@gmail.com>
---
 drivers/ata/pata_legacy.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/pata_legacy.c b/drivers/ata/pata_legacy.c
index 448a511cb..d94c365cb 100644
--- a/drivers/ata/pata_legacy.c
+++ b/drivers/ata/pata_legacy.c
@@ -579,12 +579,16 @@ static void opti82c46x_set_piomode(struct ata_port *ap, struct ata_device *adev)
 	clock = 1000000000 / khz[sysclk];
 
 	/* Get the timing data in cycles */
-	ata_timing_compute(adev, adev->pio_mode, &t, clock, 1000);
+	if (ata_timing_compute(adev, adev->pio_mode, &t, clock, 1000)) {
+		return;
+	}
 
 	/* Setup timing is shared */
 	if (pair) {
 		struct ata_timing tp;
-		ata_timing_compute(pair, pair->pio_mode, &tp, clock, 1000);
+		if (ata_timing_compute(pair, pair->pio_mode, &tp, clock, 1000)) {
+			return;
+		}
 
 		ata_timing_merge(&t, &tp, &t, ATA_TIMING_SETUP);
 	}
-- 
2.34.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CFDE77E2D1
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 15:40:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245669AbjHPNkJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 09:40:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245612AbjHPNju (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 09:39:50 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D05DB9;
        Wed, 16 Aug 2023 06:39:49 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1bdeb022738so18736305ad.0;
        Wed, 16 Aug 2023 06:39:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692193189; x=1692797989;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zuVG9z6rD8Z1emOxzWF+Wu0OPR+5zNm8bc9i/xho5n0=;
        b=gR/P4n3JUiSjnD3JC+BhiEuJub4OnAyFEDcQPCBTBJ+0ZcBpplxVi6H03t9I0ZOrJ2
         MRd8jhrbALXaQswEGEJW3P5kzv8zxOdH1R+1MHsfJNlWi8160irvmhMF3znVO2ga4upo
         zC9HakHJcPJhex0w6fFAHTxWU4iFWCjlsn1v3jPFs9mzbRuAPDrjp8ejOnwVPbZuKVWw
         Ah1J+L9d1wiQxgB2NvzvNG4kLHuyxYaLNeYQum3yIsjL+gxNyMuslXVNFniaJ7jbJT4Y
         QW+Aj4iLsXxkQ0cLbCPG9GBQIP+fdezdn9mN+r4RdgPhCFGfV/Qn5Zs1DMakq5YaMkib
         xBCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692193189; x=1692797989;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zuVG9z6rD8Z1emOxzWF+Wu0OPR+5zNm8bc9i/xho5n0=;
        b=QA605yz+lmXGwGe3oCVCnxH8xL2BfmCNfkWLRNJJdTky85Ko2k/1guUJOlNkQIXTEk
         knU0S1vnH7F7ize/SZSGDzyyaCzNBIQdYssenThcUOSd9Cmb361upbBPSjQhODaTGDU2
         Cu2i4f8lQxhGBx5HTPbD2AG1/xwskLB5tcb5uXgYVxPoU5u9VXhKWre55oK5/LnhU0Uw
         nwlri8T9n477SPWtWYHSAGHoVY0KCMWR3nq6HwznAXJrgxFmDmFN8lCau43FoRjZ9r/1
         YjCR++VgZCih6YemKcZA2HNFuy5sc+io1rswFlmBiHOPF+jBJKl0IXa/Z3TJSzRdFBJE
         Su0A==
X-Gm-Message-State: AOJu0Yx6otaPESgfAXc7XQZ2rUToTtpUibM6ux7dMTUmJBcE4Uv0YfLA
        umrx2gZ9FGwx6z5cx8d+cnU=
X-Google-Smtp-Source: AGHT+IEPuLNkCufxHrJfhz867CjjmhL9Y/QzQqqkZxRk6npZqHl4KzD/LbskCjEwCmQgYdkpITpgsQ==
X-Received: by 2002:a17:902:ea0c:b0:1b2:676d:1143 with SMTP id s12-20020a170902ea0c00b001b2676d1143mr3272394plg.15.1692193189077;
        Wed, 16 Aug 2023 06:39:49 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id r2-20020a170902be0200b001bbbbda70ccsm13138970pls.158.2023.08.16.06.39.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Aug 2023 06:39:48 -0700 (PDT)
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
Subject: [PATCH 5/7] rtc: tps6586x: Report maximum alarm limit to rtc core
Date:   Wed, 16 Aug 2023 06:39:34 -0700
Message-Id: <20230816133936.2150294-6-linux@roeck-us.net>
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

tps6586x only supports alarms up to 16,383 seconds in the future.
Report the limit to the RTC core.

Cc: Brian Norris <briannorris@chromium.org>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/rtc/rtc-tps6586x.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/rtc/rtc-tps6586x.c b/drivers/rtc/rtc-tps6586x.c
index 9f14e2475747..11f822d1b337 100644
--- a/drivers/rtc/rtc-tps6586x.c
+++ b/drivers/rtc/rtc-tps6586x.c
@@ -252,6 +252,7 @@ static int tps6586x_rtc_probe(struct platform_device *pdev)
 
 	rtc->rtc->ops = &tps6586x_rtc_ops;
 	rtc->rtc->range_max = (1ULL << 30) - 1; /* 30-bit seconds */
+	rtc->rtc->range_max_offset = ALM1_VALID_RANGE_IN_SEC;
 	rtc->rtc->start_secs = mktime64(2009, 1, 1, 0, 0, 0);
 	rtc->rtc->set_start_time = true;
 
-- 
2.39.2


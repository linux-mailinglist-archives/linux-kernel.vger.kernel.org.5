Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30DC47CD1E3
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 03:39:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344391AbjJRBi5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 21:38:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344264AbjJRBi4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 21:38:56 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4554FB6
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 18:38:55 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d9a3a98b34dso8768443276.3
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 18:38:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697593134; x=1698197934; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:mime-version
         :message-id:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PRbBSYkckHu7ywyVK16O5YWCw31g5EYOFJflhDv+v6I=;
        b=RQobtIpMdrkmTSa4eezkVWcMdiLZTRTK0UKrJQy74td4GmKP9wTw/B1xc89TjjzA7x
         SB02Z1UWaEFCSwQ/eeFy4HX9t31LYC3qSmJoGCY8UVYOOH7fDz3UBIwIcArmU+GxKeQi
         jlkHnz01RLU3vHk77GcOU5wVQDfCcRrI+wDw0ULrMuBoPFgQmRSRVVMzPogYG/Ez+X31
         WTdlus1ITkPaB01jngKt5z5DtyNz0fNcX4HUWkC3g/aB9M8DS0qmVocjo4VqsljecPOw
         d/gjJVrUFmDRv6zcytoT+uLyF5p7jGO8GckoBwWVf+jxaPvw0E76i8jWTKY4YfP3Ct8c
         MlaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697593134; x=1698197934;
        h=content-transfer-encoding:cc:to:from:subject:mime-version
         :message-id:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PRbBSYkckHu7ywyVK16O5YWCw31g5EYOFJflhDv+v6I=;
        b=FUeYO7y+2a7zG1elhwQ/AHSQRz+Cw9Xd8g47WIvO84NS4OD13pRd7Cz18NHONKREdg
         Y5AAmIPqfKyLFT6PW5U00otDeywWrhWBebzJrPISaCW8A0CA2iiVApxggK/1HXZCUgJf
         qqd9XL3IE52bnoGBLHzKUkbmqEZciYeWqZUHFejM00syQ4pWW7J8pvMubVgj1y8htcQM
         EtXkSAvqHDNw1A8Wb2C3sAzc7vZ1VLB89QWIXsGMl2X7cBDWKOXNJ8fdecGpXQih1l1i
         Bjgr5qsNMfWTHdgmjmdtBI9DB5Rar9nPJxPaS287zWHz/Y9Ih+OYls018WxE2LgxL3cM
         XpLg==
X-Gm-Message-State: AOJu0Yyn2nfzhiFyJFXfk53w/d0lNJ87vTFSF3cO0VY4K3JBDKEo/1MJ
        f7YlnXY0KeQcrF2cXLJ2c1vuh108dKAFWWI=
X-Google-Smtp-Source: AGHT+IGEQN/edD0PPNDjXxawE2hEiPZ/qA6cm9WFgILwf4NzofC0s4AuV/1wlCP0efb0T9cCGF9JcnBURGwjQ/M=
X-Received: from saravanak.san.corp.google.com ([2620:15c:2d:3:ccbc:adcd:73dd:74f3])
 (user=saravanak job=sendgmr) by 2002:a05:6902:102d:b0:d9c:2a58:b905 with SMTP
 id x13-20020a056902102d00b00d9c2a58b905mr108329ybt.9.1697593134476; Tue, 17
 Oct 2023 18:38:54 -0700 (PDT)
Date:   Tue, 17 Oct 2023 18:38:50 -0700
Message-Id: <20231018013851.3303928-1-saravanak@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.655.g421f12c284-goog
Subject: [PATCH v1] driver core: Release all resources during unbind before
 updating device links
From:   Saravana Kannan <saravanak@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Saravana Kannan <saravanak@google.com>,
        "=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=" 
        <u.kleine-koenig@pengutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Yang Yingliang <yangyingliang@huawei.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        James Clark <james.clark@arm.com>, kernel-team@android.com,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit fixes a bug in commit 9ed9895370ae ("driver core: Functional
dependencies tracking support") where the device link status was
incorrectly updated in the driver unbind path before all the device's
resources were released.

Fixes: 9ed9895370ae ("driver core: Functional dependencies tracking support=
")
Reported-by: "Uwe Kleine-K=C3=B6nig" <u.kleine-koenig@pengutronix.de>
Closes: https://lore.kernel.org/all/20231014161721.f4iqyroddkcyoefo@pengutr=
onix.de/
Signed-off-by: Saravana Kannan <saravanak@google.com>
Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Yang Yingliang <yangyingliang@huawei.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: James Clark <james.clark@arm.com>
---
 drivers/base/dd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index a528cec24264..0c3725c3eefa 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -1274,8 +1274,8 @@ static void __device_release_driver(struct device *de=
v, struct device *parent)
 		if (dev->bus && dev->bus->dma_cleanup)
 			dev->bus->dma_cleanup(dev);
=20
-		device_links_driver_cleanup(dev);
 		device_unbind_cleanup(dev);
+		device_links_driver_cleanup(dev);
=20
 		klist_remove(&dev->p->knode_driver);
 		device_pm_check_callbacks(dev);
--=20
2.42.0.655.g421f12c284-goog


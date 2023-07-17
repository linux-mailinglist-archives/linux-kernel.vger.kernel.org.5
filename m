Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CC7B756CD5
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 21:09:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230027AbjGQTJp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 15:09:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229968AbjGQTJn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 15:09:43 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBAFF1B3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 12:09:41 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1b8a8154f9cso30270595ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 12:09:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1689620981; x=1692212981;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=r6uasRoxo3I6LINUODhPvTsghfLDKOJtY1t6sJi/dUE=;
        b=acUhxK3V3gNbKrBg9uaBK2XhWeW4iS1n2cUrofZsbkhBKvWfQLWgdfMomfQ/ilmg3e
         +Tkc7dwXhn8inu52vRP1PWUrSiscaqeySlATb4DfjV9PoA9Gbm8hJiApTKDXj0k30I0K
         Yfhl1u8d9LpUcYbaBGPpmjO7dsqEF0EBi3eofl7rbxca9JYbTmjCIP7AYssycOTJBdh0
         tgFntY6IsCU0XBFGNgG2U5+/FfN/+1JqKIrS/mQni8QQBkxsShdSzbbnX3EuKE9+W8kl
         7J1ls/7LCQf2rAmcCkrGCnOFN6gcJ3BOpf1h4fzzOMKvC+JB7y82lOOvyOqbpRN0o/oa
         l2qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689620981; x=1692212981;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r6uasRoxo3I6LINUODhPvTsghfLDKOJtY1t6sJi/dUE=;
        b=dQNy6JhcPuqX/mibLX3zs4KbMz2WmfmdcMgV+GACMsfXmw6ku1M50yBHtHXbJ+NmRd
         KE45SFkVjJOJ70tootnCOSluwOQWZTx/d/EEQMDZTCTK/HsIHS+CchyMNfXyo3dCBS5w
         3Xr5rzOrOb1XMsAyoKgIRezhS7dxvsYl/kAqinymc3xW12DqC3E8uYpeYOVj3EZs3aL2
         eMwdR0s0A/CGXyZJ+MmPTabOf9WrmmWtiKQpydSpjOizykpp5QKByrGc4IKDRyNKS6fP
         Ew4RqTIh7u/co306aRBrFII9nPNpil3ggldasbZt3fm+Q2infiBGc8YMGTBf6guvPdG+
         pGyg==
X-Gm-Message-State: ABy/qLY5yKb/lDJWpXLSIjyNYmBqTY4RjlWWLZwn8azUT+Sp6l5h0Ci9
        qLmcpjAD1hERBb6XXyIw9GYA+w==
X-Google-Smtp-Source: APBJJlGsv4Of/eTxsE2yW4esubj7xgtpbKpon4eEjBP0rSH8kaO7OsUfGFmeh1d9S3QlR8bi608FZQ==
X-Received: by 2002:a17:902:c405:b0:1b6:783d:9ba7 with SMTP id k5-20020a170902c40500b001b6783d9ba7mr14739448plk.27.1689620981198;
        Mon, 17 Jul 2023 12:09:41 -0700 (PDT)
Received: from sw06.internal.sifive.com ([64.62.193.194])
        by smtp.gmail.com with ESMTPSA id ix19-20020a170902f81300b001b9d335223csm250057plb.26.2023.07.17.12.09.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jul 2023 12:09:40 -0700 (PDT)
From:   Samuel Holland <samuel.holland@sifive.com>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Support Opensource <support.opensource@diasemi.com>
Cc:     Samuel Holland <samuel.holland@sifive.com>,
        linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org
Subject: [PATCH] rtc: da9063: Mark the alarm IRQ as a wake IRQ
Date:   Mon, 17 Jul 2023 12:09:37 -0700
Message-Id: <20230717190937.1301509-1-samuel.holland@sifive.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This keeps the IRQ enabled during system suspend, if the RTC's wakeup
source is enabled. Since the IRQ is not required to wake from shutdown,
continue to add the wakeup source even if registering the wakeirq fails.
See commit 029d3a6f2f3c ("rtc: da9063: add as wakeup source").

Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

 drivers/rtc/rtc-da9063.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/rtc/rtc-da9063.c b/drivers/rtc/rtc-da9063.c
index ee2efb496174..2f5d60622564 100644
--- a/drivers/rtc/rtc-da9063.c
+++ b/drivers/rtc/rtc-da9063.c
@@ -11,6 +11,7 @@
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
+#include <linux/pm_wakeirq.h>
 #include <linux/regmap.h>
 #include <linux/rtc.h>
 #include <linux/slab.h>
@@ -496,6 +497,12 @@ static int da9063_rtc_probe(struct platform_device *pdev)
 		dev_err(&pdev->dev, "Failed to request ALARM IRQ %d: %d\n",
 			irq_alarm, ret);
 
+	ret = dev_pm_set_wake_irq(&pdev->dev, irq_alarm);
+	if (ret)
+		dev_warn(&pdev->dev,
+			 "Failed to set IRQ %d as a wake IRQ: %d\n",
+			 irq_alarm, ret);
+
 	device_init_wakeup(&pdev->dev, true);
 
 	return devm_rtc_register_device(rtc->rtc_dev);
-- 
2.40.1


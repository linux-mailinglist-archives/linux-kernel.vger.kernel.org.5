Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FC897841DE
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 15:21:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236060AbjHVNVK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 09:21:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235977AbjHVNVJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 09:21:09 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEF8618B;
        Tue, 22 Aug 2023 06:21:07 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-523bf06f7f8so5364566a12.1;
        Tue, 22 Aug 2023 06:21:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692710466; x=1693315266;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7u0D1vKsgp+LzrkxafeIdw43ha9lu5raeDJAVDWxoo8=;
        b=cZwaRC3X2zDR0oj+ZR+Axpm6IjYOrIyh4H6kiJ206iG3Q5SM6vHIsx+kyuS1vlXwWo
         AEEo2iAHs1W5XQ6iMxQRdIH+j1ZxXvksmhMcHQBtO0tub71ygab7VO5DCFtDDQoBSCYC
         fYcgtVIgs8AzwX7WoEhBp6iJljuIbcnrIRWZlGYB4D3/Tsc8llHgUriCRxs4KCBQ4jiw
         pFOetxlCOiNe68vpUHMaDqb+UHvYQ7hAFcmnKLgvkQ57ZYuJJTsKuXaCgOls1a5sfi0N
         0ShSVG95vUJOqCWzlsbqv6rejro/Hbk6p0jMxCRKjpFt1OqeRLxRRljwesXS/c3wUNca
         LzBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692710466; x=1693315266;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7u0D1vKsgp+LzrkxafeIdw43ha9lu5raeDJAVDWxoo8=;
        b=SGnWlesolpmzG/WrDSgbTAGue4r77WbLcRhA41fzinoGtz47ZjJbfu0M8ThPH89w9C
         ZMCkiJLQv5KAZGvskvYjNt0JCXqIhPLFiE9fzC/47IQ93vGH4cqD7obfijLXhi6OjX+Z
         +ebeyo+L1OZlRYPnOccIC5Jtb5fRFFNsOpqXw93mfddZaI3kzUBF8GOgne+0EH9XaSoN
         vnE5dkIEQjrZeOSCUPZd1Pvl7To1gpsNs/XuvWVIYfBiXpIzaQTdr/5txmo0HHd/xcqm
         jLqDnJdbi2hogNo/WTXhYbFMmt3sL2H37SaRAi1a/704GpUhJZjlq0rCRQ2z7PLjBjUU
         zj+w==
X-Gm-Message-State: AOJu0Yzj1xhquQhSyzFjlbq660rSC72JEXqyxfBnwCwtefbOX8b5mr52
        DKDkapN3LyxHMJ5n9sfajBX1uiVmOe/SXg==
X-Google-Smtp-Source: AGHT+IFUVTI6k19eR4xuknD+vKQzdm0gfqs/b2MGnOosJG8jTdAOtaVMgsMwmYfDYT+IAOu1YT3WmA==
X-Received: by 2002:a05:6402:648:b0:52a:943:9ab5 with SMTP id u8-20020a056402064800b0052a09439ab5mr4952530edx.31.1692710465748;
        Tue, 22 Aug 2023 06:21:05 -0700 (PDT)
Received: from localhost.localdomain ([102.39.140.247])
        by smtp.gmail.com with ESMTPSA id c4-20020aa7df04000000b00523b1335618sm7582034edy.97.2023.08.22.06.21.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Aug 2023 06:21:05 -0700 (PDT)
From:   Grant B Adams <nemith592@gmail.com>
Cc:     linux-omap@vger.kernel.org, tony@atomide.com,
        Grant B Adams <nemith592@gmail.com>,
        Sebastian Reichel <sre@kernel.org>, Bin Liu <b-liu@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: [PATCH 1/2] power: supply: Fix tps65217-charger vs vbus irq conflict
Date:   Tue, 22 Aug 2023 15:19:53 +0200
Message-Id: <20230822131953.19582-1-nemith592@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enabling the tps65217-charger driver/module causes an interrupt conflict
with the vbus driver resulting in a probe failure.
The conflict is resolved by changing both driver's threaded interrupt
request function from IRQF_ONESHOT to IRQF_SHARED.

Signed-off-by: Grant B Adams <nemith592@gmail.com>
---
 drivers/power/supply/tps65217_charger.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/supply/tps65217_charger.c b/drivers/power/supply/tps65217_charger.c
index a4bc9f2a10bc..6f68becdbfd0 100644
--- a/drivers/power/supply/tps65217_charger.c
+++ b/drivers/power/supply/tps65217_charger.c
@@ -238,7 +238,7 @@ static int tps65217_charger_probe(struct platform_device *pdev)
 	for (i = 0; i < NUM_CHARGER_IRQS; i++) {
 		ret = devm_request_threaded_irq(&pdev->dev, irq[i], NULL,
 						tps65217_charger_irq,
-						IRQF_ONESHOT, "tps65217-charger",
+						IRQF_SHARED, "tps65217-charger",
 						charger);
 		if (ret) {
 			dev_err(charger->dev,
-- 
2.34.1


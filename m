Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 649257E94E6
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 03:32:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232901AbjKMCc4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Nov 2023 21:32:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232584AbjKMCcy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Nov 2023 21:32:54 -0500
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A65FAB8
        for <linux-kernel@vger.kernel.org>; Sun, 12 Nov 2023 18:32:51 -0800 (PST)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-5bf5d6eaf60so40565987b3.2
        for <linux-kernel@vger.kernel.org>; Sun, 12 Nov 2023 18:32:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1699842771; x=1700447571; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JRTOkQAIxvqqyHp7IwShDoodnSKUTwTjnZNRiFS76Wk=;
        b=ZgnGRdwVxoipjMYHh/D2bfcvbYeUbUCHiPwnZBZshXoe6HhfYC9+9eXhABTNeCzP59
         ieY03kI0mt+0zK3oPcBSdLPa8F2yMDXGdWZeTn9nrS9b+S2CXgMLpyEjJCSwdq+qf9YL
         hp+tZ1nP0YcbKwJM3n0LF3RU02N8c7G3I4IzlWdC3d8WzGhLOEO9s70xPTCVGB6oBzin
         G/uPwQmz5UqsjhWsCk1WJo+oTUlHkBaz4953AiR2CUGmnDPHTNnrhViLGKpcv3MjkuMr
         eNL0NIcyubmJ6q2Nb9/mMqqytl9ZGC84znJsM4IMWsQft7I7Zl5huXXrp4NfnTISTdRr
         JLyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699842771; x=1700447571;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JRTOkQAIxvqqyHp7IwShDoodnSKUTwTjnZNRiFS76Wk=;
        b=onJnqmU+qG6Ow3l9vN+1ibSZLZoSIaC057ACoXRmSjOZSdefd52dJkHN8YFnMZT3Gg
         IMO7QcNZzVOIhYCgJkAQVr4t1XucNrGaBtktyzbQ4oPIdDATscQ6J1XG1KLUmdFCNPa9
         EQ2vkBVopSARNUAmfn0gKODqKESSmmUsp47A5IERPq67msK1i8JBRs8xe2vAG1Hd2Fyc
         2IKc47c9fJmP1Rz6Z3bHmkNAXoHtLDP8EoUmTV/fnkY7diLolE9UwUNlUZPmsnugVd5W
         BK68zSXXlz7wHNcc9yI84Lw7b8eGd+QlZNLqGu9V5Ij86QQ+rszd/bMO4/V+AmWEzeYc
         GcWg==
X-Gm-Message-State: AOJu0YygSEBSyDZ0zzHJC77q2rSNmlhrqK5iYYlt8gTqtVc1ojcC4EA7
        t5Drzhpd0vH8HyMc+/Q4WeZ3NQ==
X-Google-Smtp-Source: AGHT+IHrTceJ+TpoCZpIupL9IC+qT1b1tAzCHxEcPIUg1xI+sNkAyNWBP7csGLAU9+Wi7w1iFOxsNg==
X-Received: by 2002:a81:4113:0:b0:5a8:277f:b378 with SMTP id o19-20020a814113000000b005a8277fb378mr2806271ywa.1.1699842770781;
        Sun, 12 Nov 2023 18:32:50 -0800 (PST)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id n10-20020a056a000d4a00b006b725b2158bsm3026399pfv.41.2023.11.12.18.32.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Nov 2023 18:32:50 -0800 (PST)
From:   Samuel Holland <samuel.holland@sifive.com>
To:     Peter Korsgaard <peter@korsgaard.com>, Andrew Lunn <andrew@lunn.ch>
Cc:     Samuel Holland <samuel.holland@sifive.com>,
        Andi Shyti <andi.shyti@kernel.org>, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] i2c: ocores: Move system PM hooks to the NOIRQ phase
Date:   Sun, 12 Nov 2023 18:32:45 -0800
Message-ID: <20231113023249.1185682-1-samuel.holland@sifive.com>
X-Mailer: git-send-email 2.42.0
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

When an I2C device contains a wake IRQ subordinate to a regmap-irq chip,
the regmap-irq code must be able to perform I2C transactions during
suspend_device_irqs() and resume_device_irqs(). Therefore, the bus must
be suspended/resumed during the NOIRQ phase.

Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

Changes in v2:
 - Rebase on v6.7-rc1

 drivers/i2c/busses/i2c-ocores.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-ocores.c b/drivers/i2c/busses/i2c-ocores.c
index 041a76f71a49..e106af83cef4 100644
--- a/drivers/i2c/busses/i2c-ocores.c
+++ b/drivers/i2c/busses/i2c-ocores.c
@@ -771,8 +771,8 @@ static int ocores_i2c_resume(struct device *dev)
 	return ocores_init(dev, i2c);
 }
 
-static DEFINE_SIMPLE_DEV_PM_OPS(ocores_i2c_pm,
-				ocores_i2c_suspend, ocores_i2c_resume);
+static DEFINE_NOIRQ_DEV_PM_OPS(ocores_i2c_pm,
+			       ocores_i2c_suspend, ocores_i2c_resume);
 
 static struct platform_driver ocores_i2c_driver = {
 	.probe   = ocores_i2c_probe,
-- 
2.42.0


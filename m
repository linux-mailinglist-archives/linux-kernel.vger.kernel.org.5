Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18F0879CAB9
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 10:56:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231764AbjILI4K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 04:56:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233090AbjILI4G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 04:56:06 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2C2310C3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 01:56:02 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-401da71b7c5so60605795e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 01:56:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1694508961; x=1695113761; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dp0b1o9g+PpYZByhHPBV5mXBlVfc9hIIqUxUds48fFY=;
        b=igpTNQAj90LXMnpjJbjaNrUtiqCVkKFA2cuDB+sZpw9reqxf6WDyecoJpRhsRT8T2y
         uZXjLAO5fqhYJsyDKEMD5E5wOsDiAHEn8cnF3SEn0dLdtT8icU4HdscNmPWWj/aF6Bd7
         6SDs3v2YwhQpu4jkefneTlftxpGUFCrbtDgV0UsJawPa2YqRmUKGW1Obn6kSctoPUTkp
         FlAwU9O32ZsqBK5icuD746fy3EJ0sMsQ32w8v5cekqTGRummBu0scwCDuVpLzlIxdKqu
         Q3gU1h1SXyrXbeiRvVhtsJ1OAWrJWgVwBsuVq3GPPSY0gVfpCE2kotaQOAbsgyBVugU3
         ZwjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694508961; x=1695113761;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dp0b1o9g+PpYZByhHPBV5mXBlVfc9hIIqUxUds48fFY=;
        b=LHsmOrTe2sc44AweypMPvHTqTE92wYxtzi80T8YWfAD4sOHd05raxUXGReyuCRHUV8
         GFlj3nRQWD49HLd3sdxoc2G98Lx90II0cn4zxhhGcov/KtABYySrXanRkt3byGCOM4KH
         wLbwcgmnaRvw3I5I6E1ADho4xnYMi1S9pErlfYLo1bOmwEJtZuSoVqFTLZRjyJ7sOoHS
         1lC++vmP+37OJAVYV/8tyqOvwmn1sdAbLWk4/2kPMCl1pvu+d3msfj4qPWTdjC/OMlIC
         VozkqbjxBmjr7syIKog/XtyTzlxf9oJeS2KoPLQJ/YJb7EORmu5MscFbzA/f+liHiLeA
         paPg==
X-Gm-Message-State: AOJu0YzaaV0uEqqiD607QB0lO2ULSTXb2x72b5GvqbWRPHcZCi9Su1N9
        ICNe3xBu640QL/vdkMEzSJvT1Q==
X-Google-Smtp-Source: AGHT+IEGdAuxHqFncTMDy9cwwHgPV2kuOOsPnfdI9pJL2lWPhiJNk5A86SCwm/6/Qez344Ragzz09Q==
X-Received: by 2002:a5d:54d0:0:b0:319:8a5a:ab5e with SMTP id x16-20020a5d54d0000000b003198a5aab5emr8294912wrv.38.1694508961086;
        Tue, 12 Sep 2023 01:56:01 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:907f:4cd7:f0ae:6b2a])
        by smtp.gmail.com with ESMTPSA id d6-20020adfef86000000b00317ddccb0d1sm12310028wro.24.2023.09.12.01.56.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 01:56:00 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <marc.zyngier@arm.com>
Cc:     linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH 2/4] genirq/irq_sim: remove unused field from struct irq_sim_irq_ctx
Date:   Tue, 12 Sep 2023 10:55:39 +0200
Message-Id: <20230912085541.13682-3-brgl@bgdev.pl>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230912085541.13682-1-brgl@bgdev.pl>
References: <20230912085541.13682-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

The irqnum field is unused. Remove it.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 kernel/irq/irq_sim.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/irq/irq_sim.c b/kernel/irq/irq_sim.c
index dd76323ea3fd..f5ebb3ba6f9a 100644
--- a/kernel/irq/irq_sim.c
+++ b/kernel/irq/irq_sim.c
@@ -19,7 +19,6 @@ struct irq_sim_work_ctx {
 };
 
 struct irq_sim_irq_ctx {
-	int			irqnum;
 	bool			enabled;
 	struct irq_sim_work_ctx	*work_ctx;
 };
-- 
2.39.2


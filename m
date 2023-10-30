Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEEC67DBB24
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 14:54:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232227AbjJ3NyV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 09:54:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbjJ3NyT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 09:54:19 -0400
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62B87B3;
        Mon, 30 Oct 2023 06:54:17 -0700 (PDT)
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3b2b1af09c5so2225562b6e.0;
        Mon, 30 Oct 2023 06:54:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698674056; x=1699278856;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bonHmR4fbjmc64kWSY8Ujz6X/PEeEcKaN4Sq4MHNuq4=;
        b=kTAUceLaIx1FAVOrxVO/G3pH9hdZcXRY3NW+KNFm75HJSMfOjv4MNL0kpKBF+MTWpH
         UoVlo5C/8RakDz/OJ9PCsUv6SNZAEvaaR7YnQLCRQaYK4skfRU0W30qtPZ3pupi9dSiY
         OseT7bzmBqJjqqPdAFXHooIvBOgkx6lphb2+D5O5uvVSCmY4cGx0lghghH74p+286WB7
         fLCMKYEby8Icnum9DIjHICkiVpEO+An+lV30GJ2EBLtxOJfqev+Jb8iaZN3Gs06CFw11
         xwQGt1I3gD2DqklM9EQ9HzphcnOdBM30AV33gnjYPA6YB7dfu1R8oQmliqHWFLQYdiqV
         tkqQ==
X-Gm-Message-State: AOJu0YwpC7HIABNLkskgyyphks+m9iMD8GACH36iTemHpJBZPpwDAokR
        9JumYCNRRJFlgVrCNB47lpsMCGMiJA==
X-Google-Smtp-Source: AGHT+IEj06l9nIKYueD+FZJJk12ofHRcLHh21evmFKNi4n/sYcau3e90A8ByqUKu22u8pv7L38i38Q==
X-Received: by 2002:a05:6808:6399:b0:3a7:4161:44ee with SMTP id ec25-20020a056808639900b003a7416144eemr7557546oib.6.1698674056627;
        Mon, 30 Oct 2023 06:54:16 -0700 (PDT)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id i13-20020a056808030d00b003afe5617691sm1370651oie.12.2023.10.30.06.54.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Oct 2023 06:54:15 -0700 (PDT)
Received: (nullmailer pid 776890 invoked by uid 1000);
        Mon, 30 Oct 2023 13:54:14 -0000
From:   Rob Herring <robh@kernel.org>
To:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RESEND PATCH] opp: ti: Use device_get_match_data()
Date:   Mon, 30 Oct 2023 08:54:10 -0500
Message-ID: <20231030135411.776744-1-robh@kernel.org>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/opp/ti-opp-supply.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/drivers/opp/ti-opp-supply.c b/drivers/opp/ti-opp-supply.c
index 8f3f13fbbb25..e3b97cd1fbbf 100644
--- a/drivers/opp/ti-opp-supply.c
+++ b/drivers/opp/ti-opp-supply.c
@@ -18,6 +18,7 @@
 #include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/pm_opp.h>
+#include <linux/property.h>
 #include <linux/regulator/consumer.h>
 #include <linux/slab.h>
 
@@ -373,23 +374,15 @@ static int ti_opp_supply_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct device *cpu_dev = get_cpu_device(0);
-	const struct of_device_id *match;
 	const struct ti_opp_supply_of_data *of_data;
 	int ret = 0;
 
-	match = of_match_device(ti_opp_supply_of_match, dev);
-	if (!match) {
-		/* We do not expect this to happen */
-		dev_err(dev, "%s: Unable to match device\n", __func__);
-		return -ENODEV;
-	}
-	if (!match->data) {
+	of_data = device_get_match_data(dev);
+	if (!of_data) {
 		/* Again, unlikely.. but mistakes do happen */
 		dev_err(dev, "%s: Bad data in match\n", __func__);
 		return -EINVAL;
 	}
-	of_data = match->data;
-
 	dev_set_drvdata(dev, (void *)of_data);
 
 	/* If we need optimized voltage */
-- 
2.42.0


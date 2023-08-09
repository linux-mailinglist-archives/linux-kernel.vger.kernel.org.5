Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AD187768B1
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 21:26:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234038AbjHITZq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 15:25:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233898AbjHITZY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 15:25:24 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD3BC469E;
        Wed,  9 Aug 2023 12:24:20 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-3fe5695b180so766935e9.2;
        Wed, 09 Aug 2023 12:24:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691609059; x=1692213859;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NOt3f0g945aFYg2SZ1NDdkMZ84STg236RQcHRWkmfW4=;
        b=DDxHxGri9oTwwqQwxsLMJqYtCmUXCLVfQoRKZz019EmDezDldAKtMoovGpHPw18Cij
         kacubnX0HtFxd4gkNqKf8/U5wpskoEnAhPCz+QOzUbSU/JpdhiBDifGYzNKjgc8/ScQW
         69XA5ko2MvMS7GvlH+7Kcrja2Rmvk+7uop7dqjsUHzuEaokiGltfvELY/ix+9eB31gnH
         SQLapLpNtncXGyRFJ4Li/0QieX7e+oELRtK3ob01DFE1zO3cLpN2tqRgJEf4wUXmgNLi
         PSRwaMso4L8hTrnxaY2qT+CIqT+St+erwxgFJYev+adnvNfe3v+OKarePCYEfLhs43I6
         +zMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691609059; x=1692213859;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NOt3f0g945aFYg2SZ1NDdkMZ84STg236RQcHRWkmfW4=;
        b=Opl+kM8SS7/oagBVm9oF0fJlHVTMDm8JwMnFH/Q3FSLr9QlozSpfd402LtmytYY2fD
         sFvncnYdRPk3p5OMgBGJyroXHKSI6PBkB3HRMv8J/D3pOs1eorGX2nvx1VSunq057Bau
         PwxJRh/NHtd6Z0B4u1OVbPzeO7ubyoJ7qyVImEaSnef78FX/eHodAl6SPdthU6uKweo+
         t8wMrfLu812R6BKcpzTrH0Zw9Uj9HhoEydItW6e3ap+LX9rBJNlC9/Hnv8db6ivWK1nP
         +A6ehPTbZVEJZiSY/Cu5zpSKgzPIziW+qmcJSBaZI2baMgh/TnHGGEYX03s1IE2u6F/+
         jq+Q==
X-Gm-Message-State: AOJu0YzrjB/aor98j7sxabzOlvEcNIJDONU4MKznaSwmDHqIzMSXLqd3
        mMbJqsUwy65NPVbuYc7sVoQ=
X-Google-Smtp-Source: AGHT+IGYDpYRjob4tooKsa/vmj8iJrlfXsjhMGhyvtXGpMeKV4q7qO3jSQCFZ3uzukh96mh6T745DA==
X-Received: by 2002:a05:600c:3641:b0:3fb:e189:3532 with SMTP id y1-20020a05600c364100b003fbe1893532mr63223wmq.20.1691609059385;
        Wed, 09 Aug 2023 12:24:19 -0700 (PDT)
Received: from [127.0.1.1] ([91.230.2.244])
        by smtp.gmail.com with ESMTPSA id y9-20020a7bcd89000000b003fba6a0c881sm2776208wmj.43.2023.08.09.12.24.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 12:24:19 -0700 (PDT)
From:   Benjamin Bara <bbara93@gmail.com>
Date:   Wed, 09 Aug 2023 21:24:06 +0200
Subject: [PATCH v2 4/6] mfd: tps65219: Specify restart mode
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230809-pca9450-reboot-v2-4-b98b4f8139d5@skidata.com>
References: <20230809-pca9450-reboot-v2-0-b98b4f8139d5@skidata.com>
In-Reply-To: <20230809-pca9450-reboot-v2-0-b98b4f8139d5@skidata.com>
To:     Lee Jones <lee@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Tony Lindgren <tony@atomide.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        peng.fan@oss.nxp.com, rafael.j.wysocki@intel.com,
        Jerome Neanne <jneanne@baylibre.com>
Cc:     linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-omap@vger.kernel.org,
        Benjamin Bara <benjamin.bara@skidata.com>
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Benjamin Bara <benjamin.bara@skidata.com>

The current restart handler registration does not specify whether the
restart is a cold or a warm one. Instead, cold ones are typically
registered with a HIGH prio. Now, as do_kernel_restart() knows about the
type, the priorization is implicitly done (cold restarts are executed
first) and the reboot_mode kernel parameter (which is currently mostly
ignored) can be respected.

Signed-off-by: Benjamin Bara <benjamin.bara@skidata.com>
---
v2:
- improve commit message
---
 drivers/mfd/tps65219.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/mfd/tps65219.c b/drivers/mfd/tps65219.c
index 0e0c42e4fdfc..85752b93256e 100644
--- a/drivers/mfd/tps65219.c
+++ b/drivers/mfd/tps65219.c
@@ -278,12 +278,21 @@ static int tps65219_probe(struct i2c_client *client)
 		}
 	}
 
-	ret = devm_register_restart_handler(tps->dev,
-					    tps65219_restart_handler,
-					    tps);
+	ret = devm_register_cold_restart_handler(tps->dev,
+						 tps65219_restart_handler,
+						 tps);
 
 	if (ret) {
-		dev_err(tps->dev, "cannot register restart handler, %d\n", ret);
+		dev_err(tps->dev, "cannot register cold restart handler, %d\n", ret);
+		return ret;
+	}
+
+	ret = devm_register_warm_restart_handler(tps->dev,
+						 tps65219_restart_handler,
+						 tps);
+
+	if (ret) {
+		dev_err(tps->dev, "cannot register warm restart handler, %d\n", ret);
 		return ret;
 	}
 

-- 
2.34.1


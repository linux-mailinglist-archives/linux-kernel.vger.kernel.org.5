Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EA0A7768AD
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 21:25:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233905AbjHITZm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 15:25:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233830AbjHITZX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 15:25:23 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28A771FCC;
        Wed,  9 Aug 2023 12:24:19 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-3fe5eb84d8bso827625e9.2;
        Wed, 09 Aug 2023 12:24:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691609057; x=1692213857;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RfpbtjdcJpv0XZl6JBXl9uzE/kd/OCEJbio5jgIS0e8=;
        b=V8jffcHw146lNX+gH7aQ6rqWlq+TggBLwB3kM5kGUcBbBMC74bg0vz3qO1G4PUCdX4
         piPE70n6PcVNaQ+LgQLW5qApXsEI+n1IpuHXF8fOpgOsDydJdVfAovVKDSLg2weGs4jm
         8oGhg/BX7IoHEA4JLU5cZfgWMVUj8vsCE23Sst3Ktsjf/l8v73sWxQhecK62nHZXJfMr
         Erg5ywfdR88f7k6jSnWAx3JNk2eMN6f8V9juMA/PRV0CWXmYlqkTUVvRT3udiAiIeRjg
         cci8n4NZ0iyjn/kUwigB4sm2eZfdfDrb8oq5em642viUVpN5wm7at+3LGeCyNmZff0oJ
         WE0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691609057; x=1692213857;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RfpbtjdcJpv0XZl6JBXl9uzE/kd/OCEJbio5jgIS0e8=;
        b=YGbhyGnH+raOrRYGrM0JznkR7laLjfAJckdN9Nte9xm4jvRPgpPg62qQXSsJEcg5Kq
         B9kW/ONs4NSF63YlF83J3C9B6Ui6+fvqCSzWTJnxiDm+taW8SGYCfyIDU8o/8fMpwv4S
         +4f6cm1fnpb1azW2XtSSk2f7GWZRNS8I35TpZRhgfIXlhp5T/idmUAJOQdJyMTtMZKI7
         dFFs99UvK5WHrXSxhh/StKukgvwbfcTf4qH8JA/OVI9NdycM/zM8Ykn3ed3RHOj4sGNm
         +GJ2+C1PcVMNiRJLyJUDJhGo1SdgovPoMoFdgpwRV2anVrBSUFlpZq/mjY74brdKtmRy
         hFbg==
X-Gm-Message-State: AOJu0YxE6x/FT5oED3fVwU9h8dxTQRgmo6OW272XTcclPcGTTrZPduRb
        qfqCXD5EXBnhY0rqFVAY8OM=
X-Google-Smtp-Source: AGHT+IHDL05waSU4g7vB3tCasXp+dwqLWXUXoRWv+YR+q28V9nA9kHHezq781zwZk0LSTjWPM5OreA==
X-Received: by 2002:a05:600c:260d:b0:3f9:82f:bad1 with SMTP id h13-20020a05600c260d00b003f9082fbad1mr41677wma.40.1691609057577;
        Wed, 09 Aug 2023 12:24:17 -0700 (PDT)
Received: from [127.0.1.1] ([91.230.2.244])
        by smtp.gmail.com with ESMTPSA id y9-20020a7bcd89000000b003fba6a0c881sm2776208wmj.43.2023.08.09.12.24.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 12:24:17 -0700 (PDT)
From:   Benjamin Bara <bbara93@gmail.com>
Date:   Wed, 09 Aug 2023 21:24:04 +0200
Subject: [PATCH v2 2/6] mfd: rk8xx: Specify restart mode
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230809-pca9450-reboot-v2-2-b98b4f8139d5@skidata.com>
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
- use registration helper instead
---
 drivers/mfd/rk8xx-core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mfd/rk8xx-core.c b/drivers/mfd/rk8xx-core.c
index 11a831e92da8..7faf8e1189f7 100644
--- a/drivers/mfd/rk8xx-core.c
+++ b/drivers/mfd/rk8xx-core.c
@@ -696,9 +696,9 @@ int rk8xx_probe(struct device *dev, int variant, unsigned int irq, struct regmap
 		switch (rk808->variant) {
 		case RK809_ID:
 		case RK817_ID:
-			ret = devm_register_sys_off_handler(dev,
-							    SYS_OFF_MODE_RESTART, SYS_OFF_PRIO_HIGH,
-							    &rk808_restart, rk808);
+			ret = devm_register_cold_restart_handler(dev,
+								 &rk808_restart,
+								 rk808);
 			if (ret)
 				dev_warn(dev, "failed to register rst handler, %d\n", ret);
 			break;

-- 
2.34.1


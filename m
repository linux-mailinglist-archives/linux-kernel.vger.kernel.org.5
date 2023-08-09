Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 121F97768B4
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 21:26:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234028AbjHITZo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 15:25:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232708AbjHITZX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 15:25:23 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F636469B;
        Wed,  9 Aug 2023 12:24:20 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-3fe45481edfso978265e9.1;
        Wed, 09 Aug 2023 12:24:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691609059; x=1692213859;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4s4F1OhGM2F2vHHKOW1vWDCfOxzfDUM3DsLfi6qRr88=;
        b=I6x+QXcY+cv6IfbN56TTUsFWUztfXPH1E4RBbTtT7alc3mS6dkT3mjKmCRHcTdd8+x
         23RAyjDQBffMot+VZaj+tkawmDtro1SB2yjrDWxwI8ALA2oBJcOC9YbjIU7l2RQrzB4L
         HVlM+QEL5pQPNzXXg6u8N35KcXbEvmpSlU+gc79wul/x4iysTSzVzS8qo7kfoagW20un
         1eK2MQ7ovTmVXIiC00kIsdn3ZBODVGosd8QKz5mE7VesM+wUvfD9xG4+yZbCUBZpdstQ
         XDl/3kzOmB7/MxyE5etlHLBOnWIF2Prd/6vY4EUG1XCILi1DhDPUJ6JiJEx2TvwCf/eb
         Z3OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691609059; x=1692213859;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4s4F1OhGM2F2vHHKOW1vWDCfOxzfDUM3DsLfi6qRr88=;
        b=L+VhTz9I2314bdlBN56nM9b99eHtxUkqdv3EAKYAr834g6sXmkP04oWAKgx4OnhJPS
         4Ph1qE9CRG1Um/CudQfOGSvmIR4m2gDH4ipJDyigTp6oIrY5QkGa9LTpki1o7uqDnNnL
         YB/7fwHLCinLxKQWV5FZgUgVX4TQ1VGuWJ9ySTBf4VCMhl57NymNPy08c3I0+SE+Sufl
         w/0j8jzguhodDqYWo4Bxyz2xzJWM2z4LaTzXH1aWa2+AkLhyUtBUTVEFaAxnaOYeiIuH
         UY4s2ORWi4KGryuxsyNl8XelxzHHYbzrMeNxSB50iP9KlVWFD5svj7pZx1B3fvQISpZ/
         9ALg==
X-Gm-Message-State: AOJu0YxUbH/0c6cFcOUDx7asW5IMWMZg4U0xZM3Ym/VD0/k6aNOVvSbQ
        TUwczFk4r5i6vivqei74Q7o=
X-Google-Smtp-Source: AGHT+IGyKI26UZBMakZWSxNTY6XyqLZrn/T3u3x76uCrOLrwG3nqvBNVjn9MrLn7Kr5wTskrKIXcUQ==
X-Received: by 2002:a7b:c859:0:b0:3fe:4cbc:c34c with SMTP id c25-20020a7bc859000000b003fe4cbcc34cmr71618wml.24.1691609058434;
        Wed, 09 Aug 2023 12:24:18 -0700 (PDT)
Received: from [127.0.1.1] ([91.230.2.244])
        by smtp.gmail.com with ESMTPSA id y9-20020a7bcd89000000b003fba6a0c881sm2776208wmj.43.2023.08.09.12.24.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 12:24:18 -0700 (PDT)
From:   Benjamin Bara <bbara93@gmail.com>
Date:   Wed, 09 Aug 2023 21:24:05 +0200
Subject: [PATCH v2 3/6] soc/tegra: pmc: Specify restart mode
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230809-pca9450-reboot-v2-3-b98b4f8139d5@skidata.com>
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
        Benjamin Bara <benjamin.bara@skidata.com>,
        Thierry Reding <treding@nvidia.com>
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
restart is a cold or a warm one. Now, as do_kernel_restart() knows about
the type, the priorization is implicitly done (cold restarts are
executed first) and the reboot_mode kernel parameter (which is currently
mostly ignored) can be respected.

Acked-by: Thierry Reding <treding@nvidia.com>
Signed-off-by: Benjamin Bara <benjamin.bara@skidata.com>
---
v2:
- improve commit message
---
 drivers/soc/tegra/pmc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/tegra/pmc.c b/drivers/soc/tegra/pmc.c
index 162f52456f65..4f42febb9b0f 100644
--- a/drivers/soc/tegra/pmc.c
+++ b/drivers/soc/tegra/pmc.c
@@ -2962,7 +2962,7 @@ static int tegra_pmc_probe(struct platform_device *pdev)
 	}
 
 	err = devm_register_sys_off_handler(&pdev->dev,
-					    SYS_OFF_MODE_RESTART,
+					    SYS_OFF_MODE_RESTART_WARM,
 					    SYS_OFF_PRIO_LOW,
 					    tegra_pmc_restart_handler, NULL);
 	if (err) {

-- 
2.34.1


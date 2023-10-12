Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 963AD7C719E
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 17:35:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379449AbjJLPfv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 11:35:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232023AbjJLPfs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 11:35:48 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB0E4C0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 08:35:45 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-507975d34e8so238643e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 08:35:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697124944; x=1697729744; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zvD1jnafegL1HSx05hSXRJcdFWj9TTVTdBC34ZqJQ3k=;
        b=gik5tkszfGBl1UPg5O984TfmSGNW44zVnz+b+BXye37rOPk/NmJ1l/Lc1QhXRuvS0B
         Xn3agKWZyb57HFgvQZ0BYhiCeKh0efw0PKcyiZtUCr53Hc3LiC7cCh+o0xn9P/xvYxkC
         LhG51ASpaY7oOHdZcNFKGXI2pBIyTAO33rTMOtmeAND3feSByLEP53LxjYTK6waL2cKI
         uNSzsOJJNcuolPA4jodpWIr95utrHlJoYNzEjrLoc/223tpwkdzEaHOKfS4EHjDFYkoW
         TAx89neG1OCdPfxEtzQ1LXruN+Fc0qhdgyIUN1qlJNx9nyewvUZdQQFsK/lDTjF06Jg1
         S3jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697124944; x=1697729744;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zvD1jnafegL1HSx05hSXRJcdFWj9TTVTdBC34ZqJQ3k=;
        b=pnITtgvSjmTdyLEkCnqg4ZiEzCFcujWbZfiGxhMcCHEjIqFkAmgSst6xTyqCsYPz+O
         gzE7rmdNZ2eWlw+tY1iZ8VRxPTdXFNG3tjaNVA9xrbGha5ll/+1evt+C2c32W4M100Yz
         bkn4k5C7UeFYJX6CaoBcfq7dIYnzsNu+5TfreYt2Up5XMfAYsf0zgnJsYHFxPGeK6l5R
         6rEuN8QfPXdJxvfxHnDQfUkR7DcYyHFwiepUvdkhqwBTInzsxG1LaJMeIKFYdgcIryWn
         j7e0I5MqMnx+A4guiWrooWddwlSKJLr2aHdVcBm2BPVfeMaNYaKKoQDT+27CGFnM71vZ
         R8LQ==
X-Gm-Message-State: AOJu0YyXxljnf+bV94AEi4Kj6ITIKzq57PqK6+qBDMqsT87h21QmSBk0
        j8qvx4kjf6D94Bgzl1t8/TUy0A==
X-Google-Smtp-Source: AGHT+IG2J6ZaggkxrHVZijDYQcSetvij/yh8cAaq+gGH4ACdgxHWoPLrad2B09mo2iBnD1kTtZhPIA==
X-Received: by 2002:ac2:5e21:0:b0:502:ff3b:766f with SMTP id o1-20020ac25e21000000b00502ff3b766fmr17386917lfg.6.1697124943864;
        Thu, 12 Oct 2023 08:35:43 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-94-254-63-18.NA.cust.bahnhof.se. [94.254.63.18])
        by smtp.gmail.com with ESMTPSA id w32-20020a0565120b2000b005068d27e9a7sm2618008lfu.172.2023.10.12.08.35.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 08:35:43 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-tegra@vger.kernel.org
Subject: [PATCH 1/5] soc/tegra: pmc: Drop the ->opp_to_performance_state() callback
Date:   Thu, 12 Oct 2023 17:35:36 +0200
Message-Id: <20231012153536.101403-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231012152108.101270-1-ulf.hansson@linaro.org>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 7c41cdcd3bbe ("OPP: Simplify the over-designed pstate <->
level dance"), there is no longer any need for genpd providers to assign
the ->opp_to_performance_state(), hence let's drop it.

Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Jonathan Hunter <jonathanh@nvidia.com>
Cc: linux-tegra@vger.kernel.org
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/soc/tegra/pmc.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/soc/tegra/pmc.c b/drivers/soc/tegra/pmc.c
index 162f52456f65..f432aa022ace 100644
--- a/drivers/soc/tegra/pmc.c
+++ b/drivers/soc/tegra/pmc.c
@@ -1393,13 +1393,6 @@ tegra_pmc_core_pd_set_performance_state(struct generic_pm_domain *genpd,
 	return 0;
 }
 
-static unsigned int
-tegra_pmc_core_pd_opp_to_performance_state(struct generic_pm_domain *genpd,
-					   struct dev_pm_opp *opp)
-{
-	return dev_pm_opp_get_level(opp);
-}
-
 static int tegra_pmc_core_pd_add(struct tegra_pmc *pmc, struct device_node *np)
 {
 	struct generic_pm_domain *genpd;
@@ -1412,7 +1405,6 @@ static int tegra_pmc_core_pd_add(struct tegra_pmc *pmc, struct device_node *np)
 
 	genpd->name = "core";
 	genpd->set_performance_state = tegra_pmc_core_pd_set_performance_state;
-	genpd->opp_to_performance_state = tegra_pmc_core_pd_opp_to_performance_state;
 
 	err = devm_pm_opp_set_regulators(pmc->dev, rname);
 	if (err)
-- 
2.34.1


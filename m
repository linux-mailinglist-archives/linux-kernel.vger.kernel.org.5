Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5D3E752508
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 16:19:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230403AbjGMOTX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 10:19:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229949AbjGMOSZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 10:18:25 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0B66268D
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 07:18:23 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-4fb7589b187so1377342e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 07:18:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689257901; x=1691849901;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wg9EddzRzHTbuaah4rEsbuvldd37lcTULk63OCghvz0=;
        b=sRupa9nPdIbMWXYR9MCQvdEIulLVqLZzb83+phUYqZ7V0BNqtYwpqb0E/sKibMuPxY
         roudsnBWyk9D/3eQJ/qWrj+pfW+lssaxpIg3lPzPuaWit/aq1F//KfdQCJgaGtZjowLN
         jKTKEaouaN+KhdTSH5KUjDpOmzMo4B32MIJ3Ckz64HW0XZ3qiGZUT61eNxB4l2jHIaHs
         rcKi4Sgyt8Iu9rl8yYt8bc+/EvLW+4beqqrvGRzA+3bay3pCB8IdcRhTLgQcfAs5qPG/
         c+p0IvV5siP6cNE1MpWLIEo2VJSm8JJNppj/NPsrz5Za99OSC32JU+6NMgkeoJ1G4i5t
         lJNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689257901; x=1691849901;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wg9EddzRzHTbuaah4rEsbuvldd37lcTULk63OCghvz0=;
        b=S40so1Munb4Y24O/VTHO92Jn9cKsn2q6IOyTpOvfVylvwoFwn8pcG/VskprGz+y1XK
         7dAO/E8ptQAeRgk4yNOm32IynEIk1RojyCqRbPsg+BSaRZigfy9ALTIT8hHpOjeQNFUH
         C/gw3bk3FpOl5R+Ee0FFyHiNAqpI6bOTVzKT+7d1EOMCPAlQEVzhQkegpEhNuIDqRnMj
         FsohjZi8RiwX86Ya6cRMfZNnxgPHHxGTKpM0ppYi3cC5ONiDvfy7iFrE49eXbK6vKYOA
         sOs2wNIIYKu0JZ70gbZhl8GO2fX2LZVsnwYPXFmc0TYO5EiNQY0xuLYyxRkOiezPK2rL
         GX/w==
X-Gm-Message-State: ABy/qLbIP5QS0FFcP5BVf9TpR7klstY0L3kpOHkrE5rapfcpjuMq9J0d
        WzOJBB4b85Zh1/oo0XRNiEs3mg==
X-Google-Smtp-Source: APBJJlHHHzCAd2s4FvXf9+E1P9nGND6+Ni1aJCIrFXUvM3sjBMcA/3X27DJnYsEzQEjeYqNLhjz6Vg==
X-Received: by 2002:a05:6512:2251:b0:4f8:7568:e948 with SMTP id i17-20020a056512225100b004f87568e948mr1473269lfu.51.1689257901695;
        Thu, 13 Jul 2023 07:18:21 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-94-254-63-18.NA.cust.bahnhof.se. [94.254.63.18])
        by smtp.gmail.com with ESMTPSA id w28-20020ac2599c000000b004fb759964a9sm1132426lfn.168.2023.07.13.07.18.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jul 2023 07:18:21 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Nikunj Kela <nkela@quicinc.com>,
        Prasad Sodagudi <psodagud@quicinc.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 09/11] cpufreq: scmi: Add support to parse domain-id using #power-domain-cells
Date:   Thu, 13 Jul 2023 16:17:36 +0200
Message-Id: <20230713141738.23970-10-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230713141738.23970-1-ulf.hansson@linaro.org>
References: <20230713141738.23970-1-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The performance domain-id can be described in DT using the power-domains
property or the clock property. The latter is already supported, so let's
add support for the power-domains too.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Changes in v2:
	- New patch.

---
 drivers/cpufreq/scmi-cpufreq.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/cpufreq/scmi-cpufreq.c b/drivers/cpufreq/scmi-cpufreq.c
index 78f53e388094..b42f43d9bd89 100644
--- a/drivers/cpufreq/scmi-cpufreq.c
+++ b/drivers/cpufreq/scmi-cpufreq.c
@@ -72,13 +72,19 @@ static unsigned int scmi_cpufreq_fast_switch(struct cpufreq_policy *policy,
 
 static int scmi_cpu_domain_id(struct device *cpu_dev)
 {
-	struct of_phandle_args clkspec;
+	struct of_phandle_args domain_id;
 
 	if (of_parse_phandle_with_args(cpu_dev->of_node, "clocks",
-				       "#clock-cells", 0, &clkspec))
-		return -EINVAL;
+				       "#clock-cells", 0, &domain_id)) {
 
-	return clkspec.args[0];
+		if (of_parse_phandle_with_args(cpu_dev->of_node,
+					       "power-domains",
+					       "#power-domain-cells", 0,
+					       &domain_id))
+			return -EINVAL;
+	}
+
+	return domain_id.args[0];
 }
 
 static int
-- 
2.34.1


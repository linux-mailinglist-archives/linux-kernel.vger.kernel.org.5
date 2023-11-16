Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E0497EDEB4
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 11:43:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344981AbjKPKnh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 05:43:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345013AbjKPKna (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 05:43:30 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AD70B8
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 02:43:26 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1cc58219376so5875305ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 02:43:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700131406; x=1700736206; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=exfqg5Gy1TL1CFxTgMKzEKKiOxoyEHWs3MeOTbQpbPM=;
        b=oakk90eGdb/FNiJPskBRpKIq57Win0VAbBKOf+E4B/7IdKDzVD7ITZkmh6KdJQ2u9z
         Y7j+PyUb0WZ9ErwLXaMGDo7yCQjOpbV/idfDkKfph7kzKNuxznhQNZMEB5zit6nODio7
         sfJ6qLREHVGTPFix6winUMF0u4FeKb3JJ2bIK1UYN50q9ikI7Gpwg/+P2bYO8KZJIyM7
         MDWDcCsagV0OSNUV5fGCNLsdidfdSqgUrBbIzs3mr+0HMaCi8xNrfNLOM794o65fsys3
         w+WWA350h0bIHQjjpFNh+lcHeyJIZUBVqC5FVdNqV63aVMPzi7cuS7a9tzsbyq3SEyBv
         OR+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700131406; x=1700736206;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=exfqg5Gy1TL1CFxTgMKzEKKiOxoyEHWs3MeOTbQpbPM=;
        b=wbH+mA9lrAzJwfm/4RtRUb1Eb8TvWa1Ufe78GcaPjAoGS/dOPcVGhy4BOg622i8VIF
         THoFSsTXJKyCNHjWDjcBaozQrD1CC5S+F74JBnTJQDxRieFNqOyRT6vxpvgFYNBnCJt2
         Y5cszSNWr5LF9+vbncMwYsXyp3egfR8Uq3wBE42i+rcN0qvgJvaM14U95Ji8Tex8Y43i
         8wt9dk0jg9LgDJcAHexPkInmTiJQo1hG6mxCZMyHukFtI/XaEO/HqqYfUcYUlu833qJV
         pv/iBVHuWOVMoV35Apy0RyE04afwViso2KP5Ptr+99+bJDHwFMNVkWo12+2+UqZsdejH
         MYxw==
X-Gm-Message-State: AOJu0Yy7V+GR/6DBaZXOPUV1Tzdzx+MsIEcMbT0Z2XlOD9MeEg8mdUj9
        pFRUa20RA3Aq6nViUG3zGv/FxQ==
X-Google-Smtp-Source: AGHT+IEs0EGGMmo1oeYYkUgsL8ss6a7i6oyoEG3zWDZDx5n+X+ng1KMN/g8+LTbsbtgNIcCU9isEcw==
X-Received: by 2002:a17:90b:3e89:b0:281:40b:5a7a with SMTP id rj9-20020a17090b3e8900b00281040b5a7amr16857952pjb.8.1700131405640;
        Thu, 16 Nov 2023 02:43:25 -0800 (PST)
Received: from localhost ([122.172.82.6])
        by smtp.gmail.com with ESMTPSA id sr5-20020a17090b4e8500b00280c6f35546sm1307044pjb.49.2023.11.16.02.43.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Nov 2023 02:43:25 -0800 (PST)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Stephan Gerhold <stephan.gerhold@kernkonzept.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V3 3/3] OPP: Don't set OPP recursively for a parent genpd
Date:   Thu, 16 Nov 2023 16:13:07 +0530
Message-Id: <084b6088106da837abc43526c11d7d8bec850c5c.1700131353.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1700131353.git.viresh.kumar@linaro.org>
References: <cover.1700131353.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Like other frameworks (clk, regulator, etc.) genpd core too takes care
of propagation to performance state to parent genpds. The OPP core
shouldn't attempt the same, or it may result in undefined behavior.

Add checks at various places to take care of the same.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/opp/core.c | 16 +++++++++++++++-
 drivers/opp/of.c   |  7 +++++--
 2 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index e08375ed50aa..4f1ca84d9ed0 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -2392,6 +2392,12 @@ static int _opp_attach_genpd(struct opp_table *opp_table, struct device *dev,
 		return -EINVAL;
 	}
 
+	/* Genpd core takes care of propagation to parent genpd */
+	if (opp_table->is_genpd) {
+		dev_err(dev, "%s: Operation not supported for genpds\n", __func__);
+		return -EOPNOTSUPP;
+	}
+
 	/* Checking only the first one is enough ? */
 	if (opp_table->required_devs[0])
 		return 0;
@@ -2453,8 +2459,16 @@ static int _opp_set_required_devs(struct opp_table *opp_table,
 	if (opp_table->required_devs[0])
 		return 0;
 
-	for (i = 0; i < opp_table->required_opp_count; i++)
+	for (i = 0; i < opp_table->required_opp_count; i++) {
+		/* Genpd core takes care of propagation to parent genpd */
+		if (required_devs[i] && opp_table->is_genpd &&
+		    opp_table->required_opp_tables[i]->is_genpd) {
+			dev_err(dev, "%s: Operation not supported for genpds\n", __func__);
+			return -EOPNOTSUPP;
+		}
+
 		opp_table->required_devs[i] = required_devs[i];
+	}
 
 	return 0;
 }
diff --git a/drivers/opp/of.c b/drivers/opp/of.c
index 5a7e294e56b7..f9f0b22bccbb 100644
--- a/drivers/opp/of.c
+++ b/drivers/opp/of.c
@@ -339,8 +339,11 @@ static int _link_required_opps(struct dev_pm_opp *opp, struct opp_table *opp_tab
 	 */
 	if (required_table->is_genpd && opp_table->required_opp_count == 1 &&
 	    !opp_table->required_devs[0]) {
-		if (!WARN_ON(opp->level != OPP_LEVEL_UNSET))
-			opp->level = opp->required_opps[0]->level;
+		/* Genpd core takes care of propagation to parent genpd */
+		if (!opp_table->is_genpd) {
+			if (!WARN_ON(opp->level != OPP_LEVEL_UNSET))
+				opp->level = opp->required_opps[0]->level;
+		}
 	}
 
 	return 0;
-- 
2.31.1.272.g89b43f80a514


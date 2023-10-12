Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA1A67C71A1
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 17:36:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379300AbjJLPf7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 11:35:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235747AbjJLPf4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 11:35:56 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCF20D6
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 08:35:54 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-50305abe5f0so1558962e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 08:35:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697124953; x=1697729753; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vWEfZUnAs+DutIwU4c/k42cMnXYwnMbMTTHD3wX0MWE=;
        b=CyXIA+5jyGiZ5iNycRT7F7ZwiLgLYMwRpiakgCVXfDkiWLrVub6lTd9TvXnj6SNytl
         w4LqewHmJtbfV/ioQD21FR7VhkdNVwxQw+ZZy20kTqRWfdWM13cdRJfHpg8HKVPa7up+
         iS1wY+XDipaXEOX8EhvUYtTYaQ6/LVE1Qy3jlTYZZfVEZwp6mQrGfuO3ifsXe5+f0VIw
         yw49lbMO6LccC+u6KUtxxiSp6QDhalUh+igb0kGBXcu6kRMBsTH7idz4h4/HmUD9+OW1
         cFOqk0FJ0qZpSpwu4lb5gph846eIBY0Sv3C1IfU3xl6wI/Cgba4TO/Ab2HyndvQRblI0
         dTRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697124953; x=1697729753;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vWEfZUnAs+DutIwU4c/k42cMnXYwnMbMTTHD3wX0MWE=;
        b=thvPcphEppkhYE+hu2kdvxoroI6pe6cDyh1uiq6hTHaUVw9XMPO7RfY+oJ9+Mmlr9x
         p9wsgvALqk17/kQLff9TFNd4UNOipOHimqkYqmCUZcIpCysBZBPXNMuPHTCH2sKwSqtA
         ybaUI/X5oxnB03Z1vc+mfwMLiM/7GYzfrCaUjef9ZIBa77MM0TP1BG7nkoXgR+U1b1cI
         JD4XVuir5ZSugKl2rybHXQmW9yxHNEmga5kjwkyffW1+mJl+0WssR8EaDvSRoOUen5m2
         LYaoHeoKgeedY/uMOs8Iw/U/5IVzm3dd4XDu/y1oitH7dWFsqxlg9F++zy6EYl7WImaS
         X2DA==
X-Gm-Message-State: AOJu0YydMGJPbV9gbbfEBi8ApWxDQLyuCfuD+plcng+9g7E5c7oGn219
        FFG3eWqhDzj6DYy8mv26tC6I7w==
X-Google-Smtp-Source: AGHT+IG8itGKixiAzNO1JpjFZ3jLYlcAXlQ9Rg/ns33QDYBT5y3HudL4oj39XJwH7IsjxCBUH5GYlw==
X-Received: by 2002:a05:6512:118f:b0:500:adbd:43e9 with SMTP id g15-20020a056512118f00b00500adbd43e9mr26095749lfr.15.1697124953135;
        Thu, 12 Oct 2023 08:35:53 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-94-254-63-18.NA.cust.bahnhof.se. [94.254.63.18])
        by smtp.gmail.com with ESMTPSA id d13-20020ac25ecd000000b0050481565679sm2845814lfq.167.2023.10.12.08.35.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 08:35:52 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH 2/5] pmdomain: qcom: cpr: Drop the ->opp_to_performance_state() callback
Date:   Thu, 12 Oct 2023 17:35:50 +0200
Message-Id: <20231012153550.101425-1-ulf.hansson@linaro.org>
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

Cc: Bjorn Andersson <andersson@kernel.org>
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: linux-arm-msm@vger.kernel.org
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/pmdomain/qcom/cpr.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/pmdomain/qcom/cpr.c b/drivers/pmdomain/qcom/cpr.c
index 94a3f0977212..e9dd42bded6f 100644
--- a/drivers/pmdomain/qcom/cpr.c
+++ b/drivers/pmdomain/qcom/cpr.c
@@ -1424,12 +1424,6 @@ static const struct cpr_acc_desc qcs404_cpr_acc_desc = {
 	.acc_desc = &qcs404_acc_desc,
 };
 
-static unsigned int cpr_get_performance_state(struct generic_pm_domain *genpd,
-					      struct dev_pm_opp *opp)
-{
-	return dev_pm_opp_get_level(opp);
-}
-
 static int cpr_power_off(struct generic_pm_domain *domain)
 {
 	struct cpr_drv *drv = container_of(domain, struct cpr_drv, pd);
@@ -1698,7 +1692,6 @@ static int cpr_probe(struct platform_device *pdev)
 	drv->pd.power_off = cpr_power_off;
 	drv->pd.power_on = cpr_power_on;
 	drv->pd.set_performance_state = cpr_set_performance_state;
-	drv->pd.opp_to_performance_state = cpr_get_performance_state;
 	drv->pd.attach_dev = cpr_pd_attach_dev;
 
 	ret = pm_genpd_init(&drv->pd, NULL, true);
-- 
2.34.1


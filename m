Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB7A57AD8DC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 15:18:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231852AbjIYNS1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 09:18:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231829AbjIYNSO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 09:18:14 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A753112A
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 06:18:07 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2bff936e10fso90935011fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 06:18:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695647886; x=1696252686; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fsWOr9mWvmZX2dTzJ+FE4Q2Az+t23E8t0uKEFGAoZOI=;
        b=U+lFD7sQe5sx6HhehOqSxkdj/OGzQTs4Dbqn7qRYWEWfrhW83gX2ZKRMQ+w9tKJzfR
         9/NzaYUqQgVNtB0JX1JBZsie8+5jpsnjzh22dFDGf4L5u51F/8ijM7XhlV6Gg9npz2Jf
         7iKIWHcysRbDb6B8c4FRdYsZMV2gMIOopWSshEmWl6mockpkPVTRMhoUwAv3EgDQsUkT
         zu62iSCjhU4zuQjyN6EeYuNbIBlOMuf6flDKWqRR+HhdY1QjnhlkOoQxfofse393fwA7
         JXUX/Jd90HAB2eb8ebuNRvdLEyq93/2cp0jGt+ueJHR/GhHrLSxo9ahGY3pxMNCfRsN8
         L26w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695647886; x=1696252686;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fsWOr9mWvmZX2dTzJ+FE4Q2Az+t23E8t0uKEFGAoZOI=;
        b=u/xO/7xY5H4U4SzQ7aAwNwlBj9AkNFOlnKblXIRktlgN9W7Vx8xEqn8KQy7tw0fFW+
         iysjDeL/SeKy/MwKIV11bIMlkSMahgbwFfsp3+y0AZAkpih6cO6w3yS339hIdqoCgnnM
         CxnyvWy/RtxCyPxwBo3gHEh+u8edTuCb9xIToWy8YYMsEqqHCOQ8kCpMYha4Ht+/EVoU
         lsM7bIb6SCaW6qaHdDmH6IPka7v1gAilN0F+xY/QYo4QY3nKkDL6ZPF9sx1o6LNGACJ1
         DI/fv9tikyo9FPrYKADd/I8bPl0kaDp+WltrdR+qLbScg1ni5ywluJ/0T8hH3+brRLtW
         1Jcg==
X-Gm-Message-State: AOJu0Yx7oVoGZUOvsNOdejstIhm4LxTQaeXBYrD10DToBHgI7Mg0TEQM
        TsqUJqRsuxpD4GT5DxTt+jdOsw==
X-Google-Smtp-Source: AGHT+IHKfCzTsoS2MbdaJLaciuQf01sFJ3IqvH48z4MJ8ZgPdLdgU+/B/Iawd1QmPe8D7Z1RTRnMSw==
X-Received: by 2002:ac2:5110:0:b0:502:a964:84b1 with SMTP id q16-20020ac25110000000b00502a96484b1mr2196692lfb.25.1695647886003;
        Mon, 25 Sep 2023 06:18:06 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-94-254-63-18.NA.cust.bahnhof.se. [94.254.63.18])
        by smtp.gmail.com with ESMTPSA id m29-20020a056512015d00b004fe10276bbfsm1823583lfo.296.2023.09.25.06.18.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Sep 2023 06:18:05 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Viresh Kumar <vireshk@kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>
Cc:     Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        Nikunj Kela <nkela@quicinc.com>,
        Prasad Sodagudi <psodagud@quicinc.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 9/9] firmware: arm_scmi: Add generic OPP support to the SCMI performance domain
Date:   Mon, 25 Sep 2023 15:17:15 +0200
Message-Id: <20230925131715.138411-10-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230925131715.138411-1-ulf.hansson@linaro.org>
References: <20230925131715.138411-1-ulf.hansson@linaro.org>
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

To allow a consumer driver to use the OPP library to scale the performance
for its device, let's dynamically add the OPP table when the device gets
attached to its SCMI performance domain.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/pmdomain/arm/scmi_perf_domain.c | 34 +++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/drivers/pmdomain/arm/scmi_perf_domain.c b/drivers/pmdomain/arm/scmi_perf_domain.c
index aa100270500f..bc3f78abb6da 100644
--- a/drivers/pmdomain/arm/scmi_perf_domain.c
+++ b/drivers/pmdomain/arm/scmi_perf_domain.c
@@ -9,6 +9,7 @@
 #include <linux/device.h>
 #include <linux/module.h>
 #include <linux/pm_domain.h>
+#include <linux/pm_opp.h>
 #include <linux/scmi_protocol.h>
 #include <linux/slab.h>
 
@@ -42,6 +43,37 @@ scmi_pd_set_perf_state(struct generic_pm_domain *genpd, unsigned int state)
 	return ret;
 }
 
+static int
+scmi_pd_attach_dev(struct generic_pm_domain *genpd, struct device *dev)
+{
+	struct scmi_perf_domain *pd = to_scmi_pd(genpd);
+	int ret;
+
+	/*
+	 * Allow the device to be attached, but don't add the OPP table unless
+	 * the performance level can be changed.
+	 */
+	if (!pd->info->set_perf)
+		return 0;
+
+	ret = pd->perf_ops->device_opps_add(pd->ph, dev, pd->domain_id);
+	if (ret)
+		dev_warn(dev, "failed to add OPPs for the device\n");
+
+	return ret;
+}
+
+static void
+scmi_pd_detach_dev(struct generic_pm_domain *genpd, struct device *dev)
+{
+	struct scmi_perf_domain *pd = to_scmi_pd(genpd);
+
+	if (!pd->info->set_perf)
+		return;
+
+	dev_pm_opp_remove_all_dynamic(dev);
+}
+
 static int scmi_perf_domain_probe(struct scmi_device *sdev)
 {
 	struct device *dev = &sdev->dev;
@@ -95,6 +127,8 @@ static int scmi_perf_domain_probe(struct scmi_device *sdev)
 		scmi_pd->genpd.flags = GENPD_FLAG_ALWAYS_ON |
 				       GENPD_FLAG_OPP_TABLE_FW;
 		scmi_pd->genpd.set_performance_state = scmi_pd_set_perf_state;
+		scmi_pd->genpd.attach_dev = scmi_pd_attach_dev;
+		scmi_pd->genpd.detach_dev = scmi_pd_detach_dev;
 
 		ret = pm_genpd_init(&scmi_pd->genpd, NULL, false);
 		if (ret)
-- 
2.34.1


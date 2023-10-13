Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C39707C80AB
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 10:49:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230250AbjJMItF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 04:49:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230266AbjJMItC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 04:49:02 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A31ACDA
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 01:48:59 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-6969b391791so1468877b3a.3
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 01:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697186939; x=1697791739; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Il8qfrUz/VvYSn9zWibaW2EcrYf9IhDD8qWnA/nDM/0=;
        b=zFvuZ+v6bcwUvKVEs+3fLEJhusLNtle5frH1gamu5LxaQSETaab5Aozpa6sGqw9qMT
         SeSmIxsc+ccqs/p+lveeerVxz4jHK1vGW2yXxcbFs9pbV72ge2///v4NJ6etsg5fnS/O
         jBl+qz7wLlkQxgSUN3yJuNZ6VLHqokTsEjBRD4yjJl9h5QP5cDpeYAbzU/sReQzli2p+
         JgeJJvEgzZf/IDiR285Ev88BcpAfwZMlrxsJyplKi+s5EV/8oJzphjTXQe/shl5IGXSE
         B/rmGG4rVYoNPppTbjMidByz4p7KhBOpUe0PJnIbK9cZQ7TYd4Gje1CLVA/dp+s1VAOH
         WADg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697186939; x=1697791739;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Il8qfrUz/VvYSn9zWibaW2EcrYf9IhDD8qWnA/nDM/0=;
        b=CxZypTH7iP0mBRsxW/GP623ctC1HjOUiRZaFvHCV804B0+RPFhra72m5YAtH/dpAlt
         TIu9UarJZWEnSbsG+/r60osunokX4k7G5Hey5CgW7jnCnL6/ERP2gIxJPBSJ1J/ApkH7
         7NqwHl9hQ1FKNMf0a4SnNwhR2b+HEeMM3ZKiDY3nAUv6OnoH+f5RKeWdx3IkWSCS6zsd
         VBcBhs4dtwGIK0AIcTMXWnem2dwskjNa4VazLiW9uZ0DUwVAEAmp6fuB9mn5oFdC56FS
         1loLMqbOs3TL8r8FIP3kpthPVOYddj5Th2Ye6NOWc56ShDRpPseWTQn5ZT4ZEZ9CUIRM
         ikPA==
X-Gm-Message-State: AOJu0YwmFUdQLz+vJpvuplOvLnHE5cO0Jcl1bIDirfwEC3bKQ+dgT/YE
        VJwVTfN9e7td/VwQJPhg3AXOPg==
X-Google-Smtp-Source: AGHT+IFuX8OHWuQqLIHMu+hE/a9qLVdUVDAqw5Eo/AfAH/SMAqPwytZyqJGU2cHfT2sWeC/2xRVuaw==
X-Received: by 2002:a05:6a00:b8f:b0:693:4202:b535 with SMTP id g15-20020a056a000b8f00b006934202b535mr29675823pfj.27.1697186939127;
        Fri, 13 Oct 2023 01:48:59 -0700 (PDT)
Received: from localhost ([122.172.80.14])
        by smtp.gmail.com with ESMTPSA id g24-20020a62e318000000b00696e8215d28sm13025120pfh.20.2023.10.13.01.48.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Oct 2023 01:48:58 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] OPP: Reorder code in _opp_set_required_opps_genpd()
Date:   Fri, 13 Oct 2023 14:18:39 +0530
Message-Id: <a5bd698a7a899fb63b4c5caec7068bf5a395165c.1697186772.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1697186772.git.viresh.kumar@linaro.org>
References: <cover.1697186772.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reorder code in _opp_set_required_opps_genpd() to reduce duplicate code.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/opp/core.c | 34 +++++++++++++++++++---------------
 1 file changed, 19 insertions(+), 15 deletions(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index f42b663a4d8b..3516e79cf743 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -1076,7 +1076,18 @@ static int _opp_set_required_opps_genpd(struct device *dev,
 {
 	struct device **genpd_virt_devs =
 		opp_table->genpd_virt_devs ? opp_table->genpd_virt_devs : &dev;
-	int i, ret = 0;
+	int index, target, delta, ret;
+
+	/* Scaling up? Set required OPPs in normal order, else reverse */
+	if (!scaling_down) {
+		index = 0;
+		target = opp_table->required_opp_count;
+		delta = 1;
+	} else {
+		index = opp_table->required_opp_count - 1;
+		target = -1;
+		delta = -1;
+	}
 
 	/*
 	 * Acquire genpd_virt_dev_lock to make sure we don't use a genpd_dev
@@ -1084,24 +1095,17 @@ static int _opp_set_required_opps_genpd(struct device *dev,
 	 */
 	mutex_lock(&opp_table->genpd_virt_dev_lock);
 
-	/* Scaling up? Set required OPPs in normal order, else reverse */
-	if (!scaling_down) {
-		for (i = 0; i < opp_table->required_opp_count; i++) {
-			ret = _set_performance_state(dev, genpd_virt_devs[i], opp, i);
-			if (ret)
-				break;
-		}
-	} else {
-		for (i = opp_table->required_opp_count - 1; i >= 0; i--) {
-			ret = _set_performance_state(dev, genpd_virt_devs[i], opp, i);
-			if (ret)
-				break;
-		}
+	while (index != target) {
+		ret = _set_performance_state(dev, genpd_virt_devs[index], opp, index);
+		if (ret)
+			break;
+
+		index += delta;
 	}
 
 	mutex_unlock(&opp_table->genpd_virt_dev_lock);
 
-	return ret;
+	return 0;
 }
 
 /* This is only called for PM domain for now */
-- 
2.31.1.272.g89b43f80a514


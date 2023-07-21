Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14C2F75C339
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 11:41:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230120AbjGUJlc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 05:41:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230268AbjGUJlX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 05:41:23 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4760D30D6
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 02:41:20 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-666eec46206so1551162b3a.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 02:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689932480; x=1690537280;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JYBTSL0OfRqOhOs6Z05SkTlqzON3K7UIBYPi9xq4xxc=;
        b=h/+u+zIoZ/y1VnucGLle63jX7c+pQ7Xm0NSJwjLnLSldtrque1+JD9Y6a5Wt6PV+s8
         nSh+rpgcEuhavmiPomFhpb0tgkZ9ria5aWjkvT4t/eGKlkkib3Se8yudwK9gO7HWsWso
         riB1rg8fd7Cn3A4auXB5333l3S1A/Wm/ucpZx74pgINzcnP4STs9BAOF0/Wx9lk5e+d/
         +mOZ6lXDiummONPaFzjVBcA7Ne48ukqaWjjF9HPevN7LRV5KGvNLT9FWwCs5HFGjSxKr
         EPYzojBgnvifHYFzhsMhUsMRDXh5/j/snvR7jwU9b/RRxI6r0U2/XSIGuPL2z9v0xMEB
         OszQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689932480; x=1690537280;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JYBTSL0OfRqOhOs6Z05SkTlqzON3K7UIBYPi9xq4xxc=;
        b=KqoIlFE8o6reoeQi1/je7uZdN5Kg5XtSozCA0qcdkVVzNZyPypj0gSbOO0ZiZ5iBQ5
         eGXg72PLek3p0ratYiHwnpbOKUtadtoJdKqBL6QOG890GM5E/00CZTUaW8/sggezV9D9
         NH48/Vvav1rq7dhfuCztOoJYjUYii3lQVUyPr9uwH/y467tuh49wpyqAXUyhvwy7o/ia
         CIpJPl/OHilzAZGy+T0T2lnGn4L5o/mW0sZ5/7DV58+JpuDNb8zHQSpEo/U15rm9fZ9n
         N2V3AoGCYFD7Hv+wAICYZJlV0qD4dTydiXPk2eCKX4IrZSVWOIBcm4dXBpqdipDYo8R6
         l6dg==
X-Gm-Message-State: ABy/qLbrNktcuPvQLdJH8Iw77ZLmn1eIcifHtPPGYPNEfiM2mSq80kJi
        NnyHc1xj8wUHXD47Q/Ys41PkpQ==
X-Google-Smtp-Source: APBJJlHXUu/oayiAgSCxfpwW4T9SemBsvXOG6+3NOAj1UN9MdpiDtsif4PSKpRSdjDaxkHrn6GIH5g==
X-Received: by 2002:a05:6a00:2351:b0:686:24e1:d12e with SMTP id j17-20020a056a00235100b0068624e1d12emr1697924pfj.30.1689932479645;
        Fri, 21 Jul 2023 02:41:19 -0700 (PDT)
Received: from localhost ([122.172.87.195])
        by smtp.gmail.com with ESMTPSA id j26-20020a62e91a000000b00682ad247e5fsm2633899pfh.179.2023.07.21.02.41.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 02:41:19 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/6] OPP: Introduce dev_pm_opp_get_freq_indexed() API
Date:   Fri, 21 Jul 2023 15:10:56 +0530
Message-Id: <93dc0fb7d0c51908ce1a1c35bec846afa7596e65.1689932341.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1689932341.git.viresh.kumar@linaro.org>
References: <cover.1689932341.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

In the case of devices with multiple clocks, drivers need to specify the
frequency index for the OPP framework to get the specific frequency within
the required OPP. So let's introduce the dev_pm_opp_get_freq_indexed() API
accepting the frequency index as an argument.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/opp/core.c     | 22 ++++++++++++++++++++++
 include/linux/pm_opp.h |  7 +++++++
 2 files changed, 29 insertions(+)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index cb4f47b341f9..00638d40353f 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -197,6 +197,28 @@ unsigned long dev_pm_opp_get_freq(struct dev_pm_opp *opp)
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_get_freq);
 
+/**
+ * dev_pm_opp_get_freq_indexed() - Gets the frequency corresponding to an
+ *				   available opp with specified index
+ * @opp: opp for which frequency has to be returned for
+ * @index: index of the frequency within the required opp
+ *
+ * Return: frequency in hertz corresponding to the opp with specified index,
+ * else return 0
+ */
+unsigned long dev_pm_opp_get_freq_indexed(struct dev_pm_opp *opp, u32 index)
+{
+	struct opp_table *opp_table = opp->opp_table;
+
+	if (IS_ERR_OR_NULL(opp) || index >= opp_table->clk_count) {
+		pr_err("%s: Invalid parameters\n", __func__);
+		return 0;
+	}
+
+	return opp->rates[index];
+}
+EXPORT_SYMBOL_GPL(dev_pm_opp_get_freq_indexed);
+
 /**
  * dev_pm_opp_get_level() - Gets the level corresponding to an available opp
  * @opp:	opp for which level value has to be returned for
diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
index 2617f2c51f29..a13a1705df57 100644
--- a/include/linux/pm_opp.h
+++ b/include/linux/pm_opp.h
@@ -105,6 +105,8 @@ unsigned long dev_pm_opp_get_power(struct dev_pm_opp *opp);
 
 unsigned long dev_pm_opp_get_freq(struct dev_pm_opp *opp);
 
+unsigned long dev_pm_opp_get_freq_indexed(struct dev_pm_opp *opp, u32 index);
+
 unsigned int dev_pm_opp_get_level(struct dev_pm_opp *opp);
 
 unsigned int dev_pm_opp_get_required_pstate(struct dev_pm_opp *opp,
@@ -213,6 +215,11 @@ static inline unsigned long dev_pm_opp_get_freq(struct dev_pm_opp *opp)
 	return 0;
 }
 
+static inline unsigned long dev_pm_opp_get_freq_indexed(struct dev_pm_opp *opp, u32 index)
+{
+	return 0;
+}
+
 static inline unsigned int dev_pm_opp_get_level(struct dev_pm_opp *opp)
 {
 	return 0;
-- 
2.31.1.272.g89b43f80a514


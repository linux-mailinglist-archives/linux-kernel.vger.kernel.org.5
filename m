Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9D577DB82F
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 11:34:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232785AbjJ3Kei (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 06:34:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233380AbjJ3KeA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 06:34:00 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB21E1BF8
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 03:24:27 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-6bd96cfb99cso3567743b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 03:24:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698661467; x=1699266267; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fcED4WjT67F9vTej3BnZaz4/stcnOOOgNE1CTcd6l/E=;
        b=Itlp8lMvy58UID6ioZWhAjfk515YBZ9LFmvOBkdL2zN7Jm2YaSWVR01ZEbfPBUVxTq
         0hDMWVWgzUY1XNkEKdLRMumPtPgcfzdNW/8+omNFUG6TL8kXeMgJTFA5IKV0lbL4ipxL
         oTOsmdmDBo19hUJ9U1nbpT2nwKrdIPe1o6V8M9cjXgVyRz6kUo3QzHsgwXBNBb3aXTtu
         AaWOMsKNnMuXwppR/cLUMrEEDJ15Ke7fYL2h/e03sRY/nvVIP1Mg0DDc6xZO1YKQs7Lb
         5/V8Jy35sN8X+5tHRrnamvz6LdAO2stqVNlIl/awFYZArmmS+nxa35ML0gPiRbrlwX2l
         MXbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698661467; x=1699266267;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fcED4WjT67F9vTej3BnZaz4/stcnOOOgNE1CTcd6l/E=;
        b=G1fIzhJp4PyrToZ9YGYW6+cNxXXuOO3FkfiWTjmiwd4JHe/IPQPovF2+MoFM/YyCMK
         xatAg/0zzMuOx9xPUkbwn5xYvI6Fz/trp7ZPxP5gLUzYnXyi37yLvUdLHpQ6QtS/oVmI
         ymW5Dy1I6ClxD9ErhFNynv9a94IxMY2uLehPIxZscENQjk3yh9AlqtThWaMyHftUDPcb
         AGPbVIZrJ23/NfWXchd8hvfolIoER+58YBkHg1gj7LPNVy71yBl3xWQLXekR8wFBPH/m
         iFl/83G8ymIKXNZ6A6VOiWq+ug4kEPa9zAzgU2uU11Syupgm2LR5yHlHIu5djnIle+SX
         G9Ew==
X-Gm-Message-State: AOJu0YxuGL6TKb5crlq/MXira4TpQdIMqHohYcakVbKjbGX1MM5XPA6L
        f76V68IfBT9rf37jAxj9mMoDnWBcDYkf45Epv8M=
X-Google-Smtp-Source: AGHT+IFyefwXgF0q1Fm+W6NnDmQKzc97ponS+jh5210IUt7CJEk7s5l9m1aqi/ZSU2nls0p7KU5sjA==
X-Received: by 2002:a05:6a00:21d0:b0:68e:2f6e:b4c0 with SMTP id t16-20020a056a0021d000b0068e2f6eb4c0mr7744981pfj.28.1698661466983;
        Mon, 30 Oct 2023 03:24:26 -0700 (PDT)
Received: from localhost ([122.172.80.14])
        by smtp.gmail.com with ESMTPSA id a18-20020aa78652000000b006be484e5b9bsm5600469pfo.58.2023.10.30.03.24.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Oct 2023 03:24:26 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Stephan Gerhold <stephan.gerhold@kernkonzept.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2 1/3] OPP: Level zero is valid
Date:   Mon, 30 Oct 2023 15:54:15 +0530
Message-Id: <36de122e568dcba371d3581e5f936243b405a874.1698661048.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1698661048.git.viresh.kumar@linaro.org>
References: <cover.1698661048.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The level zero can be used by some OPPs to drop performance state vote
for the device. It is perfectly fine to allow the same.

_set_opp_level() considers it as an invalid value currently and returns
early.

In order to support this properly, initialize the level field with
U32_MAX, which denotes unused level field.

Reported-by: Stephan Gerhold <stephan.gerhold@kernkonzept.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/opp/core.c     | 24 ++++++++++++++++++++----
 drivers/opp/of.c       |  8 +++++++-
 include/linux/pm_opp.h |  5 ++++-
 3 files changed, 31 insertions(+), 6 deletions(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 84f345c69ea5..f2e2aa07b431 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -201,7 +201,7 @@ EXPORT_SYMBOL_GPL(dev_pm_opp_get_freq_indexed);
  * @opp:	opp for which level value has to be returned for
  *
  * Return: level read from device tree corresponding to the opp, else
- * return 0.
+ * return U32_MAX.
  */
 unsigned int dev_pm_opp_get_level(struct dev_pm_opp *opp)
 {
@@ -221,7 +221,7 @@ EXPORT_SYMBOL_GPL(dev_pm_opp_get_level);
  * @index:	index of the required opp
  *
  * Return: performance state read from device tree corresponding to the
- * required opp, else return 0.
+ * required opp, else return U32_MAX.
  */
 unsigned int dev_pm_opp_get_required_pstate(struct dev_pm_opp *opp,
 					    unsigned int index)
@@ -808,6 +808,14 @@ struct dev_pm_opp *dev_pm_opp_find_level_ceil(struct device *dev,
 	struct dev_pm_opp *opp;
 
 	opp = _find_key_ceil(dev, &temp, 0, true, _read_level, NULL);
+
+	/* False match */
+	if (temp == OPP_LEVEL_UNSET) {
+		dev_err(dev, "%s: OPP levels aren't available\n", __func__);
+		dev_pm_opp_put(opp);
+		return ERR_PTR(-ENODEV);
+	}
+
 	*level = temp;
 	return opp;
 }
@@ -1049,12 +1057,18 @@ static int _set_opp_bw(const struct opp_table *opp_table,
 static int _set_performance_state(struct device *dev, struct device *pd_dev,
 				  struct dev_pm_opp *opp, int i)
 {
-	unsigned int pstate = likely(opp) ? opp->required_opps[i]->level: 0;
+	unsigned int pstate = 0;
 	int ret;
 
 	if (!pd_dev)
 		return 0;
 
+	if (likely(opp)) {
+		pstate = opp->required_opps[i]->level;
+		if (pstate == OPP_LEVEL_UNSET)
+			return 0;
+	}
+
 	ret = dev_pm_domain_set_performance_state(pd_dev, pstate);
 	if (ret) {
 		dev_err(dev, "Failed to set performance state of %s: %d (%d)\n",
@@ -1135,7 +1149,7 @@ static int _set_opp_level(struct device *dev, struct opp_table *opp_table,
 	int ret = 0;
 
 	if (opp) {
-		if (!opp->level)
+		if (opp->level == OPP_LEVEL_UNSET)
 			return 0;
 
 		level = opp->level;
@@ -1867,6 +1881,8 @@ struct dev_pm_opp *_opp_allocate(struct opp_table *opp_table)
 
 	INIT_LIST_HEAD(&opp->node);
 
+	opp->level = OPP_LEVEL_UNSET;
+
 	return opp;
 }
 
diff --git a/drivers/opp/of.c b/drivers/opp/of.c
index 81fa27599d58..85fad7ca0007 100644
--- a/drivers/opp/of.c
+++ b/drivers/opp/of.c
@@ -1393,8 +1393,14 @@ int of_get_required_opp_performance_state(struct device_node *np, int index)
 
 	opp = _find_opp_of_np(opp_table, required_np);
 	if (opp) {
-		pstate = opp->level;
+		if (opp->level == OPP_LEVEL_UNSET) {
+			pr_err("%s: OPP levels aren't available for %pOF\n",
+			       __func__, np);
+		} else {
+			pstate = opp->level;
+		}
 		dev_pm_opp_put(opp);
+
 	}
 
 	dev_pm_opp_put_opp_table(opp_table);
diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
index ccd97bcef269..af53101a1383 100644
--- a/include/linux/pm_opp.h
+++ b/include/linux/pm_opp.h
@@ -92,9 +92,12 @@ struct dev_pm_opp_config {
 	struct device ***virt_devs;
 };
 
+#define OPP_LEVEL_UNSET			U32_MAX
+
 /**
  * struct dev_pm_opp_data - The data to use to initialize an OPP.
- * @level: The performance level for the OPP.
+ * @level: The performance level for the OPP. Set level to OPP_LEVEL_UNSET if
+ * level field isn't used.
  * @freq: The clock rate in Hz for the OPP.
  * @u_volt: The voltage in uV for the OPP.
  */
-- 
2.31.1.272.g89b43f80a514


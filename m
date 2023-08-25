Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A0607885BC
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 13:28:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244278AbjHYL1p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 07:27:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244032AbjHYL1V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 07:27:21 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C61AF2691
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 04:27:09 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-4ff09632194so1214902e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 04:27:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692962828; x=1693567628;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5gMHV9Yq0P3BvEVk6dHuf/JZOVU8klOINBbvQDcnPB8=;
        b=XBfMsJVo+PapFD2sRB8gtDtHIfO0aTjlDoCCnTpU5hVZuI1QCmf/ItpnCs3DXv163I
         FdRlQg8veVVNxvO7NM5YKNpMgX7xQciRAnojlqqMwUg8SZjdK7ita7nDX5yzo6GS/Z1H
         TokJOKfQf8buuJh0w/l53jKZI3dZ9GauvVPa42Conp9k/XS4vBCQ3zey9Vu1VUqr33mY
         OR5HF8/JrcLQZ8wojvRKdsN8vTAR33x7y5sakdTUsFltatrk2Bj4MolYAe6YiPlUbTzs
         7iVJ4yYnd/pnxkmevttRHMvhorpXfMqqwQw88GVWsHN+5pMF2xWfwBtH5GBbhkVNnIQu
         M99w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692962828; x=1693567628;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5gMHV9Yq0P3BvEVk6dHuf/JZOVU8klOINBbvQDcnPB8=;
        b=IKk5wbTiXsbk9Bss2wJVCOvWOWdm7mDlj8Za/pf5dycRj0UeUBCDKGHszs+oA6M726
         V6rmQt6IQjGeytjdNNuKXLXZfTLRHAckhL0QVBFrBSPP8kiLdEizPzgklAXUsI5b7aIu
         IZ/XMnNy+DwtGjuombC9uXYYgtzHTLX6exrQRw/++8hTMcr1RZyHnQs9YD3GJ07C85vc
         sUA9Kza7Y6T6kOarvrWG+01PXpWFhtAqJAMzHS11W3ODxXmPPiSZmH6iYIQeMq4ag5US
         HUUspDalhJ0yuqL5b/p215MPkQ+vCTPhtUaOB3m7uCVWPQdi7phKzrDxGdH62d8pTZkW
         jNSQ==
X-Gm-Message-State: AOJu0YyrOlmfQmjCy50j0YpHeYkUa7A/qWk+e01mXX5tngU8zkY3Pba/
        w5JXR5ZCKENgfvXM5FfSGGxBKA==
X-Google-Smtp-Source: AGHT+IEJFrCwxobYD3hH0FUBvo/rxPuCeM334SMKxvVgxWIdPqn1OfprXQwlTPJJuVY16tqmTMUeJg==
X-Received: by 2002:a05:6512:3e9:b0:4fe:8c07:98eb with SMTP id n9-20020a05651203e900b004fe8c0798ebmr11027207lfq.51.1692962827998;
        Fri, 25 Aug 2023 04:27:07 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-94-254-63-18.NA.cust.bahnhof.se. [94.254.63.18])
        by smtp.gmail.com with ESMTPSA id g7-20020ac25387000000b004fb7ac67bbdsm259164lfh.41.2023.08.25.04.27.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Aug 2023 04:27:07 -0700 (PDT)
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
Subject: [PATCH v3 12/13] PM: domains: Allow genpd providers to manage OPP tables directly by its FW
Date:   Fri, 25 Aug 2023 13:26:32 +0200
Message-Id: <20230825112633.236607-13-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230825112633.236607-1-ulf.hansson@linaro.org>
References: <20230825112633.236607-1-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In some cases the OPP tables aren't specified in device tree, but rather
encoded in the FW. To allow a genpd provider to specify them dynamically
instead, let's add a new genpd flag, GENPD_FLAG_OPP_TABLE_FW.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Changes in v3:
	- None.

---
 drivers/base/power/domain.c | 11 ++++++-----
 include/linux/pm_domain.h   |  5 +++++
 2 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 5cb2023581d4..c74edf80417f 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -130,6 +130,7 @@ static const struct genpd_lock_ops genpd_spin_ops = {
 #define genpd_is_active_wakeup(genpd)	(genpd->flags & GENPD_FLAG_ACTIVE_WAKEUP)
 #define genpd_is_cpu_domain(genpd)	(genpd->flags & GENPD_FLAG_CPU_DOMAIN)
 #define genpd_is_rpm_always_on(genpd)	(genpd->flags & GENPD_FLAG_RPM_ALWAYS_ON)
+#define genpd_is_opp_table_fw(genpd)	(genpd->flags & GENPD_FLAG_OPP_TABLE_FW)
 
 static inline bool irq_safe_dev_in_sleep_domain(struct device *dev,
 		const struct generic_pm_domain *genpd)
@@ -2328,7 +2329,7 @@ int of_genpd_add_provider_simple(struct device_node *np,
 	genpd->dev.of_node = np;
 
 	/* Parse genpd OPP table */
-	if (genpd->set_performance_state) {
+	if (!genpd_is_opp_table_fw(genpd) && genpd->set_performance_state) {
 		ret = dev_pm_opp_of_add_table(&genpd->dev);
 		if (ret)
 			return dev_err_probe(&genpd->dev, ret, "Failed to add OPP table\n");
@@ -2343,7 +2344,7 @@ int of_genpd_add_provider_simple(struct device_node *np,
 
 	ret = genpd_add_provider(np, genpd_xlate_simple, genpd);
 	if (ret) {
-		if (genpd->set_performance_state) {
+		if (!genpd_is_opp_table_fw(genpd) && genpd->set_performance_state) {
 			dev_pm_opp_put_opp_table(genpd->opp_table);
 			dev_pm_opp_of_remove_table(&genpd->dev);
 		}
@@ -2387,7 +2388,7 @@ int of_genpd_add_provider_onecell(struct device_node *np,
 		genpd->dev.of_node = np;
 
 		/* Parse genpd OPP table */
-		if (genpd->set_performance_state) {
+		if (!genpd_is_opp_table_fw(genpd) && genpd->set_performance_state) {
 			ret = dev_pm_opp_of_add_table_indexed(&genpd->dev, i);
 			if (ret) {
 				dev_err_probe(&genpd->dev, ret,
@@ -2423,7 +2424,7 @@ int of_genpd_add_provider_onecell(struct device_node *np,
 		genpd->provider = NULL;
 		genpd->has_provider = false;
 
-		if (genpd->set_performance_state) {
+		if (!genpd_is_opp_table_fw(genpd) && genpd->set_performance_state) {
 			dev_pm_opp_put_opp_table(genpd->opp_table);
 			dev_pm_opp_of_remove_table(&genpd->dev);
 		}
@@ -2455,7 +2456,7 @@ void of_genpd_del_provider(struct device_node *np)
 				if (gpd->provider == &np->fwnode) {
 					gpd->has_provider = false;
 
-					if (!gpd->set_performance_state)
+					if (genpd_is_opp_table_fw(gpd) || !gpd->set_performance_state)
 						continue;
 
 					dev_pm_opp_put_opp_table(gpd->opp_table);
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index f776fb93eaa0..05ad8cefdff1 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -61,6 +61,10 @@
  * GENPD_FLAG_MIN_RESIDENCY:	Enable the genpd governor to consider its
  *				components' next wakeup when determining the
  *				optimal idle state.
+ *
+ * GENPD_FLAG_OPP_TABLE_FW:	The genpd provider supports performance states,
+ *				but its corresponding OPP tables are not
+ *				described in DT, but are given directly by FW.
  */
 #define GENPD_FLAG_PM_CLK	 (1U << 0)
 #define GENPD_FLAG_IRQ_SAFE	 (1U << 1)
@@ -69,6 +73,7 @@
 #define GENPD_FLAG_CPU_DOMAIN	 (1U << 4)
 #define GENPD_FLAG_RPM_ALWAYS_ON (1U << 5)
 #define GENPD_FLAG_MIN_RESIDENCY (1U << 6)
+#define GENPD_FLAG_OPP_TABLE_FW	 (1U << 7)
 
 enum gpd_status {
 	GENPD_STATE_ON = 0,	/* PM domain is on */
-- 
2.34.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A8727AD8DB
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 15:18:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231728AbjIYNSY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 09:18:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231797AbjIYNSM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 09:18:12 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D48B11F
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 06:18:03 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-503f39d3236so10274028e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 06:18:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695647882; x=1696252682; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2bFHpy7o1LqMw4W/VuJiDN5LSPCulCxHGcm0dhiriMk=;
        b=akzsUeXATj6phxvbMERpRKxwOFzaqEdoEpSv0qkCkrIv8xSul2dEEqSCp2Wg0ZYNLW
         TDWdEo8mdnA3tl1Tfq+59V/IelAMic1xq/D9hSJuPe6WHL0AEI6jrP09on29j9JmA0jv
         8HhGi5hlL+ihxBkqAEUdmQo+Sb+iJs1FUX9oXHbdvItStVA4p+0O6AA1F2D+B5jwwOHj
         WqxI1/cLrmnrJPrX8FS/iyu6eOKZjfJvTjL1y5Ajdqzfzi1xYjnWAFkAPmxRx0EXewhZ
         40mqR4b6q1256GPxNCzgtd+ud/pdQizE81b+7kCgDY+YesbV3O8uTauH7nh9FK/dpZXV
         evow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695647882; x=1696252682;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2bFHpy7o1LqMw4W/VuJiDN5LSPCulCxHGcm0dhiriMk=;
        b=HGxzoKJhgG2nAc5HlAysSRdzaziRQlYFdzdhKVjUk1M0oTUUlsSUSea9rZS9eqrB7v
         uo2x2Civ9JsIybSWWZ7st4z7Cb2K+rw+jGV6qbRD4KZYWp59MnCfDOILEicRSvwHayUr
         OKDjuXmkBrTfs3ox9wJ3VhgGb7Uz1CnQQ/dwbHiJboggeDzapNmBvWvjJSwG3rWovA6U
         W57Hnz2sMu6NKYSSrpCyYx2WPD9Yan2f532A3Pnhawtq/e00UVhSyVppOE1aqw0RVMUQ
         CWFGcsUQsEUvDETGXMHEzuWx3zRAEpgVG2SNffuRikJFXf98Aby8Zpn/e3ClRn4AHMyp
         2ipg==
X-Gm-Message-State: AOJu0YxmuIk7WxxBoI8FSlsJB9qrEKu6920er6N4WDw1nXOAj9mCiU0t
        S9+/v3r6GX/YVwJz79he1kBIGA==
X-Google-Smtp-Source: AGHT+IGmFBgkJKVaTj0hT0ug8ZmhpL42wRm/KPZyj7Yq0oqitc6hAqHCl9UOX5muul8rmBpDMAJOnQ==
X-Received: by 2002:a05:6512:39c5:b0:4fd:faa5:64ed with SMTP id k5-20020a05651239c500b004fdfaa564edmr7421632lfu.11.1695647882083;
        Mon, 25 Sep 2023 06:18:02 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-94-254-63-18.NA.cust.bahnhof.se. [94.254.63.18])
        by smtp.gmail.com with ESMTPSA id m29-20020a056512015d00b004fe10276bbfsm1823583lfo.296.2023.09.25.06.18.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Sep 2023 06:18:01 -0700 (PDT)
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
Subject: [PATCH 6/9] OPP: Extend support for the opp-level beyond required-opps
Date:   Mon, 25 Sep 2023 15:17:12 +0200
Message-Id: <20230925131715.138411-7-ulf.hansson@linaro.org>
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

At this point the level (performance state) for an OPP is currently limited
to be requested for a device that is attached to a PM domain.  Moreover,
the device needs to have the so called required-opps assigned to it, which
are based upon OPP tables being described in DT.

To extend the support beyond required-opps and DT, let's enable the level
to be set for all OPPs. More precisely, if the requested OPP has a valid
level let's try to request it through the device's optional PM domain, via
calling dev_pm_domain_set_performance_state().

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/opp/core.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 60dca60ac4af..afb73978cdcb 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -1107,6 +1107,22 @@ void _update_set_required_opps(struct opp_table *opp_table)
 		opp_table->set_required_opps = _opp_set_required_opps_generic;
 }
 
+static int _set_opp_level(struct device *dev, struct opp_table *opp_table,
+			  struct dev_pm_opp *opp)
+{
+	int ret = 0;
+
+	/* Request a new performance state through the device's PM domain. */
+	if (opp && opp->level) {
+		ret = dev_pm_domain_set_performance_state(dev, opp->level);
+		if (ret)
+			dev_err(dev, "Failed to set performance state %u (%d)\n",
+				opp->level, ret);
+	}
+
+	return ret;
+}
+
 static void _find_current_opp(struct device *dev, struct opp_table *opp_table)
 {
 	struct dev_pm_opp *opp = ERR_PTR(-ENODEV);
@@ -1154,8 +1170,13 @@ static int _disable_opp_table(struct device *dev, struct opp_table *opp_table)
 	if (opp_table->regulators)
 		regulator_disable(opp_table->regulators[0]);
 
+	ret = _set_opp_level(dev, opp_table, NULL);
+	if (ret)
+		goto out;
+
 	ret = _set_required_opps(dev, opp_table, NULL, false);
 
+out:
 	opp_table->enabled = false;
 	return ret;
 }
@@ -1198,6 +1219,10 @@ static int _set_opp(struct device *dev, struct opp_table *opp_table,
 			return ret;
 		}
 
+		ret = _set_opp_level(dev, opp_table, opp);
+		if (ret)
+			return ret;
+
 		ret = _set_opp_bw(opp_table, opp, dev);
 		if (ret) {
 			dev_err(dev, "Failed to set bw: %d\n", ret);
@@ -1241,6 +1266,10 @@ static int _set_opp(struct device *dev, struct opp_table *opp_table,
 			return ret;
 		}
 
+		ret = _set_opp_level(dev, opp_table, opp);
+		if (ret)
+			return ret;
+
 		ret = _set_required_opps(dev, opp_table, opp, false);
 		if (ret) {
 			dev_err(dev, "Failed to set required opps: %d\n", ret);
-- 
2.34.1


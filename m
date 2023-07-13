Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7636752503
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 16:19:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231246AbjGMOTJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 10:19:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235328AbjGMOSS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 10:18:18 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63D98268D
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 07:18:17 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-4fb77f21c63so1389870e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 07:18:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689257895; x=1691849895;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8swgWEZzFMg1ioXnX70SnBjg0F7FWuFNmTlpHotRoZ8=;
        b=hCP8mCARoTgFbzFWJYb/xNDFksC1tIqoXQe2mpZlBsTTBMLamDrvONM159gJ3jzAbl
         nrYJiG/O3EomzWVHxXZwMFyxSGuTxXjKeRmjuK9PX+kI381y0q/OUOVod/Rnww8EohkL
         BJBH8luiBMkqcS1oRpxfNod9dw3ECYIvh6X9h6TM54u60Ci2cOr3jq5bpvgW4bFXNjnS
         RYA1dbBOGlNyW7XidVNuYXBEp0GzyG7vtnWsycWwLi5NOZZwQwstXezEnTUnOIujq6+f
         2RMxPRdXy/apSSKuaAgfPeKrAEh6x3s3qtQLr2bpyb1qJEETY1rIARikzC7zFap2wrzT
         VjUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689257895; x=1691849895;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8swgWEZzFMg1ioXnX70SnBjg0F7FWuFNmTlpHotRoZ8=;
        b=ikwMmimizQtECH31uWxnKiYKWywvdwroZJOl4MVr/44avxrrq97O8SQ8leWAp/OCAx
         Br6JAMMKHZsoDJDG4LqmVfS9tqdHjHY4ViVgmaPYzRj4Z1bo21K9SoztzN5dY+zKPWDN
         LYMqkGW0vysi89AwBhwQan37szYZA7H2lXntVlMuZlJDu4jORGnb/2ocnFXp3sL5vNfG
         JQ3fg2Q7p/bn1AxjhFaMKfLdhszN9VawI0PhJ0lLgw2ndHI0pNDxxhGZV98COKh6lOyW
         PSbtUsmL2arQ6ZZ8XvDNeFNphpVsD5P1SqxYpa3CGJZfc4IMkM1tqXGJyEii5FuCWAjn
         Lu5Q==
X-Gm-Message-State: ABy/qLYnsDKOoyujlTySCW2Hi7zvWDUmAf6Q9X2ufAzBEEG/1iUFKbeN
        s+3S7EwpiGsbLwVKEKEbPfu2dw==
X-Google-Smtp-Source: APBJJlGfSxoujTkP7falI08ZNJNb5RxBQyhfB12voLbucbg9J44kDqU6fl7o96FN5d1F40/zyFNy+w==
X-Received: by 2002:a05:6512:2013:b0:4fa:f96c:745f with SMTP id a19-20020a056512201300b004faf96c745fmr1297853lfb.38.1689257895790;
        Thu, 13 Jul 2023 07:18:15 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-94-254-63-18.NA.cust.bahnhof.se. [94.254.63.18])
        by smtp.gmail.com with ESMTPSA id w28-20020ac2599c000000b004fb759964a9sm1132426lfn.168.2023.07.13.07.18.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jul 2023 07:18:15 -0700 (PDT)
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
Subject: [PATCH v2 05/11] firmware: arm_scmi: Drop redundant ->device_domain_id() from perf ops
Date:   Thu, 13 Jul 2023 16:17:32 +0200
Message-Id: <20230713141738.23970-6-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230713141738.23970-1-ulf.hansson@linaro.org>
References: <20230713141738.23970-1-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are no longer any users of the ->device_domain_id() ops in the
scmi_perf_proto_ops, therefore let's remove it.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Changes in v2:
	- None.

---
 drivers/firmware/arm_scmi/perf.c | 13 -------------
 include/linux/scmi_protocol.h    |  2 --
 2 files changed, 15 deletions(-)

diff --git a/drivers/firmware/arm_scmi/perf.c b/drivers/firmware/arm_scmi/perf.c
index 6046c0eb5959..535174830946 100644
--- a/drivers/firmware/arm_scmi/perf.c
+++ b/drivers/firmware/arm_scmi/perf.c
@@ -572,18 +572,6 @@ static void scmi_perf_domain_init_fc(const struct scmi_protocol_handle *ph,
 	*p_fc = fc;
 }
 
-/* Device specific ops */
-static int scmi_dev_domain_id(struct device *dev)
-{
-	struct of_phandle_args clkspec;
-
-	if (of_parse_phandle_with_args(dev->of_node, "clocks", "#clock-cells",
-				       0, &clkspec))
-		return -EINVAL;
-
-	return clkspec.args[0];
-}
-
 static int scmi_dvfs_device_opps_add(const struct scmi_protocol_handle *ph,
 				     struct device *dev, u32 domain)
 {
@@ -702,7 +690,6 @@ static const struct scmi_perf_proto_ops perf_proto_ops = {
 	.limits_get = scmi_perf_limits_get,
 	.level_set = scmi_perf_level_set,
 	.level_get = scmi_perf_level_get,
-	.device_domain_id = scmi_dev_domain_id,
 	.transition_latency_get = scmi_dvfs_transition_latency_get,
 	.device_opps_add = scmi_dvfs_device_opps_add,
 	.freq_set = scmi_dvfs_freq_set,
diff --git a/include/linux/scmi_protocol.h b/include/linux/scmi_protocol.h
index 71072fe8ccc9..7098a0be79b9 100644
--- a/include/linux/scmi_protocol.h
+++ b/include/linux/scmi_protocol.h
@@ -112,7 +112,6 @@ struct scmi_perf_domain_info {
  * @limits_get: gets limits on the performance level of a domain
  * @level_set: sets the performance level of a domain
  * @level_get: gets the performance level of a domain
- * @device_domain_id: gets the scmi domain id for a given device
  * @transition_latency_get: gets the DVFS transition latency for a given device
  * @device_opps_add: adds all the OPPs for a given device
  * @freq_set: sets the frequency for a given device using sustained frequency
@@ -138,7 +137,6 @@ struct scmi_perf_proto_ops {
 			 u32 level, bool poll);
 	int (*level_get)(const struct scmi_protocol_handle *ph, u32 domain,
 			 u32 *level, bool poll);
-	int (*device_domain_id)(struct device *dev);
 	int (*transition_latency_get)(const struct scmi_protocol_handle *ph,
 				      u32 domain);
 	int (*device_opps_add)(const struct scmi_protocol_handle *ph,
-- 
2.34.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19C2A7524FD
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 16:18:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231312AbjGMOSe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 10:18:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235231AbjGMOSO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 10:18:14 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30E1826AF
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 07:18:13 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-4fbf1f6c771so1402027e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 07:18:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689257891; x=1691849891;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gh+gKUS7IMi6ThhGwyG8WEdTRY9eZfCeAwrMiJcy0S0=;
        b=B4jDt0oDMLMSH/SjCfe9veKB/wikJeVpnaVVOr6QY/R3rdXFS1mrBMk5ZkOtzakvu5
         LefhbCwCV9iVSCUImQ2+4PWSNcF4pqxTFnBUw6AsgGL8PvyEv24iA6JhcUO274GySsT0
         FG3sHH75BKWfeeydaEXIl0L4ONvf6US5UTE/kF3HDBC2SmagQD4I7iqAQ4pQUe/pCffk
         iwFWefirSXoFAmEgbuYynMzK+/Viogj/kAIUlk68+SwsoFMboK9K9pfFLjLsol1tc4yl
         AKlk8kTJ3MM1OmWVV4c6mGeH9b7lE2eEJOcDdvwgdc2Icic6MsEEkVsOi/+/XBsq7Ssf
         3DSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689257891; x=1691849891;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gh+gKUS7IMi6ThhGwyG8WEdTRY9eZfCeAwrMiJcy0S0=;
        b=SdxNvlMORru/ob8Za4w0mtpOVMSmRODfi8rkNdqSk59Bf+ZvP43L1ikU1ydZsr0IFn
         0udMchW+MTDBHlVB4UZVJKj4Cm0yzncUn27q1yyNbHTQfykXzA021zg2Ks8PO2LGBdvZ
         PnXtAmcT48vbmlwXfShUVRcA3/HDc3kHF8uWWyPVivZk1PgiKPXXeBTSj7eiRn8Hd6Ox
         3H7Y44phUT2UeC+w67QhSMiKQF+qDSRcqlS6gXYyDJa14QhrhsknajslzEgW8x13uRd4
         ChyKATTiKP6tSf+7MjJK/nsOuLC27AHjiZsEhm63xfUFMy9mm9GDmLLprsp//4ohTZoM
         89uA==
X-Gm-Message-State: ABy/qLa4k3JVIA5O5sThunTZsc3JEsGAs0qaLFzSDeRWFAd4hPKWeUuj
        oup+AZh/iY1CyuIAMlzlKvoMKw==
X-Google-Smtp-Source: APBJJlEz8giuIUF+FvZp4ShicPkXlGdGQnC1pcMvCg2XE1TwdbGx42cyBaN6G3kevsVYkpBLwkDfvg==
X-Received: by 2002:a19:6419:0:b0:4f8:5bf7:db05 with SMTP id y25-20020a196419000000b004f85bf7db05mr1256418lfb.27.1689257891550;
        Thu, 13 Jul 2023 07:18:11 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-94-254-63-18.NA.cust.bahnhof.se. [94.254.63.18])
        by smtp.gmail.com with ESMTPSA id w28-20020ac2599c000000b004fb759964a9sm1132426lfn.168.2023.07.13.07.18.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jul 2023 07:18:11 -0700 (PDT)
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
Subject: [PATCH v2 02/11] firmware: arm_scmi: Extend perf protocol ops to get information of a domain
Date:   Thu, 13 Jul 2023 16:17:29 +0200
Message-Id: <20230713141738.23970-3-ulf.hansson@linaro.org>
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

Similar to other protocol ops, it's useful for an scmi module driver to get
some generic information of a performance domain. Therefore, let's add a
new callback to provide this information. The information is currently
limited to the name of the performance domain and whether the set-level
operation is supported, although this can easily be extended if we find the
need for it.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Changes in v2:
	- New patch (replacing two earlier patches).

---
 drivers/firmware/arm_scmi/perf.c | 21 ++++++++++++++++-----
 include/linux/scmi_protocol.h    |  8 ++++++++
 2 files changed, 24 insertions(+), 5 deletions(-)

diff --git a/drivers/firmware/arm_scmi/perf.c b/drivers/firmware/arm_scmi/perf.c
index cf7f0de4d6db..f3ea96dd845c 100644
--- a/drivers/firmware/arm_scmi/perf.c
+++ b/drivers/firmware/arm_scmi/perf.c
@@ -124,7 +124,6 @@ struct scmi_msg_resp_perf_describe_levels {
 
 struct perf_dom_info {
 	bool set_limits;
-	bool set_perf;
 	bool perf_limit_notify;
 	bool perf_level_notify;
 	bool perf_fastchannels;
@@ -132,7 +131,7 @@ struct perf_dom_info {
 	u32 sustained_freq_khz;
 	u32 sustained_perf_level;
 	u32 mult_factor;
-	char name[SCMI_MAX_STR_SIZE];
+	struct scmi_perf_domain_info info;
 	struct scmi_opp opp[MAX_OPPS];
 	struct scmi_fc_info *fc_info;
 };
@@ -209,7 +208,7 @@ scmi_perf_domain_attributes_get(const struct scmi_protocol_handle *ph,
 		flags = le32_to_cpu(attr->flags);
 
 		dom_info->set_limits = SUPPORTS_SET_LIMITS(flags);
-		dom_info->set_perf = SUPPORTS_SET_PERF_LVL(flags);
+		dom_info->info.set_perf = SUPPORTS_SET_PERF_LVL(flags);
 		dom_info->perf_limit_notify = SUPPORTS_PERF_LIMIT_NOTIFY(flags);
 		dom_info->perf_level_notify = SUPPORTS_PERF_LEVEL_NOTIFY(flags);
 		dom_info->perf_fastchannels = SUPPORTS_PERF_FASTCHANNELS(flags);
@@ -225,7 +224,8 @@ scmi_perf_domain_attributes_get(const struct scmi_protocol_handle *ph,
 			dom_info->mult_factor =
 					(dom_info->sustained_freq_khz * 1000) /
 					dom_info->sustained_perf_level;
-		strscpy(dom_info->name, attr->name, SCMI_SHORT_NAME_MAX_SIZE);
+		strscpy(dom_info->info.name, attr->name,
+			SCMI_SHORT_NAME_MAX_SIZE);
 	}
 
 	ph->xops->xfer_put(ph, t);
@@ -237,7 +237,8 @@ scmi_perf_domain_attributes_get(const struct scmi_protocol_handle *ph,
 	if (!ret && PROTOCOL_REV_MAJOR(version) >= 0x3 &&
 	    SUPPORTS_EXTENDED_NAMES(flags))
 		ph->hops->extended_name_get(ph, PERF_DOMAIN_NAME_GET, domain,
-					    dom_info->name, SCMI_MAX_STR_SIZE);
+					    dom_info->info.name,
+					    SCMI_MAX_STR_SIZE);
 
 	return ret;
 }
@@ -340,6 +341,15 @@ static int scmi_perf_num_domains_get(const struct scmi_protocol_handle *ph)
 	return pi->num_domains;
 }
 
+static const struct scmi_perf_domain_info *
+scmi_perf_domain_info_get(const struct scmi_protocol_handle *ph, u32 domain)
+{
+	struct scmi_perf_info *pi = ph->get_priv(ph);
+	struct perf_dom_info *dom = pi->dom_info + domain;
+
+	return &dom->info;
+}
+
 static int scmi_perf_mb_limits_set(const struct scmi_protocol_handle *ph,
 				   u32 domain, u32 max_perf, u32 min_perf)
 {
@@ -695,6 +705,7 @@ scmi_power_scale_get(const struct scmi_protocol_handle *ph)
 
 static const struct scmi_perf_proto_ops perf_proto_ops = {
 	.num_domains_get = scmi_perf_num_domains_get,
+	.domain_info_get = scmi_perf_domain_info_get,
 	.limits_set = scmi_perf_limits_set,
 	.limits_get = scmi_perf_limits_get,
 	.level_set = scmi_perf_level_set,
diff --git a/include/linux/scmi_protocol.h b/include/linux/scmi_protocol.h
index 71b39cbbdace..ed032fe83c28 100644
--- a/include/linux/scmi_protocol.h
+++ b/include/linux/scmi_protocol.h
@@ -97,11 +97,17 @@ struct scmi_clk_proto_ops {
 			      u32 clk_id);
 };
 
+struct scmi_perf_domain_info {
+	char name[SCMI_MAX_STR_SIZE];
+	bool set_perf;
+};
+
 /**
  * struct scmi_perf_proto_ops - represents the various operations provided
  *	by SCMI Performance Protocol
  *
  * @num_domains_get: gets the number of supported performance domains
+ * @domain_info_get: get the information of a performance domain
  * @limits_set: sets limits on the performance level of a domain
  * @limits_get: gets limits on the performance level of a domain
  * @level_set: sets the performance level of a domain
@@ -122,6 +128,8 @@ struct scmi_clk_proto_ops {
  */
 struct scmi_perf_proto_ops {
 	int (*num_domains_get)(const struct scmi_protocol_handle *ph);
+	const struct scmi_perf_domain_info __must_check *(*domain_info_get)
+		(const struct scmi_protocol_handle *ph, u32 domain);
 	int (*limits_set)(const struct scmi_protocol_handle *ph, u32 domain,
 			  u32 max_perf, u32 min_perf);
 	int (*limits_get)(const struct scmi_protocol_handle *ph, u32 domain,
-- 
2.34.1


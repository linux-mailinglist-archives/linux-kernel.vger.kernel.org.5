Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 203AD7524FE
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 16:18:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229593AbjGMOSz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 10:18:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235212AbjGMOSN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 10:18:13 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40E421BE3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 07:18:12 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-4fb7589b187so1376752e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 07:18:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689257890; x=1691849890;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XCW60+QKZJEwgQNKCkjT3LLL/G0odRdDq+OVPuDNpv8=;
        b=oOxWTQL84s47HzPwib77Qkzsk0IUI6gsDA6gu4jy0Yi+N8ICwlsvxW3n48T0+dpvad
         +LS59ztXwWyAgcVThqitorScRIRWebmtctZCKl1/oprdbAy0u060M6pLsWLzw7sXDQ1u
         TZrF8pAxZ152VQlX/QZqxOgHre1rwjtsa31dvqY8h8Cge6iJER9gvbA78oChr+XqUY2t
         P+6Gt760N4T+lcazbAhV2N/HpewowrkJHHJuisYZQBWJeK5VKKBbVxrYs/VomTaZn8Cc
         JQfo0XldJbMVoHeTv1pXCF+RdgeDNE6I0D6eOi0KZ++EsX9OtZj1bayKgar/03HsJa/S
         ogGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689257890; x=1691849890;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XCW60+QKZJEwgQNKCkjT3LLL/G0odRdDq+OVPuDNpv8=;
        b=av8PvszsF9x1vPFKzanLBmhQBhvLPE9tiUDKrgXOmcT6AvZuXNXAylQnoFlu2zc6BR
         w4zTe53UtwCQIUgMRgf9QUgFBjGcAjizfdSnkifIgtO2fyCjziJopvqItMZTDS2W0vTu
         Ej5j0pb2kNqtlOULFY1PRX4ZacU8jN+6rGXXz+NRNw6hH7N8t8vUc6cfpvEaIhhoDifT
         2sZYUG3ZjLsuFmjwU+myH8oO1+RY+3DVZXtaTEqfq2iBx3VPFsM1u0Hyv7NNvTdeCntz
         sOKtwzc1rPZ/vmwXjXD40UfWJVRElG+GBfmHzvH1qXAPZANjNYtRL+1CRQ2WIlsq7A5Z
         bhgA==
X-Gm-Message-State: ABy/qLYZCmygDR+IneJQ4wnNnMZ9i1jG8/tudhTLNHg+rtpSFsfdIlUx
        Y2sQoUaYi0Yrc9VuUl3LggIPfA==
X-Google-Smtp-Source: APBJJlHhUlmQdmzVtzAmBWmH4d/Jr/axU6dbey0CJjqA6hkRispEKgjxi6n+QoR4ZZ7q3oEvSoW5zw==
X-Received: by 2002:ac2:58e9:0:b0:4f8:7528:50b5 with SMTP id v9-20020ac258e9000000b004f8752850b5mr1225250lfo.14.1689257890294;
        Thu, 13 Jul 2023 07:18:10 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-94-254-63-18.NA.cust.bahnhof.se. [94.254.63.18])
        by smtp.gmail.com with ESMTPSA id w28-20020ac2599c000000b004fb759964a9sm1132426lfn.168.2023.07.13.07.18.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jul 2023 07:18:09 -0700 (PDT)
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
Subject: [PATCH v2 01/11] firmware: arm_scmi: Extend perf protocol ops to get number of domains
Date:   Thu, 13 Jul 2023 16:17:28 +0200
Message-Id: <20230713141738.23970-2-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230713141738.23970-1-ulf.hansson@linaro.org>
References: <20230713141738.23970-1-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Similar to other protocol ops, it's useful for an scmi module driver to get
the number of supported performance domains, hence let's make this
available by adding a new perf protocol callback. Note that, a user is
being added from subsequent changes.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Changes in v2:
	- None.

---
 drivers/firmware/arm_scmi/perf.c | 8 ++++++++
 include/linux/scmi_protocol.h    | 2 ++
 2 files changed, 10 insertions(+)

diff --git a/drivers/firmware/arm_scmi/perf.c b/drivers/firmware/arm_scmi/perf.c
index ecf5c4de851b..cf7f0de4d6db 100644
--- a/drivers/firmware/arm_scmi/perf.c
+++ b/drivers/firmware/arm_scmi/perf.c
@@ -333,6 +333,13 @@ scmi_perf_describe_levels_get(const struct scmi_protocol_handle *ph, u32 domain,
 	return ret;
 }
 
+static int scmi_perf_num_domains_get(const struct scmi_protocol_handle *ph)
+{
+	struct scmi_perf_info *pi = ph->get_priv(ph);
+
+	return pi->num_domains;
+}
+
 static int scmi_perf_mb_limits_set(const struct scmi_protocol_handle *ph,
 				   u32 domain, u32 max_perf, u32 min_perf)
 {
@@ -687,6 +694,7 @@ scmi_power_scale_get(const struct scmi_protocol_handle *ph)
 }
 
 static const struct scmi_perf_proto_ops perf_proto_ops = {
+	.num_domains_get = scmi_perf_num_domains_get,
 	.limits_set = scmi_perf_limits_set,
 	.limits_get = scmi_perf_limits_get,
 	.level_set = scmi_perf_level_set,
diff --git a/include/linux/scmi_protocol.h b/include/linux/scmi_protocol.h
index e6fe4f73ffe6..71b39cbbdace 100644
--- a/include/linux/scmi_protocol.h
+++ b/include/linux/scmi_protocol.h
@@ -101,6 +101,7 @@ struct scmi_clk_proto_ops {
  * struct scmi_perf_proto_ops - represents the various operations provided
  *	by SCMI Performance Protocol
  *
+ * @num_domains_get: gets the number of supported performance domains
  * @limits_set: sets limits on the performance level of a domain
  * @limits_get: gets limits on the performance level of a domain
  * @level_set: sets the performance level of a domain
@@ -120,6 +121,7 @@ struct scmi_clk_proto_ops {
  *	or in some other (abstract) scale
  */
 struct scmi_perf_proto_ops {
+	int (*num_domains_get)(const struct scmi_protocol_handle *ph);
 	int (*limits_set)(const struct scmi_protocol_handle *ph, u32 domain,
 			  u32 max_perf, u32 min_perf);
 	int (*limits_get)(const struct scmi_protocol_handle *ph, u32 domain,
-- 
2.34.1


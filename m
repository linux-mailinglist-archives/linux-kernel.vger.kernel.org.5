Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CFBD7885B5
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 13:28:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243954AbjHYL1i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 07:27:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243185AbjHYL1D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 07:27:03 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D1B52105
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 04:27:00 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-4ff9abf18f9so1220374e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 04:27:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692962819; x=1693567619;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Go52eA8TYeTAK4lIGpo0JK3kGk7oP6d4bfLl8VkdcL0=;
        b=w/FMHrbeRXkj/FUdm/Sz+jxlAwsdFmqwrOj5OswyiWGkPTsSL5+QquW4AClIQ5+U6i
         4P1jYsqHDnWMp6afBE/6uba5mOYSkw+v3SaOnbKvvGGuAQiAnV5CZPI0f0F92yfNIoia
         lDKfEzLa3DZA6J8hsDkxR1h4GUJfYbppL3XdcBfMEQBmzSO8ynyhNnbBAWYOL3uKVTYt
         budih/LZg5Zoj5RmdbwH/+hz4AOimB6+oUvfdN18gpYDeLdN0/MLhYYmtzxIzHrzZUoh
         jjiU/HT+AmjvDkAVKOZQ+bFgWBaA7YDBxLMKOElMRItGL6jp9CgdovMrdHGPKmqr5dLF
         vCaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692962819; x=1693567619;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Go52eA8TYeTAK4lIGpo0JK3kGk7oP6d4bfLl8VkdcL0=;
        b=jnTDqQ2tLPk5dWJ3SEG8iWsdhVe9WbB0S4xRkyyh3lVL0/9Fp4qPVi/1XttjsF9nrT
         i4s8hgUknZs54b4QGqL28zcjUZk3mgT3WIDD4PIM8D6eXBJ+4nGSRuTirRUcrGa7AO69
         PwuX8rdcWml7p+6LtERk4YreI+voV/QGTZcRv2JAlFIV3Lv3LwzKezBDLZF6iMF321c5
         oSte/UYctpPYhE7VahXZNdnWCl3AeM7qr6fvPnelc1nFiVGUfiZtZGYaTpHKpkSa3a4c
         fKwhwGPLOdwXqM0AwzdtCJjW9tO/CBbeNn2RPlk30t5XFRlxYnmJBHvIxgSciCTWGUAH
         Syng==
X-Gm-Message-State: AOJu0Yxac4sHvfphv+Ij/1AEbxFtpOnYRncT7dDypgmRdmCGo0M+gpv5
        8nZPGEQCbcyJdqjLGxLubX7qZA==
X-Google-Smtp-Source: AGHT+IExZ0+5DmQV2MQOehaqwy+sXY50Rxg9T+DJ+H5m6XwKLlATgt+8LTXB6lG4JjOInNo0uOtHDw==
X-Received: by 2002:a19:5f50:0:b0:4fb:99c7:bb60 with SMTP id a16-20020a195f50000000b004fb99c7bb60mr10736785lfj.59.1692962818867;
        Fri, 25 Aug 2023 04:26:58 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-94-254-63-18.NA.cust.bahnhof.se. [94.254.63.18])
        by smtp.gmail.com with ESMTPSA id g7-20020ac25387000000b004fb7ac67bbdsm259164lfh.41.2023.08.25.04.26.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Aug 2023 04:26:58 -0700 (PDT)
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
Subject: [PATCH v3 05/13] firmware: arm_scmi: Drop redundant ->device_domain_id() from perf ops
Date:   Fri, 25 Aug 2023 13:26:25 +0200
Message-Id: <20230825112633.236607-6-ulf.hansson@linaro.org>
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

There are no longer any users of the ->device_domain_id() ops in the
scmi_perf_proto_ops, therefore let's remove it.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Changes in v3:
	- None.

---
 drivers/firmware/arm_scmi/perf.c | 13 -------------
 include/linux/scmi_protocol.h    |  2 --
 2 files changed, 15 deletions(-)

diff --git a/drivers/firmware/arm_scmi/perf.c b/drivers/firmware/arm_scmi/perf.c
index 092b51cf9596..9eb58df9124d 100644
--- a/drivers/firmware/arm_scmi/perf.c
+++ b/drivers/firmware/arm_scmi/perf.c
@@ -782,18 +782,6 @@ static void scmi_perf_domain_init_fc(const struct scmi_protocol_handle *ph,
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
@@ -959,7 +947,6 @@ static const struct scmi_perf_proto_ops perf_proto_ops = {
 	.limits_get = scmi_perf_limits_get,
 	.level_set = scmi_perf_level_set,
 	.level_get = scmi_perf_level_get,
-	.device_domain_id = scmi_dev_domain_id,
 	.transition_latency_get = scmi_dvfs_transition_latency_get,
 	.device_opps_add = scmi_dvfs_device_opps_add,
 	.freq_set = scmi_dvfs_freq_set,
diff --git a/include/linux/scmi_protocol.h b/include/linux/scmi_protocol.h
index bf6b0be1890e..26cda536716a 100644
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


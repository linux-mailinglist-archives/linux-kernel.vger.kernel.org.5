Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 555967CF277
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 10:24:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232383AbjJSIYR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 04:24:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235109AbjJSIYI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 04:24:08 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9E3B196
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 01:24:05 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5a828bdcfbaso92333627b3.2
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 01:24:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697703845; x=1698308645; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Lu+FeCyL3oCgR0FP+gkAe4hCPFiLBzzy7yX8rQh0MDk=;
        b=KWMlBGzAEsg46eyBH395XpMNOG4zWRjOgLuLv2f+O28E4bLZ7UeUtPK/gzSwWg4oy6
         yekOL3vFaP68khniqFLgEVn19MaqMrIc9CR5RFxbHi/WcyDOsTCExochl43yhC97Lf2B
         jKUXgbF5nXGjALb6dxL+rg9puRQcbpmGX0ZyacdShthgORcv+/tKGTHsoWmnNIxV8cB8
         tjGbQk/9pfn1ZAyXMFW62AD+q4OEROoWQZhKBXr9N7PWNP7HrZtcD/37kJO+2U50ffmC
         sJ+XA2OVF2RcEg6RikjCBIPrkhWY6F8SCuK7GVf8Ss5gyKdb0mkzYNMw5H/8AfchiV6k
         4gFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697703845; x=1698308645;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Lu+FeCyL3oCgR0FP+gkAe4hCPFiLBzzy7yX8rQh0MDk=;
        b=PYwBmFm3LoQeHOA8gNTTWxx1jkutxmghclKhWzMHgnoG03Io9rtbvBpqUMFwsk73W2
         omvIp1LhhC9JdwwoEwhJIjnn+21njiWxKvrt3h8qXlyC1i5nfshvQOGDPdB6xKbkRIoi
         Y68P33TqN+u5xYYL/a3m/UkGHe57+phKqi090ppVYWoMD6xFHISx36g7MMkGQb56F3hb
         5NQ2v4BACvRAwrdTjm+C0jpj3L8fjUej6JiDIfoE/r4zXoqrLB+gokzz1ekHgOcIv6qY
         9UrfFokOt2ca98YnRc3JXajSdp4vfaKTe27EdF8/DjFPJtIWHItKkCU7IqvjSHPs4Iq6
         ENow==
X-Gm-Message-State: AOJu0Yzh8kp/mPkmyn2T7zQjm+6+wGFvz1nTBwu9fWcnOLWBp+gQyL6r
        zEVdwtCHYYHmTHD38hwaP/k6pzV7ggnH
X-Google-Smtp-Source: AGHT+IEirk34VW4JdGjVi2e1kKViuhhou/6R9Dp0JdkMnk46P/V54IcYs4vDzb7/EWCv6K5nHuC1EamwU9FI
X-Received: from wnhuang-p920.tpe.corp.google.com ([2401:fa00:fc:200:8537:873c:b8ab:6b48])
 (user=wnhuang job=sendgmr) by 2002:a05:6902:134a:b0:d9a:58e0:c7c7 with SMTP
 id g10-20020a056902134a00b00d9a58e0c7c7mr34535ybu.1.1697703845044; Thu, 19
 Oct 2023 01:24:05 -0700 (PDT)
Date:   Thu, 19 Oct 2023 16:23:57 +0800
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.655.g421f12c284-goog
Message-ID: <20231019082357.1505047-1-wnhuang@google.com>
Subject: [PATCH] coresight: etm4x: Allow configuring cycle count threshold
From:   Wei-Ning Huang <wnhuang@google.com>
To:     linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
        suzuki.poulose@arm.com, james.clark@arm.com, leo.yan@linaro.org
Cc:     linux-kernel@vger.kernel.org, Wei-Ning Huang <wnhuang@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow userspace to configure cycle count threshold through
perf_event_attr config. The last high 12-bit of config value is used to
store the cycle count threshold.

Signed-off-by: Wei-Ning Huang <wnhuang@google.com>
---
 drivers/hwtracing/coresight/coresight-etm4x-core.c |  6 +++++-
 include/linux/coresight-pmu.h                      | 14 ++++++++------
 tools/include/linux/coresight-pmu.h                | 14 ++++++++------
 3 files changed, 21 insertions(+), 13 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
index 77b0271ce6eb..155441668b4a 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
@@ -645,6 +645,7 @@ static int etm4_parse_event_config(struct coresight_device *csdev,
 	struct perf_event_attr *attr = &event->attr;
 	unsigned long cfg_hash;
 	int preset;
+	u64 cyc_threadhold;
 
 	/* Clear configuration from previous run */
 	memset(config, 0, sizeof(struct etmv4_config));
@@ -667,7 +668,10 @@ static int etm4_parse_event_config(struct coresight_device *csdev,
 	if (attr->config & BIT(ETM_OPT_CYCACC)) {
 		config->cfg |= TRCCONFIGR_CCI;
 		/* TRM: Must program this for cycacc to work */
-		config->ccctlr = ETM_CYC_THRESHOLD_DEFAULT;
+		cyc_threshold = ((attr->config >> ETM_OPT_CYC_THRESHOLD_SHIFT) &
+				 ETM_OPT_CYC_THRESHOLD_MASK;
+		config->ccctlr = cyc_threshold ? cyc_threshold :
+				 ETM_CYC_THRESHOLD_DEFAULT;
 	}
 	if (attr->config & BIT(ETM_OPT_TS)) {
 		/*
diff --git a/include/linux/coresight-pmu.h b/include/linux/coresight-pmu.h
index 51ac441a37c3..14f48658ff1c 100644
--- a/include/linux/coresight-pmu.h
+++ b/include/linux/coresight-pmu.h
@@ -29,12 +29,14 @@
  * ETMv3.5/PTM doesn't define ETMCR config bits with prefix "ETM3_" and
  * directly use below macros as config bits.
  */
-#define ETM_OPT_BRANCH_BROADCAST 8
-#define ETM_OPT_CYCACC		12
-#define ETM_OPT_CTXTID		14
-#define ETM_OPT_CTXTID2		15
-#define ETM_OPT_TS		28
-#define ETM_OPT_RETSTK		29
+#define ETM_OPT_BRANCH_BROADCAST	8
+#define ETM_OPT_CYCACC			12
+#define ETM_OPT_CTXTID			14
+#define ETM_OPT_CTXTID2			15
+#define ETM_OPT_TS			28
+#define ETM_OPT_RETSTK			29
+#define ETM_OPT_CYC_THRESHOLD_SHIFT	52
+#define ETM_OPT_CYC_THRESHOLD_MASK	0xfff
 
 /* ETMv4 CONFIGR programming bits for the ETM OPTs */
 #define ETM4_CFG_BIT_BB         3
diff --git a/tools/include/linux/coresight-pmu.h b/tools/include/linux/coresight-pmu.h
index 51ac441a37c3..14f48658ff1c 100644
--- a/tools/include/linux/coresight-pmu.h
+++ b/tools/include/linux/coresight-pmu.h
@@ -29,12 +29,14 @@
  * ETMv3.5/PTM doesn't define ETMCR config bits with prefix "ETM3_" and
  * directly use below macros as config bits.
  */
-#define ETM_OPT_BRANCH_BROADCAST 8
-#define ETM_OPT_CYCACC		12
-#define ETM_OPT_CTXTID		14
-#define ETM_OPT_CTXTID2		15
-#define ETM_OPT_TS		28
-#define ETM_OPT_RETSTK		29
+#define ETM_OPT_BRANCH_BROADCAST	8
+#define ETM_OPT_CYCACC			12
+#define ETM_OPT_CTXTID			14
+#define ETM_OPT_CTXTID2			15
+#define ETM_OPT_TS			28
+#define ETM_OPT_RETSTK			29
+#define ETM_OPT_CYC_THRESHOLD_SHIFT	52
+#define ETM_OPT_CYC_THRESHOLD_MASK	0xfff
 
 /* ETMv4 CONFIGR programming bits for the ETM OPTs */
 #define ETM4_CFG_BIT_BB         3
-- 
2.42.0.655.g421f12c284-goog


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9A6F778631
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 05:46:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233199AbjHKDq0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 23:46:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233266AbjHKDqW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 23:46:22 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A2EAC2D78;
        Thu, 10 Aug 2023 20:46:21 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B61C5D75;
        Thu, 10 Aug 2023 20:47:03 -0700 (PDT)
Received: from a077893.arm.com (unknown [10.163.54.13])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D6E0E3F6C4;
        Thu, 10 Aug 2023 20:46:16 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-arm-kernel@lists.infradead.org, suzuki.poulose@arm.com
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mike Leach <mike.leach@linaro.org>,
        James Clark <james.clark@arm.com>,
        Leo Yan <leo.yan@linaro.org>, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org, coresight@lists.linaro.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V3 2/3] coresight: etm: Make cycle count threshold user configurable
Date:   Fri, 11 Aug 2023 09:15:59 +0530
Message-Id: <20230811034600.944386-3-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230811034600.944386-1-anshuman.khandual@arm.com>
References: <20230811034600.944386-1-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cycle counting is enabled, when requested and supported but with a default
threshold value ETM_CYC_THRESHOLD_DEFAULT i.e 0x100 getting into TRCCCCTLR,
representing the minimum interval between cycle count trace packets.

This makes cycle threshold user configurable, from the user space via perf
event attributes. Although it falls back using ETM_CYC_THRESHOLD_DEFAULT,
in case no explicit request. As expected it creates a sysfs file as well.

/sys/bus/event_source/devices/cs_etm/format/cc_threshold

New 'cc_threshold' uses 'event->attr.config3' as no more space is available
in 'event->attr.config1' or 'event->attr.config2'.

Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: Mike Leach <mike.leach@linaro.org>
Cc: James Clark <james.clark@arm.com>
Cc: Leo Yan <leo.yan@linaro.org>
Cc: coresight@lists.linaro.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 drivers/hwtracing/coresight/coresight-etm-perf.c   |  2 ++
 drivers/hwtracing/coresight/coresight-etm4x-core.c | 12 ++++++++++--
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
index 5ca6278baff4..09f75dffae60 100644
--- a/drivers/hwtracing/coresight/coresight-etm-perf.c
+++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
@@ -68,6 +68,7 @@ PMU_FORMAT_ATTR(preset,		"config:0-3");
 PMU_FORMAT_ATTR(sinkid,		"config2:0-31");
 /* config ID - set if a system configuration is selected */
 PMU_FORMAT_ATTR(configid,	"config2:32-63");
+PMU_FORMAT_ATTR(cc_threshold,	"config3:0-11");
 
 
 /*
@@ -101,6 +102,7 @@ static struct attribute *etm_config_formats_attr[] = {
 	&format_attr_preset.attr,
 	&format_attr_configid.attr,
 	&format_attr_branch_broadcast.attr,
+	&format_attr_cc_threshold.attr,
 	NULL,
 };
 
diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
index 1f3d29a639ff..ad28ee044cba 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
@@ -644,7 +644,7 @@ static int etm4_parse_event_config(struct coresight_device *csdev,
 	struct etmv4_config *config = &drvdata->config;
 	struct perf_event_attr *attr = &event->attr;
 	unsigned long cfg_hash;
-	int preset;
+	int preset, cc_threshold;
 
 	/* Clear configuration from previous run */
 	memset(config, 0, sizeof(struct etmv4_config));
@@ -667,7 +667,15 @@ static int etm4_parse_event_config(struct coresight_device *csdev,
 	if (attr->config & BIT(ETM_OPT_CYCACC)) {
 		config->cfg |= TRCCONFIGR_CCI;
 		/* TRM: Must program this for cycacc to work */
-		config->ccctlr = ETM_CYC_THRESHOLD_DEFAULT;
+		cc_threshold = attr->config3 & ETM_CYC_THRESHOLD_MASK;
+		if (cc_threshold) {
+			if (cc_threshold < drvdata->ccitmin)
+				config->ccctlr = drvdata->ccitmin;
+			else
+				config->ccctlr = cc_threshold;
+		} else {
+			config->ccctlr = ETM_CYC_THRESHOLD_DEFAULT;
+		}
 	}
 	if (attr->config & BIT(ETM_OPT_TS)) {
 		/*
-- 
2.25.1


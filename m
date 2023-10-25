Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 487507D755A
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 22:17:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230286AbjJYUQj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 16:16:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234337AbjJYUQ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 16:16:27 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 967B5136
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 13:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698264985; x=1729800985;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Cq41MKhmxSv+VmENwgWIgLLnJ6HE1k26gc7pRvVAMjw=;
  b=jDNesEt/WbgZTaYdX2mO3cUxTfr4nwqbsV2dIWLtbgIPbX60chXdZ85g
   aDgJQV+cc4nNjcx5485RUaX7loKGq13HdYo3VlXyEtTMREYxVVFfBByXH
   bpzXelOKmAuBs7NAnU6Cp7rTadQ80FnK9buHeh8ooWTpWTu3mtDPDXCuU
   vfzCnYfnifQwWWo+ZaPMVexGRxVRp4XkwEDdwJaBNU3VDhLHpvqhMKHnZ
   fjeNHKSYXpEiOOrzCl0XtgEn0SK7BgUN1Yl7msTDHcuU26qtXfkfoCgps
   3g/361KB9ocRabQiURXcF6kCdb43UkM0SSVxn38hI63wltjQXH8TE1+1r
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="377758213"
X-IronPort-AV: E=Sophos;i="6.03,250,1694761200"; 
   d="scan'208";a="377758213"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2023 13:16:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="752459071"
X-IronPort-AV: E=Sophos;i="6.03,250,1694761200"; 
   d="scan'208";a="752459071"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by orsmga007.jf.intel.com with ESMTP; 25 Oct 2023 13:16:22 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, namhyung@kernel.org, irogers@google.com,
        adrian.hunter@intel.com, ak@linux.intel.com, eranian@google.com,
        alexey.v.bayduraev@linux.intel.com, tinghao.zhang@intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V5 4/8] perf/x86/intel: Reorganize attrs and is_visible
Date:   Wed, 25 Oct 2023 13:16:22 -0700
Message-Id: <20231025201626.3000228-4-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20231025201626.3000228-1-kan.liang@linux.intel.com>
References: <20231025201626.3000228-1-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

Some attrs and is_visible implementations are rather far away from one
another which makes the whole thing hard to interpret.

There are only two attribute groups which have both .attrs and
.is_visible, group_default and group_caps_lbr. Move them together.

No functional changes.

Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---

New patch

 arch/x86/events/intel/core.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index a99449c0d77c..584b58df7bf6 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -5540,6 +5540,12 @@ static struct attribute *lbr_attrs[] = {
 	NULL
 };
 
+static umode_t
+lbr_is_visible(struct kobject *kobj, struct attribute *attr, int i)
+{
+	return x86_pmu.lbr_nr ? attr->mode : 0;
+}
+
 static char pmu_name_str[30];
 
 static ssize_t pmu_name_show(struct device *cdev,
@@ -5566,6 +5572,15 @@ static struct attribute *intel_pmu_attrs[] = {
 	NULL,
 };
 
+static umode_t
+default_is_visible(struct kobject *kobj, struct attribute *attr, int i)
+{
+	if (attr == &dev_attr_allow_tsx_force_abort.attr)
+		return x86_pmu.flags & PMU_FL_TFA ? attr->mode : 0;
+
+	return attr->mode;
+}
+
 static umode_t
 tsx_is_visible(struct kobject *kobj, struct attribute *attr, int i)
 {
@@ -5587,27 +5602,12 @@ mem_is_visible(struct kobject *kobj, struct attribute *attr, int i)
 	return pebs_is_visible(kobj, attr, i);
 }
 
-static umode_t
-lbr_is_visible(struct kobject *kobj, struct attribute *attr, int i)
-{
-	return x86_pmu.lbr_nr ? attr->mode : 0;
-}
-
 static umode_t
 exra_is_visible(struct kobject *kobj, struct attribute *attr, int i)
 {
 	return x86_pmu.version >= 2 ? attr->mode : 0;
 }
 
-static umode_t
-default_is_visible(struct kobject *kobj, struct attribute *attr, int i)
-{
-	if (attr == &dev_attr_allow_tsx_force_abort.attr)
-		return x86_pmu.flags & PMU_FL_TFA ? attr->mode : 0;
-
-	return attr->mode;
-}
-
 static struct attribute_group group_events_td  = {
 	.name = "events",
 };
-- 
2.35.1


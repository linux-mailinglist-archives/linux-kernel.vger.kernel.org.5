Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A04F7EE2AF
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 15:22:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345305AbjKPOW5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 09:22:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345303AbjKPOWz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 09:22:55 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0358719D
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 06:22:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700144572; x=1731680572;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=twF0yMuknuHU1zfCoxs5nE6Pr/iTI67oOU0Ux/+a/uk=;
  b=SXiSDKuQvEe2Il3Zi84tpSM8l6PwlBHF7yALcOb0IID7hJ5YUkILhLf5
   EO53zHh8ClTfsudLh1hDyDK5tzsyScJZrHE0vZTta6awgnEv8MEoKCCMz
   +JqesnTA9W+A1cc36Bu8KKT5eZunSRzqVU6DYmKRpjBZISv0V7keeahLN
   cLHW56yxnoUXyzi0fPjun62hFpqVtXMUDhlSNpOkzLU3mKHmx+w9T/7B8
   pQuhdcmdYBn31YVyPZ/KbAHyoWwV5YNc3fY0m4ggJnnRH7xT49j1f5aB5
   G9AtrGCMqfm0HmQtgudMlUXHyq24a5MP4xyzkVXUkJt79CmGhow12C5t/
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10896"; a="12644424"
X-IronPort-AV: E=Sophos;i="6.04,308,1695711600"; 
   d="scan'208";a="12644424"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2023 06:22:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10896"; a="800173365"
X-IronPort-AV: E=Sophos;i="6.04,308,1695711600"; 
   d="scan'208";a="800173365"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by orsmga001.jf.intel.com with ESMTP; 16 Nov 2023 06:22:49 -0800
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Cc:     artem.bityutskiy@linux.intel.com, rui.zhang@intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [RESEND PATCH 1/4] perf/x86/intel/cstate: Cleanup duplicate attr_groups
Date:   Thu, 16 Nov 2023 06:22:42 -0800
Message-Id: <20231116142245.1233485-1-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

The events of the cstate_core and cstate_pkg PMU have the same format.
They both need to create a "events" group (with empty attrs). The
attr_groups can be shared.

Remove the dedicated attr_groups for each cstate PMU. Use the shared
cstate_attr_groups to replace.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/intel/cstate.c | 44 +++++++++-------------------------
 1 file changed, 11 insertions(+), 33 deletions(-)

diff --git a/arch/x86/events/intel/cstate.c b/arch/x86/events/intel/cstate.c
index cbeb6d2bf5b4..693bdcd92e8c 100644
--- a/arch/x86/events/intel/cstate.c
+++ b/arch/x86/events/intel/cstate.c
@@ -189,20 +189,20 @@ static struct attribute *attrs_empty[] = {
  * "events" group (with empty attrs) before updating
  * it with detected events.
  */
-static struct attribute_group core_events_attr_group = {
+static struct attribute_group cstate_events_attr_group = {
 	.name = "events",
 	.attrs = attrs_empty,
 };
 
-DEFINE_CSTATE_FORMAT_ATTR(core_event, event, "config:0-63");
-static struct attribute *core_format_attrs[] = {
-	&format_attr_core_event.attr,
+DEFINE_CSTATE_FORMAT_ATTR(cstate_event, event, "config:0-63");
+static struct attribute *cstate_format_attrs[] = {
+	&format_attr_cstate_event.attr,
 	NULL,
 };
 
-static struct attribute_group core_format_attr_group = {
+static struct attribute_group cstate_format_attr_group = {
 	.name = "format",
-	.attrs = core_format_attrs,
+	.attrs = cstate_format_attrs,
 };
 
 static cpumask_t cstate_core_cpu_mask;
@@ -217,9 +217,9 @@ static struct attribute_group cpumask_attr_group = {
 	.attrs = cstate_cpumask_attrs,
 };
 
-static const struct attribute_group *core_attr_groups[] = {
-	&core_events_attr_group,
-	&core_format_attr_group,
+static const struct attribute_group *cstate_attr_groups[] = {
+	&cstate_events_attr_group,
+	&cstate_format_attr_group,
 	&cpumask_attr_group,
 	NULL,
 };
@@ -268,30 +268,8 @@ static struct perf_msr pkg_msr[] = {
 	[PERF_CSTATE_PKG_C10_RES] = { MSR_PKG_C10_RESIDENCY,	&group_cstate_pkg_c10,	test_msr },
 };
 
-static struct attribute_group pkg_events_attr_group = {
-	.name = "events",
-	.attrs = attrs_empty,
-};
-
-DEFINE_CSTATE_FORMAT_ATTR(pkg_event, event, "config:0-63");
-static struct attribute *pkg_format_attrs[] = {
-	&format_attr_pkg_event.attr,
-	NULL,
-};
-static struct attribute_group pkg_format_attr_group = {
-	.name = "format",
-	.attrs = pkg_format_attrs,
-};
-
 static cpumask_t cstate_pkg_cpu_mask;
 
-static const struct attribute_group *pkg_attr_groups[] = {
-	&pkg_events_attr_group,
-	&pkg_format_attr_group,
-	&cpumask_attr_group,
-	NULL,
-};
-
 static ssize_t cstate_get_attr_cpumask(struct device *dev,
 				       struct device_attribute *attr,
 				       char *buf)
@@ -478,7 +456,7 @@ static const struct attribute_group *pkg_attr_update[] = {
 };
 
 static struct pmu cstate_core_pmu = {
-	.attr_groups	= core_attr_groups,
+	.attr_groups	= cstate_attr_groups,
 	.attr_update	= core_attr_update,
 	.name		= "cstate_core",
 	.task_ctx_nr	= perf_invalid_context,
@@ -493,7 +471,7 @@ static struct pmu cstate_core_pmu = {
 };
 
 static struct pmu cstate_pkg_pmu = {
-	.attr_groups	= pkg_attr_groups,
+	.attr_groups	= cstate_attr_groups,
 	.attr_update	= pkg_attr_update,
 	.name		= "cstate_pkg",
 	.task_ctx_nr	= perf_invalid_context,
-- 
2.35.1


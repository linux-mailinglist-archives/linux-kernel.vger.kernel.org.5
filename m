Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 776987CB17B
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 19:40:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229666AbjJPRkd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 13:40:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231678AbjJPRk2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 13:40:28 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD85B83
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 10:40:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697478023; x=1729014023;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=twF0yMuknuHU1zfCoxs5nE6Pr/iTI67oOU0Ux/+a/uk=;
  b=l8c08qYf2PIncopJRGWLAm1P/laIk/jbvwhq8tbmX490IhsuijewcoQw
   bC7HF8WZ5j8BO9OrLaHhn+RycwafCxPhUfOiEF5KG4uDMXvJMMyCu3o0i
   chuMe97pH4/Gid2PB6fANCSP8kNiac4EiWAE8Vn/L3DgInoDe/G92qJfj
   8CSB1rV4yge3tnV+SggLgG8dWNjFONGzOVLPsHdXmeGe5zeHZUGkSKXEf
   2emYNMP58WBloWFktwgyyPicg7gt7FBmcmUApQAshwW1OigOVR808V7Fw
   b7cw0I5ulP6PCjBGtSDmiQFM5WdcPbzhSef+ttNQ7XcXDQZ308g0C6cbO
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="365858551"
X-IronPort-AV: E=Sophos;i="6.03,229,1694761200"; 
   d="scan'208";a="365858551"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2023 10:40:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="785175356"
X-IronPort-AV: E=Sophos;i="6.03,229,1694761200"; 
   d="scan'208";a="785175356"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by orsmga008.jf.intel.com with ESMTP; 16 Oct 2023 10:40:22 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Cc:     artem.bityutskiy@linux.intel.com, rui.zhang@intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH 1/4] perf/x86/intel/cstate: Cleanup duplicate attr_groups
Date:   Mon, 16 Oct 2023 10:40:11 -0700
Message-Id: <20231016174014.453169-1-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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


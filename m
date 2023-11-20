Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D8EE7F15D1
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 15:35:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233590AbjKTOfw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 09:35:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233483AbjKTOfp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 09:35:45 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D34B8131;
        Mon, 20 Nov 2023 06:35:41 -0800 (PST)
Date:   Mon, 20 Nov 2023 14:35:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1700490940;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9M6sdiqGCwinQGMULaQmGbucsy2SVfpdAMoCHNBDpF0=;
        b=SbV8qGCSJ60aoBfUWO8zvv/w1riknKDbj9z7udbfzyUOpcTGcnp9lYORiwmu8O9McbEuFa
        00uMxrq9j8uyojzgAVZVYjUiI6L+JXET/SgulN2V5onjD551FmGdBp4hUOzIYNxQXUrr43
        i1WpCeyE2k5P30zjJjetuEpjBkMT0EJVdB7XmGrbxzYwJqMFwg5uf3/aOvWWxvPx+h1YNw
        Nbblpbv8ZZ4VbTFakOZyt2bqxlPOo5l6Buu/SZodUgaSD2tkbb4Kq39uaJNavwbxtwJomG
        DdBrwBSsV/p8Ru/Beg3N8/aPaGimEI0BmqkupvXLGiHjk5Od3jyTGZfqCYCdEA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1700490940;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9M6sdiqGCwinQGMULaQmGbucsy2SVfpdAMoCHNBDpF0=;
        b=Q/zvfwnqv+DNYVXrNV9sr0nIJIvHWnUuwYHh2XYRnHmGFadX/CWeiin8w2Btiy1Ozl0fDO
        m/Rshz/7w7xyefAw==
From:   "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/intel/cstate: Cleanup duplicate attr_groups
Cc:     Kan Liang <kan.liang@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20231116142245.1233485-1-kan.liang@linux.intel.com>
References: <20231116142245.1233485-1-kan.liang@linux.intel.com>
MIME-Version: 1.0
Message-ID: <170049093988.398.3710895579013151635.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     243218ca93037631f0224fdbefea045912cb761a
Gitweb:        https://git.kernel.org/tip/243218ca93037631f0224fdbefea045912cb761a
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Thu, 16 Nov 2023 06:22:42 -08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 17 Nov 2023 10:54:52 +01:00

perf/x86/intel/cstate: Cleanup duplicate attr_groups

The events of the cstate_core and cstate_pkg PMU have the same format.
They both need to create a "events" group (with empty attrs). The
attr_groups can be shared.

Remove the dedicated attr_groups for each cstate PMU. Use the shared
cstate_attr_groups to replace.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20231116142245.1233485-1-kan.liang@linux.intel.com
---
 arch/x86/events/intel/cstate.c | 44 ++++++++-------------------------
 1 file changed, 11 insertions(+), 33 deletions(-)

diff --git a/arch/x86/events/intel/cstate.c b/arch/x86/events/intel/cstate.c
index cbeb6d2..693bdcd 100644
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

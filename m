Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A527B7D9982
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 15:16:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345860AbjJ0NQ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 09:16:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231555AbjJ0NQz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 09:16:55 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17C0C10E;
        Fri, 27 Oct 2023 06:16:53 -0700 (PDT)
Date:   Fri, 27 Oct 2023 13:16:50 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1698412611;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uiSF5Np9mn/DveiCzhPpHBBhGb0WLRkwZ5XaYOgjchA=;
        b=A4eoc4onAy40tgJ2cKS+jI1RaXWjB6oUg6Ou+g4nxl0vBDlm+e8qPougXx4nypgQ/hlEfN
        sAel4Y/j9MqtMJyNhgg2JZo3jnWR6U9ibLJhVAlSBLUt24qMetBByxqdTacWytq68+zgsf
        n3SNh1QhvZp2LvHDEE2QcFPKiGNzr1wdGr5Rm5zov8dJfjKth6J6WwANfuNlMX6m410knQ
        VNoJayvRNFQDw87eQYSiyMs3llB+pEqSLr9fQobINE/uzTQAX0/XFew2MhA+hphMcD3qX8
        sR/cm96hw3Y6yPwry81ivlZ9HPk3/VVST+W0bUO17A3U3nGxr2LbJbXedn1ZBQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1698412611;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uiSF5Np9mn/DveiCzhPpHBBhGb0WLRkwZ5XaYOgjchA=;
        b=FMc4H138dBNhfcz6nzDSRGkim+wi3Qr3nLR0V2u4w8RyKP88/vuB1aIuHxXNOgNdbBS6vp
        nYiaUgOJMXE+BeCg==
From:   "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/intel: Reorganize attrs and is_visible
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Kan Liang <kan.liang@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20231025201626.3000228-4-kan.liang@linux.intel.com>
References: <20231025201626.3000228-4-kan.liang@linux.intel.com>
MIME-Version: 1.0
Message-ID: <169841261028.3135.13368844314175705110.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     318c4985911245508f7e0bab5265e208a38b5f18
Gitweb:        https://git.kernel.org/tip/318c4985911245508f7e0bab5265e208a38b5f18
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Wed, 25 Oct 2023 13:16:22 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 27 Oct 2023 15:05:10 +02:00

perf/x86/intel: Reorganize attrs and is_visible

Some attrs and is_visible implementations are rather far away from one
another which makes the whole thing hard to interpret.

There are only two attribute groups which have both .attrs and
.is_visible, group_default and group_caps_lbr. Move them together.

No functional changes.

Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20231025201626.3000228-4-kan.liang@linux.intel.com
---
 arch/x86/events/intel/core.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index a99449c..584b58d 100644
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
@@ -5567,6 +5573,15 @@ static struct attribute *intel_pmu_attrs[] = {
 };
 
 static umode_t
+default_is_visible(struct kobject *kobj, struct attribute *attr, int i)
+{
+	if (attr == &dev_attr_allow_tsx_force_abort.attr)
+		return x86_pmu.flags & PMU_FL_TFA ? attr->mode : 0;
+
+	return attr->mode;
+}
+
+static umode_t
 tsx_is_visible(struct kobject *kobj, struct attribute *attr, int i)
 {
 	return boot_cpu_has(X86_FEATURE_RTM) ? attr->mode : 0;
@@ -5588,26 +5603,11 @@ mem_is_visible(struct kobject *kobj, struct attribute *attr, int i)
 }
 
 static umode_t
-lbr_is_visible(struct kobject *kobj, struct attribute *attr, int i)
-{
-	return x86_pmu.lbr_nr ? attr->mode : 0;
-}
-
-static umode_t
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

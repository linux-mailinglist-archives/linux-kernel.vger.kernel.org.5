Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 583EA7EBF78
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 10:29:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234785AbjKOJ3F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 04:29:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234688AbjKOJ3E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 04:29:04 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5525D9B;
        Wed, 15 Nov 2023 01:29:01 -0800 (PST)
Date:   Wed, 15 Nov 2023 09:28:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1700040540;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ccZL0j9gRjBhtc4FakVMy7I3+YuzgGEEyPPs3z/zxSQ=;
        b=SDBJhFyQm79dD0Szf2J/AGpGnNP80al77IEYdjWAZ3Q1e+CJ0XGSsS9fX9s0DoY7TZJwZq
        KGqjsKr1Q5NIAnMFdwo4KTkqxZtUPHukoiF65d6AXSUwOgAiKFFrj79BuYAZ7BJmajIk5F
        ELA0fAJhgUcpgXi8HX6NJXg2AqvWvmQ9FImzN3ZkZpKI0SraZvNTG7G8OUQleg0xXcn6LJ
        yz/4JBhGA3apRM9V4zoSWnWdrgcOtJaDEwpi157GMPgd8PM+zabKoj8ZouOBIEvspCgbr0
        kV99pB8u3zWX2W6sEdXSmYv7DyOPHOrEGGSJNSewKn9Io1yubfPUjmAoSI/HSg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1700040540;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ccZL0j9gRjBhtc4FakVMy7I3+YuzgGEEyPPs3z/zxSQ=;
        b=winUrXOua56iinRnHDOn7h3Votrwo90OaOoi18mI6Fs0CoeQKxYU2pCSP5q7ivdW7XBWz4
        WjHDG/RWHADVAFDw==
From:   "tip-bot2 for Greg KH" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/core: Fix narrow startup race when creating the
 perf nr_addr_filters sysfs file
Cc:     "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <2023061204-decal-flyable-6090@gregkh>
References: <2023061204-decal-flyable-6090@gregkh>
MIME-Version: 1.0
Message-ID: <170004053915.391.15537018323305525367.tip-bot2@tip-bot2>
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

Commit-ID:     652ffc2104ec1f69dd4a46313888c33527145ccf
Gitweb:        https://git.kernel.org/tip/652ffc2104ec1f69dd4a46313888c33527145ccf
Author:        Greg KH <gregkh@linuxfoundation.org>
AuthorDate:    Mon, 12 Jun 2023 15:09:09 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 15 Nov 2023 10:15:50 +01:00

perf/core: Fix narrow startup race when creating the perf nr_addr_filters sysfs file

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/2023061204-decal-flyable-6090@gregkh
---
 kernel/events/core.c | 40 ++++++++++++++++++++++++++++------------
 1 file changed, 28 insertions(+), 12 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 0825098..4f0c45a 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -11408,9 +11408,32 @@ static DEVICE_ATTR_RW(perf_event_mux_interval_ms);
 static struct attribute *pmu_dev_attrs[] = {
 	&dev_attr_type.attr,
 	&dev_attr_perf_event_mux_interval_ms.attr,
+	&dev_attr_nr_addr_filters.attr,
+	NULL,
+};
+
+static umode_t pmu_dev_is_visible(struct kobject *kobj, struct attribute *a, int n)
+{
+	struct device *dev = kobj_to_dev(kobj);
+	struct pmu *pmu = dev_get_drvdata(dev);
+
+	if (!pmu->nr_addr_filters)
+		return 0;
+
+	return a->mode;
+
+	return 0;
+}
+
+static struct attribute_group pmu_dev_attr_group = {
+	.is_visible = pmu_dev_is_visible,
+	.attrs = pmu_dev_attrs,
+};
+
+static const struct attribute_group *pmu_dev_groups[] = {
+	&pmu_dev_attr_group,
 	NULL,
 };
-ATTRIBUTE_GROUPS(pmu_dev);
 
 static int pmu_bus_running;
 static struct bus_type pmu_bus = {
@@ -11447,18 +11470,11 @@ static int pmu_dev_alloc(struct pmu *pmu)
 	if (ret)
 		goto free_dev;
 
-	/* For PMUs with address filters, throw in an extra attribute: */
-	if (pmu->nr_addr_filters)
-		ret = device_create_file(pmu->dev, &dev_attr_nr_addr_filters);
-
-	if (ret)
-		goto del_dev;
-
-	if (pmu->attr_update)
+	if (pmu->attr_update) {
 		ret = sysfs_update_groups(&pmu->dev->kobj, pmu->attr_update);
-
-	if (ret)
-		goto del_dev;
+		if (ret)
+			goto del_dev;
+	}
 
 out:
 	return ret;

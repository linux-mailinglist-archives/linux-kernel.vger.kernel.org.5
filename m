Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 737AC7EDA55
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 04:34:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344941AbjKPDex (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 22:34:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344862AbjKPDep (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 22:34:45 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CE341A3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 19:34:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700105679;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JXr3bQ61j0E4EgBKuR83M4hu7Kv1a8DgmvRIQYgdtY0=;
        b=eE38X/ECGbCtFl5HepDQgPocrdNi2JTkvx2BRjWOv48qMi2XCrRziyK7uoMtJRxVPQI5yv
        U/SBz8RV5vNWizDAfGFBWerDeanv68nHiJxY26AcL8vfd6vhh+gGGRrajQJnvPI6Xc1h+B
        2ZeQyan9PjnMhpk9lRLmTpNIR12xuXk=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-600-E_xi3bx8NkKrua8L76dUXw-1; Wed,
 15 Nov 2023 22:34:35 -0500
X-MC-Unique: E_xi3bx8NkKrua8L76dUXw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 76C701C04340;
        Thu, 16 Nov 2023 03:34:34 +0000 (UTC)
Received: from llong.com (unknown [10.22.8.169])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0ED7E492BFD;
        Thu, 16 Nov 2023 03:34:34 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Peter Hunt <pehunt@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH v4 1/5] workqueue: Make workqueue_set_unbound_cpumask() static
Date:   Wed, 15 Nov 2023 22:34:01 -0500
Message-Id: <20231116033405.185166-2-longman@redhat.com>
In-Reply-To: <20231116033405.185166-1-longman@redhat.com>
References: <20231116033405.185166-1-longman@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The workqueue_set_unbound_cpumask() function is only used inside
workqueue.c with CONFIG_SYSFS. Make it static and move it down to
within the ifdef CONFIG_SYSFS block. Also move apply_wqattrs_lock()
and apply_wqattrs_unlock() down as all their callers are within the
CONFIG_SYSFS block.

Also mark workqueue_apply_unbound_cpumask() as __maybe_unused for now as
it will be used by another function introduced in a later commit. There
is no functional change.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 include/linux/workqueue.h |   1 -
 kernel/workqueue.c        | 102 +++++++++++++++++++-------------------
 2 files changed, 51 insertions(+), 52 deletions(-)

diff --git a/include/linux/workqueue.h b/include/linux/workqueue.h
index 24b1e5070f4d..cf49b467bd57 100644
--- a/include/linux/workqueue.h
+++ b/include/linux/workqueue.h
@@ -491,7 +491,6 @@ struct workqueue_attrs *alloc_workqueue_attrs(void);
 void free_workqueue_attrs(struct workqueue_attrs *attrs);
 int apply_workqueue_attrs(struct workqueue_struct *wq,
 			  const struct workqueue_attrs *attrs);
-int workqueue_set_unbound_cpumask(cpumask_var_t cpumask);
 
 extern bool queue_work_on(int cpu, struct workqueue_struct *wq,
 			struct work_struct *work);
diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 6e578f576a6f..145159f993e9 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -4411,19 +4411,6 @@ static void apply_wqattrs_commit(struct apply_wqattrs_ctx *ctx)
 	mutex_unlock(&ctx->wq->mutex);
 }
 
-static void apply_wqattrs_lock(void)
-{
-	/* CPUs should stay stable across pwq creations and installations */
-	cpus_read_lock();
-	mutex_lock(&wq_pool_mutex);
-}
-
-static void apply_wqattrs_unlock(void)
-{
-	mutex_unlock(&wq_pool_mutex);
-	cpus_read_unlock();
-}
-
 static int apply_workqueue_attrs_locked(struct workqueue_struct *wq,
 					const struct workqueue_attrs *attrs)
 {
@@ -5784,7 +5771,7 @@ void thaw_workqueues(void)
 }
 #endif /* CONFIG_FREEZER */
 
-static int workqueue_apply_unbound_cpumask(const cpumask_var_t unbound_cpumask)
+static int __maybe_unused workqueue_apply_unbound_cpumask(const cpumask_var_t unbound_cpumask)
 {
 	LIST_HEAD(ctxs);
 	int ret = 0;
@@ -5827,43 +5814,6 @@ static int workqueue_apply_unbound_cpumask(const cpumask_var_t unbound_cpumask)
 	return ret;
 }
 
-/**
- *  workqueue_set_unbound_cpumask - Set the low-level unbound cpumask
- *  @cpumask: the cpumask to set
- *
- *  The low-level workqueues cpumask is a global cpumask that limits
- *  the affinity of all unbound workqueues.  This function check the @cpumask
- *  and apply it to all unbound workqueues and updates all pwqs of them.
- *
- *  Return:	0	- Success
- *  		-EINVAL	- Invalid @cpumask
- *  		-ENOMEM	- Failed to allocate memory for attrs or pwqs.
- */
-int workqueue_set_unbound_cpumask(cpumask_var_t cpumask)
-{
-	int ret = -EINVAL;
-
-	/*
-	 * Not excluding isolated cpus on purpose.
-	 * If the user wishes to include them, we allow that.
-	 */
-	cpumask_and(cpumask, cpumask, cpu_possible_mask);
-	if (!cpumask_empty(cpumask)) {
-		apply_wqattrs_lock();
-		if (cpumask_equal(cpumask, wq_unbound_cpumask)) {
-			ret = 0;
-			goto out_unlock;
-		}
-
-		ret = workqueue_apply_unbound_cpumask(cpumask);
-
-out_unlock:
-		apply_wqattrs_unlock();
-	}
-
-	return ret;
-}
-
 static int parse_affn_scope(const char *val)
 {
 	int i;
@@ -5982,6 +5932,19 @@ static struct attribute *wq_sysfs_attrs[] = {
 };
 ATTRIBUTE_GROUPS(wq_sysfs);
 
+static void apply_wqattrs_lock(void)
+{
+	/* CPUs should stay stable across pwq creations and installations */
+	cpus_read_lock();
+	mutex_lock(&wq_pool_mutex);
+}
+
+static void apply_wqattrs_unlock(void)
+{
+	mutex_unlock(&wq_pool_mutex);
+	cpus_read_unlock();
+}
+
 static ssize_t wq_nice_show(struct device *dev, struct device_attribute *attr,
 			    char *buf)
 {
@@ -6158,6 +6121,43 @@ static struct bus_type wq_subsys = {
 	.dev_groups			= wq_sysfs_groups,
 };
 
+/**
+ *  workqueue_set_unbound_cpumask - Set the low-level unbound cpumask
+ *  @cpumask: the cpumask to set
+ *
+ *  The low-level workqueues cpumask is a global cpumask that limits
+ *  the affinity of all unbound workqueues.  This function check the @cpumask
+ *  and apply it to all unbound workqueues and updates all pwqs of them.
+ *
+ *  Return:	0	- Success
+ *		-EINVAL	- Invalid @cpumask
+ *		-ENOMEM	- Failed to allocate memory for attrs or pwqs.
+ */
+static int workqueue_set_unbound_cpumask(cpumask_var_t cpumask)
+{
+	int ret = -EINVAL;
+
+	/*
+	 * Not excluding isolated cpus on purpose.
+	 * If the user wishes to include them, we allow that.
+	 */
+	cpumask_and(cpumask, cpumask, cpu_possible_mask);
+	if (!cpumask_empty(cpumask)) {
+		apply_wqattrs_lock();
+		if (cpumask_equal(cpumask, wq_unbound_cpumask)) {
+			ret = 0;
+			goto out_unlock;
+		}
+
+		ret = workqueue_apply_unbound_cpumask(cpumask);
+
+out_unlock:
+		apply_wqattrs_unlock();
+	}
+
+	return ret;
+}
+
 static ssize_t wq_unbound_cpumask_show(struct device *dev,
 		struct device_attribute *attr, char *buf)
 {
-- 
2.39.3


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2F417E9259
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Nov 2023 20:46:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232327AbjKLTq2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Nov 2023 14:46:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232117AbjKLTqS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Nov 2023 14:46:18 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD570213A
        for <linux-kernel@vger.kernel.org>; Sun, 12 Nov 2023 11:46:14 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA98DC433CA;
        Sun, 12 Nov 2023 19:46:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699818374;
        bh=8h4xcSrlngKXz6YrUu+DyY/DYWtQeX+QuoziQCKM6Qo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MIh9ucCTepKRwsUBhaeQTqSbnm6Ezok1Z01it4NK1/7eOF+AvLvl6S3L6KK2DYzVH
         n7S/Ax4akpIniSkGmPWk5EotaJGJRKGD0wb4v2jqu4rBew/mk+/s3xUP1hbXrajNhl
         hKnWmdQ6ytt9PQA2R8X7/YeiL6Cf4w+xiRQDnt4+ZChxDQ1slQLhoHdNxXMPoOzQRH
         u/ooQB77RM6qCtHj/YNpr02MYV3BB+ChlSlFYUWRBUy/x0RPqP5okkEfKNS9VNVd6X
         8GqIg/MdrDblrjoPI2J08jhGzzseTnJqWhcufBWbXAqcpC7XrxmfPVHY/JRftmpWmP
         Rowj0FpL6fkQA==
From:   SeongJae Park <sj@kernel.org>
Cc:     SeongJae Park <sj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        damon@lists.linux.dev, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 2/8] mm/damon/sysfs-schemes: implement scheme quota goals directory
Date:   Sun, 12 Nov 2023 19:46:01 +0000
Message-Id: <20231112194607.61399-3-sj@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231112194607.61399-1-sj@kernel.org>
References: <20231112194607.61399-1-sj@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement DAMON sysfs directories and files for the goals of DAMOS
quota.  It allows users set multiple goals for their aim, with target
values.  It further allows users to enter the current score value as a
feedback for DAMOS.  Following commit will connect the user inputs to
DAMOS quota auto-tuning.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/sysfs-schemes.c | 224 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 221 insertions(+), 3 deletions(-)

diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
index be667236b8e6..d3b57348f07b 100644
--- a/mm/damon/sysfs-schemes.c
+++ b/mm/damon/sysfs-schemes.c
@@ -812,6 +812,203 @@ static const struct kobj_type damon_sysfs_watermarks_ktype = {
 	.default_groups = damon_sysfs_watermarks_groups,
 };
 
+/*
+ * quota goal directory
+ */
+
+struct damos_sysfs_quota_goal {
+	struct kobject kobj;
+	unsigned long target_value;
+	unsigned long current_value;
+};
+
+static struct damos_sysfs_quota_goal *damos_sysfs_quota_goal_alloc(void)
+{
+	return kzalloc(sizeof(struct damos_sysfs_quota_goal), GFP_KERNEL);
+}
+
+static ssize_t target_value_show(struct kobject *kobj,
+		struct kobj_attribute *attr, char *buf)
+{
+	struct damos_sysfs_quota_goal *goal = container_of(kobj, struct
+			damos_sysfs_quota_goal, kobj);
+
+	return sysfs_emit(buf, "%lu\n", goal->target_value);
+}
+
+static ssize_t target_value_store(struct kobject *kobj,
+		struct kobj_attribute *attr, const char *buf, size_t count)
+{
+	struct damos_sysfs_quota_goal *goal = container_of(kobj, struct
+			damos_sysfs_quota_goal, kobj);
+	int err = kstrtoul(buf, 0, &goal->target_value);
+
+	return err ? err : count;
+}
+
+static ssize_t current_value_show(struct kobject *kobj,
+		struct kobj_attribute *attr, char *buf)
+{
+	struct damos_sysfs_quota_goal *goal = container_of(kobj, struct
+			damos_sysfs_quota_goal, kobj);
+
+	return sysfs_emit(buf, "%lu\n", goal->current_value);
+}
+
+static ssize_t current_value_store(struct kobject *kobj,
+		struct kobj_attribute *attr, const char *buf, size_t count)
+{
+	struct damos_sysfs_quota_goal *goal = container_of(kobj, struct
+			damos_sysfs_quota_goal, kobj);
+	int err = kstrtoul(buf, 0, &goal->current_value);
+
+	/* feed callback should check existence of this file and read value */
+	return err ? err : count;
+}
+
+static void damos_sysfs_quota_goal_release(struct kobject *kobj)
+{
+	/* or, notify this release to the feed callback */
+	kfree(container_of(kobj, struct damos_sysfs_quota_goal, kobj));
+}
+
+static struct kobj_attribute damos_sysfs_quota_goal_target_value_attr =
+		__ATTR_RW_MODE(target_value, 0600);
+
+static struct kobj_attribute damos_sysfs_quota_goal_current_value_attr =
+		__ATTR_RW_MODE(current_value, 0600);
+
+static struct attribute *damos_sysfs_quota_goal_attrs[] = {
+	&damos_sysfs_quota_goal_target_value_attr.attr,
+	&damos_sysfs_quota_goal_current_value_attr.attr,
+	NULL,
+};
+ATTRIBUTE_GROUPS(damos_sysfs_quota_goal);
+
+static const struct kobj_type damos_sysfs_quota_goal_ktype = {
+	.release = damos_sysfs_quota_goal_release,
+	.sysfs_ops = &kobj_sysfs_ops,
+	.default_groups = damos_sysfs_quota_goal_groups,
+};
+
+/*
+ * quota goals directory
+ */
+
+struct damos_sysfs_quota_goals {
+	struct kobject kobj;
+	struct damos_sysfs_quota_goal **goals_arr;	/* counted by nr */
+	int nr;
+};
+
+static struct damos_sysfs_quota_goals *damos_sysfs_quota_goals_alloc(void)
+{
+	return kzalloc(sizeof(struct damos_sysfs_quota_goals), GFP_KERNEL);
+}
+
+static void damos_sysfs_quota_goals_rm_dirs(
+		struct damos_sysfs_quota_goals *goals)
+{
+	struct damos_sysfs_quota_goal **goals_arr = goals->goals_arr;
+	int i;
+
+	for (i = 0; i < goals->nr; i++)
+		kobject_put(&goals_arr[i]->kobj);
+	goals->nr = 0;
+	kfree(goals_arr);
+	goals->goals_arr = NULL;
+}
+
+static int damos_sysfs_quota_goals_add_dirs(
+		struct damos_sysfs_quota_goals *goals, int nr_goals)
+{
+	struct damos_sysfs_quota_goal **goals_arr, *goal;
+	int err, i;
+
+	damos_sysfs_quota_goals_rm_dirs(goals);
+	if (!nr_goals)
+		return 0;
+
+	goals_arr = kmalloc_array(nr_goals, sizeof(*goals_arr),
+			GFP_KERNEL | __GFP_NOWARN);
+	if (!goals_arr)
+		return -ENOMEM;
+	goals->goals_arr = goals_arr;
+
+	for (i = 0; i < nr_goals; i++) {
+		goal = damos_sysfs_quota_goal_alloc();
+		if (!goal) {
+			damos_sysfs_quota_goals_rm_dirs(goals);
+			return -ENOMEM;
+		}
+
+		err = kobject_init_and_add(&goal->kobj,
+				&damos_sysfs_quota_goal_ktype, &goals->kobj,
+				"%d", i);
+		if (err) {
+			kobject_put(&goal->kobj);
+			damos_sysfs_quota_goals_rm_dirs(goals);
+			return err;
+		}
+
+		goals_arr[i] = goal;
+		goals->nr++;
+	}
+	return 0;
+}
+
+static ssize_t nr_goals_show(struct kobject *kobj,
+		struct kobj_attribute *attr, char *buf)
+{
+	struct damos_sysfs_quota_goals *goals = container_of(kobj,
+			struct damos_sysfs_quota_goals, kobj);
+
+	return sysfs_emit(buf, "%d\n", goals->nr);
+}
+
+static ssize_t nr_goals_store(struct kobject *kobj,
+		struct kobj_attribute *attr, const char *buf, size_t count)
+{
+	struct damos_sysfs_quota_goals *goals;
+	int nr, err = kstrtoint(buf, 0, &nr);
+
+	if (err)
+		return err;
+	if (nr < 0)
+		return -EINVAL;
+
+	goals = container_of(kobj, struct damos_sysfs_quota_goals, kobj);
+
+	if (!mutex_trylock(&damon_sysfs_lock))
+		return -EBUSY;
+	err = damos_sysfs_quota_goals_add_dirs(goals, nr);
+	mutex_unlock(&damon_sysfs_lock);
+	if (err)
+		return err;
+
+	return count;
+}
+
+static void damos_sysfs_quota_goals_release(struct kobject *kobj)
+{
+	kfree(container_of(kobj, struct damos_sysfs_quota_goals, kobj));
+}
+
+static struct kobj_attribute damos_sysfs_quota_goals_nr_attr =
+		__ATTR_RW_MODE(nr_goals, 0600);
+
+static struct attribute *damos_sysfs_quota_goals_attrs[] = {
+	&damos_sysfs_quota_goals_nr_attr.attr,
+	NULL,
+};
+ATTRIBUTE_GROUPS(damos_sysfs_quota_goals);
+
+static const struct kobj_type damos_sysfs_quota_goals_ktype = {
+	.release = damos_sysfs_quota_goals_release,
+	.sysfs_ops = &kobj_sysfs_ops,
+	.default_groups = damos_sysfs_quota_goals_groups,
+};
+
 /*
  * scheme/weights directory
  */
@@ -930,6 +1127,7 @@ static const struct kobj_type damon_sysfs_weights_ktype = {
 struct damon_sysfs_quotas {
 	struct kobject kobj;
 	struct damon_sysfs_weights *weights;
+	struct damos_sysfs_quota_goals *goals;
 	unsigned long ms;
 	unsigned long sz;
 	unsigned long reset_interval_ms;
@@ -943,6 +1141,7 @@ static struct damon_sysfs_quotas *damon_sysfs_quotas_alloc(void)
 static int damon_sysfs_quotas_add_dirs(struct damon_sysfs_quotas *quotas)
 {
 	struct damon_sysfs_weights *weights;
+	struct damos_sysfs_quota_goals *goals;
 	int err;
 
 	weights = damon_sysfs_weights_alloc(0, 0, 0);
@@ -951,16 +1150,35 @@ static int damon_sysfs_quotas_add_dirs(struct damon_sysfs_quotas *quotas)
 
 	err = kobject_init_and_add(&weights->kobj, &damon_sysfs_weights_ktype,
 			&quotas->kobj, "weights");
-	if (err)
+	if (err) {
 		kobject_put(&weights->kobj);
-	else
-		quotas->weights = weights;
+		return err;
+	}
+	quotas->weights = weights;
+
+	goals = damos_sysfs_quota_goals_alloc();
+	if (!goals) {
+		kobject_put(&weights->kobj);
+		return -ENOMEM;
+	}
+	err = kobject_init_and_add(&goals->kobj,
+			&damos_sysfs_quota_goals_ktype, &quotas->kobj,
+			"goals");
+	if (err) {
+		kobject_put(&weights->kobj);
+		kobject_put(&goals->kobj);
+	} else {
+		quotas->goals = goals;
+	}
+
 	return err;
 }
 
 static void damon_sysfs_quotas_rm_dirs(struct damon_sysfs_quotas *quotas)
 {
 	kobject_put(&quotas->weights->kobj);
+	damos_sysfs_quota_goals_rm_dirs(quotas->goals);
+	kobject_put(&quotas->goals->kobj);
 }
 
 static ssize_t ms_show(struct kobject *kobj, struct kobj_attribute *attr,
-- 
2.34.1


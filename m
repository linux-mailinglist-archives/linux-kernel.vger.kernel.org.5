Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE9F37FE706
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 03:38:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344328AbjK3CiX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 21:38:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234995AbjK3CiC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 21:38:02 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0F4119A1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 18:37:01 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BD35C433CD;
        Thu, 30 Nov 2023 02:37:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701311820;
        bh=Zui/g7KxP982XBB/gWdJuIQ1teaLDQkwAJtBsHfxVTg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lRgRzxNDNbm7lr2q7Y53CCXTaCb86uIcOob1lUwGtAF+twP1nzW6iYAepQ1c4Onj9
         IS893QvCkslgxKA29cJnnoDFseUyk6dq8zTOFttcFjff9ootD9pK5R6Yl4pNUluDTK
         T2EpO72ELMrqrEgXJHAuaN5peRey2z3VXHOOhl6LNi0XqzV9RcQ5SHjxcopPexngIB
         KTHq1eQ9BuXqK7CqmbuDzYmPW97jbwMhc0hoQiHkEVwL5OxIaHKBsaKv8vb2qQh+yx
         xIoLY5MyFIkGdP8MEgLBpHIfYlTV8Py37fUUhPnX0ahYWFLEgVYsKmxTjn13jga9Td
         IfYb2F89T94gA==
From:   SeongJae Park <sj@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     SeongJae Park <sj@kernel.org>, damon@lists.linux.dev,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/9] mm/damon/sysfs-schemes: implement files for scheme quota goals setup
Date:   Thu, 30 Nov 2023 02:36:45 +0000
Message-Id: <20231130023652.50284-3-sj@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231130023652.50284-1-sj@kernel.org>
References: <20231130023652.50284-1-sj@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement DAMON sysfs directories and files for the goals of DAMOS
quota.  Those allow users set multiple goals for their aim, with target
values.  Users can further enter the current score value for each goal
as feedback for DAMOS.

Note that this commit is implementing only the basic file operations,
and not connecting the files with the DAMOS core logic.  Hence writing
something to the files makes no real effect.  The following commit will
connect the file operations and the core logic.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/sysfs-schemes.c | 224 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 221 insertions(+), 3 deletions(-)

diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
index fe0fe2562000..e5531dbd4cf1 100644
--- a/mm/damon/sysfs-schemes.c
+++ b/mm/damon/sysfs-schemes.c
@@ -820,6 +820,203 @@ static const struct kobj_type damon_sysfs_watermarks_ktype = {
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
@@ -938,6 +1135,7 @@ static const struct kobj_type damon_sysfs_weights_ktype = {
 struct damon_sysfs_quotas {
 	struct kobject kobj;
 	struct damon_sysfs_weights *weights;
+	struct damos_sysfs_quota_goals *goals;
 	unsigned long ms;
 	unsigned long sz;
 	unsigned long reset_interval_ms;
@@ -951,6 +1149,7 @@ static struct damon_sysfs_quotas *damon_sysfs_quotas_alloc(void)
 static int damon_sysfs_quotas_add_dirs(struct damon_sysfs_quotas *quotas)
 {
 	struct damon_sysfs_weights *weights;
+	struct damos_sysfs_quota_goals *goals;
 	int err;
 
 	weights = damon_sysfs_weights_alloc(0, 0, 0);
@@ -959,16 +1158,35 @@ static int damon_sysfs_quotas_add_dirs(struct damon_sysfs_quotas *quotas)
 
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


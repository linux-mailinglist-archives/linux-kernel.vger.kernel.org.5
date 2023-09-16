Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A83B07A2D55
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Sep 2023 04:10:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238421AbjIPCKZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 22:10:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237683AbjIPCKL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 22:10:11 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84BC9173C
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 19:10:06 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8E34C433CB;
        Sat, 16 Sep 2023 02:10:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694830206;
        bh=CxNdbzA0gxD0qFOAF+9FaJdfdv1eofTN2A5LeDdD5oY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XUb0Za8b5NIRMAAJKo0tr9S53C++iGSYlP/jV4+2zMzBqfI5andQM3B8DKRE56GBE
         JYVNEg6j5tUbTrcXRo4I1lkPLG42yvwG5xUWCn3ezU4XMMbz2mOMwtn8B6BlIZq/d4
         ICfyBmkefS09qC8by3z7VGo0i/vBV1m92PDvsbYYIwkdYLNmCZt/tpLHa+pEUw1vte
         RUoB1p1dMYcv5w1MNew42XFfsi5Wj+8P1zNARMuVwKQcUxazpj71sjgncklfPPnxin
         hiFnZpeP0MrQ5VCdcqcs8Hz8fv0mc7IYZ0/BWUsmqotVbhAEPBu1U+6oDF5nxeh2GC
         5OM5b/TUAD5og==
From:   SeongJae Park <sj@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     SeongJae Park <sj@kernel.org>, damon@lists.linux.dev,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH 6/9] mm/damon/sysfs-schemes: support DAMOS apply interval
Date:   Sat, 16 Sep 2023 02:09:42 +0000
Message-Id: <20230916020945.47296-7-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230916020945.47296-1-sj@kernel.org>
References: <20230916020945.47296-1-sj@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update DAMON sysfs interface to support DAMOS apply intervals by adding
a new file, 'apply_interval_us' in each scheme directory.  Users can set
and get the interval for each scheme in microseconds by writing to and
reading from the file.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/sysfs-schemes.c | 38 ++++++++++++++++++++++++++++++++++----
 1 file changed, 34 insertions(+), 4 deletions(-)

diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
index 3d30e85596b0..a7d70b95c4dd 100644
--- a/mm/damon/sysfs-schemes.c
+++ b/mm/damon/sysfs-schemes.c
@@ -1121,6 +1121,7 @@ struct damon_sysfs_scheme {
 	struct kobject kobj;
 	enum damos_action action;
 	struct damon_sysfs_access_pattern *access_pattern;
+	unsigned long apply_interval_us;
 	struct damon_sysfs_quotas *quotas;
 	struct damon_sysfs_watermarks *watermarks;
 	struct damon_sysfs_scheme_filters *filters;
@@ -1141,7 +1142,7 @@ static const char * const damon_sysfs_damos_action_strs[] = {
 };
 
 static struct damon_sysfs_scheme *damon_sysfs_scheme_alloc(
-		enum damos_action action)
+		enum damos_action action, unsigned long apply_interval_us)
 {
 	struct damon_sysfs_scheme *scheme = kmalloc(sizeof(*scheme),
 				GFP_KERNEL);
@@ -1150,6 +1151,7 @@ static struct damon_sysfs_scheme *damon_sysfs_scheme_alloc(
 		return NULL;
 	scheme->kobj = (struct kobject){};
 	scheme->action = action;
+	scheme->apply_interval_us = apply_interval_us;
 	return scheme;
 }
 
@@ -1353,6 +1355,25 @@ static ssize_t action_store(struct kobject *kobj, struct kobj_attribute *attr,
 	return -EINVAL;
 }
 
+static ssize_t apply_interval_us_show(struct kobject *kobj,
+		struct kobj_attribute *attr, char *buf)
+{
+	struct damon_sysfs_scheme *scheme = container_of(kobj,
+			struct damon_sysfs_scheme, kobj);
+
+	return sysfs_emit(buf, "%lu\n", scheme->apply_interval_us);
+}
+
+static ssize_t apply_interval_us_store(struct kobject *kobj,
+		struct kobj_attribute *attr, const char *buf, size_t count)
+{
+	struct damon_sysfs_scheme *scheme = container_of(kobj,
+			struct damon_sysfs_scheme, kobj);
+	int err = kstrtoul(buf, 0, &scheme->apply_interval_us);
+
+	return err ? err : count;
+}
+
 static void damon_sysfs_scheme_release(struct kobject *kobj)
 {
 	kfree(container_of(kobj, struct damon_sysfs_scheme, kobj));
@@ -1361,8 +1382,12 @@ static void damon_sysfs_scheme_release(struct kobject *kobj)
 static struct kobj_attribute damon_sysfs_scheme_action_attr =
 		__ATTR_RW_MODE(action, 0600);
 
+static struct kobj_attribute damon_sysfs_scheme_apply_interval_us_attr =
+		__ATTR_RW_MODE(apply_interval_us, 0600);
+
 static struct attribute *damon_sysfs_scheme_attrs[] = {
 	&damon_sysfs_scheme_action_attr.attr,
+	&damon_sysfs_scheme_apply_interval_us_attr.attr,
 	NULL,
 };
 ATTRIBUTE_GROUPS(damon_sysfs_scheme);
@@ -1413,7 +1438,11 @@ static int damon_sysfs_schemes_add_dirs(struct damon_sysfs_schemes *schemes,
 	schemes->schemes_arr = schemes_arr;
 
 	for (i = 0; i < nr_schemes; i++) {
-		scheme = damon_sysfs_scheme_alloc(DAMOS_STAT);
+		/*
+		 * apply_interval_us as 0 means same to aggregation interval
+		 * (same to before-apply_interval behavior)
+		 */
+		scheme = damon_sysfs_scheme_alloc(DAMOS_STAT, 0);
 		if (!scheme) {
 			damon_sysfs_schemes_rm_dirs(schemes);
 			return -ENOMEM;
@@ -1610,8 +1639,8 @@ static struct damos *damon_sysfs_mk_scheme(
 		.low = sysfs_wmarks->low,
 	};
 
-	scheme = damon_new_scheme(&pattern, sysfs_scheme->action, 0, &quota,
-			&wmarks);
+	scheme = damon_new_scheme(&pattern, sysfs_scheme->action,
+			sysfs_scheme->apply_interval_us, &quota, &wmarks);
 	if (!scheme)
 		return NULL;
 
@@ -1641,6 +1670,7 @@ static void damon_sysfs_update_scheme(struct damos *scheme,
 	scheme->pattern.max_age_region = access_pattern->age->max;
 
 	scheme->action = sysfs_scheme->action;
+	scheme->apply_interval_us = sysfs_scheme->apply_interval_us;
 
 	scheme->quota.ms = sysfs_quotas->ms;
 	scheme->quota.sz = sysfs_quotas->sz;
-- 
2.25.1


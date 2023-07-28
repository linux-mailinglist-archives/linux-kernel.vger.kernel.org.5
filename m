Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77C7776770B
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 22:35:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235004AbjG1UfJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 16:35:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232941AbjG1Uey (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 16:34:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFC5344A0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 13:34:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5E07062209
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 20:34:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DF4BC433CA;
        Fri, 28 Jul 2023 20:34:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690576489;
        bh=JP7uB7/G+cUBWmCMFTcCRqLSa2LcbVSrJBh+8gJznBY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qEqsPnDTJzgFVqfu9V8EzsZlJlOVBtwCUd28gFsY/AzjTQsZhZQksDgaSHRkRvXm6
         l3JmnJRVO+FpqhUHnEBOWdcaXQfMAG9/39tTQYzHzN1prb1O/bPdPv1kPt8Auwz/5D
         jjYGnpBfoMfmgM4oSg5UDHunwAmxiVSwcyEzQTP/oXG5pTb73/hEKtZ0XgBxx2q6s8
         ZyGQTXlE3Ps1FA+5JnDoErKrZO8u8BKTzajZt0R1+WIrtbuOJHsuLZx/b3rVLGIgME
         FZMqUi57nVG89VRujJdxFHqvDZ1vymbdZLhk8ZLlSPzkG/ZxwgmTLxXbJBw5HTGc2e
         zSvAEuArFDBfA==
From:   SeongJae Park <sj@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     SeongJae Park <sj@kernel.org>, damon@lists.linux.dev,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 02/13] mm/damon/sysfs-schemes: support address range type DAMOS filter
Date:   Fri, 28 Jul 2023 20:34:33 +0000
Message-Id: <20230728203444.70703-3-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230728203444.70703-1-sj@kernel.org>
References: <20230728203444.70703-1-sj@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Extend DAMON sysfs interface to support address range based DAMOS
filters, by adding a special keyword for the filter/<N>/type file,
namely 'addr', and two files under filter/<N>/ for specifying the start
and the end addresses of the range, namely 'addr_start' and 'addr_end'.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/sysfs-schemes.c | 56 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
index 9a015079f3a4..03ddba3e216d 100644
--- a/mm/damon/sysfs-schemes.c
+++ b/mm/damon/sysfs-schemes.c
@@ -282,6 +282,7 @@ struct damon_sysfs_scheme_filter {
 	enum damos_filter_type type;
 	bool matching;
 	char *memcg_path;
+	struct damon_addr_range addr_range;
 };
 
 static struct damon_sysfs_scheme_filter *damon_sysfs_scheme_filter_alloc(void)
@@ -293,6 +294,7 @@ static struct damon_sysfs_scheme_filter *damon_sysfs_scheme_filter_alloc(void)
 static const char * const damon_sysfs_scheme_filter_type_strs[] = {
 	"anon",
 	"memcg",
+	"addr",
 };
 
 static ssize_t type_show(struct kobject *kobj,
@@ -373,6 +375,44 @@ static ssize_t memcg_path_store(struct kobject *kobj,
 	return count;
 }
 
+static ssize_t addr_start_show(struct kobject *kobj,
+		struct kobj_attribute *attr, char *buf)
+{
+	struct damon_sysfs_scheme_filter *filter = container_of(kobj,
+			struct damon_sysfs_scheme_filter, kobj);
+
+	return sysfs_emit(buf, "%lu\n", filter->addr_range.start);
+}
+
+static ssize_t addr_start_store(struct kobject *kobj,
+		struct kobj_attribute *attr, const char *buf, size_t count)
+{
+	struct damon_sysfs_scheme_filter *filter = container_of(kobj,
+			struct damon_sysfs_scheme_filter, kobj);
+	int err = kstrtoul(buf, 0, &filter->addr_range.start);
+
+	return err ? err : count;
+}
+
+static ssize_t addr_end_show(struct kobject *kobj,
+		struct kobj_attribute *attr, char *buf)
+{
+	struct damon_sysfs_scheme_filter *filter = container_of(kobj,
+			struct damon_sysfs_scheme_filter, kobj);
+
+	return sysfs_emit(buf, "%lu\n", filter->addr_range.end);
+}
+
+static ssize_t addr_end_store(struct kobject *kobj,
+		struct kobj_attribute *attr, const char *buf, size_t count)
+{
+	struct damon_sysfs_scheme_filter *filter = container_of(kobj,
+			struct damon_sysfs_scheme_filter, kobj);
+	int err = kstrtoul(buf, 0, &filter->addr_range.end);
+
+	return err ? err : count;
+}
+
 static void damon_sysfs_scheme_filter_release(struct kobject *kobj)
 {
 	struct damon_sysfs_scheme_filter *filter = container_of(kobj,
@@ -391,10 +431,18 @@ static struct kobj_attribute damon_sysfs_scheme_filter_matching_attr =
 static struct kobj_attribute damon_sysfs_scheme_filter_memcg_path_attr =
 		__ATTR_RW_MODE(memcg_path, 0600);
 
+static struct kobj_attribute damon_sysfs_scheme_filter_addr_start_attr =
+		__ATTR_RW_MODE(addr_start, 0600);
+
+static struct kobj_attribute damon_sysfs_scheme_filter_addr_end_attr =
+		__ATTR_RW_MODE(addr_end, 0600);
+
 static struct attribute *damon_sysfs_scheme_filter_attrs[] = {
 	&damon_sysfs_scheme_filter_type_attr.attr,
 	&damon_sysfs_scheme_filter_matching_attr.attr,
 	&damon_sysfs_scheme_filter_memcg_path_attr.attr,
+	&damon_sysfs_scheme_filter_addr_start_attr.attr,
+	&damon_sysfs_scheme_filter_addr_end_attr.attr,
 	NULL,
 };
 ATTRIBUTE_GROUPS(damon_sysfs_scheme_filter);
@@ -1484,7 +1532,15 @@ static int damon_sysfs_set_scheme_filters(struct damos *scheme,
 				damos_destroy_filter(filter);
 				return err;
 			}
+		} else if (filter->type == DAMOS_FILTER_TYPE_ADDR) {
+			if (sysfs_filter->addr_range.end <
+					sysfs_filter->addr_range.start) {
+				damos_destroy_filter(filter);
+				return -EINVAL;
+			}
+			filter->addr_range = sysfs_filter->addr_range;
 		}
+
 		damos_add_filter(scheme, filter);
 	}
 	return 0;
-- 
2.25.1


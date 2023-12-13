Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78B2D80F722
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 20:48:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377296AbjLLTsV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 14:48:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377282AbjLLTsT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 14:48:19 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C37E6A6
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 11:48:25 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9C69C433C8;
        Tue, 12 Dec 2023 19:48:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702410505;
        bh=DR2Fa3ovjeZyoem+oDl1suN899iJhJUC8UTSzsABCII=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HA5XbunGmbXfx0Q2PBWZIxDGcBV5Dgvd4kTY6CbduAGZC+9muRTppO4PFe28T/5i+
         CmRI1fkjAnKa1Nco2U18Ye7denvai3M3JgEXMpTQ3nSRWFQ2mPdOSy6zaHt41Skbdc
         4BYfTX6VlFveLW+mcLa0DSfgORdTEKPz/j8cu8i5YSkiTKb0pcvSHH4Vkljr7mXNZi
         OKDjuTBDwVxNJBELhM4NX8g+i9EnR9Zv8JYdqUkmasictn2ECU353ZPspXk14NWbju
         3lSWV3+4BKRlFdFjrSUVWG9gELYl9bKdP/KfdlLYVS6k1lVFspUt8MPDSgcv8aPZPC
         1mpjLFnRNMFOA==
From:   SeongJae Park <sj@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     SeongJae Park <sj@kernel.org>, Shuah Khan <shuah@kernel.org>,
        damon@lists.linux.dev, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/5] selftests/damon/_damon_sysfs: implement kdamonds start function
Date:   Tue, 12 Dec 2023 19:48:07 +0000
Message-Id: <20231212194810.54457-3-sj@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231212194810.54457-1-sj@kernel.org>
References: <20231212194810.54457-1-sj@kernel.org>
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

Extend the tests-writing-purpose DAMON sysfs control module to support
the kdamonds start functionality.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 tools/testing/selftests/damon/_damon_sysfs.py | 206 ++++++++++++++++++
 1 file changed, 206 insertions(+)

diff --git a/tools/testing/selftests/damon/_damon_sysfs.py b/tools/testing/selftests/damon/_damon_sysfs.py
index 78101846ab66..6b99f87a5f1e 100644
--- a/tools/testing/selftests/damon/_damon_sysfs.py
+++ b/tools/testing/selftests/damon/_damon_sysfs.py
@@ -1,5 +1,28 @@
 # SPDX-License-Identifier: GPL-2.0
 
+import os
+
+sysfs_root = '/sys/kernel/mm/damon/admin'
+
+def write_file(path, string):
+    "Returns error string if failed, or None otherwise"
+    string = '%s' % string
+    try:
+        with open(path, 'w') as f:
+            f.write(string)
+    except Exception as e:
+        return '%s' % e
+    return None
+
+def read_file(path):
+    '''Returns the read content and error string.  The read content is None if
+    the reading failed'''
+    try:
+        with open(path, 'r') as f:
+            return f.read(), None
+    except Exception as e:
+        return None, '%s' % e
+
 class DamosAccessPattern:
     size = None
     nr_accesses = None
@@ -18,6 +41,35 @@ class DamosAccessPattern:
         if self.age == None:
             self.age = [0, 2**64 - 1]
 
+    def sysfs_dir(self):
+        return os.path.join(self.scheme.sysfs_dir(), 'access_pattern')
+
+    def stage(self):
+        err = write_file(
+                os.path.join(self.sysfs_dir(), 'sz', 'min'), self.size[0])
+        if err != None:
+            return err
+        err = write_file(
+                os.path.join(self.sysfs_dir(), 'sz', 'max'), self.size[1])
+        if err != None:
+            return err
+        err = write_file(os.path.join(self.sysfs_dir(), 'nr_accesses', 'min'),
+                self.nr_accesses[0])
+        if err != None:
+            return err
+        err = write_file(os.path.join(self.sysfs_dir(), 'nr_accesses', 'max'),
+                self.nr_accesses[1])
+        if err != None:
+            return err
+        err = write_file(
+                os.path.join(self.sysfs_dir(), 'age', 'min'), self.age[0])
+        if err != None:
+            return err
+        err = write_file(
+                os.path.join(self.sysfs_dir(), 'age', 'max'), self.age[1])
+        if err != None:
+            return err
+
 class Damos:
     action = None
     access_pattern = None
@@ -30,6 +82,39 @@ class Damos:
         self.access_pattern = access_pattern
         self.access_pattern.scheme = self
 
+    def sysfs_dir(self):
+        return os.path.join(
+                self.context.sysfs_dir(), 'schemes', '%d' % self.idx)
+
+    def stage(self):
+        err = write_file(os.path.join(self.sysfs_dir(), 'action'), self.action)
+        if err != None:
+            return err
+        err = self.access_pattern.stage()
+        if err != None:
+            return err
+
+        # disable quotas
+        err = write_file(os.path.join(self.sysfs_dir(), 'quotas', 'ms'), '0')
+        if err != None:
+            return err
+        err = write_file(
+                os.path.join(self.sysfs_dir(), 'quotas', 'bytes'), '0')
+        if err != None:
+            return err
+
+        # disable watermarks
+        err = write_file(
+                os.path.join(self.sysfs_dir(), 'watermarks', 'metric'), 'none')
+        if err != None:
+            return err
+
+        # disable filters
+        err = write_file(
+                os.path.join(self.sysfs_dir(), 'filters', 'nr_filters'), '0')
+        if err != None:
+            return err
+
 class DamonTarget:
     pid = None
     # todo: Support target regions if test is made
@@ -39,6 +124,18 @@ class DamonTarget:
     def __init__(self, pid):
         self.pid = pid
 
+    def sysfs_dir(self):
+        return os.path.join(
+                self.context.sysfs_dir(), 'targets', '%d' % self.idx)
+
+    def stage(self):
+        err = write_file(
+                os.path.join(self.sysfs_dir(), 'regions', 'nr_regions'), '0')
+        if err != None:
+            return err
+        return write_file(
+                os.path.join(self.sysfs_dir(), 'pid_target'), self.pid)
+
 class DamonAttrs:
     sample_us = None
     aggr_us = None
@@ -55,6 +152,40 @@ class DamonAttrs:
         self.min_nr_regions = min_nr_regions
         self.max_nr_regions = max_nr_regions
 
+    def interval_sysfs_dir(self):
+        return os.path.join(self.context.sysfs_dir(), 'monitoring_attrs',
+                'intervals')
+
+    def nr_regions_range_sysfs_dir(self):
+        return os.path.join(self.context.sysfs_dir(), 'monitoring_attrs',
+                'nr_regions')
+
+    def stage(self):
+        err = write_file(os.path.join(self.interval_sysfs_dir(), 'sample_us'),
+                self.sample_us)
+        if err != None:
+            return err
+        err = write_file(os.path.join(self.interval_sysfs_dir(), 'aggr_us'),
+                self.aggr_us)
+        if err != None:
+            return err
+        err = write_file(os.path.join(self.interval_sysfs_dir(), 'update_us'),
+                self.update_us)
+        if err != None:
+            return err
+
+        err = write_file(
+                os.path.join(self.nr_regions_range_sysfs_dir(), 'min'),
+                self.min_nr_regions)
+        if err != None:
+            return err
+
+        err = write_file(
+                os.path.join(self.nr_regions_range_sysfs_dir(), 'max'),
+                self.max_nr_regions)
+        if err != None:
+            return err
+
 class DamonCtx:
     ops = None
     monitoring_attrs = None
@@ -79,6 +210,46 @@ class DamonCtx:
             scheme.idx = idx
             scheme.context = self
 
+    def sysfs_dir(self):
+        return os.path.join(self.kdamond.sysfs_dir(), 'contexts',
+                '%d' % self.idx)
+
+    def stage(self):
+        err = write_file(
+                os.path.join(self.sysfs_dir(), 'operations'), self.ops)
+        if err != None:
+            return err
+        err = self.monitoring_attrs.stage()
+        if err != None:
+            return err
+
+        nr_targets_file = os.path.join(
+                self.sysfs_dir(), 'targets', 'nr_targets')
+        content, err = read_file(nr_targets_file)
+        if err != None:
+            return err
+        if int(content) != len(self.targets):
+            err = write_file(nr_targets_file, '%d' % len(self.targets))
+            if err != None:
+                return err
+        for target in self.targets:
+            err = target.stage()
+            if err != None:
+                return err
+
+        nr_schemes_file = os.path.join(
+                self.sysfs_dir(), 'schemes', 'nr_schemes')
+        content, err = read_file(nr_schemes_file)
+        if int(content) != len(self.schemes):
+            err = write_file(nr_schemes_file, '%d' % len(self.schemes))
+            if err != None:
+                return err
+        for scheme in self.schemes:
+            err = scheme.stage()
+            if err != None:
+                return err
+        return None
+
 class Kdamond:
     state = None
     pid = None
@@ -92,6 +263,27 @@ class Kdamond:
             context.idx = idx
             context.kdamond = self
 
+    def sysfs_dir(self):
+        return os.path.join(self.kdamonds.sysfs_dir(), '%d' % self.idx)
+
+    def start(self):
+        nr_contexts_file = os.path.join(self.sysfs_dir(),
+                'contexts', 'nr_contexts')
+        content, err = read_file(nr_contexts_file)
+        if err != None:
+            return err
+        if int(content) != len(self.contexts):
+            err = write_file(nr_contexts_file, '%d' % len(self.contexts))
+            if err != None:
+                return err
+
+        for context in self.contexts:
+            err = context.stage()
+            if err != None:
+                return err
+        err = write_file(os.path.join(self.sysfs_dir(), 'state'), 'on')
+        return err
+
 class Kdamonds:
     kdamonds = []
 
@@ -100,3 +292,17 @@ class Kdamonds:
         for idx, kdamond in enumerate(self.kdamonds):
             kdamond.idx = idx
             kdamond.kdamonds = self
+
+    def sysfs_dir(self):
+        return os.path.join(sysfs_root, 'kdamonds')
+
+    def start(self):
+        err = write_file(os.path.join(self.sysfs_dir(),  'nr_kdamonds'),
+                '%s' % len(self.kdamonds))
+        if err != None:
+            return err
+        for kdamond in self.kdamonds:
+            err = kdamond.start()
+            if err != None:
+                return err
+        return None
-- 
2.34.1


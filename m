Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CE1080F635
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 20:12:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377098AbjLLTML (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 14:12:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235132AbjLLTMH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 14:12:07 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 899ABAF
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 11:12:13 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A235CC433C7;
        Tue, 12 Dec 2023 19:12:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702408333;
        bh=GHi4Mu0bQn8zyIS9XnsaUAW8ixexoLEYfp8Ut/tF7Co=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=igSIjbckp2hVl7FoDQk0XpOqN8qpCWR+x4WM0LuOXFbwy7VEp+1mpdVGEp8BgivFk
         YWuKoyLk6+L92fw8DO6z/SjD/Age3Nw8aFN3sUTuRzQgQjSwqpMMH4MFQTfv9gsTfK
         0yQ9XH+/wMbWvMMsVUweD+5+gttAd05TAPRCtqgaWwxz119gLLW0XT1drB4JssYga9
         hUo9zJVevAPH1Y6xLxnsPPmQ6jbZ4y880MruyyjZJ+eCpF19hzXMTF25lBB45kswHv
         hg9DjEcyWnOzOwBRp0kdHamLzLcQIb5sDCdxJcPFu+s41K1wSzza5v7T1AmYPl9he3
         9OpPFk5S2jV4A==
From:   SeongJae Park <sj@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     SeongJae Park <sj@kernel.org>, Shuah Khan <shuah@kernel.org>,
        damon@lists.linux.dev, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/5] selftests/damon: implement a python module for test-purpose DAMON sysfs controls
Date:   Tue, 12 Dec 2023 19:12:02 +0000
Message-Id: <20231212191206.52917-2-sj@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231212191206.52917-1-sj@kernel.org>
References: <20231212191206.52917-1-sj@kernel.org>
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

Implement a python module for DAMON sysfs controls.  The module is aimed
to be useful for writing DAMON functionality tests in future.
Nonetheless, this module is only representing a subset of DAMON sysfs
files.  Following commits will implement more DAMON sysfs controls.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 tools/testing/selftests/damon/_damon_sysfs.py | 102 ++++++++++++++++++
 1 file changed, 102 insertions(+)
 create mode 100644 tools/testing/selftests/damon/_damon_sysfs.py

diff --git a/tools/testing/selftests/damon/_damon_sysfs.py b/tools/testing/selftests/damon/_damon_sysfs.py
new file mode 100644
index 000000000000..78101846ab66
--- /dev/null
+++ b/tools/testing/selftests/damon/_damon_sysfs.py
@@ -0,0 +1,102 @@
+# SPDX-License-Identifier: GPL-2.0
+
+class DamosAccessPattern:
+    size = None
+    nr_accesses = None
+    age = None
+    scheme = None
+
+    def __init__(self, size=None, nr_accesses=None, age=None):
+        self.size = size
+        self.nr_accesses = nr_accesses
+        self.age = age
+
+        if self.size == None:
+            self.size = [0, 2**64 - 1]
+        if self.nr_accesses == None:
+            self.nr_accesses = [0, 2**64 - 1]
+        if self.age == None:
+            self.age = [0, 2**64 - 1]
+
+class Damos:
+    action = None
+    access_pattern = None
+    # todo: Support quotas, watermarks, stats, tried_regions
+    idx = None
+    context = None
+
+    def __init__(self, action='stat', access_pattern=DamosAccessPattern()):
+        self.action = action
+        self.access_pattern = access_pattern
+        self.access_pattern.scheme = self
+
+class DamonTarget:
+    pid = None
+    # todo: Support target regions if test is made
+    idx = None
+    context = None
+
+    def __init__(self, pid):
+        self.pid = pid
+
+class DamonAttrs:
+    sample_us = None
+    aggr_us = None
+    update_us = None
+    min_nr_regions = None
+    max_nr_regions = None
+    context = None
+
+    def __init__(self, sample_us=5000, aggr_us=100000, update_us=1000000,
+            min_nr_regions=10, max_nr_regions=1000):
+        self.sample_us = sample_us
+        self.aggr_us = aggr_us
+        self.update_us = update_us
+        self.min_nr_regions = min_nr_regions
+        self.max_nr_regions = max_nr_regions
+
+class DamonCtx:
+    ops = None
+    monitoring_attrs = None
+    targets = None
+    schemes = None
+    kdamond = None
+    idx = None
+
+    def __init__(self, ops='paddr', monitoring_attrs=DamonAttrs(), targets=[],
+            schemes=[]):
+        self.ops = ops
+        self.monitoring_attrs = monitoring_attrs
+        self.monitoring_attrs.context = self
+
+        self.targets = targets
+        for idx, target in enumerate(self.targets):
+            target.idx = idx
+            target.context = self
+
+        self.schemes = schemes
+        for idx, scheme in enumerate(self.schemes):
+            scheme.idx = idx
+            scheme.context = self
+
+class Kdamond:
+    state = None
+    pid = None
+    contexts = None
+    idx = None      # index of this kdamond between siblings
+    kdamonds = None # parent
+
+    def __init__(self, contexts=[]):
+        self.contexts = contexts
+        for idx, context in enumerate(self.contexts):
+            context.idx = idx
+            context.kdamond = self
+
+class Kdamonds:
+    kdamonds = []
+
+    def __init__(self, kdamonds=[]):
+        self.kdamonds = kdamonds
+        for idx, kdamond in enumerate(self.kdamonds):
+            kdamond.idx = idx
+            kdamond.kdamonds = self
-- 
2.34.1


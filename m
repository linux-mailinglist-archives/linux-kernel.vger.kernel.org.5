Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 359178018BA
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Dec 2023 01:10:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441977AbjLBAKV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 19:10:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235375AbjLBAKE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 19:10:04 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C0F41FC1
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 16:09:07 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C2B1C433C8;
        Sat,  2 Dec 2023 00:08:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701475690;
        bh=GC7hLao6eamt5j9k8hcen8vPzgOkrgeme7Xf5lpgbH0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ftiBRtoD5yl3wEraHqbN9wNqd+G6GNBLIgbbxpKOrAHe8oFCL7SBEpqsjBQ3FBZjl
         kJ0M6ueGJRGdyNixjGCs/yCwrSiN7nBkW5cf+rEdlaQjsoqvMrJtS6mUTqdMYIUrWG
         duoCJbg0mJe1uhfD2luVEvn0EEQBvfItemXsQ8n24Xxtl1H/RsVHr3Kj0QU4Wz+mUM
         9zSYm9L2V6rsZyDO5M2QQmhJldTJuxZGroKBuSpCk5DHoBxirlz8Csr0eOaiPeLFmM
         MHlCMPu6dHhXS7RgkofjSyJaxpu2deByYIQbzJC6XJolAfJ8xa8JM9pIzZOPL0nDHA
         LsMkoitTUar3g==
From:   SeongJae Park <sj@kernel.org>
Cc:     SeongJae Park <sj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, damon@lists.linux.dev,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 1/5] selftests/damon: add a DAMON interface wrapper python module
Date:   Sat,  2 Dec 2023 00:08:02 +0000
Message-Id: <20231202000806.46210-2-sj@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231202000806.46210-1-sj@kernel.org>
References: <20231202000806.46210-1-sj@kernel.org>
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

DAMON sysfs interface supports almost every DAMON functionality.  For
that, it provides a number of files and hierarchies that not simple to
be manually manipulated, or writing shell script every time.  For the
reason, DAMON is not having good functionality selftests.  Adding an
existing DAMON user space tool and using it could also be a way, but it
would add unnecessarily huge change that not essential for the test
purpose.  Write a minimum python module that can further extended to be
used as an easy-to-use DAMON functionality test purpose DAMON user
interface wrapper.

Note that this commit is implementing only basic data structures for
representing the sysfs files.  More operations will be implemented by
following commits, as needed for specific real test cases.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 tools/testing/selftests/damon/_damon.py | 102 ++++++++++++++++++++++++
 1 file changed, 102 insertions(+)
 create mode 100644 tools/testing/selftests/damon/_damon.py

diff --git a/tools/testing/selftests/damon/_damon.py b/tools/testing/selftests/damon/_damon.py
new file mode 100644
index 000000000000..78101846ab66
--- /dev/null
+++ b/tools/testing/selftests/damon/_damon.py
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


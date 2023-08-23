Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 089E2785291
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 10:22:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234273AbjHWISs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 04:18:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233705AbjHWIMc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 04:12:32 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0677B1982
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 01:09:35 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-58fb9323a27so50522167b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 01:09:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692778175; x=1693382975;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7+7xUX+eQzSie7iWr2Aj1jLiysTzidRjiqSjjI4y5Nk=;
        b=KGzB2PREcs7owuua9gpo5mr9UCgvODDN4jNmDXQ31zJ8kKkY+8Xr/3r2UoXwLjOePS
         K995kBSDC+RJdR30h2eK8/iNLOhSKskdWyoLgfI1S6WWIvjlf26gpbWQAnUWXcJRJNfY
         /QCrLJ3LrQQ2lux2AtnVKQDte0QQl/LSPc0RJ7G/8jTqwBphx3j+BkaorZ8qNnEsuVRH
         ld7PdetckaI4CSGfsLHt67Mn96NdZS2yYrIWZKCiXcojQNNV/rRqZ1MyWvQAvnVSnNDj
         KVBTNy0H+WpKvBG1L0x8Fw5LdWroU+bq7lBqO+YDy/xx38C09qEmo6l1CzAtNUvAS0/Z
         +XKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692778175; x=1693382975;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7+7xUX+eQzSie7iWr2Aj1jLiysTzidRjiqSjjI4y5Nk=;
        b=Z+PAPf1qVvnTMnWmU9zJBpWcEA5z6242CxzNhnbAVrVsbxXPjcpyVuLNd+NuuB2dok
         oD/DrL/HPQm9Xh4R5qdWDz4B3VdP3RkpfJ8WhYYhfTCJhEwtkXxGwvzWYp1P8ud5dWl5
         Um5SUJFinVtozL8nnxzG6KiuJGgDgFeVrWUeoZqpML6lf5YeAGLvfCg9UNH/HT8DSxqU
         MOH4+7KfyZjmXQw59qeLGE7+bXF0YnFxG00yDBtwwhtjOcuhPix4GSpHeOrfqrN9t82/
         tHjISFsImKoPOWZbho9tq5uzGiInCQoyRaqrcGR+13AAhskr/kyqVi8jKhdHFa2SjnPb
         XgYw==
X-Gm-Message-State: AOJu0YzFXuDfz3jfqowiY5MBRy7f26lKR69/RdCNq1vXIvy+P20OmV+u
        hAFy9afMOf6q/BoAoUtwgTrtFZ/K0YBF
X-Google-Smtp-Source: AGHT+IGtVayvCY/26FeTbSge7z228B5Rx9Dif54L8QiVcNmurVKbVuktSmELWXGjAL3aqdwmXD23+nueZQhm
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:3971:e84:f508:9a36])
 (user=irogers job=sendgmr) by 2002:a0d:ec05:0:b0:586:b332:8619 with SMTP id
 q5-20020a0dec05000000b00586b3328619mr150399ywn.7.1692778175150; Wed, 23 Aug
 2023 01:09:35 -0700 (PDT)
Date:   Wed, 23 Aug 2023 01:08:28 -0700
In-Reply-To: <20230823080828.1460376-1-irogers@google.com>
Message-Id: <20230823080828.1460376-26-irogers@google.com>
Mime-Version: 1.0
References: <20230823080828.1460376-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
Subject: [PATCH v1 25/25] perf jevents: Sort strings in the big C string to
 reduce faults
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        James Clark <james.clark@arm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        John Garry <john.g.garry@oracle.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Jing Zhang <renyu.zj@linux.alibaba.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Rob Herring <robh@kernel.org>,
        Gaosheng Cui <cuigaosheng1@huawei.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
        USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sort the strings within the big C string based on whether they were
for a metric and then by when they were added. This helps group
related strings and reduce minor faults by approximately 10 in 1740,
about 0.57%.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/jevents.py | 31 +++++++++++++++++++++++--------
 1 file changed, 23 insertions(+), 8 deletions(-)

diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jevents.py
index 01335a452e70..e5bce57f5688 100755
--- a/tools/perf/pmu-events/jevents.py
+++ b/tools/perf/pmu-events/jevents.py
@@ -113,13 +113,24 @@ class BigCString:
   strings: Set[str]
   big_string: Sequence[str]
   offsets: Dict[str, int]
+  insert_number: int
+  insert_point: Dict[str, int]
+  metrics: Set[str]
 
   def __init__(self):
     self.strings = set()
+    self.insert_number = 0;
+    self.insert_point = {}
+    self.metrics = set()
 
-  def add(self, s: str) -> None:
+  def add(self, s: str, metric: bool) -> None:
     """Called to add to the big string."""
-    self.strings.add(s)
+    if s not in self.strings:
+      self.strings.add(s)
+      self.insert_point[s] = self.insert_number
+      self.insert_number += 1
+      if metric:
+        self.metrics.add(s)
 
   def compute(self) -> None:
     """Called once all strings are added to compute the string and offsets."""
@@ -160,8 +171,11 @@ class BigCString:
     self.big_string = []
     self.offsets = {}
 
+    def string_cmp_key(s: str) -> Tuple[bool, int, str]:
+      return (s in self.metrics, self.insert_point[s], s)
+
     # Emit all strings that aren't folded in a sorted manner.
-    for s in sorted(self.strings):
+    for s in sorted(self.strings, key=string_cmp_key):
       if s not in folded_strings:
         self.offsets[s] = big_string_offset
         self.big_string.append(f'/* offset={big_string_offset} */ "')
@@ -574,19 +588,20 @@ def preprocess_one_file(parents: Sequence[str], item: os.DirEntry) -> None:
       assert len(mgroup) > 1, parents
       description = f"{metricgroup_descriptions[mgroup]}\\000"
       mgroup = f"{mgroup}\\000"
-      _bcs.add(mgroup)
-      _bcs.add(description)
+      _bcs.add(mgroup, metric=True)
+      _bcs.add(description, metric=True)
       _metricgroups[mgroup] = description
     return
 
   topic = get_topic(item.name)
   for event in read_json_events(item.path, topic):
     pmu_name = f"{event.pmu}\\000"
-    _bcs.add(pmu_name)
     if event.name:
-      _bcs.add(event.build_c_string(metric=False))
+      _bcs.add(pmu_name, metric=False)
+      _bcs.add(event.build_c_string(metric=False), metric=False)
     if event.metric_name:
-      _bcs.add(event.build_c_string(metric=True))
+      _bcs.add(pmu_name, metric=True)
+      _bcs.add(event.build_c_string(metric=True), metric=True)
 
 def process_one_file(parents: Sequence[str], item: os.DirEntry) -> None:
   """Process a JSON file during the main walk."""
-- 
2.42.0.rc1.204.g551eb34607-goog


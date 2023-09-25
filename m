Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 565A77ACFA4
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 07:58:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230062AbjIYF6p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 01:58:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230128AbjIYF6h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 01:58:37 -0400
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB4B2E8;
        Sun, 24 Sep 2023 22:58:30 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R671e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=renyu.zj@linux.alibaba.com;NM=1;PH=DS;RN=21;SR=0;TI=SMTPD_---0Vsl7J2J_1695621506;
Received: from srmbuffer011165236051.sqa.net(mailfrom:renyu.zj@linux.alibaba.com fp:SMTPD_---0Vsl7J2J_1695621506)
          by smtp.aliyun-inc.com;
          Mon, 25 Sep 2023 13:58:26 +0800
From:   Jing Zhang <renyu.zj@linux.alibaba.com>
To:     John Garry <john.g.garry@oracle.com>,
        Ian Rogers <irogers@google.com>
Cc:     Will Deacon <will@kernel.org>, James Clark <james.clark@arm.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-doc@vger.kernel.org,
        Zhuo Song <zhuo.song@linux.alibaba.com>,
        Jing Zhang <renyu.zj@linux.alibaba.com>,
        Shuai Xue <xueshuai@linux.alibaba.com>
Subject: [PATCH v10 3/7] perf jevents: Support EventidCode and NodeType
Date:   Mon, 25 Sep 2023 13:57:20 +0800
Message-Id: <1695621444-56530-4-git-send-email-renyu.zj@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1695621444-56530-1-git-send-email-renyu.zj@linux.alibaba.com>
References: <1695621444-56530-1-git-send-email-renyu.zj@linux.alibaba.com>
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The previous code assumes an event has either an "event=" or "config"
field at the beginning. For CMN neither of these may be present, as an
event is typically "type=xx,eventid=xxx".

So add EventidCode and NodeType to support CMN event description.

I compared pmu_event.c before and after compiling with JEVENT_ARCH=all,
they are consistent.

Signed-off-by: Jing Zhang <renyu.zj@linux.alibaba.com>
---
 tools/perf/pmu-events/jevents.py | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jevents.py
index a7e8833..057d51aa 100755
--- a/tools/perf/pmu-events/jevents.py
+++ b/tools/perf/pmu-events/jevents.py
@@ -298,6 +298,7 @@ class JsonEvent:
     if 'ExtSel' in jd:
       eventcode |= int(jd['ExtSel']) << 8
     configcode = int(jd['ConfigCode'], 0) if 'ConfigCode' in jd else None
+    eventidcode = int(jd['EventidCode'], 0) if 'EventidCode' in jd else None
     self.name = jd['EventName'].lower() if 'EventName' in jd else None
     self.topic = ''
     self.compat = jd.get('Compat')
@@ -335,7 +336,13 @@ class JsonEvent:
     if precise and self.desc and '(Precise Event)' not in self.desc:
       extra_desc += ' (Must be precise)' if precise == '2' else (' (Precise '
                                                                  'event)')
-    event = f'config={llx(configcode)}' if configcode is not None else f'event={llx(eventcode)}'
+    event = None
+    if configcode is not None:
+      event = f'config={llx(configcode)}'
+    elif eventidcode is not None:
+      event = f'eventid={llx(eventidcode)}'
+    else:
+      event = f'event={llx(eventcode)}'
     event_fields = [
         ('AnyThread', 'any='),
         ('PortMask', 'ch_mask='),
@@ -345,6 +352,7 @@ class JsonEvent:
         ('Invert', 'inv='),
         ('SampleAfterValue', 'period='),
         ('UMask', 'umask='),
+        ('NodeType', 'type='),
     ]
     for key, value in event_fields:
       if key in jd and jd[key] != '0':
-- 
1.8.3.1


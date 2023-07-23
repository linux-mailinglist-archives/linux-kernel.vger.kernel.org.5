Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6885F75E079
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jul 2023 10:22:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229912AbjGWIWi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 04:22:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229883AbjGWIWc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 04:22:32 -0400
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DCB910D3;
        Sun, 23 Jul 2023 01:22:29 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=renyu.zj@linux.alibaba.com;NM=1;PH=DS;RN=20;SR=0;TI=SMTPD_---0Vnzn8Vv_1690100543;
Received: from srmbuffer011165236051.sqa.net(mailfrom:renyu.zj@linux.alibaba.com fp:SMTPD_---0Vnzn8Vv_1690100543)
          by smtp.aliyun-inc.com;
          Sun, 23 Jul 2023 16:22:24 +0800
From:   Jing Zhang <renyu.zj@linux.alibaba.com>
To:     John Garry <john.g.garry@oracle.com>,
        Ian Rogers <irogers@google.com>
Cc:     Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Ilkka Koskinen <ilkka@os.amperecomputing.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-doc@vger.kernel.org,
        Zhuo Song <zhuo.song@linux.alibaba.com>,
        Jing Zhang <renyu.zj@linux.alibaba.com>,
        Shuai Xue <xueshuai@linux.alibaba.com>
Subject: [PATCH v4 2/4] perf jevents: Support more event fields
Date:   Sun, 23 Jul 2023 16:21:51 +0800
Message-Id: <1690100513-61165-3-git-send-email-renyu.zj@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1690100513-61165-1-git-send-email-renyu.zj@linux.alibaba.com>
References: <1690100513-61165-1-git-send-email-renyu.zj@linux.alibaba.com>
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The usual event descriptions are "event=xxx" or "config=xxx", while the
event descriptions of CMN are "type=xxx, eventid=xxx" or more complex.

$cat /sys/bus/event_source/devices/arm_cmn_0/events/hnf_cache_fill
type=0x5,eventid=0x3

When adding aliases for events described as "event=xxx" or "config=xxx",
EventCode or ConfigCode can be used in the JSON files to describe the
events. But "eventid=xxx, type=xxx" cannot be supported at present.

If EventCode and ConfigCode is not added in the alias JSON file, the
event description will add "event=0" by default. So, even if the event
field is added to supplement "eventid=xxx" and "type=xxx", the final
parsing result will be "event=0, eventid=xxx, type=xxx".

Therefore, when EventCode and ConfigCode are missing in JSON, "event=0" is
no longer added by default. EventidCode and Type are added to the event
field, and ConfigCode is moved into the event field.

Signed-off-by: Jing Zhang <renyu.zj@linux.alibaba.com>
---
 tools/perf/pmu-events/jevents.py | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jevents.py
index 2bcd07c..79c3cfa 100755
--- a/tools/perf/pmu-events/jevents.py
+++ b/tools/perf/pmu-events/jevents.py
@@ -259,12 +259,6 @@ class JsonEvent:
       }
       return table[unit] if unit in table else f'uncore_{unit.lower()}'
 
-    eventcode = 0
-    if 'EventCode' in jd:
-      eventcode = int(jd['EventCode'].split(',', 1)[0], 0)
-    if 'ExtSel' in jd:
-      eventcode |= int(jd['ExtSel']) << 8
-    configcode = int(jd['ConfigCode'], 0) if 'ConfigCode' in jd else None
     self.name = jd['EventName'].lower() if 'EventName' in jd else None
     self.topic = ''
     self.compat = jd.get('Compat')
@@ -297,7 +291,15 @@ class JsonEvent:
     if precise and self.desc and '(Precise Event)' not in self.desc:
       extra_desc += ' (Must be precise)' if precise == '2' else (' (Precise '
                                                                  'event)')
-    event = f'config={llx(configcode)}' if configcode is not None else f'event={llx(eventcode)}'
+    eventcode = None
+    if 'EventCode' in jd:
+      eventcode = int(jd['EventCode'].split(',', 1)[0], 0)
+    if 'ExtSel' in jd:
+      if eventcode is None:
+        eventcode = int(jd['ExtSel']) << 8
+      else:
+        eventcode |= int(jd['ExtSel']) << 8
+    event = f'event={llx(eventcode)}' if eventcode is not None else None
     event_fields = [
         ('AnyThread', 'any='),
         ('PortMask', 'ch_mask='),
@@ -307,10 +309,14 @@ class JsonEvent:
         ('Invert', 'inv='),
         ('SampleAfterValue', 'period='),
         ('UMask', 'umask='),
+        ('ConfigCode', 'config='),
+        ('EventIdCode', 'eventid='),
+        ('Type', 'type='),
+        ('OccupId', 'occupid='),
     ]
     for key, value in event_fields:
       if key in jd and jd[key] != '0':
-        event += ',' + value + jd[key]
+        event = event + ',' + value + jd[key] if event is not None else value + jd[key]
     if filter:
       event += f',{filter}'
     if msr:
-- 
1.8.3.1


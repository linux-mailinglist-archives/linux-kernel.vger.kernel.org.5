Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FCFF76FA73
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 08:51:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233960AbjHDGvs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 02:51:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233890AbjHDGvV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 02:51:21 -0400
Received: from out-123.mta1.migadu.com (out-123.mta1.migadu.com [95.215.58.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAA6F49E5
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 23:50:58 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1691131856;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OzB+tj5WG2nRg5qjnj2AfK3ycFx9pV+276EIl9UNjzI=;
        b=YLZj7PyQ1W40IvVqKAz4telK3UOEU755Km77YnQbv6fHLPvZQLj4HLBy8qQgXP4ZtwjJOn
        o0KkbrYXbekt3SbDYkjwl7DygkR0L1YXDxsqPO5tw2ancYRZnm9ZoDzWy/FdaabEwqnrSZ
        6LQs+S8cUSey6argktmIpAW7y+RW5Gg=
From:   chengming.zhou@linux.dev
To:     axboe@kernel.dk, tj@kernel.org
Cc:     linux-kernel@vger.kernel.org, zhouchengming@bytedance.com
Subject: [PATCH 2/3] iocost_monitor: print vrate inuse along with base_vrate
Date:   Fri,  4 Aug 2023 14:50:38 +0800
Message-ID: <20230804065039.8885-2-chengming.zhou@linux.dev>
In-Reply-To: <20230804065039.8885-1-chengming.zhou@linux.dev>
References: <20230804065039.8885-1-chengming.zhou@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chengming Zhou <zhouchengming@bytedance.com>

The real vrate iocost inuse is not base_vrate, but the atomic vtime_rate.
We need iocost_monitor tool to display this real vrate that iocost use,
to check if the boosted compensated vrate is normal.

Effect after change:

nvme0n1 RUN  per=50.0ms cur_per=172116.580:v1040587.433 busy= +0 \
vrate=135.00%:270.00% params=ssd_dfl(CQ)
                ^
                |
         this is real vrate inuse

Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 tools/cgroup/iocost_monitor.py | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/tools/cgroup/iocost_monitor.py b/tools/cgroup/iocost_monitor.py
index 7aa076cb559e..52ae9d1595b2 100644
--- a/tools/cgroup/iocost_monitor.py
+++ b/tools/cgroup/iocost_monitor.py
@@ -100,6 +100,7 @@ class IocStat:
         self.period_at = ioc.period_at.value_() / 1_000_000
         self.vperiod_at = ioc.period_at_vtime.value_() / VTIME_PER_SEC
         self.vrate_pct = ioc.vtime_base_rate.value_() * 100 / VTIME_PER_USEC
+        self.ivrate_pct = ioc.vtime_rate.counter.value_() * 100 / VTIME_PER_USEC
         self.busy_level = ioc.busy_level.value_()
         self.autop_idx = ioc.autop_idx.value_()
         self.user_cost_model = ioc.user_cost_model.value_()
@@ -119,7 +120,9 @@ class IocStat:
                  'period_at'            : self.period_at,
                  'period_vtime_at'      : self.vperiod_at,
                  'busy_level'           : self.busy_level,
-                 'vrate_pct'            : self.vrate_pct, }
+                 'vrate_pct'            : self.vrate_pct,
+                 'ivrate_pct'           : self.ivrate_pct,
+                }
 
     def table_preamble_str(self):
         state = ('RUN' if self.running else 'IDLE') if self.enabled else 'OFF'
@@ -127,7 +130,7 @@ class IocStat:
                  f'per={self.period_ms}ms ' \
                  f'cur_per={self.period_at:.3f}:v{self.vperiod_at:.3f} ' \
                  f'busy={self.busy_level:+3} ' \
-                 f'vrate={self.vrate_pct:6.2f}% ' \
+                 f'vrate={self.vrate_pct:6.2f}%:{self.ivrate_pct:6.2f}% ' \
                  f'params={self.autop_name}'
         if self.user_cost_model or self.user_qos_params:
             output += f'({"C" if self.user_cost_model else ""}{"Q" if self.user_qos_params else ""})'
-- 
2.41.0


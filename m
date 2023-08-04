Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ED7A76FA75
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 08:51:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234032AbjHDGvw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 02:51:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233957AbjHDGvX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 02:51:23 -0400
Received: from out-106.mta1.migadu.com (out-106.mta1.migadu.com [IPv6:2001:41d0:203:375::6a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 438DAE69
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 23:51:01 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1691131858;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6+OCmkB89lJ9QhqUH4GLLqFHcU5/CM75quLqXRzfOwY=;
        b=oH0V0+nUwhj+72gwRc5ePHbuqdLY/xtqB7P0DP84CcRPglVSIUiSlTqBKcH5X9gWCF69Y3
        ALYeZ+iP0YR4jahdwaAvrK7vez+SbpXMeCDnYRQQ+x76r27KkBQPrwryjXUHDHBZqGsFl7
        W0whfcJRbxal3QLq7RCQygin4tnNfq4=
From:   chengming.zhou@linux.dev
To:     axboe@kernel.dk, tj@kernel.org
Cc:     linux-kernel@vger.kernel.org, zhouchengming@bytedance.com
Subject: [PATCH 3/3] iocost_monitor: improve it by adding iocg wait_ms
Date:   Fri,  4 Aug 2023 14:50:39 +0800
Message-ID: <20230804065039.8885-3-chengming.zhou@linux.dev>
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

The iocg can have three throttled metrics: wait, debt, delay. This patch
add missing wait_ms to IocgStat to show the latest wait_ms of iocg.

As we are here, group iocg usage percents "inflt%" and "usage%" together,
and group iocg throttled metrics "wait", "debt" and "delay" together.

Effect after changes:

nvme0n1 RUN  per=50.0ms cur_per=177105.713:v1053528.587 busy= +0 vrate=135.00%:270.00% params=ssd_dfl(CQ)
                          active    weight      hweight% inflt% usage%    wait    debt   delay
InterfererGroup0             *   100/  100  54.28/  9.09   0.34  24.07    0.00    0.00    0.00
interfered                   *    84/ 1000  45.72/ 90.91   0.48  41.09    0.00    0.00    0.00

Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 tools/cgroup/iocost_monitor.py | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/tools/cgroup/iocost_monitor.py b/tools/cgroup/iocost_monitor.py
index 52ae9d1595b2..933c750b319b 100644
--- a/tools/cgroup/iocost_monitor.py
+++ b/tools/cgroup/iocost_monitor.py
@@ -138,7 +138,7 @@ class IocStat:
 
     def table_header_str(self):
         return f'{"":25} active {"weight":>9} {"hweight%":>13} {"inflt%":>6} ' \
-               f'{"debt":>7} {"delay":>7} {"usage%"}'
+               f'{"usage%":>6} {"wait":>7} {"debt":>7} {"delay":>7}'
 
 class IocgStat:
     def __init__(self, iocg):
@@ -164,6 +164,8 @@ class IocgStat:
 
         self.usage = (100 * iocg.usage_delta_us.value_() /
                       ioc.period_us.value_()) if self.active else 0
+        self.wait_ms = (iocg.stat.wait_us.value_() -
+                        iocg.last_stat.wait_us.value_()) / 1000
         self.debt_ms = iocg.abs_vdebt.value_() / VTIME_PER_USEC / 1000
         if blkg.use_delay.counter.value_() != 0:
             self.delay_ms = blkg.delay_nsec.counter.value_() / 1_000_000
@@ -180,9 +182,10 @@ class IocgStat:
                 'hweight_active_pct'    : self.hwa_pct,
                 'hweight_inuse_pct'     : self.hwi_pct,
                 'inflight_pct'          : self.inflight_pct,
+                'usage_pct'             : self.usage,
+                'wait_ms'               : self.wait_ms,
                 'debt_ms'               : self.debt_ms,
                 'delay_ms'              : self.delay_ms,
-                'usage_pct'             : self.usage,
                 'address'               : self.address }
         return out
 
@@ -192,9 +195,10 @@ class IocgStat:
               f'{round(self.inuse):5}/{round(self.active):5} ' \
               f'{self.hwi_pct:6.2f}/{self.hwa_pct:6.2f} ' \
               f'{self.inflight_pct:6.2f} ' \
+              f'{min(self.usage, 999):6.2f} ' \
+              f'{self.wait_ms:7.2f} ' \
               f'{self.debt_ms:7.2f} ' \
-              f'{self.delay_ms:7.2f} '\
-              f'{min(self.usage, 999):6.2f}'
+              f'{self.delay_ms:7.2f}'
         out = out.rstrip(':')
         return out
 
-- 
2.41.0


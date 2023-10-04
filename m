Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 116A67B83B1
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 17:35:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233738AbjJDPfq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 11:35:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233692AbjJDPfm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 11:35:42 -0400
Received: from out-203.mta1.migadu.com (out-203.mta1.migadu.com [IPv6:2001:41d0:203:375::cb])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF83FCE
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 08:35:38 -0700 (PDT)
Message-ID: <a1fe7d7d-3521-648e-baeb-5cf8e2a8ae3a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1696433736;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4sRnG2yg4I61J1F96z6/qMAsZlsk2UA4qVDxZItMXbI=;
        b=ajupj+mSkKwsdquRS64v2Myg5+yUBTjoB4o2b0tk8+3jf60EDCB3kwQPr4RrwoPLMGCKrh
        kkuxKyEXa0rFrleqFP7GvunVjH0SlbWIYA+jYrdmXfGe/u1DS3m9JHqGZdg4yjxVCJyRI5
        /ZwGctS4isFv8tDGs5lUojdozRWCUIA=
Date:   Wed, 4 Oct 2023 23:35:26 +0800
MIME-Version: 1.0
Subject: Re: [PATCH v4] sched/rt: move back to RT_GROUP_SCHED and rename it
 child
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@kernel.org>, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org,
        kernel test robot <oliver.sang@intel.com>
References: <20230803050317.2240948-1-yajun.deng@linux.dev>
 <ZRvkM1lxsTrHb2Ox@gmail.com> <93aa2ee6-3ee4-0129-7160-d3684ba67f56@linux.dev>
 <20231003163719.GG1539@noisy.programming.kicks-ass.net>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Yajun Deng <yajun.deng@linux.dev>
In-Reply-To: <20231003163719.GG1539@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2023/10/4 00:37, Peter Zijlstra wrote:
> On Tue, Oct 03, 2023 at 10:55:50PM +0800, Yajun Deng wrote:
>
>> @Peter, I think I split up this patch into 2 separate patches:
>>
>>           sched/rt: Introduce for_each_sched_rt_entity_back() & use it
> Why ?? Having that macro makes no sense what so ever. You can't use it,
> unless you set up the back pointers first. It is not a self contained
> piece of functionality.


The 2nd patch rely on this patch. It will be used in dequeue_rt_stack. 
We need to add a macro first,

because the 'back' will be not exist after the 2nd patch when disable 
CONFIG_RT_GROUP_SCHED.

diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 88fc98601413..0b6b4a715d6e 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -520,6 +520,9 @@ static inline struct task_group 
*next_task_group(struct task_group *tg)
  #define for_each_sched_rt_entity(rt_se) \
      for (; rt_se; rt_se = rt_se->parent)

+#define for_each_sched_rt_back(rt_se) \
+    for (; rt_se; rt_se = rt_se->back)
+
  static inline struct rt_rq *group_rt_rq(struct sched_rt_entity *rt_se)
  {
      return rt_se->my_q;
@@ -625,6 +628,9 @@ typedef struct rt_rq *rt_rq_iter_t;
  #define for_each_sched_rt_entity(rt_se) \
      for (; rt_se; rt_se = NULL)

+#define for_each_sched_rt_entity_back(rt_se) \
+    for_each_sched_rt_entity(rt_se)
+
  static inline struct rt_rq *group_rt_rq(struct sched_rt_entity *rt_se)
  {
      return NULL;
@@ -1445,7 +1451,8 @@ static void dequeue_rt_stack(struct 
sched_rt_entity *rt_se, unsigned int flags)

      rt_nr_running = rt_rq_of_se(back)->rt_nr_running;

-    for (rt_se = back; rt_se; rt_se = rt_se->back) {
+    rt_se = back;
+    for_each_sched_rt_entity_back(rt_se) {
          if (on_rt_rq(rt_se))
              __dequeue_rt_entity(rt_se, flags);
      }


>
>>          sched/rt: Move sched_rt_entity::back to under the
>> CONFIG_RT_GROUP_SCHED block
> This one sure.

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5ACFD7CD59B
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 09:44:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbjJRHom (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 03:44:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbjJRHok (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 03:44:40 -0400
Received: from out-204.mta1.migadu.com (out-204.mta1.migadu.com [95.215.58.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27391B6
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 00:44:38 -0700 (PDT)
Message-ID: <8cff8994-28a3-4a7e-8a6e-217c4da49ca1@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1697615075;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9bMgqpjKJctONHZa51iGAlmtZ2Iy4OZNrzOKRecYBwM=;
        b=AnzxZLNEyZMWE71XrW9O12ISDXjmlBUDBvfft5mO1leMCK6hyuSW9SjQbr3rfOVLx+/VHp
        /VwVvNQQHyuHoJsRBXYoRfHR2Hub1OckrJ7JYlt8KHNYFHVKN1gQoXTp3n3vwhLyADfFSn
        QUxmRIuvnWh0LC1Bi/3Rr7/q3kJcsKA=
Date:   Wed, 18 Oct 2023 15:44:29 +0800
MIME-Version: 1.0
Subject: Re: [RFC PATCH 0/5] slub: Delay freezing of CPU partial slabs
Content-Language: en-US
To:     Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc:     cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, akpm@linux-foundation.org, vbabka@suse.cz,
        roman.gushchin@linux.dev, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Chengming Zhou <zhouchengming@bytedance.com>
References: <20231017154439.3036608-1-chengming.zhou@linux.dev>
 <CAB=+i9Sw1YSdUKrjygA5cOsVjQMVmS8-KJ+ku4AG9Fw_2guENQ@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Chengming Zhou <chengming.zhou@linux.dev>
In-Reply-To: <CAB=+i9Sw1YSdUKrjygA5cOsVjQMVmS8-KJ+ku4AG9Fw_2guENQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/10/18 14:34, Hyeonggon Yoo wrote:
> On Wed, Oct 18, 2023 at 12:45 AM <chengming.zhou@linux.dev> wrote:
>> 4. Testing
>> ==========
>> We just did some simple testing on a server with 128 CPUs (2 nodes) to
>> compare performance for now.
>>
>>  - perf bench sched messaging -g 5 -t -l 100000
>>    baseline     RFC
>>    7.042s       6.966s
>>    7.022s       7.045s
>>    7.054s       6.985s
>>
>>  - stress-ng --rawpkt 128 --rawpkt-ops 100000000
>>    baseline     RFC
>>    2.42s        2.15s
>>    2.45s        2.16s
>>    2.44s        2.17s
>>
>> It shows above there is about 10% improvement on stress-ng rawpkt
>> testcase, although no much improvement on perf sched bench testcase.
>>
>> Thanks for any comment and code review!
> 
> Hi Chengming, this is the kerneltesting.org test report for your patch series.
> 
> I applied this series on my slab-experimental tree [1] for testing,
> and I observed several kernel panics [2] [3] [4] on kernels without
> CONFIG_SLUB_CPU_PARTIAL.
> 
> To verify that this series caused kernel panics, I tested before and after
> applying it on Vlastimil's slab/for-next and yeah, this series was the cause.
> 
> System is deadlocked on memory and the OOM-killer says there is a
> huge amount of slab memory. So maybe there is a memory leak or it makes
> slab memory grow unboundedly?

Thanks for the testing!

I can reproduce the OOM locally without CONFIG_SLUB_CPU_PARTIAL.

I made a quick fix below (will need to get another better fix). The root
cause is in patch-4, which wrongly put some partial slabs onto the CPU
partial list even without CONFIG_SLUB_CPU_PARTIAL. So these partial slabs
are leaked.

diff --git a/mm/slub.c b/mm/slub.c
index d58eaf8447fd..b7ba6c008122 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2339,12 +2339,12 @@ static void *get_partial_node(struct kmem_cache *s, struct kmem_cache_node *n,
                        }
                }

+#ifdef CONFIG_SLUB_CPU_PARTIAL
                remove_partial(n, slab);
                put_cpu_partial(s, slab, 0);
                stat(s, CPU_PARTIAL_NODE);
                partial_slabs++;

-#ifdef CONFIG_SLUB_CPU_PARTIAL
                if (!kmem_cache_has_cpu_partial(s)
                        || partial_slabs > s->cpu_partial_slabs / 2)
                        break;


> 
> [1] https://git.kerneltesting.org/slab-experimental/
> [2] https://lava.kerneltesting.org/scheduler/job/127#bottom
> [3] https://lava.kerneltesting.org/scheduler/job/131#bottom
> [4] https://lava.kerneltesting.org/scheduler/job/134#bottom
> 
>>
>> Chengming Zhou (5):
>>   slub: Introduce on_partial()
>>   slub: Don't manipulate slab list when used by cpu
>>   slub: Optimize deactivate_slab()
>>   slub: Don't freeze slabs for cpu partial
>>   slub: Introduce get_cpu_partial()
>>
>>  mm/slab.h |   2 +-
>>  mm/slub.c | 257 +++++++++++++++++++++++++++++++-----------------------
>>  2 files changed, 150 insertions(+), 109 deletions(-)
>>
>> --
>> 2.40.1
>>

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D67437D4549
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 04:02:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231865AbjJXCCl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 22:02:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231888AbjJXCCj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 22:02:39 -0400
Received: from out-207.mta0.migadu.com (out-207.mta0.migadu.com [IPv6:2001:41d0:1004:224b::cf])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 431F410C3
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 19:02:33 -0700 (PDT)
Message-ID: <08a9ee64-c27d-4eed-8762-1514c6eb1c88@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1698112951;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bJh3VcxlCB6JG6FhFj/zexR9NXgDMv0p5GP4dzs8Byc=;
        b=h3WFxfSJ6i9QZyGiLFqFgnx6zo1QpSffo0BypECG+9QLwDvjzXEqYauVXJFzKZi1PgLOBQ
        SxiNqjxZvBNKMBhXqI3rpm8V4LJykKxjOTrm8DXV/FsIRsxkVbVd2fDicJE/bj9+sJ7Ahv
        lSfuf9pscZqrtw1fWjCkTP+pC/zCUh4=
Date:   Tue, 24 Oct 2023 10:02:24 +0800
MIME-Version: 1.0
Subject: Re: [RFC PATCH v2 0/6] slub: Delay freezing of CPU partial slabs
Content-Language: en-US
To:     Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc:     cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, akpm@linux-foundation.org, vbabka@suse.cz,
        roman.gushchin@linux.dev, willy@infradead.org, pcc@google.com,
        tytso@mit.edu, maz@kernel.org, ruansy.fnst@fujitsu.com,
        vishal.moola@gmail.com, lrh2000@pku.edu.cn, hughd@google.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Chengming Zhou <zhouchengming@bytedance.com>
References: <20231021144317.3400916-1-chengming.zhou@linux.dev>
 <CAB=+i9Rm3y+y1HrYLuEHP-q8qXnvwgM62XJ_rqHnN=Eb3HFTPg@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Chengming Zhou <chengming.zhou@linux.dev>
In-Reply-To: <CAB=+i9Rm3y+y1HrYLuEHP-q8qXnvwgM62XJ_rqHnN=Eb3HFTPg@mail.gmail.com>
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

On 2023/10/22 22:52, Hyeonggon Yoo wrote:
> On Sat, Oct 21, 2023 at 11:43 PM <chengming.zhou@linux.dev> wrote:
>>
>> From: Chengming Zhou <zhouchengming@bytedance.com>
>>
>> Changes in RFC v2:
>>  - Reuse PG_workingset bit to keep track of whether slub is on the
>>    per-node partial list, as suggested by Matthew Wilcox.
>>  - Fix OOM problem on kernel without CONFIG_SLUB_CPU_PARTIAL, which
>>    is caused by leak of partial slabs when get_partial_node().
>>  - Add a patch to simplify acquire_slab().
>>  - Reorder patches a little.
>>  - v1: https://lore.kernel.org/all/20231017154439.3036608-1-chengming.zhou@linux.dev/
> 
> I've picked [1] and tested this patch series and it passed a simple MM
> & slab test
> in 30 different SLUB configurations [2].
> 
> Also there's code coverage information [3] if you're interested :P
> 
> For the series,
> Tested-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>

Thank you! These are very helpful to me, I will also do more workloads
stress testing with more configurations.

> 
> Will review when I have free time ;)

Ok, thanks for your time.

> Thanks!
> 
> [1] https://git.kerneltesting.org/slab-experimental/log/
> [2] https://jenkins.kerneltesting.org/job/slab-experimental/
> [3] https://coverage.kerneltesting.org/slab-experimental-6283c415/mm/index.html
> 
>> Chengming Zhou (6):
>>   slub: Keep track of whether slub is on the per-node partial list
>>   slub: Prepare __slab_free() for unfrozen partial slab out of node
>>     partial list
>>   slub: Don't freeze slabs for cpu partial
>>   slub: Simplify acquire_slab()
>>   slub: Introduce get_cpu_partial()
>>   slub: Optimize deactivate_slab()
>>
>>  include/linux/page-flags.h |   2 +
>>  mm/slab.h                  |  19 +++
>>  mm/slub.c                  | 245 +++++++++++++++++++------------------
>>  3 files changed, 150 insertions(+), 116 deletions(-)
>>
>> --
>> 2.20.1
>>

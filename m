Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 035A67781B6
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 21:41:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235752AbjHJTlO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 15:41:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233486AbjHJTlM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 15:41:12 -0400
Received: from out-110.mta1.migadu.com (out-110.mta1.migadu.com [95.215.58.110])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5C4D26B5
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 12:41:10 -0700 (PDT)
Message-ID: <c390dc64-280e-6d9f-661a-9a5d77f16cf8@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1691696468;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OuDx6q87jGoCwsecy09MqUn126nk87pBh26c1SpaUZI=;
        b=EyIqYMe+6RnnpEVKI1DDmD/DL9g9mqschLBHCfLPeH6sJI8V8oI6p18NmddlVUh3zGrgdw
        poEHB80/OafLc+5Z6Lp9U0lr8Q2o7wCEKcA1LyrzheoJx3KQJ3/Sg87iEIFDJiR0dvde6F
        Iq5XbQuMFFQkt0xZcte/W+q0kmgGJSs=
Date:   Thu, 10 Aug 2023 12:41:01 -0700
MIME-Version: 1.0
Subject: Re: [RFC PATCH 1/2] mm, oom: Introduce bpf_select_task
Content-Language: en-US
To:     Michal Hocko <mhocko@suse.com>,
        Roman Gushchin <roman.gushchin@linux.dev>
Cc:     Chuyi Zhou <zhouchuyi@bytedance.com>, hannes@cmpxchg.org,
        ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        muchun.song@linux.dev, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, wuyun.abel@bytedance.com,
        robin.lu@bytedance.com
References: <20230804093804.47039-1-zhouchuyi@bytedance.com>
 <20230804093804.47039-2-zhouchuyi@bytedance.com>
 <ZMzhDFhvol2VQBE4@dhcp22.suse.cz>
 <dfbf05d1-daff-e855-f4fd-e802614b79c4@bytedance.com>
 <ZMz+aBHFvfcr0oIe@dhcp22.suse.cz>
 <866462cf-6045-6239-6e27-45a733aa7daa@bytedance.com>
 <ZNCXgsZL7bKsCEBM@dhcp22.suse.cz> <ZNEpsUFgKFIAAgrp@P9FQF9L96D.lan>
 <ZNH6X/2ZZ0quKSI6@dhcp22.suse.cz> <ZNK2fUmIfawlhuEY@P9FQF9L96D>
 <ZNNGFzwlv1dC866j@dhcp22.suse.cz>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <ZNNGFzwlv1dC866j@dhcp22.suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>>> First, I'm a bit concerned about implicit restrictions we apply to bpf programs
>>>> which will be executed potentially thousands times under a very heavy memory
>>>> pressure. We will need to make sure that they don't allocate (much) memory, don't
>>>> take any locks which might deadlock with other memory allocations etc.
>>>> It will potentially require hard restrictions on what these programs can and can't
>>>> do and this is something that the bpf community will have to maintain long-term.
>>>
>>> Right, BPF callbacks operating under OOM situations will be really
>>> constrained but this is more or less by definition. Isn't it?
>>
>> What do you mean?
> 
> Callbacks cannot depend on any direct or indirect memory allocations.
> Dependencies on any sleeping locks (again directly or indirectly) is not
> allowed just to name the most important ones.
> 
>> In general, the bpf community is trying to make it as generic as possible and
>> adding new and new features. Bpf programs are not as constrained as they were
>> when it's all started.

bpf supports different running context. For example, only non-sleepable bpf prog 
is allowed to run at the NIC driver. A sleepable bpf prog is only allowed to run 
at some bpf_lsm hooks that is known to be safe to call blocking 
bpf-helper/kfunc. From the bpf side, it ensures a non-sleepable bpf prog cannot 
do things that may block.

fwiw, Dave has recently proposed something for iterating the task vma 
(https://lore.kernel.org/bpf/20230810183513.684836-4-davemarchevsky@fb.com/). 
Potentially, a similar iterator can be created for a bpf program to iterate 
cgroups and tasks.



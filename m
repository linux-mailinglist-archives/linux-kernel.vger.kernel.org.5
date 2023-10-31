Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F27377DD174
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 17:22:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345017AbjJaQWZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 12:22:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344836AbjJaQWX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 12:22:23 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B497D110
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 09:22:18 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id 5614622812f47-3b4145e887bso3182233b6e.3
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 09:22:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1698769338; x=1699374138; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3z6tukCl+9Ypo8mcVzJeMZlWMbgi6HguP+juUjy6MUA=;
        b=J6p2Y8hBEcJig2cnSTwrYtLx6gs5sT/OPgA7LX7AI0NSN8z11IXYXCVkpfBWNtSDY4
         vnt2fBvCAICMOQQmVeQPgumYt7sYKMt3BeLE3T+zj00abSVXLjp+LuJjwf4BY2CQd2PB
         2+pk6moymtVGwJQ14Y9u0iy0GJwqXoYNbqP9gA/r66oUs6PyKjiUyMnW8tRE89nlm4F3
         zU/VBqHQTmo22n7Mf/t2SyOyy7APH8ebI7BZJbnoDPGaifR6fzQ4iW/zr6OMkI8Wk5XS
         JopQeQ6/FO2VNeyhXHkQ5UuIJu8fiNgyJ5Zpcl1QArzbaT8jZJww7ovwwHxieNCJUlp8
         12Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698769338; x=1699374138;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3z6tukCl+9Ypo8mcVzJeMZlWMbgi6HguP+juUjy6MUA=;
        b=BBU1OgWx9KMnLtB5ZDPVgZp5M99qIKGmfQSio+oC6YL5+/kbJLBQtmeHeY5Tc2JGi2
         FR7nsHqvWsdMl/dsiWN5tyMbaxvVkO5PJkn/qzhQIErsySn6FFTwVFeSfXIKsqzt/YfJ
         FYttTz8VNehODPLJndR0lGhLohv1JJ42Hcv2zVXnaAtGYCjVGk1SzdEux6vN9fjrr6pG
         G2geg23FnouHR9vzO4iqGmNhL/PpTFVPEOGFacj0veUaOChFrIHaIbM7dIHiqQs0vK/z
         BobawcLMkEzHq7PGDA9+eKwn889hNMJPSXuLyNSz4BKahjombCSANKxJCFVntQbxXqF1
         StGw==
X-Gm-Message-State: AOJu0YwaILm3ABYCRQoSat2MQ94LEAfwaO7XgXPycDDoU4M3shiy21Hf
        Ld8oabgJIsB5VZs7vvdOC9znDA==
X-Google-Smtp-Source: AGHT+IFuyfW7nO6nH2U0/Ul9RAvsJtuReIeOW8nEg9tgWykrqT2tdTJvGFEngkm4AktnJZX2S1p9/w==
X-Received: by 2002:a05:6808:14d0:b0:3ae:4774:c00c with SMTP id f16-20020a05680814d000b003ae4774c00cmr15224164oiw.53.1698769337776;
        Tue, 31 Oct 2023 09:22:17 -0700 (PDT)
Received: from localhost ([2620:10d:c091:400::5:a294])
        by smtp.gmail.com with ESMTPSA id b22-20020a05620a119600b0076cc4610d0asm628787qkk.85.2023.10.31.09.22.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Oct 2023 09:22:17 -0700 (PDT)
Date:   Tue, 31 Oct 2023 12:22:16 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Gregory Price <gourry.memverge@gmail.com>,
        linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
        linux-mm@kvack.org, ying.huang@intel.com,
        akpm@linux-foundation.org, aneesh.kumar@linux.ibm.com,
        weixugc@google.com, apopple@nvidia.com, tim.c.chen@intel.com,
        dave.hansen@intel.com, shy828301@gmail.com,
        gregkh@linuxfoundation.org, rafael@kernel.org,
        Gregory Price <gregory.price@memverge.com>
Subject: Re: [RFC PATCH v3 0/4] Node Weights and Weighted Interleave
Message-ID: <20231031162216.GB3029315@cmpxchg.org>
References: <20231031003810.4532-1-gregory.price@memverge.com>
 <rm43wgtlvwowjolzcf6gj4un4qac4myngxqnd2jwt5yqxree62@t66scnrruttc>
 <20231031152142.GA3029315@cmpxchg.org>
 <jgh5b5bm73qe7m3qmnsjo3drazgfaix3ycqmom5u6tfp6hcerj@ij4vftrutvrt>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <jgh5b5bm73qe7m3qmnsjo3drazgfaix3ycqmom5u6tfp6hcerj@ij4vftrutvrt>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 31, 2023 at 04:56:27PM +0100, Michal Hocko wrote:
> On Tue 31-10-23 11:21:42, Johannes Weiner wrote:
> > On Tue, Oct 31, 2023 at 10:53:41AM +0100, Michal Hocko wrote:
> > > On Mon 30-10-23 20:38:06, Gregory Price wrote:
> > > > This patchset implements weighted interleave and adds a new sysfs
> > > > entry: /sys/devices/system/node/nodeN/accessM/il_weight.
> > > > 
> > > > The il_weight of a node is used by mempolicy to implement weighted
> > > > interleave when `numactl --interleave=...` is invoked.  By default
> > > > il_weight for a node is always 1, which preserves the default round
> > > > robin interleave behavior.
> > > > 
> > > > Interleave weights may be set from 0-100, and denote the number of
> > > > pages that should be allocated from the node when interleaving
> > > > occurs.
> > > > 
> > > > For example, if a node's interleave weight is set to 5, 5 pages
> > > > will be allocated from that node before the next node is scheduled
> > > > for allocations.
> > > 
> > > I find this semantic rather weird TBH. First of all why do you think it
> > > makes sense to have those weights global for all users? What if
> > > different applications have different view on how to spred their
> > > interleaved memory?
> > > 
> > > I do get that you might have a different tiers with largerly different
> > > runtime characteristics but why would you want to interleave them into a
> > > single mapping and have hard to predict runtime behavior?
> > > 
> > > [...]
> > > > In this way it becomes possible to set an interleaving strategy
> > > > that fits the available bandwidth for the devices available on
> > > > the system. An example system:
> > > > 
> > > > Node 0 - CPU+DRAM, 400GB/s BW (200 cross socket)
> > > > Node 1 - CPU+DRAM, 400GB/s BW (200 cross socket)
> > > > Node 2 - CXL Memory. 64GB/s BW, on Node 0 root complex
> > > > Node 3 - CXL Memory. 64GB/s BW, on Node 1 root complex
> > > > 
> > > > In this setup, the effective weights for nodes 0-3 for a task
> > > > running on Node 0 may be [60, 20, 10, 10].
> > > > 
> > > > This spreads memory out across devices which all have different
> > > > latency and bandwidth attributes at a way that can maximize the
> > > > available resources.
> > > 
> > > OK, so why is this any better than not using any memory policy rely
> > > on demotion to push out cold memory down the tier hierarchy?
> > > 
> > > What is the actual real life usecase and what kind of benefits you can
> > > present?
> > 
> > There are two things CXL gives you: additional capacity and additional
> > bus bandwidth.
> > 
> > The promotion/demotion mechanism is good for the capacity usecase,
> > where you have a nice hot/cold gradient in the workingset and want
> > placement accordingly across faster and slower memory.
> > 
> > The interleaving is useful when you have a flatter workingset
> > distribution and poorer access locality. In that case, the CPU caches
> > are less effective and the workload can be bus-bound. The workload
> > might fit entirely into DRAM, but concentrating it there is
> > suboptimal. Fanning it out in proportion to the relative performance
> > of each memory tier gives better resuls.
> > 
> > We experimented with datacenter workloads on such machines last year
> > and found significant performance benefits:
> > 
> > https://lore.kernel.org/linux-mm/YqD0%2FtzFwXvJ1gK6@cmpxchg.org/T/
> 
> Thanks, this is a useful insight.
>  
> > This hopefully also explains why it's a global setting. The usecase is
> > different from conventional NUMA interleaving, which is used as a
> > locality measure: spread shared data evenly between compute
> > nodes. This one isn't about locality - the CXL tier doesn't have local
> > compute. Instead, the optimal spread is based on hardware parameters,
> > which is a global property rather than a per-workload one.
> 
> Well, I am not convinced about that TBH. Sure it is probably a good fit
> for this specific CXL usecase but it just doesn't fit into many others I
> can think of - e.g. proportional use of those tiers based on the
> workload - you get what you pay for.
> 
> Is there any specific reason for not having a new interleave interface
> which defines weights for the nodemask? Is this because the policy
> itself is very dynamic or is this more driven by simplicity of use?

A downside of *requiring* weights to be paired with the mempolicy is
that it's then the application that would have to figure out the
weights dynamically, instead of having a static host configuration. A
policy of "I want to be spread for optimal bus bandwidth" translates
between different hardware configurations, but optimal weights will
vary depending on the type of machine a job runs on.

That doesn't mean there couldn't be usecases for having weights as
policy as well in other scenarios, like you allude to above. It's just
so far such usecases haven't really materialized or spelled out
concretely. Maybe we just want both - a global default, and the
ability to override it locally. Could you elaborate on the 'get what
you pay for' usecase you mentioned?

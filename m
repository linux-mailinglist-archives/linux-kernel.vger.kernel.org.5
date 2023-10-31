Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E76767DD06D
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 16:22:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344777AbjJaPWI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 11:22:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344673AbjJaPWC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 11:22:02 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2F00126
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 08:21:44 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id af79cd13be357-77897c4ac1fso386727485a.3
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 08:21:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1698765704; x=1699370504; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZnmkiJJG0cEgBzyHB4LFbZlwQl8xMEYKj1qchPFtzG4=;
        b=J6Bn8VVUm06P+Yfv/ypgUgwEbXm+/Dnh08wxkyt71+r9Rg/A5oQ7ep/9ZRMxcHVnEx
         TcE+j0TC0WJJSXe6FzowZM9oCfB1+dicsO7YFi2O96Y56fcv76YZ1n2v4Vze/oaeNGaA
         6slRWe2x5p5zmeZ3Td4W53ZUZP0PNuubYvaXeh5kDbJxGGsplXdwrrcZVsFVMB1f3lOJ
         7B+q4zK09l0VyZqPLJGWp88EEBEL+cJbg1Pa5eZKCEjZiyTgfPgMF2bD92pzgl2dv0wG
         rLKhsf7+B4P7B9iC9vrvVg1RC9jJF95kEhdMMh5s/1+aeeAXBEx5xKNFagBZaiMCwnLO
         bnpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698765704; x=1699370504;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZnmkiJJG0cEgBzyHB4LFbZlwQl8xMEYKj1qchPFtzG4=;
        b=cif6nccpl6pCaNswtjyyF0A+ffCdwS2t47XxwQyFUcudlJLXU38YOmMqiTDxXuiqLh
         2HDzxmA1LDXHvmNsFGI2rioluJkiQ1jMAgvP1hBsYR6kGoNKbP1TSImP9uQPt/aTARf3
         k7dkMYlzNFgITCXO4iZ2lWAASnGy7hjNibSsU9pnlLTou3MN5LK2Uk9HgxeAonNs2iSz
         NaeFH6K1cYUrh9XY2RDGcS0Rk2TzvNAe0O8mz2Tnmbb3owVUyXiXowmfOrXPCXoxxuVK
         AMSgraOxqrFKdS81U9a3fIrsFleSQbC1sZG5T01ThI2vQ+D4RwlcnrDipDxgrtsnkoIx
         znbA==
X-Gm-Message-State: AOJu0YxV+9j7WDLUMKfpicSdtOGdgn2QujFuQAecl/UAn6eDKJ/3Bf/l
        tI8SmLVyjuLoU5PceciMFzvHzw==
X-Google-Smtp-Source: AGHT+IGPYBEeF9BbUTVwUbma4WDE/1ptaZPy3XJsVsp7P2LAAwW3/vB/rtdvJjOrS3sR2ClQKgFiXQ==
X-Received: by 2002:a05:620a:25c8:b0:77a:47ad:1211 with SMTP id y8-20020a05620a25c800b0077a47ad1211mr1196140qko.69.1698765703762;
        Tue, 31 Oct 2023 08:21:43 -0700 (PDT)
Received: from localhost ([2620:10d:c091:400::5:a294])
        by smtp.gmail.com with ESMTPSA id az40-20020a05620a172800b0076db5b792basm577846qkb.75.2023.10.31.08.21.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Oct 2023 08:21:43 -0700 (PDT)
Date:   Tue, 31 Oct 2023 11:21:42 -0400
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
Message-ID: <20231031152142.GA3029315@cmpxchg.org>
References: <20231031003810.4532-1-gregory.price@memverge.com>
 <rm43wgtlvwowjolzcf6gj4un4qac4myngxqnd2jwt5yqxree62@t66scnrruttc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <rm43wgtlvwowjolzcf6gj4un4qac4myngxqnd2jwt5yqxree62@t66scnrruttc>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 31, 2023 at 10:53:41AM +0100, Michal Hocko wrote:
> On Mon 30-10-23 20:38:06, Gregory Price wrote:
> > This patchset implements weighted interleave and adds a new sysfs
> > entry: /sys/devices/system/node/nodeN/accessM/il_weight.
> > 
> > The il_weight of a node is used by mempolicy to implement weighted
> > interleave when `numactl --interleave=...` is invoked.  By default
> > il_weight for a node is always 1, which preserves the default round
> > robin interleave behavior.
> > 
> > Interleave weights may be set from 0-100, and denote the number of
> > pages that should be allocated from the node when interleaving
> > occurs.
> > 
> > For example, if a node's interleave weight is set to 5, 5 pages
> > will be allocated from that node before the next node is scheduled
> > for allocations.
> 
> I find this semantic rather weird TBH. First of all why do you think it
> makes sense to have those weights global for all users? What if
> different applications have different view on how to spred their
> interleaved memory?
> 
> I do get that you might have a different tiers with largerly different
> runtime characteristics but why would you want to interleave them into a
> single mapping and have hard to predict runtime behavior?
> 
> [...]
> > In this way it becomes possible to set an interleaving strategy
> > that fits the available bandwidth for the devices available on
> > the system. An example system:
> > 
> > Node 0 - CPU+DRAM, 400GB/s BW (200 cross socket)
> > Node 1 - CPU+DRAM, 400GB/s BW (200 cross socket)
> > Node 2 - CXL Memory. 64GB/s BW, on Node 0 root complex
> > Node 3 - CXL Memory. 64GB/s BW, on Node 1 root complex
> > 
> > In this setup, the effective weights for nodes 0-3 for a task
> > running on Node 0 may be [60, 20, 10, 10].
> > 
> > This spreads memory out across devices which all have different
> > latency and bandwidth attributes at a way that can maximize the
> > available resources.
> 
> OK, so why is this any better than not using any memory policy rely
> on demotion to push out cold memory down the tier hierarchy?
> 
> What is the actual real life usecase and what kind of benefits you can
> present?

There are two things CXL gives you: additional capacity and additional
bus bandwidth.

The promotion/demotion mechanism is good for the capacity usecase,
where you have a nice hot/cold gradient in the workingset and want
placement accordingly across faster and slower memory.

The interleaving is useful when you have a flatter workingset
distribution and poorer access locality. In that case, the CPU caches
are less effective and the workload can be bus-bound. The workload
might fit entirely into DRAM, but concentrating it there is
suboptimal. Fanning it out in proportion to the relative performance
of each memory tier gives better resuls.

We experimented with datacenter workloads on such machines last year
and found significant performance benefits:

https://lore.kernel.org/linux-mm/YqD0%2FtzFwXvJ1gK6@cmpxchg.org/T/

This hopefully also explains why it's a global setting. The usecase is
different from conventional NUMA interleaving, which is used as a
locality measure: spread shared data evenly between compute
nodes. This one isn't about locality - the CXL tier doesn't have local
compute. Instead, the optimal spread is based on hardware parameters,
which is a global property rather than a per-workload one.

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB3F97DD10E
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 16:56:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344869AbjJaP4f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 11:56:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344808AbjJaP4c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 11:56:32 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9853ADA;
        Tue, 31 Oct 2023 08:56:29 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 3B98021847;
        Tue, 31 Oct 2023 15:56:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1698767788; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kcqO6QLqoWLHFsYYNG8GZ2WufbipJ9PS9Z8s132JUF0=;
        b=PjG5beWQTeTrQUOfOjdE55R4tYzVI+HBaDqg4F9XzTIUY3xCwOvp/da4SK6M24HVLB0e4I
        y3B1VUk/LfDwQXmmeQDB2K7m7IT01FTfR7/i/tMqUhI9VRq23bieV6SV9CKvYDgAoUwfoC
        6oH5WsqCKz6cK23Mgf/Ls7Np+1d6f8Y=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 16AC2138EF;
        Tue, 31 Oct 2023 15:56:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ntLLAqwjQWUsQwAAMHmgww
        (envelope-from <mhocko@suse.com>); Tue, 31 Oct 2023 15:56:28 +0000
Date:   Tue, 31 Oct 2023 16:56:27 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Gregory Price <gourry.memverge@gmail.com>,
        linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
        linux-mm@kvack.org, ying.huang@intel.com,
        akpm@linux-foundation.org, aneesh.kumar@linux.ibm.com,
        weixugc@google.com, apopple@nvidia.com, tim.c.chen@intel.com,
        dave.hansen@intel.com, shy828301@gmail.com,
        gregkh@linuxfoundation.org, rafael@kernel.org,
        Gregory Price <gregory.price@memverge.com>
Subject: Re: [RFC PATCH v3 0/4] Node Weights and Weighted Interleave
Message-ID: <jgh5b5bm73qe7m3qmnsjo3drazgfaix3ycqmom5u6tfp6hcerj@ij4vftrutvrt>
References: <20231031003810.4532-1-gregory.price@memverge.com>
 <rm43wgtlvwowjolzcf6gj4un4qac4myngxqnd2jwt5yqxree62@t66scnrruttc>
 <20231031152142.GA3029315@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231031152142.GA3029315@cmpxchg.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 31-10-23 11:21:42, Johannes Weiner wrote:
> On Tue, Oct 31, 2023 at 10:53:41AM +0100, Michal Hocko wrote:
> > On Mon 30-10-23 20:38:06, Gregory Price wrote:
> > > This patchset implements weighted interleave and adds a new sysfs
> > > entry: /sys/devices/system/node/nodeN/accessM/il_weight.
> > > 
> > > The il_weight of a node is used by mempolicy to implement weighted
> > > interleave when `numactl --interleave=...` is invoked.  By default
> > > il_weight for a node is always 1, which preserves the default round
> > > robin interleave behavior.
> > > 
> > > Interleave weights may be set from 0-100, and denote the number of
> > > pages that should be allocated from the node when interleaving
> > > occurs.
> > > 
> > > For example, if a node's interleave weight is set to 5, 5 pages
> > > will be allocated from that node before the next node is scheduled
> > > for allocations.
> > 
> > I find this semantic rather weird TBH. First of all why do you think it
> > makes sense to have those weights global for all users? What if
> > different applications have different view on how to spred their
> > interleaved memory?
> > 
> > I do get that you might have a different tiers with largerly different
> > runtime characteristics but why would you want to interleave them into a
> > single mapping and have hard to predict runtime behavior?
> > 
> > [...]
> > > In this way it becomes possible to set an interleaving strategy
> > > that fits the available bandwidth for the devices available on
> > > the system. An example system:
> > > 
> > > Node 0 - CPU+DRAM, 400GB/s BW (200 cross socket)
> > > Node 1 - CPU+DRAM, 400GB/s BW (200 cross socket)
> > > Node 2 - CXL Memory. 64GB/s BW, on Node 0 root complex
> > > Node 3 - CXL Memory. 64GB/s BW, on Node 1 root complex
> > > 
> > > In this setup, the effective weights for nodes 0-3 for a task
> > > running on Node 0 may be [60, 20, 10, 10].
> > > 
> > > This spreads memory out across devices which all have different
> > > latency and bandwidth attributes at a way that can maximize the
> > > available resources.
> > 
> > OK, so why is this any better than not using any memory policy rely
> > on demotion to push out cold memory down the tier hierarchy?
> > 
> > What is the actual real life usecase and what kind of benefits you can
> > present?
> 
> There are two things CXL gives you: additional capacity and additional
> bus bandwidth.
> 
> The promotion/demotion mechanism is good for the capacity usecase,
> where you have a nice hot/cold gradient in the workingset and want
> placement accordingly across faster and slower memory.
> 
> The interleaving is useful when you have a flatter workingset
> distribution and poorer access locality. In that case, the CPU caches
> are less effective and the workload can be bus-bound. The workload
> might fit entirely into DRAM, but concentrating it there is
> suboptimal. Fanning it out in proportion to the relative performance
> of each memory tier gives better resuls.
> 
> We experimented with datacenter workloads on such machines last year
> and found significant performance benefits:
> 
> https://lore.kernel.org/linux-mm/YqD0%2FtzFwXvJ1gK6@cmpxchg.org/T/

Thanks, this is a useful insight.
 
> This hopefully also explains why it's a global setting. The usecase is
> different from conventional NUMA interleaving, which is used as a
> locality measure: spread shared data evenly between compute
> nodes. This one isn't about locality - the CXL tier doesn't have local
> compute. Instead, the optimal spread is based on hardware parameters,
> which is a global property rather than a per-workload one.

Well, I am not convinced about that TBH. Sure it is probably a good fit
for this specific CXL usecase but it just doesn't fit into many others I
can think of - e.g. proportional use of those tiers based on the
workload - you get what you pay for.

Is there any specific reason for not having a new interleave interface
which defines weights for the nodemask? Is this because the policy
itself is very dynamic or is this more driven by simplicity of use?

-- 
Michal Hocko
SUSE Labs

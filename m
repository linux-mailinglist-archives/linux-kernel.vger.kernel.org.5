Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E4657DE1EE
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 15:14:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232113AbjKANqB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 09:46:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230464AbjKANp7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 09:45:59 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A91983;
        Wed,  1 Nov 2023 06:45:52 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 915CE1F750;
        Wed,  1 Nov 2023 13:45:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1698846351; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LtTK0Ve9fvHJNOvzcaEqD249pBo2083iZ5qPSdDbfNg=;
        b=cUZLQ1vk/TkzkU7BO5pKe0quxSNG7qmBe1s8JS2/aMYUlbVciyDV+aH9MBvOuPLYGg2mDS
        LWfrYX3AcMP8ctmtPeBhbRv3H/OdUj7gtHR3Gw9isyYROG/aWdhcIZHGXQnooTUqPl5Hzq
        KubDIt0MzJvAMAifOl3MRxJOpZ6iMho=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6954713460;
        Wed,  1 Nov 2023 13:45:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id FdHJF49WQmWPdwAAMHmgww
        (envelope-from <mhocko@suse.com>); Wed, 01 Nov 2023 13:45:51 +0000
Date:   Wed, 1 Nov 2023 14:45:50 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Gregory Price <gregory.price@memverge.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Gregory Price <gourry.memverge@gmail.com>,
        linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
        linux-mm@kvack.org, ying.huang@intel.com,
        akpm@linux-foundation.org, aneesh.kumar@linux.ibm.com,
        weixugc@google.com, apopple@nvidia.com, tim.c.chen@intel.com,
        dave.hansen@intel.com, shy828301@gmail.com,
        gregkh@linuxfoundation.org, rafael@kernel.org
Subject: Re: [RFC PATCH v3 0/4] Node Weights and Weighted Interleave
Message-ID: <pmxrljwp4ayl3fcu7rxm6prbumgb5l3lwb75lqfipmxxxwnqfo@nb5qjcxw22gp>
References: <20231031003810.4532-1-gregory.price@memverge.com>
 <rm43wgtlvwowjolzcf6gj4un4qac4myngxqnd2jwt5yqxree62@t66scnrruttc>
 <20231031152142.GA3029315@cmpxchg.org>
 <jgh5b5bm73qe7m3qmnsjo3drazgfaix3ycqmom5u6tfp6hcerj@ij4vftrutvrt>
 <ZUCCGJgrqqk87aGN@memverge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZUCCGJgrqqk87aGN@memverge.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 31-10-23 00:27:04, Gregory Price wrote:
> On Tue, Oct 31, 2023 at 04:56:27PM +0100, Michal Hocko wrote:
> 
> > > This hopefully also explains why it's a global setting. The usecase is
> > > different from conventional NUMA interleaving, which is used as a
> > > locality measure: spread shared data evenly between compute
> > > nodes. This one isn't about locality - the CXL tier doesn't have local
> > > compute. Instead, the optimal spread is based on hardware parameters,
> > > which is a global property rather than a per-workload one.
> > 
> > Well, I am not convinced about that TBH. Sure it is probably a good fit
> > for this specific CXL usecase but it just doesn't fit into many others I
> > can think of - e.g. proportional use of those tiers based on the
> > workload - you get what you pay for.
> > 
> > Is there any specific reason for not having a new interleave interface
> > which defines weights for the nodemask? Is this because the policy
> > itself is very dynamic or is this more driven by simplicity of use?
> > 
> 
> I had originally implemented it this way while experimenting with new
> mempolicies.
> 
> https://lore.kernel.org/linux-cxl/20231003002156.740595-5-gregory.price@memverge.com/
> 
> The downside of doing it in mempolicy is...
> 1) mempolicy is not sysfs friendly, and to make it sysfs friendly is a
>    non-trivial task.  It is very "current-task" centric.

True. Cpusets is the way to make it less process centric but that comes
with its own constains (namely which NUMA policies are supported).
 
> 2) Barring a change to mempolicy to be sysfs friendly, the options for
>    implementing weights in the mempolicy are either a) new flag and
>    setting every weight individually in many syscalls, or b) a new
>    syscall (set_mempolicy2), which is what I demonstrated in the RFC.

Yes, that would likely require a new syscall.
 
> 3) mempolicy is also subject to cgroup nodemasks, and as a result you
>    end up with a rats nest of interactions between mempolicy nodemasks
>    changing as a result of cgroup migrations, nodes potentially coming
>    and going (hotplug under CXL), and others I'm probably forgetting.

Is this really any different from what you are proposing though?

>    Basically:  If a node leaves the nodemask, should you retain the
>    weight, or should you reset it? If a new node comes into the node
>    mask... what weight should you set? I did not have answers to these
>    questions.

I am not really sure I follow you. Are you talking about cpuset
nodemask changes or memory hotplug here.

> It was recommended to explore placing it in tiers instead, so I took a
> crack at it here: 
> 
> https://lore.kernel.org/linux-mm/20231009204259.875232-1-gregory.price@memverge.com/
> 
> This had similar issue with the idea of hotplug nodes: if you give a
> tier a weight, and one or more of the nodes goes away/comes back... what
> should you do with the weight?  Split it up among the remaining nodes?
> Rebalance? Etc.

How is this any different from node becoming depleted? You cannot
really expect that you get memory you are asking for and you can easily
end up getting memory from a different node instead.
 
> The result of this discussion lead us to simply say "What if we place
> the weights directly in the node".  And that lead us to this RFC.

Maybe I am missing something really crucial here but I do not see how
this fundamentally changes anything.

Memory hotremove (or mere node memory depletion) is not really a thing
because interleaving is a best effort operation so you have to live with
memory not being strictly distributed per your preferences.

Memory hotadd will be easier to manage because you just update a single
place after node is hotadded rather than gazillions partial policies.
But, that requires that interleave policy nodemask is assuming future
nodes going online and put them to the mask.

> I am not against implementing it in mempolicy (as proof: my first RFC).
> I am simply searching for the acceptable way to implement it.
> 
> One of the benefits of having it set as a global setting is that weights
> can be automatically generated from HMAT/HMEM information (ACPI tables)
> and programs already using MPOL_INTERLEAVE will have a direct benefit.

Right. This is understood. My main concern is whether this is outweights
the limitations of having a _global_ policy _only_. Historically a single
global policy usually led to finding ways how to make that more scoped
(usually through cgroups).
 
> I have been considering whether MPOL_WEIGHTED_INTERLEAVE should be added
> along side this patch so that MPOL_INTERLEAVE is left entirely alone.
> 
> Happy to discuss more,
> ~Gregory

-- 
Michal Hocko
SUSE Labs

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EFFB7E0140
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 11:31:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347698AbjKCJ4c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 05:56:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347612AbjKCJ4S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 05:56:18 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E39C6191;
        Fri,  3 Nov 2023 02:56:04 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 111421F8C0;
        Fri,  3 Nov 2023 09:56:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1699005362; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ePm7WjwbNkGtg7aZPPVJIXKZCUCupTKzceDuad9x8Qg=;
        b=Boti3rzXvIy6GpXicVmWEQvGmOFfKkcLOYxK/Vs1qx/LvOFOCNZik2CcJI4ZDtqjYPnUt9
        TUx62ElcRoAqB72miNFGbGnLgblzwKs4IHCvbfpL90O8ZapU9e3zW9je11NEo5PfW0kicP
        FhjCCXDkC1IoRZxEJR5d3903OYs8/uU=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DB32513907;
        Fri,  3 Nov 2023 09:56:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id AY2ENLHDRGUWBgAAMHmgww
        (envelope-from <mhocko@suse.com>); Fri, 03 Nov 2023 09:56:01 +0000
Date:   Fri, 3 Nov 2023 10:56:01 +0100
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
Message-ID: <s72oio7nmez565i7h6fb4bdnhqkcablr34rz5gqteyrrf7yeux@lqrztvy35si5>
References: <20231031003810.4532-1-gregory.price@memverge.com>
 <rm43wgtlvwowjolzcf6gj4un4qac4myngxqnd2jwt5yqxree62@t66scnrruttc>
 <20231031152142.GA3029315@cmpxchg.org>
 <jgh5b5bm73qe7m3qmnsjo3drazgfaix3ycqmom5u6tfp6hcerj@ij4vftrutvrt>
 <ZUCCGJgrqqk87aGN@memverge.com>
 <pmxrljwp4ayl3fcu7rxm6prbumgb5l3lwb75lqfipmxxxwnqfo@nb5qjcxw22gp>
 <ZUKDz5NpMsoyzWtZ@memverge.com>
 <a4f5das6ckw5lwj3qv2eaygx4nypb762b6mdnxivrjjndqlhjk@zpjao2ewfdoc>
 <ZUMVI4YG7mB54u0D@memverge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZUMVI4YG7mB54u0D@memverge.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 01-11-23 23:18:59, Gregory Price wrote:
> On Thu, Nov 02, 2023 at 10:47:33AM +0100, Michal Hocko wrote:
> > On Wed 01-11-23 12:58:55, Gregory Price wrote:
> > > Basically consider: `numactl --interleave=all ...`
> > > 
> > > If `--weights=...`: when a node hotplug event occurs, there is no
> > > recourse for adding a weight for the new node (it will default to 1).
> > 
> > Correct and this is what I was asking about in an earlier email. How
> > much do we really need to consider this setup. Is this something nice to
> > have or does the nature of the technology requires to be fully dynamic
> > and expect new nodes coming up at any moment?
> >  
> 
> Dynamic Capacity is expected to cause a numa node to change size (in
> number of memory blocks) rather than cause numa nodes to come and go, so
> maybe handling the full node hotplug is a bit of an overreach.
> 
> Good call, I'll stop considering this problem for now.
> 
> > > If the node is removed from the system, I believe (need to validate
> > > this, but IIRC) the node will be removed from any registered cpusets.
> > > As a result, that falls down to mempolicy, and the node is removed.
> > 
> > I do not think we do anything like that. Userspace might decide to
> > change the numa mask when a node is offlined but I do not think we do
> > anything like that automagically.
> >
> 
> mpol_rebind_policy called by update_tasks_nodemask
> https://elixir.bootlin.com/linux/latest/source/mm/mempolicy.c#L319
> https://elixir.bootlin.com/linux/latest/source/kernel/cgroup/cpuset.c#L2016
> 
> falls down from cpuset_hotplug_workfn:
> https://elixir.bootlin.com/linux/latest/source/kernel/cgroup/cpuset.c#L3771

Ohh, have missed that. Thanks for the reference. Quite honestly I am not
sure this code is really a) necessary and b) ever exercised. For the
former I would argue that offline node could be treated as completely
depleted one. From the correctness POV it shouldn't make any difference
and I am rather skeptical it would have performance improvements. And
for the latter, full node offlines are really rare from experience. I
would be interested about actual real life usecases which do that
regularly. I do remember a certain HW vendor working on a hotplugable
system (both CPUs and memory) to reduce downtimes cause by misbehaving
CPUs/memoryu. This has turned out very impractical because of movable
memory requirements and also some HW limitations (like most HW attached
to Node0 which has turned out to be single point of failure anyway).

[...]
[...]
> > Moving the global policy to cgroups would make the main cocern of
> > different workloads looking for different policy less problamatic.
> > I didn't have much time to think that through but the main question is
> > how to sanely define hierarchical properties of those weights? This is
> > more of a resource distribution than enforcement so maybe a simple
> > inherit or overwrite (if you have a more specific needs) semantic makes
> > sense and it is sufficient.
> >
> 
> As a user I would assume it would operate much the same way as other
> nested cgroups, which is inherit by default (with subsets) or an
> explicit overwrite that can't exceed the higher level settings.

This would make it rather impractical because a default (everything set
to 1) would be cast in stone. As mentioned above this this not an
enforcement limit. So I _think_ that a simple hierarchical rule like
	cgroup_interleaving_mask(cgroup)
		interleaving_mask = (cgroup->interleaving_mask) ? : cgroup_interleaving_mask(parent_cgroup(cgroup))

So child cgroups could overwrite parent as they wish. If there is any
enforcement (like a cpuset) that would filter useable nodes and the
allocation policy would simply apply weights on those.

-- 
Michal Hocko
SUSE Labs

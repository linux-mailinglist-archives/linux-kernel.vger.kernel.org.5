Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76E927DEF28
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 10:47:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345739AbjKBJrn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 05:47:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345743AbjKBJrl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 05:47:41 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FC3D13A;
        Thu,  2 Nov 2023 02:47:35 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id F1F321F896;
        Thu,  2 Nov 2023 09:47:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1698918454; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AcRP2FT5t+4MsoYnPKOmZrMF9C7uJ/RsjNWL+vm21Ko=;
        b=BrFd6PhHDUXKwKn1RMkdq/CA7tFqSbaSzq+jAzOZQt6nqnxQBY+E1AXwm9T4Hs3gNy43PN
        0TPf0aH874H8031b4/Ta1mJKrZN1WcpH8eFgJtIivom4Mgslb8Kea6CQu5x7KWbUHycRSf
        CFWPUnQMvO3RprIgNaEZ8LeS46NGBOs=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C9A9B138EC;
        Thu,  2 Nov 2023 09:47:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 9J0uLjVwQ2UHdAAAMHmgww
        (envelope-from <mhocko@suse.com>); Thu, 02 Nov 2023 09:47:33 +0000
Date:   Thu, 2 Nov 2023 10:47:33 +0100
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
Message-ID: <a4f5das6ckw5lwj3qv2eaygx4nypb762b6mdnxivrjjndqlhjk@zpjao2ewfdoc>
References: <20231031003810.4532-1-gregory.price@memverge.com>
 <rm43wgtlvwowjolzcf6gj4un4qac4myngxqnd2jwt5yqxree62@t66scnrruttc>
 <20231031152142.GA3029315@cmpxchg.org>
 <jgh5b5bm73qe7m3qmnsjo3drazgfaix3ycqmom5u6tfp6hcerj@ij4vftrutvrt>
 <ZUCCGJgrqqk87aGN@memverge.com>
 <pmxrljwp4ayl3fcu7rxm6prbumgb5l3lwb75lqfipmxxxwnqfo@nb5qjcxw22gp>
 <ZUKDz5NpMsoyzWtZ@memverge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZUKDz5NpMsoyzWtZ@memverge.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 01-11-23 12:58:55, Gregory Price wrote:
> On Wed, Nov 01, 2023 at 02:45:50PM +0100, Michal Hocko wrote:
> > On Tue 31-10-23 00:27:04, Gregory Price wrote:
> [... snip ...]
> > > 
> > > The downside of doing it in mempolicy is...
> > > 1) mempolicy is not sysfs friendly, and to make it sysfs friendly is a
> > >    non-trivial task.  It is very "current-task" centric.
> > 
> > True. Cpusets is the way to make it less process centric but that comes
> > with its own constains (namely which NUMA policies are supported).
> >  
> > > 2) Barring a change to mempolicy to be sysfs friendly, the options for
> > >    implementing weights in the mempolicy are either a) new flag and
> > >    setting every weight individually in many syscalls, or b) a new
> > >    syscall (set_mempolicy2), which is what I demonstrated in the RFC.
> > 
> > Yes, that would likely require a new syscall.
> >  
> > > 3) mempolicy is also subject to cgroup nodemasks, and as a result you
> > >    end up with a rats nest of interactions between mempolicy nodemasks
> > >    changing as a result of cgroup migrations, nodes potentially coming
> > >    and going (hotplug under CXL), and others I'm probably forgetting.
> > 
> > Is this really any different from what you are proposing though?
> >
> 
> In only one manner: An external user can set the weight of a node that
> is added later on.  If it is implemented in mempolicy, then this is not
> possible.
> 
> Basically consider: `numactl --interleave=all ...`
> 
> If `--weights=...`: when a node hotplug event occurs, there is no
> recourse for adding a weight for the new node (it will default to 1).

Correct and this is what I was asking about in an earlier email. How
much do we really need to consider this setup. Is this something nice to
have or does the nature of the technology requires to be fully dynamic
and expect new nodes coming up at any moment?
 
> Maybe the answer is "Best effort, sorry" and we don't handle that
> situation.  That doesn't seem entirely unreasonable.
> 
> At least with weights in node (or cgroup, or memtier, whatever) it
> provides the ability to set that weight outside the mempolicy context.
> 
> > >    weight, or should you reset it? If a new node comes into the node
> > >    mask... what weight should you set? I did not have answers to these
> > >    questions.
> > 
> > I am not really sure I follow you. Are you talking about cpuset
> > nodemask changes or memory hotplug here.
> >
> 
> Actually both - slightly different context.
> 
> If the weights are implemented in mempolicy, if the cpuset nodemask
> changes then the mempolicy nodemask changes with it.
> 
> If the node is removed from the system, I believe (need to validate
> this, but IIRC) the node will be removed from any registered cpusets.
> As a result, that falls down to mempolicy, and the node is removed.

I do not think we do anything like that. Userspace might decide to
change the numa mask when a node is offlined but I do not think we do
anything like that automagically.

> Not entirely sure what happens if a node is added.  The only case where
> I think that is relevant is when cpuset is empty ("all") and mempolicy
> is set to something like `--interleave=all`.  In this case, it's
> possible that the new node will simply have a default weight (1), and if
> weights are implemented in mempolicy only there is no recourse for changing
> it.

That is what I would expect.
 
[...]
> > Right. This is understood. My main concern is whether this is outweights
> > the limitations of having a _global_ policy _only_. Historically a single
> > global policy usually led to finding ways how to make that more scoped
> > (usually through cgroups).
> >
> 
> Maybe the answer here is put it in cgroups + mempolicy, and don't handle
> hotplug?  This is an easy shift my this patch to cgroups, and then
> pulling my syscall patch forward to add weights directly to mempolicy.

Moving the global policy to cgroups would make the main cocern of
different workloads looking for different policy less problamatic.
I didn't have much time to think that through but the main question is
how to sanely define hierarchical properties of those weights? This is
more of a resource distribution than enforcement so maybe a simple
inherit or overwrite (if you have a more specific needs) semantic makes
sense and it is sufficient.

> I think the interleave code stays pretty much the same, the only
> difference would be where the task gets the weight from:
> 
> if (policy->mode == WEIGHTED_INTERLEAVE)
>   weight = pol->weight[target_node]
> else
>    cgroups.get_weight(from_node, target_node)
> 
> ~Gregory

This is not as much about the code as it is about the proper interface
because that will get cast in stone once introduced. It would be really
bad to realize that we have a global policy that doesn't fit well and
have hard time to work it around without breaking anybody.
-- 
Michal Hocko
SUSE Labs

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 006CA774596
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 20:43:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233814AbjHHSnm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 14:43:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229807AbjHHSnW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 14:43:22 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1A7147DF;
        Tue,  8 Aug 2023 09:37:50 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 31FC621B9B;
        Tue,  8 Aug 2023 08:18:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1691482721; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sOStBsStITHb4ZpK/5yby6Wy7QLtGEurMTFf3fXVmi4=;
        b=TPZRoAVJGjm1dIR07dj+Ft1G0Wth/H+wEDfJL9wvwICEsnVxu2vM2NemfWX0arTkAsyq7q
        qjtvXVbHOwmj4khviWaGRqAshne9nnwh5l7mb3ai5de8Ptf1DV0Am8ILz5NNlfgDMdY4DP
        TC4Lafcb4gmZ3MyVdiSBB/ZWlnef0iM=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 04B9E139D1;
        Tue,  8 Aug 2023 08:18:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id OXTZOWD60WQadgAAMHmgww
        (envelope-from <mhocko@suse.com>); Tue, 08 Aug 2023 08:18:40 +0000
Date:   Tue, 8 Aug 2023 10:18:39 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Roman Gushchin <roman.gushchin@linux.dev>
Cc:     Chuyi Zhou <zhouchuyi@bytedance.com>, hannes@cmpxchg.org,
        ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        muchun.song@linux.dev, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, wuyun.abel@bytedance.com,
        robin.lu@bytedance.com
Subject: Re: [RFC PATCH 1/2] mm, oom: Introduce bpf_select_task
Message-ID: <ZNH6X/2ZZ0quKSI6@dhcp22.suse.cz>
References: <20230804093804.47039-1-zhouchuyi@bytedance.com>
 <20230804093804.47039-2-zhouchuyi@bytedance.com>
 <ZMzhDFhvol2VQBE4@dhcp22.suse.cz>
 <dfbf05d1-daff-e855-f4fd-e802614b79c4@bytedance.com>
 <ZMz+aBHFvfcr0oIe@dhcp22.suse.cz>
 <866462cf-6045-6239-6e27-45a733aa7daa@bytedance.com>
 <ZNCXgsZL7bKsCEBM@dhcp22.suse.cz>
 <ZNEpsUFgKFIAAgrp@P9FQF9L96D.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZNEpsUFgKFIAAgrp@P9FQF9L96D.lan>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 07-08-23 10:28:17, Roman Gushchin wrote:
> On Mon, Aug 07, 2023 at 09:04:34AM +0200, Michal Hocko wrote:
> > On Mon 07-08-23 10:21:09, Chuyi Zhou wrote:
> > > 
> > > 
> > > 在 2023/8/4 21:34, Michal Hocko 写道:
> > > > On Fri 04-08-23 21:15:57, Chuyi Zhou wrote:
> > > > [...]
> > > > > > +	switch (bpf_oom_evaluate_task(task, oc, &points)) {
> > > > > > +		case -EOPNOTSUPP: break; /* No BPF policy */
> > > > > > +		case -EBUSY: goto abort; /* abort search process */
> > > > > > +		case 0: goto next; /* ignore process */
> > > > > > +		default: goto select; /* note the task */
> > > > > > +	}
> 
> To be honest, I can't say I like it. IMO it's not really using the full bpf
> potential and is too attached to the current oom implementation.

TBH I am not sure we are able to come up with an interface that would
ise the full BPF potential at this stage and I strongly believe that we
should start by something that is good enough.

> First, I'm a bit concerned about implicit restrictions we apply to bpf programs
> which will be executed potentially thousands times under a very heavy memory
> pressure. We will need to make sure that they don't allocate (much) memory, don't
> take any locks which might deadlock with other memory allocations etc.
> It will potentially require hard restrictions on what these programs can and can't
> do and this is something that the bpf community will have to maintain long-term.

Right, BPF callbacks operating under OOM situations will be really
constrained but this is more or less by definition. Isn't it?

> Second, if we're introducing bpf here (which I'm not yet convinced),
> IMO we should use it in a more generic and expressive way.
> Instead of adding hooks into the existing oom killer implementation, we can call
> a bpf program before invoking the in-kernel oom killer and let it do whatever
> it takes to free some memory. E.g. we can provide it with an API to kill individual
> tasks as well as all tasks in a cgroup.
> This approach is more generic and will allow to solve certain problems which
> can't be solved by the current oom killer, e.g. deleting files from a tmpfs
> instead of killing tasks.

The aim of this proposal is to lift any heavy lifting steming from
iterating tasks or cgroups which those BPF might need to make a
decision. There are other ways of course and provide this iteration
functionality as library functions but my BPF experience is very limited
to say how easy is that.

> So I think the alternative approach is to provide some sort of an interface to
> pre-select oom victims in advance. E.g. on memcg level it can look like:
> 
> echo PID >> memory.oom.victim_proc

this is just a terrible interface TBH. Pids are very volatile objects.
At the time oom killer reads this pid it might be a completely different
process.

> If the list is empty, the default oom killer is invoked.
> If there are tasks, the first one is killed on OOM.
> A similar interface can exist to choose between sibling cgroups:
> 
> echo CGROUP_NAME >> memory.oom.victim_cgroup

Slightly less volatile but not much better either.

> This is just a rough idea.

I am pretty sure that both policies could be implemetd by the proposed
BPF interface though if you want something like that.
-- 
Michal Hocko
SUSE Labs

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9E207FE415
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 00:12:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343567AbjK2XL6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 18:11:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbjK2XL4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 18:11:56 -0500
Received: from out-185.mta1.migadu.com (out-185.mta1.migadu.com [95.215.58.185])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE7A4A2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 15:12:01 -0800 (PST)
Date:   Wed, 29 Nov 2023 18:11:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1701299520;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bz6GxSchlHkXU2aV4ba3kIBQOXF/boj29ncnlCvytHU=;
        b=wcLd0b+SU3Q08M7z+7e+p3ST5xtyx3lE5TeHDRElAIXAZRCPie/oUJeFa7jSIYZP1KIFDw
        OEMI1w2ReC27VoEy+nvYH4raQL+GrSzwULOn1wgD//78O4uhqRkP8fE97JrBLkErScz7AF
        M4ouptTywkbdStIdTJ4FJRTitezve88=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Roman Gushchin <roman.gushchin@linux.dev>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        Muchun Song <muchun.song@linux.dev>,
        Linux-MM <linux-mm@kvack.org>, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH 2/7] mm: shrinker: Add a .to_text() method for shrinkers
Message-ID: <20231129231147.7msiocerq7phxnyu@moria.home.lan>
References: <20231122232515.177833-3-kent.overstreet@linux.dev>
 <deed9bb1-02b9-4e89-895b-38a84e5a9408@gmail.com>
 <20231123212411.s6r5ekvkklvhwfra@moria.home.lan>
 <4caadff7-1df0-45cc-9d43-e616f9e4ddb3@bytedance.com>
 <20231125003009.tbaxuquny43uwei3@moria.home.lan>
 <76A1EE85-B62C-49B3-889C-80F9A2A88040@linux.dev>
 <20231128035345.5c7yc7jnautjpfoc@moria.home.lan>
 <abd0ddd6-389c-43dc-b18f-aa5e3a4fcf5a@bytedance.com>
 <ZWaHG09fY2BYjyGD@P9FQF9L96D.corp.robot.car>
 <ZWcBDglmDKUJdwMv@tiehlicka>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZWcBDglmDKUJdwMv@tiehlicka>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 29, 2023 at 10:14:54AM +0100, Michal Hocko wrote:
> On Tue 28-11-23 16:34:35, Roman Gushchin wrote:
> > On Tue, Nov 28, 2023 at 02:23:36PM +0800, Qi Zheng wrote:
> [...]
> > > Now I think adding this method might not be a good idea. If we allow
> > > shrinkers to report thier own private information, OOM logs may become
> > > cluttered. Most people only care about some general information when
> > > troubleshooting OOM problem, but not the private information of a
> > > shrinker.
> > 
> > I agree with that.
> > 
> > It seems that the feature is mostly useful for kernel developers and it's easily
> > achievable by attaching a bpf program to the oom handler. If it requires a bit
> > of work on the bpf side, we can do that instead, but probably not. And this
> > solution can potentially provide way more information in a more flexible way.
> > 
> > So I'm not convinced it's a good idea to make the generic oom handling code
> > more complicated and fragile for everybody, as well as making oom reports differ
> > more between kernel versions and configurations.
> 
> Completely agreed! From my many years of experience of oom reports
> analysing from production systems I would conclude the following categories
> 	- clear runaways (and/or memory leaks)
> 		- userspace consumers - either shmem or anonymous memory
> 		  predominantly consumes the memory, swap is either depleted
> 		  or not configured.
> 		  OOM report is usually useful to pinpoint those as we
> 		  have required counters available
> 		- kernel memory consumers - if we are lucky they are
> 		  using slab allocator and unreclaimable slab is a huge
> 		  part of the memory consumption. If this is a page
> 		  allocator user the oom repport only helps to deduce
> 		  the fact by looking at how much user + slab + page
> 		  table etc. form. But identifying the root cause is
> 		  close to impossible without something like page_owner
> 		  or a crash dump.
> 	- misbehaving memory reclaim
> 		- minority of issues and the oom report is usually
> 		  insufficient to drill down to the root cause. If the
> 		  problem is reproducible then collecting vmstat data
> 		  can give a much better clue.
> 		- high number of slab reclaimable objects or free swap
> 		  are good indicators. Shrinkers data could be
> 		  potentially helpful in the slab case but I really have
> 		  hard time to remember any such situation.
> On non-production systems the situation is quite different. I can see
> how it could be very beneficial to add a very specific debugging data
> for subsystem/shrinker which is developed and could cause the OOM. For
> that purpose the proposed scheme is rather inflexible AFAICS.

Considering that you're an MM guy, and that shrinkers are pretty much
universally used by _filesystem_ people - I'm not sure your experience
is the most relevant here?

The general attitude I've been seeing in this thread has been one of
dismissiveness towards filesystem people. Roman too; back when he was
working on his shrinker debug feature I reached out to him, explained
that I was working on my own, and asked about collaborating - got
crickets in response...

Hmm..

Besides that, I haven't seen anything what-so-ever out of you guys to
make our lives easier, regarding OOM debugging, nor do you guys even
seem interested in the needs and perspectives of the filesytem people.
Roman, your feature didn't help one bit for OOM debuging - didn't even
come with documentation or hints as to what it's for.

BPF? Please.

Anyways.

Regarding log spam: that's something this patchset already starts to
address. I don't think we needed to be dumping every single slab in the
system, for ~2 pages worth of logs; hence this patchset changes that to
just print the top 10.

The same approach is taken with shrinkers: more targeted, less spammy
output.

So now that that concern has been addressed, perhaps some actual meat:

For one, the patchset adds tracking for when a shrinker was last asked
to free something, vs. when it was actually freed. So right there, we
can finally see at a glance when a shrinker has gotten stuck and which
one.

Next up, why has a shrinker gotten stuck?

That's why the .to_text() callback is needed: _shrinkers have internal
state_, and the reasons objects may not be getting freed are specific to
a given shrinker implementation. In bcachefs we added counters for each
individual reason an object may be skipped by the shrinker (io in
flight? that debugged a runaway prefetch issue. too many dirty? that
points to journal reclaim).

I'm working on a .to_text() function for the struct super_block
shrinker, will post that one soon...

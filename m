Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF1817FE79E
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 04:22:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344173AbjK3DVy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 22:21:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230393AbjK3DVw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 22:21:52 -0500
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [IPv6:2001:41d0:1004:224b::b3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71BD2C4
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 19:21:57 -0800 (PST)
Date:   Wed, 29 Nov 2023 22:21:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1701314514;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Czmn18gjTSfWVrvUGKkcFDp26hQvPKQD/bldcWkParM=;
        b=fUgDpF8gwjCohOrHWhracPL13JiJvWhq2tX5EVWyxGYN+FO8FaI/C6yOY97/y4c9Ud67QF
        aEUgxHzMtYe2uFDpNfPAzTG64JlQSDyrRri6UkXTfMdA2KOq3VZKcYgZt15rJTH+lMDYXO
        PymIfltyDoAY22RtOQMx8rzpIOLoaZE=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     Qi Zheng <zhengqi.arch@bytedance.com>
Cc:     Michal Hocko <mhocko@suse.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <muchun.song@linux.dev>,
        Linux-MM <linux-mm@kvack.org>, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH 2/7] mm: shrinker: Add a .to_text() method for shrinkers
Message-ID: <20231130032149.ynap4ai47dj62fy3@moria.home.lan>
References: <20231123212411.s6r5ekvkklvhwfra@moria.home.lan>
 <4caadff7-1df0-45cc-9d43-e616f9e4ddb3@bytedance.com>
 <20231125003009.tbaxuquny43uwei3@moria.home.lan>
 <76A1EE85-B62C-49B3-889C-80F9A2A88040@linux.dev>
 <20231128035345.5c7yc7jnautjpfoc@moria.home.lan>
 <abd0ddd6-389c-43dc-b18f-aa5e3a4fcf5a@bytedance.com>
 <ZWaHG09fY2BYjyGD@P9FQF9L96D.corp.robot.car>
 <ZWcBDglmDKUJdwMv@tiehlicka>
 <20231129231147.7msiocerq7phxnyu@moria.home.lan>
 <04f63966-af72-43ef-a65c-ff927064a3e4@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <04f63966-af72-43ef-a65c-ff927064a3e4@bytedance.com>
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

On Thu, Nov 30, 2023 at 11:09:42AM +0800, Qi Zheng wrote:
> 
> 
> On 2023/11/30 07:11, Kent Overstreet wrote:
> > On Wed, Nov 29, 2023 at 10:14:54AM +0100, Michal Hocko wrote:
> > > On Tue 28-11-23 16:34:35, Roman Gushchin wrote:
> > > > On Tue, Nov 28, 2023 at 02:23:36PM +0800, Qi Zheng wrote:
> > > [...]
> > > > > Now I think adding this method might not be a good idea. If we allow
> > > > > shrinkers to report thier own private information, OOM logs may become
> > > > > cluttered. Most people only care about some general information when
> > > > > troubleshooting OOM problem, but not the private information of a
> > > > > shrinker.
> > > > 
> > > > I agree with that.
> > > > 
> > > > It seems that the feature is mostly useful for kernel developers and it's easily
> > > > achievable by attaching a bpf program to the oom handler. If it requires a bit
> > > > of work on the bpf side, we can do that instead, but probably not. And this
> > > > solution can potentially provide way more information in a more flexible way.
> > > > 
> > > > So I'm not convinced it's a good idea to make the generic oom handling code
> > > > more complicated and fragile for everybody, as well as making oom reports differ
> > > > more between kernel versions and configurations.
> > > 
> > > Completely agreed! From my many years of experience of oom reports
> > > analysing from production systems I would conclude the following categories
> > > 	- clear runaways (and/or memory leaks)
> > > 		- userspace consumers - either shmem or anonymous memory
> > > 		  predominantly consumes the memory, swap is either depleted
> > > 		  or not configured.
> > > 		  OOM report is usually useful to pinpoint those as we
> > > 		  have required counters available
> > > 		- kernel memory consumers - if we are lucky they are
> > > 		  using slab allocator and unreclaimable slab is a huge
> > > 		  part of the memory consumption. If this is a page
> > > 		  allocator user the oom repport only helps to deduce
> > > 		  the fact by looking at how much user + slab + page
> > > 		  table etc. form. But identifying the root cause is
> > > 		  close to impossible without something like page_owner
> > > 		  or a crash dump.
> > > 	- misbehaving memory reclaim
> > > 		- minority of issues and the oom report is usually
> > > 		  insufficient to drill down to the root cause. If the
> > > 		  problem is reproducible then collecting vmstat data
> > > 		  can give a much better clue.
> > > 		- high number of slab reclaimable objects or free swap
> > > 		  are good indicators. Shrinkers data could be
> > > 		  potentially helpful in the slab case but I really have
> > > 		  hard time to remember any such situation.
> > > On non-production systems the situation is quite different. I can see
> > > how it could be very beneficial to add a very specific debugging data
> > > for subsystem/shrinker which is developed and could cause the OOM. For
> > > that purpose the proposed scheme is rather inflexible AFAICS.
> > 
> > Considering that you're an MM guy, and that shrinkers are pretty much
> > universally used by _filesystem_ people - I'm not sure your experience
> > is the most relevant here?
> > 
> > The general attitude I've been seeing in this thread has been one of
> > dismissiveness towards filesystem people. Roman too; back when he was
> 
> Oh, please don't say that, it seems like you are the only one causing
> the fight. We deeply respect the opinions of file system developers, so
> I invited Dave to this thread from the beginning. And you didn’t CC
> linux-fsdevel@vger.kernel.org yourself.
> 
> > working on his shrinker debug feature I reached out to him, explained
> > that I was working on my own, and asked about collaborating - got
> > crickets in response...
> > 
> > Hmm..
> > 
> > Besides that, I haven't seen anything what-so-ever out of you guys to
> > make our lives easier, regarding OOM debugging, nor do you guys even
> > seem interested in the needs and perspectives of the filesytem people.
> > Roman, your feature didn't help one bit for OOM debuging - didn't even
> > come with documentation or hints as to what it's for.
> > 
> > BPF? Please.
> 
> (Disclaimer, no intention to start a fight, here are some objective
> views.)
> 
> Why not? In addition to printk, there are many good debugging tools
> worth trying, such as BPF related tools, drgn, etc.
> 
> For non-bcachefs developers, who knows what those statistics mean?
> 
> You can use BPF or drgn to traverse in advance to get the address of the
> bcachefs shrinker structure, and then during OOM, find the bcachefs
> private structure through the shrinker->private_data member, and then
> dump the bcachefs private data. Is there any problem with this?

No, BPF is not an excuse for improving our OOM/allocation failure
reports. BPF/tracing are secondary tools; whenever we're logging
information about a problem we should strive to log enough information
to debug the issue.

We've got junk in there we don't need: as mentioned before, there's no
need to be dumping information on _every_ slab, we can pick the ones
using the most memory and show those.

Similarly for shrinkers, we're not going to be printing all of them -
the patchset picks the top 10 by objects and prints those. Could
probably be ~4, there's fewer shrinkers than slabs; also if we can get
shrinkers to report on memory owned in bytes, that will help too with
deciding what information is pertinent.

That's not a huge amount of information to be dumping, and to make it
easier to debug something that has historically been a major pain point.

There's a lot more that could be done to make our OOM reports more
readable and useful to non-mm developers. Unfortunately, any time
changing the show_mem report the immediate reaction seems to be "but
that will break my log parsing/change what I'm used to!"...

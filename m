Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B11798013D8
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 21:01:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379575AbjLAUBk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 15:01:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379550AbjLAUBi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 15:01:38 -0500
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [IPv6:2001:41d0:1004:224b::b7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 429E695
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 12:01:41 -0800 (PST)
Date:   Fri, 1 Dec 2023 12:01:33 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1701460898;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=L4EsUjCpDqR5ukRbUrdGLVdW+brLvnqNkoJINxDTUj4=;
        b=imM9s+0UUfzimqJ8u6k96q03kHMIRBQOgk5f45b7nxNLxLWwGy/XhsfjLsd4SIikXhSdPg
        Mx7ovIdRCZz9QgY6LMils28s6R6uBRdlmfUCTISH4vw315Z0la9owPgNYDmBqfpGn9GpKc
        5KZwnG40OoqDZPcOv/k5NWqbO9oSEOA=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Roman Gushchin <roman.gushchin@linux.dev>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Kent Overstreet <kent.overstreet@linux.dev>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        Michal Hocko <mhocko@suse.com>,
        Muchun Song <muchun.song@linux.dev>,
        Linux-MM <linux-mm@kvack.org>, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 2/7] mm: shrinker: Add a .to_text() method for shrinkers
Message-ID: <ZWo7ncdgPsj6rP7_@P9FQF9L96D.corp.robot.car>
References: <76A1EE85-B62C-49B3-889C-80F9A2A88040@linux.dev>
 <20231128035345.5c7yc7jnautjpfoc@moria.home.lan>
 <abd0ddd6-389c-43dc-b18f-aa5e3a4fcf5a@bytedance.com>
 <ZWaHG09fY2BYjyGD@P9FQF9L96D.corp.robot.car>
 <ZWcBDglmDKUJdwMv@tiehlicka>
 <20231129231147.7msiocerq7phxnyu@moria.home.lan>
 <04f63966-af72-43ef-a65c-ff927064a3e4@bytedance.com>
 <20231130032149.ynap4ai47dj62fy3@moria.home.lan>
 <ZWjcA4BA5vZe57Eh@P9FQF9L96D.corp.robot.car>
 <ZWk0dI0PISWBbbKr@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZWk0dI0PISWBbbKr@dread.disaster.area>
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

On Fri, Dec 01, 2023 at 12:18:44PM +1100, Dave Chinner wrote:
> On Thu, Nov 30, 2023 at 11:01:23AM -0800, Roman Gushchin wrote:
> > On Wed, Nov 29, 2023 at 10:21:49PM -0500, Kent Overstreet wrote:
> > > On Thu, Nov 30, 2023 at 11:09:42AM +0800, Qi Zheng wrote:
> > > > For non-bcachefs developers, who knows what those statistics mean?
> 
> > Ok, a simple question then:
> > why can't you dump /proc/slabinfo after the OOM?
> 
> Taken to it's logical conclusion, we arrive at:
> 
> 	OOM-kill doesn't need to output anything at all except for
> 	what it killed because we can dump
> 	/proc/{mem,zone,vmalloc,buddy,slab}info after the OOM....
> 
> As it is, even asking such a question shows that you haven't looked
> at the OOM kill output for a long time - it already reports the slab
> cache usage information for caches that are reclaimable.
> 
> That is, if too much accounted slab cache based memory consumption
> is detected at OOM-kill, it will calldump_unreclaimable_slab() to
> dump all the SLAB_RECLAIM_ACCOUNT caches (i.e. those with shrinkers)
> to the console as part of the OOM-kill output.

You are right, I missed that, partially because most of OOM's I had to deal
with recently were memcg OOM's.

This changes my perspective at Kent's patches, if we dump this information
already, it might be not a bad idea to do it nicer. So I take my words back
here.

> 
> The problem Kent is trying to address is that this output *isn't
> sufficient to debug shrinker based memory reclaim issues*. It hasn't
> been for a long time, and so we've all got our own special debug
> patches and methods for checking that shrinkers are doing what they
> are supposed to. Kent is trying to formalise one of the more useful
> general methods for exposing that internal information when OOM
> occurs...
> 
> Indeed, I can think of several uses for a shrinker->to_text() output
> that we simply cannot do right now.
> 
> Any shrinker that does garbage collection on something that is not a
> pure slab cache (e.g. xfs buffer cache, xfs inode gc subsystem,
> graphics memory allocators, binder, etc) has no visibility of the
> actuall memory being used by the subsystem in the OOM-kill output.
> This information isn't in /proc/slabinfo, it's not accounted by a
> SLAB_RECLAIM_ACCOUNT cache, and it's not accounted by anything in
> the core mm statistics.
> 
> e.g. How does anyone other than a XFS expert know that the 500k of
> active xfs_buf handles in the slab cache actually pins 15GB of
> cached metadata allocated directly from the page allocator, not just
> the 150MB of slab cache the handles take up?
> 
> Another example is that an inode can pin lots of heap memory (e.g.
> for in-memory extent lists) and that may not be freeable until the
> inode is reclaimed. So while the slab cache might not be excesively
> large, we might have an a million inodes with a billion cumulative
> extents cached in memory and it is the heap memory consumed by the
> cached extents that is consuming the 30GB of "missing" kernel memory
> that is causing OOM-kills to occur.
> 
> How is a user or developer supposed to know when one of these
> situations has occurred given the current lack of memory usage
> introspection into subsystems?

What would be the proper solution to this problem from your point of view?
What functionality/API mm can provide to make the life of fs developers
better here?

> 
> These are the sorts of situations that shrinker->to_text() would
> allow us to enumerate when it is necessary (i.e. at OOM-kill). At
> any other time, it just doesn't matter, but when we're at OOM having
> a mechanism to report somewhat accurate subsystem memory consumption
> would be very useful indeed.
> 
> > Unlike anon memory, slab memory (fs caches in particular) should not be heavily
> > affected by killing some userspace task.
> 
> Whether tasks get killed or not is completely irrelevant. The issue
> is that not all memory that is reclaimed by shrinkers is either pure
> slab cache memory or directly accounted as reclaimable to the mm
> subsystem....

My problem with the current OOM reporting infrastructure (and it's a bit an
offtopic here) - it's good for manually looking into these reports, but not
particularly great for automatic collection and analysis at scale.
So this is where I was coming from.

Thanks!

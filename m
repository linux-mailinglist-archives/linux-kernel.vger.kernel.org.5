Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86ACC8000E4
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 02:18:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229578AbjLABSn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 20:18:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjLABSl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 20:18:41 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC22610D1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 17:18:47 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id 41be03b00d2f7-5c6001ec920so29479a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 17:18:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1701393527; x=1701998327; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=g/48m46wPgyvqnD4XpgC0rhUYtIZ3FOXv9eiG/yAP/4=;
        b=vquECw7LY7U9wZ9FGmu3KeuJE3PL9M7XK5Vv2/ry21FXNE0FxvzdJtqqbmV/CLd6RX
         dnphUPkzvzOZyUAyUUWtS/+idD1AdtVS75iGTTLGGMmS7I90zYd/nqC8xnzJWwhaosG+
         qaM2m187eZZlR2S/uYpewt09kuenGgBjILN7rN80LMoVJlQqV/W9WI+3+40Jn8mFKotL
         p+HnBWf8F4gE5+KWBHfPF8fLesSXlFR3YGrTZ/yNEREG9pQB3rssM58qWejN4mSM3Kkw
         BxfD+2uKTfTAUw3y+0z1hljulAnkgGaAz2rSi1a46kDgVoA5Hbf15EnEsacP6IPyTbO+
         zqCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701393527; x=1701998327;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g/48m46wPgyvqnD4XpgC0rhUYtIZ3FOXv9eiG/yAP/4=;
        b=QnDl2yNIuSKkQ5uztWgio8FnKrHPNodreHlrRzAt9HdOH6nkbtI79qhS5EGkUYJ757
         VbPmh6jlAZXobFJm3iJ+u/FSAQ383386yzcMQYulKIK9d1sZFv0hYRshZ3r1aYVRaiDj
         d4WNBKZvR0vwz0aMhmTbaynj8/okHpgOH69Bc0cHMDYXtCOkAWwBBtLdxj9I4T0jHeJM
         qACDvNjHgFTRrbg+sbeRvRwyna1xSIrL/795Av1Nu2Gz4MovEpOiHxlVvgSHG7jYNm3Q
         g2tf4cUEgfb9k7pGwLSPMzI/Lcu+LnbZ3x3/p//rGvbZUmnLaOzGII8XNAtwLx+Wq+Nl
         aYUw==
X-Gm-Message-State: AOJu0Yz/IsV0VdDKaf78peFmYDjEKyVav3NIVYOa05Vc+NYwjl8Kifc3
        Z1NssZF5T6RuQD4OLhM5B0cldw==
X-Google-Smtp-Source: AGHT+IFbXpDmkQrMsVjyH2MbAdXUl/hHHiinDnOdNUwvXQkqgibcLnsfNxUrQES1AUWkmrI2vqAZ7g==
X-Received: by 2002:a05:6a20:daaa:b0:187:c662:9b7e with SMTP id iy42-20020a056a20daaa00b00187c6629b7emr24458515pzb.25.1701393527121;
        Thu, 30 Nov 2023 17:18:47 -0800 (PST)
Received: from dread.disaster.area (pa49-180-125-5.pa.nsw.optusnet.com.au. [49.180.125.5])
        by smtp.gmail.com with ESMTPSA id hq23-20020a056a00681700b006cddd9d0174sm1843768pfb.108.2023.11.30.17.18.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 17:18:46 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.96)
        (envelope-from <david@fromorbit.com>)
        id 1r8sB2-002C0s-0T;
        Fri, 01 Dec 2023 12:18:44 +1100
Date:   Fri, 1 Dec 2023 12:18:44 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Roman Gushchin <roman.gushchin@linux.dev>
Cc:     Kent Overstreet <kent.overstreet@linux.dev>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        Michal Hocko <mhocko@suse.com>,
        Muchun Song <muchun.song@linux.dev>,
        Linux-MM <linux-mm@kvack.org>, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 2/7] mm: shrinker: Add a .to_text() method for shrinkers
Message-ID: <ZWk0dI0PISWBbbKr@dread.disaster.area>
References: <20231125003009.tbaxuquny43uwei3@moria.home.lan>
 <76A1EE85-B62C-49B3-889C-80F9A2A88040@linux.dev>
 <20231128035345.5c7yc7jnautjpfoc@moria.home.lan>
 <abd0ddd6-389c-43dc-b18f-aa5e3a4fcf5a@bytedance.com>
 <ZWaHG09fY2BYjyGD@P9FQF9L96D.corp.robot.car>
 <ZWcBDglmDKUJdwMv@tiehlicka>
 <20231129231147.7msiocerq7phxnyu@moria.home.lan>
 <04f63966-af72-43ef-a65c-ff927064a3e4@bytedance.com>
 <20231130032149.ynap4ai47dj62fy3@moria.home.lan>
 <ZWjcA4BA5vZe57Eh@P9FQF9L96D.corp.robot.car>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZWjcA4BA5vZe57Eh@P9FQF9L96D.corp.robot.car>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 30, 2023 at 11:01:23AM -0800, Roman Gushchin wrote:
> On Wed, Nov 29, 2023 at 10:21:49PM -0500, Kent Overstreet wrote:
> > On Thu, Nov 30, 2023 at 11:09:42AM +0800, Qi Zheng wrote:
> > > For non-bcachefs developers, who knows what those statistics mean?

For non-mm developers, who knows what those internal mm state
statistics mean?

IOWs, a non-mm developer goes and asks a mm developer to
help them decipher the output to determine what to do next.

So why can't a mm developer go an ask a subsystem developer to tell
them what the shrinker oom-kill output means?

Such a question is a demonstration of an unconscious bias
that prioritises internal mm stuff as far more important than what
anyone else outside core-mm might ever need...

> > > You can use BPF or drgn to traverse in advance to get the address of the
> > > bcachefs shrinker structure, and then during OOM, find the bcachefs
> > > private structure through the shrinker->private_data member, and then
> > > dump the bcachefs private data. Is there any problem with this?
> > 
> > No, BPF is not an excuse for improving our OOM/allocation failure
> > reports. BPF/tracing are secondary tools; whenever we're logging
> > information about a problem we should strive to log enough information
> > to debug the issue.
> 
> Ok, a simple question then:
> why can't you dump /proc/slabinfo after the OOM?

Taken to it's logical conclusion, we arrive at:

	OOM-kill doesn't need to output anything at all except for
	what it killed because we can dump
	/proc/{mem,zone,vmalloc,buddy,slab}info after the OOM....

As it is, even asking such a question shows that you haven't looked
at the OOM kill output for a long time - it already reports the slab
cache usage information for caches that are reclaimable.

That is, if too much accounted slab cache based memory consumption
is detected at OOM-kill, it will calldump_unreclaimable_slab() to
dump all the SLAB_RECLAIM_ACCOUNT caches (i.e. those with shrinkers)
to the console as part of the OOM-kill output.

The problem Kent is trying to address is that this output *isn't
sufficient to debug shrinker based memory reclaim issues*. It hasn't
been for a long time, and so we've all got our own special debug
patches and methods for checking that shrinkers are doing what they
are supposed to. Kent is trying to formalise one of the more useful
general methods for exposing that internal information when OOM
occurs...

Indeed, I can think of several uses for a shrinker->to_text() output
that we simply cannot do right now.

Any shrinker that does garbage collection on something that is not a
pure slab cache (e.g. xfs buffer cache, xfs inode gc subsystem,
graphics memory allocators, binder, etc) has no visibility of the
actuall memory being used by the subsystem in the OOM-kill output.
This information isn't in /proc/slabinfo, it's not accounted by a
SLAB_RECLAIM_ACCOUNT cache, and it's not accounted by anything in
the core mm statistics.

e.g. How does anyone other than a XFS expert know that the 500k of
active xfs_buf handles in the slab cache actually pins 15GB of
cached metadata allocated directly from the page allocator, not just
the 150MB of slab cache the handles take up?

Another example is that an inode can pin lots of heap memory (e.g.
for in-memory extent lists) and that may not be freeable until the
inode is reclaimed. So while the slab cache might not be excesively
large, we might have an a million inodes with a billion cumulative
extents cached in memory and it is the heap memory consumed by the
cached extents that is consuming the 30GB of "missing" kernel memory
that is causing OOM-kills to occur.

How is a user or developer supposed to know when one of these
situations has occurred given the current lack of memory usage
introspection into subsystems?

These are the sorts of situations that shrinker->to_text() would
allow us to enumerate when it is necessary (i.e. at OOM-kill). At
any other time, it just doesn't matter, but when we're at OOM having
a mechanism to report somewhat accurate subsystem memory consumption
would be very useful indeed.

> Unlike anon memory, slab memory (fs caches in particular) should not be heavily
> affected by killing some userspace task.

Whether tasks get killed or not is completely irrelevant. The issue
is that not all memory that is reclaimed by shrinkers is either pure
slab cache memory or directly accounted as reclaimable to the mm
subsystem....

-Dave.

-- 
Dave Chinner
david@fromorbit.com

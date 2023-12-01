Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6C56800136
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 02:47:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376403AbjLABru (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 20:47:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231336AbjLABrr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 20:47:47 -0500
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [IPv6:2001:41d0:203:375::ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6878A10F9
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 17:47:51 -0800 (PST)
Date:   Thu, 30 Nov 2023 20:47:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1701395269;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8DNjgQTchLvLaDKKz+PNTn+XS4o7e4vJLhgx6og08P4=;
        b=o8YvlnA5l55Q9Ne/lUb4wsf0ptcUzWPg0sgakcZYsq3+PNkQO3OqqADFyBDPVNf+hv854M
        UC/aM89sl+wHb+1yrATfQamrdemNYZQyGoWOc/OtFxYFHfUbeuztiYfWIhuR+fEIrJomWJ
        lb7PC4NIkOOT5O++btN59GCGwcBfgCM=
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
Message-ID: <20231201014745.b2ud4w3ymztdtctu@moria.home.lan>
References: <20231123212411.s6r5ekvkklvhwfra@moria.home.lan>
 <4caadff7-1df0-45cc-9d43-e616f9e4ddb3@bytedance.com>
 <20231125003009.tbaxuquny43uwei3@moria.home.lan>
 <76A1EE85-B62C-49B3-889C-80F9A2A88040@linux.dev>
 <20231128035345.5c7yc7jnautjpfoc@moria.home.lan>
 <abd0ddd6-389c-43dc-b18f-aa5e3a4fcf5a@bytedance.com>
 <ZWaHG09fY2BYjyGD@P9FQF9L96D.corp.robot.car>
 <ZWcBDglmDKUJdwMv@tiehlicka>
 <20231129231147.7msiocerq7phxnyu@moria.home.lan>
 <ZWhEawxI1CT8stu9@tiehlicka>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZWhEawxI1CT8stu9@tiehlicka>
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

On Thu, Nov 30, 2023 at 09:14:35AM +0100, Michal Hocko wrote:
> On Wed 29-11-23 18:11:47, Kent Overstreet wrote:
> > Considering that you're an MM guy, and that shrinkers are pretty much
> > universally used by _filesystem_ people - I'm not sure your experience
> > is the most relevant here?
> 
> I really do not understand where you have concluded that. In those years
> of analysis I was not debugging my _own_ code. I was dealing with
> customer reports and I would not really blame them to specifically
> trigger any class of OOM reports.

I've also spent a considerable amount of time debugging OOM issues, and
a lot of that took a lot longer than it should of due to insufficient
visibility in what the system was doing.

I'm talking about things like tuning journal reclaim/writeback behaviour
(this is a tricky one! shrinkers can't shrink if all items are dirty,
but random update workloads really suffer if we're biasing too much in
favour of memory reclaim, i.e. limiting dirty ratio too much), or
debugging tests in fstests that really like to exhaust memory on just
the inode cache.

If you can take the time to understand what other people are trying to
do and share your own perspective on what you find useful -  instead of
just saying "I've spent a lot of time on OOM reports and I haven't need
any of this/this is just for debugging" - we'll be able to have a much
more productive discussion.

Regarding another point you guys have been making - that this is "just
for developers debugging their own code" - that's a terribly dismissive
attitude to take as well.

Debugging doesn't stop when we're done testing the code on our local
machine and push it out to be merged; we're constantly debugging our
own code as it is running in the wild based on sparse bug reports with
at most a dmesg log. That dmesg log needs to, whenever possible, have
all the information we need to debug the issue.

In bcachefs, I have made this principle a _high_ priority; when I have a
bug in front of me, if there's visibility improvements that would make
the issue easier to debug I prioritize that _first_, and then fix the
actual bug. That's been one of the guiding principles that have enabled
me to work efficiently.

Code should tell you _what_ went wrong when something goes wrong,
whenever possible. Not just for ourselves, the individual developer, it
makes our code more maintainable by the people tha come after us.

> > For one, the patchset adds tracking for when a shrinker was last asked
> > to free something, vs. when it was actually freed. So right there, we
> > can finally see at a glance when a shrinker has gotten stuck and which
> > one.
> 
> The primary problem I have with this is how to decide whether to dump
> shrinker data and/or which shrinkers to mention. How do you know that it
> is the specific shrinker which has contributed to the OOM state?
> Printing that data unconditionally will very likely be just additional
> balast in most production situations. Sure if you are doing a filesystem
> development and you are tuning your specific shrinker then this might be
> a really important information to have. But then it is a debugging devel
> tool rather than something we want or need to have in a generic oom
> report.

Like I've mentioned before, this patchset only reports on the top 10
shrinkers, by number of objects. If we can plumb through reporting on
memory usage in _bytes_, that would help even more with deciding what to
report on.

> All that being said, I am with you on the fact that the oom report in
> its current form could see improvements.

I'm glad we're finally in agreement on something!

If you want to share your own ideas on what could be improved and what
you find useful, maybe we could find some more common ground.

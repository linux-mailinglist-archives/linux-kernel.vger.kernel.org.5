Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A88D480154A
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 22:25:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230526AbjLAVZK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 16:25:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjLAVZI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 16:25:08 -0500
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [IPv6:2001:41d0:1004:224b::b2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 085FF10DF
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 13:25:12 -0800 (PST)
Date:   Fri, 1 Dec 2023 16:25:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1701465910;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YSgoe7iZYKiPM6BcayB3V39+srzlSNOnYElv/By5ffY=;
        b=gc6yl/ztFUNQwfobq42K6NCtYZpPRWQcxOzOmE7jxwtoeLHyrvyMd+3AawaE+RRDfsI+oa
        x1nSJ9mFZ06h1JB/74dFCH94XCysnPMjaOJvykGEEygt3xpwKrkU386cB3+AAuje8cgRk1
        pKuqNn/erKapz5JzDwV9+5fVCMmiyos=
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
Message-ID: <20231201212506.skgzaoafi5zgi3pi@moria.home.lan>
References: <20231125003009.tbaxuquny43uwei3@moria.home.lan>
 <76A1EE85-B62C-49B3-889C-80F9A2A88040@linux.dev>
 <20231128035345.5c7yc7jnautjpfoc@moria.home.lan>
 <abd0ddd6-389c-43dc-b18f-aa5e3a4fcf5a@bytedance.com>
 <ZWaHG09fY2BYjyGD@P9FQF9L96D.corp.robot.car>
 <ZWcBDglmDKUJdwMv@tiehlicka>
 <20231129231147.7msiocerq7phxnyu@moria.home.lan>
 <ZWhEawxI1CT8stu9@tiehlicka>
 <20231201014745.b2ud4w3ymztdtctu@moria.home.lan>
 <ZWmvp5Yeb5HE1Uxo@tiehlicka>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZWmvp5Yeb5HE1Uxo@tiehlicka>
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

On Fri, Dec 01, 2023 at 11:04:23AM +0100, Michal Hocko wrote:
> On Thu 30-11-23 20:47:45, Kent Overstreet wrote:
> > On Thu, Nov 30, 2023 at 09:14:35AM +0100, Michal Hocko wrote:
> [...]
> > > All that being said, I am with you on the fact that the oom report in
> > > its current form could see improvements.
> > 
> > I'm glad we're finally in agreement on something!
> > 
> > If you want to share your own ideas on what could be improved and what
> > you find useful, maybe we could find some more common ground.
> 
> One thing that I would consider an improvement is to have a way to
> subscribe drivers with excessive memory consumption or those which are
> struggling to dump their state.

Remember the memory allocation profiling patchset? The one where you
kept complaining about "maintenancy overhead"?

We can plug that into the show_mem report too, and list the top 10
allocations by file and line number.

> Maybe your proposal can be extended that way but the crucial point is to
> not dump all sorts of random shrinkers' state and end up with unwieldy
> reports.  If, on the other hand, any particular shrinker struggles to
> reclaim memory and it is sitting on a lot of memory it could be able to
> flag itself to be involved in the dump.

Great, since as was mentioned in the original commit message it's not
"all sorts of random shrinkers", but top 10 by objects reported, what
I've got here should make you happy.

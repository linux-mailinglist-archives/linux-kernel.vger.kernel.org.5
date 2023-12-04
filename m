Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D28C803C95
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 19:16:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231954AbjLDSPz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 13:15:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231783AbjLDSPx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 13:15:53 -0500
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3E0BCA
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 10:15:58 -0800 (PST)
Date:   Mon, 4 Dec 2023 13:15:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1701713756;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xC4jCVvT+IFQ6qX/7Rd+v3ZG1sbqYN9jp27m45RKW54=;
        b=UInPrONmCV4wOdcNrtM+3QKuViLTgz3GTf2O+imE34q5jZJZWmag47hsLh1rGFQh7N2A06
        qITVIBE9zgAidF9KNEnWUrz6bRgzRRoe3BTqo51XOnC76bY3uIRfgfkCLdOdLu2FtAAIVG
        r8ZFMCosxb6H6BFvH3WEvhQCnFDR3MI=
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
Message-ID: <20231204181553.tyxeq7zy54cuc3o7@moria.home.lan>
References: <20231128035345.5c7yc7jnautjpfoc@moria.home.lan>
 <abd0ddd6-389c-43dc-b18f-aa5e3a4fcf5a@bytedance.com>
 <ZWaHG09fY2BYjyGD@P9FQF9L96D.corp.robot.car>
 <ZWcBDglmDKUJdwMv@tiehlicka>
 <20231129231147.7msiocerq7phxnyu@moria.home.lan>
 <ZWhEawxI1CT8stu9@tiehlicka>
 <20231201014745.b2ud4w3ymztdtctu@moria.home.lan>
 <ZWmvp5Yeb5HE1Uxo@tiehlicka>
 <20231201212506.skgzaoafi5zgi3pi@moria.home.lan>
 <ZW2q6GAanaogxCSV@tiehlicka>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZW2q6GAanaogxCSV@tiehlicka>
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

On Mon, Dec 04, 2023 at 11:33:12AM +0100, Michal Hocko wrote:
> On Fri 01-12-23 16:25:06, Kent Overstreet wrote:
> > On Fri, Dec 01, 2023 at 11:04:23AM +0100, Michal Hocko wrote:
> > > On Thu 30-11-23 20:47:45, Kent Overstreet wrote:
> > > > On Thu, Nov 30, 2023 at 09:14:35AM +0100, Michal Hocko wrote:
> > > [...]
> > > > > All that being said, I am with you on the fact that the oom report in
> > > > > its current form could see improvements.
> > > > 
> > > > I'm glad we're finally in agreement on something!
> > > > 
> > > > If you want to share your own ideas on what could be improved and what
> > > > you find useful, maybe we could find some more common ground.
> > > 
> > > One thing that I would consider an improvement is to have a way to
> > > subscribe drivers with excessive memory consumption or those which are
> > > struggling to dump their state.
> > 
> > Remember the memory allocation profiling patchset? The one where you
> > kept complaining about "maintenancy overhead"?
> 
> Yes, I still maintain my opinion on that approach. I have never
> questioned usefulness of the information.
> 
> > We can plug that into the show_mem report too, and list the top 10
> > allocations by file and line number.
> > 
> > > Maybe your proposal can be extended that way but the crucial point is to
> > > not dump all sorts of random shrinkers' state and end up with unwieldy
> > > reports.  If, on the other hand, any particular shrinker struggles to
> > > reclaim memory and it is sitting on a lot of memory it could be able to
> > > flag itself to be involved in the dump.
> > 
> > Great, since as was mentioned in the original commit message it's not
> > "all sorts of random shrinkers", but top 10 by objects reported, what
> > I've got here should make you happy.
> 
> Can we do better and make that a shrinker decision rather than an
> arbitrary top N selection? The thing is that shrinkers might even not
> matter in many cases so their output would be just a balast. The number
> of objects is not universaly great choice. As Dave mentioned metdata
> might be pinning other objects.
> 
> That being said, if you want to give more debugability power to
> shrinkers then it makes more sense to allow them to opt-in for the oom
> report rather than control which of them to involve from the oom
> reporting code which doesn't have enough context on its own.

If you've got an idea for a refinement, please submit your own patch and
I'll look at incorporating it into the series.

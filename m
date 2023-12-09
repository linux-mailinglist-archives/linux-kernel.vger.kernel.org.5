Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2BC180B18B
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Dec 2023 02:44:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235973AbjLIBoS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 20:44:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbjLIBoR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 20:44:17 -0500
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35E511700
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 17:44:23 -0800 (PST)
Date:   Fri, 8 Dec 2023 17:44:16 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1702086261;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dEa8QaNsjYl+s8o0gsHyRZ4RaaNqT3abDhzMXeL0qdo=;
        b=wzRy6s8veFnUU5bJNgdMSFLnGRzIkZYdeFCe2HgzQ9TtGun5P8swPOMFlxqhzIaQBnIJc2
        dN17ldR8uKRlAw68zDGPd6vFr3H6uDROlDA4T84AjubJVeqt25Zui9OB2yfilnrYcbEf3J
        +GTkozjJjnjywRbLMcbVBFA+/WO5le8=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Roman Gushchin <roman.gushchin@linux.dev>
To:     Kent Overstreet <kent.overstreet@linux.dev>
Cc:     Dave Chinner <david@fromorbit.com>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        Michal Hocko <mhocko@suse.com>,
        Muchun Song <muchun.song@linux.dev>,
        Linux-MM <linux-mm@kvack.org>, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 2/7] mm: shrinker: Add a .to_text() method for shrinkers
Message-ID: <ZXPGcHZA7qwvhj_k@P9FQF9L96D.corp.robot.car>
References: <ZWaHG09fY2BYjyGD@P9FQF9L96D.corp.robot.car>
 <ZWcBDglmDKUJdwMv@tiehlicka>
 <20231129231147.7msiocerq7phxnyu@moria.home.lan>
 <04f63966-af72-43ef-a65c-ff927064a3e4@bytedance.com>
 <20231130032149.ynap4ai47dj62fy3@moria.home.lan>
 <ZWjcA4BA5vZe57Eh@P9FQF9L96D.corp.robot.car>
 <ZWk0dI0PISWBbbKr@dread.disaster.area>
 <ZWo7ncdgPsj6rP7_@P9FQF9L96D.corp.robot.car>
 <ZXAtxBKZmKhFxwYB@dread.disaster.area>
 <20231206191349.x52nm3ercxelh3dx@moria.home.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231206191349.x52nm3ercxelh3dx@moria.home.lan>
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

On Wed, Dec 06, 2023 at 02:13:49PM -0500, Kent Overstreet wrote:
0;95;0c> On Wed, Dec 06, 2023 at 07:16:04PM +1100, Dave Chinner wrote:
> > On Fri, Dec 01, 2023 at 12:01:33PM -0800, Roman Gushchin wrote:
> > > What would be the proper solution to this problem from your point of view?
> > > What functionality/API mm can provide to make the life of fs developers
> > > better here?
> > 
> > What can we do better?
> > 
> > The first thing we can do better that comes to mind is to merge
> > Kent's patches that allow the shrinker owner to output debug
> > information when requested by the infrastructure.
> > 
> > Then we - the shrinker implementers - have some control of our own
> > destiny.  We can add whatever we need to solve shrinker and OOM
> > problems realted to our shrinkers not doing the right thing.
> > 
> > But without that callout from the infrastructure and the
> > infrastructure to drive it at appropriate times, we will make zero
> > progress improving the situation. 
> > 
> > Yes, the code may not be perfect and, yes, it may not be useful to
> > mm developers, but for the people who have to debug shrinker related
> > problems in production systems we need all the help we can get. We
> > certainly don't care if it isn't perfect, just having something we
> > can partially tailor to our iindividual needs is far, far better
> > than the current situation of nothing at all...
> 
> Of course if mm people don't want it I've got better things to do than
> fight uphill battles just to get some reviewed-by tags. Real high
> quality review feedback in this thread.

(ignoring an attack towards all mm people, sigh)

Kent, I think extending the shrinker debugfs interface is useful.
And in this context there is no need to limit the output to 10 items.
Also most of disagreements will vanish (sorry, if I missed something,
but looks like all concerns are related to the oom part).
Will it work for you?

If yes, would you be able to drop the oom part (at least for now)
and resend the patchset?

Thanks!

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CC5F80786E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 20:14:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379331AbjLFTNv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 14:13:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379272AbjLFTNt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 14:13:49 -0500
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60723193
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 11:13:55 -0800 (PST)
Date:   Wed, 6 Dec 2023 14:13:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1701890033;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aQlIzioB/NXQ5qBnXhi85XEv3cm+9ys274pnHM2/1Jg=;
        b=BNDnEkV+1sMya0F/B4bmg/yD0HnFaLSKKcZDsYMka3CyS5M9ffOsfxIo8H2/Bd1mtJVTXk
        IOm9asmccJ+vXO7OqdIo9cwX/02GM9D398nfToOX0/c17JhWRjK2MgwuD08EtQKCEgzgmf
        ez8Q6G0jtQnSoL9WKK3vQ3zKZx7K7yc=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Roman Gushchin <roman.gushchin@linux.dev>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        Michal Hocko <mhocko@suse.com>,
        Muchun Song <muchun.song@linux.dev>,
        Linux-MM <linux-mm@kvack.org>, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 2/7] mm: shrinker: Add a .to_text() method for shrinkers
Message-ID: <20231206191349.x52nm3ercxelh3dx@moria.home.lan>
References: <abd0ddd6-389c-43dc-b18f-aa5e3a4fcf5a@bytedance.com>
 <ZWaHG09fY2BYjyGD@P9FQF9L96D.corp.robot.car>
 <ZWcBDglmDKUJdwMv@tiehlicka>
 <20231129231147.7msiocerq7phxnyu@moria.home.lan>
 <04f63966-af72-43ef-a65c-ff927064a3e4@bytedance.com>
 <20231130032149.ynap4ai47dj62fy3@moria.home.lan>
 <ZWjcA4BA5vZe57Eh@P9FQF9L96D.corp.robot.car>
 <ZWk0dI0PISWBbbKr@dread.disaster.area>
 <ZWo7ncdgPsj6rP7_@P9FQF9L96D.corp.robot.car>
 <ZXAtxBKZmKhFxwYB@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZXAtxBKZmKhFxwYB@dread.disaster.area>
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

On Wed, Dec 06, 2023 at 07:16:04PM +1100, Dave Chinner wrote:
> On Fri, Dec 01, 2023 at 12:01:33PM -0800, Roman Gushchin wrote:
> > What would be the proper solution to this problem from your point of view?
> > What functionality/API mm can provide to make the life of fs developers
> > better here?
> 
> What can we do better?
> 
> The first thing we can do better that comes to mind is to merge
> Kent's patches that allow the shrinker owner to output debug
> information when requested by the infrastructure.
> 
> Then we - the shrinker implementers - have some control of our own
> destiny.  We can add whatever we need to solve shrinker and OOM
> problems realted to our shrinkers not doing the right thing.
> 
> But without that callout from the infrastructure and the
> infrastructure to drive it at appropriate times, we will make zero
> progress improving the situation. 
> 
> Yes, the code may not be perfect and, yes, it may not be useful to
> mm developers, but for the people who have to debug shrinker related
> problems in production systems we need all the help we can get. We
> certainly don't care if it isn't perfect, just having something we
> can partially tailor to our iindividual needs is far, far better
> than the current situation of nothing at all...

Of course if mm people don't want it I've got better things to do than
fight uphill battles just to get some reviewed-by tags. Real high
quality review feedback in this thread.

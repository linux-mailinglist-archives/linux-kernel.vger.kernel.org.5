Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C78B27FE831
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 05:15:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344423AbjK3EOr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 23:14:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234934AbjK3EOp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 23:14:45 -0500
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16070D5C
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 20:14:51 -0800 (PST)
Date:   Wed, 29 Nov 2023 23:14:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1701317689;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sOgwC1NdimlzYQo5Epj8cIIpO4bimXE0tJXhrILlqsg=;
        b=p7G7lo0fSJvxUHk9qub8yOk3MjGHq4JEevY4ZI5IXmIyT9FmJ+3NqAplpxnqSQI7KOLWEI
        6mbt+WSLPiFiTnG1UpmmrhgPlCS2tWwqxcbP6ncDFFidF8b747d1cqP8Nxy/OaBkK2LtuR
        nTAtfwpyT2DAM9rK/gXBm2WVDnpY77E=
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
Message-ID: <20231130041444.7cbhbvkvwpcbbhyd@moria.home.lan>
References: <20231125003009.tbaxuquny43uwei3@moria.home.lan>
 <76A1EE85-B62C-49B3-889C-80F9A2A88040@linux.dev>
 <20231128035345.5c7yc7jnautjpfoc@moria.home.lan>
 <abd0ddd6-389c-43dc-b18f-aa5e3a4fcf5a@bytedance.com>
 <ZWaHG09fY2BYjyGD@P9FQF9L96D.corp.robot.car>
 <ZWcBDglmDKUJdwMv@tiehlicka>
 <20231129231147.7msiocerq7phxnyu@moria.home.lan>
 <04f63966-af72-43ef-a65c-ff927064a3e4@bytedance.com>
 <20231130032149.ynap4ai47dj62fy3@moria.home.lan>
 <6f56c8f4-77e3-4ad7-a5f8-a6235b047137@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6f56c8f4-77e3-4ad7-a5f8-a6235b047137@bytedance.com>
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

On Thu, Nov 30, 2023 at 11:42:45AM +0800, Qi Zheng wrote:
> > Similarly for shrinkers, we're not going to be printing all of them -
> > the patchset picks the top 10 by objects and prints those. Could
> > probably be ~4, there's fewer shrinkers than slabs; also if we can get
> > shrinkers to report on memory owned in bytes, that will help too with
> > deciding what information is pertinent.
> 
> I'm not worried about the shrinker's general data. What I'm worried
> about is the shrinker's private data. Except for the corresponding
> developers, others don't know the meaning of the private statistical
> data, and we have no control over the printing quantity and form of
> the private data. This may indeed cause OOM log confusion and failure
> to automatically parse. For this, any thoughts?

If a shrinker is responsible for the OOM, then that private state is
exactly what is needed to debug the issue.

I explained this earlier - shrinkers can skip reclaiming objects for a
variety of reasons; in bcachefs's case that could be trylock() failure,
an IO in flight, the node being dirty, and more. Unlock the system inode
shrinker, it's much too expensive to move objects on and off the
shrinker list whenever they're touched. Again, this all comes from real
world experience.

The show_mem report is already full of numbers with zero explanation of
how they're relevant for debugging OOMS; we really need to improve how
that is presented as well.

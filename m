Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B75937FE33B
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 23:37:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234764AbjK2Wg4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 17:36:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231506AbjK2Wgz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 17:36:55 -0500
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [IPv6:2001:41d0:203:375::b2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CF75C4
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 14:37:01 -0800 (PST)
Date:   Wed, 29 Nov 2023 17:36:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1701297419;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iThWbTiboznHyChE5Jo4QcgUuCYJSKHGFLfD6YWq1kA=;
        b=ZZ4ikl8Y1DagtagNlyORcz+TM0QK5RWVuGkV2YXDMLOKY9y9IN37nPARWa/xHQWsPHRHEL
        gXgUC6eXEwh/SHSU/FSiyiMi6E2utKCQx4VmasacRZvvlRD+xUNPaTvCkBlreZjG00H/7z
        Vkvo1qYywvIIcejRA6LfCocERhDOu6c=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     Michal Hocko <mhocko@suse.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        Roman Gushchin <roman.gushchin@linux.dev>
Subject: Re: [PATCH 2/7] mm: shrinker: Add a .to_text() method for shrinkers
Message-ID: <20231129223655.shi74lnm2tolun77@moria.home.lan>
References: <20231122232515.177833-1-kent.overstreet@linux.dev>
 <20231122232515.177833-3-kent.overstreet@linux.dev>
 <ZWW6bInvMA2x3mHC@tiehlicka>
 <20231128174853.vdpwullepoxg5blo@moria.home.lan>
 <ZWdgm2I3tF0zvHG9@tiehlicka>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZWdgm2I3tF0zvHG9@tiehlicka>
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

On Wed, Nov 29, 2023 at 05:02:35PM +0100, Michal Hocko wrote:
> On Tue 28-11-23 12:48:53, Kent Overstreet wrote:
> > On Tue, Nov 28, 2023 at 11:01:16AM +0100, Michal Hocko wrote:
> > > On Wed 22-11-23 18:25:07, Kent Overstreet wrote:
> > > [...]
> > > > +void shrinkers_to_text(struct seq_buf *out)
> > > > +{
> > > > +	struct shrinker *shrinker;
> > > > +	struct shrinker_by_mem {
> > > > +		struct shrinker	*shrinker;
> > > > +		unsigned long	mem;
> > > > +	} shrinkers_by_mem[10];
> > > > +	int i, nr = 0;
> > > > +
> > > > +	if (!mutex_trylock(&shrinker_mutex)) {
> > > > +		seq_buf_puts(out, "(couldn't take shrinker lock)");
> > > > +		return;
> > > > +	}
> > > > +
> > > > +	list_for_each_entry(shrinker, &shrinker_list, list) {
> > > > +		struct shrink_control sc = { .gfp_mask = GFP_KERNEL, };
> > > 
> > > This seems to be global reclaim specific. What about memcg reclaim?
> > 
> > I have no fsckin idea how memcg reclaim works - and, for that matter,
> > the recent lockless shrinking work seems to have neglected to write even
> > an iterator macro, leaving _that_ a nasty mess so I'm not touching that
> > either.
> 
> OK, you could have made it more clearly that all of this is aiming at
> the global OOM handling. With an outlook on what should be done if this
> was ever required.
> 
> Another thing you want to look into is a NUMA constrained OOM (mbind,
> cpuset) where this output could be actively misleading.

Yeah.

It's not clear to me how (if at all) we want memcg to be represented in
this output; it's not something us filesystem developers think about a
lot. NUMA definitely should, though.

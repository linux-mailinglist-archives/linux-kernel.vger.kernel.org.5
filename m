Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 375907FC19D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 19:15:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346468AbjK1Ryn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 12:54:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345748AbjK1Ryi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 12:54:38 -0500
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [IPv6:2001:41d0:1004:224b::bc])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2506F1998
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 09:54:44 -0800 (PST)
Date:   Tue, 28 Nov 2023 12:54:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1701194082;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=A+pO7DYA9VT1hzqD2ijKa3011VeZdg5NxmlmwJJE8x0=;
        b=DnK9rrKxuNVA9XQur6wR6wNty7+/ZeYFP8CiQ2aCntiJKDSHXqEgoDFVgRZbAbuZza5JYz
        c5yJn9IITPXcNRXHcRn4zr6tQCbnwwT6/h5WzN+eGe3DPL4vMjmZFSwaHeLDocVoK9t67T
        1njDT3MlHARAsO4+ET4wot2Kf8eQhbQ=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     Michal Hocko <mhocko@suse.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        Roman Gushchin <roman.gushchin@linux.dev>
Subject: Re: [PATCH 4/7] mm: Centralize & improve oom reporting in show_mem.c
Message-ID: <20231128175439.6jarreie7cay74fn@moria.home.lan>
References: <20231122232515.177833-1-kent.overstreet@linux.dev>
 <20231122232515.177833-5-kent.overstreet@linux.dev>
 <ZWW71lfACwiHw3zk@tiehlicka>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZWW71lfACwiHw3zk@tiehlicka>
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

On Tue, Nov 28, 2023 at 11:07:18AM +0100, Michal Hocko wrote:
> On Wed 22-11-23 18:25:09, Kent Overstreet wrote:
> [...]
> > 00177 Shrinkers:
> > 00177 super_cache_scan: objects: 127
> > 00177 super_cache_scan: objects: 106
> > 00177 jbd2_journal_shrink_scan: objects: 32
> > 00177 ext4_es_scan: objects: 32
> > 00177 bch2_btree_cache_scan: objects: 8
> > 00177   nr nodes:          24
> > 00177   nr dirty:          0
> > 00177   cannibalize lock:  0000000000000000
> > 00177
> > 00177 super_cache_scan: objects: 8
> > 00177 super_cache_scan: objects: 1
> 
> It would be really great to provide an example on how these numbers are
> useful for the oom evaluation.

I should've posted an example from the end of the patch series; I'll do
that later today.

> [...]
> > @@ -423,4 +426,21 @@ void __show_mem(unsigned int filter, nodemask_t *nodemask, int max_zone_idx)
> >  #ifdef CONFIG_MEMORY_FAILURE
> >  	printk("%lu pages hwpoisoned\n", atomic_long_read(&num_poisoned_pages));
> >  #endif
> > +
> > +	buf = kmalloc(4096, GFP_ATOMIC);
> 
> I really do not think we want to allow allocations from the OOM context.
> Is there any reason why this cannot be a statically allocated buffer?

You've made this claim before without ever giving any reasoning behind
it.

It's GFP_ATOMIC; it has to work from _interrupt_ context, OOM context is
fine.

And no, we don't want to burn 4k on a static buffer that is almost never
used; people do care about making the kernel run on small systems.

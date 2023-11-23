Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E9B87F68AA
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 22:30:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbjKWVYN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 16:24:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjKWVYL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 16:24:11 -0500
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [IPv6:2001:41d0:203:375::b0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58297130
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 13:24:17 -0800 (PST)
Date:   Thu, 23 Nov 2023 16:24:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1700774655;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7ZLXHI2Ndk3rHHsAuo56iifYdV0BTffvf5dGp9YUFqg=;
        b=XxPzFZrtvipkxFgmFlx/ExysB/xnfphkaUcLFZbqpwUXkPvQsLc2IZXsi299cEJPyvv/14
        pfZlRTUxePNx0ah8qULgO/bJzkahkISeivJkSuhB2Y/7Y6xSyf5zaU3Vwl2JSZjX1Uuv7S
        NDq+tYptKfF1tikav+qzthg5l6luMeM=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     Qi Zheng <arch0.zheng@gmail.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH 2/7] mm: shrinker: Add a .to_text() method for shrinkers
Message-ID: <20231123212411.s6r5ekvkklvhwfra@moria.home.lan>
References: <20231122232515.177833-1-kent.overstreet@linux.dev>
 <20231122232515.177833-3-kent.overstreet@linux.dev>
 <deed9bb1-02b9-4e89-895b-38a84e5a9408@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <deed9bb1-02b9-4e89-895b-38a84e5a9408@gmail.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 23, 2023 at 11:32:59AM +0800, Qi Zheng wrote:
> > +	void (*to_text)(struct seq_buf *, struct shrinker *);
> 
> The "to_text" looks a little strange, how about naming it
> "stat_objects"?

The convention I've been using heavily in bcachefs is
typename_to_text(), or type.to_text(), for debug reports. The
consistency is nice.

> 
> >   	long batch;	/* reclaim batch size, 0 = default */
> >   	int seeks;	/* seeks to recreate an obj */
> > @@ -110,7 +114,6 @@ struct shrinker {
> >   #endif
> >   #ifdef CONFIG_SHRINKER_DEBUG
> >   	int debugfs_id;
> > -	const char *name;
> 
> The name will only be allocated memory when the CONFIG_SHRINKER_DEBUG is
> enabled, otherwise its value is NULL. So you can't move it out and use
> it while CONFIG_SHRINKER_DEBUG is disabled.

Good catch

> > +void shrinkers_to_text(struct seq_buf *out)
> > +{
> > +	struct shrinker *shrinker;
> > +	struct shrinker_by_mem {
> > +		struct shrinker	*shrinker;
> > +		unsigned long	mem;
> 
> The "mem" also looks a little strange, how about naming it
> "freeable"?

The type is just used in this one function, but sure.

> 
> > +	} shrinkers_by_mem[10];
> > +	int i, nr = 0;
> > +
> > +	if (!mutex_trylock(&shrinker_mutex)) {
> > +		seq_buf_puts(out, "(couldn't take shrinker lock)");
> > +		return;
> > +	}
> 
> We now have lockless method (RCU + refcount) to iterate shrinker_list,
> please refer to shrink_slab().

Will do!

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15EB47FB0BC
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 04:53:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234482AbjK1Dxr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 22:53:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbjK1Dxp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 22:53:45 -0500
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [IPv6:2001:41d0:1004:224b::b4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 401779D
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 19:53:51 -0800 (PST)
Date:   Mon, 27 Nov 2023 22:53:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1701143629;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ltroLqviQ4lHKFN5qNaVbgM2/VXvtAeYp19q2JtiWHk=;
        b=RT274r+AtrfGYjQp6+DSpGZQFDTOVvoa/2NbWP6DrGCzNJJsOgnQYA4aUZQ/9Ogj1HGBGl
        mVo/SvsDuJNb4RciNGpPODy8k8/kS9jjCdiA5N6uTzUXxK50HHI1qkW/TPJPQJ4IFtZt3T
        OU13ski2WqJ+SVEmEQ8/F2dzP/Qxjk0=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     Muchun Song <muchun.song@linux.dev>
Cc:     Qi Zheng <zhengqi.arch@bytedance.com>,
        Linux-MM <linux-mm@kvack.org>, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH 2/7] mm: shrinker: Add a .to_text() method for shrinkers
Message-ID: <20231128035345.5c7yc7jnautjpfoc@moria.home.lan>
References: <20231122232515.177833-1-kent.overstreet@linux.dev>
 <20231122232515.177833-3-kent.overstreet@linux.dev>
 <deed9bb1-02b9-4e89-895b-38a84e5a9408@gmail.com>
 <20231123212411.s6r5ekvkklvhwfra@moria.home.lan>
 <4caadff7-1df0-45cc-9d43-e616f9e4ddb3@bytedance.com>
 <20231125003009.tbaxuquny43uwei3@moria.home.lan>
 <76A1EE85-B62C-49B3-889C-80F9A2A88040@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <76A1EE85-B62C-49B3-889C-80F9A2A88040@linux.dev>
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

On Tue, Nov 28, 2023 at 11:27:11AM +0800, Muchun Song wrote:
> 
> 
> > On Nov 25, 2023, at 08:30, Kent Overstreet <kent.overstreet@linux.dev> wrote:
> > 
> > On Fri, Nov 24, 2023 at 11:08:11AM +0800, Qi Zheng wrote:
> >> Hi Kent,
> >> 
> >> On 2023/11/24 05:24, Kent Overstreet wrote:
> >>> On Thu, Nov 23, 2023 at 11:32:59AM +0800, Qi Zheng wrote:
> >>>>> + void (*to_text)(struct seq_buf *, struct shrinker *);
> >>>> 
> >>>> The "to_text" looks a little strange, how about naming it
> >>>> "stat_objects"?
> >>> 
> >>> The convention I've been using heavily in bcachefs is
> >>> typename_to_text(), or type.to_text(), for debug reports. The
> >> 
> >> OK.
> >> 
> >>> consistency is nice.
> >> 
> >> However, this is inconsistent with the name style of other
> >> shrinker callbacks. Please use the "objects" suffix. As for
> >> bcachefs's own callback function, you can use typename_to_text()
> >> to ensure consistency.
> > 
> > That would be inconsistent with introducing a convention to the wider
> > kernel.
> > 
> 
> I don not think .to_text is a good name. I really do not know what it means
> when I first look at this name. I knew you want to report the objects of
> shrinks, so why not use .report_objects or stat_objects proposed by Qi.
> Although .to_text is only used by bcachefs now, shrinker is a general module
> which is not only serving the bcachefs itself. I think it should be better
> to use a more straightforward name.

No, .report_objects or .stat_objects would be wrong; this isn't
generating a report on the objects owned by the shrinker, it's just a
report on the statistics of the shrinker itself.

That's why the convention is typename_to_text() - generate a text
representation of an object of that type.

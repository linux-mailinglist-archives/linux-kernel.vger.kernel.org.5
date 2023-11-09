Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D790D7E6729
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 10:53:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231518AbjKIJxg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 04:53:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbjKIJxf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 04:53:35 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80DC02D4F;
        Thu,  9 Nov 2023 01:53:32 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id C9BC821981;
        Thu,  9 Nov 2023 09:53:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1699523610; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uAxi1znqk3sGJCSNyuUjTVir9QcizsjWhu13JPKmk1Q=;
        b=Chxg8NzcVn76MnEz5kl7JNVtqSUwVkxnuEveTXfGaXv1vBRKOJIt3ndyinjPp1TMC4cCO/
        VBnyQ1BQfvQIPsL786bdXhDjkLeXb1F7PmvEoKx1u8oxACTPGmOSTaJPXDrXbwc9ISbWdb
        WsSLyYUqVJxEHlyJPUWrrnx6Rw6WJEM=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B85F5138E5;
        Thu,  9 Nov 2023 09:53:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 87f9LBqsTGWJYQAAMHmgww
        (envelope-from <mhocko@suse.com>); Thu, 09 Nov 2023 09:53:30 +0000
Date:   Thu, 9 Nov 2023 10:53:30 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Huan Yang <link@vivo.com>
Cc:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Huang Ying <ying.huang@intel.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Peter Xu <peterx@redhat.com>,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
        Yosry Ahmed <yosryahmed@google.com>,
        Liu Shixin <liushixin2@huawei.com>,
        Hugh Dickins <hughd@google.com>, cgroups@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, opensource.kernel@vivo.com
Subject: Re: [RFC 0/4] Introduce unbalance proactive reclaim
Message-ID: <ZUysGhwqo_XZSV-M@tiehlicka>
References: <20231108065818.19932-1-link@vivo.com>
 <ZUuV9xOZ5k7Ia_V2@tiehlicka>
 <ccc4094a-54de-4ce4-b8f6-76ee46d8d02d@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ccc4094a-54de-4ce4-b8f6-76ee46d8d02d@vivo.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 09-11-23 09:56:46, Huan Yang wrote:
> 
> 在 2023/11/8 22:06, Michal Hocko 写道:
> > [Some people who received this message don't often get email from mhocko@suse.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> > 
> > On Wed 08-11-23 14:58:11, Huan Yang wrote:
> > > In some cases, we need to selectively reclaim file pages or anonymous
> > > pages in an unbalanced manner.
> > > 
> > > For example, when an application is pushed to the background and frozen,
> > > it may not be opened for a long time, and we can safely reclaim the
> > > application's anonymous pages, but we do not want to touch the file pages.
> > Could you explain why? And also why do you need to swap out in that
> > case?
>
> When an application is frozen, it usually means that we predict that
> it will not be used for a long time. In order to proactively save some
> memory, our strategy will choose to compress the application's private
> data into zram. And we will also select some of the cold application
> data that we think is in zram and swap it out.
>
> The above operations assume that anonymous pages are private to the
> application.  After the application is frozen, compressing these pages
> into zram can save memory to some extent without worrying about
> frequent refaults.

Why don't you rely on the default reclaim heuristics? In other words do
you have any numbers showing that a selective reclaim results in a much
better behavior? How do you evaluate that?

> 
> And the cost of refaults on zram is lower than that of IO.
> 
> 
> > 
> > > This patchset extends the proactive reclaim interface to achieve
> > > unbalanced reclamation. Users can control the reclamation tendency by
> > > inputting swappiness under the original interface. Specifically, users
> > > can input special values to extremely reclaim specific pages.
> > Other have already touched on this in other replies but v2 doesn't have
> > a per-memcg swappiness
> > 
> > > Example:
> > >        echo "1G" 200 > memory.reclaim (only reclaim anon)
> > >          echo "1G" 0  > memory.reclaim (only reclaim file)
> > >          echo "1G" 1  > memory.reclaim (only reclaim file)
> > > 
> > > Note that when performing unbalanced reclamation, the cgroup swappiness
> > > will be temporarily adjusted dynamically to the input value. Therefore,
> > > if the cgroup swappiness is further modified during runtime, there may
> > > be some errors.
> > In general this is a bad semantic. The operation shouldn't have side
> > effect that are potentially visible for another operation.
> So, maybe pass swappiness into sc and keep a single reclamation ensure that
> swappiness is not changed?

That would be a much saner approach.

> Or, it's a bad idea that use swappiness to control unbalance reclaim.

Memory reclaim is not really obliged to consider swappiness. In fact the
actual behavior has changed several times in the past and it is safer to
assume this might change in the future again.

-- 
Michal Hocko
SUSE Labs

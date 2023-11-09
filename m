Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF4237E6B68
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 14:46:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234055AbjKINq4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 08:46:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230055AbjKINqz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 08:46:55 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30EDC272C;
        Thu,  9 Nov 2023 05:46:53 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id CDB6F21986;
        Thu,  9 Nov 2023 13:46:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1699537611; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YKHzFm/oapSlwZcHTR2PFLFJfozxMVapfiyCQwE/TOI=;
        b=l2biBl5ppzUx3t2WvUqfOlGuhAfLsWkWFrakSkJ7AEDjtiNP/PL9a27vmTyG8Nrx/jD+bw
        oJ58v0OKNARNz+eoBZAndvkafUxkWLACRq+aDkmdIKQt3L6z2X9ol2MiSYNo4nkBV9F9EO
        ehe9y+r+mKOMEcUbFUMWzfXuAF9IY24=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BCEFE138E5;
        Thu,  9 Nov 2023 13:46:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id JSQVLsviTGWSWQAAMHmgww
        (envelope-from <mhocko@suse.com>); Thu, 09 Nov 2023 13:46:51 +0000
Date:   Thu, 9 Nov 2023 14:46:51 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Huan Yang <link@vivo.com>
Cc:     "Huang, Ying" <ying.huang@intel.com>, Tejun Heo <tj@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Peter Xu <peterx@redhat.com>,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
        Yosry Ahmed <yosryahmed@google.com>,
        Liu Shixin <liushixin2@huawei.com>,
        Hugh Dickins <hughd@google.com>, cgroups@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, opensource.kernel@vivo.com
Subject: Re: [RFC 0/4] Introduce unbalance proactive reclaim
Message-ID: <ZUziy-6QPdTIDJlm@tiehlicka>
References: <ZUuV9xOZ5k7Ia_V2@tiehlicka>
 <ccc4094a-54de-4ce4-b8f6-76ee46d8d02d@vivo.com>
 <87msvniplj.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <1e699ff2-0841-490b-a8e7-bb87170d5604@vivo.com>
 <ZUytB5lSwxeKkBW8@tiehlicka>
 <6b539e16-c835-49ff-9fae-a65960567657@vivo.com>
 <ZUy2-vrqDq7URzb6@tiehlicka>
 <e8c0c069-a685-482d-afad-d1069c6a95ba@vivo.com>
 <ZUzTVgK_i05uiHiB@tiehlicka>
 <e07c977f-8c73-4772-b069-527c6ac0ae4f@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e07c977f-8c73-4772-b069-527c6ac0ae4f@vivo.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 09-11-23 21:07:29, Huan Yang wrote:
[...]
> > > Of course, as you suggested, madvise can also achieve this, but
> > > implementing it in the agent may be more complex.(In terms of
> > > achieving the same goal, using memcg to group all the processes of an
> > > APP and perform proactive reclamation is simpler than using madvise
> > > and scanning multiple processes of an application using an agent?)
> > It might be more involved but the primary question is whether it is
> > usable for the specific use case. Madvise interface is not LRU aware but
> > you are not really talking about that to be a requirement? So it would
> > really help if you go deeper into details on how is the interface
> > actually supposed to be used in your case.
> In mobile field, we usually configure zram to compress anonymous page.
> We can approximate to expand memory usage with limited hardware memory
> by using zram.
> 
> With proper strategies, an 8GB RAM phone can approximate the usage of a 12GB
> phone
> (or more).
> 
> In our strategy, we group memcg by application. When the agent detects that
> an
> application has entered the background, then frozen, and has not been used
> for a long time,
> the agent will slowly issue commands to reclaim the anonymous page of that
> application.
> 
> With this interface, `echo memory anon > memory.reclaim`

This doesn't really answer my questions above.
  
> > Also make sure to exaplain why you cannot use other existing interfaces.
> > For example, why you simply don't decrease the limit of the frozen
> > cgroup and rely on the normal reclaim process to evict the most cold
> This is a question of reclamation tendency, and simply decreasing the limit
> of the frozen cgroup cannot achieve this.

Why?

> > memory? What are you basing your anon vs. file proportion decision on?
> When zram is configured and anonymous pages are reclaimed proactively, the
> refault
> probability of anonymous pages is low when an application is frozen and not
> reopened.
> Also, the cost of refaulting from zram is relatively low.
>
> However, file pages usually have shared properties, so even if an
> application is frozen,
> other processes may still access the file pages. If a limit is set and the
> reclamation encounters
> file pages, it will cause a certain amount of refault I/O, which is costly
> for mobile devices.

Two points here (and the reason why I am repeatedly asking for some
data) 1) are you really seeing shared and actively used page cache pages
being reclaimed? 2) Is the refault IO really a problem. What kind of
storage those phone have that this is more significant than potentially
GB of compressed anonymous memory which would need CPU to refaulted
back. I mean do you have any actual numbers to show that the default
reclaim strategy would lead to a less utilized or less performant
system?
-- 
Michal Hocko
SUSE Labs

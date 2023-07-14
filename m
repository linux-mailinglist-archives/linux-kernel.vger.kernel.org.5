Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC3C27535EA
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 10:59:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235750AbjGNI7h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 04:59:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235654AbjGNI7Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 04:59:25 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2966C270B
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 01:59:22 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id A89AD22100;
        Fri, 14 Jul 2023 08:59:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1689325160; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OD2Y8EYH4iQhl/uinOOqc2LyprUZwMqThWDOzf/DPgk=;
        b=AQAUwUV19C/3BBTp78ZvdS/A9jzkyZrYU47ID+jQp5YfCXngJ9JYeQ9VHBZv/cgyMPwQtW
        hec+5BnJFMYm77jUoXeS7yjLZPYmwu+UVvDAikEbBkAtjbzo1dEQ20Yq5KLrvQ3Kuaxy0V
        85vGxifQdJrBjYcDTSsrIrHqBn8Y6o4=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8763B138F8;
        Fri, 14 Jul 2023 08:59:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id HwIVHmgOsWTeZQAAMHmgww
        (envelope-from <mhocko@suse.com>); Fri, 14 Jul 2023 08:59:20 +0000
Date:   Fri, 14 Jul 2023 10:59:19 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Arjan Van De Ven <arjan@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>,
        Johannes Weiner <jweiner@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [RFC 1/2] mm: add framework for PCP high auto-tuning
Message-ID: <ZLEOZ7ScEwnNpS0e@dhcp22.suse.cz>
References: <20230710065325.290366-1-ying.huang@intel.com>
 <20230710065325.290366-2-ying.huang@intel.com>
 <ZK035Tl7lrCPk09r@dhcp22.suse.cz>
 <87edldefnt.fsf@yhuang6-desk2.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87edldefnt.fsf@yhuang6-desk2.ccr.corp.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 12-07-23 15:45:58, Huang, Ying wrote:
> Michal Hocko <mhocko@suse.com> writes:
> 
> > On Mon 10-07-23 14:53:24, Huang Ying wrote:
> >> The page allocation performance requirements of different workloads
> >> are usually different.  So, we often need to tune PCP (per-CPU
> >> pageset) high to optimize the workload page allocation performance.
> >> Now, we have a system wide sysctl knob (percpu_pagelist_high_fraction)
> >> to tune PCP high by hand.  But, it's hard to find out the best value
> >> by hand.  And one global configuration may not work best for the
> >> different workloads that run on the same system.  One solution to
> >> these issues is to tune PCP high of each CPU automatically.
> >> 
> >> This patch adds the framework for PCP high auto-tuning.  With it,
> >> pcp->high will be changed automatically by tuning algorithm at
> >> runtime.  Its default value (pcp->high_def) is the original PCP high
> >> value calculated based on low watermark pages or
> >> percpu_pagelist_high_fraction sysctl knob.  To avoid putting too many
> >> pages in PCP, the original limit of percpu_pagelist_high_fraction
> >> sysctl knob, MIN_PERCPU_PAGELIST_HIGH_FRACTION, is used to calculate
> >> the max PCP high value (pcp->high_max).
> >
> > It would have been very helpful to describe the basic entry points to
> > the auto-tuning. AFAICS the central place of the tuning is tune_pcp_high
> > which is called from the freeing path. Why?  Is this really a good place
> > considering this is a hot path? What about the allocation path? Isn't
> > that a good spot to watch for the allocation demand? 
> 
> Yes.  The main entry point to the auto-tuning is tune_pcp_high().  Which
> is called from the freeing path because pcp->high is only used by page
> freeing.  It's possible to call it in allocation path instead.  The
> drawback is that the pcp->high may be updated a little later in some
> situations.  For example, if there are many page freeing but no page
> allocation for quite long time.  But I don't think this is a serious
> problem.

I consider it a serious flaw in the framework as it cannot cope with the
transition of the allocation pattern (e.g. increasing the allocation
pressure).

> > Also this framework seems to be enabled by default. Is this really
> > desirable? What about workloads tuning the pcp batch size manually?
> > Shouldn't they override any auto-tuning?
> 
> In the current implementation, the pcp->high will be tuned between
> original pcp high (default or tuned manually) and the max pcp high (via
> MIN_PERCPU_PAGELIST_HIGH_FRACTION).  So the high value tuned manually is
> respected at some degree.
> 
> So you think that it's better to disable auto-tuning if PCP high is
> tuned manually?

Yes, I think this is a much safer option. For two reasons 1) it is less
surprising to setups which know what they are doing by configuring the
batching and 2) the auto-tuning needs a way to get disabled in case
there are pathological patterns in behavior.
-- 
Michal Hocko
SUSE Labs

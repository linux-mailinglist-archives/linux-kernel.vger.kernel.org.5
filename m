Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FF3D7539C5
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 13:42:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235425AbjGNLmb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 07:42:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234567AbjGNLm2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 07:42:28 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8627535B3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 04:41:58 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 00ADA2209F;
        Fri, 14 Jul 2023 11:41:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1689334890; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iilSheHIUhgnsn15zN9O4xrXzcgpGmmRPakgPtr45AM=;
        b=XQo5MHIA02k7FaZ/QWVO6OpYvFpMXlPWusvgWQ6WpC3IdDJEGdWpcJkM/nwl/8we72XFfn
        Z5QLr1PW+J58HRL0qHho+YJUudt5t25D5W8L8XaWxuG4iQuhm76O/EDDoBjLEO38ArXIUI
        pG7wRONnYxbgMTQrMgxR97oqYr79nFo=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D588F138F8;
        Fri, 14 Jul 2023 11:41:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Gbf1MWk0sWTdOQAAMHmgww
        (envelope-from <mhocko@suse.com>); Fri, 14 Jul 2023 11:41:29 +0000
Date:   Fri, 14 Jul 2023 13:41:28 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Huang Ying <ying.huang@intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Arjan Van De Ven <arjan@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>,
        Johannes Weiner <jweiner@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [RFC 2/2] mm: alloc/free depth based PCP high auto-tuning
Message-ID: <ZLE0aF/pT9zZeoGt@dhcp22.suse.cz>
References: <20230710065325.290366-1-ying.huang@intel.com>
 <20230710065325.290366-3-ying.huang@intel.com>
 <ZK060sMG0GfC5gUS@dhcp22.suse.cz>
 <20230712090526.thk2l7sbdcdsllfi@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230712090526.thk2l7sbdcdsllfi@techsingularity.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 12-07-23 10:05:26, Mel Gorman wrote:
> On Tue, Jul 11, 2023 at 01:19:46PM +0200, Michal Hocko wrote:
> > On Mon 10-07-23 14:53:25, Huang Ying wrote:
> > > To auto-tune PCP high for each CPU automatically, an
> > > allocation/freeing depth based PCP high auto-tuning algorithm is
> > > implemented in this patch.
> > > 
> > > The basic idea behind the algorithm is to detect the repetitive
> > > allocation and freeing pattern with short enough period (about 1
> > > second).  The period needs to be short to respond to allocation and
> > > freeing pattern changes quickly and control the memory wasted by
> > > unnecessary caching.
> > 
> > 1s is an ethernity from the allocation POV. Is a time based sampling
> > really a good choice? I would have expected a natural allocation/freeing
> > feedback mechanism. I.e. double the batch size when the batch is
> > consumed and it requires to be refilled and shrink it under memory
> > pressure (GFP_NOWAIT allocation fails) or when the surplus grows too
> > high over batch (e.g. twice as much).  Have you considered something as
> > simple as that?
> > Quite honestly I am not sure time based approach is a good choice
> > because memory consumptions tends to be quite bulky (e.g. application
> > starts or workload transitions based on requests).
> >  
> 
> I tend to agree. Tuning based on the recent allocation pattern without frees
> would make more sense and also be symmetric with how free_factor works. I
> suspect that time-based may be heavily orientated around the will-it-scale
> benchmark. While I only glanced at this, a few things jumped out
> 
> 1. Time-based heuristics are not ideal. congestion_wait() and
>    friends was an obvious case where time-based heuristics fell apart even
>    before the event it waited on was removed. For congestion, it happened to
>    work for slow storage for a while but that was about it.  For allocation
>    stream detection, it has a similar problem. If a process is allocating
>    heavily, then fine, if it's in bursts of less than a second more than one
>    second apart then it will not adapt. While I do not think it is explicitly
>    mentioned anywhere, my understanding was that heuristics like this within
>    mm/ should be driven by explicit events as much as possible and not time.

Agreed. I would also like to point out that it is also important to
realize those events that we should care about. Remember the primary
motivation of the tuning is to reduce the lock contention. That being
said, it is less of a problem to have stream or bursty demand for
memory if that doesn't really cause the said contention, right? So any
auto-tuning should consider that as well and do not inflate the batch
in an absense of the contention. That of course means that a solely
deallocation based monitoring.

-- 
Michal Hocko
SUSE Labs

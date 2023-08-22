Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EE0E784965
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 20:29:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbjHVS3E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 14:29:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjHVS3D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 14:29:03 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77A64CCB
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 11:29:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=a15U4MejTFPZxXdAjLchlRcmwqjq8ec43bcazCol0I8=; b=ccrrsO6FaMUwmvMuoxI2mJa9/6
        nGglbUdgn6XwvHEbUQ9rbGnJWCCX/W/SwJl7g/yxNVdUe3N4VyLMhkDdEeJb5hv4HpdPEiewDna+4
        g0/P34NZgeERT8XmTOAk9J20tMvbE9E4j3tfaPUO9cH4Q+XD3NQ4WXGU7GDnDs7suQe0GF8D+1kHz
        zQsuTqmuXsMcJ+tqDrTjWn16C3EjnfdDpHo8qYaD7h7MknHn/SIUBdyxFHuwoPstdKoG4Q1ufwCdt
        VZdpSkkzwGHUj7vFLDQ3fCotCRWnAFndZI5yjSlSuCanY62XOG2eyEsfjV7JkcYXJGGKxilBt6uSA
        P6ofLqSQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qYW73-000F0d-Gp; Tue, 22 Aug 2023 18:28:21 +0000
Date:   Tue, 22 Aug 2023 19:28:21 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Chris Li <chrisl@kernel.org>
Cc:     Mel Gorman <mgorman@techsingularity.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kemeng Shi <shikemeng@huaweicloud.com>,
        baolin.wang@linux.alibaba.com, Michal Hocko <mhocko@suse.com>,
        david@redhat.com, linux-mm@kvack.org,
        Namhyung Kim <namhyung@google.com>,
        Greg Thelen <gthelen@google.com>, linux-kernel@vger.kernel.org,
        John Sperbeck <jsperbeck@google.com>,
        Huang Ying <ying.huang@intel.com>,
        Alexei Starovoitov <ast@kernel.org>
Subject: Re: [PATCH RFC 0/2] mm/page_alloc: free_pcppages_bulk safeguard
Message-ID: <ZOT+RYe22TkkqCgP@casper.infradead.org>
References: <20230817-free_pcppages_bulk-v1-0-c14574a9f80c@kernel.org>
 <20230821103225.qntnsotdzuthxn2y@techsingularity.net>
 <CAF8kJuOsWo5RfDcfnWZfnqYXjf6bkkxdXG1JCwjaEZ1nn29AaA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAF8kJuOsWo5RfDcfnWZfnqYXjf6bkkxdXG1JCwjaEZ1nn29AaA@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 22, 2023 at 10:48:42AM -0700, Chris Li wrote:
> Hi Mel,
> 
> Adding Alexei to the discussion.
> 
> On Mon, Aug 21, 2023 at 3:32 AM Mel Gorman <mgorman@techsingularity.net> wrote:
> >
> > On Thu, Aug 17, 2023 at 11:05:22PM -0700, Chris Li wrote:
> > > In this patch series I want to safeguard
> > > the free_pcppage_bulk against change in the
> > > pcp->count outside of this function. e.g.
> > > by BPF program inject on the function tracepoint.
> > >
> > > I break up the patches into two seperate patches
> > > for the safeguard and clean up.
> > >
> > > Hopefully that is easier to review.
> > >
> > > Signed-off-by: Chris Li <chrisl@kernel.org>
> >
> > This sounds like a maintenance nightmare if internal state can be arbitrary
> > modified by a BPF program and still expected to work properly in all cases.
> > Every review would have to take into account "what if a BPF script modifies
> > state behind our back?"
> 
> Thanks for the feedback.
> 
> I agree that it is hard to support if we allow BPF to change any internal
> stage as a rule.  That is why it is a RFC. Would you consider it case
> by case basis?
> The kernel panic is bad, the first patch is actually very small. I can
> also change it
> to generate warnings if we detect the inconsistent state.

We wouldn't allow C code that hooks spinlocks (eg lockdep) to allocate
memory.  I don't understand why BPF code should allocate memory either.

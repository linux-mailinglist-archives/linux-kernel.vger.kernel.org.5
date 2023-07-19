Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48567758FDF
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 10:06:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229724AbjGSIGJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 04:06:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjGSIGH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 04:06:07 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3351B9D
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 01:06:03 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id E9E9E1FD64;
        Wed, 19 Jul 2023 08:06:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1689753961; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zBnExcgSy6/8W0b3ctbNk4QK5v+V0L2vbTzjaBee7xs=;
        b=qsOSHoPT2PhOaYUzl8APdcnP6okS7SZTR5gw33DZdqCMWOu7C/ic4prqf4sQy7161rigdD
        QbwLdP/SnJCkbWv/SK1jkdtX283tQyiUQ+8NEOImeqwMYtRKnG6pMAFAO5GCXjYJWd+RwB
        s+S1XoSPXyqAKGGXSV/IWupMnvmrPKE=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CE39D13460;
        Wed, 19 Jul 2023 08:06:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id VwjZL2mZt2Q3cQAAMHmgww
        (envelope-from <mhocko@suse.com>); Wed, 19 Jul 2023 08:06:01 +0000
Date:   Wed, 19 Jul 2023 10:06:01 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Ross Zwisler <zwisler@google.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>, Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>
Subject: Re: collision between ZONE_MOVABLE and memblock allocations
Message-ID: <ZLeZaa5LMH1c2zQ3@dhcp22.suse.cz>
References: <20230718220106.GA3117638@google.com>
 <ZLd/WEZTH5rlwYjP@dhcp22.suse.cz>
 <20230719075952.GH1901145@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230719075952.GH1901145@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 19-07-23 10:59:52, Mike Rapoport wrote:
> On Wed, Jul 19, 2023 at 08:14:48AM +0200, Michal Hocko wrote:
> > On Tue 18-07-23 16:01:06, Ross Zwisler wrote:
> > [...]
> > > I do think that we need to fix this collision between ZONE_MOVABLE and memmap
> > > allocations, because this issue essentially makes the movablecore= kernel
> > > command line parameter useless in many cases, as the ZONE_MOVABLE region it
> > > creates will often actually be unmovable.
> > 
> > movablecore is kinda hack and I would be more inclined to get rid of it
> > rather than build more into it. Could you be more specific about your
> > use case?
> > 
> > > Here are the options I currently see for resolution:
> > > 
> > > 1. Change the way ZONE_MOVABLE memory is allocated so that it is allocated from
> > > the beginning of the NUMA node instead of the end. This should fix my use case,
> > > but again is prone to breakage in other configurations (# of NUMA nodes, other
> > > architectures) where ZONE_MOVABLE and memblock allocations might overlap.  I
> > > think that this should be relatively straightforward and low risk, though.
> > > 
> > > 2. Make the code which processes the movablecore= command line option aware of
> > > the memblock allocations, and have it choose a region for ZONE_MOVABLE which
> > > does not have these allocations. This might be done by checking for
> > > PageReserved() as we do with offlining memory, though that will take some boot
> > > time reordering, or we'll have to figure out the overlap in another way. This
> > > may also result in us having two ZONE_NORMAL zones for a given NUMA node, with
> > > a ZONE_MOVABLE section in between them.  I'm not sure if this is allowed?
> > 
> > Yes, this is no problem. Zones are allowed to be sparse.
> 
> The current initialization order is roughly
> 
> * very early initialization with some memblock allocations
> * determine zone locations and sizes
> * initialize memory map	
>   - memblock_alloc(lots of memory)
> * lots of unrelated initializations that may allocate memory
> * release free pages from memblock to the buddy allocator
> 
> With 2) we can make sure the memory map and early allocations won't be in
> the ZONE_MOVABLE, but we'll still may have reserved pages there.

Yes this will always be fragile. If the spefic placement of the movable
memory is not important and the only thing that matters is the size and
numa locality then an easier to maintain solution would be to simply
offline enough memory blocks very early in the userspace bring up and
online it back as movable. If offlining fails just try another
memblock. This doesn't require any kernel code change.
-- 
Michal Hocko
SUSE Labs

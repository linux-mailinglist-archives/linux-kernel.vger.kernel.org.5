Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22A0575A2A3
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 01:05:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230242AbjGSXFq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 19:05:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230118AbjGSXFn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 19:05:43 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55476268F
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 16:05:20 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id ca18e2360f4ac-78362f574c9so6790539f.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 16:05:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689807919; x=1692399919;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NtoVTIzSaEDDzG0bR4jOtPcvMd189PXBa9TamlZo308=;
        b=UKTkTk7YGb5sJ7JSucdkUItIsjvrFJMq+hXa/yO2GuqHnTAu7Cl6ve+b8+wbptuh69
         VLH+HU3danMVPr/I+PdFWVrA78ovyfPAJoqzx83Nr0d3etmfqB7KlNjnU+53bFnqBm5h
         bJym6ezLXxvMwjpO5vyvR3FrM+VYAoRirtYYiLriz6Qi82hVxAb2a/VSWQcxcfbITdE6
         REBx7cKruKtMUVABv5K/aYV7ues8suooxt0O3/j4FIk6358bgNVWlpbZjW0AUAybaJS+
         /qtOVpoczOWQfazbmqVYQGQu4ZVMkhQHG1AJsiWOK5rMHxtd6SsCRo5Fb4KQu1jgpbi8
         PujA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689807919; x=1692399919;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NtoVTIzSaEDDzG0bR4jOtPcvMd189PXBa9TamlZo308=;
        b=N0yD+jvewIfRLjAklSd0uQFAOGn/zpWa+613Cc2yFNaQLBPoQLSbRB435s3E5gBwd6
         o/zyRy7Xw4w95oY2h1xPEBDxgTU4O48HkcTdCcWHW+kRuJRoYYPuqoBzMK0dg32AN0ET
         +nd0ED7g5ZGRB2up2rFX3Xg+FmGq740p7PogL7qg9Lc5zjPKhEl2YVx/oIK2NdQzwK2V
         1QHr4em4Sfmn9SGE1SzH4PcJA+j6UuOrkcOcRuboG+REtReWa6mwM48BKW7sVT3YK+Kq
         hbRcXykvPzMrXX8Xb/EVzeklZoryCAOleQ/Ki4z2iPguAGWCaIQ8HxsiNi85NPBFMj5J
         P2XQ==
X-Gm-Message-State: ABy/qLaTcBSFSamRAdTb/V33lEQFwqZRW/kV6Td1SRC0KaWqoQhxkIzR
        Tqv6+nJOBjCHRYjOaCgEHskeNA==
X-Google-Smtp-Source: APBJJlGK517Ks2qQjDvuU28RE/+1S6J6gj01Hw8Ew77Bdf7DnmdFmIYgQT9VnrMGj1JSVi2zkl+vUA==
X-Received: by 2002:a6b:610d:0:b0:783:5209:c01 with SMTP id v13-20020a6b610d000000b0078352090c01mr7971152iob.17.1689807919206;
        Wed, 19 Jul 2023 16:05:19 -0700 (PDT)
Received: from google.com ([2620:15c:183:200:84dc:2218:a741:ad50])
        by smtp.gmail.com with ESMTPSA id e9-20020a056638020900b0042bae96eba7sm1624193jaq.7.2023.07.19.16.05.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jul 2023 16:05:18 -0700 (PDT)
Date:   Wed, 19 Jul 2023 17:05:15 -0600
From:   Ross Zwisler <zwisler@google.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Michal Hocko <mhocko@suse.com>, Mike Rapoport <rppt@kernel.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>, Vlastimil Babka <vbabka@suse.cz>
Subject: Re: collision between ZONE_MOVABLE and memblock allocations
Message-ID: <20230719230515.GA3654720@google.com>
References: <20230718220106.GA3117638@google.com>
 <ZLd/WEZTH5rlwYjP@dhcp22.suse.cz>
 <20230719075952.GH1901145@kernel.org>
 <ZLeZaa5LMH1c2zQ3@dhcp22.suse.cz>
 <9770454d-f840-c7cf-314e-ce81839393e3@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9770454d-f840-c7cf-314e-ce81839393e3@redhat.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,FSL_HELO_FAKE,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 19, 2023 at 10:14:59AM +0200, David Hildenbrand wrote:
> On 19.07.23 10:06, Michal Hocko wrote:
> > On Wed 19-07-23 10:59:52, Mike Rapoport wrote:
> > > On Wed, Jul 19, 2023 at 08:14:48AM +0200, Michal Hocko wrote:
> > > > On Tue 18-07-23 16:01:06, Ross Zwisler wrote:
> > > > [...]
> > > > > I do think that we need to fix this collision between ZONE_MOVABLE and memmap
> > > > > allocations, because this issue essentially makes the movablecore= kernel
> > > > > command line parameter useless in many cases, as the ZONE_MOVABLE region it
> > > > > creates will often actually be unmovable.
> > > > 
> > > > movablecore is kinda hack and I would be more inclined to get rid of it
> > > > rather than build more into it. Could you be more specific about your
> > > > use case?
> > > > 
> > > > > Here are the options I currently see for resolution:
> > > > > 
> > > > > 1. Change the way ZONE_MOVABLE memory is allocated so that it is allocated from
> > > > > the beginning of the NUMA node instead of the end. This should fix my use case,
> > > > > but again is prone to breakage in other configurations (# of NUMA nodes, other
> > > > > architectures) where ZONE_MOVABLE and memblock allocations might overlap.  I
> > > > > think that this should be relatively straightforward and low risk, though.
> > > > > 
> > > > > 2. Make the code which processes the movablecore= command line option aware of
> > > > > the memblock allocations, and have it choose a region for ZONE_MOVABLE which
> > > > > does not have these allocations. This might be done by checking for
> > > > > PageReserved() as we do with offlining memory, though that will take some boot
> > > > > time reordering, or we'll have to figure out the overlap in another way. This
> > > > > may also result in us having two ZONE_NORMAL zones for a given NUMA node, with
> > > > > a ZONE_MOVABLE section in between them.  I'm not sure if this is allowed?
> > > > 
> > > > Yes, this is no problem. Zones are allowed to be sparse.
> > > 
> > > The current initialization order is roughly
> > > 
> > > * very early initialization with some memblock allocations
> > > * determine zone locations and sizes
> > > * initialize memory map	
> > >    - memblock_alloc(lots of memory)
> > > * lots of unrelated initializations that may allocate memory
> > > * release free pages from memblock to the buddy allocator
> > > 
> > > With 2) we can make sure the memory map and early allocations won't be in
> > > the ZONE_MOVABLE, but we'll still may have reserved pages there.
> > 
> > Yes this will always be fragile. If the spefic placement of the movable
> > memory is not important and the only thing that matters is the size and
> > numa locality then an easier to maintain solution would be to simply
> > offline enough memory blocks very early in the userspace bring up and
> > online it back as movable. If offlining fails just try another
> > memblock. This doesn't require any kernel code change.
> 
> As an alternative, we might use the "memmap=nn[KMG]!ss[KMG]" [1] parameter
> to mark some memory as protected.
> 
> That memory can then be configured as devdax device and online to
> ZONE_MOVABLE (dev/dax).
> 
> [1] https://docs.pmem.io/persistent-memory/getting-started-guide/creating-development-environments/linux-environments/linux-memmap

I've previously been reconfiguring devdax memory like this:

  ndctl create-namespace --reconfig=namespace0.0 -m devdax -f
  daxctl reconfigure-device --mode=system-ram dax0.0

Is this how you've been doing it, or is there something else I should
consider?

I just sent mail to Michal outlining my use case, hopefully it makes sense.

I had thought about using 'memmap=' in the first kernel and the worry was that
I'd have to support many different machines with different memory
configurations, and have to hard-code memory offsets and lengths for the
various memmap= kernel command line parameters.  If I can make ZONE_MOVABLE
work that's preferable because the kernel will choose the correct usermem-only
region for me, and then I can just use that region for the crash kernel and
3rd kernel boots.

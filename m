Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D6A875A280
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 00:51:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231334AbjGSWvR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 18:51:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231321AbjGSWuu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 18:50:50 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 427B035BB
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 15:48:47 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id ca18e2360f4ac-7836164a08aso6447439f.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 15:48:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689806906; x=1692398906;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MEInahlEsHjcSww3xlsFFaRjkkq9xhhzX3ommlPB214=;
        b=6tp966Gqs/ZMxnKjLWUUJqUqBl4BzuZGXqP9Mmb4vHPejYI9MnffUrgLxx4/IF14o+
         ikpT/1FbqXrEukdQDXj/VnjMHO9btaa/85Y/1rQ7clmzjsu32vyQ3bM02Ac3rp96p3eM
         Dqv+LaezvNgSUJ5N4P2wxPVF8ZHK5TiHd2EdSd+2S5ONj9OYc8DZXwnBm7wiWPQ4/ljz
         YCOL8Giz6Hocq+XMWB9ejRU+ilEnLD8oyyCgpQH5yXvHCIy0dZIugE+fahUmyXX0VTWf
         w8csHyIWL4HpUnI4UruW2T9bMLDjg3kXttaCHWa9OQmAH6v5h5YAcrrB88ckNsjvEGul
         h+uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689806906; x=1692398906;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MEInahlEsHjcSww3xlsFFaRjkkq9xhhzX3ommlPB214=;
        b=TJTVfMNpyjKSyvPz7ElZd4HzrooQmsDZ6nj1k5KYtLgh+n/+KeNLARtGwhun7UmnEu
         1074MIdD14dQXLhRw6QE9j5rzMSn7A9KmlymbmkpPsmbhhZNcjk2oqSDZ2XsC355ZzJW
         nAMB865ALjf2PFGOaMzBIOsbDrElAMtZ1xm5L08GhDk5DhEr36HYHj3CG5I04l9TgSAP
         do65jbOx0XJJa5IadRNee6s2uoIAKoe7GP//qSVlNb5PDCNVpVY7fr7ZPQEtrosMGzD9
         W4eMSrZLxtrxwBbAzzaYN+YIJ38cRGnPjryY7mkc+UNavZtOFFl95vVjGLzuKozfVlcG
         y6ZA==
X-Gm-Message-State: ABy/qLZ9R+aTlYFUx2GYj7TNyg3Xt+Gt5dUYefhopl76x9SgDmUSb5sp
        365xhZOm8adACpNsDaz/klZspBQu6SyRtanw8gGHQg==
X-Google-Smtp-Source: APBJJlHG2p5kJkjtlR54T+n8e3Fhz/nng4jNTrNeUYgDF4OxcLYDA4PP4lkpT+l8Zh2rIK0GXczqjQ==
X-Received: by 2002:a6b:fb0f:0:b0:784:e618:e6cd with SMTP id h15-20020a6bfb0f000000b00784e618e6cdmr695079iog.20.1689806905915;
        Wed, 19 Jul 2023 15:48:25 -0700 (PDT)
Received: from google.com ([2620:15c:183:200:84dc:2218:a741:ad50])
        by smtp.gmail.com with ESMTPSA id y20-20020a5ec814000000b00786fd8e764bsm1659096iol.0.2023.07.19.15.48.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jul 2023 15:48:25 -0700 (PDT)
Date:   Wed, 19 Jul 2023 16:48:21 -0600
From:   Ross Zwisler <zwisler@google.com>
To:     Michal Hocko <mhocko@suse.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>, Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>
Subject: Re: collision between ZONE_MOVABLE and memblock allocations
Message-ID: <20230719224821.GC3528218@google.com>
References: <20230718220106.GA3117638@google.com>
 <ZLd/WEZTH5rlwYjP@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZLd/WEZTH5rlwYjP@dhcp22.suse.cz>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,FSL_HELO_FAKE,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 19, 2023 at 08:14:48AM +0200, Michal Hocko wrote:
> On Tue 18-07-23 16:01:06, Ross Zwisler wrote:
> [...]
> > I do think that we need to fix this collision between ZONE_MOVABLE and memmap
> > allocations, because this issue essentially makes the movablecore= kernel
> > command line parameter useless in many cases, as the ZONE_MOVABLE region it
> > creates will often actually be unmovable.
> 
> movablecore is kinda hack and I would be more inclined to get rid of it
> rather than build more into it. Could you be more specific about your
> use case?

The problem that I'm trying to solve is that I'd like to be able to get kernel
core dumps off machines (chromebooks) so that we can debug crashes.  Because
the memory used by the crash kernel ("crashkernel=" kernel command line
option) is consumed the entire time the machine is booted, there is a strong
motivation to keep the crash kernel as small and as simple as possible.  To
this end I'm trying to get away without SSD drivers, not having to worry about
encryption on the SSDs, etc.

So, the rough plan right now is:

1) During boot set aside some memory that won't contain kernel allocations.
I'm trying to do this now with ZONE_MOVABLE, but I'm open to better ways.

We set aside memory for a crash kernel & arm it so that the ZONE_MOVABLE
region (or whatever non-kernel region) will be set aside as PMEM in the crash
kernel.  This is done with the memmap=nn[KMG]!ss[KMG] kernel command line
parameter passed to the crash kernel.

So, in my sample 4G VM system, I see:

  # lsmem --split ZONES --output-all
  RANGE                                  SIZE  STATE REMOVABLE BLOCK NODE   ZONES
  0x0000000000000000-0x0000000007ffffff  128M online       yes     0    0    None
  0x0000000008000000-0x00000000bfffffff  2.9G online       yes  1-23    0   DMA32
  0x0000000100000000-0x000000012fffffff  768M online       yes 32-37    0  Normal
  0x0000000130000000-0x000000013fffffff  256M online       yes 38-39    0 Movable
  
  Memory block size:       128M
  Total online memory:       4G
  Total offline memory:      0B

so I'll pass "memmap=256M!0x130000000" to the crash kernel.

2) When we hit a kernel crash, we know (hope?) that the PMEM region we've set
aside only contains user data, which we don't want to store anyway.  We make a
filesystem in there, and create a kernel crash dump using 'makedumpfile':

  mkfs.ext4 /dev/pmem0
  mount /dev/pmem0 /mnt
  makedumpfile -c -d 31 /proc/vmcore /mnt/kdump

We then set up the next full kernel boot to also have this same PMEM region,
using the same memmap kernel parameter.  We reboot back into a full kernel.

3) The next full kernel will be a normal boot with a full networking stack,
SSD drivers, disk encryption, etc.  We mount up our PMEM filesystem, pull out
the kdump and either store it somewhere persistent or upload it somewhere.  We
can then unmount the PMEM and reconfigure it back to system ram so that the
live system isn't missing memory.

  ndctl create-namespace --reconfig=namespace0.0 -m devdax -f
  daxctl reconfigure-device --mode=system-ram dax0.0

This is the flow I'm trying to support, and have mostly working in a VM,
except up until now makedumpfile would crash because all the memblock
structures it needed were in the PMEM area that I had just wiped out by making
a new filesystem. :)

Do you see any blockers that would make this infeasible?

For the non-kernel memory, is the ZONE_MOVABLE path that I'm currently
pursuing the best option, or would we be better off with your suggestion
elsewhere in this thread:

> If the spefic placement of the movable memory is not important and the only
> thing that matters is the size and numa locality then an easier to maintain
> solution would be to simply offline enough memory blocks very early in the
> userspace bring up and online it back as movable. If offlining fails just
> try another memblock. This doesn't require any kernel code change.

If this 2nd way is preferred, can you point me to how I can offline the memory
blocks & then get them back later in boot?

Thanks for the help!
- Ross

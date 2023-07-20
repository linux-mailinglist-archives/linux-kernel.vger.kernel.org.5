Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D645975A829
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 09:50:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231776AbjGTHuA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 03:50:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231748AbjGTHty (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 03:49:54 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42D3B26B2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 00:49:43 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 206D720564;
        Thu, 20 Jul 2023 07:49:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1689839376; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lRC0RZqoqHV1iZY41MWNjsNJG0i4hN0HBuJmKMyE0Wo=;
        b=aQCzKzGBMeKi2sz6zlSxFkgL6KNrlffTJAKxJ6W/tSXCyraqlNP8363C5ZdtM+eUPG7SYq
        OaQTD+7y/8DeJNf1nuta4obUaMKlHOr/zxlTsadPxS/XvzTGMs86rsmOIiw7o+i3yOnBX0
        /GSI5f9uVgZk+AnvtksAvwDvNa59EhA=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 12050138EC;
        Thu, 20 Jul 2023 07:49:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 6/KNAxDnuGSAEQAAMHmgww
        (envelope-from <mhocko@suse.com>); Thu, 20 Jul 2023 07:49:36 +0000
Date:   Thu, 20 Jul 2023 09:49:35 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Ross Zwisler <zwisler@google.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>, Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>,
        Jiri Bohac <jbohac@suse.cz>
Subject: Re: collision between ZONE_MOVABLE and memblock allocations
Message-ID: <ZLjnDzTdXPlM3KY6@dhcp22.suse.cz>
References: <20230718220106.GA3117638@google.com>
 <ZLd/WEZTH5rlwYjP@dhcp22.suse.cz>
 <20230719224821.GC3528218@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230719224821.GC3528218@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[CC Jiri Bohac]

On Wed 19-07-23 16:48:21, Ross Zwisler wrote:
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
> 
> The problem that I'm trying to solve is that I'd like to be able to get kernel
> core dumps off machines (chromebooks) so that we can debug crashes.  Because
> the memory used by the crash kernel ("crashkernel=" kernel command line
> option) is consumed the entire time the machine is booted, there is a strong
> motivation to keep the crash kernel as small and as simple as possible.  To
> this end I'm trying to get away without SSD drivers, not having to worry about
> encryption on the SSDs, etc.

This is something Jiri is also looking into.
 
> So, the rough plan right now is:
> 
> 1) During boot set aside some memory that won't contain kernel allocations.
> I'm trying to do this now with ZONE_MOVABLE, but I'm open to better ways.
> 
> We set aside memory for a crash kernel & arm it so that the ZONE_MOVABLE
> region (or whatever non-kernel region) will be set aside as PMEM in the crash
> kernel.  This is done with the memmap=nn[KMG]!ss[KMG] kernel command line
> parameter passed to the crash kernel.
> 
> So, in my sample 4G VM system, I see:
> 
>   # lsmem --split ZONES --output-all
>   RANGE                                  SIZE  STATE REMOVABLE BLOCK NODE   ZONES
>   0x0000000000000000-0x0000000007ffffff  128M online       yes     0    0    None
>   0x0000000008000000-0x00000000bfffffff  2.9G online       yes  1-23    0   DMA32
>   0x0000000100000000-0x000000012fffffff  768M online       yes 32-37    0  Normal
>   0x0000000130000000-0x000000013fffffff  256M online       yes 38-39    0 Movable
>   
>   Memory block size:       128M
>   Total online memory:       4G
>   Total offline memory:      0B
> 
> so I'll pass "memmap=256M!0x130000000" to the crash kernel.
> 
> 2) When we hit a kernel crash, we know (hope?) that the PMEM region we've set
> aside only contains user data, which we don't want to store anyway.  We make a
> filesystem in there, and create a kernel crash dump using 'makedumpfile':
> 
>   mkfs.ext4 /dev/pmem0
>   mount /dev/pmem0 /mnt
>   makedumpfile -c -d 31 /proc/vmcore /mnt/kdump
> 
> We then set up the next full kernel boot to also have this same PMEM region,
> using the same memmap kernel parameter.  We reboot back into a full kernel.
> 
> 3) The next full kernel will be a normal boot with a full networking stack,
> SSD drivers, disk encryption, etc.  We mount up our PMEM filesystem, pull out
> the kdump and either store it somewhere persistent or upload it somewhere.  We
> can then unmount the PMEM and reconfigure it back to system ram so that the
> live system isn't missing memory.
> 
>   ndctl create-namespace --reconfig=namespace0.0 -m devdax -f
>   daxctl reconfigure-device --mode=system-ram dax0.0
> 
> This is the flow I'm trying to support, and have mostly working in a VM,
> except up until now makedumpfile would crash because all the memblock
> structures it needed were in the PMEM area that I had just wiped out by making
> a new filesystem. :)
> 
> Do you see any blockers that would make this infeasible?
> 
> For the non-kernel memory, is the ZONE_MOVABLE path that I'm currently
> pursuing the best option, or would we be better off with your suggestion
> elsewhere in this thread:

The main problem I would see with this approach is that the small
Movable zone you set aside would be easily consumed and reclaimed. That
could generate some unexpected performance artifacts. We used to see
those with small zones or large differences in zone sizes in the past.
But functionally this should work. Or I do not see any fundamental
problems at least.

Jiri is looking at this from a slightly different angle. Very broadly,
he would like to have a dedicated CMA pool and reuse that for the
kernel memory (dropping anything sitting there) when crashing.
GFP_MOVABLE allocations can use CMA pools.

> > If the spefic placement of the movable memory is not important and the only
> > thing that matters is the size and numa locality then an easier to maintain
> > solution would be to simply offline enough memory blocks very early in the
> > userspace bring up and online it back as movable. If offlining fails just
> > try another memblock. This doesn't require any kernel code change.
> 
> If this 2nd way is preferred, can you point me to how I can offline the memory
> blocks & then get them back later in boot?

/bin/echo offline > /sys/devices/system/memory/memory$NUM/state && \
echo online_movable > /sys/devices/system/memory/memory$NUM/state

more in Documentation/admin-guide/mm/memory-hotplug.rst

-- 
Michal Hocko
SUSE Labs

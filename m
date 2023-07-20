Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C099E75AE00
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 14:13:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230053AbjGTMNd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 08:13:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbjGTMNb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 08:13:31 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 585102106
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 05:13:27 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 0BF3D20505;
        Thu, 20 Jul 2023 12:13:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1689855206; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=z8W41ZNTIwKt+2Nk7HZ0tWIn8uIgWXqjgIN9VIsXFfg=;
        b=RZi4dFEkrVEPhleKd9t89JcanOoz6QOVGM9Zk9Nu70dWLuPSu8pIZm8QbloSRQj4hOSJi0
        jzLuqZXdxLNS9Xe27DpPVygI+TwySrUAn8Kxcee7aMc6e/h8oqNBpLYmcIngd/oB+NiEt6
        zQg1I2w6HoV4qftlFEbWYu4M2SXceLc=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EF9C1138EC;
        Thu, 20 Jul 2023 12:13:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id tuj6N+UkuWQ5JAAAMHmgww
        (envelope-from <mhocko@suse.com>); Thu, 20 Jul 2023 12:13:25 +0000
Date:   Thu, 20 Jul 2023 14:13:25 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Ross Zwisler <zwisler@google.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>, Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>
Subject: Re: collision between ZONE_MOVABLE and memblock allocations
Message-ID: <ZLkk5Z3jGT88is5g@dhcp22.suse.cz>
References: <20230718220106.GA3117638@google.com>
 <ZLd/WEZTH5rlwYjP@dhcp22.suse.cz>
 <20230719224821.GC3528218@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230719224821.GC3528218@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
> 
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

Btw. How do you ensure that the address range doesn't get reinitialized
by POST? Do you rely on kexec boot here?
-- 
Michal Hocko
SUSE Labs

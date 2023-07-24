Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3860375FCBE
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 18:56:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231330AbjGXQ4q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 12:56:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjGXQ4l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 12:56:41 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E76CCFA
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 09:56:39 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id ca18e2360f4ac-7837329a00aso203387339f.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 09:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690217799; x=1690822599;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=h1BawSFeKkQp75BQDYvDzIq+nGzVfTgNWo74YLqiWag=;
        b=0Di7l/A21DoRGVwSScxYjAwwf2wr0vBXtlcLiqdjBt47aG9QdoJF39hVuMLPdVP5Rq
         O28YcrSwMCcTFviUZxbru+ThXscv8Nl/53zM863TvQOVsvnlL3trmSfDmpwh0rqiEC0x
         TbkXAIxRgYAwIBvln2Gl5a+29o+3DXyuE+nnFY8A6wvyo12JnOFtZqlrVGbjQe9V3zph
         5e7vJuy4Gc2s6WjsIEzm2v4XA+09cB+RlR2r+OvlMsFFsAaEuZRQfxluqeD16KPu7mph
         LIoW+MP8llkdt8QxYgSywKn/UN0pDCs/hnYX0FIyCmooMJfFkEs8+X1GPpx6HTb6NP6k
         KUBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690217799; x=1690822599;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h1BawSFeKkQp75BQDYvDzIq+nGzVfTgNWo74YLqiWag=;
        b=QP2yz7i8Ni4xb9rUpscUk3pML7XKRwmEaCr3kSJGP7WAJ8NZYSGs+vys8MEQhlrfw1
         ulTRE3XPMw/LaOW0LlC9x3XCv6Jjb0jIL3/tjQYj4Xr29R3n0waWR7v6fmA5o0lRIHpq
         LG0Q6AU2RQXPduvw87v/Onj+fAyp0eybHYbP3pHGXiG+bdBujYoWZc6Ox/iYwI5WY9xL
         ckDo0fIdKc7/DiU5txtk2ejh1IdAndeyKKv80EWo5GirWMcwHFEtASBGjw0TTlJuiBBB
         z/82/5Gfesi3JBBS8aF2WJ6wHVlpHrVCre4xx/de8a4KiMQ2GeUaesvL1//u5rQU6lN1
         /5cg==
X-Gm-Message-State: ABy/qLYgDLmI6gs44jxcQ5wMUmjLiOMZNWTj4TU/BmPNZdOuXav5zgn3
        TD/6I9zquJlztqqGqAjFVYI50w==
X-Google-Smtp-Source: APBJJlFGNB7cLBhkP74vkaL08AgDWHiguohc1Ze12ev5+LItdOXqFFru745rS9RyPQHvKtQhT8HCOA==
X-Received: by 2002:a6b:916:0:b0:780:ce89:ca73 with SMTP id t22-20020a6b0916000000b00780ce89ca73mr477988ioi.14.1690217799172;
        Mon, 24 Jul 2023 09:56:39 -0700 (PDT)
Received: from google.com ([2620:15c:183:200:5e44:ee40:d817:ec4a])
        by smtp.gmail.com with ESMTPSA id m18-20020a02c892000000b0041d859c5721sm3071026jao.64.2023.07.24.09.56.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jul 2023 09:56:38 -0700 (PDT)
Date:   Mon, 24 Jul 2023 10:56:35 -0600
From:   Ross Zwisler <zwisler@google.com>
To:     Michal Hocko <mhocko@suse.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>, Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>
Subject: Re: collision between ZONE_MOVABLE and memblock allocations
Message-ID: <20230724165635.GA20994@google.com>
References: <20230718220106.GA3117638@google.com>
 <ZLd/WEZTH5rlwYjP@dhcp22.suse.cz>
 <20230719224821.GC3528218@google.com>
 <ZLkk5Z3jGT88is5g@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZLkk5Z3jGT88is5g@dhcp22.suse.cz>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,FSL_HELO_FAKE,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 20, 2023 at 02:13:25PM +0200, Michal Hocko wrote:
> On Wed 19-07-23 16:48:21, Ross Zwisler wrote:
> > On Wed, Jul 19, 2023 at 08:14:48AM +0200, Michal Hocko wrote:
> > > On Tue 18-07-23 16:01:06, Ross Zwisler wrote:
> > > [...]
> > > > I do think that we need to fix this collision between ZONE_MOVABLE and memmap
> > > > allocations, because this issue essentially makes the movablecore= kernel
> > > > command line parameter useless in many cases, as the ZONE_MOVABLE region it
> > > > creates will often actually be unmovable.
> > > 
> > > movablecore is kinda hack and I would be more inclined to get rid of it
> > > rather than build more into it. Could you be more specific about your
> > > use case?
> > 
> > The problem that I'm trying to solve is that I'd like to be able to get kernel
> > core dumps off machines (chromebooks) so that we can debug crashes.  Because
> > the memory used by the crash kernel ("crashkernel=" kernel command line
> > option) is consumed the entire time the machine is booted, there is a strong
> > motivation to keep the crash kernel as small and as simple as possible.  To
> > this end I'm trying to get away without SSD drivers, not having to worry about
> > encryption on the SSDs, etc.
> > 
> > So, the rough plan right now is:
> > 
> > 1) During boot set aside some memory that won't contain kernel allocations.
> > I'm trying to do this now with ZONE_MOVABLE, but I'm open to better ways.
> > 
> > We set aside memory for a crash kernel & arm it so that the ZONE_MOVABLE
> > region (or whatever non-kernel region) will be set aside as PMEM in the crash
> > kernel.  This is done with the memmap=nn[KMG]!ss[KMG] kernel command line
> > parameter passed to the crash kernel.
> > 
> > So, in my sample 4G VM system, I see:
> > 
> >   # lsmem --split ZONES --output-all
> >   RANGE                                  SIZE  STATE REMOVABLE BLOCK NODE   ZONES
> >   0x0000000000000000-0x0000000007ffffff  128M online       yes     0    0    None
> >   0x0000000008000000-0x00000000bfffffff  2.9G online       yes  1-23    0   DMA32
> >   0x0000000100000000-0x000000012fffffff  768M online       yes 32-37    0  Normal
> >   0x0000000130000000-0x000000013fffffff  256M online       yes 38-39    0 Movable
> >   
> >   Memory block size:       128M
> >   Total online memory:       4G
> >   Total offline memory:      0B
> > 
> > so I'll pass "memmap=256M!0x130000000" to the crash kernel.
> > 
> > 2) When we hit a kernel crash, we know (hope?) that the PMEM region we've set
> > aside only contains user data, which we don't want to store anyway.  We make a
> > filesystem in there, and create a kernel crash dump using 'makedumpfile':
> > 
> >   mkfs.ext4 /dev/pmem0
> >   mount /dev/pmem0 /mnt
> >   makedumpfile -c -d 31 /proc/vmcore /mnt/kdump
> > 
> > We then set up the next full kernel boot to also have this same PMEM region,
> > using the same memmap kernel parameter.  We reboot back into a full kernel.
> 
> Btw. How do you ensure that the address range doesn't get reinitialized
> by POST? Do you rely on kexec boot here?

I've been working under the assumption that I do need to do a full reboot (not
just another kexec boot) so that the devices in the system (NICs, disks, etc)
are all reinitialized and don't carry over bad state from the crash.

I do know about the 'reset_devices' kernel command line parameter, but wasn't
sure that would be enough.  From looking around it seems like this is very
driver + device dependent, so maybe I just need to test more.

In any case, you're right, if we do a full reboot and go through POST, it's
system dependent on whether BIOS/UEFI/Coreboot/etc will zero memory, and if it
does this feature won't work unless we kexec to the 3rd kernel.

I've also heard concerns around whether a full reboot will cause the memory
controller to reinitialize and potentially cause memory bit flips or similar,
though I haven't yet seen this myself.  Has anyone seen such bit flips /
memory corruption due to system reboot, or is this a non-issue in your
experience?

Lots to figure out, thanks for the help. :)

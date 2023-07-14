Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93F80753C07
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 15:49:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235423AbjGNNtH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 09:49:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235217AbjGNNtF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 09:49:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C06D3271E
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 06:48:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689342497;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xinDoQRdcE5sxZPT6WiHl1eOgAOzV50L/CpzwNIn2nE=;
        b=F+062NFpQ8JV9QQl7Xw2Tvlbqv3oSLlKFH55XOEeBnc4wZpdrlWzADResF36eJA+UiSiiN
        OuMUOdU3CqcckCUW/zLB47NKUWKiUMgdlrbJDRWd4gOROQGRU8JazMr9UmemuQ/ogAfB5e
        y3UMH9JDnaNs86E6jlabC5k6zmSF8G0=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-279-JvoMrE8ZMvyfp9R_BeIRTQ-1; Fri, 14 Jul 2023 09:48:13 -0400
X-MC-Unique: JvoMrE8ZMvyfp9R_BeIRTQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C0E221C0419A;
        Fri, 14 Jul 2023 13:48:12 +0000 (UTC)
Received: from segfault.boston.devel.redhat.com (segfault.boston.devel.redhat.com [10.19.60.26])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 312B41454142;
        Fri, 14 Jul 2023 13:48:12 +0000 (UTC)
From:   Jeff Moyer <jmoyer@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        Dave Jiang <dave.jiang@intel.com>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org,
        Huang Ying <ying.huang@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCH 0/3] mm: use memmap_on_memory semantics for dax/kmem
References: <20230613-vv-kmem_memmap-v1-0-f6de9c6af2c6@intel.com>
        <29c9b998-f453-59f2-5084-9b4482b489cf@redhat.com>
        <x49fs5r7hj1.fsf@segfault.boston.devel.redhat.com>
        <cfeecd92-3aa4-a07d-b71a-793531785692@redhat.com>
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
Date:   Fri, 14 Jul 2023 09:54:02 -0400
In-Reply-To: <cfeecd92-3aa4-a07d-b71a-793531785692@redhat.com> (David
        Hildenbrand's message of "Fri, 14 Jul 2023 10:35:47 +0200")
Message-ID: <x491qha7g5h.fsf@segfault.boston.devel.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

David Hildenbrand <david@redhat.com> writes:

> On 13.07.23 21:12, Jeff Moyer wrote:
>> David Hildenbrand <david@redhat.com> writes:
>>
>>> On 16.06.23 00:00, Vishal Verma wrote:
>>>> The dax/kmem driver can potentially hot-add large amounts of memory
>>>> originating from CXL memory expanders, or NVDIMMs, or other 'device
>>>> memories'. There is a chance there isn't enough regular system memory
>>>> available to fit ythe memmap for this new memory. It's therefore
>>>> desirable, if all other conditions are met, for the kmem managed memory
>>>> to place its memmap on the newly added memory itself.
>>>>
>>>> Arrange for this by first allowing for a module parameter override for
>>>> the mhp_supports_memmap_on_memory() test using a flag, adjusting the
>>>> only other caller of this interface in dirvers/acpi/acpi_memoryhotplug=
.c,
>>>> exporting the symbol so it can be called by kmem.c, and finally changi=
ng
>>>> the kmem driver to add_memory() in chunks of memory_block_size_bytes().
>>>
>>> 1) Why is the override a requirement here? Just let the admin
>>> configure it then then add conditional support for kmem.
>>>
>>> 2) I recall that there are cases where we don't want the memmap to
>>> land on slow memory (which online_movable would achieve). Just imagine
>>> the slow PMEM case. So this might need another configuration knob on
>>> the kmem side.
>>
>>  From my memory, the case where you don't want the memmap to land on
>> *persistent memory* is when the device is small (such as NVDIMM-N), and
>> you want to reserve as much space as possible for the application data.
>> This has nothing to do with the speed of access.
>
> Now that you mention it, I also do remember the origin of the altmap --
> to achieve exactly that: place the memmap on the device.
>
> commit 4b94ffdc4163bae1ec73b6e977ffb7a7da3d06d3
> Author: Dan Williams <dan.j.williams@intel.com>
> Date:   Fri Jan 15 16:56:22 2016 -0800
>
>     x86, mm: introduce vmem_altmap to augment vmemmap_populate()
>       In support of providing struct page for large persistent memory
>     capacities, use struct vmem_altmap to change the default policy for
>     allocating memory for the memmap array.  The default vmemmap_populate=
()
>     allocates page table storage area from the page allocator.  Given
>     persistent memory capacities relative to DRAM it may not be feasible =
to
>     store the memmap in 'System Memory'.  Instead vmem_altmap represents
>     pre-allocated "device pages" to satisfy vmemmap_alloc_block_buf()
>     requests.
>
> In PFN_MODE_PMEM (and only then), we use the altmap (don't see a way to
> configure it).

Configuration is done at pmem namespace creation time.  The metadata for
the namespace indicates where the memmap resides.  See the
ndctl-create-namespace man page:

       -M, --map=3D
           A pmem namespace in "fsdax" or "devdax" mode requires allocation=
 of
           per-page metadata. The allocation can be drawn from either:

           =C2=B7   "mem": typical system memory

           =C2=B7   "dev": persistent memory reserved from the namespace

                   Given relative capacities of "Persistent Memory" to "Sys=
tem
                   RAM" the allocation defaults to reserving space out of t=
he
                   namespace directly ("--map=3Ddev"). The overhead is 64-b=
ytes per
                   4K (16GB per 1TB) on x86.

> BUT that case is completely different from the "System RAM" mode. The mem=
map
> of an NVDIMM in pmem mode is barely used by core-mm (i.e., not the buddy).

Right.  (btw, I don't think system ram mode existed back then.)

> In comparison, if the buddy and everybody else works on the memmap in
> "System RAM", it's much more significant if that resides on slow memory.

Agreed.

> Looking at
>
> commit 9b6e63cbf85b89b2dbffa4955dbf2df8250e5375
> Author: Michal Hocko <mhocko@suse.com>
> Date:   Tue Oct 3 16:16:19 2017 -0700
>
>     mm, page_alloc: add scheduling point to memmap_init_zone
>       memmap_init_zone gets a pfn range to initialize and it can be
> really
>     large resulting in a soft lockup on non-preemptible kernels
>         NMI watchdog: BUG: soft lockup - CPU#31 stuck for 23s!
> [kworker/u642:5:1720]
>       [...]
>       task: ffff88ecd7e902c0 ti: ffff88eca4e50000 task.ti: ffff88eca4e500=
00
>       RIP: move_pfn_range_to_zone+0x185/0x1d0
>       [...]
>       Call Trace:
>         devm_memremap_pages+0x2c7/0x430
>         pmem_attach_disk+0x2fd/0x3f0 [nd_pmem]
>         nvdimm_bus_probe+0x64/0x110 [libnvdimm]
>
>
> It's hard to tell if that was only required due to the memmap for these d=
evices
> being that large, or also partially because the access to the memmap is s=
lower
> that it makes a real difference.

I believe the main driver was the size.  At the time, Intel was
advertising 3TiB/socket for pmem.  I can't remember the exact DRAM
configuration sizes from the time.

> I recall that we're also often using ZONE_MOVABLE on such slow memory
> to not end up placing other kernel data structures on there: especially,
> user space page tables as I've been told.

Part of the issue was preserving the media.  The page structure gets
lots of updates, and that could cause premature wear.

> @Dan, any insight on the performance aspects when placing the memmap on
> (slow) memory and having that memory be consumed by the buddy where we fr=
equently
> operate on the memmap?

I'm glad you're asking these questions.  We definitely want to make sure
we don't conflate requirements based on some particular
technology/implementation.  Also, I wouldn't make any assumptions about
the performance of CXL devices.  As I understand it, there could be a
broad spectrum of performance profiles.

And now Dan can correct anything I got wrong.  ;-)

Cheers,
Jeff


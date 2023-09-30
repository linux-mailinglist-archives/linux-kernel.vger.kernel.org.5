Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E37917B3FA2
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Sep 2023 11:11:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232685AbjI3JLr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Sep 2023 05:11:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbjI3JLp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Sep 2023 05:11:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A6281A4
        for <linux-kernel@vger.kernel.org>; Sat, 30 Sep 2023 02:10:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696065057;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UPWXUz5xFoBIqUnArR4JRWxPC09psvlsazRlR/JX6bI=;
        b=Oc4dmTWEAU4Xco7fQicf0yifNPldMr4GjqwBgloqQgvHqDIBGHzy0IWCwlcU3P2OTkrf5X
        a3rNHnS9UpVK63kKjWTQLxkWR1BuaGBruUswI/2+RTS7aZ6QQuGeN+4Vq0WslFQKZRS3+V
        gSOAHfSN5JhDGyMStRRl4b46asbaEeQ=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-635-DKlSVvnzMzS0JasWQtp-Dw-1; Sat, 30 Sep 2023 05:10:53 -0400
X-MC-Unique: DKlSVvnzMzS0JasWQtp-Dw-1
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-77578227e4bso692325385a.2
        for <linux-kernel@vger.kernel.org>; Sat, 30 Sep 2023 02:10:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696065053; x=1696669853;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UPWXUz5xFoBIqUnArR4JRWxPC09psvlsazRlR/JX6bI=;
        b=PTZWplTfulVDpylr28mk264+H6WUYJ8efv/ORzUQkSDiX/9UKG1zDSRr6xXgLGfw/3
         UZAEPiMn0adL6jihYb0qdC0CLHBPxPK04AttOMYOM/84NMUtiip4IY1wA+l/vCC8sxIj
         Ur83njGtc4BT0MM/5zYlOyU6x7RIcAEnR14ek64cbzTIaBu/jPER+uL+erpJ8VkhLWkh
         C//N6JXj291JEg9NpM+F8oJUo923JkZz2Fcyq5bA4GI+KomxKBhIC6L8N7tiDNHmsJTz
         uJfv5qBPToWG815DWwnMBqBprVadzLjjPutoOPwKsmSyYWXSZwQeEWMYZ1ob65HWqzot
         ateQ==
X-Gm-Message-State: AOJu0YxRVsfA1KZvxsdpWXjw/YU2SLZv/MONbk9X+9OdsjWdGjptCmk+
        HKh2LndMiRGPJtDy14tsqJSaHK23cg/481Rmf5jmd7lju8oejfPi+y1W4Vx55wvYrKVDCj+S+ox
        nRKFrYeNOsB64A1CmtX7zMyTE
X-Received: by 2002:a0c:df08:0:b0:658:4008:e2ba with SMTP id g8-20020a0cdf08000000b006584008e2bamr5489069qvl.63.1696065053000;
        Sat, 30 Sep 2023 02:10:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE56LNXHwXdZYQD+TSBlp5hcvvEHvpjv1FySU1EeuW4NIJz6A3QVslPfd2pXr6ysltdBKNDrg==
X-Received: by 2002:a0c:df08:0:b0:658:4008:e2ba with SMTP id g8-20020a0cdf08000000b006584008e2bamr5489053qvl.63.1696065052586;
        Sat, 30 Sep 2023 02:10:52 -0700 (PDT)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id o8-20020a0cf4c8000000b0065b260eafd9sm3658278qvm.87.2023.09.30.02.10.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Sep 2023 02:10:51 -0700 (PDT)
Date:   Sat, 30 Sep 2023 02:10:50 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Chris Leech <cleech@redhat.com>, Christoph Hellwig <hch@lst.de>,
        Rasesh Mody <rmody@marvell.com>,
        Ariel Elior <aelior@marvell.com>,
        Sudarsana Kalluru <skalluru@marvell.com>,
        Manish Chopra <manishc@marvell.com>,
        Nilesh Javali <njavali@marvell.com>,
        Manish Rangankar <mrangankar@marvell.com>,
        John Meneghini <jmeneghi@redhat.com>,
        Lee Duncan <lduncan@suse.com>,
        Mike Christie <michael.christie@oracle.com>,
        Hannes Reinecke <hare@kernel.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] cnic,bnx2,bnx2x: use UIO_MEM_DMA_COHERENT
Message-ID: <yfws24bzfebts5mr7n7y4dekjlrhlbbk6afr6vgbducpx4j2wh@iiftl57eonc6>
References: <20230929170023.1020032-1-cleech@redhat.com>
 <20230929170023.1020032-4-cleech@redhat.com>
 <2023093055-gotten-astronomy-a98b@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023093055-gotten-astronomy-a98b@gregkh>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 30, 2023 at 09:06:51AM +0200, Greg Kroah-Hartman wrote:
> On Fri, Sep 29, 2023 at 10:00:23AM -0700, Chris Leech wrote:
> > Make use of the new UIO_MEM_DMA_COHERENT type to properly handle mmap
> > for dma_alloc_coherent buffers.
> 
> Why are ethernet drivers messing around with UIO devices?  That's not
> what UIO is for, unless you are trying to do kernel bypass for these
> devices without anyone noticing?
> 
> confused,
> 
> greg k-h

Hi Greg,

It is for iscsi offload [1], and apparently cnic has been handing off
dma alloc'd memory to uio for this since 2009, but it has just been
handing off the address from dma_alloc_coherent to uio, and giving the
dma handle the bnx2x device. That managed to avoid being an issue
until changes last year rightly cleaned up allowing __GFP_COMP to be
passed to the dma_alloc* calls, which cnic was passing to
dma_alloc_coherent. Now iscsiuio goes to mmap through the uio device
and the result is a BUG and stack trace like below.

It was my suggestion that it either needs to use dma_mmap_coherent to
mmap the memory, which possibly is a mistaken understanding on my
part but what dma_mmap_coherent says it is for, or possibly look to
do something similar to what qed is doing for uio.

Regards,
Jerry


[  129.196731] page:ffffea0004cacb40 refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x132b2d
[  129.207285] flags: 0x17ffffc0000000(node=0|zone=2|lastcpupid=0x1fffff)
[  129.214650] page_type: 0xffffffff()
[  129.218584] raw: 0017ffffc0000000 dead000000000100 dead000000000122 0000000000000000
[  129.227264] raw: 0000000000000000 0000000000000000 00000000ffffffff 0000000000000000
[  129.235937] page dumped because: VM_BUG_ON_FOLIO(((unsigned int) folio_ref_count(folio) + 127u <= 127u))
[  129.246632] ------------[ cut here ]------------
[  129.251817] kernel BUG at include/linux/mm.h:1441!
[  129.257209] invalid opcode: 0000 [#1] PREEMPT SMP KASAN PTI
[  129.263440] CPU: 1 PID: 1930 Comm: iscsiuio Kdump: loaded Not tainted 6.6.0-0.rc3.26.eln130.x86_64+debug #1
[  129.274323] Hardware name: Dell Inc. PowerEdge R320/08VT7V, BIOS 2.4.2 01/29/2015
[  129.282682] RIP: 0010:uio_vma_fault+0x40e/0x520 [uio]
[  129.288345] Code: 49 83 ee 01 e9 db fe ff ff be 01 00 00 00 4c 89 f7 e8 96 7f ae e9 e9 2b ff ff ff 48 c7 c6 00 08 52 c1 4c 89 f7 e8 12 1b 8e e9 <0f> 0b e8 cb 7b a3 e9 e9 f6 fd ff ff bb 02 00 00 00 e9 2b ff ff ff
[  129.309311] RSP: 0018:ffffc900022878b0 EFLAGS: 00010246
[  129.315156] RAX: 000000000000005c RBX: ffffea0004cacb40 RCX: 0000000000000000
[  129.323130] RDX: 0000000000000000 RSI: ffffffffad380f00 RDI: 0000000000000001
[  129.331102] RBP: ffff8881a65da528 R08: 0000000000000001 R09: fffff52000450eca
[  129.339074] R10: ffffc90002287657 R11: 0000000000000001 R12: ffffea0004cacb74
[  129.347044] R13: ffffc900022879f8 R14: ffffea0004cacb40 R15: ffff8881946a0400
[  129.355015] FS:  00007fc6dcafe640(0000) GS:ffff8885cb800000(0000) knlGS:0000000000000000
[  129.364054] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  129.370474] CR2: 000055b5c9f091a0 CR3: 0000000162292001 CR4: 00000000001706e0
[  129.378446] Call Trace:
[  129.381183]  <TASK>
[  129.383532]  ? die+0x36/0x90
[  129.386765]  ? do_trap+0x199/0x240
[  129.390573]  ? uio_vma_fault+0x40e/0x520 [uio]
[  129.395560]  ? uio_vma_fault+0x40e/0x520 [uio]
[  129.400539]  ? do_error_trap+0xa3/0x170
[  129.404830]  ? uio_vma_fault+0x40e/0x520 [uio]
[  129.409815]  ? handle_invalid_op+0x2c/0x40
[  129.414395]  ? uio_vma_fault+0x40e/0x520 [uio]
[  129.419361]  ? exc_invalid_op+0x2d/0x40
[  129.423657]  ? asm_exc_invalid_op+0x1a/0x20
[  129.428332]  ? uio_vma_fault+0x40e/0x520 [uio]
[  129.433301]  __do_fault+0xf2/0x5a0
[  129.437103]  do_fault+0x68e/0xc30
[  129.440804]  ? __pfx___pte_offset_map_lock+0x10/0x10
[  129.446350]  __handle_mm_fault+0x8e0/0xeb0
[  129.450939]  ? follow_page_pte+0x29a/0xda0
[  129.455513]  ? __pfx___handle_mm_fault+0x10/0x10
[  129.460668]  ? __pfx_follow_page_pte+0x10/0x10
[  129.465626]  ? follow_pmd_mask.isra.0+0x1d4/0xab0
[  129.470877]  ? count_memcg_event_mm.part.0+0xc7/0x1f0
[  129.476515]  ? rcu_is_watching+0x15/0xb0
[  129.480896]  handle_mm_fault+0x2f2/0x8d0
[  129.485277]  ? check_vma_flags+0x1c2/0x420
[  129.489852]  __get_user_pages+0x333/0xa20
[  129.494331]  ? __pfx___get_user_pages+0x10/0x10
[  129.499389]  ? __pfx_mt_find+0x10/0x10
[  129.503568]  ? __mm_populate+0xe7/0x360
[  129.507850]  ? rcu_is_watching+0x15/0xb0
[  129.512231]  populate_vma_page_range+0x1e9/0x2d0
[  129.517388]  ? __pfx_populate_vma_page_range+0x10/0x10
[  129.523125]  ? __pfx_mmap_region+0x10/0x10
[  129.527693]  __mm_populate+0x1ff/0x360
[  129.531882]  ? __pfx___mm_populate+0x10/0x10
[  129.536649]  ? do_mmap+0x61d/0xcd0
[  129.540446]  ? __up_write+0x1a5/0x500
[  129.544536]  vm_mmap_pgoff+0x276/0x360
[  129.548722]  ? rcu_is_watching+0x15/0xb0
[  129.553093]  ? __pfx_vm_mmap_pgoff+0x10/0x10
[  129.557861]  ? rcu_is_watching+0x15/0xb0
[  129.562239]  ? lock_release+0x25c/0x300
[  129.566522]  ? __fget_files+0x1e0/0x380
[  129.570807]  ksys_mmap_pgoff+0x2e4/0x430
[  129.575189]  do_syscall_64+0x60/0x90
[  129.579180]  ? do_syscall_64+0x6c/0x90
[  129.583357]  ? lockdep_hardirqs_on+0x7d/0x100
[  129.588235]  ? do_syscall_64+0x6c/0x90
[  129.592420]  ? lockdep_hardirqs_on+0x7d/0x100
[  129.597283]  entry_SYSCALL_64_after_hwframe+0x6e/0xd8



[1] https://github.com/open-iscsi/open-iscsi/blob/master/iscsiuio/README


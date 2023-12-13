Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5ECE6812090
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 22:19:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233907AbjLMVQO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 16:16:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbjLMVQM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 16:16:12 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EE74B7
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 13:16:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1702502177;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=t3w6Xj8LYqILm8EKMqzQWJRNazs3Z4fz1iwltgUE9Bo=;
        b=faOgFzpeyLskoFQNuYuu5BZeIW1C/sA4cOqLFC/kI7xcDeXgWovRanJOhtrZa6xU2H8CDG
        mlCaGWozoyldj8a8fN3Gxw2w+CehMzsDXyjPc6EE7tvHMjNpY2PHp+XnvmF2vGYrImXFTJ
        CRIw5423GxS3eKwp6D/dhd6fqXnoPMs=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-693-5sm7vwytNvOm-9xQQOi97g-1; Wed,
 13 Dec 2023 16:16:15 -0500
X-MC-Unique: 5sm7vwytNvOm-9xQQOi97g-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C04001C0BB51;
        Wed, 13 Dec 2023 21:16:13 +0000 (UTC)
Received: from rh (unknown [10.64.138.3])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2144F492BC6;
        Wed, 13 Dec 2023 21:16:13 +0000 (UTC)
Received: from localhost ([::1] helo=rh)
        by rh with esmtps  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <dchinner@redhat.com>)
        id 1rDWaQ-003rLL-1U;
        Thu, 14 Dec 2023 08:16:10 +1100
Date:   Thu, 14 Dec 2023 08:16:07 +1100
From:   Dave Chinner <dchinner@redhat.com>
To:     Alexander Potapenko <glider@google.com>
Cc:     syzbot+a6d6b8fffa294705dbd8@syzkaller.appspotmail.com, hch@lst.de,
        davem@davemloft.net, herbert@gondor.apana.org.au,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, linux-xfs@vger.kernel.org
Subject: Re: [syzbot] [crypto?] KMSAN: uninit-value in __crc32c_le_base (3)
Message-ID: <ZXofF2lXuIUvKi/c@rh>
References: <000000000000f66a3005fa578223@google.com>
 <20231213104950.1587730-1-glider@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231213104950.1587730-1-glider@google.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[cc linux-xfs@vger.kernel.org because that's where all questions
about XFS stuff should be directed, not to random individual
developers. ]

On Wed, Dec 13, 2023 at 11:49:50AM +0100, Alexander Potapenko wrote:
> Hi Christoph, Dave,
> 
> The repro provided by Xingwei indeed works.
> 
> I tried adding kmsan_check_memory(data, write_len) to xlog_write_iovec(), and
> it reported an uninitialized hole inside the `data` buffer:
> 
> kmalloc-ed xlog buffer of size 512 : ffff88802fc26200
> kmalloc-ed xlog buffer of size 368 : ffff88802fc24a00
> kmalloc-ed xlog buffer of size 648 : ffff88802b631000
> kmalloc-ed xlog buffer of size 648 : ffff88802b632800
> kmalloc-ed xlog buffer of size 648 : ffff88802b631c00

Off the top of my head:

> xlog_write_iovec: copying 12 bytes from ffff888017ddbbd8 to ffff88802c300400

Log start record in an ophdr.

> xlog_write_iovec: copying 28 bytes from ffff888017ddbbe4 to ffff88802c30040c

ophdr + checkpoint start header

> xlog_write_iovec: copying 68 bytes from ffff88802fc26274 to ffff88802c300428

ophdr + inode log format header

> xlog_write_iovec: copying 188 bytes from ffff88802fc262bc to ffff88802c30046c

ophdr + inode core in struct xfs_log_dinode format.

> =====================================================
> BUG: KMSAN: uninit-value in xlog_write_iovec fs/xfs/xfs_log.c:2227
> BUG: KMSAN: uninit-value in xlog_write_full fs/xfs/xfs_log.c:2263
> BUG: KMSAN: uninit-value in xlog_write+0x1fac/0x2600 fs/xfs/xfs_log.c:2532
>  xlog_write_iovec fs/xfs/xfs_log.c:2227
>  xlog_write_full fs/xfs/xfs_log.c:2263
>  xlog_write+0x1fac/0x2600 fs/xfs/xfs_log.c:2532
>  xlog_cil_write_chain fs/xfs/xfs_log_cil.c:918
>  xlog_cil_push_work+0x30f2/0x44e0 fs/xfs/xfs_log_cil.c:1263
>  process_one_work kernel/workqueue.c:2630
>  process_scheduled_works+0x1188/0x1e30 kernel/workqueue.c:2703
>  worker_thread+0xee5/0x14f0 kernel/workqueue.c:2784
>  kthread+0x391/0x500 kernel/kthread.c:388
>  ret_from_fork+0x66/0x80 arch/x86/kernel/process.c:147
>  ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:242
> 
> Uninit was created at:
>  slab_post_alloc_hook+0x101/0xac0 mm/slab.h:768
>  slab_alloc_node mm/slub.c:3482
>  __kmem_cache_alloc_node+0x612/0xae0 mm/slub.c:3521
>  __do_kmalloc_node mm/slab_common.c:1006
>  __kmalloc+0x11a/0x410 mm/slab_common.c:1020
>  kmalloc ./include/linux/slab.h:604
>  xlog_kvmalloc fs/xfs/xfs_log_priv.h:704
>  xlog_cil_alloc_shadow_bufs fs/xfs/xfs_log_cil.c:343
>  xlog_cil_commit+0x487/0x4dc0 fs/xfs/xfs_log_cil.c:1574
>  __xfs_trans_commit+0x8df/0x1930 fs/xfs/xfs_trans.c:1017
>  xfs_trans_commit+0x30/0x40 fs/xfs/xfs_trans.c:1061
>  xfs_create+0x15af/0x2150 fs/xfs/xfs_inode.c:1076
>  xfs_generic_create+0x4cd/0x1550 fs/xfs/xfs_iops.c:199
>  xfs_vn_create+0x4a/0x60 fs/xfs/xfs_iops.c:275
>  lookup_open fs/namei.c:3477
>  open_last_lookups fs/namei.c:3546
>  path_openat+0x29ac/0x6180 fs/namei.c:3776
>  do_filp_open+0x24d/0x680 fs/namei.c:3809
>  do_sys_openat2+0x1bc/0x330 fs/open.c:1440
>  do_sys_open fs/open.c:1455
>  __do_sys_openat fs/open.c:1471
>  __se_sys_openat fs/open.c:1466
>  __x64_sys_openat+0x253/0x330 fs/open.c:1466
>  do_syscall_x64 arch/x86/entry/common.c:51
>  do_syscall_64+0x4f/0x140 arch/x86/entry/common.c:82
>  entry_SYSCALL_64_after_hwframe+0x63/0x6b arch/x86/entry/entry_64.S:120
> 
> Bytes 112-115 of 188 are uninitialized
> Memory access of size 188 starts at ffff88802fc262bc

so bytes 100-103 of the xfs_log_dinode, which is the di_crc field
of the structure.

<looks at code>

Indeed, we *never* initialise that field, and we've never noticed
because it doesn't get used in replay (it is recalculated after
replay) so it's value is never checked and nothing has ever issued
warnings about it in our testing.

We actually did all uninitialised structure leak testing back in
2017 on the xfs_log_dinode and that, amongst other things, flagged
the 4 bytes *before* the di_crc field as being uninitialised
(di_next_unlinked). We fixed those issues and the uninit/leak
warnings went away via this commit:

commit 20413e37d71befd02b5846acdaf5e2564dd1c38e
Author: Dave Chinner <dchinner@redhat.com>
Date:   Mon Oct 9 11:37:22 2017 -0700

    xfs: Don't log uninitialised fields in inode structures
    
    Prevent kmemcheck from throwing warnings about reading uninitialised
    memory when formatting inodes into the incore log buffer. There are
    several issues here - we don't always log all the fields in the
    inode log format item, and we never log the inode the
    di_next_unlinked field.
    
    In the case of the inode log format item, this is exacerbated
    by the old xfs_inode_log_format structure padding issue. Hence make
    the padded, 64 bit aligned version of the structure the one we always
    use for formatting the log and get rid of the 64 bit variant. This
    means we'll always log the 64-bit version and so recovery only needs
    to convert from the unpadded 32 bit version from older 32 bit
    kernels.
    
    Signed-Off-By: Dave Chinner <dchinner@redhat.com>
    Tested-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
    Reviewed-by: Brian Foster <bfoster@redhat.com>
    Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>
    Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>

The same tool that found those problems didn't report the 4 byte
region of the di_crc as being uninitialised, and it's taken another
6 years for some random, weird corner case for KMSAN to realise that
every inode we log fails to initialise the di_crc field?

It's trivial to fix now that the kmsan tool has identified the
issue, but I'm perplexed at how this has gone undetected for several
years despite the fact that "mount <fs>; touch foo; unmount <fs>"
should trigger an uninitialised memory read warning, without fail,
every time it is run.

-Dave.
-- 
Dave Chinner
dchinner@redhat.com


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58A0479D422
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 16:55:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236097AbjILOzq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 10:55:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236090AbjILOzn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 10:55:43 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0300CCD
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 07:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=VsIIWSCKKQ4g3J8ZWVNV3zkM3OtDKG0id+2jj8qXrsQ=; b=s28xTPpk5lPl6WWgdf0Gz2Xijk
        p3kv3RocM0egFx9oRC9Oe8J1BIJ1rEiFsFz5XtoFKTCHkf9dXsDV7tbh2R9WFnsD5FfCckVhdd4KX
        vpnYSdvgzVqD+T2dBCLMhvrIvG282WtKKW61MLQGENvjvbclDUVl54ySR3nVL8VShttYaAx6xiMKM
        FkIQwwYSuHIT9J8RIr0OhArMqTMDMl7BbxPyD98ghiAeI7MGhXJMzmxTm8SXep8iZIfE+zeVmzxIX
        TF/fcLmCIg4leOE+BBrCK5wBDXSz/t1w1V+epZwlt00TKJ6wKbLLxVReI0xmhM15DdhsbBtM5fits
        DQmLVPdA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qg4ng-008Bt2-TA; Tue, 12 Sep 2023 14:55:36 +0000
Date:   Tue, 12 Sep 2023 15:55:36 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     syzbot <syzbot+b591856e0f0139f83023@syzkaller.appspotmail.com>
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com,
        Suren Baghdasaryan <surenb@google.com>
Subject: Re: [syzbot] [mm?] kernel BUG in vma_replace_policy
Message-ID: <ZQB76G/6NxVgoE9u@casper.infradead.org>
References: <000000000000f392a60604a65085@google.com>
 <ZP/3hgDCXeceE9uU@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZP/3hgDCXeceE9uU@casper.infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 12, 2023 at 06:30:46AM +0100, Matthew Wilcox wrote:
> On Tue, Sep 05, 2023 at 06:03:49PM -0700, syzbot wrote:
> > Hello,
> > 
> > syzbot found the following issue on:
> > 
> > HEAD commit:    a47fc304d2b6 Add linux-next specific files for 20230831
> > git tree:       linux-next
> > console+strace: https://syzkaller.appspot.com/x/log.txt?x=16502ddba80000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=6ecd2a74f20953b9
> > dashboard link: https://syzkaller.appspot.com/bug?extid=b591856e0f0139f83023
> > compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=120e7d70680000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1523f9c0680000
> > 
> > Downloadable assets:
> > disk image: https://storage.googleapis.com/syzbot-assets/b2e8f4217527/disk-a47fc304.raw.xz
> > vmlinux: https://storage.googleapis.com/syzbot-assets/ed6cdcc09339/vmlinux-a47fc304.xz
> > kernel image: https://storage.googleapis.com/syzbot-assets/bd9b2475bf5a/bzImage-a47fc304.xz
> > 
> > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > Reported-by: syzbot+b591856e0f0139f83023@syzkaller.appspotmail.com
> 
> #syz test
> 
> diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> index 42b5567e3773..90ad5fe60824 100644
> --- a/mm/mempolicy.c
> +++ b/mm/mempolicy.c
> @@ -1342,6 +1342,7 @@ static long do_mbind(unsigned long start, unsigned long len,
>  	vma_iter_init(&vmi, mm, start);
>  	prev = vma_prev(&vmi);
>  	for_each_vma_range(vmi, vma, end) {
> +		vma_start_write(vma);
>  		err = mbind_range(&vmi, vma, &prev, start, end, new);
>  		if (err)
>  			break;

Suren, can you take a look at this?  The VMA should be locked by the
call to queue_pages_range(), but by the time we get to here, the VMA
isn't locked.  I don't see anywhere that we cycle the mmap_lock (which
would unlock the VMA), but I could have missed something.  The two
VMA walks should walk over the same set of VMAs.  Certainly the VMA
being dumped should have been locked by the pagewalk:

 vma ffff888077381a00 start 0000000020c2a000 end 0000000021000000 mm ffff8880258a8980
 prot 25 anon_vma 0000000000000000 vm_ops 0000000000000000
 pgoff 20c2a file 0000000000000000 private_data 0000000000000000
 flags: 0x8100077(read|write|exec|mayread|maywrite|mayexec|account|softdirty)

  syscall(__NR_mbind, /*addr=*/0x20400000ul, /*len=*/0xc00000ul, /*mode=*/4ul,
          /*nodemask=*/0ul, /*maxnode=*/0ul, /*flags=*/3ul);

20400000 + c00000 should overlap 20c2a000-21000000

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDB8476150F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 13:25:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234572AbjGYLZO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 07:25:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234564AbjGYLZN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 07:25:13 -0400
X-Greylist: delayed 516 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 25 Jul 2023 04:25:11 PDT
Received: from proxmox-new.maurer-it.com (proxmox-new.maurer-it.com [94.136.29.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 745869D
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 04:25:11 -0700 (PDT)
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
        by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 183F143CB5;
        Tue, 25 Jul 2023 13:16:33 +0200 (CEST)
Message-ID: <8d063a26-43f5-0bb7-3203-c6a04dc159f8@proxmox.com>
Date:   Tue, 25 Jul 2023 13:16:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Content-Language: en-US
From:   Fiona Ebner <f.ebner@proxmox.com>
To:     torvalds@linux-foundation.org, akpm@linux-foundation.org
Cc:     Thomas Lamprecht <t.lamprecht@proxmox.com>,
        Wolfgang Bumiller <w.bumiller@proxmox.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: segfaults of processes while being killed after commit "mm: make the
 page fault mmap locking killable"
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

we are seeing segfaults from processes while being killed starting with
kernels which include commit eda0047296a16d65a7f2bc60a408f70d178b2014
("mm: make the page fault mmap locking killable") all the way up to
v6.5-rc3 which is the kernel I based this report on.

I don't have a simple reproducer unfortunately, the one I have is big
and quite racy. My working theory for what happens is (see also the
bpftrace script and output [0]):

Since get_mmap_lock_carefully() now uses mmap_read_lock_killable(), if
rwsem_down_write_slowpath() is taken and there is a fatal signal
pending, rwsem_down_write_slowpath() will return -EINTR and this is
propagated up until get_mmap_lock_carefully() will return its boolean
negation with !mmap_read_lock_killable(mm), i.e. 0.

Then lock_mm_and_find_vma() returns NULL

>     if (!get_mmap_lock_carefully(mm, regs))
>         return NULL;
and so do_user_addr_fault()

>     vma = lock_mm_and_find_vma(mm, address, regs);
>     if (unlikely(!vma)) {
>         bad_area_nosemaphore(regs, error_code, address);
>         return;
>     }

will end up without a vma and cause/log the segfault. Of course the
process is already being killed, but I'd argue it is very confusing to
users when apparent segfaults from such processes are being logged by
the kernel.

Happy to provide other traces or information if required!

Best Regards,
Fiona

[0]:

I ended up with the following bpftrace script

> #include <linux/signal.h>
> #include <linux/sched.h>
> 
> kprobe:down_read_killable {
>     printf("%s %d %d\n", func, pid, tid);
> }
> 
> kprobe:rwsem_down_read_slowpath {
>     printf("%s %d %d\n", func, pid, tid);
> }
> 
> kretprobe:rwsem_down_read_slowpath {
>     printf("%s %d %d retval 0x%x\n", func, pid, tid, retval);
>     printf("%s\n", kstack());
> }
> 
> kprobe:bad_area_nosemaphore {
>     printf("%s %d %d %s pending signal: %d\n", func, pid, tid, comm,
>     curtask->pending.signal.sig[0]
>     );
>     if (curtask->pending.signal.sig[0]) {
> 	printf("%s\n", kstack());
>     }
> }

and here is a capture of a process running into the segfault. AFAIU, the
pending signal translates to SIGKILL and the return value from
down_read_killable() is -EINTR.

> down_read_killable 987299 987299
> rwsem_down_read_slowpath 987299 987299
> down_read_killable 987299 987299 retval 0xfffffffc
> 
>         down_read_killable+72
>         lock_mm_and_find_vma+167
>         do_user_addr_fault+477
>         exc_page_fault+131
>         asm_exc_page_fault+39
> 
> bad_area_nosemaphore 987299 987299 pverados pending signal: 256
> 
>         bad_area_nosemaphore+1
>         exc_page_fault+131
>         asm_exc_page_fault+39
> 
> bad_area_nosemaphore 987299 987299 pverados pending signal: 256
> 
>         bad_area_nosemaphore+1
>         exc_page_fault+131
>         asm_exc_page_fault+39
>         rep_movs_alternative+96
>         show_opcodes+118
>         __bad_area_nosemaphore+640
>         bad_area_nosemaphore+22
>         do_user_addr_fault+708
>         exc_page_fault+131
>         asm_exc_page_fault+39
> 
> bad_area_nosemaphore 987299 987299 pverados pending signal: 256
> 
>         bad_area_nosemaphore+1
>         exc_page_fault+131
>         asm_exc_page_fault+39
>         rep_movs_alternative+15
>         show_opcodes+118
>         __bad_area_nosemaphore+640
>         bad_area_nosemaphore+22
>         do_user_addr_fault+708
>         exc_page_fault+131
>         asm_exc_page_fault+39
>


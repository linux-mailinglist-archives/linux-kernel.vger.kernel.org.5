Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69A7E7D20C9
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Oct 2023 04:52:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230200AbjJVCww (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Oct 2023 22:52:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjJVCwv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Oct 2023 22:52:51 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77B3CD5D;
        Sat, 21 Oct 2023 19:52:45 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id d75a77b69052e-41cc7b67419so14937221cf.2;
        Sat, 21 Oct 2023 19:52:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697943164; x=1698547964; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fLJPGz08SScZMNcOGuHvw7UWOGHz7MBlKaho3/nzID8=;
        b=PrM1C45OtorNQYkqV6nVhbTVDNHmgLl2JeBAwytC8NoDFqhs5LRQqnT+z2R6EeDS+F
         uVrMr8O+xSdgl5mBLFAhH+qsMkhsHwBQmEPidDilBXFtjGVD7jVscNslwWgKflMbOeHA
         ftMphdNVbvEIJu9C8kiSST0kLwJGwT97PotezqPEoRi2hgZtX4Rs7vC7AuhbrGMBVYmW
         QT4B7HPSeT2i+LGk8PbU6DyMgrJalvMVjfGcSy2zpPMlaGaRtz8B30AX7fw9XyxNfxF8
         xyI5iL01sBiFe2KQlV3FdEg2jDCSVbPhMUtNrmBEdwjU2vxaQZBG2RivNHz6CDRTb1Zo
         MYsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697943164; x=1698547964;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fLJPGz08SScZMNcOGuHvw7UWOGHz7MBlKaho3/nzID8=;
        b=k/jGVLHoJDXPER5mwLrfBE+GlrMIFBWX61O8BaWsq42Vik2SuGo+7/ay+nEOzemL+G
         ueAx+CwjpRFxN9fF7SHPkHF8ub9G0/ttudYyOLbkjJamxciE407zZlZMv8x+46aWwo2r
         gmVZ4KzBK01PO/0d3RE8/YxAhowvS5bH+OqMNx6tdn8SdrXVxFCuuXpjo2qqIPU1jLKU
         ct6Jdr33IbxCjZYAETdWGVxAyPa7aebCHU4Z3E5kXsgR8rBGSMri4Wfz/ikJS+n4pwpC
         +uMA+NsLlBWtS1h968WBc6geKtoNLwmlre26B/lrU6keCqDwFf1bvmt0uHp0Op/BZ3YA
         rzgg==
X-Gm-Message-State: AOJu0Ywu1G81BrF2gkb3ljlNzJHLcL+dLWzbFirRN0PUae6Pvc7wFInq
        VlekXh6zKcIine7V2dHSlVA4ZjHTJ7WmM1ZIazU=
X-Google-Smtp-Source: AGHT+IH2MHhpNeld9CqgKmIyUAEse6uqV2LrpU3aVrBAb1iJmpBgVHWItyqnxH7A/f6f8L8SOj4byTK4gKxP3ZofK/4=
X-Received: by 2002:a05:622a:5d1:b0:418:1f20:5522 with SMTP id
 d17-20020a05622a05d100b004181f205522mr6758862qtb.43.1697943164314; Sat, 21
 Oct 2023 19:52:44 -0700 (PDT)
MIME-Version: 1.0
References: <20231018141151.1334501-1-sashal@kernel.org> <20231018141151.1334501-12-sashal@kernel.org>
In-Reply-To: <20231018141151.1334501-12-sashal@kernel.org>
From:   Z qiang <qiang.zhang1211@gmail.com>
Date:   Sun, 22 Oct 2023 10:52:33 +0800
Message-ID: <CALm+0cVpvreUHCxjLiEAbXgmEO1J3egtn=MnB8NDs=c0gFx8Vw@mail.gmail.com>
Subject: Re: [PATCH AUTOSEL 6.5 12/31] workqueue: Fix UAF report by KASAN in pwq_release_workfn()
To:     Sasha Levin <sashal@kernel.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        syzbot+60db9f652c92d5bacba4@syzkaller.appspotmail.com,
        Tejun Heo <tj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>
> From: Zqiang <qiang.zhang1211@gmail.com>
>
> [ Upstream commit 643445531829d89dc5ddbe0c5ee4ff8f84ce8687 ]
>
> Currently, for UNBOUND wq, if the apply_wqattrs_prepare() return error,
> the apply_wqattr_cleanup() will be called and use the pwq_release_worker
> kthread to release resources asynchronously. however, the kfree(wq) is
> invoked directly in failure path of alloc_workqueue(), if the kfree(wq)
> has been executed and when the pwq_release_workfn() accesses wq, this
> leads to the following scenario:
>
> BUG: KASAN: slab-use-after-free in pwq_release_workfn+0x339/0x380 kernel/workqueue.c:4124
> Read of size 4 at addr ffff888027b831c0 by task pool_workqueue_/3
>
> CPU: 0 PID: 3 Comm: pool_workqueue_ Not tainted 6.5.0-rc7-next-20230825-syzkaller #0
> Hardware name: Google Compute Engine/Google Compute Engine, BIOS Google 07/26/2023
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:88 [inline]
>  dump_stack_lvl+0xd9/0x1b0 lib/dump_stack.c:106
>  print_address_description mm/kasan/report.c:364 [inline]
>  print_report+0xc4/0x620 mm/kasan/report.c:475
>  kasan_report+0xda/0x110 mm/kasan/report.c:588
>  pwq_release_workfn+0x339/0x380 kernel/workqueue.c:4124
>  kthread_worker_fn+0x2fc/0xa80 kernel/kthread.c:823
>  kthread+0x33a/0x430 kernel/kthread.c:388
>  ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
>  ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304
>  </TASK>
>
> Allocated by task 5054:
>  kasan_save_stack+0x33/0x50 mm/kasan/common.c:45
>  kasan_set_track+0x25/0x30 mm/kasan/common.c:52
>  ____kasan_kmalloc mm/kasan/common.c:374 [inline]
>  __kasan_kmalloc+0xa2/0xb0 mm/kasan/common.c:383
>  kmalloc include/linux/slab.h:599 [inline]
>  kzalloc include/linux/slab.h:720 [inline]
>  alloc_workqueue+0x16f/0x1490 kernel/workqueue.c:4684
>  kvm_mmu_init_tdp_mmu+0x23/0x100 arch/x86/kvm/mmu/tdp_mmu.c:19
>  kvm_mmu_init_vm+0x248/0x2e0 arch/x86/kvm/mmu/mmu.c:6180
>  kvm_arch_init_vm+0x39/0x720 arch/x86/kvm/x86.c:12311
>  kvm_create_vm arch/x86/kvm/../../../virt/kvm/kvm_main.c:1222 [inline]
>  kvm_dev_ioctl_create_vm arch/x86/kvm/../../../virt/kvm/kvm_main.c:5089 [inline]
>  kvm_dev_ioctl+0xa31/0x1c20 arch/x86/kvm/../../../virt/kvm/kvm_main.c:5131
>  vfs_ioctl fs/ioctl.c:51 [inline]
>  __do_sys_ioctl fs/ioctl.c:871 [inline]
>  __se_sys_ioctl fs/ioctl.c:857 [inline]
>  __x64_sys_ioctl+0x18f/0x210 fs/ioctl.c:857
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x63/0xcd
>
> Freed by task 5054:
>  kasan_save_stack+0x33/0x50 mm/kasan/common.c:45
>  kasan_set_track+0x25/0x30 mm/kasan/common.c:52
>  kasan_save_free_info+0x2b/0x40 mm/kasan/generic.c:522
>  ____kasan_slab_free mm/kasan/common.c:236 [inline]
>  ____kasan_slab_free+0x15b/0x1b0 mm/kasan/common.c:200
>  kasan_slab_free include/linux/kasan.h:164 [inline]
>  slab_free_hook mm/slub.c:1800 [inline]
>  slab_free_freelist_hook+0x114/0x1e0 mm/slub.c:1826
>  slab_free mm/slub.c:3809 [inline]
>  __kmem_cache_free+0xb8/0x2f0 mm/slub.c:3822
>  alloc_workqueue+0xe76/0x1490 kernel/workqueue.c:4746
>  kvm_mmu_init_tdp_mmu+0x23/0x100 arch/x86/kvm/mmu/tdp_mmu.c:19
>  kvm_mmu_init_vm+0x248/0x2e0 arch/x86/kvm/mmu/mmu.c:6180
>  kvm_arch_init_vm+0x39/0x720 arch/x86/kvm/x86.c:12311
>  kvm_create_vm arch/x86/kvm/../../../virt/kvm/kvm_main.c:1222 [inline]
>  kvm_dev_ioctl_create_vm arch/x86/kvm/../../../virt/kvm/kvm_main.c:5089 [inline]
>  kvm_dev_ioctl+0xa31/0x1c20 arch/x86/kvm/../../../virt/kvm/kvm_main.c:5131
>  vfs_ioctl fs/ioctl.c:51 [inline]
>  __do_sys_ioctl fs/ioctl.c:871 [inline]
>  __se_sys_ioctl fs/ioctl.c:857 [inline]
>  __x64_sys_ioctl+0x18f/0x210 fs/ioctl.c:857
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x63/0xcd
>
> This commit therefore flush pwq_release_worker in the alloc_and_link_pwqs()
> before invoke kfree(wq).
>
> Reported-by: syzbot+60db9f652c92d5bacba4@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=60db9f652c92d5bacba4
> Signed-off-by: Zqiang <qiang.zhang1211@gmail.com>
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  kernel/workqueue.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/kernel/workqueue.c b/kernel/workqueue.c
> index e51ab3d4765eb..a0045c159a0e1 100644
> --- a/kernel/workqueue.c
> +++ b/kernel/workqueue.c
> @@ -4567,6 +4567,12 @@ static int alloc_and_link_pwqs(struct workqueue_struct *wq)
>         }
>         cpus_read_unlock();
>
> +       /* for unbound pwq, flush the pwq_release_worker ensures that the
> +        * pwq_release_workfn() completes before calling kfree(wq).
> +        */
> +       if (ret)
> +               kthread_flush_worker(pwq_release_worker);
> +
>         return ret;
>  }
>

Hello Sasha,  the pwq_release_worker only exists in the V6.6 kernel,
the previous versions of kernels do not use this mechanism.

Thanks
Zqiang

>
> --
> 2.40.1
>

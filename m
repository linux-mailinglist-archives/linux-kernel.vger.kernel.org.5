Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 864487CD7C9
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 11:21:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229840AbjJRJVJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 05:21:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229747AbjJRJU5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 05:20:57 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D4E7119
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 02:20:45 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-408382da7f0so8569545e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 02:20:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697620844; x=1698225644; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9ewrMPyx4pJfcubjcrEJa/asBuC5oD61em5IsCdml64=;
        b=TWUzEUR2g1xXNNCqVOHHSumYgND1x1ycms3bkzp0xSSrnUV9iKcSDb3ddrWKUrgQRt
         XEuzvgq8gVH7JOfKMb/GU812uDj2fm41xaIQf+7+6xrlGsDklmhp6ZQoD669GtD+mFPc
         UWKqRXF8VpEDMntkC1i8a1CpeV2KU4HkUVFrEKrTtHz3mXMJsfKY77doLWW4/RlP6maV
         kZwrBAECbHPO7cO6G2DzfqLxc9Zs1QMk6DSiUNidsM7eqYRxKs0EsLmjWERscHKpRzO6
         KcsePc/O8mZtm9YKT/XP1jj1PvKzaj6hIGigkaFzZGiRYT5rJ1Ynvib7GCY/612GlFBV
         PzIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697620844; x=1698225644;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9ewrMPyx4pJfcubjcrEJa/asBuC5oD61em5IsCdml64=;
        b=bYl1eY4Jz0zhlF+wpGWGEQOOUnZPSQYFSZrHmxYHus/GGeEkuyByWSuEGE/aEtRN++
         FSFhzukpysT7fMhKpyhY9OxwqjLMoxkx/huzVlvRtgVZuxyXEqYYLo3E3UMe4qnTnIhl
         u9qmmePAVxcM+jyzyvCg2y6bg+mQPRtMOoZzqWiSSBrT+44ZPOXsLyYBWzT2RXuRxQMs
         GV9vrajVTrsDreE62GYzdNuFL9Mh/1Hj9XhpAyvxT+n+yP/0lcrMCL6/x0KLWiAwGXRq
         u/mhk1WoVJUXGFaAdWbwEliVQNVr/PzxWPQruh+68Cre4dfPIa8Vat8Bxsz3KPd/Gv8f
         oU2w==
X-Gm-Message-State: AOJu0YzdzJqN/X22K9UYthNhsIQmHVB7SQxpowikciEU4k9Z1FYrGtPd
        1qPNmHD13SXz3ZIHwDfw2E+mIN3PeAEsiDpeP/Lk1Q==
X-Google-Smtp-Source: AGHT+IGi3FLJ0Wf3sLFhYoNxoDCCu6JqOQ4wFhsrh26tmEfNkB34bnsv2gYfdBeY4hAom5KZzFhfCA==
X-Received: by 2002:a05:600c:4f49:b0:405:3b1f:968b with SMTP id m9-20020a05600c4f4900b004053b1f968bmr3664452wmq.21.1697620843537;
        Wed, 18 Oct 2023 02:20:43 -0700 (PDT)
Received: from elver.google.com ([2a00:79e0:9c:201:8d0f:ea49:93ba:ca57])
        by smtp.gmail.com with ESMTPSA id c39-20020a05600c4a2700b0040588d85b3asm1117664wmp.15.2023.10.18.02.20.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 02:20:43 -0700 (PDT)
Date:   Wed, 18 Oct 2023 11:20:37 +0200
From:   Marco Elver <elver@google.com>
To:     syzbot <syzbot+59f37b0ab4c558a5357c@syzkaller.appspotmail.com>,
        Muchun Song <muchun.song@linux.dev>
Cc:     akpm@linux-foundation.org, dvyukov@google.com, glider@google.com,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com,
        Andrey Konovalov <andreyknvl@gmail.com>
Subject: Re: [syzbot] [mm?] [kasan?] WARNING in __kfence_free (3)
Message-ID: <ZS-jZQFcQwb8o8qs@elver.google.com>
References: <000000000000bc90a60607f41fc3@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000bc90a60607f41fc3@google.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 17, 2023 at 07:09PM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    213f891525c2 Merge tag 'probes-fixes-v6.6-rc6' of git://gi..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=14a731f9680000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=a4436b383d761e86
> dashboard link: https://syzkaller.appspot.com/bug?extid=59f37b0ab4c558a5357c
> compiler:       aarch64-linux-gnu-gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
> userspace arch: arm64
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> Downloadable assets:
> disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/384ffdcca292/non_bootable_disk-213f8915.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/98b9a78b6226/vmlinux-213f8915.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/8ed2ef54968f/Image-213f8915.gz.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+59f37b0ab4c558a5357c@syzkaller.appspotmail.com
> 
> ------------[ cut here ]------------
> WARNING: CPU: 1 PID: 3252 at mm/kfence/core.c:1147 __kfence_free+0x7c/0xb4 mm/kfence/core.c:1147

This has happened before:
https://lore.kernel.org/all/FC29C538-1446-4A3F-A6FA-857295D7DEB3@linux.dev/T/#u

And is this warning:

	| void __kfence_free(void *addr)
	| {
	| 	struct kfence_metadata *meta = addr_to_metadata((unsigned long)addr);
	| 
	| #ifdef CONFIG_MEMCG
	| 	KFENCE_WARN_ON(meta->objcg);           <--------
	| #endif

Which is this assembly in the vmlinux provided by syzbot:

	ffff8000802bed9c: 22 40 42 f9   ldr     x2, [x1, #1152]
	ffff8000802beda0: 02 fe ff b4   cbz     x2, 0xffff8000802bed60 <__kfence_free+0x38>
	ffff8000802beda4: 00 00 21 d4   brk     #0x800

So we know the pointer is in x2, and from the below we know it's fcff000006a24ec0.

Muchun, last time you said:

> Maybe we could improve the warning message,
> e.g. print the current value of "meta->objcg".

Does this somehow help you better understand what's going on?

Also this is a KASAN_HW_TAGS instance (using arm64 MTE), not sure that's
relevant though.

> Modules linked in:
> CPU: 1 PID: 3252 Comm: syz-executor.1 Not tainted 6.6.0-rc6-syzkaller-00029-g213f891525c2 #0
> Hardware name: linux,dummy-virt (DT)
> pstate: 81400009 (Nzcv daif +PAN -UAO -TCO +DIT -SSBS BTYPE=--)
> pc : __kfence_free+0x7c/0xb4 mm/kfence/core.c:1147
> lr : kfence_free include/linux/kfence.h:187 [inline]
> lr : __slab_free+0x48c/0x508 mm/slub.c:3614
> sp : ffff800082cebb50
> x29: ffff800082cebb50 x28: f7ff000002c0c400 x27: ffff8000818ca8a8
> x26: ffff8000821f0620 x25: 0000000000000001 x24: ffff00007ffa3000
> x23: 0000000000000001 x22: ffff00007ffa3000 x21: ffff00007ffa3000
> x20: ffff80008004191c x19: fffffc0001ffe8c0 x18: ffffffffffffffff
> x17: ffff800080027b40 x16: ffff800080027a34 x15: ffff800080318514
> x14: ffff8000800469c8 x13: ffff800080011558 x12: ffff800081897ff4
> x11: ffff800081897b28 x10: ffff800080027bfc x9 : 0000000000400cc0
> x8 : ffff800082cebc30 x7 : 0000000000000000 x6 : 0000000000000000
> x5 : ffff80008004191c x4 : ffff00007f869000 x3 : ffff800082420338
> x2 : fcff000006a24ec0 x1 : ffff00007f8a50a0 x0 : ffff00007ffa3000
> Call trace:
>  __kfence_free+0x7c/0xb4 mm/kfence/core.c:1147
>  kfence_free include/linux/kfence.h:187 [inline]
>  __slab_free+0x48c/0x508 mm/slub.c:3614
>  do_slab_free mm/slub.c:3757 [inline]
>  slab_free mm/slub.c:3810 [inline]
>  __kmem_cache_free+0x220/0x230 mm/slub.c:3822
>  kfree+0x5c/0x74 mm/slab_common.c:1072
>  kvm_uevent_notify_change.part.0+0x10c/0x174 arch/arm64/kvm/../../../virt/kvm/kvm_main.c:5908
>  kvm_uevent_notify_change arch/arm64/kvm/../../../virt/kvm/kvm_main.c:5878 [inline]
>  kvm_dev_ioctl_create_vm arch/arm64/kvm/../../../virt/kvm/kvm_main.c:5107 [inline]
>  kvm_dev_ioctl+0x3e8/0x91c arch/arm64/kvm/../../../virt/kvm/kvm_main.c:5131
>  vfs_ioctl fs/ioctl.c:51 [inline]
>  __do_sys_ioctl fs/ioctl.c:871 [inline]
>  __se_sys_ioctl fs/ioctl.c:857 [inline]
>  __arm64_sys_ioctl+0xac/0xf0 fs/ioctl.c:857
>  __invoke_syscall arch/arm64/kernel/syscall.c:37 [inline]
>  invoke_syscall+0x48/0x114 arch/arm64/kernel/syscall.c:51
>  el0_svc_common.constprop.0+0x40/0xe0 arch/arm64/kernel/syscall.c:136
>  do_el0_svc+0x1c/0x28 arch/arm64/kernel/syscall.c:155
>  el0_svc+0x40/0x114 arch/arm64/kernel/entry-common.c:678
>  el0t_64_sync_handler+0x100/0x12c arch/arm64/kernel/entry-common.c:696
>  el0t_64_sync+0x19c/0x1a0 arch/arm64/kernel/entry.S:595
> ---[ end trace 0000000000000000 ]---

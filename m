Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 209D77AB72C
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 19:28:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231175AbjIVR2m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 13:28:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230025AbjIVR2l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 13:28:41 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AF8E194;
        Fri, 22 Sep 2023 10:28:26 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA9FCC433C8;
        Fri, 22 Sep 2023 17:28:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1695403706;
        bh=5e+Uaa6IVXhwt1E8qsYEHDmAS2OFX3RrpBQFhfedKBc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=p2MLgonAtabExJ6WcBnB7c1yQdb18pCCLp8DgbhIOUvUNOrb3VOjLXSMlxf6K06dx
         bct8IhcGTDWdtae5yf8MsKc04A+Xwm2J6KESzlokuiMN6vIFQ4j0kUYCJpakllHbiL
         ogx8bae+iNaa19jzmh5zfqTAXitSrpKPIwIiAhpg=
Date:   Fri, 22 Sep 2023 10:28:25 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     syzbot <syzbot+6ccbcd15a17f3e1cde38@syzkaller.appspotmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-next@vger.kernel.org, sfr@canb.auug.org.au,
        syzkaller-bugs@googlegroups.com,
        David Hildenbrand <david@redhat.com>
Subject: Re: [syzbot] [mm?] linux-next test error: WARNING in
 page_add_anon_rmap
Message-Id: <20230922102825.061c67b4418190426fdc68f2@linux-foundation.org>
In-Reply-To: <00000000000090d6a00605eb5de9@google.com>
References: <00000000000090d6a00605eb5de9@google.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Sep 2023 21:51:45 -0700 syzbot <syzbot+6ccbcd15a17f3e1cde38@syzkaller.appspotmail.com> wrote:

> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    7fc7222d9680 Add linux-next specific files for 20230918
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=13acae54680000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=79253779bcbe3130
> dashboard link: https://syzkaller.appspot.com/bug?extid=6ccbcd15a17f3e1cde38
> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/82da18e596ba/disk-7fc7222d.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/4e71084ae5e0/vmlinux-7fc7222d.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/f412e76b12e4/bzImage-7fc7222d.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+6ccbcd15a17f3e1cde38@syzkaller.appspotmail.com
> 
>  destroy_args+0x768/0x990 mm/debug_vm_pgtable.c:1028
>  debug_vm_pgtable+0x1d79/0x3df0 mm/debug_vm_pgtable.c:1408
>  do_one_initcall+0x11c/0x640 init/main.c:1232
>  do_initcall_level init/main.c:1294 [inline]
>  do_initcalls init/main.c:1310 [inline]
>  do_basic_setup init/main.c:1329 [inline]
>  kernel_init_freeable+0x5c2/0x8f0 init/main.c:1547
>  kernel_init+0x1c/0x2a0 init/main.c:1437
>  ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
>  ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304
> ------------[ cut here ]------------
> WARNING: CPU: 0 PID: 5053 at mm/rmap.c:1252 page_add_anon_rmap+0xc33/0x1a70 mm/rmap.c:1252

Thanks, this should be addressed by
https://lkml.kernel.org/r/d8e5a093-2e22-c14b-7e64-6da280398d9f@redhat.com


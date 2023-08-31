Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36A9F78EF58
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 16:13:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245476AbjHaONo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 10:13:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229877AbjHaONm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 10:13:42 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FE6DCC
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 07:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693491218; x=1725027218;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=StqPCQw1ND0E7Y10i0CieQyaYgnOL74aH5ssVvA0BPk=;
  b=gfJT1Vx7Ven7Ml/mQYNSSLUo1whIwlTCVSLncn4kVAiLIeQX+gL6eZxu
   CNXAFSmOE6DU8UAy7D8GpwZy+xUA7Ti+cIGsVXEAEWpeZzko6bzyQOJOO
   BsWwek+KJlq6Ec465A2hwSPebu81dVDJseMUIUmitllzlqdMNsq1Y7lCW
   9YcqHfYQ5Ro4dg/DeEKzkPIvwcO51lmZD3TEzAek+LOHV56/dz7EPSOZC
   kcct7wM07Ha6TwNHdXC0gBzSe0DDOJGMKpdD4bpFLHdrc0i4NN0aQTG+p
   v2kz0z0ZvMLjPj0ZkpWcE0+BKtSmkr20RNBKAOdOWNeeUBM4MOjUR9VYl
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="462324527"
X-IronPort-AV: E=Sophos;i="6.02,217,1688454000"; 
   d="scan'208";a="462324527"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2023 07:11:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="809647189"
X-IronPort-AV: E=Sophos;i="6.02,217,1688454000"; 
   d="scan'208";a="809647189"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2023 07:11:08 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qbiO2-005PCZ-10;
        Thu, 31 Aug 2023 17:11:06 +0300
Date:   Thu, 31 Aug 2023 17:11:05 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     syzbot <syzbot+d2c31705e468a347e6db@syzkaller.appspotmail.com>
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        rafael@kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [kernel?] general protection fault in
 netdev_register_kobject
Message-ID: <ZPCfeaBrzF433cWE@smile.fi.intel.com>
References: <000000000000bd9b26060432ac0c@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000bd9b26060432ac0c@google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 31, 2023 at 12:05:53AM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    2ee82481c392 Add linux-next specific files for 20230828
> git tree:       linux-next
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=16ea87b7a80000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=e82a7781f9208c0d
> dashboard link: https://syzkaller.appspot.com/bug?extid=d2c31705e468a347e6db
> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=141c0267a80000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1585c0c0680000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/30801702ce78/disk-2ee82481.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/8d9b67709145/vmlinux-2ee82481.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/47f8ef9bffd0/bzImage-2ee82481.xz
> 
> The issue was bisected to:
> 
> commit d21fdd07cea418c0d98c8a15fc95b8b8970801e7
> Author: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Date:   Thu Aug 17 09:12:21 2023 +0000
> 
>     driver core: Return proper error code when dev_set_name() fails
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=16cefca8680000
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=15cefca8680000
> console output: https://syzkaller.appspot.com/x/log.txt?x=11cefca8680000
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+d2c31705e468a347e6db@syzkaller.appspotmail.com
> Fixes: d21fdd07cea4 ("driver core: Return proper error code when dev_set_name() fails")
> 
> RBP: 0000000000000002 R08: 00007ffd497ebaf6 R09: 0000000100000000
> R10: 0000000000000002 R11: 0000000000000246 R12: 0000000000000000
> R13: 00000000000f4240 R14: 00000000000162a9 R15: 00007ffd497ebd74
>  </TASK>
> general protection fault, probably for non-canonical address 0xdffffc0000000000: 0000 [#1] PREEMPT SMP KASAN
> KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
> CPU: 0 PID: 5057 Comm: syz-executor401 Not tainted 6.5.0-next-20230828-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/26/2023
> RIP: 0010:strchr+0x1b/0xb0 lib/string.c:329
> Code: a3 ac f7 48 8b 74 24 08 48 8b 14 24 eb 89 90 f3 0f 1e fa 48 b8 00 00 00 00 00 fc ff df 48 89 fa 55 48 c1 ea 03 53 48 83 ec 10 <0f> b6 04 02 48 89 fa 83 e2 07 38 d0 7f 04 84 c0 75 51 0f b6 07 89
> RSP: 0018:ffffc90003abf058 EFLAGS: 00010282
> RAX: dffffc0000000000 RBX: 0000000000000000 RCX: 0000000000000000
> RDX: 0000000000000000 RSI: 0000000000000025 RDI: 0000000000000000
> RBP: ffffc90003abf0e8 R08: 0000000000000001 R09: 0000000000000000
> R10: 0000000000000001 R11: 0000000000000000 R12: ffffc90003abf0e8
> R13: 0000000000000cc0 R14: ffff8880142f8880 R15: 0000000000000001
> FS:  0000555555e44380(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f8bf2d75fc4 CR3: 000000007211d000 CR4: 00000000003506f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>  kvasprintf_const+0x25/0x190 lib/kasprintf.c:45
>  kobject_set_name_vargs+0x5a/0x130 lib/kobject.c:272
>  kobject_add_varg lib/kobject.c:366 [inline]
>  kobject_add+0x12a/0x240 lib/kobject.c:424
>  device_add+0x290/0x1ac0 drivers/base/core.c:3560
>  netdev_register_kobject+0x183/0x3f0 net/core/net-sysfs.c:2044
>  register_netdevice+0xbcb/0x1490 net/core/dev.c:10133
>  macvlan_common_newlink+0x1102/0x1a40 drivers/net/macvlan.c:1545
>  rtnl_newlink_create net/core/rtnetlink.c:3485 [inline]
>  __rtnl_newlink+0x1177/0x1940 net/core/rtnetlink.c:3705
>  rtnl_newlink+0x67/0xa0 net/core/rtnetlink.c:3718
>  rtnetlink_rcv_msg+0x439/0xd30 net/core/rtnetlink.c:6444
>  netlink_rcv_skb+0x16b/0x440 net/netlink/af_netlink.c:2545
>  netlink_unicast_kernel net/netlink/af_netlink.c:1342 [inline]
>  netlink_unicast+0x536/0x810 net/netlink/af_netlink.c:1368
>  netlink_sendmsg+0x93c/0xe40 net/netlink/af_netlink.c:1910
>  sock_sendmsg_nosec net/socket.c:730 [inline]
>  sock_sendmsg+0xd9/0x180 net/socket.c:753
>  ____sys_sendmsg+0x6ac/0x940 net/socket.c:2540
>  ___sys_sendmsg+0x135/0x1d0 net/socket.c:2594
>  __sys_sendmsg+0x117/0x1e0 net/socket.c:2623
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> RIP: 0033:0x7f8bf2d14ce9
> Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 d1 19 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007ffd497ebd58 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
> RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007f8bf2d14ce9
> RDX: 0000000000000000 RSI: 0000000020000280 RDI: 0000000000000003
> RBP: 0000000000000002 R08: 00007ffd497ebaf6 R09: 0000000100000000
> R10: 0000000000000002 R11: 0000000000000246 R12: 0000000000000000
> R13: 00000000000f4240 R14: 00000000000162a9 R15: 00007ffd497ebd74
>  </TASK>
> Modules linked in:
> ---[ end trace 0000000000000000 ]---
> RIP: 0010:strchr+0x1b/0xb0 lib/string.c:329
> Code: a3 ac f7 48 8b 74 24 08 48 8b 14 24 eb 89 90 f3 0f 1e fa 48 b8 00 00 00 00 00 fc ff df 48 89 fa 55 48 c1 ea 03 53 48 83 ec 10 <0f> b6 04 02 48 89 fa 83 e2 07 38 d0 7f 04 84 c0 75 51 0f b6 07 89
> RSP: 0018:ffffc90003abf058 EFLAGS: 00010282
> RAX: dffffc0000000000 RBX: 0000000000000000 RCX: 0000000000000000
> RDX: 0000000000000000 RSI: 0000000000000025 RDI: 0000000000000000
> RBP: ffffc90003abf0e8 R08: 0000000000000001 R09: 0000000000000000
> R10: 0000000000000001 R11: 0000000000000000 R12: ffffc90003abf0e8
> R13: 0000000000000cc0 R14: ffff8880142f8880 R15: 0000000000000001
> FS:  0000555555e44380(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00005628e3c36050 CR3: 000000007211d000 CR4: 00000000003506f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> ----------------
> Code disassembly (best guess):
>    0:	a3 ac f7 48 8b 74 24 	movabs %eax,0x480824748b48f7ac
>    7:	08 48
>    9:	8b 14 24             	mov    (%rsp),%edx
>    c:	eb 89                	jmp    0xffffff97
>    e:	90                   	nop
>    f:	f3 0f 1e fa          	endbr64
>   13:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
>   1a:	fc ff df
>   1d:	48 89 fa             	mov    %rdi,%rdx
>   20:	55                   	push   %rbp
>   21:	48 c1 ea 03          	shr    $0x3,%rdx
>   25:	53                   	push   %rbx
>   26:	48 83 ec 10          	sub    $0x10,%rsp
> * 2a:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax <-- trapping instruction
>   2e:	48 89 fa             	mov    %rdi,%rdx
>   31:	83 e2 07             	and    $0x7,%edx
>   34:	38 d0                	cmp    %dl,%al
>   36:	7f 04                	jg     0x3c
>   38:	84 c0                	test   %al,%al
>   3a:	75 51                	jne    0x8d
>   3c:	0f b6 07             	movzbl (%rdi),%eax
>   3f:	89                   	.byte 0x89
> 
> 
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection
> 
> If the bug is already fixed, let syzbot know by replying with:
> #syz fix: exact-commit-title
> 
> If you want syzbot to run the reproducer, reply with:
> #syz test: git://repo/address.git branch-or-commit-hash
> If you attach or paste a git patch, syzbot will apply it before testing.
> 
> If you want to overwrite bug's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
> 
> If the bug is a duplicate of another bug, reply with:
> #syz dup: exact-subject-of-another-report

#syz dup: [syzbot] [kernel?] general protection fault in nfc_register_device

> If you want to undo deduplication, reply with:
> #syz undup

-- 
With Best Regards,
Andy Shevchenko



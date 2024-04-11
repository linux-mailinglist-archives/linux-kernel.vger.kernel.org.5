Return-Path: <linux-kernel+bounces-139903-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A0FE8A08FC
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 08:59:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 221251C20FC7
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 06:59:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76F9E13DB8D;
	Thu, 11 Apr 2024 06:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IyMZwl5F"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93E7013DDBD;
	Thu, 11 Apr 2024 06:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712818726; cv=none; b=miFS3s5dflOXqGYzBH/GxG2ShE9gk5K4krNfUvZtvkdMEuUBwwt7oaH0MfRZ/vTIVYS5xzZlD75A+bBAw96SNxeJ3IC6LVVI6pD5GhTrT1dabAEnGYPTb8QZO4y1EgVE1HRSxJoaYBDfcbVl7DKPylwm07Ulzy9gEVjOT3mFZec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712818726; c=relaxed/simple;
	bh=LMM+ez524Aboe2mGPKwqNrGqAQc9aK5c4yyXY0LCoss=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hx77fKP/wdyQ7m8Jjb2AfmiW1BDctESpH9LIGJeqMdiQKGWoopWzr8aqFHVXcJW2VBvqiRIxw/XZXooNW2IQidmEw/ffla8mlpk8zv4fSyoJq3zbpkiNDY2XDAnlW/4T983N0hktrT1JRQbqWXt7hlz1TrXXOks/q/Vrn3LwHIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IyMZwl5F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA2E5C433F1;
	Thu, 11 Apr 2024 06:58:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712818726;
	bh=LMM+ez524Aboe2mGPKwqNrGqAQc9aK5c4yyXY0LCoss=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IyMZwl5FpJTPzEbw308SeJc3Ty8Un2aBddHUk/JLXbiBBH165npc4RDa4iuNxYX6h
	 nzWXejLUWk9e59IKjl7fGYFQtb8GyPsUMMhhJTSB+BQPagt73nRfUNaw7ETL10RZq+
	 upjX3vcsrNeDu1CXU8PxaOAc8UmjPzrbvybMUhVM=
Date: Thu, 11 Apr 2024 08:58:43 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Sam Sun <samsun1006219@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
	Alan Stern <stern@rowland.harvard.edu>, swboyd@chromium.org,
	ricardo@marliere.net, hkallweit1@gmail.com,
	heikki.krogerus@linux.intel.com, mathias.nyman@linux.intel.com,
	royluo@google.com, syzkaller-bugs@googlegroups.com,
	xrivendell7@gmail.com
Subject: Re: [Linux kernel bug] general protection fault in disable_store
Message-ID: <2024041125-anemic-decorated-52aa@gregkh>
References: <CAEkJfYON+ry7xPx=AiLR9jzUNT+i_Va68ACajOC3HoacOfL1ig@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEkJfYON+ry7xPx=AiLR9jzUNT+i_Va68ACajOC3HoacOfL1ig@mail.gmail.com>

On Thu, Apr 11, 2024 at 02:52:27PM +0800, Sam Sun wrote:
> Dear developers and maintainers,
> 
> We encountered a general protection fault in function disable_store.
> It is tested against the latest upstream linux (tag 6.9-rc3). C repro
> and kernel config are attached to this email. Kernel crash log is
> listed below.
> ```
> general protection fault, probably for non-canonical address
> 0xdffffc0000000000: 0000 [#1] PREEMPT SMP KASAN
> KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
> CPU: 1 PID: 9459 Comm: syz-executor414 Not tainted 6.7.0-rc7 #2
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
> RIP: 0010:disable_store+0xd0/0x3d0 drivers/usb/core/port.c:88
> Code: 02 00 00 4c 8b 75 40 4d 8d be 58 ff ff ff 4c 89 ff e8 a4 20 fa
> ff 48 89 c2 48 89 c5 48 b8 00 00 00 00 00 fc ff df 48 c1 ea 03 <80> 3c
> 02 00 0f 85 b0 02 00 00 48 8b 45 00 48 8d bb 34 05 00 00 48
> RSP: 0018:ffffc90006e3fc08 EFLAGS: 00010246
> RAX: dffffc0000000000 RBX: ffff88801d4d4008 RCX: ffffffff86706be8
> RDX: 0000000000000000 RSI: ffffffff86706c4d RDI: 0000000000000005
> RBP: 0000000000000000 R08: 0000000000000005 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000000 R12: 1ffff92000dc7f85
> R13: ffff88810f4bfb18 R14: ffff88801d4d10a8 R15: ffff88801d4d1000
> FS:  00007fa0af71b640(0000) GS:ffff888135c00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007fa0af71a4b8 CR3: 0000000022f5f000 CR4: 0000000000750ef0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> PKRU: 55555554
> Call Trace:
>  <TASK>
>  dev_attr_store+0x54/0x80 drivers/base/core.c:2366
>  sysfs_kf_write+0x114/0x170 fs/sysfs/file.c:136
>  kernfs_fop_write_iter+0x337/0x500 fs/kernfs/file.c:334
>  call_write_iter include/linux/fs.h:2020 [inline]
>  new_sync_write fs/read_write.c:491 [inline]
>  vfs_write+0x96a/0xd80 fs/read_write.c:584
>  ksys_write+0x122/0x250 fs/read_write.c:637
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0x40/0x110 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x63/0x6b
> RIP: 0033:0x7fa0aff9ee1f
> Code: 89 54 24 18 48 89 74 24 10 89 7c 24 08 e8 a9 f4 02 00 48 8b 54
> 24 18 48 8b 74 24 10 41 89 c0 8b 7c 24 08 b8 01 00 00 00 0f 05 <48> 3d
> 00 f0 ff ff 77 31 44 89 c7 48 89 44 24 08 e8 ec f4 02 00 48
> RSP: 002b:00007fa0af71a460 EFLAGS: 00000293 ORIG_RAX: 0000000000000001
> RAX: ffffffffffffffda RBX: 00000000ffffffff RCX: 00007fa0aff9ee1f
> RDX: 0000000000000004 RSI: 00007fa0af71acc0 RDI: 0000000000000005
> RBP: 0000000000000005 R08: 0000000000000000 R09: 00007fffdb6af2cf
> R10: 0000000000000000 R11: 0000000000000293 R12: 00007fa0af71acc0
> R13: 000000000000006e R14: 00007fa0aff613d0 R15: 00007fa0af6fb000
>  </TASK>
> Modules linked in:
> ---[ end trace 0000000000000000 ]---
> RIP: 0010:disable_store+0xd0/0x3d0 drivers/usb/core/port.c:88
> Code: 02 00 00 4c 8b 75 40 4d 8d be 58 ff ff ff 4c 89 ff e8 a4 20 fa
> ff 48 89 c2 48 89 c5 48 b8 00 00 00 00 00 fc ff df 48 c1 ea 03 <80> 3c
> 02 00 0f 85 b0 02 00 00 48 8b 45 00 48 8d bb 34 05 00 00 48
> RSP: 0018:ffffc90006e3fc08 EFLAGS: 00010246
> RAX: dffffc0000000000 RBX: ffff88801d4d4008 RCX: ffffffff86706be8
> RDX: 0000000000000000 RSI: ffffffff86706c4d RDI: 0000000000000005
> RBP: 0000000000000000 R08: 0000000000000005 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000000 R12: 1ffff92000dc7f85
> R13: ffff88810f4bfb18 R14: ffff88801d4d10a8 R15: ffff88801d4d1000
> FS:  00007fa0af71b640(0000) GS:ffff888063a00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 000055d23050c460 CR3: 0000000022f5f000 CR4: 0000000000750ef0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> PKRU: 55555554
> ----------------
> Code disassembly (best guess):
>    0:    02 00                    add    (%rax),%al
>    2:    00 4c 8b 75              add    %cl,0x75(%rbx,%rcx,4)
>    6:    40                       rex
>    7:    4d 8d be 58 ff ff ff     lea    -0xa8(%r14),%r15
>    e:    4c 89 ff                 mov    %r15,%rdi
>   11:    e8 a4 20 fa ff           call   0xfffa20ba
>   16:    48 89 c2                 mov    %rax,%rdx
>   19:    48 89 c5                 mov    %rax,%rbp
>   1c:    48 b8 00 00 00 00 00     movabs $0xdffffc0000000000,%rax
>   23:    fc ff df
>   26:    48 c1 ea 03              shr    $0x3,%rdx
> * 2a:    80 3c 02 00              cmpb   $0x0,(%rdx,%rax,1) <--
> trapping instruction
>   2e:    0f 85 b0 02 00 00        jne    0x2e4
>   34:    48 8b 45 00              mov    0x0(%rbp),%rax
>   38:    48 8d bb 34 05 00 00     lea    0x534(%rbx),%rdi
>   3f:    48                       rex.W
> ```
> We analyzed the root cause of this bug. When calling disable_store()
> in drivers/usb/core/port.c, if function authorized_store() is calling
> usb_deauthorized_device() concurrently, the usb_interface will be
> removed by usb_disable_device. However, in function disable_store,
> usb_hub_to_struct_hub() would try to deref interface, causing
> nullptr-deref. We also tested other functions in
> drivers/usb/core/port.c. So far we haven't found a similar problem.
> 
> If you have any questions, please contact us.
> 
> Reported by Yue Sun <samsun1006219@gmail.com>
> Reported by xingwei lee <xrivendell7@gmail.com>

Do you have a proposed patch to fix this as you have a way to easily
test this?

thanks,

greg k-h


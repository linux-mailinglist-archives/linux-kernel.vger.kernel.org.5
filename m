Return-Path: <linux-kernel+bounces-140754-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9E198A18C0
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 17:31:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9ECD31F22322
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 15:31:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 109DD156CF;
	Thu, 11 Apr 2024 15:31:24 +0000 (UTC)
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 8CCF413AE2
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.131.102.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849483; cv=none; b=PkDw33Oz3wJsp/SqkITHG5VuxixNVflc3VeKw8e75AXJ2X72kzw1Bcuzkczw9oKE5RZGS+yPHRiBANGKadaYPMiXL0ABbx26ITo6JC4Ar4ZD7ms+ibfmuaDm46rBz+hWsty0W1qIKs4D8dqoxfWm2MIcxIq2ce6Kw1ywyoaVCXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849483; c=relaxed/simple;
	bh=LV3XxHklggyH1m5MNwe1hhpT3rkIrYb8jHihU8HACXM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pn3FY8W/rajX4kBBfTyf2RMG1gNKoQ5ISrBYRksb6HS9b9pjadJgvfRs4mchrtzMviFycJSgZvLdjQTyI577mbhWDsfsdQ34H+WCc3MDe2aylekrL/uSULoXCMrFdFgFVdIWWNAnuEjUckeI+zi5QX3VDScfxwFA8JfW1JXe23o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=rowland.harvard.edu; spf=pass smtp.mailfrom=netrider.rowland.org; arc=none smtp.client-ip=192.131.102.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netrider.rowland.org
Received: (qmail 248476 invoked by uid 1000); 11 Apr 2024 11:24:39 -0400
Date: Thu, 11 Apr 2024 11:24:39 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: Sam Sun <samsun1006219@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
  Greg KH <gregkh@linuxfoundation.org>, swboyd@chromium.org,
  ricardo@marliere.net, hkallweit1@gmail.com, heikki.krogerus@linux.intel.com,
  mathias.nyman@linux.intel.com, royluo@google.com,
  syzkaller-bugs@googlegroups.com, xrivendell7@gmail.com
Subject: Re: [Linux kernel bug] general protection fault in disable_store
Message-ID: <92fe8e95-bc01-4d7d-9678-8cfc55cc4a7b@rowland.harvard.edu>
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

I don't see how this explanation could be correct.  disable_store() is a 
sysfs attribute file for the port device, so when it is called the port 
device structure must still be registered.  The interface structure 
doesn't get removed until after usb_disable_device() calls device_del(), 
which won't return until hub_disconnect() returns, which won't happen 
until after the port devices are unregistered, which doesn't happen 
until disable_store() calls sysfs_break_active_protection(), which is 
after the call to usb_hub_to_struct_hub().

Can you do a little extra debugging to find out exactly which C 
statement causes the trap?  The disassembly above indicates the trap 
happens during a compare against 0 inside disable_store() -- not inside 
usb_hub_to_struct_hub().  Can you figure out which comparison that is?

Alan Stern

> If you have any questions, please contact us.
> 
> Reported by Yue Sun <samsun1006219@gmail.com>
> Reported by xingwei lee <xrivendell7@gmail.com>
> 
> Best Regards,
> Yue


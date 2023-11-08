Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79A7A7E5260
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 10:08:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235428AbjKHJIJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 04:08:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235217AbjKHJIH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 04:08:07 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDB049F
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 01:08:05 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFA82C433C7;
        Wed,  8 Nov 2023 09:08:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1699434485;
        bh=/tqCy0GiTwNlj8HnVSS6XXto34Eu3HLPueFS68+ENk8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=U49qkNexYhu3FsxqoD7o4D41pHjm/LaVL80SdSH6WpfspyDHhAuj1uNFH5n/nGaMQ
         Rjl1/aNPgyMmxW8b9YDETmBkMpl5MDLw+WlnV6RnPKixL4wTNdYCAh0XLFj04BBQdA
         NC7ahpG8oLanWOceyGFUPdl7gqTsP89BBGg6xtys=
Date:   Wed, 8 Nov 2023 10:08:02 +0100
From:   "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To:     =?utf-8?B?5p+z6I+B5bOw?= <liujingfeng@qianxin.com>
Cc:     Marco Elver <elver@google.com>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "security@kernel.org" <security@kernel.org>,
        "syzkaller@googlegroups.com" <syzkaller@googlegroups.com>
Subject: Re: Reply: A null-ptr crash in linux-6.4 usb driver
Message-ID: <2023110820-improper-nervous-30ff@gregkh>
References: <01a265f7bb654e948485c1d0ddc14954@qianxin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <01a265f7bb654e948485c1d0ddc14954@qianxin.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 08, 2023 at 08:56:39AM +0000, 柳菁峰 wrote:
> A null-ptr crash was found in usb driver and it crashed with
> fault-inject.

Then don't do fault injection :)

> I have made a patch that simply checks for this null
> pointer, but I am not sure if this will affect certain functions or
> logic. I hope you can check it carefully please and the format meets
> the requirements this time.
> 
> 
> 
> The crash info:
> general protection fault, probably for non-canonical address 0xdffffc0000000021: 0000 [#1] PREEMPT SMP KASAN NOPTI
> KASAN: null-ptr-deref in range [0x0000000000000108-0x000000000000010f]
> CPU: 0 PID: 4280 Comm: syz-executor.3 Not tainted 6.4.0 #8
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.13.0-1ubuntu1.1 04/01/2014
> RIP: 0010:__device_attach+0xa9/0x450
> Code: e8 03 42 80 3c 20 00 0f 85 3f 03 00 00 48 b8 00 00 00 00 00 fc ff df 4c 8b 65 48 49 8d bc 24 08 01 00 00 48 89 fa 48 c1 ea 03 <0f> b6 04 02 84 c0 74 06 0f 8e f8 02 00 00 41 f6 84 24 08 01 00 00
> RSP: 0018:ffff888116927b98 EFLAGS: 00010206
> RAX: dffffc0000000000 RBX: 1ffff11022d24f73 RCX: 0000000000000000
> RDX: 0000000000000021 RSI: ffffffff847c3300 RDI: 0000000000000108
> RBP: ffff88811959b078 R08: 0000000000000000 R09: ffffffff860a0097
> R10: ffff888116927b98 R11: 0000000000000001 R12: 0000000000000000
> R13: ffff88811959b0f8 R14: 00000000fffffff0 R15: 0000000000000000
> FS:  00007f00232a3700(0000) GS:ffff88811ae00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007fff79859fb0 CR3: 000000010a18a005 CR4: 0000000000770ef0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> PKRU: 55555554
> Call Trace:
>   <TASK>
>   ? die_addr+0x38/0xa0
>   ? exc_general_protection+0x144/0x220
>   ? asm_exc_general_protection+0x22/0x30
>   ? __device_attach+0xa9/0x450
>   ? __device_attach+0x76/0x450
>   ? __pfx___device_attach+0x10/0x10
>   ? usb_ifnum_to_if+0x140/0x1d0
>   proc_ioctl.part.0+0x3ff/0x4a0
>   usbdev_ioctl+0x178a/0x3f70
>   ? __pfx_usbdev_ioctl+0x10/0x10
>   ? __pfx___lock_acquire+0x10/0x10
>   ? do_vfs_ioctl+0x120/0x1480
>   ? __pfx_do_vfs_ioctl+0x10/0x10
>   ? find_held_lock+0x2c/0x110
>   ? __fget_files+0x1f8/0x420
>   ? lock_release+0x3c3/0x6a0
>   ? __pfx_lock_release+0x10/0x10
>   ? lock_release+0x3c3/0x6a0
>   ? __fget_files+0x21a/0x420
>   ? __pfx_usbdev_ioctl+0x10/0x10
>   __x64_sys_ioctl+0x171/0x1e0
>   do_syscall_64+0x38/0x90
>   entry_SYSCALL_64_after_hwframe+0x72/0xdc
> RIP: 0033:0x4699cd
> Code: 02 b8 ff ff ff ff c3 66 0f 1f 44 00 00 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007f00232a2c58 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> RAX: ffffffffffffffda RBX: 000000000057c008 RCX: 00000000004699cd
> RDX: 0000000020000180 RSI: 00000000c0105512 RDI: 0000000000000003
> RBP: 00000000004d4a17 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 000000000057c008
> R13: 00007ffe93c75b1f R14: 00007ffe93c75cc0 R15: 00007f00232a2dc0
>   </TASK>
> 
> 
> 
> ---
> drivers/base/dd.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

You need a proper signed-off-by and description of what this patch does
here too.

> 
> 
> diff --git a/drivers/base/dd.c b/drivers/base/dd.c
> index 9c09ca5c4..fcd83226a 100644
> --- a/drivers/base/dd.c
> +++ b/drivers/base/dd.c
> @@ -1003,7 +1003,7 @@ static int __device_attach(struct device *dev, bool allow_async)
>         bool async = false;
> 
>         device_lock(dev);
> -       if (dev->p->dead) {
> +       if (!dev->p||dev->p->dead) {

How can p be NULL?

When p was assigned, why isn't it checked and handled properly then?

This isn't a change to the usb core, it's a change to the driver core.

I see this being properly checked in device_private_init(), so how can
this code path ever actually be hit?  Are you rewriting kernel memory
randomly with your fault injection code?

confused,

greg k-h

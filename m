Return-Path: <linux-kernel+bounces-61286-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E82D85105F
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 11:12:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E7DA1B235C2
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 10:12:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78BEE1803A;
	Mon, 12 Feb 2024 10:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.b="x1J7Ug7u"
Received: from smtp107.iad3a.emailsrvr.com (smtp107.iad3a.emailsrvr.com [173.203.187.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4A4B17BBE
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 10:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.203.187.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707732715; cv=none; b=G4KTcRIXWBUXV4njEd5ZRXUisZ2ulB5CaK0DJfrIGP6bebn9wXICvv1t8Nlk3gWXnCsVghXOt+v4PaH1kz0ERSeBAn4ex37oB7MehwEV8Cd7tOGUWTdkcVAf5b4auhihodr2WY1JjXWHrdv2C97fsS2tZ9OX6X/g6kzXPeIEy2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707732715; c=relaxed/simple;
	bh=2wyzB0QE3kpdGWU3sblt9oxOWxZLihwNJBrY33Ct7PI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r5e7VCmYBRx5cCENqdCGAzvGoitNEXFVkROgzNxIwngfpZiDnEtkpHDLyGau8KeX2pTC2qexujohKZ1ifPR5Q9f2Jlo/1c8EPA3Yha/xTbFuynKVcKl3O5BQxnqt39MkmlFu7Hu5lNsfcBLUdDwVfIMH3CyCkMSitEqvpEDgzJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mev.co.uk; spf=pass smtp.mailfrom=mev.co.uk; dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.b=x1J7Ug7u; arc=none smtp.client-ip=173.203.187.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mev.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mev.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mev.co.uk;
	s=20221208-6x11dpa4; t=1707732200;
	bh=2wyzB0QE3kpdGWU3sblt9oxOWxZLihwNJBrY33Ct7PI=;
	h=Date:Subject:To:From:From;
	b=x1J7Ug7uhtxfwPCfsgB5EoDPJ2go6hC7AmtiJPip7u520qVNlEYfsxruEn43Rr/0j
	 DyCh6vmPb0SdSB/doo3/BxJqjCh18kqfZQR+qeunsvlaxPTjWLv3j//2YYtbZwSIN0
	 4bK+e/xBHI/TIGh9Voxpto+0Sk+wwF5ZMh4SZF4I=
X-Auth-ID: abbotti@mev.co.uk
Received: by smtp22.relay.iad3a.emailsrvr.com (Authenticated sender: abbotti-AT-mev.co.uk) with ESMTPSA id 9E28A1984;
	Mon, 12 Feb 2024 05:03:19 -0500 (EST)
Message-ID: <66d15664-0d54-4e89-bf54-508ff072fab8@mev.co.uk>
Date: Mon, 12 Feb 2024 10:03:18 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] comedi: comedi_8255: Correct error in subdevice
 initialization
To: Frej Drejhammar <frej.drejhammar@gmail.com>,
 H Hartley Sweeten <hsweeten@visionengravers.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
References: <20240211175822.1357-1-frej.drejhammar@gmail.com>
Content-Language: en-GB
From: Ian Abbott <abbotti@mev.co.uk>
Organization: MEV Ltd.
In-Reply-To: <20240211175822.1357-1-frej.drejhammar@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Classification-ID: 13877c57-bc63-4c2e-b481-38fe52eaea54-1-1

On 11/02/2024 17:58, Frej Drejhammar wrote:
> The refactoring done in commit 5c57b1ccecc7 ("comedi: comedi_8255: Rework
> subdevice initialization functions") to the initialization of the io
> field of struct subdev_8255_private broke all cards using the
> drivers/comedi/drivers/comedi_8255.c module.
> 
> Prior to 5c57b1ccecc7, __subdev_8255_init() initialized the io field
> in the newly allocated struct subdev_8255_private to the non-NULL
> callback given to the function, otherwise it used a flag parameter to
> select between subdev_8255_mmio and subdev_8255_io. The refactoring
> removed that logic and the flag, as subdev_8255_mm_init() and
> subdev_8255_io_init() now explicitly pass subdev_8255_mmio and
> subdev_8255_io respectively to __subdev_8255_init(), only
> __subdev_8255_init() never sets spriv->io to the supplied
> callback. That spriv->io is NULL leads to a later BUG:
> 
> BUG: kernel NULL pointer dereference, address: 0000000000000000
> PGD 0 P4D 0
> Oops: 0010 [#1] SMP PTI
> CPU: 1 PID: 1210 Comm: systemd-udevd Not tainted 6.7.3-x86_64 #1
> Hardware name: XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
> RIP: 0010:0x0
> Code: Unable to access opcode bytes at 0xffffffffffffffd6.
> RSP: 0018:ffffa3f1c02d7b78 EFLAGS: 00010202
> RAX: 0000000000000000 RBX: ffff91f847aefd00 RCX: 000000000000009b
> RDX: 0000000000000003 RSI: 0000000000000001 RDI: ffff91f840f6fc00
> RBP: ffff91f840f6fc00 R08: 0000000000000000 R09: 0000000000000001
> R10: 0000000000000000 R11: 000000000000005f R12: 0000000000000000
> R13: 0000000000000000 R14: ffffffffc0102498 R15: ffff91f847ce6ba8
> FS:  00007f72f4e8f500(0000) GS:ffff91f8d5c80000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: ffffffffffffffd6 CR3: 000000010540e000 CR4: 00000000000406f0
> Call Trace:
>   <TASK>
>   ? __die_body+0x15/0x57
>   ? page_fault_oops+0x2ef/0x33c
>   ? insert_vmap_area.constprop.0+0xb6/0xd5
>   ? alloc_vmap_area+0x529/0x5ee
>   ? exc_page_fault+0x15a/0x489
>   ? asm_exc_page_fault+0x22/0x30
>   __subdev_8255_init+0x79/0x8d [comedi_8255]
>   pci_8255_auto_attach+0x11a/0x139 [8255_pci]
>   comedi_auto_config+0xac/0x117 [comedi]
>   ? __pfx___driver_attach+0x10/0x10
>   pci_device_probe+0x88/0xf9
>   really_probe+0x101/0x248
>   __driver_probe_device+0xbb/0xed
>   driver_probe_device+0x1a/0x72
>   __driver_attach+0xd4/0xed
>   bus_for_each_dev+0x76/0xb8
>   bus_add_driver+0xbe/0x1be
>   driver_register+0x9a/0xd8
>   comedi_pci_driver_register+0x28/0x48 [comedi_pci]
>   ? __pfx_pci_8255_driver_init+0x10/0x10 [8255_pci]
>   do_one_initcall+0x72/0x183
>   do_init_module+0x5b/0x1e8
>   init_module_from_file+0x86/0xac
>   __do_sys_finit_module+0x151/0x218
>   do_syscall_64+0x72/0xdb
>   entry_SYSCALL_64_after_hwframe+0x6e/0x76
> RIP: 0033:0x7f72f50a0cb9
> Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 47 71 0c 00 f7 d8 64 89 01 48
> RSP: 002b:00007ffd47e512d8 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
> RAX: ffffffffffffffda RBX: 0000562dd06ae070 RCX: 00007f72f50a0cb9
> RDX: 0000000000000000 RSI: 00007f72f52d32df RDI: 000000000000000e
> RBP: 0000000000000000 R08: 00007f72f5168b20 R09: 0000000000000000
> R10: 0000000000000050 R11: 0000000000000246 R12: 00007f72f52d32df
> R13: 0000000000020000 R14: 0000562dd06785c0 R15: 0000562dcfd0e9a8
>   </TASK>
> Modules linked in: 8255_pci(+) comedi_8255 comedi_pci comedi intel_gtt e100(+) acpi_cpufreq rtc_cmos usbhid
> CR2: 0000000000000000
> ---[ end trace 0000000000000000 ]---
> RIP: 0010:0x0
> Code: Unable to access opcode bytes at 0xffffffffffffffd6.
> RSP: 0018:ffffa3f1c02d7b78 EFLAGS: 00010202
> RAX: 0000000000000000 RBX: ffff91f847aefd00 RCX: 000000000000009b
> RDX: 0000000000000003 RSI: 0000000000000001 RDI: ffff91f840f6fc00
> RBP: ffff91f840f6fc00 R08: 0000000000000000 R09: 0000000000000001
> R10: 0000000000000000 R11: 000000000000005f R12: 0000000000000000
> R13: 0000000000000000 R14: ffffffffc0102498 R15: ffff91f847ce6ba8
> FS:  00007f72f4e8f500(0000) GS:ffff91f8d5c80000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: ffffffffffffffd6 CR3: 000000010540e000 CR4: 00000000000406f0
> 
> This patch simply corrects the above mistake by initializing spriv->io
> to the given io callback.
> 
> Fixes: 5c57b1ccecc7 ("comedi: comedi_8255: Rework subdevice initialization functions")
> Signed-off-by: Frej Drejhammar <frej.drejhammar@gmail.com>
> Cc: <stable@vger.kernel.org>
> ---
>   drivers/comedi/drivers/comedi_8255.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/comedi/drivers/comedi_8255.c b/drivers/comedi/drivers/comedi_8255.c
> index e4974b508328..a933ef53845a 100644
> --- a/drivers/comedi/drivers/comedi_8255.c
> +++ b/drivers/comedi/drivers/comedi_8255.c
> @@ -159,6 +159,7 @@ static int __subdev_8255_init(struct comedi_device *dev,
>   		return -ENOMEM;
>   
>   	spriv->context = context;
> +	spriv->io      = io;
>   
>   	s->type		= COMEDI_SUBD_DIO;
>   	s->subdev_flags	= SDF_READABLE | SDF_WRITABLE;

Thanks for the fix. I screwed up!

Acked-by: Ian Abbott <abbotti@mev.co.uk>
Reviewed-by: Ian Abbott <abbotti@mev.co.uk>

-- 
-=( Ian Abbott <abbotti@mev.co.uk> || MEV Ltd. is a company  )=-
-=( registered in England & Wales.  Regd. number: 02862268.  )=-
-=( Regd. addr.: S11 & 12 Building 67, Europa Business Park, )=-
-=( Bird Hall Lane, STOCKPORT, SK3 0XA, UK. || www.mev.co.uk )=-



Return-Path: <linux-kernel+bounces-156319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E4D58B011E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 07:37:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 551382824E0
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 05:37:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05525156873;
	Wed, 24 Apr 2024 05:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KA2yXBP9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F00C7156668;
	Wed, 24 Apr 2024 05:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713937025; cv=none; b=flLmRRfqYApKPmtH6N3uHP8U7pDmboSUdOCkVYUqcPaB6moq6hOQzJgH8JfREA/ZldYnN1B8cmXTnwdvBzgUN7Wisa3qjSTMnFM6XDsZo+/LqS4TACUEOQfOjPTHhWTK5O2CjKQd1Md+yp0TNc8+7fFPORGhqKyG60IvTcCu8tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713937025; c=relaxed/simple;
	bh=oHcGUQgqMIeQZMBzpiKANO7yxwwA4DzrP+qPeFBbeyI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W2/HQbi2yeUuUftT1x064y3No8jdZkt2x9+nIGpZgJ7pM6rei6yIk+zt8L4VGnTareBfXpGIbcSGTYwiloltQGlLUDfl2JWqfMcqfjiuvWcLkL42BYAQnbxppwZX02NLlqt+YVt8sEpn38dpwmnGbwcMBFPb9GosGX3b6pSbUWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KA2yXBP9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A662C113CE;
	Wed, 24 Apr 2024 05:37:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713937024;
	bh=oHcGUQgqMIeQZMBzpiKANO7yxwwA4DzrP+qPeFBbeyI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=KA2yXBP9mHjP6ONXLhJ8eEKCbdkLca2LwO3+ibuoCI3zl5Efd7xi/ltZCOGKjP9Oq
	 oMqG2Vgmde6IlP0hu8YIRDRPfReHYbG0vleqqn2xKrRxn3jHhczow85KkirWAQ/Fzx
	 asFV4F8kODK+5rXppBQr/P/9upGyezFoBpElMhc50kuw3cGjyNVikKmNr0H5VGNwms
	 iCuAQjZW3ZelReeYf/C8mYgyldtgXeLWRTdrTnog9nXrGWwkftWoZqpPpz6OCWmvWX
	 hwvRxkBsCCxGlsXGJKTVgiaB2EmUlLR+8hRwZFpUBfmXHwkx8idiIc1B9NPWC5N44O
	 mUPT7zmWI/Jsg==
Message-ID: <f229256f-ceac-4a82-afa4-ecea67712ec3@kernel.org>
Date: Wed, 24 Apr 2024 07:36:57 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nfc: pn533: Fix null-ptr-deref in pn533_recv_frame()
To: Yuxuan Hu <20373622@buaa.edu.cn>, gregkh@linuxfoundation.org,
 johan@kernel.org, davem@davemloft.net, u.kleine-koenig@pengutronix.de,
 Jonathan.Cameron@huawei.com, francesco.dolcini@toradex.com,
 jirislaby@kernel.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 baijiaju1990@gmail.com, sy2239101@buaa.edu.cn,
 Yuxuan Hu <yuxuanhu@buaa.edu.cn>
References: <20240422080408.1639247-1-20373622@buaa.edu.cn>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <20240422080408.1639247-1-20373622@buaa.edu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 22/04/2024 10:04, Yuxuan Hu wrote:
> From: Yuxuan Hu <yuxuanhu@buaa.edu.cn>
> 
> Our fuzzing tool found a null-ptr-deref in function pn533_recv_frame 
> (/drivers/nfc/pn533/pn533.c) in kernel 6.8.
> 
> (1.1) When execute the NFC_CMD_START_POLL command via netlink, the 
> pn533_send_cmd_async function (/drivers/nfc/pn533/pn533.c: 1714) is 
> called, which sends the PN533_CMD_IN_AUTOPOLL command packet.
> 
> (2.1) If a pn533 response frame that does not match the command is 
> received, the following call sequence is executed:
> pn533_recv_frame (/drivers/nfc/pn533/pn533.c: 2165)
>     pn533_rx_frame_is_cmd_response (/drivers/nfc/pn533/pn533.c: 2194)
>     pn533_wq_cmd_complete (/drivers/nfc/pn533/pn533.c: 2022)
>         pn533_send_async_complete (/drivers/nfc/pn533/pn533.c: 547)
>             pn533_autopoll_complete (/drivers/nfc/pn533/pn533.c: 414)
> 
> (2.2) After completing (2.1), dev->cmd is freed and set to null 
> (/drivers/nfc/pn533/pn533.c: 432-433).
> 
> (3.1) If another incorrect pn533 response frame is received during 
> the above process, (2.1) and (2.2) will be executed concurrently, and 
> the initial process setting dev->cmd to null causes the concurrent 
> process to trigger a null-ptr-deref in pn533_recv_frame.
> 
> Although pn533_recv_frame checks for dev->cmd at the beginning, it is 
> possible that dev->cmd is set to null after the check.

That sounds reasonable... but solution does not.

> 
> Through our verification, this concurrent vulnerability has a high 
> probability of occurrence and needs to be fixed.
> 
> Kernel print messages when null-ptr-deref is triggered (including PN533 
> packets, PN533 module errors, and KASAN reports) are as follows.
> We added printk of the data packets, and printk before the relevant steps 
> in pn533_send_async_complete and pn533_recv_frame.
> 
>   -> 00 00 FF 08 F8 D4 60 FF 03 00 11 12 04 A3 00 
>   <- 00 00 FF 00 FF 00 
>   <- 00 00 FF 0E F2 D5 86 01 10 09 01 00 20 08 04 9B 2C EE 9F 0A 00 
>   tty tty60: NFC: It it not the response to the last command
>   arted polling nfc device
>   <- 00 00 FF 03 FD D5 41 00 EA 00 
>   tty tty60: NFC: pn533_autopoll_complete  autopoll complete error -5
>   tty tty60: NFC: It it not the response to the last command
>   tty tty60: NFC: Error -5 when running autopoll
>   tty tty60: NFC: autopoll operation has been stopped
>   pn533_send_async_complete: set dev->cmd to null!!!
>   pn533_recv_frame: dev->cmd is null!!!
>   BUG: kernel NULL pointer dereference, address: 0000000000000014
>   #PF: supervisor write access in kernel mode
>   #PF: error_code(0x0002) - not-present page
>   PGD 0 P4D 0 
>   Oops: 0002 [#1] PREEMPT SMP KASAN PTI
>   CPU: 0 PID: 5541 Comm: kworker/0:0 Tainted: G           O       6.8.0 #1
>   Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.13.0-1ubuntu1.1 04/01/2014
>   Workqueue: events nfcvirt_recv_work [nfcvirt]
>   RIP: 0010:pn533_recv_frame+0x18a/0x1e0 [pn533]
>   Code: 43 ff ff ff 48 8b bb 80 02 00 00 48 c7 c6 0b 02 46 c0 31 c0 e8 97 64 4f c4 48 83 bb b0 01 00 00 00 74 3f 48 8b 83 b0 01 00 00 <c7> 40 14 fb ff ff ff 48 8b 83 b0 01 00 00 48 85 c0 0f 85 3b ff ff
>   RSP: 0018:ffff88802665fc68 EFLAGS: 00010246
>   RAX: 0000000000000000 RBX: ffff88804a13b800 RCX: ad381de3b3cd5e00
>   RDX: 1ffff11004ccbf38 RSI: 0000000000000008 RDI: ffff88802665f9e0
>   RBP: ffff88804fb25000 R08: ffff88802665f9e7 R09: 1ffff11004ccbf3c
>   R10: dffffc0000000000 R11: ffffed1004ccbf3d R12: 0000000000001950
>   R13: ffff88804ab80000 R14: ffff888021d22640 R15: ffff88802665fcb0
>   FS:  0000000000000000(0000) GS:ffff88806d200000(0000) knlGS:0000000000000000
>   CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>   CR2: 0000000000000014 CR3: 0000000004ebc000 CR4: 00000000000006f0

Please trim the log from irrelevant register dumps.

>   Call Trace:
>    <TASK>
>    ? __die_body+0x62/0xb0
>    ? page_fault_oops+0x421/0x740
>    ? kernelmode_fixup_or_oops+0x1d0/0x1d0
>    ? asan.module_ctor+0x10/0x10
>    ? vprintk_emit+0x3f0/0x3f0
>    ? kernelmode_fixup_or_oops+0x163/0x1d0
>    ? do_user_addr_fault+0xb6c/0xde0
>    ? irq_work_queue+0x54/0xa0
>    ? do_kern_addr_fault+0x160/0x160
>    ? __call_rcu_common+0x518/0xc30
>    ? _dev_err+0x106/0x150
>    ? exc_page_fault+0x66/0x1a0
>    ? asm_exc_page_fault+0x22/0x30
>    ? pn533_recv_frame+0x18a/0x1e0 [pn533]
>    ? pn533_recv_frame+0x1d7/0x1e0 [pn533]
>    nfcvirt_recv_work+0x24e/0x320 [nfcvirt]
>    ? wake_bit_function+0x230/0x230
>    process_one_work+0x4f0/0xab0
>    worker_thread+0x8af/0xee0
>    ? process_one_work+0xab0/0xab0
>    kthread+0x275/0x300
>    ? process_one_work+0xab0/0xab0
>    ? kthread_blkcg+0xa0/0xa0
>    ret_from_fork+0x30/0x60
>    ? kthread_blkcg+0xa0/0xa0
>    ret_from_fork_asm+0x11/0x20
>    </TASK>
>   Modules linked in: nfcvirt(O) pn533(O) nfc(O) ki_coverage(O) [last unloaded: pn533(O)]
>   CR2: 0000000000000014
>   ---[ end trace 0000000000000000 ]---
>   RIP: 0010:pn533_recv_frame+0x18a/0x1e0 [pn533]
>   Code: 43 ff ff ff 48 8b bb 80 02 00 00 48 c7 c6 0b 02 46 c0 31 c0 e8 97 64 4f c4 48 83 bb b0 01 00 00 00 74 3f 48 8b 83 b0 01 00 00 <c7> 40 14 fb ff ff ff 48 8b 83 b0 01 00 00 48 85 c0 0f 85 3b ff ff
>   RSP: 0018:ffff88802665fc68 EFLAGS: 00010246
>   RAX: 0000000000000000 RBX: ffff88804a13b800 RCX: ad381de3b3cd5e00
>   RDX: 1ffff11004ccbf38 RSI: 0000000000000008 RDI: ffff88802665f9e0
>   RBP: ffff88804fb25000 R08: ffff88802665f9e7 R09: 1ffff11004ccbf3c
>   R10: dffffc0000000000 R11: ffffed1004ccbf3d R12: 0000000000001950
>   R13: ffff88804ab80000 R14: ffff888021d22640 R15: ffff88802665fcb0
>   FS:  0000000000000000(0000) GS:ffff88806d200000(0000) knlGS:0000000000000000
>   CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>   CR2: 0000000000000014 CR3: 0000000004ebc000 CR4: 00000000000006f0

Same here.

This just makes the commit log less readable.

> 
> Signed-off-by: Yuxuan Hu <yuxuanhu@buaa.edu.cn>
> ---
>  drivers/nfc/pn533/pn533.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/nfc/pn533/pn533.c b/drivers/nfc/pn533/pn533.c
> index b19c39dcfbd9..a80a23332f59 100644
> --- a/drivers/nfc/pn533/pn533.c
> +++ b/drivers/nfc/pn533/pn533.c
> @@ -2190,9 +2190,13 @@ void pn533_recv_frame(struct pn533 *dev, struct sk_buff *skb, int status)
>  
>  	if (!dev->ops->rx_is_frame_valid(skb->data, dev)) {
>  		nfc_err(dev->dev, "Received an invalid frame\n");

Imagine here dev->cmd != NULL...

> +		if (!dev->cmd)
> +			goto sched_wq;

.. but here is being NULL-ified by pn533_send_async_complete(). How
does your solution prevent anything? I assume pn533_recv_frame() will be
executed in parallel to the workqueue.

A bit better solution would be to NULL-ify dev->cmd at the beginning of
pn533_send_async_complete(), because that seems logical. The complete
callback takes ownership of dev->cmd, so why it performs the assignment
at the end?

However even above code will keep the race open for short period.
Probably some locking would solve it or checking for dev->cmd in few
places with barriers.

Best regards,
Krzysztof



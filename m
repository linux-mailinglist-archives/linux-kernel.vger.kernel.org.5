Return-Path: <linux-kernel+bounces-59780-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B525584FBB0
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 19:16:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CE3B1F239AA
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 18:16:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20E8A80BFC;
	Fri,  9 Feb 2024 18:16:20 +0000 (UTC)
Received: from air.basealt.ru (air.basealt.ru [194.107.17.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 055747EF01;
	Fri,  9 Feb 2024 18:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.107.17.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707502579; cv=none; b=USEMXSpcfqLrUHxUDSFhuDDx1ncFTvMqFVvcs7tbmLJlSjgV6soMehWAKkq75x9P7qkNKkK+r7f3wTk482RHbn/s5ZFI0/BogM6rKfvFRSxEyzVhOkySfwLZkNarVSkMiA0ufsbdXU7FcUnmULMCmEt2KHo90dmM5uktWYvi6gM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707502579; c=relaxed/simple;
	bh=hX1l/Lh4jyHuTTXJ9Bs/52PPQqTdcUtw6j6rEQ2wz5k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HS1nYHjcdhZ9w2MKlJyxR/W7079kXmx6yHzCOj/0765HLE+9ZfkkA+wDp+f14ofT48DDhrIJRnHf3irFpP1jge5CrkIZ2B4QGj3QQBtc7q+A4uKCFUSi9Na49Q86S+kOCfCPxZxvHbcyTinfAWXmXG5Tm07f8ZzQoIz2/z0T7tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org; spf=pass smtp.mailfrom=altlinux.org; arc=none smtp.client-ip=194.107.17.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altlinux.org
Received: by air.basealt.ru (Postfix, from userid 490)
	id 23B782F2024D; Fri,  9 Feb 2024 18:16:08 +0000 (UTC)
X-Spam-Level: 
Received: from [192.168.0.102] (unknown [178.76.204.78])
	by air.basealt.ru (Postfix) with ESMTPSA id 1328C2F2024B;
	Fri,  9 Feb 2024 18:16:01 +0000 (UTC)
Message-ID: <d602ebc3-f0e7-171c-7d76-e2f9bb4c2db6@basealt.ru>
Date: Fri, 9 Feb 2024 21:16:00 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 1/1] gtp: fix use-after-free and null-ptr-deref in
 gtp_genl_dump_pdp()
Content-Language: en-US
To: Eric Dumazet <edumazet@google.com>
Cc: pablo@netfilter.org, laforge@gnumonks.org, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, osmocom-net-gprs@lists.osmocom.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, nickel@altlinux.org,
 oficerovas@altlinux.org, dutyrok@altlinux.org
References: <20240124101404.161655-1-kovalev@altlinux.org>
 <20240124101404.161655-2-kovalev@altlinux.org>
 <CANn89iLKc8-hwvSBE=aSTRg=52Pn9B0HmFDneGCe6PMawPFCnQ@mail.gmail.com>
 <1144600e-52f1-4c1a-4854-c53e05af5b45@basealt.ru>
 <CANn89iKb+NQPOuZ9wdovQYVOwC=1fUMMdWd5VrEU=EsxTH7nFg@mail.gmail.com>
From: kovalev@altlinux.org
In-Reply-To: <CANn89iKb+NQPOuZ9wdovQYVOwC=1fUMMdWd5VrEU=EsxTH7nFg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

24.01.2024 14:52, Eric Dumazet wrote:
> On Wed, Jan 24, 2024 at 12:20 PM <kovalev@altlinux.org> wrote:
>> 24.01.2024 13:57, Eric Dumazet wrote:
>>> Oh wait, this is a 5.10 kernel ?
>> Yes, but the bug is reproduced on the latest stable kernels.
>>> Please generate a stack trace using a recent tree, it is possible the
>>> bug has been fixed already.
>> See [PATCH 0/1] above, there's a stack for the 6.6.13 kernel at the
>> bottom of the message.
> Ah, ok. Not sure why you sent a cover letter for a single patch...
>
> Setting a boolean, in a module that can disappear will not prevent the
> module from disappearing.
>
> This work around might work, or might not work, depending on timing,
> preemptions, ....
>
> Thanks.

I tested running the reproducer [1] on the 6.8-rc3 kernel, the crash 
occurs in less than 10 seconds and the qemu VM restarts:

dmesg -w:

[  106.941736] gtp: GTP module unloaded
[  106.962548] gtp: GTP module loaded (pdp ctx size 104 bytes)
[  107.014691] gtp: GTP module unloaded
[  107.041554] gtp: GTP module loaded (pdp ctx size 104 bytes)
[  107.082283] gtp: GTP module unloaded
[  107.123268] general protection fault, probably for non-canonical 
address 0xdffffc0000000002: 0000 [#1] PREEMPT SMP KASAN NOPTI
[  107.124050] KASAN: null-ptr-deref in range 
[0x0000000000000010-0x0000000000000017]
[  107.124339] CPU: 1 PID: 5826 Comm: gtp Not tainted 
6.8.0-rc3-std-def-alt1 #1
[  107.124604] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 
1.16.0-alt1 04/01/2014
[  107.124916] RIP: 0010:gtp_genl_dump_pdp+0x1be/0x800 [gtp]
[  107.125141] Code: c6 89 c6 e8 64 e9 86 df 58 45 85 f6 0f 85 4e 04 00 
00 e8 c5 ee 86 df 48 8b 54 24 18 48 b8 00 00 00 00 00 fc ff df 48 c1 ea 
03 <80> 3c 02 00 0f 85 de 05 00 00 48 8b 44 24 18 4c 8b 30 4c 39 f0 74
[  107.125960] RSP: 0018:ffff888014107220 EFLAGS: 00010202
[  107.126164] RAX: dffffc0000000000 RBX: 0000000000000000 RCX: 
0000000000000000
[  107.126434] RDX: 0000000000000002 RSI: 0000000000000000 RDI: 
0000000000000000
[  107.126707] RBP: 0000000000000000 R08: 0000000000000000 R09: 
0000000000000000
[  107.126976] R10: 0000000000000000 R11: 0000000000000000 R12: 
0000000000000000
[  107.127245] R13: ffff88800fcda588 R14: 0000000000000001 R15: 
0000000000000000
[  107.127515] FS:  00007f1be4eb05c0(0000) GS:ffff88806ce80000(0000) 
knlGS:0000000000000000
[  107.127955] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  107.128177] CR2: 00007f1be4e766cf CR3: 000000000c33e000 CR4: 
0000000000750ef0
[  107.128450] PKRU: 55555554
[  107.128577] Call Trace:
[  107.128699]  <TASK>
[  107.128790]  ? show_regs+0x90/0xa0
[  107.128935]  ? die_addr+0x50/0xd0
[  107.129075]  ? exc_general_protection+0x148/0x220
[  107.129267]  ? asm_exc_general_protection+0x22/0x30
[  107.129469]  ? gtp_genl_dump_pdp+0x1be/0x800 [gtp]
[  107.129677]  ? __alloc_skb+0x1dd/0x350
[  107.129831]  ? __pfx___alloc_skb+0x10/0x10
[  107.129999]  genl_dumpit+0x11d/0x230
[  107.130150]  netlink_dump+0x5b9/0xce0
[  107.130301]  ? lockdep_hardirqs_on_prepare+0x253/0x430
[  107.130503]  ? __pfx_netlink_dump+0x10/0x10
[  107.130686]  ? kasan_save_track+0x10/0x40
[  107.130849]  ? __kasan_kmalloc+0x9b/0xa0
[  107.131009]  ? genl_start+0x675/0x970
[  107.131162]  __netlink_dump_start+0x6fc/0x9f0
[  107.131341]  genl_family_rcv_msg_dumpit+0x1bb/0x2d0
[  107.131538]  ? __pfx_genl_family_rcv_msg_dumpit+0x10/0x10
[  107.131754]  ? genl_op_from_small+0x2a/0x440
[  107.131972]  ? cap_capable+0x1d0/0x240
[  107.132127]  ? __pfx_genl_start+0x10/0x10
[  107.132292]  ? __pfx_genl_dumpit+0x10/0x10
[  107.132461]  ? __pfx_genl_done+0x10/0x10
[  107.132645]  ? security_capable+0x9d/0xe0

With the proposed patch applied, such a crash is not observed during 
long-term testing.

[1] 
https://lore.kernel.org/lkml/20240124101404.161655-1-kovalev@altlinux.org/T/#mf9b411baec52858b1c9118c671f26a6dc424e7b4

-- 
Regards,
Vasiliy Kovalev



Return-Path: <linux-kernel+bounces-36843-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 650D183A79D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 12:20:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CC591F2613D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 11:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDB2E1AADB;
	Wed, 24 Jan 2024 11:20:11 +0000 (UTC)
Received: from air.basealt.ru (air.basealt.ru [194.107.17.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 832A32BAF3;
	Wed, 24 Jan 2024 11:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.107.17.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706095211; cv=none; b=bAtYECntS7dwPemU4AJ+d7lnOpvCWtUWd+YnAgj4J3FwqGwFHVwM+4+VpOF0b3BFrTL72kt7Md2rqq6dRE6nc/0uhu5bVrSGWh/8CaBjbVOlEbo6uLAX79O22J5E4l4yTkyZzRxSs1lSjoT3junoFqJ7swlY2aS0LFpZh8ZpJWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706095211; c=relaxed/simple;
	bh=SwYywfFiynvvHpJ2PvBMDL2E2B8ISlww9VXd7SFdmSE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iAvqIVw9qJ8N6BaDp+jk0e0fxD5O8zggZGDwSBN7A01Yhhwc5Cw+6McxKNGEqJkueq/uVD7al0V5v2wIWrhbLfMRnNCztFGhVtoF6p9eiPKUPDUek2iC9/5qdARAWh+ZkG+d09fDIs1EFAUVXTzkgQ9QcB17yDl48hGlcArSAzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org; spf=pass smtp.mailfrom=altlinux.org; arc=none smtp.client-ip=194.107.17.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altlinux.org
Received: by air.basealt.ru (Postfix, from userid 490)
	id 733622F20242; Wed, 24 Jan 2024 11:20:06 +0000 (UTC)
X-Spam-Level: 
Received: from [10.88.144.178] (obninsk.basealt.ru [217.15.195.17])
	by air.basealt.ru (Postfix) with ESMTPSA id 94C0B2F20236;
	Wed, 24 Jan 2024 11:20:04 +0000 (UTC)
Message-ID: <1144600e-52f1-4c1a-4854-c53e05af5b45@basealt.ru>
Date: Wed, 24 Jan 2024 14:20:04 +0300
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
 oficerovas@altlinux.org, dutyrok@altlinux.org, kovalev@altlinux.org
References: <20240124101404.161655-1-kovalev@altlinux.org>
 <20240124101404.161655-2-kovalev@altlinux.org>
 <CANn89iLKc8-hwvSBE=aSTRg=52Pn9B0HmFDneGCe6PMawPFCnQ@mail.gmail.com>
From: kovalev@altlinux.org
In-Reply-To: <CANn89iLKc8-hwvSBE=aSTRg=52Pn9B0HmFDneGCe6PMawPFCnQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

24.01.2024 13:57, Eric Dumazet wrote:
> Oh wait, this is a 5.10 kernel ?
Yes, but the bug is reproduced on the latest stable kernels.
> Please generate a stack trace using a recent tree, it is possible the
> bug has been fixed already.

See [PATCH 0/1] above, there's a stack for the 6.6.13 kernel at the 
bottom of the message.

[  523.915255] Call Trace:
[  523.915255]  <TASK>
[  523.915255]  ? __die+0x1f/0x70
[  523.915255]  ? page_fault_oops+0x14d/0x4a0
[  523.915255]  ? exc_page_fault+0x7b/0x180
[  523.915255]  ? asm_exc_page_fault+0x22/0x30
[  523.915255]  ? gtp_genl_dump_pdp+0x82/0x190 [gtp]
[  523.915255]  ? gtp_genl_dump_pdp+0x82/0x190 [gtp]
[  523.915255]  genl_dumpit+0x2f/0x90
[  523.915255]  netlink_dump+0x126/0x320
[  523.915255]  __netlink_dump_start+0x1da/0x2a0
[  523.915255]  genl_family_rcv_msg_dumpit+0x93/0x100
[  523.915255]  ? __pfx_genl_start+0x10/0x10
[  523.915255]  ? __pfx_genl_dumpit+0x10/0x10
[  523.915255]  ? __pfx_genl_done+0x10/0x10
[  523.915255]  genl_rcv_msg+0x112/0x2a0
[  523.915255]  ? __pfx_gtp_genl_dump_pdp+0x10/0x10 [gtp]
[  523.915255]  ? __pfx_genl_rcv_msg+0x10/0x10
[  523.915255]  netlink_rcv_skb+0x54/0x110
[  523.915255]  genl_rcv+0x24/0x40
[  523.915255]  netlink_unicast+0x19f/0x290
[  523.915255]  netlink_sendmsg+0x250/0x4e0
[  523.915255]  ____sys_sendmsg+0x376/0x3b0
[  523.915255]  ? copy_msghdr_from_user+0x6d/0xb0
[  523.915255]  ___sys_sendmsg+0x86/0xe0
[  523.915255]  ? do_fault+0x296/0x470
[  523.915255]  ? __handle_mm_fault+0x771/0xda0
[  523.915255]  __sys_sendmsg+0x57/0xb0
[  523.915255]  do_syscall_64+0x59/0x90
[  523.915255]  ? ct_kernel_exit.isra.0+0x71/0x90
[  523.915255]  ? __ct_user_enter+0x5a/0xd0
[  523.915255]  entry_SYSCALL_64_after_hwframe+0x6e/0xd8
[  523.915255] RIP: 0033:0x7f2bcb93cd49

-- 
Regards,
Vasiliy Kovalev



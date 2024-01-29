Return-Path: <linux-kernel+bounces-42662-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E3020840488
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 13:03:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21C0C1C21334
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 12:03:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D06825FBB1;
	Mon, 29 Jan 2024 12:02:56 +0000 (UTC)
Received: from ganesha.gnumonks.org (ganesha.gnumonks.org [213.95.27.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45AD35F544;
	Mon, 29 Jan 2024 12:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.27.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706529776; cv=none; b=J3d6g5vHuUIuWjEGyQUbQvW0X/x8H17OW12LwsHsDSGNj+JvxwcqET89tgYJy0vzfd86430IluJOP7aoL/GAyqB7ihzaHIhrm539gCi/C/9aqEyCUNkRbtJSnq/APaaA9yy5x+q0UESulXJCswWDcohDYZs7xR1d3pYYEcYq9GE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706529776; c=relaxed/simple;
	bh=pGbJ27JnYljmxLcfm9joJeRrsJ7Caqlg7bLtcQgUIhk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CotbZ3B1CIharL16B77Uz9DOnKeVk/1vO3hqKL3tPucIlOaqFyx65CTGjDAIGwMD9BG5nqr626z55DyB0JUFZiG9QxN9VZPWZCCH/BtHLTZSf+M09cQU4FGcxmnd/w7bzAtM3GBTxnbAjL5R5iBbHNK0RLO5rrerTyw8Bcgg6Sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=gnumonks.org; arc=none smtp.client-ip=213.95.27.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gnumonks.org
Received: from [78.30.41.52] (port=53984 helo=gnumonks.org)
	by ganesha.gnumonks.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <pablo@gnumonks.org>)
	id 1rUQLY-00DalQ-0n; Mon, 29 Jan 2024 13:02:42 +0100
Date: Mon, 29 Jan 2024 13:02:39 +0100
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: kovalev@altlinux.org
Cc: Eric Dumazet <edumazet@google.com>, laforge@gnumonks.org,
	davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
	osmocom-net-gprs@lists.osmocom.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, nickel@altlinux.org,
	oficerovas@altlinux.org, dutyrok@altlinux.org
Subject: Re: [PATCH 1/1] gtp: fix use-after-free and null-ptr-deref in
 gtp_genl_dump_pdp()
Message-ID: <ZbeT31rUh0h3CctO@calendula>
References: <20240124101404.161655-1-kovalev@altlinux.org>
 <20240124101404.161655-2-kovalev@altlinux.org>
 <CANn89iLKc8-hwvSBE=aSTRg=52Pn9B0HmFDneGCe6PMawPFCnQ@mail.gmail.com>
 <1144600e-52f1-4c1a-4854-c53e05af5b45@basealt.ru>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1144600e-52f1-4c1a-4854-c53e05af5b45@basealt.ru>
X-Spam-Score: -1.9 (-)

Hi,

On Wed, Jan 24, 2024 at 02:20:04PM +0300, kovalev@altlinux.org wrote:
> 24.01.2024 13:57, Eric Dumazet wrote:
> > Oh wait, this is a 5.10 kernel ?
>
> Yes, but the bug is reproduced on the latest stable kernels.
>
> > Please generate a stack trace using a recent tree, it is possible the
> > bug has been fixed already.

__netlink_dump_start() is called at the beginning of the dump, which is
grabbing a reference on this module.

do you have a reproducer?

> See [PATCH 0/1] above, there's a stack for the 6.6.13 kernel at the bottom
> of the message.
> 
> [  523.915255] Call Trace:
> [  523.915255]  <TASK>
> [  523.915255]  ? __die+0x1f/0x70
> [  523.915255]  ? page_fault_oops+0x14d/0x4a0
> [  523.915255]  ? exc_page_fault+0x7b/0x180
> [  523.915255]  ? asm_exc_page_fault+0x22/0x30
> [  523.915255]  ? gtp_genl_dump_pdp+0x82/0x190 [gtp]
> [  523.915255]  ? gtp_genl_dump_pdp+0x82/0x190 [gtp]
> [  523.915255]  genl_dumpit+0x2f/0x90
> [  523.915255]  netlink_dump+0x126/0x320
> [  523.915255]  __netlink_dump_start+0x1da/0x2a0
> [  523.915255]  genl_family_rcv_msg_dumpit+0x93/0x100
> [  523.915255]  ? __pfx_genl_start+0x10/0x10
> [  523.915255]  ? __pfx_genl_dumpit+0x10/0x10
> [  523.915255]  ? __pfx_genl_done+0x10/0x10
> [  523.915255]  genl_rcv_msg+0x112/0x2a0
> [  523.915255]  ? __pfx_gtp_genl_dump_pdp+0x10/0x10 [gtp]
> [  523.915255]  ? __pfx_genl_rcv_msg+0x10/0x10
> [  523.915255]  netlink_rcv_skb+0x54/0x110
> [  523.915255]  genl_rcv+0x24/0x40
> [  523.915255]  netlink_unicast+0x19f/0x290
> [  523.915255]  netlink_sendmsg+0x250/0x4e0
> [  523.915255]  ____sys_sendmsg+0x376/0x3b0
> [  523.915255]  ? copy_msghdr_from_user+0x6d/0xb0
> [  523.915255]  ___sys_sendmsg+0x86/0xe0
> [  523.915255]  ? do_fault+0x296/0x470
> [  523.915255]  ? __handle_mm_fault+0x771/0xda0
> [  523.915255]  __sys_sendmsg+0x57/0xb0
> [  523.915255]  do_syscall_64+0x59/0x90
> [  523.915255]  ? ct_kernel_exit.isra.0+0x71/0x90
> [  523.915255]  ? __ct_user_enter+0x5a/0xd0
> [  523.915255]  entry_SYSCALL_64_after_hwframe+0x6e/0xd8
> [  523.915255] RIP: 0033:0x7f2bcb93cd49
> 
> -- 
> Regards,
> Vasiliy Kovalev
> 


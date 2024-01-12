Return-Path: <linux-kernel+bounces-24677-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B7FE182C0AA
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 14:16:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C9B91F244B6
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 13:16:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1277C6BB5C;
	Fri, 12 Jan 2024 13:16:20 +0000 (UTC)
Received: from exchange.fintech.ru (exchange.fintech.ru [195.54.195.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84A3A2AEEC;
	Fri, 12 Jan 2024 13:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fintech.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fintech.ru
Received: from Ex16-01.fintech.ru (10.0.10.18) by exchange.fintech.ru
 (195.54.195.159) with Microsoft SMTP Server (TLS) id 14.3.498.0; Fri, 12 Jan
 2024 16:16:06 +0300
Received: from localhost (10.0.253.138) by Ex16-01.fintech.ru (10.0.10.18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Fri, 12 Jan
 2024 16:16:06 +0300
From: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
To: Alexander Aring <aahringo@redhat.com>
CC: Nikita Zhandarovich <n.zhandarovich@fintech.ru>, Zhang Shurong
	<zhang_shurong@foxmail.com>, <alex.aring@gmail.com>,
	<stefan@datenfreihafen.org>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <linux-wpan@vger.kernel.org>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<harperchen1110@gmail.com>
Subject: Re: [PATCH RESEND] mac802154: Fix uninit-value access in ieee802154_hdr_push_sechdr
Date: Fri, 12 Jan 2024 05:15:54 -0800
Message-ID: <20240112131554.10352-1-n.zhandarovich@fintech.ru>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <CAK-6q+jsZ13Cs9iuk_WjFeYFCEnnj-dJ9QYkWaw4fh6Gi=JtHA@mail.gmail.com>
References:
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: Ex16-02.fintech.ru (10.0.10.19) To Ex16-01.fintech.ru
 (10.0.10.18)

>> > >
>> > > BUG: KMSAN: uninit-value in ieee802154_hdr_push_sechdr net/ieee802154=
> /header_ops.c:54 [inline]
>> > > BUG: KMSAN: uninit-value in ieee802154_hdr_push+0x971/0xb90 net/ieee8=
> 02154/header_ops.c:108
>> > >  ieee802154_hdr_push_sechdr net/ieee802154/header_ops.c:54 [inline]
>> > >  ieee802154_hdr_push+0x971/0xb90 net/ieee802154/header_ops.c:108
>> > >  ieee802154_header_create+0x9c0/0xc00 net/mac802154/iface.c:396
>> > >  wpan_dev_hard_header include/net/cfg802154.h:494 [inline]
>> > >  dgram_sendmsg+0xd1d/0x1500 net/ieee802154/socket.c:677
>> > >  ieee802154_sock_sendmsg+0x91/0xc0 net/ieee802154/socket.c:96
>> > >  sock_sendmsg_nosec net/socket.c:725 [inline]
>> > >  sock_sendmsg net/socket.c:748 [inline]
>> > >  ____sys_sendmsg+0x9c2/0xd60 net/socket.c:2494
>> > >  ___sys_sendmsg+0x28d/0x3c0 net/socket.c:2548
>> > >  __sys_sendmsg+0x225/0x3c0 net/socket.c:2577
>> > >  __compat_sys_sendmsg net/compat.c:346 [inline]
>> > >  __do_compat_sys_sendmsg net/compat.c:353 [inline]
>> > >  __se_compat_sys_sendmsg net/compat.c:350 [inline]
>> > >
>> > > We found hdr->key_id_mode is uninitialized in mac802154_set_header_se=
> curity()
>> > > which indicates hdr.fc.security_enabled should be 0. However, it is s=
> et to be cb->secen before.
>> > > Later, ieee802154_hdr_push_sechdr is invoked, causing KMSAN complains=
>  uninit-value issue.
>> >
>> > I am not too deeply involved in the security header but for me it feels
>> > like your patch does the opposite of what's needed. We should maybe
>> > initialize hdr->key_id_mode based on the value in cb->secen, no? (maybe
>> > Alexander will have a better understanding than I have).
>>
>> I can't help yet with a better answer why syzkaller reports it but it
>> will break things as we using skb->cb to pass additional parameters
>> through header_ops->create()... in this case it is some sockopts of
>> af802154, I guess.
>>
> 
> Maybe we just need to init some "more" defaults in [0]
> 
> - Alex
> 
> [0] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
> /net/ieee802154/socket.c?h=3Dv6.7-rc5#n474

Hello,

I was looking into the same issue (now present in syzbot [1]) and since it has a
C-repro, the error is easy to recreate. Apparently, despite cb->secen (and
hdr.fc.security_enabled accordingly) being equal 1, mac802154_set_header_security()
finishes with 0 in:

	if (!params.enabled ||
	    (cb->secen_override && !cb->secen) ||
	    !params.out_level)
	    return 0;

Not presuming to understand the issue fully but if we do end up leaving
mac802154_set_header_security() early, should we init hdr->key_id_mode
with IEEE802154_SCF_KEY_IMPLICIT before returning with 0?
I imagine that reseting hdr.fc.security_enabled to 0 ourselves in this
case is a wrong way to go too.

[1] https://syzkaller.appspot.com/bug?extid=60a66d44892b66b56545

Hoping not to have spewed too much nonsense here...

With regards,
Nikita


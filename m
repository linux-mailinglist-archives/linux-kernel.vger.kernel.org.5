Return-Path: <linux-kernel+bounces-63796-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C22D853486
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 16:24:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E98F1C2106A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 15:24:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 492095DF2F;
	Tue, 13 Feb 2024 15:24:34 +0000 (UTC)
Received: from exchange.fintech.ru (exchange.fintech.ru [195.54.195.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D64C75D902;
	Tue, 13 Feb 2024 15:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.54.195.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707837873; cv=none; b=jN1XVInVt+IDSuoqDkojjr4l8WqktzTV8rSdNCYPXhch5iZJWNB9uTHpS9rEYMEliHk4J7MFTXtK999EjSvb8l4Gsa96oFKQwALlXUVZs2QHeYvE8mOSZeFxFQNoUB7KY6EnD/xOsnSKrKU5t29QOXZdY/rD4gfdjYyE8IHQwZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707837873; c=relaxed/simple;
	bh=CwNvQx4cKxm4wTveQJa2fF9BF88LSILbE5saxxP+eqw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=F/iKuI7y2Tx+QDSFsr35EzvXa2uBbqET3fJGxfLlw26ZRPGh9ScS9JYaG6X++0e7BeerQmKcObFJa8O6ae4zwwXjEKERg8ULvVffvXLha3ddMxjiPWPT8rL0Vo/wyOQhyrlhLayGINkKUo5aDMjUEQMu5p1Ii1i9mU4In9298bU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fintech.ru; spf=pass smtp.mailfrom=fintech.ru; arc=none smtp.client-ip=195.54.195.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fintech.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fintech.ru
Received: from Ex16-01.fintech.ru (10.0.10.18) by exchange.fintech.ru
 (195.54.195.169) with Microsoft SMTP Server (TLS) id 14.3.498.0; Tue, 13 Feb
 2024 18:24:20 +0300
Received: from localhost (10.0.253.138) by Ex16-01.fintech.ru (10.0.10.18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Tue, 13 Feb
 2024 18:24:20 +0300
From: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
To: Alexander Aring <alex.aring@gmail.com>
CC: Nikita Zhandarovich <n.zhandarovich@fintech.ru>, Stefan Schmidt
	<stefan@datenfreihafen.org>, Miquel Raynal <miquel.raynal@bootlin.com>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	<linux-wpan@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <syzkaller-bugs@googlegroups.com>,
	<syzbot+60a66d44892b66b56545@syzkaller.appspotmail.com>
Subject: [PATCH wpan] mac802154: fix uninit-value issue in ieee802154_header_create()
Date: Tue, 13 Feb 2024 07:24:14 -0800
Message-ID: <20240213152414.3703-1-n.zhandarovich@fintech.ru>
X-Mailer: git-send-email 2.25.1
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

Syzkaller with KMSAN reported [1] a problem with uninitialized value
access in ieee802154_header_create().

The issue arises from a weird combination of cb->secen == 1 and
cb->secen_override == 0, while other required security parameters
are not found enabled in mac802154_set_header_security().

Ideally such case is expected to be caught by starting check at the
beginning of mac802154_set_header_security():

	if (!params.enabled && cb->secen_override && cb->secen)
		return -EINVAL;

However, since secen_override is zero, the function in question
passes this check and returns with success early, without having
set values to ieee802154_sechdr fields such as key_id_mode. This in
turn leads to uninitialized access of such values in
ieee802154_hdr_push_sechdr() and other places.

Fix this problem by only checking for secen value and presence of
security parameters (and ignoring secen_override). Exit early with
error if necessary requirements are not met.

[1]
BUG: KMSAN: uninit-value in ieee802154_hdr_push_sechdr net/ieee802154/header_ops.c:54 [inline]
BUG: KMSAN: uninit-value in ieee802154_hdr_push+0x971/0xb90 net/ieee802154/header_ops.c:108
 ieee802154_hdr_push_sechdr net/ieee802154/header_ops.c:54 [inline]
 ieee802154_hdr_push+0x971/0xb90 net/ieee802154/header_ops.c:108
 ieee802154_header_create+0x9c0/0xc00 net/mac802154/iface.c:396
 wpan_dev_hard_header include/net/cfg802154.h:494 [inline]
 dgram_sendmsg+0xd1d/0x1500 net/ieee802154/socket.c:677
 ieee802154_sock_sendmsg+0x91/0xc0 net/ieee802154/socket.c:96
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg net/socket.c:745 [inline]
 ____sys_sendmsg+0x9c2/0xd60 net/socket.c:2584
 ___sys_sendmsg+0x28d/0x3c0 net/socket.c:2638
 __sys_sendmsg net/socket.c:2667 [inline]
 __do_sys_sendmsg net/socket.c:2676 [inline]
 __se_sys_sendmsg net/socket.c:2674 [inline]
 __x64_sys_sendmsg+0x307/0x490 net/socket.c:2674
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0x44/0x110 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b

Local variable hdr created at:
 ieee802154_header_create+0x4e/0xc00 net/mac802154/iface.c:360
 wpan_dev_hard_header include/net/cfg802154.h:494 [inline]
 dgram_sendmsg+0xd1d/0x1500 net/ieee802154/socket.c:677

Fixes: f30be4d53cad ("mac802154: integrate llsec with wpan devices")
Reported-and-tested-by: syzbot+60a66d44892b66b56545@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=60a66d44892b66b56545
Signed-off-by: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
---
P.S. Link to previous similar discussion:
https://lore.kernel.org/all/tencent_1C04CA8D66ADC45608D89687B4020B2A8706@qq.com/
P.P.S. This issue may affect stable versions, at least up to 6.1.

 net/mac802154/iface.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mac802154/iface.c b/net/mac802154/iface.c
index c0e2da5072be..ad799d349625 100644
--- a/net/mac802154/iface.c
+++ b/net/mac802154/iface.c
@@ -328,7 +328,7 @@ static int mac802154_set_header_security(struct ieee802154_sub_if_data *sdata,
 
 	mac802154_llsec_get_params(&sdata->sec, &params);
 
-	if (!params.enabled && cb->secen_override && cb->secen)
+	if (!params.enabled && cb->secen)
 		return -EINVAL;
 	if (!params.enabled ||
 	    (cb->secen_override && !cb->secen) ||


Return-Path: <linux-kernel+bounces-53187-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6413E84A1D8
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 19:13:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 723A91C23005
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 18:12:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13FA347F76;
	Mon,  5 Feb 2024 18:12:54 +0000 (UTC)
Received: from exchange.fintech.ru (exchange.fintech.ru [195.54.195.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B11D481AC;
	Mon,  5 Feb 2024 18:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.54.195.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707156773; cv=none; b=NWddX+bt9XiBqfhCrkCChaX62s/A2z1UWYYI93ragA9qmqGF53cP+TbcKyaprwJGTo5n5vw2GfbN8cW00b+PHnx9NtJRcWRDUOMc3sAcOG6O/+De2G+N/5ttA0dI5ggXhzF0xlOBkQvZ/c1qFs1TFNZ85E6nAGxPMjUeVkdvsG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707156773; c=relaxed/simple;
	bh=n8N7r/5U8euCWe7HHeBpW4qZBL/8nbymCpH6xYaz0cM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NqSQ8iiY4jloemsIv3SGFQpEG5B0mQVj7ObU8ytTMJ3FsFSQoalWVs6/U9dmJlj+T+QJz7cx5fWKStyA6nbQEZIXt0g08MDpymb0aywUP8KKdCnI2Zii4g2x/qLfwdhoqjX5Ak0ZShT+Qstec3q/HEFdpQaBVgQYGnvfbUUfmCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fintech.ru; spf=pass smtp.mailfrom=fintech.ru; arc=none smtp.client-ip=195.54.195.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fintech.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fintech.ru
Received: from Ex16-01.fintech.ru (10.0.10.18) by exchange.fintech.ru
 (195.54.195.159) with Microsoft SMTP Server (TLS) id 14.3.498.0; Mon, 5 Feb
 2024 21:11:36 +0300
Received: from localhost (10.0.253.138) by Ex16-01.fintech.ru (10.0.10.18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Mon, 5 Feb 2024
 21:11:35 +0300
From: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
To: "Jason A. Donenfeld" <Jason@zx2c4.com>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>
CC: Nikita Zhandarovich <n.zhandarovich@fintech.ru>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	<wireguard@lists.zx2c4.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, syzbot <syzkaller@googlegroups.com>,
	<syzbot+d1de830e4ecdaac83d89@syzkaller.appspotmail.com>
Subject: [PATCH RESEND net v2] wireguard: receive: annotate data-race around receiving_counter.counter
Date: Mon, 5 Feb 2024 10:11:11 -0800
Message-ID: <20240205181111.43414-1-n.zhandarovich@fintech.ru>
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

Syzkaller with KCSAN identified a data-race issue [1] when accessing
keypair->receiving_counter.counter.

This patch uses READ_ONCE() and WRITE_ONCE() annotations to fix the
problem.

[1]
BUG: KCSAN: data-race in wg_packet_decrypt_worker / wg_packet_rx_poll

write to 0xffff888107765888 of 8 bytes by interrupt on cpu 0:
 counter_validate drivers/net/wireguard/receive.c:321 [inline]
 wg_packet_rx_poll+0x3ac/0xf00 drivers/net/wireguard/receive.c:461
 __napi_poll+0x60/0x3b0 net/core/dev.c:6536
 napi_poll net/core/dev.c:6605 [inline]
 net_rx_action+0x32b/0x750 net/core/dev.c:6738
 __do_softirq+0xc4/0x279 kernel/softirq.c:553
 do_softirq+0x5e/0x90 kernel/softirq.c:454
 __local_bh_enable_ip+0x64/0x70 kernel/softirq.c:381
 __raw_spin_unlock_bh include/linux/spinlock_api_smp.h:167 [inline]
 _raw_spin_unlock_bh+0x36/0x40 kernel/locking/spinlock.c:210
 spin_unlock_bh include/linux/spinlock.h:396 [inline]
 ptr_ring_consume_bh include/linux/ptr_ring.h:367 [inline]
 wg_packet_decrypt_worker+0x6c5/0x700 drivers/net/wireguard/receive.c:499
 process_one_work kernel/workqueue.c:2633 [inline]
 ...

read to 0xffff888107765888 of 8 bytes by task 3196 on cpu 1:
 decrypt_packet drivers/net/wireguard/receive.c:252 [inline]
 wg_packet_decrypt_worker+0x220/0x700 drivers/net/wireguard/receive.c:501
 process_one_work kernel/workqueue.c:2633 [inline]
 process_scheduled_works+0x5b8/0xa30 kernel/workqueue.c:2706
 worker_thread+0x525/0x730 kernel/workqueue.c:2787
 ...

Fixes: a9e90d9931f3 ("wireguard: noise: separate receive counter from send counter")
Reported-by: syzbot+d1de830e4ecdaac83d89@syzkaller.appspotmail.com
Signed-off-by: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
---
v2: add missing annotation in wg_packet_rx_poll() per Eric Duzamet's
<edumazet@google.com> helpful suggestion.

 drivers/net/wireguard/receive.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireguard/receive.c b/drivers/net/wireguard/receive.c
index a176653c8861..db01ec03bda0 100644
--- a/drivers/net/wireguard/receive.c
+++ b/drivers/net/wireguard/receive.c
@@ -251,7 +251,7 @@ static bool decrypt_packet(struct sk_buff *skb, struct noise_keypair *keypair)
 
 	if (unlikely(!READ_ONCE(keypair->receiving.is_valid) ||
 		  wg_birthdate_has_expired(keypair->receiving.birthdate, REJECT_AFTER_TIME) ||
-		  keypair->receiving_counter.counter >= REJECT_AFTER_MESSAGES)) {
+		  READ_ONCE(keypair->receiving_counter.counter) >= REJECT_AFTER_MESSAGES)) {
 		WRITE_ONCE(keypair->receiving.is_valid, false);
 		return false;
 	}
@@ -318,7 +318,7 @@ static bool counter_validate(struct noise_replay_counter *counter, u64 their_cou
 		for (i = 1; i <= top; ++i)
 			counter->backtrack[(i + index_current) &
 				((COUNTER_BITS_TOTAL / BITS_PER_LONG) - 1)] = 0;
-		counter->counter = their_counter;
+		WRITE_ONCE(counter->counter, their_counter);
 	}
 
 	index &= (COUNTER_BITS_TOTAL / BITS_PER_LONG) - 1;
@@ -463,7 +463,7 @@ int wg_packet_rx_poll(struct napi_struct *napi, int budget)
 			net_dbg_ratelimited("%s: Packet has invalid nonce %llu (max %llu)\n",
 					    peer->device->dev->name,
 					    PACKET_CB(skb)->nonce,
-					    keypair->receiving_counter.counter);
+					    READ_ONCE(keypair->receiving_counter.counter));
 			goto next;
 		}
 


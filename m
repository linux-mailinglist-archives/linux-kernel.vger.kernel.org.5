Return-Path: <linux-kernel+bounces-113990-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D80E8887CA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:09:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5AE9B1C26B76
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:09:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF06E1428E9;
	Sun, 24 Mar 2024 23:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dasxYGpQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E97951F30A9;
	Sun, 24 Mar 2024 22:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321119; cv=none; b=UQ4GNH6FTzh5VMt0SBA1G0o1VMzAVufxT+V/0dYZRETt/wmjpVCbPNN5LiyX0aDINfHKZOOJtEH/9RICY3G1YZ465DNiHVR0PZ7hkpXLfb3mJET31kZGiddgp/f7/ek4VOLH/lM2t6LPkyp2r9nThSDGL4tKPQXGpn9BUE8coS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321119; c=relaxed/simple;
	bh=RMsiwQfl7cYHKFn8JymDMhMZpp+GCZ0RkLUQJ2lV0CU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VFu6/6M3xmPq+Hc/abpGyxaVDflaLAUrPA05eRF3J9NMJb9ITrL++5mZwmnfapDS1qKTk1fmkTQR6BI5Eq1yjgfv2DtWi3ELV2Z1ndavSe7BngPjpajYrqZ4LP9SM8aFOkQ1jk5tAnnQUawIEr79uJu8dz3sdtwmWHrD7nBqWO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dasxYGpQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE69EC43399;
	Sun, 24 Mar 2024 22:58:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321118;
	bh=RMsiwQfl7cYHKFn8JymDMhMZpp+GCZ0RkLUQJ2lV0CU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dasxYGpQ+oJvfWFPbSIOr3obHDMDqdjzrQhuLO6PKbQa87gKVRIT3aNpUIpAUVMuH
	 i+HdebdutNWVEj7NN+50QX+LpnCdTBbjudOEXWllh4higDQzR3j26o8Z7fYeixkPFf
	 v09Ljd1sFWy2zc7ILl+Ja8FC05ey7xiIp8iKeSNQdo0PMHWjmBb3XmExNe4isoGEee
	 kLTXtayee/p45PxRtEREnvirEmHZVS8jXGJsIglvDBTEYMXv/Cv//mS76aBZzLnNzZ
	 sp9wDuQxkUik/aOdRtnmZDcjPkGNCGPoVLGwSwG0Obxgc+SIJxqC2OQb64aOkkxgKb
	 YWZai7y13bIdQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Nikita Zhandarovich <n.zhandarovich@fintech.ru>,
	syzbot+d1de830e4ecdaac83d89@syzkaller.appspotmail.com,
	"Jason A . Donenfeld" <Jason@zx2c4.com>,
	Jiri Pirko <jiri@nvidia.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 680/713] wireguard: receive: annotate data-race around receiving_counter.counter
Date: Sun, 24 Mar 2024 18:46:46 -0400
Message-ID: <20240324224720.1345309-681-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324224720.1345309-1-sashal@kernel.org>
References: <20240324224720.1345309-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Nikita Zhandarovich <n.zhandarovich@fintech.ru>

[ Upstream commit bba045dc4d996d03dce6fe45726e78a1a1f6d4c3 ]

Syzkaller with KCSAN identified a data-race issue when accessing
keypair->receiving_counter.counter. Use READ_ONCE() and WRITE_ONCE()
annotations to mark the data race as intentional.

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
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireguard/receive.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireguard/receive.c b/drivers/net/wireguard/receive.c
index a176653c88616..db01ec03bda00 100644
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
 
-- 
2.43.0



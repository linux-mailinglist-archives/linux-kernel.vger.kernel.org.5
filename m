Return-Path: <linux-kernel+bounces-113573-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A316888567
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:06:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AE58AB23A08
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:06:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 440B91C8829;
	Sun, 24 Mar 2024 22:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cl6fKrql"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C0671C880B;
	Sun, 24 Mar 2024 22:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320376; cv=none; b=gWNFsQNBepjUNx/NTCogKJNJLwiRWBwHknwRz5I8ENxK1jRFq/sCWYpZyLGnC6C9YkDy9oWf5gEXLpbi/TfInnOxNQj/3VuKaXPIdwFBMaM737vCBJ47G4L0N9inPm4l00kh0Q1Kzw8bPqKH6ORxCgBkdOauALlCPEa1m4Pj060=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320376; c=relaxed/simple;
	bh=RMsiwQfl7cYHKFn8JymDMhMZpp+GCZ0RkLUQJ2lV0CU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RSDaVH7Pmtygkt4AlmvBvCY/WboTpC++Y4S0VYHbs7OuUCmi8ua68+u977PmJbTu2xg1kz4jW1tKdJoune07QSqDR9Vn3bYKcG1ot0MJO+FGDtb2vFyn+Dgi++5J478Z1N1itbVVnJDLqjZHHuXMv3KMkGy0H3K10Rcj3OB1Dg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cl6fKrql; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 659E6C43399;
	Sun, 24 Mar 2024 22:46:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320376;
	bh=RMsiwQfl7cYHKFn8JymDMhMZpp+GCZ0RkLUQJ2lV0CU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Cl6fKrqlUJPLdHoc92cfccCee4mWLDvf+2y1HFmsDr+mjXgEFuLnG4HBis8c0irE8
	 1GT9DCADdLD/j1iJVCJMC+YFxUxQNW+kPfBho/jI7fDGUlotmKWizHGNS1lwxE7p2m
	 zmtYrP+lo+nywJA/M2U8GXci6Ica/cyHOJ7Ww5R537xWY0uGR4JPOb3xiiRWNSoGhN
	 +Jg+nZC6he5CSm7Giq3vrUxqvM45q8LsuISPaYYi1BUpWPYuKbyU7roBJ9LZlrwjmp
	 6h0+3v8LEUtFEd51zeBg33N+6QEZqaW8j3Hi0FnobiLpw59AwUTGUCR53MOKHN1WFu
	 ONfAEmjdgDAqg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Nikita Zhandarovich <n.zhandarovich@fintech.ru>,
	syzbot+d1de830e4ecdaac83d89@syzkaller.appspotmail.com,
	"Jason A . Donenfeld" <Jason@zx2c4.com>,
	Jiri Pirko <jiri@nvidia.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 682/715] wireguard: receive: annotate data-race around receiving_counter.counter
Date: Sun, 24 Mar 2024 18:34:21 -0400
Message-ID: <20240324223455.1342824-683-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
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



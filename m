Return-Path: <linux-kernel+bounces-113595-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AF1D0888594
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:11:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FC8E1F240F8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:11:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ABAF75807;
	Sun, 24 Mar 2024 22:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GryioFye"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C83D1CCE44;
	Sun, 24 Mar 2024 22:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320398; cv=none; b=iA595EJ9FYROFBx2vBfA8MMijKSOWs8G2B5yh+OA/XS94Tb5DexF2b2FUDy8VrgyDzI3f20SALU/cuLztX3vBXbMkY6Nb3ltnS3E1/CjED8hgm5jyKqjW/Sfh2Nn6Sjgia0sh6bXira9CF1hNuDHBMl4+kfd5+j8TGWeq/gRheI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320398; c=relaxed/simple;
	bh=cCKaGFKaaq2aPdwssBwou06amcLXcG4Mo8pwh3kNhkU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bj2Tp46plnW+aeKs3wARmRxzNdNXw5Cm98BWyYbU6LX+Ga31oqHHrEOBKyNP0Tl5U0zkmaPLQ3VTB3GZbplrt9MYm5SK5xndcoWoOiDlSEw1Bwo7vvAjSqKrUaqrQTRt1I8i6UuRQMpcyNq/gl+uRljx9ikLyVpaMHM3v5HS/VA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GryioFye; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43B07C433B2;
	Sun, 24 Mar 2024 22:46:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320398;
	bh=cCKaGFKaaq2aPdwssBwou06amcLXcG4Mo8pwh3kNhkU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GryioFyeyxAU4r7GbyBtRxQU75QbR8GqeCnpQXOY78QF3pIWTjhkGIMC9ukwi7If1
	 MZIm29dPpzzwCpG1iVyKGPzL6qilOYKc7ps2yoeSWqt2iYB6qSS3bYxC1HbUF0lZrx
	 7HTOHeRfamS4GGIws736ZEa8yziKB8WQB3HtEgqOdkvlXkxHyBlQFqYu2+UxUgeq36
	 8StoA/Ke0JJbGEDBZc5wsafMBZSrajOKEw8HcirYjXFl053T4A1CiImxN8ZXdQrtU6
	 LZ2BXyqbEIgoZFTRfOEkfeKDOJzIy3PrCtjPhkEa14AzN/Rcsmy4lXpHRD7SU6vSkG
	 IYJuqUthubOwA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Yan Zhai <yan@cloudflare.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 704/715] net: report RCU QS on threaded NAPI repolling
Date: Sun, 24 Mar 2024 18:34:43 -0400
Message-ID: <20240324223455.1342824-705-sashal@kernel.org>
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

From: Yan Zhai <yan@cloudflare.com>

[ Upstream commit d6dbbb11247c71203785a2c9da474c36f4b19eae ]

NAPI threads can keep polling packets under load. Currently it is only
calling cond_resched() before repolling, but it is not sufficient to
clear out the holdout of RCU tasks, which prevent BPF tracing programs
from detaching for long period. This can be reproduced easily with
following set up:

ip netns add test1
ip netns add test2

ip -n test1 link add veth1 type veth peer name veth2 netns test2

ip -n test1 link set veth1 up
ip -n test1 link set lo up
ip -n test2 link set veth2 up
ip -n test2 link set lo up

ip -n test1 addr add 192.168.1.2/31 dev veth1
ip -n test1 addr add 1.1.1.1/32 dev lo
ip -n test2 addr add 192.168.1.3/31 dev veth2
ip -n test2 addr add 2.2.2.2/31 dev lo

ip -n test1 route add default via 192.168.1.3
ip -n test2 route add default via 192.168.1.2

for i in `seq 10 210`; do
 for j in `seq 10 210`; do
    ip netns exec test2 iptables -I INPUT -s 3.3.$i.$j -p udp --dport 5201
 done
done

ip netns exec test2 ethtool -K veth2 gro on
ip netns exec test2 bash -c 'echo 1 > /sys/class/net/veth2/threaded'
ip netns exec test1 ethtool -K veth1 tso off

Then run an iperf3 client/server and a bpftrace script can trigger it:

ip netns exec test2 iperf3 -s -B 2.2.2.2 >/dev/null&
ip netns exec test1 iperf3 -c 2.2.2.2 -B 1.1.1.1 -u -l 1500 -b 3g -t 100 >/dev/null&
bpftrace -e 'kfunc:__napi_poll{@=count();} interval:s:1{exit();}'

Report RCU quiescent states periodically will resolve the issue.

Fixes: 29863d41bb6e ("net: implement threaded-able napi poll loop support")
Reviewed-by: Jesper Dangaard Brouer <hawk@kernel.org>
Signed-off-by: Yan Zhai <yan@cloudflare.com>
Acked-by: Paul E. McKenney <paulmck@kernel.org>
Acked-by: Jesper Dangaard Brouer <hawk@kernel.org>
Link: https://lore.kernel.org/r/4c3b0d3f32d3b18949d75b18e5e1d9f13a24f025.1710877680.git.yan@cloudflare.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/core/dev.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/core/dev.c b/net/core/dev.c
index 439419d912eb0..c9b8412f1c9d3 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -6708,6 +6708,8 @@ static int napi_threaded_poll(void *data)
 	void *have;
 
 	while (!napi_thread_wait(napi)) {
+		unsigned long last_qs = jiffies;
+
 		for (;;) {
 			bool repoll = false;
 
@@ -6732,6 +6734,7 @@ static int napi_threaded_poll(void *data)
 			if (!repoll)
 				break;
 
+			rcu_softirq_qs_periodic(last_qs);
 			cond_resched();
 		}
 	}
-- 
2.43.0



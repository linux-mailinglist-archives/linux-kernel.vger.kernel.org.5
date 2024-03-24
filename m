Return-Path: <linux-kernel+bounces-114471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D71E2888AAC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:24:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CF921F2619D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:24:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38DCF17CF6B;
	Sun, 24 Mar 2024 23:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sCPuVmSZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EECB156C6D;
	Sun, 24 Mar 2024 23:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321899; cv=none; b=FbhAQJWt+kSgf8dq2GzHJfR6fBTipxPiZ+yU0Zm9moJHEzYfkfWB9UiWbU4NhRM/ba50LNpl+cf2TyXfu+6uhD1O22TNvRNgjusm7nMZXnmwQkIqW0MelFG9adzgFZ+7XOdknmI1Yy4O+FRfanKKnGgR4VSw/8lU1BY6bfgZ56g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321899; c=relaxed/simple;
	bh=KfwDjXDxUaYF07I39Iz8WI9g83GqG4ln62S9uC3nKm4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OvkFIr2QRfYClTKA+7pFS6aEYbOj04vQNYfpe7n0kLras/1rtiUj+4O6+tRwJ54QRm34ILkCzvHNVhxEH+n+CTgGJTswY1U8U0RZ1g+BsaKeUYmd7G1unGTubDDvCP+L9DifsI6CyZxjfdb7CfgKUE7Q4ebciyAVxvFSjJtKg3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sCPuVmSZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9389FC433B1;
	Sun, 24 Mar 2024 23:11:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321898;
	bh=KfwDjXDxUaYF07I39Iz8WI9g83GqG4ln62S9uC3nKm4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sCPuVmSZ4bOw5tLPBpF9Cbw/qdvsNwmPkCXw6JthSsp2Prd0RMEZ6Vbm/rj9ffFYA
	 dExynvWvpjGgMR1YdE3szLTpm28FXz+Lo9HRYIj9T9hzPTkaG4V2xJdDoP+aWF7RZl
	 eT0iNtpLKakj6OqmNa7G51cxowfF+LTJXGYxrNRHrjVdJrLIIU1+fqglmn3ZbKRd4W
	 AV5/jYV91xEZAwSSLHuLNV/gItCDTx19d65zNiyxkHLic1xWITuwH1Dom86g66P9p8
	 Lcnz7U3KQsyzdLUj9yhEIA2htGbmygWohjmXNRJLWutnP9cpsT0Hd/zgYrgvABJYIE
	 tBOAUdqlFxcUg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Yan Zhai <yan@cloudflare.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 627/638] net: report RCU QS on threaded NAPI repolling
Date: Sun, 24 Mar 2024 19:01:04 -0400
Message-ID: <20240324230116.1348576-628-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324230116.1348576-1-sashal@kernel.org>
References: <20240324230116.1348576-1-sashal@kernel.org>
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
index 8ac8b5c561030..1f6c8945f2eca 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -6689,6 +6689,8 @@ static int napi_threaded_poll(void *data)
 	void *have;
 
 	while (!napi_thread_wait(napi)) {
+		unsigned long last_qs = jiffies;
+
 		for (;;) {
 			bool repoll = false;
 
@@ -6713,6 +6715,7 @@ static int napi_threaded_poll(void *data)
 			if (!repoll)
 				break;
 
+			rcu_softirq_qs_periodic(last_qs);
 			cond_resched();
 		}
 	}
-- 
2.43.0



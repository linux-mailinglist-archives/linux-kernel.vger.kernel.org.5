Return-Path: <linux-kernel+bounces-113998-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AA9B8887DB
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:12:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BB0F1C26D36
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:12:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 533A4157487;
	Sun, 24 Mar 2024 23:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N2tgX2vN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0037F14BFBD;
	Sun, 24 Mar 2024 22:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321142; cv=none; b=Jh397LHJ6lOmNo0m+U6kTp6oljYhfU3sLkD1dElrK0vvtY13BNjEJx1FXQ1caRe+1LDaFgeAY1B9CUEGKfZip195wFuE8YLtVgdRjPkKW9RgUOVYtOXljBAy1Km5Pm8DYpxk9U70UW6DczhVMsI0LM5ej0248eLDF9/ECrKNI3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321142; c=relaxed/simple;
	bh=0swHJxYrBHmtAizG4AL6sWoZHWf/Br+7m4Md/cLVXVI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KMNseobjQwRDfSgI2I1nBT689tVXVWKglqHHBbqnzTCyCnRsIL/Mgw3rxmgJXr0Vj+8BVVXcpYp7d13otst7EeWk3PaJlLSWSO5RskpHaHDn0TIQV1PvJSIcNPglUQg1aZIX0xLloS+E8zD1d9uzacIfHUlr4fN0zs6xC7iQx/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N2tgX2vN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0A30C43399;
	Sun, 24 Mar 2024 22:58:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321140;
	bh=0swHJxYrBHmtAizG4AL6sWoZHWf/Br+7m4Md/cLVXVI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=N2tgX2vNxqEEUpK1owXpQzx/H1eMSkN4cWSQuJDVWvo1hfaXK/vfn3cFcIhTIi/I0
	 zJJVfaTeCiHU8+khIxteYPRlsyWHpn8fpZeC/5X0+92iAtWBe3cJSQVeyqblwsfDrv
	 WCM8ITLWlQIdwDF4EYdI4lzIFgUdmSPQfaZRih8hKbzYIZma+bQ2O13XyP4fZNlz+0
	 uT5YF3tJ8+ERQtZAsng7lbHkCxlcyb6NAXQCC7Nd5naSOoM9eraP5FIGoivi1bhUfg
	 9XWIoH7/YpDUkEXXhsVkYXWL5zzWh0TLxy30XTJRGOFOIQzZVB33CzJj1DhliV0smW
	 YFKmAcXrCqN6w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Yan Zhai <yan@cloudflare.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 702/713] net: report RCU QS on threaded NAPI repolling
Date: Sun, 24 Mar 2024 18:47:08 -0400
Message-ID: <20240324224720.1345309-703-sashal@kernel.org>
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
index ae898594690f7..e3c06ccf21d03 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -6668,6 +6668,8 @@ static int napi_threaded_poll(void *data)
 	void *have;
 
 	while (!napi_thread_wait(napi)) {
+		unsigned long last_qs = jiffies;
+
 		for (;;) {
 			bool repoll = false;
 
@@ -6692,6 +6694,7 @@ static int napi_threaded_poll(void *data)
 			if (!repoll)
 				break;
 
+			rcu_softirq_qs_periodic(last_qs);
 			cond_resched();
 		}
 	}
-- 
2.43.0



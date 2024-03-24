Return-Path: <linux-kernel+bounces-114700-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99065888BCF
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:00:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA2911C29A2F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:00:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C5FD14F9C9;
	Mon, 25 Mar 2024 00:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fuhNIq6/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2072815FCE9;
	Sun, 24 Mar 2024 23:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322364; cv=none; b=u//mkETbscUGBfTcrTXw3DJ2wzFkmiB+4KKvl4rlEua/i8Nsey+wS6qeH6HuOOZPeaRib34Drsl2sfUCAWbxN9L2PZY51xSHX2D9skaiJqn5xery6X13bTMNNEowcl1ZnV7HMVW/vwwCvR+li5j+4R927XMm6u+lOTP5qzXlYsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322364; c=relaxed/simple;
	bh=90Uqm9QF4FUxa1GZXRDF0mBH1f1Bbm0BPJYWcT65jps=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lHVIpkZ1i63iUEjWtGzFe0+tXaG3njKI0PEbzAayiwEZMrCjwbaA7EuUD3WWvTfdB1Lw17MKBI+1xUKCuMHUMFHN70fl6kVBOEcs0fdp+Pb2xvNQjBIx/gBtOgorgfDkUOvv0dgNlNBjzwSTz1q5Xafdl8QZec//z0YL32Z2rys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fuhNIq6/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38118C43394;
	Sun, 24 Mar 2024 23:19:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711322363;
	bh=90Uqm9QF4FUxa1GZXRDF0mBH1f1Bbm0BPJYWcT65jps=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fuhNIq6/PEKQYYYLEdKkP8YdY42HJOat6Tmf1iXZ4jHxSFjV8fhtYdTiWVkireadg
	 3c/BFcnikLvJ5yG5Mu/3NSLDkYU+qfpWtJ7JPOB/ee1JxEUM8OnrWE2r4wnc92NI1L
	 Q8/tJ0VTZKjP/sJnHzgQtMSKlhimiBlzcvaRILtwYRo3wIQv1klmIbnBNrswLgOk7W
	 4wvuo2Q+o90c+tNm9dxPRSFZ+FtKirtmdqj6jgXv1Q2WgsohOaTPWLz4IvUU0+f7cB
	 +BoVajYmcRmohNWwpIeyhq+xRut0X7YJ0ZPcvctk6RrxghHRzUpiLJvZxdqkSxX9FR
	 7hcwQVC2/rMtg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ido Schimmel <idosch@nvidia.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Hangbin Liu <liuhangbin@gmail.com>,
	Jiri Pirko <jiri@nvidia.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 445/451] selftests: forwarding: Fix ping failure due to short timeout
Date: Sun, 24 Mar 2024 19:12:01 -0400
Message-ID: <20240324231207.1351418-446-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324231207.1351418-1-sashal@kernel.org>
References: <20240324231207.1351418-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Ido Schimmel <idosch@nvidia.com>

[ Upstream commit e4137851d4863a9bdc6aabc613bcb46c06d91e64 ]

The tests send 100 pings in 0.1 second intervals and force a timeout of
11 seconds, which is borderline (especially on debug kernels), resulting
in random failures in netdev CI [1].

Fix by increasing the timeout to 20 seconds. It should not prolong the
test unless something is wrong, in which case the test will rightfully
fail.

[1]
 # selftests: net/forwarding: vxlan_bridge_1d_port_8472_ipv6.sh
 # INFO: Running tests with UDP port 8472
 # TEST: ping: local->local                                            [ OK ]
 # TEST: ping: local->remote 1                                         [FAIL]
 # Ping failed
 [...]

Fixes: b07e9957f220 ("selftests: forwarding: Add VxLAN tests with a VLAN-unaware bridge for IPv6")
Fixes: 728b35259e28 ("selftests: forwarding: Add VxLAN tests with a VLAN-aware bridge for IPv6")
Reported-by: Paolo Abeni <pabeni@redhat.com>
Closes: https://lore.kernel.org/netdev/24a7051fdcd1f156c3704bca39e4b3c41dfc7c4b.camel@redhat.com/
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Reviewed-by: Hangbin Liu <liuhangbin@gmail.com>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Link: https://lore.kernel.org/r/20240320065717.4145325-1-idosch@nvidia.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../testing/selftests/net/forwarding/vxlan_bridge_1d_ipv6.sh  | 4 ++--
 .../testing/selftests/net/forwarding/vxlan_bridge_1q_ipv6.sh  | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/net/forwarding/vxlan_bridge_1d_ipv6.sh b/tools/testing/selftests/net/forwarding/vxlan_bridge_1d_ipv6.sh
index ac97f07e5ce82..bd3f7d492af2b 100755
--- a/tools/testing/selftests/net/forwarding/vxlan_bridge_1d_ipv6.sh
+++ b/tools/testing/selftests/net/forwarding/vxlan_bridge_1d_ipv6.sh
@@ -354,7 +354,7 @@ __ping_ipv4()
 
 	# Send 100 packets and verify that at least 100 packets hit the rule,
 	# to overcome ARP noise.
-	PING_COUNT=100 PING_TIMEOUT=11 ping_do $dev $dst_ip
+	PING_COUNT=100 PING_TIMEOUT=20 ping_do $dev $dst_ip
 	check_err $? "Ping failed"
 
 	tc_check_at_least_x_packets "dev $rp1 egress" 101 10 100
@@ -410,7 +410,7 @@ __ping_ipv6()
 
 	# Send 100 packets and verify that at least 100 packets hit the rule,
 	# to overcome neighbor discovery noise.
-	PING_COUNT=100 PING_TIMEOUT=11 ping6_do $dev $dst_ip
+	PING_COUNT=100 PING_TIMEOUT=20 ping6_do $dev $dst_ip
 	check_err $? "Ping failed"
 
 	tc_check_at_least_x_packets "dev $rp1 egress" 101 100
diff --git a/tools/testing/selftests/net/forwarding/vxlan_bridge_1q_ipv6.sh b/tools/testing/selftests/net/forwarding/vxlan_bridge_1q_ipv6.sh
index d880df89bc8bd..e83fde79f40d0 100755
--- a/tools/testing/selftests/net/forwarding/vxlan_bridge_1q_ipv6.sh
+++ b/tools/testing/selftests/net/forwarding/vxlan_bridge_1q_ipv6.sh
@@ -457,7 +457,7 @@ __ping_ipv4()
 
 	# Send 100 packets and verify that at least 100 packets hit the rule,
 	# to overcome ARP noise.
-	PING_COUNT=100 PING_TIMEOUT=11 ping_do $dev $dst_ip
+	PING_COUNT=100 PING_TIMEOUT=20 ping_do $dev $dst_ip
 	check_err $? "Ping failed"
 
 	tc_check_at_least_x_packets "dev $rp1 egress" 101 10 100
@@ -522,7 +522,7 @@ __ping_ipv6()
 
 	# Send 100 packets and verify that at least 100 packets hit the rule,
 	# to overcome neighbor discovery noise.
-	PING_COUNT=100 PING_TIMEOUT=11 ping6_do $dev $dst_ip
+	PING_COUNT=100 PING_TIMEOUT=20 ping6_do $dev $dst_ip
 	check_err $? "Ping failed"
 
 	tc_check_at_least_x_packets "dev $rp1 egress" 101 100
-- 
2.43.0



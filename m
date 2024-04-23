Return-Path: <linux-kernel+bounces-155221-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B91058AE6FC
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 14:52:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE07E1C230E5
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 12:52:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BB5513B290;
	Tue, 23 Apr 2024 12:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="vJqK1J1X"
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B36CB135417;
	Tue, 23 Apr 2024 12:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713876571; cv=none; b=K4MhaspcUko80mbF9lwGwy7RiWuLrMSGKLIIRDAntbecrjYyrKeuopPLbagxrKchXlMI3WsltgImk04qO/Lzup86pvHfkixKO8WZPvURsCuodLrbpmZoD9uQUv2YUGwQrA5+oTpnuU3w6FQBqH9Nkq+xlD0FDyL+DUX6N+W0vKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713876571; c=relaxed/simple;
	bh=uTLp+ELFhdGrJpCMfmww9OK9ESHzrjUhNlIi99hsMw0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kMRXSZouYkrQK3mcmZ1IV8etGtdlRCfAeUyc809KmTrhq4EfPMEX9FMoi6GhhH5BU40Rhbwiggi/Xl14uX7OFPuayEi43Fu/ts2Kn2/cOjZj4JRMQL9bJE4IJa9cl9I/bbomRCTvx+qzTswEr+7mbCspLld9OsV8iLvZdX6KyH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=vJqK1J1X; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from localhost.localdomain (85-222-111-42.dynamic.chello.pl [85.222.111.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: lukma@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 714C48851D;
	Tue, 23 Apr 2024 14:49:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1713876567;
	bh=jhxcryAuFqbosk8HIXlOyLBsXBEZ6UHazg4UEaO9BxU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vJqK1J1Xh1VwdC06jg3okQcMTJofDvM5aDcHFFO7qpBv8vHQaYkrGp07H+nv4CbQa
	 CPU/Cwm9XuQR3EkRKSV0TXa4S0lExV54bBbmaqPCuAiDyXGofbbyNBeO6jhEai3xR6
	 yaNgotRrnhgwF+c00gr1hMkwGiEBe+Q9raz5ZIt9KLZCAbbW3ZjKWk8EDma/sWkG6E
	 hsDS8T3mgNbgR3Jk6Sb8SIVPRRQCyIsupQjAV/vqQjaf2RoX72sQ9yh5PTVMDP9G9n
	 e8yEYpbhpoKJe3Edw2vLf6xbWfDHTJnW3sqeWygzRIeYC8KeK8MNQKqPYVN5LlOXIB
	 YghhXeicI04mQ==
From: Lukasz Majewski <lukma@denx.de>
To: netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Casper Andersson <casper.casan@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Tristram.Ha@microchip.com,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Ravi Gunasekaran <r-gunasekaran@ti.com>,
	Simon Horman <horms@kernel.org>,
	Nikita Zhandarovich <n.zhandarovich@fintech.ru>,
	Murali Karicheri <m-karicheri2@ti.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Ziyang Xuan <william.xuanziyang@huawei.com>,
	Shigeru Yoshida <syoshida@redhat.com>,
	"Ricardo B. Marliere" <ricardo@marliere.net>,
	linux-kernel@vger.kernel.org,
	Lukasz Majewski <lukma@denx.de>
Subject: [net-next PATCH v6 5/5] test: hsr: Add test for HSR RedBOX (HSR-SAN) mode of operation
Date: Tue, 23 Apr 2024 14:49:08 +0200
Message-Id: <20240423124908.2073400-6-lukma@denx.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240423124908.2073400-1-lukma@denx.de>
References: <20240423124908.2073400-1-lukma@denx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

This patch adds hsr_redbox.sh script to test if HSR-SAN mode of operation
works correctly.

Signed-off-by: Lukasz Majewski <lukma@denx.de>
---
Changes for v6:
- add to Makefile's TEST_PROGS hsr_redbox.sh script
---
 tools/testing/selftests/net/hsr/Makefile      |  2 +-
 tools/testing/selftests/net/hsr/hsr_redbox.sh | 92 +++++++++++++++++++
 2 files changed, 93 insertions(+), 1 deletion(-)
 create mode 100755 tools/testing/selftests/net/hsr/hsr_redbox.sh

diff --git a/tools/testing/selftests/net/hsr/Makefile b/tools/testing/selftests/net/hsr/Makefile
index c782ad19e011..884cd2cc0681 100644
--- a/tools/testing/selftests/net/hsr/Makefile
+++ b/tools/testing/selftests/net/hsr/Makefile
@@ -2,7 +2,7 @@
 
 top_srcdir = ../../../../..
 
-TEST_PROGS := hsr_ping.sh
+TEST_PROGS := hsr_ping.sh hsr_redbox.sh
 TEST_FILES += hsr_common.sh
 
 include ../../lib.mk
diff --git a/tools/testing/selftests/net/hsr/hsr_redbox.sh b/tools/testing/selftests/net/hsr/hsr_redbox.sh
new file mode 100755
index 000000000000..52e0412c32e6
--- /dev/null
+++ b/tools/testing/selftests/net/hsr/hsr_redbox.sh
@@ -0,0 +1,92 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+ipv6=false
+
+source ./hsr_common.sh
+
+do_complete_ping_test()
+{
+	echo "INFO: Initial validation ping (HSR-SAN/RedBox)."
+	# Each node has to be able each one.
+	do_ping "${ns1}" 100.64.0.2
+	do_ping "${ns2}" 100.64.0.1
+	# Ping from SAN to hsr1 (via hsr2)
+	do_ping "${ns3}" 100.64.0.1
+	do_ping "${ns1}" 100.64.0.3
+	stop_if_error "Initial validation failed."
+
+	# Wait for MGNT HSR frames being received and nodes being
+	# merged.
+	sleep 5
+
+	echo "INFO: Longer ping test (HSR-SAN/RedBox)."
+	# Ping from SAN to hsr1 (via hsr2)
+	do_ping_long "${ns3}" 100.64.0.1
+	# Ping from hsr1 (via hsr2) to SAN
+	do_ping_long "${ns1}" 100.64.0.3
+	stop_if_error "Longer ping test failed."
+
+	echo "INFO: All good."
+}
+
+setup_hsr_interfaces()
+{
+	local HSRv="$1"
+
+	echo "INFO: preparing interfaces for HSRv${HSRv} (HSR-SAN/RedBox)."
+
+#       |NS1                     |
+#       |                        |
+#       |    /-- hsr1 --\        |
+#       | ns1eth1     ns1eth2    |
+#       |------------------------|
+#            |            |
+#            |            |
+#            |            |
+#       |------------------------|        |-----------|
+#       | ns2eth1     ns2eth2    |        |           |
+#       |    \-- hsr2 --/        |        |           |
+#       |            \           |        |           |
+#       |             ns2eth3    |--------| ns3eth1   |
+#       |             (interlink)|        |           |
+#       |NS2 (RedBOX)            |        |NS3 (SAN)  |
+#
+	# Check if iproute2 supports adding interlink port to hsrX device
+	ip link help hsr | grep -q INTERLINK
+	[ $? -ne 0 ] && { echo "iproute2: HSR interlink interface not supported!"; exit 0; }
+
+	# Create interfaces for name spaces
+	ip link add ns1eth1 netns "${ns1}" type veth peer name ns2eth1 netns "${ns2}"
+	ip link add ns1eth2 netns "${ns1}" type veth peer name ns2eth2 netns "${ns2}"
+	ip link add ns3eth1 netns "${ns3}" type veth peer name ns2eth3 netns "${ns2}"
+
+	sleep 1
+
+	ip -n "${ns1}" link set ns1eth1 up
+	ip -n "${ns1}" link set ns1eth2 up
+
+	ip -n "${ns2}" link set ns2eth1 up
+	ip -n "${ns2}" link set ns2eth2 up
+	ip -n "${ns2}" link set ns2eth3 up
+
+	ip -n "${ns3}" link set ns3eth1 up
+
+	ip -net "${ns1}" link add name hsr1 type hsr slave1 ns1eth1 slave2 ns1eth2 supervision 45 version ${HSRv} proto 0
+	ip -net "${ns2}" link add name hsr2 type hsr slave1 ns2eth1 slave2 ns2eth2 interlink ns2eth3 supervision 45 version ${HSRv} proto 0
+
+	ip -n "${ns1}" addr add 100.64.0.1/24 dev hsr1
+	ip -n "${ns2}" addr add 100.64.0.2/24 dev hsr2
+	ip -n "${ns3}" addr add 100.64.0.3/24 dev ns3eth1
+
+	ip -n "${ns1}" link set hsr1 up
+	ip -n "${ns2}" link set hsr2 up
+}
+
+check_prerequisites
+setup_ns ns1 ns2 ns3
+
+setup_hsr_interfaces 1
+do_complete_ping_test
+
+exit $ret
-- 
2.20.1



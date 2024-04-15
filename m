Return-Path: <linux-kernel+bounces-145135-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0F468A4FFF
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 14:58:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2AD61C206AA
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 12:58:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11F8812880A;
	Mon, 15 Apr 2024 12:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="XxfPMjSi"
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65AC6745FD;
	Mon, 15 Apr 2024 12:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713185415; cv=none; b=l3DDMLgZB+B8UlfTQEsGtJyAuPPrvbaUgPM0Bdxp/wXSTuRimRnY3uVSTuJemjDJtMLhfBJdAa2y39TkLjvsKmSFeB6zhmqw9wDTfMpUrizKqJkIEwgQk8E6/CzLF94LFa1qV5qMd0eMEpVdcVfcx3b7aGF1KxeIFbmZsaF+zL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713185415; c=relaxed/simple;
	bh=Hdykt2B4i1lx8yLnP0uavaOKrQI+GIykrNOpYC+S9nU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fFKulF1FnfHFNgHrthXaHHePMkQ4qqwwsA8SntuthWBRs7gakaLgPNOcf3bU5GEz1IC9i5iqULqmYlUSHD/9cvsDKmE51GDMblv4fEIthsOHNr4kM7zWQ5I8dBNbd1Pltb8e/d8z3DSi2WH50HIRfo79d38WyGWQQ/es+LkEs8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=XxfPMjSi; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from localhost.localdomain (85-222-111-42.dynamic.chello.pl [85.222.111.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: lukma@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 852A8881FB;
	Mon, 15 Apr 2024 14:50:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1713185406;
	bh=0ZiAkni61pGt7UsZmTgp8Dq1oPO+rvrlLp0DKseZgaw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XxfPMjSi3ybaxKd7cTcMRIHDg0ud7LbbJZGhVE7GlxFprQ85vzRX8QWWCJG/qsoz/
	 SW8GFWdYaLCIMVZ7UIpSLEyYoXfkipEVOCEiFsSs4b8lIoZ1ddHwZgb3NoZsy9qQuG
	 9/yybX3hqhTJB9VAcZZR3EW97rkvwdzBPpHvLsjyATwHjf7sQ80waxnEc5D8dWIno0
	 tyXeMyMjLnSA6hdHF3UTjZDwZ4EZnIeYYOyPArXxClGfIk811LSfpIdhKm3wFh6Foj
	 ujqpevYTCFM1C6wAzlpoZNAWvGBKuvjOnwWGN1rnaj4a65A7gkeguWR016zegBedgy
	 uNKo0e32ygNEg==
From: Lukasz Majewski <lukma@denx.de>
To: netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
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
Subject: [net-next PATCH v5 4/4] test: hsr: Add test for HSR RedBOX (HSR-SAN) mode of operation
Date: Mon, 15 Apr 2024 14:49:28 +0200
Message-Id: <20240415124928.1263240-5-lukma@denx.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240415124928.1263240-1-lukma@denx.de>
References: <20240415124928.1263240-1-lukma@denx.de>
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
 tools/testing/selftests/net/hsr/hsr_redbox.sh | 97 +++++++++++++++++++
 1 file changed, 97 insertions(+)
 create mode 100755 tools/testing/selftests/net/hsr/hsr_redbox.sh

diff --git a/tools/testing/selftests/net/hsr/hsr_redbox.sh b/tools/testing/selftests/net/hsr/hsr_redbox.sh
new file mode 100755
index 000000000000..6946a0c6eb17
--- /dev/null
+++ b/tools/testing/selftests/net/hsr/hsr_redbox.sh
@@ -0,0 +1,97 @@
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
+trap cleanup EXIT SIGKILL SIGTERM
+
+for i in "$ns1" "$ns2" "$ns3" ;do
+	ip netns add $i || exit $ksft_skip
+	ip -net $i link set lo up
+done
+
+setup_hsr_interfaces 1
+do_complete_ping_test
+
+exit $ret
-- 
2.20.1



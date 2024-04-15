Return-Path: <linux-kernel+bounces-145132-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A06898A4FF8
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 14:58:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 109B11F21E25
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 12:58:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C694127E22;
	Mon, 15 Apr 2024 12:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="YQgc1XAE"
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52E79126F03;
	Mon, 15 Apr 2024 12:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713185414; cv=none; b=YDLDmbZgZLsVN2+2DSwIkGLqV60wTGh+pz38lc6MLk+CCH+xYEEdzwRh8G+LYS5MQqJx1Soevu+7BdFCMJo+6EMJmMZiLWgFikdKYChQEIYKog14wWdupbsstIk1PItvBnOuy2oa+gPdoQQdFNdgddfCeXVZFgTNSPToVyheU38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713185414; c=relaxed/simple;
	bh=/2VHN6Fpx9YFbPIk82zaXoeshzNI9r9yb9C+nlQyp04=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=T7hpnpqtqlbYnDF/0C8KDg5HrNGcYSX3yj5lBdSmDjA3+0Xpjhy3BNK/hfMXZcfK25+PtzSgAgvz6YUOhHlcB9Ojh6a6R91OClejdNdpSbuUEPkO4KXY76TnyA9zkLqXxZckKwZhpHJM7FWJAxxa7jFKndxzVlqZ57o3Lf5CPXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=YQgc1XAE; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from localhost.localdomain (85-222-111-42.dynamic.chello.pl [85.222.111.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: lukma@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 32F3B88151;
	Mon, 15 Apr 2024 14:50:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1713185404;
	bh=VNBmv56aCUIZ6QJaObTK3qMpfGN3t8BH2BrLFEwBkhE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YQgc1XAE11wORCxsRU2bINaUYyko2awiBZfaDJkWAvL5x2UvPpKUKYwRHiTauTvBV
	 2FDTn59+ryL5vUgp4iUrMbLxviTu0qdj52JULASTUC3m1sr7UnRyonsobC7C5AbUIa
	 ZyTiESAgoESoiEGFNobNYtOee75tya9J3BSa7ZzrL3hqrSudkwo2kXqPBHu2tPw4I4
	 kyLJi6GWRRnwh+jbEZSJGwa76MmgrSvyE7BKFHNb0+jyhAtgs9vJxtp2+duKFB6YVC
	 9OQaAjVycYlE4G/CXe7Ke02I8wB3F/6YV3yE5Diq5nrHm3zbLhcFuAchS5TOTPRb61
	 SWDKuRHHTioKQ==
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
Subject: [net-next PATCH v5 2/4] test: hsr: Move common code to hsr_common.sh file
Date: Mon, 15 Apr 2024 14:49:26 +0200
Message-Id: <20240415124928.1263240-3-lukma@denx.de>
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

Some of the code already present in the hsr_ping.sh test program can be
moved to a separate script file, so it can be reused by other HSR
functionality (like HSR-SAN) tests.

Signed-off-by: Lukasz Majewski <lukma@denx.de>
---
 tools/testing/selftests/net/hsr/hsr_common.sh | 96 +++++++++++++++++++
 tools/testing/selftests/net/hsr/hsr_ping.sh   | 93 +-----------------
 2 files changed, 99 insertions(+), 90 deletions(-)
 create mode 100644 tools/testing/selftests/net/hsr/hsr_common.sh

diff --git a/tools/testing/selftests/net/hsr/hsr_common.sh b/tools/testing/selftests/net/hsr/hsr_common.sh
new file mode 100644
index 000000000000..822165391573
--- /dev/null
+++ b/tools/testing/selftests/net/hsr/hsr_common.sh
@@ -0,0 +1,96 @@
+# SPDX-License-Identifier: GPL-2.0
+# Common code for HSR testing scripts
+
+ret=0
+ksft_skip=4
+
+sec=$(date +%s)
+rndh=$(printf %x $sec)-$(mktemp -u XXXXXX)
+ns1="ns1-$rndh"
+ns2="ns2-$rndh"
+ns3="ns3-$rndh"
+
+cleanup()
+{
+	local netns
+	for netns in "$ns1" "$ns2" "$ns3" ;do
+		ip netns del $netns
+	done
+}
+
+# $1: IP address
+is_v6()
+{
+	[ -z "${1##*:*}" ]
+}
+
+do_ping()
+{
+	local netns="$1"
+	local connect_addr="$2"
+	local ping_args="-q -c 2"
+
+	if is_v6 "${connect_addr}"; then
+		$ipv6 || return 0
+		ping_args="${ping_args} -6"
+	fi
+
+	ip netns exec ${netns} ping ${ping_args} $connect_addr >/dev/null
+	if [ $? -ne 0 ] ; then
+		echo "$netns -> $connect_addr connectivity [ FAIL ]" 1>&2
+		ret=1
+		return 1
+	fi
+
+	return 0
+}
+
+do_ping_long()
+{
+	local netns="$1"
+	local connect_addr="$2"
+	local ping_args="-q -c 10"
+
+	if is_v6 "${connect_addr}"; then
+		$ipv6 || return 0
+		ping_args="${ping_args} -6"
+	fi
+
+	OUT="$(LANG=C ip netns exec ${netns} ping ${ping_args} $connect_addr | grep received)"
+	if [ $? -ne 0 ] ; then
+		echo "$netns -> $connect_addr ping [ FAIL ]" 1>&2
+		ret=1
+		return 1
+	fi
+
+	VAL="$(echo $OUT | cut -d' ' -f1-8)"
+	if [ "$VAL" != "10 packets transmitted, 10 received, 0% packet loss," ]
+	then
+		echo "$netns -> $connect_addr ping TEST [ FAIL ]"
+		echo "Expect to send and receive 10 packets and no duplicates."
+		echo "Full message: ${OUT}."
+		ret=1
+		return 1
+	fi
+
+	return 0
+}
+
+stop_if_error()
+{
+	local msg="$1"
+
+	if [ ${ret} -ne 0 ]; then
+		echo "FAIL: ${msg}" 1>&2
+		exit ${ret}
+	fi
+}
+
+check_prerequisites()
+{
+	ip -Version > /dev/null 2>&1
+	if [ $? -ne 0 ];then
+		echo "SKIP: Could not run test without ip tool"
+		exit $ksft_skip
+	fi
+}
diff --git a/tools/testing/selftests/net/hsr/hsr_ping.sh b/tools/testing/selftests/net/hsr/hsr_ping.sh
index 1c6457e54625..6fab532793a0 100755
--- a/tools/testing/selftests/net/hsr/hsr_ping.sh
+++ b/tools/testing/selftests/net/hsr/hsr_ping.sh
@@ -1,10 +1,10 @@
 #!/bin/bash
 # SPDX-License-Identifier: GPL-2.0
 
-ret=0
-ksft_skip=4
 ipv6=true
 
+source ./hsr_common.sh
+
 optstring="h4"
 usage() {
 	echo "Usage: $0 [OPTION]"
@@ -27,88 +27,6 @@ while getopts "$optstring" option;do
 esac
 done
 
-sec=$(date +%s)
-rndh=$(printf %x $sec)-$(mktemp -u XXXXXX)
-ns1="ns1-$rndh"
-ns2="ns2-$rndh"
-ns3="ns3-$rndh"
-
-cleanup()
-{
-	local netns
-	for netns in "$ns1" "$ns2" "$ns3" ;do
-		ip netns del $netns
-	done
-}
-
-# $1: IP address
-is_v6()
-{
-	[ -z "${1##*:*}" ]
-}
-
-do_ping()
-{
-	local netns="$1"
-	local connect_addr="$2"
-	local ping_args="-q -c 2"
-
-	if is_v6 "${connect_addr}"; then
-		$ipv6 || return 0
-		ping_args="${ping_args} -6"
-	fi
-
-	ip netns exec ${netns} ping ${ping_args} $connect_addr >/dev/null
-	if [ $? -ne 0 ] ; then
-		echo "$netns -> $connect_addr connectivity [ FAIL ]" 1>&2
-		ret=1
-		return 1
-	fi
-
-	return 0
-}
-
-do_ping_long()
-{
-	local netns="$1"
-	local connect_addr="$2"
-	local ping_args="-q -c 10"
-
-	if is_v6 "${connect_addr}"; then
-		$ipv6 || return 0
-		ping_args="${ping_args} -6"
-	fi
-
-	OUT="$(LANG=C ip netns exec ${netns} ping ${ping_args} $connect_addr | grep received)"
-	if [ $? -ne 0 ] ; then
-		echo "$netns -> $connect_addr ping [ FAIL ]" 1>&2
-		ret=1
-		return 1
-	fi
-
-	VAL="$(echo $OUT | cut -d' ' -f1-8)"
-	if [ "$VAL" != "10 packets transmitted, 10 received, 0% packet loss," ]
-	then
-		echo "$netns -> $connect_addr ping TEST [ FAIL ]"
-		echo "Expect to send and receive 10 packets and no duplicates."
-		echo "Full message: ${OUT}."
-		ret=1
-		return 1
-	fi
-
-	return 0
-}
-
-stop_if_error()
-{
-	local msg="$1"
-
-	if [ ${ret} -ne 0 ]; then
-		echo "FAIL: ${msg}" 1>&2
-		exit ${ret}
-	fi
-}
-
 do_complete_ping_test()
 {
 	echo "INFO: Initial validation ping."
@@ -248,12 +166,7 @@ setup_hsr_interfaces()
 	ip -net "$ns3" link set hsr3 up
 }
 
-ip -Version > /dev/null 2>&1
-if [ $? -ne 0 ];then
-	echo "SKIP: Could not run test without ip tool"
-	exit $ksft_skip
-fi
-
+check_prerequisites
 trap cleanup EXIT
 
 for i in "$ns1" "$ns2" "$ns3" ;do
-- 
2.20.1



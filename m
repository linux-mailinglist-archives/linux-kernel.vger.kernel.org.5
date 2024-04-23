Return-Path: <linux-kernel+bounces-155219-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21B098AE6F6
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 14:51:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45C501C22DAB
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 12:51:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1825513775B;
	Tue, 23 Apr 2024 12:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="qZUi1j3k"
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D9BD129E95;
	Tue, 23 Apr 2024 12:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713876569; cv=none; b=kE4p8sCecS1jpr260KUwcLx+PhnQkU79tkrtuh9uXVUf4jCmgQrLJ1psM1NQ35pGd0txC8YC/6gRf1Mk5RjFSkHvf5noS/IRFcmZyFYT46RQH4m7ajggffl9KDtGhZZpgHjz3h1KTWCPM/ozN7jl/Lq5Te3g1h2g3ta1m5OSEyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713876569; c=relaxed/simple;
	bh=l+EukYChqq3qBiwbnn/UAYYX26vJ61gYpOLFJtik6bY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jGY1Eg1pCgppVtYLEWNta39EgPLoTHq9zI+pI8e1faxFcVS1HYN+w9GTR4ykVFIRqRZV5sAI0XcEM6hTXqFAySZrbmpFOkO4ogLFv1uNShbJN/UDOFvY+53z96jvO+D1WObqxVO66A0k8ZT70M0Boj9OfY3UycbzEIohgLglIPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=qZUi1j3k; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from localhost.localdomain (85-222-111-42.dynamic.chello.pl [85.222.111.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: lukma@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 100C1885A2;
	Tue, 23 Apr 2024 14:49:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1713876565;
	bh=h6JvA4qYo+9oassIObUcS54wmHUdhNA+WMQkhrfxRto=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qZUi1j3kLXUtYII9cb6AcHh+Ekltqz63a1ArnrIoXpzkqBw6U/RF3j3+N0aPCYClQ
	 26yRoS8XRmNrdpXOH0/IdKws8anDa69g3kOVqStWIEzhjrwdyJHTY89iYV73+qUOZn
	 oG4a7oNKkzmP17T6dUvvScoWb/Pqu0kjr6cJsXNHYU4qshhN/lU5VT6U6cE5YQaxMt
	 Z2+1hHRfKqyCatRfQGskRUj3vLEGl7nBg9MYREtSUkRhw3vsJJepPXuw+cZH90wMiB
	 Z5LT5jgnqExfEM6P6zNeKMVxwgFjo1uyCSTT8Yd3Ws4e9C/TKiMkTwxmqMJH6dCiwt
	 KuBgkvrQeSS9g==
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
Subject: [net-next PATCH v6 3/5] test: hsr: Move common code to hsr_common.sh file
Date: Tue, 23 Apr 2024 14:49:06 +0200
Message-Id: <20240423124908.2073400-4-lukma@denx.de>
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

Some of the code already present in the hsr_ping.sh test program can be
moved to a separate script file, so it can be reused by other HSR
functionality (like HSR-SAN) tests.

Signed-off-by: Lukasz Majewski <lukma@denx.de>

---
Changes for v6:
- Use common code from ../lib.sh

- Add hsr_common.sh to TEST_FILES variable
---
 tools/testing/selftests/net/hsr/Makefile      |  1 +
 tools/testing/selftests/net/hsr/hsr_common.sh | 83 +++++++++++++++++++
 tools/testing/selftests/net/hsr/hsr_ping.sh   | 82 +-----------------
 3 files changed, 88 insertions(+), 78 deletions(-)
 create mode 100644 tools/testing/selftests/net/hsr/hsr_common.sh

diff --git a/tools/testing/selftests/net/hsr/Makefile b/tools/testing/selftests/net/hsr/Makefile
index 92c1d9d080cd..c782ad19e011 100644
--- a/tools/testing/selftests/net/hsr/Makefile
+++ b/tools/testing/selftests/net/hsr/Makefile
@@ -3,5 +3,6 @@
 top_srcdir = ../../../../..
 
 TEST_PROGS := hsr_ping.sh
+TEST_FILES += hsr_common.sh
 
 include ../../lib.mk
diff --git a/tools/testing/selftests/net/hsr/hsr_common.sh b/tools/testing/selftests/net/hsr/hsr_common.sh
new file mode 100644
index 000000000000..be4ad07ff355
--- /dev/null
+++ b/tools/testing/selftests/net/hsr/hsr_common.sh
@@ -0,0 +1,83 @@
+# SPDX-License-Identifier: GPL-2.0
+# Common code for HSR testing scripts
+
+source ../lib.sh
+ret=0
+ksft_skip=4
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
index bd7c4b8f07b8..790294c8af83 100755
--- a/tools/testing/selftests/net/hsr/hsr_ping.sh
+++ b/tools/testing/selftests/net/hsr/hsr_ping.sh
@@ -1,11 +1,10 @@
 #!/bin/bash
 # SPDX-License-Identifier: GPL-2.0
 
-source ../lib.sh
-ret=0
-ksft_skip=4
 ipv6=true
 
+source ./hsr_common.sh
+
 optstring="h4"
 usage() {
 	echo "Usage: $0 [OPTION]"
@@ -28,76 +27,6 @@ while getopts "$optstring" option;do
 esac
 done
 
-setup_ns ns1 ns2 ns3
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
@@ -237,11 +166,8 @@ setup_hsr_interfaces()
 	ip -net "$ns3" link set hsr3 up
 }
 
-ip -Version > /dev/null 2>&1
-if [ $? -ne 0 ];then
-	echo "SKIP: Could not run test without ip tool"
-	exit $ksft_skip
-fi
+check_prerequisites
+setup_ns ns1 ns2 ns3
 
 trap cleanup_all_ns EXIT
 
-- 
2.20.1



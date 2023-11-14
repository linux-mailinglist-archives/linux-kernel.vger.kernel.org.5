Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00CE37EB324
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 16:11:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232340AbjKNPLl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 10:11:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjKNPLj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 10:11:39 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6B7BE3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 07:11:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699974695;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=m/doj/T8nqtKHRc2PP5ZmgpfbSgB0XHlZpghgNdMkI4=;
        b=V6/jzaqeGA0KVZTTy+OiBNzPOO7lRV1qFqMf+K7/mcIgJU8THMtIrJdBNvB1XbPw9yH3B+
        Dx1q/Cgkg7RrR5i1O5+S1vDKvyjA/MQ36y/Tpl7ft+TJdLZK/MaplikanOc5UdN5Lv+J4X
        kMcNNtiuW0+iekVULs/VWDl1jdRqf7o=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-247-xyUMiUYkNWSqUArVx0MXBg-1; Tue, 14 Nov 2023 10:11:33 -0500
X-MC-Unique: xyUMiUYkNWSqUArVx0MXBg-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-66d4aa946ceso98350636d6.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 07:11:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699974693; x=1700579493;
        h=user-agent:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m/doj/T8nqtKHRc2PP5ZmgpfbSgB0XHlZpghgNdMkI4=;
        b=SeEZexdrGuWyIhcO27qmU8Csz9hKmlUweEUj1ov5400m+V0EUltDvS450ZxJrZ/OtE
         nG64mY2n2vnxh2taS4Q/fhvE5g8n8NIj2ECVctgqTFIsVh9tUwnBlhsYyhoXIfgAZTXd
         SJJer0evRWkHYEKJw5ZGL4qZoPriia6kwsZvkfT5mjRZTzyktxDw/QAjhpp7XS4nxzo6
         TELuOaAD5/J3nWVVdsmTW8aj1yZ/jPYQ2SR3XrQHBrAozeKH/FqTup9SLI8bWX4pYxcm
         FpYFUz3SUDF80GGsLumyo9nwDIqO8CKqZ1euBsjpo4jr0TJ/KNeYeuuRKUrbU1PaKF+k
         b98w==
X-Gm-Message-State: AOJu0YwzbSVmbvkNAU0Wp83i5LA7/WVRqbJMEQaiHf8mnPf0bapE/a/5
        YbwfCsKWVDQ5AC82E0IKD9npzNPe431JHYDF3Ie9ENFedlP5RktqTq2gmjng+SunkV02zDkLCtM
        +3rDUaYxWDUVzhmkggCWXwm35
X-Received: by 2002:a05:6214:a6b:b0:671:560f:3306 with SMTP id ef11-20020a0562140a6b00b00671560f3306mr4222477qvb.4.1699974693059;
        Tue, 14 Nov 2023 07:11:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IETr8rC65ge7cAq25brn2IswFpgUjOqN5yHvyuJsXuhW2wFWXuNITxZngmj3KoUixz/DqtrQw==
X-Received: by 2002:a05:6214:a6b:b0:671:560f:3306 with SMTP id ef11-20020a0562140a6b00b00671560f3306mr4222433qvb.4.1699974692710;
        Tue, 14 Nov 2023 07:11:32 -0800 (PST)
Received: from fedora ([142.181.225.135])
        by smtp.gmail.com with ESMTPSA id u12-20020a0cea4c000000b00655d711180dsm2988835qvp.17.2023.11.14.07.11.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Nov 2023 07:11:32 -0800 (PST)
Date:   Tue, 14 Nov 2023 10:11:31 -0500
From:   Lucas Karpinski <lkarpins@redhat.com>
To:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: [PATCH net-next v3] selftests/net: synchronize udpgro tests' tx and
 rx connection
Message-ID: <jvzrm33xjrhal3qro37tfpfw2w4jbh35byjlogcc776xt4fpzy@zkmfoqn5ipil>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20231023
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The sockets used by udpgso_bench_tx aren't always ready when
udpgso_bench_tx transmits packets. This issue is more prevalent in -rt
kernels, but can occur in both. Replace the hacky sleep calls with a
function that checks whether the ports in the namespace are ready for
use.

Suggested-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Lucas Karpinski <lkarpins@redhat.com>
---
https://lore.kernel.org/all/6ceki76bcv7qz6de5rxc26ot6aezdmeoz2g4ubtve7qwozmyyw@zibbg64wsdjp/
v3:
- moved redundant code to net_helper.sh
- replaced awk with grep
- changed commit message to specify udpgro
- added target tree

v2:
- applied synchronization method suggested by Paolo
- changed commit message to code

tools/testing/selftests/net/net_helper.sh     | 22 +++++++++++++++++++
 tools/testing/selftests/net/udpgro.sh         | 13 +++++------
 tools/testing/selftests/net/udpgro_bench.sh   |  5 +++--
 tools/testing/selftests/net/udpgro_frglist.sh |  5 +++--
 4 files changed, 34 insertions(+), 11 deletions(-)
 create mode 100755 tools/testing/selftests/net/net_helper.sh

diff --git a/tools/testing/selftests/net/net_helper.sh b/tools/testing/selftests/net/net_helper.sh
new file mode 100755
index 000000000000..4fe0befa13fb
--- /dev/null
+++ b/tools/testing/selftests/net/net_helper.sh
@@ -0,0 +1,22 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# Helper functions
+
+wait_local_port_listen()
+{
+	local listener_ns="${1}"
+	local port="${2}"
+	local protocol="${3}"
+	local port_hex
+	local i
+
+	port_hex="$(printf "%04X" "${port}")"
+	for i in $(seq 10); do
+		if ip netns exec "${listener_ns}" cat /proc/net/"${protocol}"* | \
+		   grep -q "${port_hex}"; then
+			break
+		fi
+		sleep 0.1
+	done
+}
diff --git a/tools/testing/selftests/net/udpgro.sh b/tools/testing/selftests/net/udpgro.sh
index 0c743752669a..af5dc57c8ce9 100755
--- a/tools/testing/selftests/net/udpgro.sh
+++ b/tools/testing/selftests/net/udpgro.sh
@@ -3,6 +3,8 @@
 #
 # Run a series of udpgro functional tests.
 
+source net_helper.sh
+
 readonly PEER_NS="ns-peer-$(mktemp -u XXXXXX)"
 
 BPF_FILE="../bpf/xdp_dummy.bpf.o"
@@ -51,8 +53,7 @@ run_one() {
 		echo "ok" || \
 		echo "failed" &
 
-	# Hack: let bg programs complete the startup
-	sleep 0.2
+	wait_local_port_listen ${PEER_NS} 8000 udp
 	./udpgso_bench_tx ${tx_args}
 	ret=$?
 	wait $(jobs -p)
@@ -97,7 +98,7 @@ run_one_nat() {
 		echo "ok" || \
 		echo "failed"&
 
-	sleep 0.1
+	wait_local_port_listen "${PEER_NS}" 8000 udp
 	./udpgso_bench_tx ${tx_args}
 	ret=$?
 	kill -INT $pid
@@ -118,11 +119,9 @@ run_one_2sock() {
 		echo "ok" || \
 		echo "failed" &
 
-	# Hack: let bg programs complete the startup
-	sleep 0.2
+	wait_local_port_listen "${PEER_NS}" 12345 udp
 	./udpgso_bench_tx ${tx_args} -p 12345
-	sleep 0.1
-	# first UDP GSO socket should be closed at this point
+	wait_local_port_listen "${PEER_NS}" 8000 udp
 	./udpgso_bench_tx ${tx_args}
 	ret=$?
 	wait $(jobs -p)
diff --git a/tools/testing/selftests/net/udpgro_bench.sh b/tools/testing/selftests/net/udpgro_bench.sh
index 894972877e8b..cb664679b434 100755
--- a/tools/testing/selftests/net/udpgro_bench.sh
+++ b/tools/testing/selftests/net/udpgro_bench.sh
@@ -3,6 +3,8 @@
 #
 # Run a series of udpgro benchmarks
 
+source net_helper.sh
+
 readonly PEER_NS="ns-peer-$(mktemp -u XXXXXX)"
 
 BPF_FILE="../bpf/xdp_dummy.bpf.o"
@@ -40,8 +42,7 @@ run_one() {
 	ip netns exec "${PEER_NS}" ./udpgso_bench_rx ${rx_args} -r &
 	ip netns exec "${PEER_NS}" ./udpgso_bench_rx -t ${rx_args} -r &
 
-	# Hack: let bg programs complete the startup
-	sleep 0.2
+	wait_local_port_listen "${PEER_NS}" 8000 udp
 	./udpgso_bench_tx ${tx_args}
 }
 
diff --git a/tools/testing/selftests/net/udpgro_frglist.sh b/tools/testing/selftests/net/udpgro_frglist.sh
index 0a6359bed0b9..dd47fa96f6b3 100755
--- a/tools/testing/selftests/net/udpgro_frglist.sh
+++ b/tools/testing/selftests/net/udpgro_frglist.sh
@@ -3,6 +3,8 @@
 #
 # Run a series of udpgro benchmarks
 
+source net_helper.sh
+
 readonly PEER_NS="ns-peer-$(mktemp -u XXXXXX)"
 
 BPF_FILE="../bpf/xdp_dummy.bpf.o"
@@ -45,8 +47,7 @@ run_one() {
         echo ${rx_args}
 	ip netns exec "${PEER_NS}" ./udpgso_bench_rx ${rx_args} -r &
 
-	# Hack: let bg programs complete the startup
-	sleep 0.2
+	wait_local_port_listen "${PEER_NS}" 8000 udp
 	./udpgso_bench_tx ${tx_args}
 }
 
-- 
2.41.0


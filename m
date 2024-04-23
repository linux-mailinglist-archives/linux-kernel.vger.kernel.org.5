Return-Path: <linux-kernel+bounces-155217-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFC128AE6F3
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 14:51:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABA64287C3D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 12:51:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D71F7134CCA;
	Tue, 23 Apr 2024 12:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="RosOYJi7"
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9016A13280E;
	Tue, 23 Apr 2024 12:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713876568; cv=none; b=lxbAQiLqlAgeHawm11xWAkZuslI3wZtREOA7Vxey+2IuNEXKos9NC2dwofQraU1eYn06E2xM6SIgT7xG1wa6nkyELK3G8D7lLFv2Ud5eDOnxQvhT4ZO++xwa5Yh2o027dRJVUGBLY3yNw8jvTdXyT5zosRoJ0iAFxFZjoPwyKgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713876568; c=relaxed/simple;
	bh=ENEQWjd/orFKbPCnRA9/wp03isKnfgGXn50Q9kBx/4U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PqP82DmtRbV2LfRmrhGQCht0WUgDm7oO8KMLIlmRQVjYijrM2jJevXYzfPC4Nan24J9cb33TQV3jQov47XQPbymlkI3SGS2fRHMHgGL6C9qvddQ/c+91s3w2iFD8k/GLP28UZKxwftjP3qrZNWpPzBHGHn/QX14Iz2QTKknZP/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=RosOYJi7; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from localhost.localdomain (85-222-111-42.dynamic.chello.pl [85.222.111.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: lukma@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 5F7BA88599;
	Tue, 23 Apr 2024 14:49:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1713876564;
	bh=IiL05VoBy7iASraWS1ixTUxUFwRXhuZA90r6BgcT/kg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RosOYJi7Xh7QYxrSYxVRaMxlMl1g5I2pa1CGd3o7KvgVt4+dsWdCi4v0UgEEcA2Gm
	 AzmPTexUihPUTnZRILSDCA6ihpeA5E7GoDpOWEDZ9inq2+bMT743FLHMGrtrLrof21
	 aC+WwQlqjxC3Sy8uKkaLnlQYgJ2uuzDp8kpalOGCq04wktHT/uV5xZKMWYTqZFF9HR
	 t+R63CyIThWH2d7TJ+pXqYvrSZRpnUJzLUld/A0i+SxRkLNgXt0X1ns4bPk59gQ2w4
	 0SQcTkrRMSC1vpl0Whw1gr6TBqWf+SnLLCpJufgdxiiMZ7VckG6ihdwk5vkWGyobev
	 jEJBEPOvXAOcw==
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
Subject: [net-next PATCH v6 2/5] test: hsr: Remove script code already implemented in lib.sh
Date: Tue, 23 Apr 2024 14:49:05 +0200
Message-Id: <20240423124908.2073400-3-lukma@denx.de>
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

Some parts (like netns creation and cleanup) of hsr_ping.sh script are
already implemented in ../lib.sh common script, so can be replaced by it.

Signed-off-by: Lukasz Majewski <lukma@denx.de>

---
Changes for v6:
- New patch
---
 tools/testing/selftests/net/hsr/hsr_ping.sh | 28 +++------------------
 1 file changed, 3 insertions(+), 25 deletions(-)

diff --git a/tools/testing/selftests/net/hsr/hsr_ping.sh b/tools/testing/selftests/net/hsr/hsr_ping.sh
index 1c6457e54625..bd7c4b8f07b8 100755
--- a/tools/testing/selftests/net/hsr/hsr_ping.sh
+++ b/tools/testing/selftests/net/hsr/hsr_ping.sh
@@ -1,6 +1,7 @@
 #!/bin/bash
 # SPDX-License-Identifier: GPL-2.0
 
+source ../lib.sh
 ret=0
 ksft_skip=4
 ipv6=true
@@ -27,19 +28,7 @@ while getopts "$optstring" option;do
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
+setup_ns ns1 ns2 ns3
 
 # $1: IP address
 is_v6()
@@ -254,21 +243,10 @@ if [ $? -ne 0 ];then
 	exit $ksft_skip
 fi
 
-trap cleanup EXIT
-
-for i in "$ns1" "$ns2" "$ns3" ;do
-	ip netns add $i || exit $ksft_skip
-	ip -net $i link set lo up
-done
+trap cleanup_all_ns EXIT
 
 setup_hsr_interfaces 0
 do_complete_ping_test
-cleanup
-
-for i in "$ns1" "$ns2" "$ns3" ;do
-	ip netns add $i || exit $ksft_skip
-	ip -net $i link set lo up
-done
 
 setup_hsr_interfaces 1
 do_complete_ping_test
-- 
2.20.1



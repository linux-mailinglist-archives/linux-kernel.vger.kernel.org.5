Return-Path: <linux-kernel+bounces-155220-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 053C58AE6F8
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 14:51:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3795C1C23005
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 12:51:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 337F8135A65;
	Tue, 23 Apr 2024 12:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="tVkokZzG"
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0734912DDBE;
	Tue, 23 Apr 2024 12:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713876569; cv=none; b=ZdsfJ3hyLZOzKP7Ft04Jdi/Wcx5OFIvZsFuPzXMn+2XEvRyBrJgLNkg8Wgtc8X+Ssk78+NP9QHvRMXfMwlV9AymoKQYINtLW1lmteQ3zBKKUZLyok5klzVk7gF6d8RQn9t0zPUHoPmSBVzns1PFAgxuAnQLkKxTgsGKQsAIQ1w4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713876569; c=relaxed/simple;
	bh=4KJAZTnFdP0YfNsuIvgBcb3TjXvRU3k02Foba2mASPY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EmxBgTJCxbc3WzVmujTW6cy0tFnrYUs8M9pTlSZZSUnvNdeCo3SzZgwIpEQ/AMzH4QGrrYkvNeyN75RByuKV1JRVNGSda5MZixwF2wUeKiQzB/wGAf6cjrCsEYPKaxqWfhtRHBtrSs5Onm6FqotwCmaYFB1AlL7iTGNTpmWPm6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=tVkokZzG; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from localhost.localdomain (85-222-111-42.dynamic.chello.pl [85.222.111.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: lukma@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id BAEB48828C;
	Tue, 23 Apr 2024 14:49:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1713876566;
	bh=kzTo4K8y7VuBk5h4xs8FQ5Pjrt3pC9EnvZtlpBFRwK8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tVkokZzGMiaiUWimE/8N7Nc2vjrEGPsZaXZbcF9qic2l6L54sKxDS7QTicsfnTYzD
	 Tj4JhfV1WdR/fO1kiMc8mpziyJBxrjMXsOoieUCZ/e3sg3uwG1upGywbXhhsALHqk7
	 7zd9RnbiSz0NuNm8N4nSx1YipM97IO8hyZAPsAwaQEo8LgaRX87HjaPBfH1zL7P0Yf
	 ocG4VF0RR0s028fQg2x/Lfhia1Rkf1G21AndbCenD6CLKbSBMPN/HEq/+Ec2LTYSr5
	 Eco19MkWvt4yH+8IYlHN21IjfkGgXMd5+DtSqYfALNx3hm3lHkLYUYBN18Eb/7MpIs
	 mauMxg6VIZUcQ==
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
Subject: [net-next PATCH v6 4/5] test: hsr: Extract version agnostic information from ping command output
Date: Tue, 23 Apr 2024 14:49:07 +0200
Message-Id: <20240423124908.2073400-5-lukma@denx.de>
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

Current code checks if ping command output match hardcoded pattern:
"10 packets transmitted, 10 received, 0% packet loss,".

Such approach will work only from one ping program version (for which
this test has been originally written).
This patch address problem when ping with different summary output
like "10 packets transmitted, 10 packets received, 0% packet" is
used to run this test - for example one from busybox (as the test
system runs in QEMU with rootfs created with buildroot).

The fix is to modify output of ping command to be agnostic to ping
version used on the platform.

Signed-off-by: Lukasz Majewski <lukma@denx.de>
---
Changes for v6:
- New patch
---
 tools/testing/selftests/net/hsr/hsr_common.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/hsr/hsr_common.sh b/tools/testing/selftests/net/hsr/hsr_common.sh
index be4ad07ff355..8e97b1f2e7e5 100644
--- a/tools/testing/selftests/net/hsr/hsr_common.sh
+++ b/tools/testing/selftests/net/hsr/hsr_common.sh
@@ -51,7 +51,8 @@ do_ping_long()
 	fi
 
 	VAL="$(echo $OUT | cut -d' ' -f1-8)"
-	if [ "$VAL" != "10 packets transmitted, 10 received, 0% packet loss," ]
+	SED_VAL="$(echo ${VAL} | sed -r -e 's/([0-9]{2}).*([0-9]{2}).*[[:space:]]([0-9]+%).*/\1 transmitted \2 received \3 loss/')"
+	if [ "${SED_VAL}" != "10 transmitted 10 received 0% loss" ]
 	then
 		echo "$netns -> $connect_addr ping TEST [ FAIL ]"
 		echo "Expect to send and receive 10 packets and no duplicates."
-- 
2.20.1



Return-Path: <linux-kernel+bounces-145131-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70CCB8A4FF3
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 14:57:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B50128172C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 12:57:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74AB8127B6A;
	Mon, 15 Apr 2024 12:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="fpj34lVE"
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52EC4126F04;
	Mon, 15 Apr 2024 12:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713185413; cv=none; b=l4nmvzV0Td8Lix07D5Xr0Bnv8daSuDMFhlB33DnFjGFfwfaj1RD9IP7KUojTvddvY1ySE3+Focz94haVxh7RE0wsLf+pcQFd+Frb8+GwhUhQWby4qXi9E/2HA3LQ2rQUBpdxTWajkke1fKuWBtIfqO2xkIEmJGhKG4EPgZq05gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713185413; c=relaxed/simple;
	bh=z0/VNucQ2b5gMFfyo65SQ3j5gsYjeZQte4ulxbPVM3M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=c1+U6hH1185Wa6RlqZ04nKYpNEfBrYrVncrHGXY5vN71VmBRJ4mXFeXEp6gj4K+xi2aqw6aVfz8HriXGzHlFBnD3JGSOSOr/cY8I9lLo9wmP3z41KTSESGJOkUM8hlmytjxjYsrjMauAQMjqHMDTjNzl5spqqCwNncBs6Af/0UI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=fpj34lVE; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from localhost.localdomain (85-222-111-42.dynamic.chello.pl [85.222.111.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: lukma@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id D6C3B88198;
	Mon, 15 Apr 2024 14:50:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1713185405;
	bh=p9dlsSxzlUXwfeOgL0Q/YTdva1qwP6JdcJnDZqixIvQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fpj34lVEyC2w+99Iu91s8I5Ba4wXSY7h3bMTpFnEAa9CcRJV2ql+3XiHYwjiaOgoV
	 YrtaFgBWk1dTye4q3/pu3nN+8SrAZ1CyTpKFHCgQvuy+HsWL5NCPTzgVfZMA9KiaYr
	 J7fT6CkQyOpk0SYdgf5ixTXMeQDr9mEXbZ9XkdoI3E8/aXuvpdyif5mxVqCnZvbVZE
	 rCtNYRj6IBtKIOQGOtOTLAKnOlOnb6YG4KBvYIqvIoPyfkjIpFZ8VKK1Obdwq8tdsr
	 5m8g0NnPQX0VZmjF2Zi0NXpPDhoRvbmT5GOr9NmU5b+2d7ENWeH3apFp9Bqc0IzDQ+
	 vDw+sgy8cYmIg==
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
Subject: [net-next PATCH v5 3/4] test: hsr: Extract version agnostic information from ping command output
Date: Mon, 15 Apr 2024 14:49:27 +0200
Message-Id: <20240415124928.1263240-4-lukma@denx.de>
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
 tools/testing/selftests/net/hsr/hsr_common.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/hsr/hsr_common.sh b/tools/testing/selftests/net/hsr/hsr_common.sh
index 822165391573..9ae2723f6a48 100644
--- a/tools/testing/selftests/net/hsr/hsr_common.sh
+++ b/tools/testing/selftests/net/hsr/hsr_common.sh
@@ -64,7 +64,8 @@ do_ping_long()
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



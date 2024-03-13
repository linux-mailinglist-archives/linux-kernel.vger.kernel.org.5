Return-Path: <linux-kernel+bounces-102373-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5795C87B17E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 20:17:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 59E7EB2A79D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 19:13:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FCC46280E;
	Wed, 13 Mar 2024 18:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="Cky7LxcD"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81D08626AB
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 18:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710355094; cv=none; b=RilAohjOheaMB4AT/KClxXMAVPXHwQ2FKJ8MU1cXrHWB2paacjDWwJh+bak+oRSzxU76lO1aRsm8CzPLqQ10SC9tZ+v1YsCTTHlwXtV5OklOzNDeqxgyOLm0XHWhooElEuNNVaf32At/rtjN7YNRryb5sstRer8ILA6Wn8vVQ4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710355094; c=relaxed/simple;
	bh=URUD89ZpV/M99TV8Q1KUNJTJb1wy6+G5vnL3bqgQajI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GVr/0HC1EQPEOhn5mFda23OmQAr8nkIHoEjSU1UbLhL2sPR0Cuz3zwA9yf2FpkOqDAFhlpLGNfEGkw5PeMdhYOSOKihgrj0uFwf4BN/0dUy/AGFd19R0YMR+rx0kYqY0MUyKX+a73g4l3gwB3+WGFgcGOa66v93xb3ZjSxs2VLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=Cky7LxcD; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-33e7ae72312so82540f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 11:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1710355091; x=1710959891; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8EzQDcDpN2IS5wJV2ssrZ8U1t23GsreBp6xfIco7Uu8=;
        b=Cky7LxcDwl9vYQPaUJ5wQy2Ax1nAJmgIqeHWpJODKvLtN0HLjG5djofTuzwlU/QAwl
         e0xwC1B0W++UHhocrPrQaUWaRyoEGvVPHAy8SlRwRscGvi81ZiLEfNjZ5Mu4mYZcCCis
         ntJGzNaRGwaVsE2m3WCGexuBOd5EvOndLpg9I6i+pPnLee2dajfMfpmlznQTMBYeRvqv
         Jr7AezquA3Lb8VkThZ8bobSd5cuBAwrwr9O0NVvDo6amGkyOh6uAaEenihnpfPL+aYrf
         7dVJfuEW8sgiaEg/PZYUhY2OfVsusEPjVM8svO4IeqS9vkkKm1DJt7mmqF2QPdBjONA3
         5UIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710355091; x=1710959891;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8EzQDcDpN2IS5wJV2ssrZ8U1t23GsreBp6xfIco7Uu8=;
        b=AyPeRRJbaDv7m7CbNrBIs4garSBsDhYYaZE2MQ3CmvxOyg0fTkcV4VxES/f4x45qYp
         XuLvKZ1EEifZtQ3YHKKsXzzq9PXlmJEju1qBbug68HKaHYFuPWiy5hULYASu2NBSWUBF
         2Ef9tHJYsIC+0RmsVOclrNwzJpupIaQ0HvTnYVQFnr2S1cPvDNCrH+M7oKZChVDMWPM6
         ywTmFBYlg6HIK/82J9VPAr86HhMSNFBPpSeNdSHbqF1eoznW5FufLZC5BqZG/IZ0av6e
         PVcd1qranVaNx9zd30etesWZWJyH7wz6CpDirdBH5n/uEbYF9HGGNe+aP1Zl+e+k40Pk
         5O3A==
X-Forwarded-Encrypted: i=1; AJvYcCVI+sBr7vlOSzcXDxRCb/TXXvETv3o0CKb8LAGYpdhD5UGYCUSKtNgY8jHPlL6mgqGICwC7SBtzSHe67yGZ18r4NjGuQgx7D8vf3SUJ
X-Gm-Message-State: AOJu0Yx0KzoQ/rXaizXfSCpF2V3DRTrdKzlHBerdGZ15vERHy9/4Nma8
	pYzunXd+Q5BvuFSJH/q2xO+xuQludfj0Rafpfij9gyHQULqjrI5HItzLDOgcTwU=
X-Google-Smtp-Source: AGHT+IGN0kdH+ft/mrswhUd/gRl1XEtRbqs37iks4KzueF1kvu0EfYAfDh8X+dFbpFZ5Sfi7yl0azA==
X-Received: by 2002:adf:fa0f:0:b0:33e:800d:e87a with SMTP id m15-20020adffa0f000000b0033e800de87amr2281197wrr.34.1710355090852;
        Wed, 13 Mar 2024 11:38:10 -0700 (PDT)
Received: from localhost.localdomain ([104.28.192.85])
        by smtp.gmail.com with ESMTPSA id az19-20020adfe193000000b0033e9d9f891csm7089876wrb.58.2024.03.13.11.38.09
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 13 Mar 2024 11:38:10 -0700 (PDT)
From: Ignat Korchagin <ignat@cloudflare.com>
To: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: kernel-team@cloudflare.com,
	Ignat Korchagin <ignat@cloudflare.com>
Subject: [PATCH net v3 2/2] selftests: net: veth: test the ability to independently manipulate GRO and XDP
Date: Wed, 13 Mar 2024 19:37:59 +0100
Message-Id: <20240313183759.87923-3-ignat@cloudflare.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20240313183759.87923-1-ignat@cloudflare.com>
References: <20240313183759.87923-1-ignat@cloudflare.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We should be able to independently flip either XDP or GRO states and toggling
one should not affect the other.

Adjust other tests as well that had implicit expectation that GRO would be
automatically enabled.

Signed-off-by: Ignat Korchagin <ignat@cloudflare.com>
---
 tools/testing/selftests/net/udpgro_fwd.sh |  4 ++++
 tools/testing/selftests/net/veth.sh       | 24 ++++++++++++++++++++---
 2 files changed, 25 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/net/udpgro_fwd.sh b/tools/testing/selftests/net/udpgro_fwd.sh
index 9cd5e885e91f..380cb15e942e 100755
--- a/tools/testing/selftests/net/udpgro_fwd.sh
+++ b/tools/testing/selftests/net/udpgro_fwd.sh
@@ -217,6 +217,7 @@ for family in 4 6; do
 	cleanup
 
 	create_ns
+	ip netns exec $NS_DST ethtool -K veth$DST generic-receive-offload on
 	ip netns exec $NS_DST ethtool -K veth$DST rx-gro-list on
 	run_test "GRO frag list" $BM_NET$DST 1 0
 	cleanup
@@ -227,6 +228,7 @@ for family in 4 6; do
 	# use NAT to circumvent GRO FWD check
 	create_ns
 	ip -n $NS_DST addr add dev veth$DST $BM_NET$DST_NAT/$SUFFIX
+	ip netns exec $NS_DST ethtool -K veth$DST generic-receive-offload on
 	ip netns exec $NS_DST ethtool -K veth$DST rx-udp-gro-forwarding on
 	ip netns exec $NS_DST $IPT -t nat -I PREROUTING -d $BM_NET$DST_NAT \
 					-j DNAT --to-destination $BM_NET$DST
@@ -240,6 +242,7 @@ for family in 4 6; do
 	cleanup
 
 	create_vxlan_pair
+	ip netns exec $NS_DST ethtool -K veth$DST generic-receive-offload on
 	ip netns exec $NS_DST ethtool -K veth$DST rx-gro-list on
 	run_test "GRO frag list over UDP tunnel" $OL_NET$DST 1 1
 	cleanup
@@ -247,6 +250,7 @@ for family in 4 6; do
 	# use NAT to circumvent GRO FWD check
 	create_vxlan_pair
 	ip -n $NS_DST addr add dev $VXDEV$DST $OL_NET$DST_NAT/$SUFFIX
+	ip netns exec $NS_DST ethtool -K veth$DST generic-receive-offload on
 	ip netns exec $NS_DST ethtool -K veth$DST rx-udp-gro-forwarding on
 	ip netns exec $NS_DST $IPT -t nat -I PREROUTING -d $OL_NET$DST_NAT \
 					-j DNAT --to-destination $OL_NET$DST
diff --git a/tools/testing/selftests/net/veth.sh b/tools/testing/selftests/net/veth.sh
index 5ae85def0739..3a394b43e274 100755
--- a/tools/testing/selftests/net/veth.sh
+++ b/tools/testing/selftests/net/veth.sh
@@ -249,9 +249,9 @@ cleanup
 create_ns
 ip -n $NS_DST link set dev veth$DST up
 ip -n $NS_DST link set dev veth$DST xdp object ${BPF_FILE} section xdp
-chk_gro_flag "gro vs xdp while down - gro flag on" $DST on
+chk_gro_flag "gro vs xdp while down - gro flag off" $DST off
 ip -n $NS_DST link set dev veth$DST down
-chk_gro_flag "                      - after down" $DST on
+chk_gro_flag "                      - after down" $DST off
 ip -n $NS_DST link set dev veth$DST xdp off
 chk_gro_flag "                      - after xdp off" $DST off
 ip -n $NS_DST link set dev veth$DST up
@@ -260,6 +260,21 @@ ip -n $NS_SRC link set dev veth$SRC xdp object ${BPF_FILE} section xdp
 chk_gro_flag "                      - after peer xdp" $DST off
 cleanup
 
+create_ns
+ip -n $NS_DST link set dev veth$DST up
+ip -n $NS_DST link set dev veth$DST xdp object ${BPF_FILE} section xdp
+ip netns exec $NS_DST ethtool -K veth$DST generic-receive-offload on
+chk_gro_flag "gro vs xdp while down - gro flag on" $DST on
+ip -n $NS_DST link set dev veth$DST down
+chk_gro_flag "                      - after down" $DST on
+ip -n $NS_DST link set dev veth$DST xdp off
+chk_gro_flag "                      - after xdp off" $DST on
+ip -n $NS_DST link set dev veth$DST up
+chk_gro_flag "                      - after up" $DST on
+ip -n $NS_SRC link set dev veth$SRC xdp object ${BPF_FILE} section xdp
+chk_gro_flag "                      - after peer xdp" $DST on
+cleanup
+
 create_ns
 chk_channels "default channels" $DST 1 1
 
@@ -327,11 +342,14 @@ if [ $CPUS -gt 2 ]; then
 fi
 
 ip -n $NS_DST link set dev veth$DST xdp object ${BPF_FILE} section xdp 2>/dev/null
-chk_gro_flag "with xdp attached - gro flag" $DST on
+chk_gro_flag "with xdp attached - gro flag" $DST off
 chk_gro_flag "        - peer gro flag" $SRC off
 chk_tso_flag "        - tso flag" $SRC off
 chk_tso_flag "        - peer tso flag" $DST on
 ip netns exec $NS_DST ethtool -K veth$DST rx-udp-gro-forwarding on
+chk_gro "        - no aggregation" 10
+ip netns exec $NS_DST ethtool -K veth$DST generic-receive-offload on
+chk_gro_flag "        - gro flag with GRO on" $DST on
 chk_gro "        - aggregation" 1
 
 
-- 
2.39.2



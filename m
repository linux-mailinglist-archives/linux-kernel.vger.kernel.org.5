Return-Path: <linux-kernel+bounces-100495-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 012A8879893
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 17:10:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 967961F24115
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 16:10:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B8C77E58B;
	Tue, 12 Mar 2024 16:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="WfeGElob"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 058267D3E1
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 16:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710259812; cv=none; b=jN8zJhg9mrJKpWiQcB/QbHxPnKti77oNdpL3pJrrX3bHjs47Fxks7UsPgXnC0o+44w2auh0AK7QKv3Ek/XOQgN+krKZRAJ1f+c18mMNg5nsxyFihxLYGO0QYdDP96kFNc8avUyCs2Mq+/xBv3mJ66YcKB/8mKZ36fwjfZebd5nQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710259812; c=relaxed/simple;
	bh=Fc7O8sfBRRb8zOY1eOkMRYKNnB5ApRvE6ZnNgsRMbYg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=C0OLBO3BUwCtbnPv2v9uEzXlWeyqfntjimolugSY9+ryIaBJUJMVWbJ7OjBlslbcTjcsOyS9epZZKr6YbAndbRWE0i/pp21Vjc+/6+H6UcTK/vtgeHnu9178HRQSP9adV2TPfIc0Jm0rYQ/W6+X11ig5Si0kt5bWJC2fiHiusWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=WfeGElob; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-413e642806fso1207715e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 09:10:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1710259809; x=1710864609; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9wNUX9DZCZhkOtkzBdWY6lDTHbYdRFBZXQzvAC4CccA=;
        b=WfeGElob94iVcNvEUrLD+hD8IJpTbHvgaI3ykcUz8EI9MyeYXhnmblK0VLvuzDGKsL
         oKXQtHwEO1cmNl5w4j2qseyBWbAazM1QmqOzgOthxNx3OKFIaDhZvU42AKfwwmZPg41m
         LTLf0BDBJ99PkNAT0M+hff4C6aieJsbpfwCIIKuxlr8cN0lFON4R11oxp3GvHnXUbfSA
         xr1NKAzkqFqX7YSCTYWTrypKMyBQ8XsxnNzDIEFQ8cl5BSKKXdD4lH6W7ylDOYOIm8Sg
         D/U7aPYXT43vgaGjOPX2iVG0G1YsD/AvjjK9SJtEZ/ckdrLLgN6USca979ApfivmtwpI
         ILeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710259809; x=1710864609;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9wNUX9DZCZhkOtkzBdWY6lDTHbYdRFBZXQzvAC4CccA=;
        b=OaXbwTydZ0O4ydUFHm8RSQ86QqtPLNWAMSTMceYf057xmVo36qpbfzID194LTTiwd2
         vANk4yAzC/H7VqZ+60kggaOYvLotyzRUXd5XdUb3gcdEvZPSKeJdoeaK692dCOkNkkaj
         ZJLfEwDgnSETcrmh8qsWDtnZ82jI77ptxVg8dje+6MCmc2Sv3H91VDo1VcpxZjmjazkV
         cp9Ph4yTfonpYAx14Glf+6soBPKNETP8MR6hfS6mdFiZ8CHyyrsP94xxk/U0TAjqPWBA
         Hmym3bslXy9K9L7NNgRfEegmVKreG2DswGt/KW6F09m/YZbINiSDHEFoMq7i9m2oZsAY
         ojwA==
X-Forwarded-Encrypted: i=1; AJvYcCVq2wFCMti9Z258AACdLYJ4tNESjyAdxLUSL6rKhoAbQgwo1DNqHQDwSciOqHkdplj3L+iN5AFORIjVanwrNPGgu+Pz45PwuMWaN0Xk
X-Gm-Message-State: AOJu0YyOQEoGaEg8J5GBr3gAo9K1FIbSstrBgL4eWWWfglRDvAJfAT/7
	VqGsGxBIl7X0e0XzcH2nsn+qrpj0JFACOvqcRLdlAP8TChR4Jfwa11j69qichp4=
X-Google-Smtp-Source: AGHT+IF+bWouiIFf+uP88Mr8eQSuWHP1533kqdq4LfgBW7SC7cEl/s7h/DffeGifPPsn3+G8rECSuw==
X-Received: by 2002:a05:600c:4690:b0:412:95fb:e41 with SMTP id p16-20020a05600c469000b0041295fb0e41mr1840249wmo.24.1710259809271;
        Tue, 12 Mar 2024 09:10:09 -0700 (PDT)
Received: from localhost.localdomain ([104.28.232.7])
        by smtp.gmail.com with ESMTPSA id fl8-20020a05600c0b8800b00413e523b7f9sm474253wmb.43.2024.03.12.09.10.08
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 12 Mar 2024 09:10:08 -0700 (PDT)
From: Ignat Korchagin <ignat@cloudflare.com>
To: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: kernel-team@cloudflare.com,
	Ignat Korchagin <ignat@cloudflare.com>
Subject: [PATCH net v2 2/2] selftests: net: veth: test the ability to independently manipulate GRO and XDP
Date: Tue, 12 Mar 2024 16:05:52 +0000
Message-Id: <20240312160551.73184-3-ignat@cloudflare.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20240312160551.73184-1-ignat@cloudflare.com>
References: <20240312160551.73184-1-ignat@cloudflare.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We should be able to independently flip either XDP or GRO states and toggling
one should not affect the other.

Signed-off-by: Ignat Korchagin <ignat@cloudflare.com>
---
 tools/testing/selftests/net/veth.sh | 24 +++++++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)

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



Return-Path: <linux-kernel+bounces-150352-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 759768A9DC5
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 16:58:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 142821F23A86
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 14:58:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D5F016ABEA;
	Thu, 18 Apr 2024 14:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="BAT8MIoK"
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6128016ABD8
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 14:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713452280; cv=none; b=nYYmfMKdDnI+dMJ5VMd3v7ipyV3b2lWFObOR/YJ1H9D48QSRY+82Zduli6fzzr0z3EvE8xdhfzv1xsVqkgJcQcTzuuG2KScsYEavvbGBYdYTiNxeB6Pfhu3U3yQqC/psSxqErIpDXwQQXA7kXXsycQ3biV3rz1x66pezFml7Awo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713452280; c=relaxed/simple;
	bh=XnWJOnILBcBRDeU1BqBLAtGDVWZ7R54SvcYt0DpJjys=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kS5Z3aMEDqZIqaXusLTcsHgXYSggiE9pt6bLtPmaDJro15RTnLRh8SJx/IwPWoLN6kxNbUi3NG4yx+m+RO4FuGniv3bQ04y3PU+GJMu38AGCNKCwrc5OIVuQQ4DFdMUMODQDTbcp9YgAs9bqtnXWM7swJOXDZrJK2AOxeyK0y5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=BAT8MIoK; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com [209.85.218.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 331673F68F
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 14:57:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1713452272;
	bh=TPzhJ3AAYaNuKmuKpflVm92Wqe6tHXbtl8g4S4zlOco=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
	b=BAT8MIoKlopi90CacwOQVPh0v/pBJBYgIWvrP5qRLoZbLA2NqWDQHgyvXwiI8UEMW
	 boJDhO6wVH6BH7mzp8Ow73Im10o8w+rMrgerZmcKTcYFIJDBknvCST6yCW3mHRykZM
	 0BizvkRbPrM9H3XgXAf0ilFPS46mONPfyCS+QVy70t7LQzYpqFhwkCIYqwPoj9oT3h
	 1YhQ0DXnF0rC3nmN1v3u5PyDfTA4r0v2m9wb/Quo2487xqk3uaBRR+SbHUfqAesfn7
	 CEK/p7Db17pH0wwod0eVQHbuvDuv06EdP+R+fBKJnM1d40nWBWmqwQz27d6lQBW7L1
	 9SCG5jpPRdd2w==
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a51beadf204so53247866b.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 07:57:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713452271; x=1714057071;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TPzhJ3AAYaNuKmuKpflVm92Wqe6tHXbtl8g4S4zlOco=;
        b=V6Nj8s1t4IfuTmebLz85F0VbxTzNp4K11ybRRz2XbVtOVwr14+XNNIg5Dl2csi/60y
         mCDFzSOWTCD41atSjjl6MYRxmTHw37IUceY2EvcEE8zVOsPPhS2adJnt6E7HVSSmviK4
         EXEA0Y0BrZ9Eo7m7QKpULMs4jRoiEZHrwXYi3TqK9PDisRtWkgkw1qQ0YPY6qB+zRoC1
         0AiDgyQEZnRWn6huG1nDQAbQZftTDu22LTWTbJbdoU4JgKh3rPj0Uz3+KlIXhpKrjxWA
         3w2kQi+AUvZnAy6r8vJXKtjBbmuJUkYLb7aeP4bg0Kia+xh4LKy0ayE6nP7lqv5DHJp9
         LXXQ==
X-Forwarded-Encrypted: i=1; AJvYcCU+kxhhguPuhmtGsX2LmTqLN55/RdMzpr9vSJTvijY5IK0pHncZFmeDu24Z2yBG16/f4yTW3Jl5R7YJDcLWGkBJBkqCjuyUXtJ/kjTW
X-Gm-Message-State: AOJu0YwampXcxaC0Nh/ekJ+wDFoGPpqFMmZR9W0XYzIeYVFMm9gQuSb9
	84drBH54xoI1Ad3bvv8v7uiL7QhLavVU2jxvXQ3Do+rZjrFdE4od2Ug+m8rjgbYW3FUHuEdkqnj
	YA0R96wbG2exTLwJDHl6A8T16bfsYqTkKNCBEd5Pm5SFG/2ZkFBDQcJpFJf3808RzlzvGmMdpXf
	754g==
X-Received: by 2002:a17:906:1182:b0:a52:58a7:11d1 with SMTP id n2-20020a170906118200b00a5258a711d1mr1836769eja.38.1713452271345;
        Thu, 18 Apr 2024 07:57:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFhzDZOsSyjW2YgiF+3b9SbPzp6uVKID7mT1Wura27dE1HKH8MQkcJys3WmmEXVTnVSN92wWQ==
X-Received: by 2002:a17:906:1182:b0:a52:58a7:11d1 with SMTP id n2-20020a170906118200b00a5258a711d1mr1836755eja.38.1713452271043;
        Thu, 18 Apr 2024 07:57:51 -0700 (PDT)
Received: from amikhalitsyn.lan ([2001:470:6d:781:320c:9c91:fb97:fbfc])
        by smtp.gmail.com with ESMTPSA id jj17-20020a170907985100b00a522a073a64sm993665ejc.187.2024.04.18.07.57.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 07:57:50 -0700 (PDT)
From: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
To: horms@verge.net.au
Cc: netdev@vger.kernel.org,
	lvs-devel@vger.kernel.org,
	netfilter-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
	Julian Anastasov <ja@ssi.bg>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	Florian Westphal <fw@strlen.de>
Subject: [PATCH net-next v3 1/2] ipvs: add READ_ONCE barrier for ipvs->sysctl_amemthresh
Date: Thu, 18 Apr 2024 16:57:42 +0200
Message-Id: <20240418145743.248109-1-aleksandr.mikhalitsyn@canonical.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Cc: Julian Anastasov <ja@ssi.bg>
Cc: Simon Horman <horms@verge.net.au>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: Jozsef Kadlecsik <kadlec@netfilter.org>
Cc: Florian Westphal <fw@strlen.de>
Suggested-by: Julian Anastasov <ja@ssi.bg>
Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
---
 net/netfilter/ipvs/ip_vs_ctl.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/net/netfilter/ipvs/ip_vs_ctl.c b/net/netfilter/ipvs/ip_vs_ctl.c
index 143a341bbc0a..32be24f0d4e4 100644
--- a/net/netfilter/ipvs/ip_vs_ctl.c
+++ b/net/netfilter/ipvs/ip_vs_ctl.c
@@ -94,6 +94,7 @@ static void update_defense_level(struct netns_ipvs *ipvs)
 {
 	struct sysinfo i;
 	int availmem;
+	int amemthresh;
 	int nomem;
 	int to_change = -1;
 
@@ -105,7 +106,8 @@ static void update_defense_level(struct netns_ipvs *ipvs)
 	/* si_swapinfo(&i); */
 	/* availmem = availmem - (i.totalswap - i.freeswap); */
 
-	nomem = (availmem < ipvs->sysctl_amemthresh);
+	amemthresh = max(READ_ONCE(ipvs->sysctl_amemthresh), 0);
+	nomem = (availmem < amemthresh);
 
 	local_bh_disable();
 
@@ -145,9 +147,8 @@ static void update_defense_level(struct netns_ipvs *ipvs)
 		break;
 	case 1:
 		if (nomem) {
-			ipvs->drop_rate = ipvs->drop_counter
-				= ipvs->sysctl_amemthresh /
-				(ipvs->sysctl_amemthresh-availmem);
+			ipvs->drop_counter = amemthresh / (amemthresh - availmem);
+			ipvs->drop_rate = ipvs->drop_counter;
 			ipvs->sysctl_drop_packet = 2;
 		} else {
 			ipvs->drop_rate = 0;
@@ -155,9 +156,8 @@ static void update_defense_level(struct netns_ipvs *ipvs)
 		break;
 	case 2:
 		if (nomem) {
-			ipvs->drop_rate = ipvs->drop_counter
-				= ipvs->sysctl_amemthresh /
-				(ipvs->sysctl_amemthresh-availmem);
+			ipvs->drop_counter = amemthresh / (amemthresh - availmem);
+			ipvs->drop_rate = ipvs->drop_counter;
 		} else {
 			ipvs->drop_rate = 0;
 			ipvs->sysctl_drop_packet = 1;
-- 
2.34.1



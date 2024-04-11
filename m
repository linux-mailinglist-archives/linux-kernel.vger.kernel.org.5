Return-Path: <linux-kernel+bounces-140286-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F84F8A1247
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 12:53:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59FAC1C2142C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 10:53:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A37D8146D7E;
	Thu, 11 Apr 2024 10:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="UYmPND8P"
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C352A2EAE5;
	Thu, 11 Apr 2024 10:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712832826; cv=none; b=T6ff7Y9+KQzjlz4EC+HqZQJEF/hdcyTZKKofpE0UL8MHsGko6XvnVqHQnvwJHeCodmTWlalimmCiVj3WfH3ByJTragGeVs69AMe5mDYpC9nQPL4wPPFKjs3fJMfvZsHORoezLEv9UsAfpUiA7qb3PLC+H5id1LZB+aERA39EN5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712832826; c=relaxed/simple;
	bh=hA4bLqry0f38bkJtkBZ2E//5jq8jhyAZdUEvMOe9BL8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bvHAwYkWcbTzAN85H23yAwTkRHV24TZYJMmHu+wLmNxnzNBi7bhAnIxfY2BiwA0YMVFccdBGkJUeZmATgbLl64W/mKjBFFnqHCMicjB4oBmDwJIjuA14Toiz4BEuhTGluyxXiM6Q5f9Bke/HY2y27Hf1mkgzK6zcV0pA1Uvv2m4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=UYmPND8P; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id 55E8D600A2;
	Thu, 11 Apr 2024 10:53:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1712832815;
	bh=hA4bLqry0f38bkJtkBZ2E//5jq8jhyAZdUEvMOe9BL8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UYmPND8PWvAcLq6omI3g5jtVViO9/dxL2Wk03v6XNMtrT6XHlbH7nu/7jW8noNUqZ
	 3S1kQrrriI9Ad6vdVoYnonijbCx+at6UB2jobo2ts6p8cdx2vQncrIVUL35wvVZA/u
	 EeT6I03o5GcgzvQNa+PY1cFSYHEIygkTznzWTDXoJbnqivS7xBf1wrwTuHJrw2Drf0
	 6nXPkb9zD9Iukr24ssq/Epw7wVLLaQzIMvVdFCxjPGCRQFRciZFEp7L5x7QeKrAncf
	 G+O6S5xjV0u7EGJfvc5T3cRmTVBdXk8Ukr8SJgbaGz17PX4QG3LNIypPr1YT/YlzYp
	 MN89YGRRQ/Vzg==
Received: by x201s (Postfix, from userid 1000)
	id B250620EF3B; Thu, 11 Apr 2024 10:53:18 +0000 (UTC)
From: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>
To: netdev@vger.kernel.org
Cc: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org,
	Louis Peens <louis.peens@corigine.com>,
	Yanguo Li <yanguo.li@corigine.com>,
	oss-drivers@corigine.com,
	Taras Chornyi <taras.chornyi@plvision.eu>,
	Woojung Huh <woojung.huh@microchip.com>,
	UNGLinuxDriver@microchip.com,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Edward Cree <ecree.xilinx@gmail.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>,
	Jiri Pirko <jiri@resnulli.us>
Subject: [PATCH net-next v3 4/4] net: dsa: microchip: ksz9477: flower: validate control flags
Date: Thu, 11 Apr 2024 10:52:57 +0000
Message-ID: <20240411105302.112091-5-ast@fiberby.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240411105302.112091-1-ast@fiberby.net>
References: <20240411105302.112091-1-ast@fiberby.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add check for unsupported control flags.

Only compile-tested, no access to HW.

Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>
---
 drivers/net/dsa/microchip/ksz9477_tc_flower.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/dsa/microchip/ksz9477_tc_flower.c b/drivers/net/dsa/microchip/ksz9477_tc_flower.c
index 8b2f5be667e01..ca7830ab168ac 100644
--- a/drivers/net/dsa/microchip/ksz9477_tc_flower.c
+++ b/drivers/net/dsa/microchip/ksz9477_tc_flower.c
@@ -124,6 +124,9 @@ static int ksz9477_flower_parse_key(struct ksz_device *dev, int port,
 		return -EOPNOTSUPP;
 	}
 
+	if (flow_rule_match_has_control_flags(rule, extack))
+		return -EOPNOTSUPP;
+
 	if (flow_rule_match_key(rule, FLOW_DISSECTOR_KEY_BASIC) ||
 	    flow_rule_match_key(rule, FLOW_DISSECTOR_KEY_ETH_ADDRS)) {
 		ret = ksz9477_flower_parse_key_l2(dev, port, extack, rule,
-- 
2.43.0



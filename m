Return-Path: <linux-kernel+bounces-138263-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5674E89EEF1
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 11:33:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 049912822E4
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 09:33:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0BAA1591F1;
	Wed, 10 Apr 2024 09:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="rvXwihWs"
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6965D1553BF;
	Wed, 10 Apr 2024 09:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712741582; cv=none; b=g8Mwv2ayFSWyhupN/G4hvWewjZ16qsSTVnxg0PrnSxoCVBrOYv+eOhsQxjd0gzGNsbW9lSrTHVmCCeIwETbxc6PHMqocqXWrQysWYXBzkygLPMfhWBL4q60k45V43ukZIpTOfhwRfqAnL++oOL42FswFlT7Jk+uB9C2wmw6g9m8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712741582; c=relaxed/simple;
	bh=hA4bLqry0f38bkJtkBZ2E//5jq8jhyAZdUEvMOe9BL8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uuVygXZsEE3TZlQ32eKgDYXItY+S7XEZ49W0pytTaQT4FAfJGXXxYp3kqrzi8SdPIYxu/sIB3D67TDHdbe7310glUkWUKequX9O/gEtBYlZxH37apLga3QLYdU9DttHiBaqhV66uSnwns4f+c5lMpZUiplqnR3DRR+ZW9aPW+0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=rvXwihWs; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id BE144600A5;
	Wed, 10 Apr 2024 09:32:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1712741573;
	bh=hA4bLqry0f38bkJtkBZ2E//5jq8jhyAZdUEvMOe9BL8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rvXwihWsjNXni7NbXHMR9ICfhE8s8uPB1KSTg0lut/EYzsej2+uSJ+V66MFVrZ+lK
	 Knv+5QhvAJAbLmomOS/RWkcqyEU7D7tYjMMn8KNvPfPPAI64Kp1MLK2sDYbggs4VsG
	 rRxX9oovEnJoV7ujbylHg1C1zYDvzPpEvYM9gxiBX7VLCTQvxUunW0YfmcQdc4Ce+r
	 QJoDUa/i4Dp4SLyy19xnL2NFIWvS0wfszjVI/Ansi9sEv+IHVCI1MSYdK3TY7VpbvZ
	 tYrKYYq60Sx8qbxzpEdC8fqL7nrIqGYWRd34Ji7tLhFteu8LzX3a++bF2np15s4Joo
	 V9RlAu/QVud/w==
Received: by x201s (Postfix, from userid 1000)
	id D245720BDE6; Wed, 10 Apr 2024 09:32:41 +0000 (UTC)
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
Subject: [PATCH net-next v2 4/4] net: dsa: microchip: ksz9477: flower: validate control flags
Date: Wed, 10 Apr 2024 09:32:25 +0000
Message-ID: <20240410093235.5334-5-ast@fiberby.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240410093235.5334-1-ast@fiberby.net>
References: <20240410093235.5334-1-ast@fiberby.net>
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



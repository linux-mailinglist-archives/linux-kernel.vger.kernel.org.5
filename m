Return-Path: <linux-kernel+bounces-135427-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 650B189C1D5
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 15:24:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 983A11C215BD
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 13:24:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CFC085C44;
	Mon,  8 Apr 2024 13:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="ukQgap4V"
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1135862148;
	Mon,  8 Apr 2024 13:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712582416; cv=none; b=BNXvUscJdEzUTPwk+dnyV0BoR6CLODkKllcD4AVFruV9EhPId+vfQ3RPfgASMWboLHnIIduYjEmw36iFKQeGh5kxoS4a7XligT2u8o682tFWTYAnsyWpVUSxoy2m9zeydAreFrz3yAU0j4MBLvQ5N9P1h1uidZd06+/rfHkbH1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712582416; c=relaxed/simple;
	bh=Lg7MpZIv/xYXPJQLm776tfjlApa0oKTGhqiiIowID+0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PbD0TLboJpL0GLu77qyOSojNH53xGPEkU2D830PCAwUUCHeU8rg2CuoLrYsQ8O2+X8Hcr+0fmGXWnJNSki+mhpfEckX6PtLXKdqQWTSJvpjiLpZdSfjadyVkuzFu7K0ZW01ExVTQqvhX7E2tilRNpMYfyK6bjd04G4lIBGUjWCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=ukQgap4V; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id 7791E600A2;
	Mon,  8 Apr 2024 13:10:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1712581838;
	bh=Lg7MpZIv/xYXPJQLm776tfjlApa0oKTGhqiiIowID+0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ukQgap4VNE/vEA18w+LsctfzZJVVbH5993hCpyEXFwbO5RsxzLSdiYuvYQdSZSSBr
	 0Zwu+kMItoPPBwuiVadpvYwGoAyGRfMwC62RwOIMI6Vr14reFCwrdT4iqYeo3z31ek
	 lrpFvy8acFixr7vXWudQheEMb4t3ZaIzkKLTevsFUgej9H/l6x6ZqrRlG+eMmBgm8L
	 X3d5xObHrLSUacMgbYs3fYwQ87bCWJsYjIgPvQJUJ/xpv7kd+5IQOBvppvgq7rB3OL
	 44KJjW1ifhYrLrm2/uX4n7kdckW1L/D2o9p34JkeUKkyVGd7BEJRMDS0IH28O7WadB
	 kPdBkZjsvE+Ww==
Received: by x201s (Postfix, from userid 1000)
	id F02F5205049; Mon, 08 Apr 2024 13:09:39 +0000 (UTC)
From: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Louis Peens <louis.peens@corigine.com>,
	Taras Chornyi <taras.chornyi@plvision.eu>,
	Woojung Huh <woojung.huh@microchip.com>,
	UNGLinuxDriver@microchip.com
Cc: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yanguo Li <yanguo.li@corigine.com>,
	oss-drivers@corigine.com,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Edward Cree <ecree.xilinx@gmail.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>,
	Jiri Pirko <jiri@resnulli.us>
Subject: [PATCH net-next 3/6] flow_offload: add flow_rule_no_control_flags()
Date: Mon,  8 Apr 2024 13:09:21 +0000
Message-ID: <20240408130927.78594-4-ast@fiberby.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240408130927.78594-1-ast@fiberby.net>
References: <20240408130927.78594-1-ast@fiberby.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This helper can be used by drivers, that doesn't support
any control flags, to reject any attempt to install rules
with control flags.

This is aimed at drivers, which uses flow_rule_match_control(),
but doesn't implement any control flags.

Only compile-tested.

Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>
---
 include/net/flow_offload.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/include/net/flow_offload.h b/include/net/flow_offload.h
index c1317b14da08c..415d225204a1f 100644
--- a/include/net/flow_offload.h
+++ b/include/net/flow_offload.h
@@ -471,6 +471,19 @@ static inline bool flow_rule_no_unsupp_control_flags(const u32 supp_flags,
 	return false;
 }
 
+/**
+ * flow_rule_no_control_flags() - check for presence of any control flags
+ * @flags: flags present in rule
+ * @extack: The netlink extended ACK for reporting errors.
+ *
+ * Returns true if no control flags are set, false otherwise.
+ */
+static inline bool flow_rule_no_control_flags(const u32 flags,
+					      struct netlink_ext_ack *extack)
+{
+	return flow_rule_no_unsupp_control_flags(0, flags, extack);
+}
+
 struct flow_stats {
 	u64	pkts;
 	u64	bytes;
-- 
2.43.0



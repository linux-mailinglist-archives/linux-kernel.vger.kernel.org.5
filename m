Return-Path: <linux-kernel+bounces-135426-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A23B489C1D0
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 15:24:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E1732831FB
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 13:24:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B253585658;
	Mon,  8 Apr 2024 13:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="ZGp1Wkw6"
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1139A7B3E5;
	Mon,  8 Apr 2024 13:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712582416; cv=none; b=rejIWid7BTrpRO9z2mGUck9wTmpdKpx/ihE5js8I/oUWdwGjwaOLJp9iRgHLNb4PcQS5tEdwekIzHRq1EOMQ9cFm+5W8jW/2RIKaJexuHiJy9iI7NPtf0lFnnyWl/StzXOydXz8y5266werlkStvCUGpfmnyj9o7iU5tO+Ndk/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712582416; c=relaxed/simple;
	bh=ybDXUvRF9y6wAVfgDLw3PDAmgXBzneOlo90cnXJ4qG8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Yhb6YsR2rDwpc3VmM+3/74p2UVMlBnjkv6bC+aYKFbbMY9XHw4icfrEgNw+obgzWUIX/VqBvmsoWnZeG4MspOrViDISlQJpsSNwebx2UiAqqNOZmk1sP8rmS/8lwzz3Fjlp22CIbG7d6lI/8DOSlEZWLLj59GFG8fm2lfn5Nk/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=ZGp1Wkw6; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id 9035E600B1;
	Mon,  8 Apr 2024 13:10:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1712581838;
	bh=ybDXUvRF9y6wAVfgDLw3PDAmgXBzneOlo90cnXJ4qG8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZGp1Wkw6pyXtSdbijXOMykk4HWkte2yBaRa8+vodUcCLehD2tAFMJqgRFee3X17y5
	 wPG8mUMjQ2kmRhxUSXWmqrKn1fD6sVbweETvJC5htAb1RQIu3k65zKvM3k4pzmZvzE
	 TmP3vSwfJCjLHM5Nvg84N6eVgU7y+pND2cUlhab5l6YmL5YchcnX8WLGBXNgz7e95w
	 lFoG9+UCF3cNtqRvOZ6ktgPh/lXo2hIF4dWUoEe432IatfVdL2ZSBz+4QjW6lxHxvO
	 fZL8Nw8Fr6SVb5Tb1PifeS0z7+By465MUAf3KWpY4crSUwR+udE6wEHE8e/YtNw2kx
	 JOsoDa1bgsTRQ==
Received: by x201s (Postfix, from userid 1000)
	id EE36320BDE2; Mon, 08 Apr 2024 13:09:41 +0000 (UTC)
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
Subject: [PATCH net-next 5/6] flow_offload: add flow_rule_match_no_control_flags()
Date: Mon,  8 Apr 2024 13:09:23 +0000
Message-ID: <20240408130927.78594-6-ast@fiberby.net>
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

This helper can by used by drivers, that doesn't look
into FLOW_DISSECTOR_KEY_CONTROL at all.

This is aimed at drivers, which doesn't call flow_rule_match_control()
directly, and therefore doesn't support any control flags.

Only compile-tested.

Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>
---
 include/net/flow_offload.h | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/include/net/flow_offload.h b/include/net/flow_offload.h
index 415d225204a1f..b427b93d151a9 100644
--- a/include/net/flow_offload.h
+++ b/include/net/flow_offload.h
@@ -484,6 +484,26 @@ static inline bool flow_rule_no_control_flags(const u32 flags,
 	return flow_rule_no_unsupp_control_flags(0, flags, extack);
 }
 
+/**
+ * flow_rule_match_no_control_flags() - match and check for any control flags
+ * @rule: The flow_rule under evaluation.
+ * @extack: The netlink extended ACK for reporting errors.
+ *
+ * Returns true if no control flags are set, false otherwise.
+ */
+static inline bool flow_rule_match_no_control_flags(struct flow_rule *rule,
+						    struct netlink_ext_ack *extack)
+{
+	struct flow_match_control match;
+
+	if (!flow_rule_match_key(rule, FLOW_DISSECTOR_KEY_CONTROL))
+		return true;
+
+	flow_rule_match_control(rule, &match);
+
+	return flow_rule_no_control_flags(match.mask->flags, extack);
+}
+
 struct flow_stats {
 	u64	pkts;
 	u64	bytes;
-- 
2.43.0



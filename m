Return-Path: <linux-kernel+bounces-138261-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CEF189EEEF
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 11:33:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2A825B249D6
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 09:33:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D0D51581ED;
	Wed, 10 Apr 2024 09:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="FX71Y6W6"
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8962C144312;
	Wed, 10 Apr 2024 09:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712741581; cv=none; b=uV8Lbw3DYgVwWavdBz/m6i+soYsiuexwWu1CMFHMLQXpGpwXEHc0uKhIbydmu8fCi8/PoF0aLmP2mWIyJ1VVm8tXZYCs3G9EWhlQmfnjPUmk9nwMvBEoD/LGMEylTXg3rxDhuPCX76zWwITOi7pwYs0kTaLF8X1S3D3aceW2P+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712741581; c=relaxed/simple;
	bh=dz2ZRjqTz89ZMEMlnTX6GlK7nVgj8fTZW8/LNxn/yyo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aaVsKRNJCHp/G4tdcOXStMNsujJFe36ClWklmj+iu1kVNPAzkl2BWql6B24KVPDHRRmyiVXRND9t3fOasv40mr63izcQyEVfwATuzUDU+RGcPyF/K6s4wrom47/kAv7MgxB7yjZWuwMBx63ARmZbmWskYkrkiuRI1ecSQuk5FQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=FX71Y6W6; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id C7AA4600A9;
	Wed, 10 Apr 2024 09:32:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1712741568;
	bh=dz2ZRjqTz89ZMEMlnTX6GlK7nVgj8fTZW8/LNxn/yyo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FX71Y6W6XKB/HF9n8dBmNZuiUpUkRHrzi9ypWd4iqYandQNSHpRZ5fRiHwPmFdxte
	 g2Y4mUX9/k1u2IJFUUsUcmHLGZGaah20geWMXzivCTVLO7yuLDUjkNfL/deKxlyF7O
	 CHoE9LhtNixMXetnfTgQHb/LIeynzlRZPhqBkKx8mFNMCEZANjorxN0p15xpr3J1Q6
	 bjqQ1I8Fkt/JbrMDCxeXr01TmnhcADmWsy4LnZAZQzm8YT9HeN7rfuS6uT+rGbIXj7
	 kMuFEI4JfF+XiJOTfiDtzqEZ/fjHDfj9zL2Rv/03RU5pI7OHTk3KnvvTx4lnJZu7ZV
	 VtR5HPXh23rGg==
Received: by x201s (Postfix, from userid 1000)
	id A92CE20B99F; Wed, 10 Apr 2024 09:32:39 +0000 (UTC)
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
Subject: [PATCH net-next v2 1/4] flow_offload: add control flag checking helpers
Date: Wed, 10 Apr 2024 09:32:22 +0000
Message-ID: <20240410093235.5334-2-ast@fiberby.net>
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

These helpers aim to help drivers, with checking
for the presence of unsupported control flags.

For drivers supporting at least one control flag:
  flow_rule_is_supp_control_flags()

For drivers using flow_rule_match_control(), but not using flags:
  flow_rule_has_control_flags()

For drivers not using flow_rule_match_control():
  flow_rule_match_has_control_flags()

While primarily aimed at FLOW_DISSECTOR_KEY_CONTROL
and flow_rule_match_control(), then the first two
can also be used with FLOW_DISSECTOR_KEY_ENC_CONTROL
and flow_rule_match_enc_control().

These helpers mirrors the existing check done in sfc:
  drivers/net/ethernet/sfc/tc.c +276

Only compile-tested.

Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>
---
 include/net/flow_offload.h | 55 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/include/net/flow_offload.h b/include/net/flow_offload.h
index 314087a5e1818..9ee3ad4a308a8 100644
--- a/include/net/flow_offload.h
+++ b/include/net/flow_offload.h
@@ -449,6 +449,61 @@ static inline bool flow_rule_match_key(const struct flow_rule *rule,
 	return dissector_uses_key(rule->match.dissector, key);
 }
 
+/**
+ * flow_rule_is_supp_control_flags() - check for supported control flags
+ * @supp_flags: control flags supported by driver
+ * @ctrl_flags: control flags present in rule
+ * @extack: The netlink extended ACK for reporting errors.
+ *
+ * @returns true if only supported control flags are set, false otherwise.
+ */
+static inline bool flow_rule_is_supp_control_flags(const u32 supp_flags,
+						   const u32 ctrl_flags,
+						   struct netlink_ext_ack *extack)
+{
+	if (likely((ctrl_flags & ~supp_flags) == 0))
+		return true;
+
+	NL_SET_ERR_MSG_FMT_MOD(extack,
+			       "Unsupported match on control.flags %#x",
+			       ctrl_flags);
+
+	return false;
+}
+
+/**
+ * flow_rule_has_control_flags() - check for presence of any control flags
+ * @ctrl_flags: control flags present in rule
+ * @extack: The netlink extended ACK for reporting errors.
+ *
+ * @returns true if control flags are set, false otherwise.
+ */
+static inline bool flow_rule_has_control_flags(const u32 ctrl_flags,
+					       struct netlink_ext_ack *extack)
+{
+	return !flow_rule_is_supp_control_flags(0, ctrl_flags, extack);
+}
+
+/**
+ * flow_rule_match_has_control_flags() - match and check for any control flags
+ * @rule: The flow_rule under evaluation.
+ * @extack: The netlink extended ACK for reporting errors.
+ *
+ * @returns true if control flags are set, false otherwise.
+ */
+static inline bool flow_rule_match_has_control_flags(struct flow_rule *rule,
+						     struct netlink_ext_ack *extack)
+{
+	struct flow_match_control match;
+
+	if (!flow_rule_match_key(rule, FLOW_DISSECTOR_KEY_CONTROL))
+		return false;
+
+	flow_rule_match_control(rule, &match);
+
+	return flow_rule_has_control_flags(match.mask->flags, extack);
+}
+
 struct flow_stats {
 	u64	pkts;
 	u64	bytes;
-- 
2.43.0



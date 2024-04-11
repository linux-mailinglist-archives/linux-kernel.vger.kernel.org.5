Return-Path: <linux-kernel+bounces-140287-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 892CA8A124A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 12:54:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CFB20B21193
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 10:54:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C4CD147C7C;
	Thu, 11 Apr 2024 10:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="j/bq5ZU1"
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAC991448F3;
	Thu, 11 Apr 2024 10:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712832826; cv=none; b=MzzUIpf8adl5EDsc6fKPUotcZSSyDes+fkqfn6KC4bMujGAhRXIxDMEbPVl5BRlA6EaCa7OieumIEraWYyZ6EU5/FnNwfhV/MiT85s7XbIRv2ZWkc4QjobrZQnVsJoOrHrOEkqyA75e3pZJEkOTGm0cmqqXXXHzUpvK7bqISgSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712832826; c=relaxed/simple;
	bh=AfyMjC1FaXvd5ToX0H0wu1qi+kPBVGLrisweV0XUBhU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VUoh2qKbZYmmyWMD0OjyEFoAqf65xIjhjYfmpExt5n4VbNxqbOJ5KTC/JNqdyCMsRtA9mCOiu9E8qhA8Deou9U1CZD0LCV6PWWbEMoGkziy57C5TxmMLiNF0ztr6EygP+0W4LYzB+OkdnJR7PU+YSxX6EK5sJhR7prSdcOFzGu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=j/bq5ZU1; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id 5AE81600A7;
	Thu, 11 Apr 2024 10:53:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1712832815;
	bh=AfyMjC1FaXvd5ToX0H0wu1qi+kPBVGLrisweV0XUBhU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=j/bq5ZU1DnUqAvGRx9YasD/ShxugeonrPd1pqcorXBPi8htKPbVKoUhPAZtxTbF5q
	 qFnORG89W2FeaP5hqUBASXAnqngSqIIYqLyei+5aB/gsI8BA6ROkvm0Ehm0GenLzah
	 l1Eubm4+r/1F869vJMd+CkMLs1RzF0gRT92vQ5Jdcu2A0nOoeTe8meQAE4PbA/MSK1
	 DqHTCQy1iybywUsGRgnR+vzWx+bvraGf1X13Q+CvIbIQuxkqOy2SLq2Rq7BLEpAV5C
	 MfK7VeuVBpfPoV/AzydqnLL5B+4hNywzOnB8qecakZcqN1lP9Bju8iOlY5B0mdKVfl
	 obk8Z0ECFyfrg==
Received: by x201s (Postfix, from userid 1000)
	id A69B020EF2F; Thu, 11 Apr 2024 10:53:14 +0000 (UTC)
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
Subject: [PATCH net-next v3 1/4] flow_offload: add control flag checking helpers
Date: Thu, 11 Apr 2024 10:52:54 +0000
Message-ID: <20240411105302.112091-2-ast@fiberby.net>
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
Reviewed-by: Louis Peens <louis.peens@corigine.com>
---
 include/net/flow_offload.h | 55 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/include/net/flow_offload.h b/include/net/flow_offload.h
index 314087a5e1818..0e3d3dc332e47 100644
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
+ * Return: true if only supported control flags are set, false otherwise.
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
+ * Return: true if control flags are set, false otherwise.
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
+ * Return: true if control flags are set, false otherwise.
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



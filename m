Return-Path: <linux-kernel+bounces-135410-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E059489C0EF
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 15:15:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1EE9D1C21EE5
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 13:15:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2610A8612E;
	Mon,  8 Apr 2024 13:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="XKiMNFGu"
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1451A8287E;
	Mon,  8 Apr 2024 13:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712581852; cv=none; b=vAmqs946y4r8VWXDVWZLPXLjZ4Wr9NrvCkgfiK8YOA2QpL8HIU67en+B2/5qF9XmaBKsHcLhbO15bR1QpFbgNj+ACyYTFOY0t7XvSilGaR5/zoOYYRFGj08hKgoFqUHQvaVdBxZyAaK+X/2aEy0cWxquOlIZiUgDfV5hCtI6mAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712581852; c=relaxed/simple;
	bh=zFYXy7e8s/QlamSDHv94nVwNKIb1xplVZBX1CbE7gOE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GoJ1cb94IZxwd0fae24zs2CPkj7E9Wt2ZSliUxFQvV8GEPyrjhgQ6kvasx6BxDyp3G4YuGRljh6hpjCQSp96hwwk51fvjFa4yAIWgDk82SkYxHELGt2mJ5ExxMOiL027aTBYoYQ12yeDRzXrmE1wbk7ssaGDLsiA8J3FDAzaOZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=XKiMNFGu; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id 0D759600E4;
	Mon,  8 Apr 2024 13:10:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1712581839;
	bh=zFYXy7e8s/QlamSDHv94nVwNKIb1xplVZBX1CbE7gOE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XKiMNFGueMuNqCMKTV63pCJxCZxxleMEpb1sOBtrfvbu3RkHkd98yAcSXevzhlBE6
	 IwtgYvpdrl6EApvlHatUy6iE5IM61P3ezoctXTNGDpIBwTtUqP+/N/sW2iz4onZU1y
	 ROVOrBqugZHnGdcjK3WsLQRZz+KOOv5qm9Bw/6zBQq4CUcfquMC50ExcoUqWvN3FVk
	 ikbMqEwrBzr0z0UhtQytv5Nku9hJmcf4QJQnomL3Ua3arT36iR28JcHL8UdYsnk93j
	 ths7grC8D8oS2ewQ9Z6aMN57c9RSt4zP60fGT6gyNOnXGbszENd21WPz6R/UMyZJ+L
	 /S3nftHH4Hq4A==
Received: by x201s (Postfix, from userid 1000)
	id 38AFC202005; Mon, 08 Apr 2024 13:09:38 +0000 (UTC)
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
Subject: [PATCH net-next 1/6] flow_offload: add flow_rule_no_unsupp_control_flags()
Date: Mon,  8 Apr 2024 13:09:19 +0000
Message-ID: <20240408130927.78594-2-ast@fiberby.net>
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

This helper can be used by drivers to check for the
presence of unsupported control flags.

It mirrors the existing check done in sfc:
  drivers/net/ethernet/sfc/tc.c +276

This is aimed at drivers, which implements some control flags.

This should also be used by drivers that implement all
current flags, so that future flags will be unsupported
by default.

Only compile-tested.

Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>
---
 include/net/flow_offload.h | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/include/net/flow_offload.h b/include/net/flow_offload.h
index 314087a5e1818..c1317b14da08c 100644
--- a/include/net/flow_offload.h
+++ b/include/net/flow_offload.h
@@ -449,6 +449,28 @@ static inline bool flow_rule_match_key(const struct flow_rule *rule,
 	return dissector_uses_key(rule->match.dissector, key);
 }
 
+/**
+ * flow_rule_no_unsupp_control_flags() - check for unsupported control flags
+ * @supp_flags: flags supported by driver
+ * @flags: flags present in rule
+ * @extack: The netlink extended ACK for reporting errors.
+ *
+ * Returns true if only supported control flags are set, false otherwise.
+ */
+static inline bool flow_rule_no_unsupp_control_flags(const u32 supp_flags,
+						     const u32 flags,
+						     struct netlink_ext_ack *extack)
+{
+	if (likely((flags & ~supp_flags) == 0))
+		return true;
+
+	NL_SET_ERR_MSG_FMT_MOD(extack,
+			       "Unsupported match on control.flags %#x",
+			       flags);
+
+	return false;
+}
+
 struct flow_stats {
 	u64	pkts;
 	u64	bytes;
-- 
2.43.0



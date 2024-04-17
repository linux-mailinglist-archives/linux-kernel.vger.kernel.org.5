Return-Path: <linux-kernel+bounces-148714-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEE1A8A8685
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 16:48:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF3A81C20BF9
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 14:48:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1E3014534A;
	Wed, 17 Apr 2024 14:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="QThZoPil"
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39D8A13D2B5;
	Wed, 17 Apr 2024 14:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713365078; cv=none; b=llWFLFRHbA05ywr+pykORXFVuVB98JaTlKoK8f4QQYfZ+YV5t1sbaCnPorjQM+mPPeXviicfHw3SCBGxLiRUnah6C3eVSmczs/TUgFXK61jWYQfxO7XxtP6D2Jupz5HuxuAOjQteTSeyXfeTsDIf/KaOHCof2NcbrcuVLqrt/pU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713365078; c=relaxed/simple;
	bh=AeYBqsRbD+pAB5pvLNzFZd3L+Nbnsjq7CIGHuwOaTis=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZyHXOFdcDLaascYLFhZ0GfmCN32x5+N8J2MXMNbao5UTsZCqD7eEyXyD13BRcBFH2R3/rgPhO/B6Obc75IBPJ7FmI00nnH3FXZLEOI1uFeXPR/p3YqYpa/rGbpDXclfYQVl8oWgpjJzrc6QBQyjQeYcStetWKpGZbhz3dQn0Bb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=QThZoPil; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id 71F2A600A5;
	Wed, 17 Apr 2024 14:44:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1713365073;
	bh=AeYBqsRbD+pAB5pvLNzFZd3L+Nbnsjq7CIGHuwOaTis=;
	h=From:To:Cc:Subject:Date:From;
	b=QThZoPil5H/vtZMfqxYS0DzWhwCduWXsOjJrQLRYmzk8qMLywjAohzNVX4Biu0Zw2
	 DooQDy0PUa//4YrDX306ecM17QXgv2EsHEKcrDWWYa8nBBKg2a4tKSOO16FZj9m6KM
	 aRgmHZcXYTJzaTATBsOK9ckVpyvYFwJB3V29rdy2BfxVjQLOJP0Mf3iN4PrlylmA6m
	 EyunO6p3V+6kQCRgzM7qui5PFJ+MT4gNuaizFaww0ssrba1mdKjc6wM60Yj5ApgLXC
	 VIvjGNxrRJzIgXgI549PxFPFoOab1qTljYvtPABtX3SBJSQmtB+rhXmg2bBp+sbz9b
	 qPpuvt6Zqk5Mg==
Received: by x201s (Postfix, from userid 1000)
	id B2168204CF2; Wed, 17 Apr 2024 14:44:13 +0000 (UTC)
From: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>
To: netdev@vger.kernel.org
Cc: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>,
	linux-kernel@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>
Subject: [PATCH net-next] net: dsa: sja1105: flower: validate control flags
Date: Wed, 17 Apr 2024 14:44:12 +0000
Message-ID: <20240417144413.104257-1-ast@fiberby.net>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This driver currently doesn't support any control flags.

Use flow_rule_match_has_control_flags() to check for control flags,
such as can be set through `tc flower ... ip_flags frag`.

In case any control flags are masked, flow_rule_match_has_control_flags()
sets a NL extended error message, and we return -EOPNOTSUPP.

Only compile-tested.

Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>
---
 drivers/net/dsa/sja1105/sja1105_flower.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/dsa/sja1105/sja1105_flower.c b/drivers/net/dsa/sja1105/sja1105_flower.c
index 9e8ca182c722..05d8ed3121e7 100644
--- a/drivers/net/dsa/sja1105/sja1105_flower.c
+++ b/drivers/net/dsa/sja1105/sja1105_flower.c
@@ -214,6 +214,9 @@ static int sja1105_flower_parse_key(struct sja1105_private *priv,
 		return -EOPNOTSUPP;
 	}
 
+	if (flow_rule_match_has_control_flags(rule, extack))
+		return -EOPNOTSUPP;
+
 	if (flow_rule_match_key(rule, FLOW_DISSECTOR_KEY_BASIC)) {
 		struct flow_match_basic match;
 
-- 
2.43.0



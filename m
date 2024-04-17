Return-Path: <linux-kernel+bounces-148716-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B80C8A8689
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 16:49:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0600A2827C5
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 14:49:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 410D3140E5E;
	Wed, 17 Apr 2024 14:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="T2Aa33Gw"
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39E1C1422DD;
	Wed, 17 Apr 2024 14:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713365081; cv=none; b=HpwTiTGs17N0QJbLUF+CIiYUBhbHINucuifLaP7FkUlQuTZ/D3NCMNKKjNPChCDsrvX1GWanIqZvSMNZZ+djJ0F86e6xxVLwFQ7/5MBJ13diKLaPHdPeD+QIGwD3aVVKSHNzIkVaSbdYXp0iGQ4OXxwApvf4Cs7QN/HFaq+9UPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713365081; c=relaxed/simple;
	bh=rrJ7n75EIyuAFCln7lBnBkC5hjWcPtbZH17TwmJZfvE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gJ7Vhse8bqnQRJ6hvSfzmcHsSWDic80JkZC19boShMLv/O7tsDZWsczpDwm5vT9nKIuKP7VncnvpKg3r5hJ2HlrYj12hVW9Tfp/2L8uXj9JUnNWoqvsm2+0PJQNPWvOL9d+XCAkSMfpWHauGj5OCPc00Lb9fP9r0Fd8SG9VyzIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=T2Aa33Gw; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id 39A52600A7;
	Wed, 17 Apr 2024 14:44:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1713365075;
	bh=rrJ7n75EIyuAFCln7lBnBkC5hjWcPtbZH17TwmJZfvE=;
	h=From:To:Cc:Subject:Date:From;
	b=T2Aa33Gw170VjuixaQ5ondCPu5fmMT4KbChRGTbnOrl9HGBSlwN8bMipdWEnzeGF9
	 /6uDM5L6xmBiguy0tpZwAxBT5L35uZDTUNAsmIpyFM0VFhfiuAUwc8j+qqfv2afAhk
	 zB13JBSq0zyXzI8pCtZsvAuTyoNLfbisT7H29H5XuwUV820FtsYVVcaVOCQhsLt1CC
	 25EfJu3KTF3B5jhPmxSeCUmGuqGGbbThTdKxncSjSoSCb54sCTQ65ERN7eDFNchtRb
	 /FZLdstYO8ppkdLhCBVC1LzQwxKhR7A1J6/JOjWiwQA9KgkGr5i9ZRPWevtqzTpLrA
	 v+bpDFPCzv0ww==
Received: by x201s (Postfix, from userid 1000)
	id BA137203AC4; Wed, 17 Apr 2024 14:44:00 +0000 (UTC)
From: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>
To: netdev@vger.kernel.org
Cc: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>,
	linux-kernel@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	UNGLinuxDriver@microchip.com
Subject: [PATCH net-next] net: mscc: ocelot: flower: validate control flags
Date: Wed, 17 Apr 2024 14:43:58 +0000
Message-ID: <20240417144359.104225-1-ast@fiberby.net>
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
 drivers/net/ethernet/mscc/ocelot_flower.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/mscc/ocelot_flower.c b/drivers/net/ethernet/mscc/ocelot_flower.c
index 33b438c6aec5..a057ec3dab97 100644
--- a/drivers/net/ethernet/mscc/ocelot_flower.c
+++ b/drivers/net/ethernet/mscc/ocelot_flower.c
@@ -609,11 +609,8 @@ ocelot_flower_parse_key(struct ocelot *ocelot, int port, bool ingress,
 			return ret;
 	}
 
-	if (flow_rule_match_key(rule, FLOW_DISSECTOR_KEY_CONTROL)) {
-		struct flow_match_control match;
-
-		flow_rule_match_control(rule, &match);
-	}
+	if (flow_rule_match_has_control_flags(rule, extack))
+		return -EOPNOTSUPP;
 
 	if (flow_rule_match_key(rule, FLOW_DISSECTOR_KEY_VLAN)) {
 		struct flow_match_vlan match;
-- 
2.43.0



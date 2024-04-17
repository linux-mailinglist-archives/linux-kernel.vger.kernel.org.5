Return-Path: <linux-kernel+bounces-148715-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC0498A8687
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 16:48:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67B53283F0C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 14:48:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97196145B1F;
	Wed, 17 Apr 2024 14:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="IJdd2bTY"
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72966140E5E;
	Wed, 17 Apr 2024 14:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713365078; cv=none; b=kK0WRYjTfMp3axc5Bwn67yfKbn4HwX8D6uYeDBSeQMBdqbMSzlGNQfn6GQWBMd4iKpzoU5Xz5CEIz7Y0GcRdC7WIIePqVLKvHiEmkgJQ91DTuJc60cNZlHMzgSGKZApsmmYcgJBlf6ZGesk43xsUWF8TQpvzlk8y3V45a4d3nnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713365078; c=relaxed/simple;
	bh=eyPztPGpoTcAfA8TrZ2aBkQkDvbE2JrkMRHX1Zzaf+M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pqbtJYecnYNOMc76b2a8nWxXxlG2mQzJei7ng1NtLVE8jVkTfyN500OmY/gBPovV54xbTu7orJuCSzPvBPuPLPjzdEU8jGKOqE/OSC5BIBP1QBbAJtKKwAvuWI0591SwZJVcV2oopHGE7L9MOVYg4kAsMxNKu5Vl/b4M2hzZG5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=IJdd2bTY; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id 35A16600A2;
	Wed, 17 Apr 2024 14:44:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1713365075;
	bh=eyPztPGpoTcAfA8TrZ2aBkQkDvbE2JrkMRHX1Zzaf+M=;
	h=From:To:Cc:Subject:Date:From;
	b=IJdd2bTYgL2RcCYJgrqL9cT1WC2KFNEtOT9s7v/I7gTpElCE1HiD9F9yIwZphQKch
	 LHN5o5e1tgjxad7b5YBONDdQn6R9sy+QOSBQSAYRzkceakGq+XZAusNgLtjTKyx3Kg
	 AGivZTv33klrZW2J/JanfMfv9euwsBPlRh0t/DIeZYKZGjv/Z7FMzpB48TDR1l/RFN
	 0xwqMdXmyErKO7538i8k4E9CIFZEwZ9of2Ki+MMxjUWMpHnQfXAMVwPJ7AuDK56SzY
	 SjNkDckWMc/ahv/3yxlmZVe+6UwnGzrCFuS2jm8sbcRbi9XVvlDnKh32GuyW1dRMCl
	 8uKH/uASey2GA==
Received: by x201s (Postfix, from userid 1000)
	id 8955720445E; Wed, 17 Apr 2024 14:44:07 +0000 (UTC)
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
	UNGLinuxDriver@microchip.com,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>
Subject: [PATCH net-next] net: dsa: felix: flower: validate control flags
Date: Wed, 17 Apr 2024 14:44:06 +0000
Message-ID: <20240417144407.104241-1-ast@fiberby.net>
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
 drivers/net/dsa/ocelot/felix_vsc9959.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/dsa/ocelot/felix_vsc9959.c b/drivers/net/dsa/ocelot/felix_vsc9959.c
index 3c5509e75a54..85952d841f28 100644
--- a/drivers/net/dsa/ocelot/felix_vsc9959.c
+++ b/drivers/net/dsa/ocelot/felix_vsc9959.c
@@ -1755,6 +1755,9 @@ static int vsc9959_stream_identify(struct flow_cls_offload *f,
 	      BIT_ULL(FLOW_DISSECTOR_KEY_ETH_ADDRS)))
 		return -EOPNOTSUPP;
 
+	if (flow_rule_match_has_control_flags(rule, f->common.extack))
+		return -EOPNOTSUPP;
+
 	if (flow_rule_match_key(rule, FLOW_DISSECTOR_KEY_ETH_ADDRS)) {
 		struct flow_match_eth_addrs match;
 
-- 
2.43.0



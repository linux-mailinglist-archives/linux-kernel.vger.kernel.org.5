Return-Path: <linux-kernel+bounces-135409-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E56789C0EB
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 15:15:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CBB8285BBB
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 13:15:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50D917BAEC;
	Mon,  8 Apr 2024 13:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="qteOSczA"
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1455C8287F;
	Mon,  8 Apr 2024 13:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712581851; cv=none; b=MtooxkWxZE9nMYd60FtkVa/X7asiazVFhJiXtdUxnbdrIRRKfWEfjI99KAwx3eHXG1WNaB5DVU173vgU09/KaBbK2NEmUsldzpcTARa41qnWPYjviHqnoVDz5TQjTtvTbXJOhYFv74HDJuWtylk9CckvTKhcsN+KHKDT+0p0SKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712581851; c=relaxed/simple;
	bh=JhvINSSfLvE52ybLOuVuFxGqHxUcIIr9GHOMoeqR5HE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NLKF/atzBxakNeTAd2YCihYAprBEWt2/nLg91CJ0Kn1r2eD2UUoXvG4knhfs6Ya37sr10xbfTgXNSB6OImHtH3lIqT6YIhNd08If1lKTR6r84k+OdELMZsc5Uh4QoICWXlDWPPaGUUuB+9dcCoXTh8qhENcEQ1j7FNs8YYzC5+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=qteOSczA; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id 0D636600DC;
	Mon,  8 Apr 2024 13:10:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1712581839;
	bh=JhvINSSfLvE52ybLOuVuFxGqHxUcIIr9GHOMoeqR5HE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qteOSczAIRp0V/v8WSLj6CEOq5SgEreq1kGNOFJntvW4CKBugjgEoTbmq1BX41Nn/
	 Xaf96Zb6YaMmb/tyGAnXmaLp7SBnoBic75LpSqLSpvD7LQIww0ckQYLE3m6r3pbuaa
	 fJPgSORUvEosFWgNJNE2mJIKC1Fif20T36t/L5HMdV8bB7UUZONLPpzsY2IcYiUkap
	 ZIANjIueZ4utUx4ZpAya0WsTxnF9mfl7blxTnGOqOSaiesr3e6I7Jxixii2T8Tq0/x
	 hhgc4S1KyhVje2+1ZAWrIY9kYw4CmcwoEQmkitMgY5Kcvt30YJKM27rANXsFcRruFO
	 jIlJ7FFto5x5A==
Received: by x201s (Postfix, from userid 1000)
	id 33287204CF2; Mon, 08 Apr 2024 13:09:39 +0000 (UTC)
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
Subject: [PATCH net-next 2/6] nfp: flower: fix check for unsupported control flags
Date: Mon,  8 Apr 2024 13:09:20 +0000
Message-ID: <20240408130927.78594-3-ast@fiberby.net>
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

Use flow_rule_no_unsupp_control_flags()

Check the mask, not the key, for unsupported control flags.

Only compile-tested, no access to HW

Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>
---
 drivers/net/ethernet/netronome/nfp/flower/offload.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/netronome/nfp/flower/offload.c b/drivers/net/ethernet/netronome/nfp/flower/offload.c
index 0aceef9fe5826..bc7d7c7e68efb 100644
--- a/drivers/net/ethernet/netronome/nfp/flower/offload.c
+++ b/drivers/net/ethernet/netronome/nfp/flower/offload.c
@@ -527,10 +527,10 @@ nfp_flower_calculate_key_layers(struct nfp_app *app,
 		struct flow_match_control ctl;
 
 		flow_rule_match_control(rule, &ctl);
-		if (ctl.key->flags & ~NFP_FLOWER_SUPPORTED_CTLFLAGS) {
-			NL_SET_ERR_MSG_MOD(extack, "unsupported offload: match on unknown control flag");
+
+		if (!flow_rule_no_unsupp_control_flags(NFP_FLOWER_SUPPORTED_CTLFLAGS,
+						       ctl.mask->flags, extack))
 			return -EOPNOTSUPP;
-		}
 	}
 
 	ret_key_ls->key_layer = key_layer;
-- 
2.43.0



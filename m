Return-Path: <linux-kernel+bounces-140288-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C50008A124B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 12:54:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02C531C21A4C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 10:54:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33DE7147C97;
	Thu, 11 Apr 2024 10:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="mX2+yU/K"
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEDC81448EF;
	Thu, 11 Apr 2024 10:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712832826; cv=none; b=orN6d5IXPf9uQOqlbFvJ+IuLWDhBXgYGkXlcmq5L/wz752VP4P2mmN4YdByKcp/HOyuWsQr2u863k+Ai1SjdNcSeZHGdZiR2JNFLiGHgRC4OEcBhglIk9O/FXU+FqoY2cOHj0Tmq1VoYxScJFIzap1/dhe0cXJf6ef+zR6qbizA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712832826; c=relaxed/simple;
	bh=9YVU8sC5lyA2gQoDE2b9psBJEuL/8EhzWJnh02ASQX0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T0mSIPynRKm7Nq90TGiyAHmfZsW7RUSEUt4X1o+Bn7lBf9CyGqCsazZZ6A2heM18lv8irzNHAGkQHe5yRZoCmIf2oLn87OsIyIe/4re+eZGn0BBG7kdnY4Gvk0/cnamz5R6gpCvrkH8h5XpjYnOkTeiAzDhT9Bx2aBDnMkIKv3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=mX2+yU/K; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id 5875D600A5;
	Thu, 11 Apr 2024 10:53:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1712832815;
	bh=9YVU8sC5lyA2gQoDE2b9psBJEuL/8EhzWJnh02ASQX0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mX2+yU/KhoZUmwWalHJVw5OA5QOwvXERX7UUuRxvkKcd+M4ngWuItmyAm9Rme0kX8
	 Y+jBSnLqD2LUQyIM9h7YvBypjvZRm/mL3MIwUHg3awRXZaluEBH4xa8syaZtsvu5q7
	 95YD2pt3FA+AMDikecxoccUaK7/Q09KzUW1kisK2qMBJRVPYu16KuqRHucq5LO1fhW
	 kjWUTBObSERTb3eBNV6UCHf3mvpHAk7vfX2Ol1jZkNIZnTMgg+xGxpScIZAt2x31jZ
	 w13KJwT2NoHn/LN1lQil3qkhe8TM8Sv2nNTyMc7E6edZGifOnK/O89AQn1o4GCmTvH
	 LUZwMoUMy09tA==
Received: by x201s (Postfix, from userid 1000)
	id B817D20EF33; Thu, 11 Apr 2024 10:53:15 +0000 (UTC)
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
Subject: [PATCH net-next v3 2/4] nfp: flower: fix check for unsupported control flags
Date: Thu, 11 Apr 2024 10:52:55 +0000
Message-ID: <20240411105302.112091-3-ast@fiberby.net>
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

Use flow_rule_is_supp_control_flags()

Check the mask, not the key, for unsupported control flags.

Only compile-tested, no access to HW

Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>
Reviewed-by: Louis Peens <louis.peens@corigine.com>
---
 drivers/net/ethernet/netronome/nfp/flower/offload.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/netronome/nfp/flower/offload.c b/drivers/net/ethernet/netronome/nfp/flower/offload.c
index 0aceef9fe5826..8e0a890381b60 100644
--- a/drivers/net/ethernet/netronome/nfp/flower/offload.c
+++ b/drivers/net/ethernet/netronome/nfp/flower/offload.c
@@ -527,10 +527,10 @@ nfp_flower_calculate_key_layers(struct nfp_app *app,
 		struct flow_match_control ctl;
 
 		flow_rule_match_control(rule, &ctl);
-		if (ctl.key->flags & ~NFP_FLOWER_SUPPORTED_CTLFLAGS) {
-			NL_SET_ERR_MSG_MOD(extack, "unsupported offload: match on unknown control flag");
+
+		if (!flow_rule_is_supp_control_flags(NFP_FLOWER_SUPPORTED_CTLFLAGS,
+						     ctl.mask->flags, extack))
 			return -EOPNOTSUPP;
-		}
 	}
 
 	ret_key_ls->key_layer = key_layer;
-- 
2.43.0



Return-Path: <linux-kernel+bounces-117972-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D406D88B1ED
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 21:48:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F6A02967AC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 20:48:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DDDB82D7E;
	Mon, 25 Mar 2024 20:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bzz8tOQg"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5AC26BFCC;
	Mon, 25 Mar 2024 20:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711399516; cv=none; b=S5/90m4ZQHCo8m88JpZZmIRTCNkhnnr1+kWRNe8Zxx558e2PHrLkjhY00OhVs+Qj9OT1C81WLZsiiTVsJxd0nhOK5UQvmcLNBLYrvqUZR/x7chOGIyPV83GNO3b1CTEb4OvcZQ5Z8iX57yCAPfUsw0fghgyOX6t4KDWYvJ3e5LQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711399516; c=relaxed/simple;
	bh=9j8ww96xZAA5t61iUhYjOuJc3n9ckfgsgyCrBkegL5k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SzuEpzPAAvUBzrbDyP9kxZgUlfq5fx0PvTG1DJI6zXfgvW82jHXXtc6Jo7mUUNjYbXN8MIwc81kbw0Pw+MHRk+SOpBWzZrvhlmTeF3361ey+pDznGcuLyNUOk+DELz5qlG0g4YDRkX8ZCd1cKYAibv9PRnqEVv8bjGzigI13FGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bzz8tOQg; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-56829f41f81so5953662a12.2;
        Mon, 25 Mar 2024 13:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711399513; x=1712004313; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xmYDYlHI8ubyZLeGylt14fi0GeBgKPGuFj2fUHhgPug=;
        b=bzz8tOQgbFcPqF8XrHBCmLVxLlDknG+p8R2DFP2upmdGpa1yoX4NOW609IjCGlNwue
         pCJ5Fc8fiskXkWRi4Ixn9PTsPJGaX6ST4xTpwQYmyDYs2fdvn0c/duqMk2WaTxFRlhqd
         qdAmZhrDtzIIHhqKLrnYtiip9AIFTD3zZNRMMv4H8oWw8O3aJM8Q+6gBns0paXeHMqSF
         NmgUR79W6WFmz4nDl2oy0ijtDs6YQXj4+qqAqE8J8Psn1gw9lKcnzyb7TfKLA8zd9dBY
         f74n+iLQd9zDRMk0dp8wvd8ONu9m+UXkS8QK6u2W60Kx3gC7SUTOILhG7DYoXLftIKRg
         FsdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711399513; x=1712004313;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xmYDYlHI8ubyZLeGylt14fi0GeBgKPGuFj2fUHhgPug=;
        b=uHEgnXG5KvcX31SoCDRStWDuZdgsYdXC4yiP/E0X5WC6uLH8IFAZ+YwkJtR353cnKI
         FaUS7X+co+2qSbpdtc5slzbl9ipioJOb8mFSImlMCneECYANdvs82Y3QIkCk8+7OyqOI
         /pYZwxg3/j75eYnWvfFVPPhFTwDPIlCA9OrCOkaJJLveESfKJm6F57mPK/n7KmLbaooy
         OfTpj5FskfrTgWicZZBa9m+lWWE7S9A03ipqShEDnbu5kARDSXsKnEq27M9lHIYbI+OC
         mFVgFqeca1cOoEnRT+k+auoR8G9W3IcFQYQr79UUAab0rT74+pYdXThDIpqeL4LLZtld
         CXIA==
X-Forwarded-Encrypted: i=1; AJvYcCWr/r0+MxC9tp9QsddcJ6xHhWJboz5u562gi5ewcD5WKqWOkW9nCg+KVRhpDuq+XnEAXMHIm+P76SvgmKI1sc1PQOL1RlWLJuLR5YmD
X-Gm-Message-State: AOJu0YwRs4+9nazjgw8CaMMVx4jMtaeFY7ccwxK9hmP4hS67VTlvFsk8
	lynQm+2/ANr2CSXaL5Pi86+KAe4TtmGBsTDTcs4GfyVAadnvF7S0wFnKW3lzlR4=
X-Google-Smtp-Source: AGHT+IGpSBRJGdEtwVg2BGsj6lCELQXGqhgg6sM7D+rniqQ5qW7RIVrx4u71WsaPgyE5xoHwd3zGiQ==
X-Received: by 2002:aa7:d8d8:0:b0:56c:26f4:bfe9 with SMTP id k24-20020aa7d8d8000000b0056c26f4bfe9mr297540eds.27.1711399512922;
        Mon, 25 Mar 2024 13:45:12 -0700 (PDT)
Received: from WBEC325.dom.lan ([185.188.71.122])
        by smtp.gmail.com with ESMTPSA id k18-20020a056402049200b0056c1cba8480sm591751edv.25.2024.03.25.13.45.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 13:45:12 -0700 (PDT)
From: Pawel Dembicki <paweldembicki@gmail.com>
To: netdev@vger.kernel.org
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Simon Horman <horms@kernel.org>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Pawel Dembicki <paweldembicki@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	UNGLinuxDriver@microchip.com,
	Russell King <linux@armlinux.org.uk>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v7 10/16] net: dsa: tag_sja1105: prefer precise source port info on SJA1110 too
Date: Mon, 25 Mar 2024 21:43:35 +0100
Message-Id: <20240325204344.2298241-11-paweldembicki@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240325204344.2298241-1-paweldembicki@gmail.com>
References: <20240325204344.2298241-1-paweldembicki@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Vladimir Oltean <vladimir.oltean@nxp.com>

Now that dsa_8021q_rcv() handles better the case where we don't
overwrite the precise source information if it comes from an external
(non-tag_8021q) source, we can now unify the call sequence between
sja1105_rcv() and sja1110_rcv().

This is a preparatory change for creating a higher-level wrapper for the
entire sequence which will live in tag_8021q.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>
---
v7,v6,v5:
  - resend only
v4:
  - introduce patch and replace 'slave' with 'conduit' after rebase

 net/dsa/tag_sja1105.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/dsa/tag_sja1105.c b/net/dsa/tag_sja1105.c
index 7639ccb94d35..35a6346549f2 100644
--- a/net/dsa/tag_sja1105.c
+++ b/net/dsa/tag_sja1105.c
@@ -652,12 +652,12 @@ static struct sk_buff *sja1110_rcv(struct sk_buff *skb,
 	if (likely(sja1105_skb_has_tag_8021q(skb)))
 		dsa_8021q_rcv(skb, &source_port, &switch_id, &vbid, &vid);
 
-	if (vbid >= 1)
+	if (source_port != -1 && switch_id != -1)
+		skb->dev = dsa_conduit_find_user(netdev, switch_id, source_port);
+	else if (vbid >= 1)
 		skb->dev = dsa_tag_8021q_find_port_by_vbid(netdev, vbid);
-	else if (source_port == -1 || switch_id == -1)
-		skb->dev = dsa_find_designated_bridge_port_by_vid(netdev, vid);
 	else
-		skb->dev = dsa_conduit_find_user(netdev, switch_id, source_port);
+		skb->dev = dsa_find_designated_bridge_port_by_vid(netdev, vid);
 	if (!skb->dev) {
 		netdev_warn(netdev, "Couldn't decode source port\n");
 		return NULL;
-- 
2.34.1



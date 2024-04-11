Return-Path: <linux-kernel+bounces-140290-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DD6F8A124D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 12:54:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F0502833B1
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 10:54:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A589D148FF7;
	Thu, 11 Apr 2024 10:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="FE0s0iX7"
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2871E140E3C;
	Thu, 11 Apr 2024 10:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712832827; cv=none; b=q0Q8D0lScb7b1yHu25zGm5a+5HptxEts0Y4EdJIpOohmEr1yeacYWdRH+tWIK0fQEgSxL5QEhBgHgCHs9hbo0EgSlfvD+4a602JxYhu7Okxq1doNIEyaGlKbNiF0wTJsDXVVezRH/5m+EtX/M5dG3wwiq74SnO2UHHndeEcaz/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712832827; c=relaxed/simple;
	bh=Sy9vwHM9lL5sKyKFDT+sqtrTgE6HSdTNapyCUyx55lE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=vDkkv1/Ug+xA+GMXr/TZIaJgxwWjk+WKsOJhT2drdzylzBIx/E2fBgrxE3gdWnTBhqplGeJknGokVAQw9HiFwW2CqweCvuzS+ss1ggvVpo6kcUHAUr9znWdVaEHkP1WbcjjA1+WTNj75AmjKgb+BDkz/qPSbn/eaJxH/uo+D2yM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=FE0s0iX7; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id 6293D600A9;
	Thu, 11 Apr 2024 10:53:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1712832815;
	bh=Sy9vwHM9lL5sKyKFDT+sqtrTgE6HSdTNapyCUyx55lE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FE0s0iX7zfOIYHPXs42ynIILdQ6X+cBY/6D9s+2ACqgR/LBQAwRAYxrpoLAz6Dspt
	 Y0kPsGL3LwzsgVKQ6ertwd69M2HUevzEMopa8vmY2L8bukT87K9xr3Kx700+Xajwyh
	 0ZGSx6vAu/ua/ULEZzko76gRaB64aJbRWotkzen8AImRa1QmwdwFIIaq1E1hxCZdAT
	 ewJWmeGCLZdGBUrao5uM2JkotYK2VMiRNhxeGxsOBAqkFZcliQ+cYdYhutwhsG94cS
	 5sZhdsZDH0fLkTojE2KMYYUxKcNib+7aBZQnB/GmhI8/jJIM8eHfs9J8kC04MhIxgw
	 9Mzn9WJuUYwrw==
Received: by x201s (Postfix, from userid 1000)
	id BE2F120EF37; Thu, 11 Apr 2024 10:53:16 +0000 (UTC)
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
Subject: [PATCH net-next v3 3/4] net: prestera: flower: validate control flags
Date: Thu, 11 Apr 2024 10:52:56 +0000
Message-ID: <20240411105302.112091-4-ast@fiberby.net>
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

Add check for unsupported control flags.

Only compile-tested, no access to HW.

Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>
---
 drivers/net/ethernet/marvell/prestera/prestera_flower.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/marvell/prestera/prestera_flower.c b/drivers/net/ethernet/marvell/prestera/prestera_flower.c
index 8b9455d8a4f7a..418101a931490 100644
--- a/drivers/net/ethernet/marvell/prestera/prestera_flower.c
+++ b/drivers/net/ethernet/marvell/prestera/prestera_flower.c
@@ -229,6 +229,10 @@ static int prestera_flower_parse(struct prestera_flow_block *block,
 
 		flow_rule_match_control(f_rule, &match);
 		addr_type = match.key->addr_type;
+
+		if (flow_rule_has_control_flags(match.mask->flags,
+						f->common.extack))
+			return -EOPNOTSUPP;
 	}
 
 	if (flow_rule_match_key(f_rule, FLOW_DISSECTOR_KEY_BASIC)) {
-- 
2.43.0



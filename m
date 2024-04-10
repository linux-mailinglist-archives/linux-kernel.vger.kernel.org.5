Return-Path: <linux-kernel+bounces-138262-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FF5089EEEE
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 11:33:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A1388B2495C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 09:33:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0823B157E9B;
	Wed, 10 Apr 2024 09:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="lgqOwKCG"
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EFEC13D2BC;
	Wed, 10 Apr 2024 09:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712741581; cv=none; b=VuqdmwNvncZiBhjkPMh8JtQ+nJHMizEQoyagW+SXjpzB+RvxAhgSvyno8eF8ID+vo0U7z5wMdULqrZhP8sDMGL/r6xCVPAWmDePO6CKKefv898kMQE9BTN3gwnHltmAGgkyJpwu3pcEyZSjy7aOhNU3IsVSBO1I8fagmn6qqvq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712741581; c=relaxed/simple;
	bh=Sy9vwHM9lL5sKyKFDT+sqtrTgE6HSdTNapyCUyx55lE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t/xsjQiZQ1jwLKfnKPhoCU3zxGEh5HzYJIV01+fKFCFFOnZBe+Yqlah5HqUuSinlUoq0XucTEqfw8Hfj6YySUZ//bxvxi0Gjb8YKWYoTjLW0VFnaao4T+FmiVSYLJeQzQzk7TeUwjZFqPFXnsWXJQqds2LoBmgv2p0tNwKv4ogg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=lgqOwKCG; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id BB988600A2;
	Wed, 10 Apr 2024 09:32:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1712741570;
	bh=Sy9vwHM9lL5sKyKFDT+sqtrTgE6HSdTNapyCUyx55lE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lgqOwKCGYCz7hpXThum89aLbSSV/nTzdyP1VEpjeM0gkNX07wTOf/DfxsSKfBXfEG
	 rhsLEEFaRfFLhmmL4Zhh4xtw5HDGYlK2Fl/50HvVf82/aurZLpigO30ewKtO+2ZBFI
	 f7OOtXjRXtyCXnmcRAw9bLmLiIyDZ0I+oFGQbLbLpf0LI0pQ50MOHEWFHVSDoB61rJ
	 aZvAJ3wtJIW50SOZ3JmH65wpRNzl8fonQDKZV6f4R2M9ZvgmbG+7TJEp8rmDXO7G5/
	 mJsFNdY4sNRzriq0Ir0vEGcW++2qGAGgwoPZQhQzQg7Nm7kMWpd9bF3tfMv82gQfQJ
	 wkhVCdxjdu4IQ==
Received: by x201s (Postfix, from userid 1000)
	id EB91020BDE4; Wed, 10 Apr 2024 09:32:40 +0000 (UTC)
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
Subject: [PATCH net-next v2 3/4] net: prestera: flower: validate control flags
Date: Wed, 10 Apr 2024 09:32:24 +0000
Message-ID: <20240410093235.5334-4-ast@fiberby.net>
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



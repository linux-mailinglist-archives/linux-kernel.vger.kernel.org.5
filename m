Return-Path: <linux-kernel+bounces-135424-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D93E589C217
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 15:26:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9F519B25D2A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 13:24:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 218F8823AE;
	Mon,  8 Apr 2024 13:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="Gkp+lPA1"
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1144E81754;
	Mon,  8 Apr 2024 13:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712582415; cv=none; b=uydI1X2bS4ds1Al7uDVqLIGffnlRR2TIQA9emJ8J0i+Oq8UjzrINHHCr3hOSyhIAJns+HTJNyM9XY+lNCSTPvagpbZ2jCFOUye3BMOF/YMza6RBIUY6ojbK9615L+OpNCzqZ2ZeHHZYC7K4oLLNHN9gwSnPm+rM0yMstXT/MhlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712582415; c=relaxed/simple;
	bh=NQlO1jgsVllyqjrKVAx0V+IBXpfLP2/7zeKLGvcmncY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ygur8/1PQR+bpnyrp/gSgO8EJpFQm1cSE5neAHWbrswD9lVpobLHjvtrWke3VM6+IoYQtxrBcjcO6QmE5RmfKgzGYiqLt0GOuwOsObdOgJ3XTRBOXgiMw8OgF3IEwzZMGES4IHf0rj1QNtyyBJ5EMXvQnLv0+cpZreXKRkfxzCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=Gkp+lPA1; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id 8E9C0600AF;
	Mon,  8 Apr 2024 13:10:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1712581838;
	bh=NQlO1jgsVllyqjrKVAx0V+IBXpfLP2/7zeKLGvcmncY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Gkp+lPA16aDUfsw0EDjURxoxWbcqt1X/Sf1wfddELRWDfzqvTQ5/WhCiOJHS/SLXI
	 YsANT4PVAnjTBzu20h/0Ex/RX2HHVSrguydZepBs9gbh+j1sJxOuHArPzeFmE+wYO/
	 kaR2fA2kGH/CouPssyceK5eumXTQb/zzgQGl7NyvE5Wd+PC4s56NGxxPlHLqc10T1i
	 UPfRYL06BJaXTHeJRuoNMlwJCsdwa9jflF/NuJuuZtKguh27H31Z6dhM8VXiLuTHyh
	 KzKTCtoeJkgoBmhcDxqIYLnfH36wlc53dcMcOCLzm6h/CH5cgSfySCjFQyJeuBsO+m
	 FOVEwS3cX/L7Q==
Received: by x201s (Postfix, from userid 1000)
	id EC22120B99F; Mon, 08 Apr 2024 13:09:40 +0000 (UTC)
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
Subject: [PATCH net-next 4/6] net: prestera: flower: validate control flags
Date: Mon,  8 Apr 2024 13:09:22 +0000
Message-ID: <20240408130927.78594-5-ast@fiberby.net>
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

Add check for unsupported control flags.

Only compile-tested, no access to HW.

Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>
---
 drivers/net/ethernet/marvell/prestera/prestera_flower.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/marvell/prestera/prestera_flower.c b/drivers/net/ethernet/marvell/prestera/prestera_flower.c
index 8b9455d8a4f7a..075aed847913d 100644
--- a/drivers/net/ethernet/marvell/prestera/prestera_flower.c
+++ b/drivers/net/ethernet/marvell/prestera/prestera_flower.c
@@ -229,6 +229,10 @@ static int prestera_flower_parse(struct prestera_flow_block *block,
 
 		flow_rule_match_control(f_rule, &match);
 		addr_type = match.key->addr_type;
+
+		if (!flow_rule_no_control_flags(match.mask->flags,
+						f->common.extack))
+			return -EOPNOTSUPP;
 	}
 
 	if (flow_rule_match_key(f_rule, FLOW_DISSECTOR_KEY_BASIC)) {
-- 
2.43.0



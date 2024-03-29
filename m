Return-Path: <linux-kernel+bounces-124658-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73A70891B18
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 14:17:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC8F6289756
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 13:17:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 953E116D9BA;
	Fri, 29 Mar 2024 12:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ot06NQDM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D34DE1420C4;
	Fri, 29 Mar 2024 12:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711715647; cv=none; b=F/88jDu6xxzZDTKCS4BjNXReQmJgtWPwdZ7wSATyk9/KAwD02ep/k9kbUVTnpHF3XsDvwAWs91E1WUGGxPTpb04tTZSfs9kLchD6OIGGTQPhyicJOve1yazhflfyyKGB77p+n/s3gCTf/GMV9noA+mpd8NrQ+tJmx3R5t09msQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711715647; c=relaxed/simple;
	bh=WXr6Pj9tx3rS/dc47u7x06zimCghNHXN33j+WnQrsX4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Wr90zMjNRcNmy0I46c1wUbRnTipqfor9EtCiIqqRIeeIw/XYweKPJa5tDeYRa+1ABW+TzlVpib3H8GhLpl2r+40uPVem2ZAGFP+2DFxCICsi1Jn36Af97dl0SRxbyQ2BHx25lmC79VhGYLfcaRSZxuOXYJy3G/8WTA36jnBBCC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ot06NQDM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 490A2C433C7;
	Fri, 29 Mar 2024 12:34:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711715647;
	bh=WXr6Pj9tx3rS/dc47u7x06zimCghNHXN33j+WnQrsX4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ot06NQDMzmi3vqtLMyGBH5K2rladNJqwNGG9eiypg5FLZcHBiX4TuEsf6yyRV/rmD
	 J5+I7BdnJFOao82nMfU3iJ9Oo8idp5DlbKP2wp9ib6AeiC1C8A+Tocg0E4TANxodeI
	 w0zAfjDp2f/RbVSepm6F5wdrezxcFAvSvma2/8LCr5+FPIZOVFNh3FbNJleMN8+1Rg
	 kfXoVE4TaWiPwXQl0JK52B89gohlfvdvhDP3t4XLQfgcnSYmX9uo+Bx4UT64f6t/uv
	 yR9I1OrcQeGK8WE0NAzcO7A6nmV13cn+O36j6Nn7K8N7KHJeHLtqcYAX8NgV+F9EyA
	 aJuoYjWNeaI7Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Markus Elfring <elfring@users.sourceforge.net>,
	Sven Eckelmann <sven@narfation.org>,
	Simon Wunderlich <sw@simonwunderlich.de>,
	Sasha Levin <sashal@kernel.org>,
	mareklindner@neomailbox.ch,
	a@unstable.cc,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	b.a.t.m.a.n@lists.open-mesh.org,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 02/17] batman-adv: Return directly after a failed batadv_dat_select_candidates() in batadv_dat_forward_data()
Date: Fri, 29 Mar 2024 08:33:41 -0400
Message-ID: <20240329123405.3086155-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329123405.3086155-1-sashal@kernel.org>
References: <20240329123405.3086155-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.214
Content-Transfer-Encoding: 8bit

From: Markus Elfring <elfring@users.sourceforge.net>

[ Upstream commit ffc15626c861f811f9778914be004fcf43810a91 ]

The kfree() function was called in one case by
the batadv_dat_forward_data() function during error handling
even if the passed variable contained a null pointer.
This issue was detected by using the Coccinelle software.

* Thus return directly after a batadv_dat_select_candidates() call failed
  at the beginning.

* Delete the label “out” which became unnecessary with this refactoring.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
Acked-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/batman-adv/distributed-arp-table.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/batman-adv/distributed-arp-table.c b/net/batman-adv/distributed-arp-table.c
index ddd3b4c70a516..b1cb6ecffceb9 100644
--- a/net/batman-adv/distributed-arp-table.c
+++ b/net/batman-adv/distributed-arp-table.c
@@ -687,7 +687,7 @@ static bool batadv_dat_forward_data(struct batadv_priv *bat_priv,
 
 	cand = batadv_dat_select_candidates(bat_priv, ip, vid);
 	if (!cand)
-		goto out;
+		return ret;
 
 	batadv_dbg(BATADV_DBG_DAT, bat_priv, "DHT_SEND for %pI4\n", &ip);
 
@@ -731,7 +731,6 @@ static bool batadv_dat_forward_data(struct batadv_priv *bat_priv,
 		batadv_orig_node_put(cand[i].orig_node);
 	}
 
-out:
 	kfree(cand);
 	return ret;
 }
-- 
2.43.0



Return-Path: <linux-kernel+bounces-124696-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A6A38891B84
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 14:26:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A4D4291A2E
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 13:26:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E10F4174EDC;
	Fri, 29 Mar 2024 12:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GyLg1Qbn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CD58174EC9;
	Fri, 29 Mar 2024 12:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711715725; cv=none; b=nxh6vttoYLgHbysWR3vwC6PmLLvTcbXCpi2x1Gv6Xifqck3nqxdse3PxrYUReiRCu8eb9sQqwQZ1I0YY+Rsjp+waM7fM1Zv1jE2Wbk/NEGlUZEheqfHRLMDMrvaNqgy4/jhscDRXhbcNFipi/XWk8wZ5b2H0/KVRxhJ2kmsAQ8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711715725; c=relaxed/simple;
	bh=PmkpG9xyozHyIEXJIgQk0WwwHU4/pWTCqDE1hBXAblc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KUoPyb9GEZkIhL6iffXwc1Zt0V7AIZV2a8E4vvvgOmzkufUOwcqdJWFxQTOopC4QD5+kRYmObvrJ3PfqKnHAIPxR798fIAbSIh4AhCxFLO8cnYtETjPx0mDEe8q/UpagCNTsW/XV1tD+khLAzsqwOOa7QskOP09zCqbxmEROBZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GyLg1Qbn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B332C43390;
	Fri, 29 Mar 2024 12:35:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711715724;
	bh=PmkpG9xyozHyIEXJIgQk0WwwHU4/pWTCqDE1hBXAblc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GyLg1Qbn/tS+uk3ErVBnZIiPXcy9HFQ9vkP1x0KVDkNmUtp8pq+fbkunDPN7O4eQq
	 uD0TWBljWne22qX6VPe+QdG6fDtrZP1pNCSFZCMK9yEI9jTmcetbAEQi9vdmHpuQXs
	 JYR0+lQ79cnI3cPXgdqoff2oKmW5flDv7Y4vD9M3Rjv0rbU5VqL/+/7TyYflIq6RcU
	 Rf2YWskOR13E/2qhPhHXAL45fqU9zSMreQ3km+PKDtf5K+6+OQvPVouRK3gQKHlnRY
	 +3CLn9+J3UAEgtw5Am2tBjjIUNgk4W1tOKu4hv9oRalef3zVyQjRmNwtGe8rDKP3fz
	 E2dT4kR2RXHBA==
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
Subject: [PATCH AUTOSEL 4.19 02/11] batman-adv: Return directly after a failed batadv_dat_select_candidates() in batadv_dat_forward_data()
Date: Fri, 29 Mar 2024 08:35:08 -0400
Message-ID: <20240329123522.3086878-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329123522.3086878-1-sashal@kernel.org>
References: <20240329123522.3086878-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.19.311
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
index af380dc877e31..6930d414138e1 100644
--- a/net/batman-adv/distributed-arp-table.c
+++ b/net/batman-adv/distributed-arp-table.c
@@ -648,7 +648,7 @@ static bool batadv_dat_send_data(struct batadv_priv *bat_priv,
 
 	cand = batadv_dat_select_candidates(bat_priv, ip, vid);
 	if (!cand)
-		goto out;
+		return ret;
 
 	batadv_dbg(BATADV_DBG_DAT, bat_priv, "DHT_SEND for %pI4\n", &ip);
 
@@ -692,7 +692,6 @@ static bool batadv_dat_send_data(struct batadv_priv *bat_priv,
 		batadv_orig_node_put(cand[i].orig_node);
 	}
 
-out:
 	kfree(cand);
 	return ret;
 }
-- 
2.43.0



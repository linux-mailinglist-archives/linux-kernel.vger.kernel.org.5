Return-Path: <linux-kernel+bounces-124554-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D81678919D9
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 13:48:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D307B224DF
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 12:48:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 307B014D453;
	Fri, 29 Mar 2024 12:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YflT/8jx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F34914D436;
	Fri, 29 Mar 2024 12:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711715402; cv=none; b=Nur+1QMVAzZE4nmWkrT4AuKhfVezFSyYEf2Eec0zsEtWpevzJjYmBik9z2xRqGa6oM1HbYrTY+lm2noumgTepDreJoztrY5ldcpWI6LEvFcP+jnyXWxzvT03/MVoZvAnp954FelRiH/DDx9ZoXa6nAvEe52tEMTvFJ5ta1qKahI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711715402; c=relaxed/simple;
	bh=SEsbnjgbOnrUNykRPC13YRzmbgzyK5QZUYeQcKRJKlk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ud5cajeCuBe75w/O9AD+Tl2lNllJncxtEmvvWUMxQnQL9BWhJWyc4r+LyVdSYEL4O/guPB8uyTRSw/XvZh7enyDSfJy6L3KjlnS9VCvtigifRcqrpuxmZ+u58e1gpbKn2DAgg1tjneuGwSPeh2H3d/7Riq6k/r3x2JrmOpMIEyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YflT/8jx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97AE6C433F1;
	Fri, 29 Mar 2024 12:30:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711715402;
	bh=SEsbnjgbOnrUNykRPC13YRzmbgzyK5QZUYeQcKRJKlk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YflT/8jxM6MGfJOgoUZoJ1UwsYDf180IGE0/mSLLhSaB3PoXM+U33YxAidGT5FrqN
	 denjly5YprdUg0xTv5nsz1QkQqYcqHeS2E5kiKR9dfSQEdvxMSvdaqbqXrRbjlsFkh
	 NPbEUdFx4ukhMNE97kGHvS2TtweGAp3EDGimkpS18khAlmmLC1JIUyBOr5tP6JcFSK
	 Fdx3r8Zcw+TAITn6ZBmTIDn3qHT2QhArQ0Gcpkgj7C7F/WfBFXBDg5+ON/VFVPHfo4
	 XLYbLfqj7QRoy0FZ1EFDOQxdp2SngAG0V91126+E6L57YIA0Cu6dOWR1niApMo/3Rk
	 Rk7fzaeN+A+LQ==
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
Subject: [PATCH AUTOSEL 6.6 04/52] batman-adv: Return directly after a failed batadv_dat_select_candidates() in batadv_dat_forward_data()
Date: Fri, 29 Mar 2024 08:28:34 -0400
Message-ID: <20240329122956.3083859-4-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329122956.3083859-1-sashal@kernel.org>
References: <20240329122956.3083859-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.23
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
index 28a939d560906..4c7e855343245 100644
--- a/net/batman-adv/distributed-arp-table.c
+++ b/net/batman-adv/distributed-arp-table.c
@@ -684,7 +684,7 @@ static bool batadv_dat_forward_data(struct batadv_priv *bat_priv,
 
 	cand = batadv_dat_select_candidates(bat_priv, ip, vid);
 	if (!cand)
-		goto out;
+		return ret;
 
 	batadv_dbg(BATADV_DBG_DAT, bat_priv, "DHT_SEND for %pI4\n", &ip);
 
@@ -728,7 +728,6 @@ static bool batadv_dat_forward_data(struct batadv_priv *bat_priv,
 		batadv_orig_node_put(cand[i].orig_node);
 	}
 
-out:
 	kfree(cand);
 	return ret;
 }
-- 
2.43.0



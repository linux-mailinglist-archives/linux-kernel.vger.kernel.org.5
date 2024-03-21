Return-Path: <linux-kernel+bounces-110038-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D92CC885932
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 13:35:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9400B284BB7
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 12:35:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA7E183CB6;
	Thu, 21 Mar 2024 12:35:38 +0000 (UTC)
Received: from new-mail.astralinux.ru (new-mail.astralinux.ru [51.250.53.244])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE9521CA98;
	Thu, 21 Mar 2024 12:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.250.53.244
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711024538; cv=none; b=mDz48pPcd6PMrByqM634gXy+nBqGlb9vJorr1dvkNFIqjI/ldjK0f71tg8pVpDudKjxsAD1c61txGYShnACCJD2EFKbJyYnxSvhHH5Ay+zigxHZ+f/VeDmQFh3Da1Ni9JjevIxe0YsNzy/aiQ/nt0D4OafCIXKV/bs6LZ3+JL6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711024538; c=relaxed/simple;
	bh=4TKY33L5OYoSI/i+t5Rf7IO4C2V8xKSF29Hm5DbaqXU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CLurwKlMXQXx1VVv6NVzBkh84CJLeuwEdBCoUnXiQzFzjsh/dOMi3DV+NlJSz9lrGZ4ScA/BPzLl6R4FTjBrxmaVLYLZdcuXtdYaUkM5gp/WVZ61zQKmW4bl0t3xydPAq1ldStePfXgAbEJKhu6pE6brI/cCg0s4NwshmAXZ4DY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=astralinux.ru; spf=pass smtp.mailfrom=astralinux.ru; arc=none smtp.client-ip=51.250.53.244
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=astralinux.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=astralinux.ru
Received: from rbta-msk-lt-106062.astralinux.ru (unknown [176.59.168.90])
	by new-mail.astralinux.ru (Postfix) with ESMTPA id 4V0lKt2Rb3zlVps;
	Thu, 21 Mar 2024 15:35:30 +0300 (MSK)
From: Anastasia Belova <abelova@astralinux.ru>
To: "David S. Miller" <davem@davemloft.net>
Cc: Anastasia Belova <abelova@astralinux.ru>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jiri Pirko <jiri@resnulli.us>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH v2] flow_dissector: prevent NULL pointer dereference in __skb_flow_dissect
Date: Thu, 21 Mar 2024 15:34:46 +0300
Message-Id: <20240321123446.7012-1-abelova@astralinux.ru>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <Zfrmv4u0tVcYGS5n@nanopsycho>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DrWeb-SpamScore: -100
X-DrWeb-SpamState: legit
X-DrWeb-SpamDetail: gggruggvucftvghtrhhoucdtuddrgedvfedrvdehuddgtddvucetufdoteggodetrfcurfhrohhfihhlvgemucfftfghgfeunecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeetnhgrshhtrghsihgruceuvghlohhvrgcuoegrsggvlhhovhgrsegrshhtrhgrlhhinhhugidrrhhuqeenucggtffrrghtthgvrhhnpeevhfduuefhueektdefkedvgfekgfekffegvdetffehfefhffejhfehveevudeigfenucffohhmrghinheplhhinhhugihtvghsthhinhhgrdhorhhgnecukfhppedujeeirdehledrudeikedrledtnecurfgrrhgrmhephhgvlhhopehrsghtrgdqmhhskhdqlhhtqddutdeitdeivddrrghsthhrrghlihhnuhigrdhruhdpihhnvghtpedujeeirdehledrudeikedrledtmeegfedvjeejpdhmrghilhhfrhhomheprggsvghlohhvrgesrghsthhrrghlihhnuhigrdhruhdpnhgspghrtghpthhtohepkedprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtoheprggsvghlohhvrgesrghsthhrrghlihhnuhigrdhruhdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehjihhrihesrhgvshhnuhhllhhirdhushdprhgtph
 htthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlvhgtqdhprhhojhgvtghtsehlihhnuhigthgvshhtihhnghdrohhrgh
X-DrWeb-SpamVersion: Vade Retro 01.423.251#02 AS+AV+AP Profile: DRWEB; Bailout: 300
X-AntiVirus: Checked by Dr.Web [MailD: 11.1.19.2307031128, SE: 11.1.12.2210241838, Core engine: 7.00.62.01180, Virus records: 12528158, Updated: 2024-Mar-21 10:27:40 UTC]

skb is an optional parameter, so it may be NULL.
Add check defore dereference in eth_hdr.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 690e36e726d0 ("net: Allow raw buffers to be passed into the flow dissector.")
Signed-off-by: Anastasia Belova <abelova@astralinux.ru>
---
 net/core/flow_dissector.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/core/flow_dissector.c b/net/core/flow_dissector.c
index 272f09251343..68a8228ffae3 100644
--- a/net/core/flow_dissector.c
+++ b/net/core/flow_dissector.c
@@ -1139,6 +1139,8 @@ bool __skb_flow_dissect(const struct net *net,
 
 	if (dissector_uses_key(flow_dissector,
 			       FLOW_DISSECTOR_KEY_ETH_ADDRS)) {
+		if (!skb)
+			goto out_bad;
 		struct ethhdr *eth = eth_hdr(skb);
 		struct flow_dissector_key_eth_addrs *key_eth_addrs;
 
-- 
2.30.2



Return-Path: <linux-kernel+bounces-108921-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 99D5E8811EF
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 13:57:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 472441F244ED
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 12:57:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0824240850;
	Wed, 20 Mar 2024 12:57:47 +0000 (UTC)
Received: from new-mail.astralinux.ru (new-mail.astralinux.ru [51.250.53.244])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F05B3FE4F;
	Wed, 20 Mar 2024 12:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.250.53.244
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710939466; cv=none; b=Z5Adb2nCmoAFzaHM5837C2oeSPLnBKI6qErbWc0g+BnvJ2QHdeEeqNjCLT+SxFvStjtWj5RxldnX7uUflEXGX0WLo98sPCBoyQ5A5jzJuHWz/6XKx2nmqD4AQ0i607PK9HsPLIBt275zoKVci6nVVAb+aFgT17rExK1OSbbTJC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710939466; c=relaxed/simple;
	bh=WNjA4RJDnjon5+pbZkJWvOEhagdQ0OkaB0NbNTEO9DU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fEqU/+FBzDluLHgFfwS1AnY8wTpLNBMwHbxlfR6siSSwLJGHG9ZS6vsVDGK8US4ReyGFv5EYfOQ+Y56wpjm7TXA+lasJcxw+AThsodyuKE6d0PcNU3vYLqQDrOva0lD9rPAxS7klJawzwGjAA33Q8qe/GbD1qN+F8o6XGG3Vemw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=astralinux.ru; spf=pass smtp.mailfrom=astralinux.ru; arc=none smtp.client-ip=51.250.53.244
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=astralinux.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=astralinux.ru
Received: from rbta-msk-lt-106062.astralinux.ru (unknown [176.59.54.140])
	by new-mail.astralinux.ru (Postfix) with ESMTPA id 4V07sh1r9KzlVq9;
	Wed, 20 Mar 2024 15:57:28 +0300 (MSK)
From: Anastasia Belova <abelova@astralinux.ru>
To: "David S. Miller" <davem@davemloft.net>
Cc: Anastasia Belova <abelova@astralinux.ru>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jiri Pirko <jiri@resnulli.us>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH] flow_dissector: prevent NULL pointer dereference in __skb_flow_dissect
Date: Wed, 20 Mar 2024 15:56:35 +0300
Message-Id: <20240320125635.1444-1-abelova@astralinux.ru>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DrWeb-SpamScore: -100
X-DrWeb-SpamState: legit
X-DrWeb-SpamDetail: gggruggvucftvghtrhhoucdtuddrgedvfedrvdehuddgtddvucetufdoteggodetrfcurfhrohhfihhlvgemucfftfghgfeunecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeetnhgrshhtrghsihgruceuvghlohhvrgcuoegrsggvlhhovhgrsegrshhtrhgrlhhinhhugidrrhhuqeenucggtffrrghtthgvrhhnpeffvddvueehvedvgfeivdeuvdduteeulefgfeehieffgfehtedutdfgveefvdeiheenucffohhmrghinheplhhinhhugihtvghsthhinhhgrdhorhhgnecukfhppedujeeirdehledrheegrddugedtnecurfgrrhgrmhephhgvlhhopehrsghtrgdqmhhskhdqlhhtqddutdeitdeivddrrghsthhrrghlihhnuhigrdhruhdpihhnvghtpedujeeirdehledrheegrddugedtmeefheekheehpdhmrghilhhfrhhomheprggsvghlohhvrgesrghsthhrrghlihhnuhigrdhruhdpnhgspghrtghpthhtohepkedprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtoheprggsvghlohhvrgesrghsthhrrghlihhnuhigrdhruhdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehjihhrihesrhgvshhnuhhllhhirdhushdprhgtphhtth
 hopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlvhgtqdhprhhojhgvtghtsehlihhnuhigthgvshhtihhnghdrohhrgh
X-DrWeb-SpamVersion: Vade Retro 01.423.251#02 AS+AV+AP Profile: DRWEB; Bailout: 300
X-AntiVirus: Checked by Dr.Web [MailD: 11.1.19.2307031128, SE: 11.1.12.2210241838, Core engine: 7.00.62.01180, Virus records: 12524175, Updated: 2024-Mar-20 11:10:12 UTC]

skb is an optional parameter, so it may be NULL.
Add check defore dereference in eth_hdr.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 67a900cc0436 ("flow_dissector: introduce support for Ethernet addresses")
Signed-off-by: Anastasia Belova <abelova@astralinux.ru>
---
 net/core/flow_dissector.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/flow_dissector.c b/net/core/flow_dissector.c
index 272f09251343..05db3a8aa771 100644
--- a/net/core/flow_dissector.c
+++ b/net/core/flow_dissector.c
@@ -1137,7 +1137,7 @@ bool __skb_flow_dissect(const struct net *net,
 		rcu_read_unlock();
 	}
 
-	if (dissector_uses_key(flow_dissector,
+	if (skb && dissector_uses_key(flow_dissector,
 			       FLOW_DISSECTOR_KEY_ETH_ADDRS)) {
 		struct ethhdr *eth = eth_hdr(skb);
 		struct flow_dissector_key_eth_addrs *key_eth_addrs;
-- 
2.30.2



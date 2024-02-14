Return-Path: <linux-kernel+bounces-65353-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BAA2854BBC
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 15:43:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A9ED1F232F9
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 14:43:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E7705A7A9;
	Wed, 14 Feb 2024 14:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="OYlFujES"
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6311F1CA80;
	Wed, 14 Feb 2024 14:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707921780; cv=none; b=HL7NSpIwhzvtf/yLWOAoJhPOSrot+ShN8ckTK2pH1ZEXm5RA+LskjtKsXPbq/swThwMLLdsmjipHbVqabBTv14ENBtdg0B57D6WgLfsa9p1n3q6gNKFH5KAaS63wc3oUM6aIPTMdWnAjw+SRm/jTRydqBBKRZeGiIQHa0SkbemM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707921780; c=relaxed/simple;
	bh=4kfKQXMjrSswVfEs9TFm2VCVbnaJe/UZ/yq2Vn1p9nU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qiNicJXrQUXfLRxGUNWokD+7C5Qar9UMDIqhJU1/AHboosyJbT72V6sackLB+iIeKLhoGJTdfVi3AHgHMjxD1T23MB7CHazafu0XiSh6Q6jbP1BNgVXhPhgWMbIu/hkFxohjJl3Zg0EnqZfeAIy/yUbo/fn8woPLxfA4lWv7ykU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=OYlFujES; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=rvZNAKQ9eQwBSXPdNcyqhFwbwKHStEKZIKN+cfFuE3Q=; b=OYlFujESUs6qcMYm3TB0qsFgH1
	4qwjrAoWPYH/dciAjcE6Hn6fX9jwiXsP4sUOf48wlY6/jsjHulI23+vBNjLybhqQWx1/weYpDoIav
	DoWZJukCKVywIlASoeoUj0CX+z2WznqrOnb/UfFyqJYsBRfGW7VaVXYEmT1Nj/UE5Kk0=;
Received: from p54ae9e7b.dip0.t-ipconnect.de ([84.174.158.123] helo=localhost.localdomain)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
	(Exim 4.94.2)
	(envelope-from <nbd@nbd.name>)
	id 1raGT6-00DWlk-Ky; Wed, 14 Feb 2024 15:42:36 +0100
From: Felix Fietkau <nbd@nbd.name>
To: netdev@vger.kernel.org,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Vlad Buslov <vladbu@nvidia.com>
Cc: Daniel Golle <daniel@makrotopia.org>,
	netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] netfilter: nf_tables: fix bidirectional offload regression
Date: Wed, 14 Feb 2024 15:42:35 +0100
Message-ID: <20240214144235.70341-1-nbd@nbd.name>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 8f84780b84d6 ("netfilter: flowtable: allow unidirectional rules")
made unidirectional flow offload possible, while completely ignoring (and
breaking) bidirectional flow offload for nftables.
Add the missing flag that was left out as an exercise for the reader :)

Cc: Vlad Buslov <vladbu@nvidia.com>
Fixes: 8f84780b84d6 ("netfilter: flowtable: allow unidirectional rules")
Reported-by: Daniel Golle <daniel@makrotopia.org>
Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 net/netfilter/nft_flow_offload.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/netfilter/nft_flow_offload.c b/net/netfilter/nft_flow_offload.c
index 397351fa4d5f..ab9576098701 100644
--- a/net/netfilter/nft_flow_offload.c
+++ b/net/netfilter/nft_flow_offload.c
@@ -361,6 +361,7 @@ static void nft_flow_offload_eval(const struct nft_expr *expr,
 		ct->proto.tcp.seen[1].flags |= IP_CT_TCP_FLAG_BE_LIBERAL;
 	}
 
+	__set_bit(NF_FLOW_HW_BIDIRECTIONAL, &flow->flags);
 	ret = flow_offload_add(flowtable, flow);
 	if (ret < 0)
 		goto err_flow_add;
-- 
2.43.0



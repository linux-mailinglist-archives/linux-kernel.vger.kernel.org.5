Return-Path: <linux-kernel+bounces-157019-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 550318B0B9F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 15:55:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1214F2868DB
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 13:55:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E34915EFA2;
	Wed, 24 Apr 2024 13:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZLZCny2u"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7862515ECE4
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 13:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713966885; cv=none; b=fVz6qreNk55x9e2lOPPrDMRy5wgZfawgaY8dE0FGzQm02RkyIN533DXQGXfzGOIu2gvHDGaxCBPYKW3yKjJT9x2grybl5sx3hb3MsmAquizTacVDtjwhnulnXxwwPWql0m46zmLzTuA8TMllzEsygVOMdA+0oTxb3ouNOLPuwu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713966885; c=relaxed/simple;
	bh=UOWkQ6MFWCBRbY+FwMYzxJ5JdvgUYAvrEWMlto0lo14=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DrpQ7lTT43+3PXfmeVJvNHauqbh4nH+L9g+jciVDr9sCjqCc1RLFqYTVlMLOQN5G4dPUafgZkFYSAGbts0HoULRVBa1LcrNA7ryv7GExIa08C1N1YPwARGEueUJEDmLU6oMw9/WB7921P+NJ6nvakvkAclpyY4YoLrx4DkBeoCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZLZCny2u; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713966883;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vikpMJxJ9Ds+2aUp1Td8HwJZsh9X5P4rCQC4urDpxnw=;
	b=ZLZCny2uQAklGJiyg5kS2mzXtlbML6HUnobY1aaKrNPmc811Sqmw8ev/bq3PjfWRsXIqUB
	yTPDiTlSuXfP/AB2pgqYWeOir3VbJm68KpTvp1kSoUrpvl7aItmfiBdWn78Dv5aExsBqpA
	bQ8hVGpVy67yrKmttOq/8R4BpivqgsM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-516-gdQN8hpGOlq2BtCoLX2ZrA-1; Wed, 24 Apr 2024 09:54:38 -0400
X-MC-Unique: gdQN8hpGOlq2BtCoLX2ZrA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 837FB834FEE;
	Wed, 24 Apr 2024 13:54:37 +0000 (UTC)
Received: from antares.redhat.com (unknown [10.39.193.98])
	by smtp.corp.redhat.com (Postfix) with ESMTP id A82F71C060D0;
	Wed, 24 Apr 2024 13:54:35 +0000 (UTC)
From: Adrian Moreno <amorenoz@redhat.com>
To: netdev@vger.kernel.org
Cc: aconole@redhat.com,
	echaudro@redhat.com,
	horms@kernel.org,
	i.maximets@ovn.org,
	Adrian Moreno <amorenoz@redhat.com>,
	Yotam Gigi <yotam.gi@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 3/8] net: psample: add user cookie
Date: Wed, 24 Apr 2024 15:50:50 +0200
Message-ID: <20240424135109.3524355-4-amorenoz@redhat.com>
In-Reply-To: <20240424135109.3524355-1-amorenoz@redhat.com>
References: <20240424135109.3524355-1-amorenoz@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7

Add a user cookie to the sample metadata so that sample emitters can
provide more contextual information to samples.

If present, send the user cookie in a new attribute:
PSAMPLE_ATTR_USER_COOKIE.

Signed-off-by: Adrian Moreno <amorenoz@redhat.com>
---
 include/net/psample.h        |  2 ++
 include/uapi/linux/psample.h |  1 +
 net/psample/psample.c        | 12 +++++++++++-
 3 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/include/net/psample.h b/include/net/psample.h
index 0509d2d6be67..2ac71260a546 100644
--- a/include/net/psample.h
+++ b/include/net/psample.h
@@ -25,6 +25,8 @@ struct psample_metadata {
 	   out_tc_occ_valid:1,
 	   latency_valid:1,
 	   unused:5;
+	const u8 *user_cookie;
+	u32 user_cookie_len;
 };
 
 struct psample_group *psample_group_get(struct net *net, u32 group_num);
diff --git a/include/uapi/linux/psample.h b/include/uapi/linux/psample.h
index 9d62983af0a4..83dc919c4023 100644
--- a/include/uapi/linux/psample.h
+++ b/include/uapi/linux/psample.h
@@ -19,6 +19,7 @@ enum {
 	PSAMPLE_ATTR_LATENCY,		/* u64, nanoseconds */
 	PSAMPLE_ATTR_TIMESTAMP,		/* u64, nanoseconds */
 	PSAMPLE_ATTR_PROTO,		/* u16 */
+	PSAMPLE_ATTR_USER_COOKIE,	/* binary, user provided data */
 
 	__PSAMPLE_ATTR_MAX
 };
diff --git a/net/psample/psample.c b/net/psample/psample.c
index f5f77515b969..476aaad7a885 100644
--- a/net/psample/psample.c
+++ b/net/psample/psample.c
@@ -480,7 +480,8 @@ void psample_sample_packet(struct psample_group *group, struct sk_buff *skb,
 		   nla_total_size(sizeof(u32)) +	/* group_num */
 		   nla_total_size(sizeof(u32)) +	/* seq */
 		   nla_total_size_64bit(sizeof(u64)) +	/* timestamp */
-		   nla_total_size(sizeof(u16));		/* protocol */
+		   nla_total_size(sizeof(u16)) +	/* protocol */
+		   nla_total_size(md->user_cookie_len);	/* user_cookie */
 
 #ifdef CONFIG_INET
 	tun_info = skb_tunnel_info(skb);
@@ -579,6 +580,15 @@ void psample_sample_packet(struct psample_group *group, struct sk_buff *skb,
 			goto error;
 	}
 #endif
+	if (md->user_cookie && md->user_cookie_len) {
+		int nla_len = nla_total_size(md->user_cookie_len);
+		struct nlattr *nla;
+
+		nla = skb_put(nl_skb, nla_len);
+		nla->nla_type = PSAMPLE_ATTR_USER_COOKIE;
+		nla->nla_len = nla_attr_size(md->user_cookie_len);
+		memcpy(nla_data(nla), md->user_cookie, md->user_cookie_len);
+	}
 
 	genlmsg_end(nl_skb, data);
 	psample_nl_obj_desc_init(&desc, group->group_num);
-- 
2.44.0



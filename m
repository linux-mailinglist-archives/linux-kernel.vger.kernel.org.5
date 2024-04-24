Return-Path: <linux-kernel+bounces-157021-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 20B798B0BA3
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 15:56:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 76690B26AD6
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 13:56:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F078F15EFA8;
	Wed, 24 Apr 2024 13:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GU1GAapl"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3F5B15EFD5
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 13:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713966891; cv=none; b=MG6O8dsRLusM2Y6Sw2Lc1GplBNA4KciyTWNnwv3AaKbucGBhNNn6nhLUiaPTYByY/qvcPicIIMCgkBRVjtg9dyC9Ehsa1nVyJpn+zuen/qig7PZDUUgG6qLkYdd6WqrFBIQp7sqFftC6gSCRFpeVyNFPYPPtk0//DgS9c5bz2B4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713966891; c=relaxed/simple;
	bh=n+RkZRic6ie2G6KEet41avGQwCdtOj5Z3lDU2WqxhVM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R3Y5BwxGPRp31dIAlDhuDwHF0SEZ6Hv21g0T7ae6jWXKLqAj06aw+NaKsHTxdCI5eo5xaxX0Q2Mhy+lM4p7uMXbC2xIYm08N68JyBo2aVhoDPVEWC80OWX77SRjV24//g8S3cjVJXQoVrKwPhtQPaW5EQsfoYvOPeOwQUjEFDKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GU1GAapl; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713966888;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LGEwg3DBg8RjmiswLmLzz0YVtT2CJ7TbhBWyCbgcMoQ=;
	b=GU1GAaplvtz3/85uOfSdzyVHg8m2UCr3sYA/a43HOfH3TRcBL+uqGR3WmmQM3lQ4i3XnDD
	TGgkyIqoOULGFFac1ZGPp03CZdiYDct0wI0+YUzNTiiF+BKwCnwWQB5lxkn3JoyqVpgw0X
	WN4cT+oG8LS9VauhSJvViroMdeW0YCc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-656-Vzx_EQ-XMa24eb4s9v5pQA-1; Wed, 24 Apr 2024 09:54:44 -0400
X-MC-Unique: Vzx_EQ-XMa24eb4s9v5pQA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EC52A104D537;
	Wed, 24 Apr 2024 13:54:43 +0000 (UTC)
Received: from antares.redhat.com (unknown [10.39.193.98])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 902EC1C060D0;
	Wed, 24 Apr 2024 13:54:41 +0000 (UTC)
From: Adrian Moreno <amorenoz@redhat.com>
To: netdev@vger.kernel.org
Cc: aconole@redhat.com,
	echaudro@redhat.com,
	horms@kernel.org,
	i.maximets@ovn.org,
	Adrian Moreno <amorenoz@redhat.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 5/8] net: sched: act_sample: add action cookie to sample
Date: Wed, 24 Apr 2024 15:50:52 +0200
Message-ID: <20240424135109.3524355-6-amorenoz@redhat.com>
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

If the action has a user_cookie, pass it along to the sample so it can
be easily identified.

Signed-off-by: Adrian Moreno <amorenoz@redhat.com>
---
 net/sched/act_sample.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/net/sched/act_sample.c b/net/sched/act_sample.c
index a69b53d54039..5c3f86ec964a 100644
--- a/net/sched/act_sample.c
+++ b/net/sched/act_sample.c
@@ -165,9 +165,11 @@ TC_INDIRECT_SCOPE int tcf_sample_act(struct sk_buff *skb,
 				     const struct tc_action *a,
 				     struct tcf_result *res)
 {
+	u8 cookie_data[TC_COOKIE_MAX_SIZE] = {};
 	struct tcf_sample *s = to_sample(a);
 	struct psample_group *psample_group;
 	struct psample_metadata md = {};
+	struct tc_cookie *user_cookie;
 	int retval;
 
 	tcf_lastuse_update(&s->tcf_tm);
@@ -189,6 +191,16 @@ TC_INDIRECT_SCOPE int tcf_sample_act(struct sk_buff *skb,
 		if (skb_at_tc_ingress(skb) && tcf_sample_dev_ok_push(skb->dev))
 			skb_push(skb, skb->mac_len);
 
+		rcu_read_lock();
+		user_cookie = rcu_dereference(a->user_cookie);
+		if (user_cookie) {
+			memcpy(cookie_data, user_cookie->data,
+			       user_cookie->len);
+			md.user_cookie = cookie_data;
+			md.user_cookie_len = user_cookie->len;
+		}
+		rcu_read_unlock();
+
 		md.trunc_size = s->truncate ? s->trunc_size : skb->len;
 		psample_sample_packet(psample_group, skb, s->rate, &md);
 
-- 
2.44.0



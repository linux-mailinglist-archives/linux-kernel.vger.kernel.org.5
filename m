Return-Path: <linux-kernel+bounces-157018-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 228C58B0B9D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 15:55:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 978441F22545
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 13:55:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ADDC15ECDE;
	Wed, 24 Apr 2024 13:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UBEzUrLY"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC2FC15E7EE
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 13:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713966882; cv=none; b=L4E0AWzk6af/PmLDHPrZqf5QDXa2ob4iFwXqKVN4fQBXYYVQ+yer0/6YiM/HemBSnU7i+s0p3d+xsc5MdTlkjKW6lQomHam+f/5RwSKInHF0/Ay+zlPucqX+iiKSgY0QZpsWuEylprd0pRTuL9a2HKVcbybynPMCwltYW+zFlCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713966882; c=relaxed/simple;
	bh=gxTGezLHWXY8b7sIhgnJbShbHkUHWXR6geF6I6OEDao=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qpr3Cm07VbxBIViC/UXZTUGqROv7hr/0daoaP0upqUf1SBkZhLhAIxNxLuDxi2VwAvIjJGhu63RWtfAeIY6QoN/3EZ98JOZ+KZrwhpfvG6aAEvfrJD5b19WnwhPkdBBnmY36IySFjVFzcFB1EY5kX2+M7ruDpBd3iR1VplbvbtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UBEzUrLY; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713966880;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mvfMKL+8UkJyc+6NdO80ILmMaNmzG0sr9rlaAL4MQIg=;
	b=UBEzUrLYP1KsCFrnT3zjqKBcErNlcII2ybg9kYZuWE1D9WXCpPYP6nMDljzrqdhSvAkgZL
	xPx76MNATkXz6G5gUG2WPzZbtZht3pWXUeqmIBATJVnc6MH7HZNHQAuQ3WQKecb2mD/SlV
	HsS18hsDTFvssmfqdBxqDW1L43ugV2o=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-651-tSYvXOl7N2OL-BBPH0PrrQ-1; Wed,
 24 Apr 2024 09:54:35 -0400
X-MC-Unique: tSYvXOl7N2OL-BBPH0PrrQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 148D73C0252B;
	Wed, 24 Apr 2024 13:54:35 +0000 (UTC)
Received: from antares.redhat.com (unknown [10.39.193.98])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 3B8881C0F120;
	Wed, 24 Apr 2024 13:54:33 +0000 (UTC)
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
Subject: [PATCH net-next 2/8] net: psample: add multicast filtering on group_id
Date: Wed, 24 Apr 2024 15:50:49 +0200
Message-ID: <20240424135109.3524355-3-amorenoz@redhat.com>
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

Packet samples can come from several places (e.g: different tc sample
actions), typically using the sample group (PSAMPLE_ATTR_SAMPLE_GROUP)
to differentiate them.

Likewise, sample consumers that listen on the multicast group may only
be interested on a single group. However, they are currently forced to
receive all samples and discard the ones that are not relevant, causing
unnecessary overhead.

Allow users to filter on the desired group_id by adding a new command
PSAMPLE_SET_FILTER that can be used to pass the desired group id.
Store this filter on the per-socket private pointer and use it for
filtering multicasted samples.

Signed-off-by: Adrian Moreno <amorenoz@redhat.com>
---
 include/uapi/linux/psample.h |   1 +
 net/psample/psample.c        | 110 +++++++++++++++++++++++++++++++++--
 2 files changed, 105 insertions(+), 6 deletions(-)

diff --git a/include/uapi/linux/psample.h b/include/uapi/linux/psample.h
index e585db5bf2d2..9d62983af0a4 100644
--- a/include/uapi/linux/psample.h
+++ b/include/uapi/linux/psample.h
@@ -28,6 +28,7 @@ enum psample_command {
 	PSAMPLE_CMD_GET_GROUP,
 	PSAMPLE_CMD_NEW_GROUP,
 	PSAMPLE_CMD_DEL_GROUP,
+	PSAMPLE_CMD_SET_FILTER,
 };
 
 enum psample_tunnel_key_attr {
diff --git a/net/psample/psample.c b/net/psample/psample.c
index a5d9b8446f77..f5f77515b969 100644
--- a/net/psample/psample.c
+++ b/net/psample/psample.c
@@ -98,13 +98,77 @@ static int psample_nl_cmd_get_group_dumpit(struct sk_buff *msg,
 	return msg->len;
 }
 
-static const struct genl_small_ops psample_nl_ops[] = {
+struct psample_obj_desc {
+	struct rcu_head rcu;
+	u32 group_num;
+};
+
+struct psample_nl_sock_priv {
+	struct psample_obj_desc __rcu *filter;
+	spinlock_t filter_lock; /* Protects filter. */
+};
+
+static void psample_nl_sock_priv_init(void *priv)
+{
+	struct psample_nl_sock_priv *sk_priv = priv;
+
+	spin_lock_init(&sk_priv->filter_lock);
+}
+
+static void psample_nl_sock_priv_destroy(void *priv)
+{
+	struct psample_nl_sock_priv *sk_priv = priv;
+	struct psample_obj_desc *filter;
+
+	filter = rcu_dereference_protected(sk_priv->filter, true);
+	kfree_rcu(filter, rcu);
+}
+
+static int psample_nl_set_filter_doit(struct sk_buff *skb,
+				      struct genl_info *info)
+{
+	struct psample_obj_desc *filter = NULL;
+	struct psample_nl_sock_priv *sk_priv;
+	struct nlattr **attrs = info->attrs;
+
+	if (attrs[PSAMPLE_ATTR_SAMPLE_GROUP]) {
+		filter = kzalloc(sizeof(*filter), GFP_KERNEL);
+		filter->group_num =
+			nla_get_u32(attrs[PSAMPLE_ATTR_SAMPLE_GROUP]);
+	}
+
+	sk_priv = genl_sk_priv_get(&psample_nl_family, NETLINK_CB(skb).sk);
+	if (IS_ERR(sk_priv)) {
+		kfree(filter);
+		return PTR_ERR(sk_priv);
+	}
+
+	spin_lock(&sk_priv->filter_lock);
+	filter = rcu_replace_pointer(sk_priv->filter, filter,
+				     lockdep_is_held(&sk_priv->filter_lock));
+	spin_unlock(&sk_priv->filter_lock);
+	kfree_rcu(filter, rcu);
+	return 0;
+}
+
+static const struct nla_policy
+psample_set_filter_policy[PSAMPLE_ATTR_SAMPLE_GROUP + 1] = {
+	[PSAMPLE_ATTR_SAMPLE_GROUP] = { .type = NLA_U32, },
+};
+
+static const struct genl_ops psample_nl_ops[] = {
 	{
 		.cmd = PSAMPLE_CMD_GET_GROUP,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
 		.dumpit = psample_nl_cmd_get_group_dumpit,
 		/* can be retrieved by unprivileged users */
-	}
+	},
+	{
+		.cmd		= PSAMPLE_CMD_SET_FILTER,
+		.doit		= psample_nl_set_filter_doit,
+		.policy		= psample_set_filter_policy,
+		.flags		= 0,
+	},
 };
 
 static struct genl_family psample_nl_family __ro_after_init = {
@@ -114,10 +178,13 @@ static struct genl_family psample_nl_family __ro_after_init = {
 	.netnsok	= true,
 	.module		= THIS_MODULE,
 	.mcgrps		= psample_nl_mcgrps,
-	.small_ops	= psample_nl_ops,
-	.n_small_ops	= ARRAY_SIZE(psample_nl_ops),
+	.ops		= psample_nl_ops,
+	.n_ops		= ARRAY_SIZE(psample_nl_ops),
 	.resv_start_op	= PSAMPLE_CMD_GET_GROUP + 1,
 	.n_mcgrps	= ARRAY_SIZE(psample_nl_mcgrps),
+	.sock_priv_size		= sizeof(struct psample_nl_sock_priv),
+	.sock_priv_init		= psample_nl_sock_priv_init,
+	.sock_priv_destroy	= psample_nl_sock_priv_destroy,
 };
 
 static void psample_group_notify(struct psample_group *group,
@@ -360,6 +427,32 @@ static int psample_tunnel_meta_len(struct ip_tunnel_info *tun_info)
 }
 #endif
 
+static inline void psample_nl_obj_desc_init(struct psample_obj_desc *desc,
+					    u32 group_num)
+{
+	memset(desc, 0, sizeof(*desc));
+	desc->group_num = group_num;
+}
+
+static int psample_nl_sample_filter(struct sock *dsk, struct sk_buff *skb,
+				    void *data)
+{
+	struct psample_obj_desc *desc = data;
+	struct psample_nl_sock_priv *sk_priv;
+	struct psample_obj_desc *filter;
+	int ret = 0;
+
+	rcu_read_lock();
+	sk_priv = __genl_sk_priv_get(&psample_nl_family, dsk);
+	if (!IS_ERR_OR_NULL(sk_priv)) {
+		filter = rcu_dereference(sk_priv->filter);
+		if (filter && desc)
+			ret = (filter->group_num != desc->group_num);
+	}
+	rcu_read_unlock();
+	return ret;
+}
+
 void psample_sample_packet(struct psample_group *group, struct sk_buff *skb,
 			   u32 sample_rate, const struct psample_metadata *md)
 {
@@ -370,6 +463,7 @@ void psample_sample_packet(struct psample_group *group, struct sk_buff *skb,
 #ifdef CONFIG_INET
 	struct ip_tunnel_info *tun_info;
 #endif
+	struct psample_obj_desc desc;
 	struct sk_buff *nl_skb;
 	int data_len;
 	int meta_len;
@@ -487,8 +581,12 @@ void psample_sample_packet(struct psample_group *group, struct sk_buff *skb,
 #endif
 
 	genlmsg_end(nl_skb, data);
-	genlmsg_multicast_netns(&psample_nl_family, group->net, nl_skb, 0,
-				PSAMPLE_NL_MCGRP_SAMPLE, GFP_ATOMIC);
+	psample_nl_obj_desc_init(&desc, group->group_num);
+	genlmsg_multicast_netns_filtered(&psample_nl_family,
+					 group->net, nl_skb, 0,
+					 PSAMPLE_NL_MCGRP_SAMPLE,
+					 GFP_ATOMIC, psample_nl_sample_filter,
+					 &desc);
 
 	return;
 error:
-- 
2.44.0



Return-Path: <linux-kernel+bounces-157022-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 43CDF8B0BA6
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 15:56:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC5521F22C3C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 13:56:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF2D815F414;
	Wed, 24 Apr 2024 13:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NiZ/p5LM"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE9FC15E1FD
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 13:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713966898; cv=none; b=a1tvg1ACDWgG/iFpLcwDtIMW5V02kgwM4yXnBPR9E+XpbUBalIp+RMYYxKUGphqhDJxUfyhJxRVzMUCMI9gAJqz8GVoQIJ7DSV92XK36i324wJU1GfUSLrrbXFY23ukqJTk4OZKh88Z5wArveOkYTTxnmof7zmOZtDz5pnqk3l0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713966898; c=relaxed/simple;
	bh=4NcjaWSsSdX3L3qcZFJzNNlvPctHO6umf9/Defd/OAY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=So70/0WW5HjyzuVgfGVruYR04ZCGRHC5jF2OGb+NsX143AL1sNaC9gozrNTW8LupiWOuh8LMcVs3o6fmwfD9FjNGEVNupOSJ2LfD5TBymXkA9i1oV4f05Qt9nCtxTzuFd1X0BI97PQ3VNXIck7hgO5YouAs5DYPcoqFrmePRxxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NiZ/p5LM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713966895;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jIPqwhfGK1wcmX33k6tBJ0wJeSbk/ZBhsvCTykKHqkw=;
	b=NiZ/p5LMl5oc1Feji6su5aDoau1p4c3taNE4LHw3Aa/KtaFY7ipY5nGB6/w2gO1SPcsqqy
	wyeXwiHNhTSrWEKHPeAuf16qIYjGLYoX2j6b2HU8pWmY7Db6uq3Y93F/gFk8SFe8DksA4B
	V7Qx8QQMktA7fjcV48o8w6BUaNVuIaQ=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-70-_LhlJPW2PiOSXqOiu7ySag-1; Wed,
 24 Apr 2024 09:54:51 -0400
X-MC-Unique: _LhlJPW2PiOSXqOiu7ySag-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 35ABB3C02B54;
	Wed, 24 Apr 2024 13:54:51 +0000 (UTC)
Received: from antares.redhat.com (unknown [10.39.193.98])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 1D8CE1C06798;
	Wed, 24 Apr 2024 13:54:48 +0000 (UTC)
From: Adrian Moreno <amorenoz@redhat.com>
To: netdev@vger.kernel.org
Cc: aconole@redhat.com,
	echaudro@redhat.com,
	horms@kernel.org,
	i.maximets@ovn.org,
	Adrian Moreno <amorenoz@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Pravin B Shelar <pshelar@ovn.org>,
	Donald Hunter <donald.hunter@gmail.com>,
	linux-kernel@vger.kernel.org,
	dev@openvswitch.org
Subject: [PATCH net-next 6/8] net:openvswitch: add psample support
Date: Wed, 24 Apr 2024 15:50:53 +0200
Message-ID: <20240424135109.3524355-7-amorenoz@redhat.com>
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

Add support for psample sampling via two new attributes to the
OVS_ACTION_ATTR_SAMPLE action.

OVS_SAMPLE_ATTR_PSAMPLE_GROUP used to pass an integer psample group_id.
OVS_SAMPLE_ATTR_PSAMPLE_COOKIE used to pass a variable-length binary
cookie that will be forwared to psample.

The maximum length of the user-defined cookie is set to 16, same as
tc_cookie, to discourage using cookies that will not be offloadable.

In order to simplify the internal processing of the action and given the
maximum size of the cookie is relatively small, add both fields to the
internal-only struct sample_arg.

The presence of a group_id mandates that the action shall called the
psample module to multicast the packet with such group_id and the
user-provided cookie if present. This behavior is orthonogal to
also executing the nested actions if present.

Signed-off-by: Adrian Moreno <amorenoz@redhat.com>
---
 Documentation/netlink/specs/ovs_flow.yaml |  6 ++
 include/uapi/linux/openvswitch.h          | 49 ++++++++++----
 net/openvswitch/actions.c                 | 51 +++++++++++++--
 net/openvswitch/flow_netlink.c            | 80 ++++++++++++++++++-----
 4 files changed, 153 insertions(+), 33 deletions(-)

diff --git a/Documentation/netlink/specs/ovs_flow.yaml b/Documentation/netlink/specs/ovs_flow.yaml
index 4fdfc6b5cae9..5543c2937225 100644
--- a/Documentation/netlink/specs/ovs_flow.yaml
+++ b/Documentation/netlink/specs/ovs_flow.yaml
@@ -825,6 +825,12 @@ attribute-sets:
         name: actions
         type: nest
         nested-attributes: action-attrs
+      -
+        name: psample_group
+        type: u32
+      -
+        name: psample_cookie
+        type: binary
   -
     name: userspace-attrs
     enum-name: ovs-userspace-attr
diff --git a/include/uapi/linux/openvswitch.h b/include/uapi/linux/openvswitch.h
index efc82c318fa2..e9cd6f3a952d 100644
--- a/include/uapi/linux/openvswitch.h
+++ b/include/uapi/linux/openvswitch.h
@@ -639,6 +639,7 @@ enum ovs_flow_attr {
 #define OVS_UFID_F_OMIT_MASK     (1 << 1)
 #define OVS_UFID_F_OMIT_ACTIONS  (1 << 2)
 
+#define OVS_PSAMPLE_COOKIE_MAX_SIZE 16
 /**
  * enum ovs_sample_attr - Attributes for %OVS_ACTION_ATTR_SAMPLE action.
  * @OVS_SAMPLE_ATTR_PROBABILITY: 32-bit fraction of packets to sample with
@@ -646,15 +647,27 @@ enum ovs_flow_attr {
  * %UINT32_MAX samples all packets and intermediate values sample intermediate
  * fractions of packets.
  * @OVS_SAMPLE_ATTR_ACTIONS: Set of actions to execute in sampling event.
- * Actions are passed as nested attributes.
+ * Actions are passed as nested attributes. Optional if
+ * OVS_SAMPLE_ATTR_PSAMPLE_GROUP is set.
+ * @OVS_SAMPLE_ATTR_PSAMPLE_GROUP: A 32-bit number to be used as psample group.
+ * Optional if OVS_SAMPLE_ATTR_ACTIONS is set.
+ * @OVS_SAMPLE_ATTR_PSAMPLE_COOKIE: A variable-length binary cookie that, if
+ * provided, will be copied to the psample cookie.
  *
- * Executes the specified actions with the given probability on a per-packet
- * basis.
+ * Either OVS_SAMPLE_ATTR_PSAMPLE_GROUP or OVS_SAMPLE_ATTR_ACTIONS must be
+ * specified.
+ *
+ * Executes the specified actions and/or sends the packet to psample
+ * with the given probability on a per-packet basis.
  */
 enum ovs_sample_attr {
 	OVS_SAMPLE_ATTR_UNSPEC,
-	OVS_SAMPLE_ATTR_PROBABILITY, /* u32 number */
-	OVS_SAMPLE_ATTR_ACTIONS,     /* Nested OVS_ACTION_ATTR_* attributes. */
+	OVS_SAMPLE_ATTR_PROBABILITY,	/* u32 number */
+	OVS_SAMPLE_ATTR_ACTIONS,	/* Nested OVS_ACTION_ATTR_
+					 * attributes.
+					 */
+	OVS_SAMPLE_ATTR_PSAMPLE_GROUP,	/* u32 number */
+	OVS_SAMPLE_ATTR_PSAMPLE_COOKIE,	/* binary */
 	__OVS_SAMPLE_ATTR_MAX,
 
 #ifdef __KERNEL__
@@ -665,13 +678,27 @@ enum ovs_sample_attr {
 #define OVS_SAMPLE_ATTR_MAX (__OVS_SAMPLE_ATTR_MAX - 1)
 
 #ifdef __KERNEL__
+
+/* Definition for flags in struct sample_arg. */
+enum {
+	/* When set, actions in sample will not change the flows. */
+	OVS_SAMPLE_ARG_FLAG_EXEC = 1 << 0,
+	/* When set, the packet will be sent to psample. */
+	OVS_SAMPLE_ARG_FLAG_PSAMPLE = 1 << 1,
+};
+
 struct sample_arg {
-	bool exec;                   /* When true, actions in sample will not
-				      * change flow keys. False otherwise.
-				      */
-	u32  probability;            /* Same value as
-				      * 'OVS_SAMPLE_ATTR_PROBABILITY'.
-				      */
+	u16 flags;		/* Flags that modify the behavior of the
+				 * action. See SAMPLE_ARG_FLAG_*.
+				 */
+	u32  probability;       /* Same value as
+				 * 'OVS_SAMPLE_ATTR_PROBABILITY'.
+				 */
+	u32  group_id;		/* Same value as
+				 * 'OVS_SAMPLE_ATTR_PSAMPLE_GROUP'.
+				 */
+	u8  cookie_len;		/* Length of psample cookie. */
+	char cookie[OVS_PSAMPLE_COOKIE_MAX_SIZE]; /* psample cookie data. */
 };
 #endif
 
diff --git a/net/openvswitch/actions.c b/net/openvswitch/actions.c
index 6fcd7e2ca81f..eb3166986fd2 100644
--- a/net/openvswitch/actions.c
+++ b/net/openvswitch/actions.c
@@ -24,6 +24,7 @@
 #include <net/checksum.h>
 #include <net/dsfield.h>
 #include <net/mpls.h>
+#include <net/psample.h>
 #include <net/sctp/checksum.h>
 
 #include "datapath.h"
@@ -1025,6 +1026,34 @@ static int dec_ttl_exception_handler(struct datapath *dp, struct sk_buff *skb,
 	return 0;
 }
 
+static int ovs_psample_packet(struct datapath *dp, struct sw_flow_key *key,
+			      const struct sample_arg *arg,
+			      struct sk_buff *skb)
+{
+	struct psample_group psample_group = {};
+	struct psample_metadata md = {};
+	struct vport *input_vport;
+	u32 rate;
+
+	psample_group.group_num = arg->group_id;
+	psample_group.net = ovs_dp_get_net(dp);
+
+	input_vport = ovs_vport_rcu(dp, key->phy.in_port);
+	if (!input_vport)
+		input_vport = ovs_vport_rcu(dp, OVSP_LOCAL);
+
+	md.in_ifindex = input_vport->dev->ifindex;
+	md.user_cookie = arg->cookie_len ? &arg->cookie[0] : NULL;
+	md.user_cookie_len = arg->cookie_len;
+	md.trunc_size = skb->len;
+
+	rate = arg->probability ? U32_MAX / arg->probability : 0;
+
+	psample_sample_packet(&psample_group, skb, rate, &md);
+
+	return 0;
+}
+
 /* When 'last' is true, sample() should always consume the 'skb'.
  * Otherwise, sample() should keep 'skb' intact regardless what
  * actions are executed within sample().
@@ -1033,11 +1062,12 @@ static int sample(struct datapath *dp, struct sk_buff *skb,
 		  struct sw_flow_key *key, const struct nlattr *attr,
 		  bool last)
 {
-	struct nlattr *actions;
+	const struct sample_arg *arg;
 	struct nlattr *sample_arg;
 	int rem = nla_len(attr);
-	const struct sample_arg *arg;
+	struct nlattr *actions;
 	bool clone_flow_key;
+	int ret;
 
 	/* The first action is always 'OVS_SAMPLE_ATTR_ARG'. */
 	sample_arg = nla_data(attr);
@@ -1051,9 +1081,20 @@ static int sample(struct datapath *dp, struct sk_buff *skb,
 		return 0;
 	}
 
-	clone_flow_key = !arg->exec;
-	return clone_execute(dp, skb, key, 0, actions, rem, last,
-			     clone_flow_key);
+	if (arg->flags & OVS_SAMPLE_ARG_FLAG_PSAMPLE) {
+		ret = ovs_psample_packet(dp, key, arg, skb);
+		if (ret)
+			return ret;
+	}
+
+	if (nla_ok(actions, rem)) {
+		clone_flow_key = !(arg->flags & OVS_SAMPLE_ARG_FLAG_EXEC);
+		ret = clone_execute(dp, skb, key, 0, actions, rem, last,
+				    clone_flow_key);
+	} else if (last) {
+		ovs_kfree_skb_reason(skb, OVS_DROP_LAST_ACTION);
+	}
+	return ret;
 }
 
 /* When 'last' is true, clone() should always consume the 'skb'.
diff --git a/net/openvswitch/flow_netlink.c b/net/openvswitch/flow_netlink.c
index f224d9bcea5e..1a348d3905fc 100644
--- a/net/openvswitch/flow_netlink.c
+++ b/net/openvswitch/flow_netlink.c
@@ -2561,6 +2561,9 @@ static int __ovs_nla_copy_actions(struct net *net, const struct nlattr *attr,
 				  u32 mpls_label_count, bool log,
 				  u32 depth);
 
+static int copy_action(const struct nlattr *from,
+		       struct sw_flow_actions **sfa, bool log);
+
 static int validate_and_copy_sample(struct net *net, const struct nlattr *attr,
 				    const struct sw_flow_key *key,
 				    struct sw_flow_actions **sfa,
@@ -2569,10 +2572,10 @@ static int validate_and_copy_sample(struct net *net, const struct nlattr *attr,
 				    u32 depth)
 {
 	const struct nlattr *attrs[OVS_SAMPLE_ATTR_MAX + 1];
-	const struct nlattr *probability, *actions;
+	const struct nlattr *probability, *actions, *group, *cookie;
+	struct sample_arg arg = {};
 	const struct nlattr *a;
 	int rem, start, err;
-	struct sample_arg arg;
 
 	memset(attrs, 0, sizeof(attrs));
 	nla_for_each_nested(a, attr, rem) {
@@ -2589,7 +2592,19 @@ static int validate_and_copy_sample(struct net *net, const struct nlattr *attr,
 		return -EINVAL;
 
 	actions = attrs[OVS_SAMPLE_ATTR_ACTIONS];
-	if (!actions || (nla_len(actions) && nla_len(actions) < NLA_HDRLEN))
+	if (actions && (!nla_len(actions) || nla_len(actions) < NLA_HDRLEN))
+		return -EINVAL;
+
+	group = attrs[OVS_SAMPLE_ATTR_PSAMPLE_GROUP];
+	if (group && nla_len(group) != sizeof(u32))
+		return -EINVAL;
+
+	cookie = attrs[OVS_SAMPLE_ATTR_PSAMPLE_COOKIE];
+	if (cookie &&
+	    (!group || nla_len(cookie) > OVS_PSAMPLE_COOKIE_MAX_SIZE))
+		return -EINVAL;
+
+	if (!group && !actions)
 		return -EINVAL;
 
 	/* validation done, copy sample action. */
@@ -2608,7 +2623,19 @@ static int validate_and_copy_sample(struct net *net, const struct nlattr *attr,
 	 * If the sample is the last action, it can always be excuted
 	 * rather than deferred.
 	 */
-	arg.exec = last || !actions_may_change_flow(actions);
+	if (actions && (last || !actions_may_change_flow(actions)))
+		arg.flags |= OVS_SAMPLE_ARG_FLAG_EXEC;
+
+	if (group) {
+		arg.flags |= OVS_SAMPLE_ARG_FLAG_PSAMPLE;
+		arg.group_id = nla_get_u32(group);
+	}
+
+	if (cookie) {
+		memcpy(&arg.cookie[0], nla_data(cookie), nla_len(cookie));
+		arg.cookie_len = nla_len(cookie);
+	}
+
 	arg.probability = nla_get_u32(probability);
 
 	err = ovs_nla_add_action(sfa, OVS_SAMPLE_ATTR_ARG, &arg, sizeof(arg),
@@ -2616,12 +2643,13 @@ static int validate_and_copy_sample(struct net *net, const struct nlattr *attr,
 	if (err)
 		return err;
 
-	err = __ovs_nla_copy_actions(net, actions, key, sfa,
-				     eth_type, vlan_tci, mpls_label_count, log,
-				     depth + 1);
-
-	if (err)
-		return err;
+	if (actions) {
+		err = __ovs_nla_copy_actions(net, actions, key, sfa,
+					     eth_type, vlan_tci,
+					     mpls_label_count, log, depth + 1);
+		if (err)
+			return err;
+	}
 
 	add_nested_action_end(*sfa, start);
 
@@ -3553,20 +3581,38 @@ static int sample_action_to_attr(const struct nlattr *attr,
 		goto out;
 	}
 
-	ac_start = nla_nest_start_noflag(skb, OVS_SAMPLE_ATTR_ACTIONS);
-	if (!ac_start) {
-		err = -EMSGSIZE;
-		goto out;
+	if (arg->flags & OVS_SAMPLE_ARG_FLAG_PSAMPLE) {
+		if (nla_put_u32(skb, OVS_SAMPLE_ATTR_PSAMPLE_GROUP,
+				arg->group_id)) {
+			err = -EMSGSIZE;
+			goto out;
+		}
+
+		if (arg->cookie_len &&
+		    nla_put(skb, OVS_SAMPLE_ATTR_PSAMPLE_COOKIE,
+			    arg->cookie_len, &arg->cookie[0])) {
+			err = -EMSGSIZE;
+			goto out;
+		}
 	}
 
-	err = ovs_nla_put_actions(actions, rem, skb);
+	if (nla_ok(actions, rem)) {
+		ac_start = nla_nest_start_noflag(skb, OVS_SAMPLE_ATTR_ACTIONS);
+		if (!ac_start) {
+			err = -EMSGSIZE;
+			goto out;
+		}
+		err = ovs_nla_put_actions(actions, rem, skb);
+	}
 
 out:
 	if (err) {
-		nla_nest_cancel(skb, ac_start);
+		if (ac_start)
+			nla_nest_cancel(skb, ac_start);
 		nla_nest_cancel(skb, start);
 	} else {
-		nla_nest_end(skb, ac_start);
+		if (ac_start)
+			nla_nest_end(skb, ac_start);
 		nla_nest_end(skb, start);
 	}
 
-- 
2.44.0



Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 916A37C0457
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 21:22:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343647AbjJJTWL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 15:22:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234222AbjJJTWJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 15:22:09 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A56D6B6
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 12:22:06 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2972C433C7;
        Tue, 10 Oct 2023 19:22:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696965726;
        bh=yM7KjXTObWwFAt0kkYCB/fRJosZ7h5UaoJgfYR7hptI=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=KX0HvAubMonj4fEYMAnneanvzGUqUZlt5s/tjo02hIt45ev2Dwbs4BmmoMjlm1Bz9
         Z/jHaTSIAKIuiOqK18i29ulpH9ftVd9WpONAqSn/qiQ6ScJQkSYX/gTzLqx0lm1E7n
         iwPQT7X5zxh8tvrfhthzcWUnN2WRaom/RaMqyiKvrZOLPCg9XhdLCCSiH171vANKcB
         l3hxWepJds8aRSVv54CQQ+03mvSpd26PEdlh+rLV0dRdxWRWG+5OuYtGMPQe3u1kzA
         QXIHEhwEr2d5O/H/YSr3VkTAocucpwhRM5EwG3tGFlmYRl0sjdy06rK36ccqjXSaTJ
         SU78vYi35eVrw==
From:   Matthieu Baerts <matttbe@kernel.org>
Date:   Tue, 10 Oct 2023 21:21:43 +0200
Subject: [PATCH net-next 2/6] net: mptcp: convert netlink from small_ops to
 ops
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231010-upstream-net-next-20231006-mptcp-ynl-v1-2-18dd117e8f50@kernel.org>
References: <20231010-upstream-net-next-20231006-mptcp-ynl-v1-0-18dd117e8f50@kernel.org>
In-Reply-To: <20231010-upstream-net-next-20231006-mptcp-ynl-v1-0-18dd117e8f50@kernel.org>
To:     mptcp@lists.linux.dev, "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Mat Martineau <martineau@kernel.org>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Davide Caratti <dcaratti@redhat.com>,
        Matthieu Baerts <matttbe@kernel.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=11837; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=xJIQUgvyWS794R7SPkEw/jyO1hGLyVubPRydeRZdkVw=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBlJaRVaw8Aty37Yvxf6LD8AqCyqv5UFhiJqVPmw
 SGS8Ut+p/6JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZSWkVQAKCRD2t4JPQmmg
 c8MMD/45dq2QnSTNF7YeXnTDSdI37oBC5l4F9Gs5DudPJaFmBmcckRimTtl15un4xZIl+knbYAo
 xpfkTxXNnxgdTjNIuzo1GbzR2VL5UAbS/3Vvor16rDwKiorg6NRhG1hz/uQjXMlxR2MyW92m/h8
 EN5pOEpqWEanmHYqzqfbyRu1DDCPfABVsW0gqtl+Z2jf+zMomyt045mbMfVdHLoqztdZvrIntnV
 CzQkHje17hk1Io7/FNj77bxvk3TfFyU5LsgXG7p1Ly4Lf0Ub4DYgkTYsuRL0+sS+jodN73S9DaY
 smzjsUlA5SYFwu4ojb71arn4J0LvBxzgVpoDJKUPQdpJLFMZA02FUEQyPu/Dvk9LWm/ItGFgkhS
 B1qSzda+lxi4cO0JCd5agjZiXXLTHfk+Tn0dsZUYlYRuxclTjv9ZTb2wmo5SdlGGvpQqS6G8L0G
 H1z0kfm+6sMBhGyyxmPuHa/4JXmPUuAeXq9K9UB1By5EUortt9lZxE/bG1rRtDOm3jDma+dX4P5
 czFfRGoFAIKJxi4c9RbPJvx0d34r01J6PQBrfqJOUu8K4tArZsDuJFpoAuGlP3fSWbyybRzOsJ5
 x0R5EwzYIb6Vyg1+6SmlJVdBb5E8E5q8FZ/mc1DLFp5l7SnweZ+MMsLC5q2PKpzeTG+16ezaaPZ
 hXJo+AddjrXARzA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Davide Caratti <dcaratti@redhat.com>

in the current MPTCP control plane, all operations use a netlink
attribute of the same type "MPTCP_PM_ATTR". However, add/del/get/flush
operations only parse the first element in the message _ the one that
describes MPTCP endpoints (that was named MPTCP_PM_ATTR_ADDR and
mostly used in ADD_ADDR operations _ probably the similarity of "attr",
"addr" and "add" might cause some confusion to human readers).
Convert MPTCP from 'small_ops' to 'ops', thus allowing different attributes
for each single operation, hopefully makes all this clearer to human
readers.

- use a separate attribute set for add/del/get/flush address operation,
  binary compatible with the existing one, to store the endpoint address.
  MPTCP_PM_ENDPOINT_ADDR is added to the uAPI (with the same value as
  MPTCP_PM_ATTR_ADDR) for these operations.
- convert mptcp_pm_ops[] and add policy files accordingly.

this prepares MPTCP control plane to be described as YAML spec.

Link: https://github.com/multipath-tcp/mptcp_net-next/issues/340
Acked-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Davide Caratti <dcaratti@redhat.com>
Signed-off-by: Matthieu Baerts <matttbe@kernel.org>
---
 include/uapi/linux/mptcp.h |   8 ++
 net/mptcp/pm_netlink.c     | 191 ++++++++++++++++++++++++++++++---------------
 2 files changed, 135 insertions(+), 64 deletions(-)

diff --git a/include/uapi/linux/mptcp.h b/include/uapi/linux/mptcp.h
index ee9c49f949a2..0e62937ab17c 100644
--- a/include/uapi/linux/mptcp.h
+++ b/include/uapi/linux/mptcp.h
@@ -65,6 +65,14 @@ enum {
 
 #define MPTCP_PM_ATTR_MAX (__MPTCP_PM_ATTR_MAX - 1)
 
+enum {
+	MPTCP_PM_ENDPOINT_ADDR = 1,
+
+	__MPTCP_PM_ENDPOINT_MAX
+};
+
+#define MPTCP_PM_ENDPOINT_MAX (__MPTCP_PM_ENDPOINT_MAX - 1)
+
 enum {
 	MPTCP_PM_ADDR_ATTR_UNSPEC,
 
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 9661f3812682..32976cf7c82b 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -48,6 +48,60 @@ struct pm_nl_pernet {
 #define MPTCP_PM_ADDR_MAX	8
 #define ADD_ADDR_RETRANS_MAX	3
 
+static
+const struct nla_policy mptcp_pm_address_nl_policy[MPTCP_PM_ADDR_ATTR_IF_IDX + 1] = {
+	[MPTCP_PM_ADDR_ATTR_FAMILY] = { .type = NLA_U16, },
+	[MPTCP_PM_ADDR_ATTR_ID] = { .type = NLA_U8, },
+	[MPTCP_PM_ADDR_ATTR_ADDR4] = { .type = NLA_U32, },
+	[MPTCP_PM_ADDR_ATTR_ADDR6] = { .len = 16, },
+	[MPTCP_PM_ADDR_ATTR_PORT] = { .type = NLA_U16, },
+	[MPTCP_PM_ADDR_ATTR_FLAGS] = { .type = NLA_U32, },
+	[MPTCP_PM_ADDR_ATTR_IF_IDX] = { .type = NLA_S32, },
+};
+
+/* MPTCP_PM_CMD_ADD_ADDR / DEL / GET / FLUSH - do */
+static
+const struct nla_policy mptcp_pm_endpoint_nl_policy[MPTCP_PM_ENDPOINT_ADDR + 1] = {
+	[MPTCP_PM_ENDPOINT_ADDR] = NLA_POLICY_NESTED(mptcp_pm_address_nl_policy),
+};
+
+/* MPTCP_PM_CMD_SET_LIMITS - do */
+static
+const struct nla_policy mptcp_pm_set_limits_nl_policy[MPTCP_PM_ATTR_SUBFLOWS + 1] = {
+	[MPTCP_PM_ATTR_RCV_ADD_ADDRS] = { .type = NLA_U32, },
+	[MPTCP_PM_ATTR_SUBFLOWS] = { .type = NLA_U32, },
+};
+
+/* MPTCP_PM_CMD_SET_FLAGS - do */
+static
+const struct nla_policy mptcp_pm_set_flags_nl_policy[MPTCP_PM_ATTR_ADDR_REMOTE + 1] = {
+	[MPTCP_PM_ATTR_ADDR] = NLA_POLICY_NESTED(mptcp_pm_address_nl_policy),
+	[MPTCP_PM_ATTR_TOKEN] = { .type = NLA_U32, },
+	[MPTCP_PM_ATTR_ADDR_REMOTE] = NLA_POLICY_NESTED(mptcp_pm_address_nl_policy),
+};
+
+/* MPTCP_PM_CMD_ANNOUNCE - do */
+static
+const struct nla_policy mptcp_pm_announce_nl_policy[MPTCP_PM_ATTR_TOKEN + 1] = {
+	[MPTCP_PM_ATTR_ADDR] = NLA_POLICY_NESTED(mptcp_pm_address_nl_policy),
+	[MPTCP_PM_ATTR_TOKEN] = { .type = NLA_U32, },
+};
+
+/* MPTCP_PM_CMD_REMOVE - do */
+static
+const struct nla_policy mptcp_pm_remove_nl_policy[MPTCP_PM_ATTR_LOC_ID + 1] = {
+	[MPTCP_PM_ATTR_TOKEN] = { .type = NLA_U32, },
+	[MPTCP_PM_ATTR_LOC_ID] = { .type = NLA_U8, },
+};
+
+/* MPTCP_PM_CMD_SUBFLOW_CREATE / DESTROY - do */
+static
+const struct nla_policy mptcp_pm_subflow_create_nl_policy[MPTCP_PM_ATTR_ADDR_REMOTE + 1] = {
+	[MPTCP_PM_ATTR_ADDR] = NLA_POLICY_NESTED(mptcp_pm_address_nl_policy),
+	[MPTCP_PM_ATTR_TOKEN] = { .type = NLA_U32, },
+	[MPTCP_PM_ATTR_ADDR_REMOTE] = NLA_POLICY_NESTED(mptcp_pm_address_nl_policy),
+};
+
 static struct pm_nl_pernet *pm_nl_get_pernet(const struct net *net)
 {
 	return net_generic(net, pm_nl_pernet_id);
@@ -1104,29 +1158,6 @@ static const struct genl_multicast_group mptcp_pm_mcgrps[] = {
 					  },
 };
 
-static const struct nla_policy
-mptcp_pm_addr_policy[MPTCP_PM_ADDR_ATTR_MAX + 1] = {
-	[MPTCP_PM_ADDR_ATTR_FAMILY]	= { .type	= NLA_U16,	},
-	[MPTCP_PM_ADDR_ATTR_ID]		= { .type	= NLA_U8,	},
-	[MPTCP_PM_ADDR_ATTR_ADDR4]	= { .type	= NLA_U32,	},
-	[MPTCP_PM_ADDR_ATTR_ADDR6]	=
-		NLA_POLICY_EXACT_LEN(sizeof(struct in6_addr)),
-	[MPTCP_PM_ADDR_ATTR_PORT]	= { .type	= NLA_U16	},
-	[MPTCP_PM_ADDR_ATTR_FLAGS]	= { .type	= NLA_U32	},
-	[MPTCP_PM_ADDR_ATTR_IF_IDX]     = { .type	= NLA_S32	},
-};
-
-static const struct nla_policy mptcp_pm_policy[MPTCP_PM_ATTR_MAX + 1] = {
-	[MPTCP_PM_ATTR_ADDR]		=
-					NLA_POLICY_NESTED(mptcp_pm_addr_policy),
-	[MPTCP_PM_ATTR_RCV_ADD_ADDRS]	= { .type	= NLA_U32,	},
-	[MPTCP_PM_ATTR_SUBFLOWS]	= { .type	= NLA_U32,	},
-	[MPTCP_PM_ATTR_TOKEN]		= { .type	= NLA_U32,	},
-	[MPTCP_PM_ATTR_LOC_ID]		= { .type	= NLA_U8,	},
-	[MPTCP_PM_ATTR_ADDR_REMOTE]	=
-					NLA_POLICY_NESTED(mptcp_pm_addr_policy),
-};
-
 void mptcp_pm_nl_subflow_chk_stale(const struct mptcp_sock *msk, struct sock *ssk)
 {
 	struct mptcp_subflow_context *iter, *subflow = mptcp_subflow_ctx(ssk);
@@ -1188,7 +1219,7 @@ static int mptcp_pm_parse_pm_addr_attr(struct nlattr *tb[],
 
 	/* no validation needed - was already done via nested policy */
 	err = nla_parse_nested_deprecated(tb, MPTCP_PM_ADDR_ATTR_MAX, attr,
-					  mptcp_pm_addr_policy, info->extack);
+					  mptcp_pm_address_nl_policy, info->extack);
 	if (err)
 		return err;
 
@@ -1305,7 +1336,7 @@ static int mptcp_nl_add_subflow_or_signal_addr(struct net *net)
 
 static int mptcp_nl_cmd_add_addr(struct sk_buff *skb, struct genl_info *info)
 {
-	struct nlattr *attr = info->attrs[MPTCP_PM_ATTR_ADDR];
+	struct nlattr *attr = info->attrs[MPTCP_PM_ENDPOINT_ADDR];
 	struct pm_nl_pernet *pernet = genl_info_pm_nl(info);
 	struct mptcp_pm_addr_entry addr, *entry;
 	int ret;
@@ -1486,7 +1517,7 @@ static int mptcp_nl_remove_id_zero_address(struct net *net,
 
 static int mptcp_nl_cmd_del_addr(struct sk_buff *skb, struct genl_info *info)
 {
-	struct nlattr *attr = info->attrs[MPTCP_PM_ATTR_ADDR];
+	struct nlattr *attr = info->attrs[MPTCP_PM_ENDPOINT_ADDR];
 	struct pm_nl_pernet *pernet = genl_info_pm_nl(info);
 	struct mptcp_pm_addr_entry addr, *entry;
 	unsigned int addr_max;
@@ -1677,7 +1708,7 @@ static int mptcp_nl_fill_addr(struct sk_buff *skb,
 
 static int mptcp_nl_cmd_get_addr(struct sk_buff *skb, struct genl_info *info)
 {
-	struct nlattr *attr = info->attrs[MPTCP_PM_ATTR_ADDR];
+	struct nlattr *attr = info->attrs[MPTCP_PM_ENDPOINT_ADDR];
 	struct pm_nl_pernet *pernet = genl_info_pm_nl(info);
 	struct mptcp_pm_addr_entry addr, *entry;
 	struct sk_buff *msg;
@@ -2283,72 +2314,104 @@ void mptcp_event(enum mptcp_event_type type, const struct mptcp_sock *msk,
 	nlmsg_free(skb);
 }
 
-static const struct genl_small_ops mptcp_pm_ops[] = {
+static const struct genl_ops mptcp_pm_ops[] = {
 	{
-		.cmd    = MPTCP_PM_CMD_ADD_ADDR,
-		.doit   = mptcp_nl_cmd_add_addr,
-		.flags  = GENL_UNS_ADMIN_PERM,
+		.cmd		= MPTCP_PM_CMD_ADD_ADDR,
+		.validate	= GENL_DONT_VALIDATE_STRICT,
+		.doit		= mptcp_nl_cmd_add_addr,
+		.policy		= mptcp_pm_endpoint_nl_policy,
+		.maxattr	= MPTCP_PM_ENDPOINT_ADDR,
+		.flags		= GENL_UNS_ADMIN_PERM,
 	},
 	{
-		.cmd    = MPTCP_PM_CMD_DEL_ADDR,
-		.doit   = mptcp_nl_cmd_del_addr,
-		.flags  = GENL_UNS_ADMIN_PERM,
+		.cmd		= MPTCP_PM_CMD_DEL_ADDR,
+		.validate	= GENL_DONT_VALIDATE_STRICT,
+		.doit		= mptcp_nl_cmd_del_addr,
+		.policy		= mptcp_pm_endpoint_nl_policy,
+		.maxattr	= MPTCP_PM_ENDPOINT_ADDR,
+		.flags		= GENL_UNS_ADMIN_PERM,
 	},
 	{
-		.cmd    = MPTCP_PM_CMD_FLUSH_ADDRS,
-		.doit   = mptcp_nl_cmd_flush_addrs,
-		.flags  = GENL_UNS_ADMIN_PERM,
+		.cmd		= MPTCP_PM_CMD_GET_ADDR,
+		.validate	= GENL_DONT_VALIDATE_STRICT,
+		.doit		= mptcp_nl_cmd_get_addr,
+		.dumpit		= mptcp_nl_cmd_dump_addrs,
+		.policy		= mptcp_pm_endpoint_nl_policy,
+		.maxattr	= MPTCP_PM_ENDPOINT_ADDR,
+		.flags		= GENL_UNS_ADMIN_PERM,
 	},
 	{
-		.cmd    = MPTCP_PM_CMD_GET_ADDR,
-		.doit   = mptcp_nl_cmd_get_addr,
-		.dumpit   = mptcp_nl_cmd_dump_addrs,
+		.cmd		= MPTCP_PM_CMD_FLUSH_ADDRS,
+		.validate	= GENL_DONT_VALIDATE_STRICT,
+		.doit		= mptcp_nl_cmd_flush_addrs,
+		.policy		= mptcp_pm_endpoint_nl_policy,
+		.maxattr	= MPTCP_PM_ENDPOINT_ADDR,
+		.flags		= GENL_UNS_ADMIN_PERM,
 	},
 	{
-		.cmd    = MPTCP_PM_CMD_SET_LIMITS,
-		.doit   = mptcp_nl_cmd_set_limits,
-		.flags  = GENL_UNS_ADMIN_PERM,
+		.cmd		= MPTCP_PM_CMD_SET_LIMITS,
+		.validate	= GENL_DONT_VALIDATE_STRICT,
+		.doit		= mptcp_nl_cmd_set_limits,
+		.policy		= mptcp_pm_set_limits_nl_policy,
+		.maxattr	= MPTCP_PM_ATTR_SUBFLOWS,
+		.flags		= GENL_UNS_ADMIN_PERM,
 	},
 	{
-		.cmd    = MPTCP_PM_CMD_GET_LIMITS,
-		.doit   = mptcp_nl_cmd_get_limits,
+		.cmd		= MPTCP_PM_CMD_GET_LIMITS,
+		.validate	= GENL_DONT_VALIDATE_STRICT,
+		.doit		= mptcp_nl_cmd_get_limits,
+		.policy		= mptcp_pm_set_limits_nl_policy,
+		.maxattr	= MPTCP_PM_ATTR_SUBFLOWS,
 	},
 	{
-		.cmd    = MPTCP_PM_CMD_SET_FLAGS,
-		.doit   = mptcp_nl_cmd_set_flags,
-		.flags  = GENL_UNS_ADMIN_PERM,
+		.cmd		= MPTCP_PM_CMD_SET_FLAGS,
+		.validate	= GENL_DONT_VALIDATE_STRICT,
+		.doit		= mptcp_nl_cmd_set_flags,
+		.policy		= mptcp_pm_set_flags_nl_policy,
+		.maxattr	= MPTCP_PM_ATTR_ADDR_REMOTE,
+		.flags		= GENL_UNS_ADMIN_PERM,
 	},
 	{
-		.cmd    = MPTCP_PM_CMD_ANNOUNCE,
-		.doit   = mptcp_nl_cmd_announce,
-		.flags  = GENL_UNS_ADMIN_PERM,
+		.cmd		= MPTCP_PM_CMD_ANNOUNCE,
+		.validate	= GENL_DONT_VALIDATE_STRICT,
+		.doit		= mptcp_nl_cmd_announce,
+		.policy		= mptcp_pm_announce_nl_policy,
+		.maxattr	= MPTCP_PM_ATTR_TOKEN,
+		.flags		= GENL_UNS_ADMIN_PERM,
 	},
 	{
-		.cmd    = MPTCP_PM_CMD_REMOVE,
-		.doit   = mptcp_nl_cmd_remove,
-		.flags  = GENL_UNS_ADMIN_PERM,
+		.cmd		= MPTCP_PM_CMD_REMOVE,
+		.validate	= GENL_DONT_VALIDATE_STRICT,
+		.doit		= mptcp_nl_cmd_remove,
+		.policy		= mptcp_pm_remove_nl_policy,
+		.maxattr	= MPTCP_PM_ATTR_LOC_ID,
+		.flags		= GENL_UNS_ADMIN_PERM,
 	},
 	{
-		.cmd    = MPTCP_PM_CMD_SUBFLOW_CREATE,
-		.doit   = mptcp_nl_cmd_sf_create,
-		.flags  = GENL_UNS_ADMIN_PERM,
+		.cmd		= MPTCP_PM_CMD_SUBFLOW_CREATE,
+		.validate	= GENL_DONT_VALIDATE_STRICT,
+		.doit		= mptcp_nl_cmd_sf_create,
+		.policy		= mptcp_pm_subflow_create_nl_policy,
+		.maxattr	= MPTCP_PM_ATTR_ADDR_REMOTE,
+		.flags		= GENL_UNS_ADMIN_PERM,
 	},
 	{
-		.cmd    = MPTCP_PM_CMD_SUBFLOW_DESTROY,
-		.doit   = mptcp_nl_cmd_sf_destroy,
-		.flags  = GENL_UNS_ADMIN_PERM,
+		.cmd		= MPTCP_PM_CMD_SUBFLOW_DESTROY,
+		.validate	= GENL_DONT_VALIDATE_STRICT,
+		.doit		= mptcp_nl_cmd_sf_destroy,
+		.policy		= mptcp_pm_subflow_create_nl_policy,
+		.maxattr	= MPTCP_PM_ATTR_ADDR_REMOTE,
+		.flags		= GENL_UNS_ADMIN_PERM,
 	},
 };
 
 static struct genl_family mptcp_genl_family __ro_after_init = {
 	.name		= MPTCP_PM_NAME,
 	.version	= MPTCP_PM_VER,
-	.maxattr	= MPTCP_PM_ATTR_MAX,
-	.policy		= mptcp_pm_policy,
 	.netnsok	= true,
 	.module		= THIS_MODULE,
-	.small_ops	= mptcp_pm_ops,
-	.n_small_ops	= ARRAY_SIZE(mptcp_pm_ops),
+	.ops		= mptcp_pm_ops,
+	.n_ops		= ARRAY_SIZE(mptcp_pm_ops),
 	.resv_start_op	= MPTCP_PM_CMD_SUBFLOW_DESTROY + 1,
 	.mcgrps		= mptcp_pm_mcgrps,
 	.n_mcgrps	= ARRAY_SIZE(mptcp_pm_mcgrps),

-- 
2.40.1


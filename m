Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 903167C045D
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 21:22:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343861AbjJJTW1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 15:22:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343775AbjJJTWS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 15:22:18 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AD5BE0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 12:22:15 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78F05C433BD;
        Tue, 10 Oct 2023 19:22:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696965734;
        bh=Ie7O/vWRffp+xW6oDBLzG/P6h5B/Uq4ksbSuheaQx5A=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=OHA2VF4/A5XdNoXbQsULqmbnog4ojpU1FFdKBLyRQkIsz7CgjUS0Qht/mQ1AKoqrR
         39ccvzsqs9Apb0UcooY+zkWbb5layXJqWZ0YYHaSZy7Yc7sVZA5w7hUc0v6WsOk4UI
         u7JnRYpcBxKfS/1b9phWNcHalOG6Wn0TTqPW5sOwUJ/7N8Zvp9GHN5U3GinPMcaZZV
         h8ERfAyYAQDoe3GVlBYzsc8SUo5lSwZg98cO+qMO9C9Tc4StXr5mQ/pz9N3cmQfsst
         7xHLDq9eQlvXhpMe83Xl7Jvx8ZNV7dm+zJWQQddFXnB3rIqY+puIljqvjPpcNRToF6
         0C3JAHDbMDFNA==
From:   Matthieu Baerts <matttbe@kernel.org>
Date:   Tue, 10 Oct 2023 21:21:46 +0200
Subject: [PATCH net-next 5/6] net: mptcp: rename netlink handlers to
 mptcp_pm_nl_<blah>_{doit,dumpit}
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231010-upstream-net-next-20231006-mptcp-ynl-v1-5-18dd117e8f50@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=11131; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=yVRzO2/YTZEyfWc8rNLxsJ5c6xVbSMMP4stse3H/SRk=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBlJaRVfGJd4xmDkoLBnFmg42SOhWqb6S8nahPlq
 6yDyGVgaRuJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZSWkVQAKCRD2t4JPQmmg
 c5dEEACrNHZnA14m7dy8I6/paGfCLrIdboMX3xlU9s6+sppsZMB2x493OFW0uVHvHRm2FZh4fvV
 BVmQpmTfFzKXmAseNaV3MqGby8k1dNzW9PDVvlgmOA7U32mJT0bwMR6O4hmsQ6e8g+Qvbk0fTuT
 Wpfdc455jm9vjUb1ixfVLCmGi4bpjMRUa+mVvHoy/Ulkz6Nzowr5eQd0EpjLVq+E70NhyG7yNhy
 ZgZvexgDfC0B+9XIScSIoSo61cV00aptIenqGCkVCr5+TDh+boBmjVBe7TjFL2oHbjUuSMgq0UH
 mLU/Ubtr/mjnRiNC3sy8iJTRwgm6b6r1Evreaa/kFxDfwr3cTtDi2cWYbT69mhHppoW7GZlAJPu
 SyYL86qDsVveTSdQMdJuCS1r77xXzVVbw9jgcYZeLphgtK4CTtzJnmBc4yp4TfGrxb0wM+RXe8u
 H2u22VWdi94a0tY6mfyx7so3z4ohg1eWek+0wPcSDZYS4tHhn1rZQ2sGxxbCDknURXltd6ZKnYQ
 IOBkF60EGiDuGh7m4vG+rrLGPXOF+D/06C8lVe+4S7/eF5cV1HTmSKzHFW90AMxXTLomVc61cFe
 +XARIkEpJfs0wdTY741lbe4ZswcLG30t8mN/ESI3Eety1jDgnuGYXH7dRiuWda0ashyHHLUTARs
 eOulDCufgrs0m7w==
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

so that they will match names generated from YAML spec.

Link: https://github.com/multipath-tcp/mptcp_net-next/issues/340
Suggested-by: Paolo Abeni <pabeni@redhat.com>
Acked-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Davide Caratti <dcaratti@redhat.com>
Signed-off-by: Matthieu Baerts <matttbe@kernel.org>
---
 net/mptcp/pm_netlink.c   | 48 ++++++++++++++++++++++++------------------------
 net/mptcp/pm_userspace.c |  8 ++++----
 net/mptcp/protocol.h     |  8 ++++----
 3 files changed, 32 insertions(+), 32 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 32976cf7c82b..dc3ed337eb1f 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1334,7 +1334,7 @@ static int mptcp_nl_add_subflow_or_signal_addr(struct net *net)
 	return 0;
 }
 
-static int mptcp_nl_cmd_add_addr(struct sk_buff *skb, struct genl_info *info)
+static int mptcp_pm_nl_add_addr_doit(struct sk_buff *skb, struct genl_info *info)
 {
 	struct nlattr *attr = info->attrs[MPTCP_PM_ENDPOINT_ADDR];
 	struct pm_nl_pernet *pernet = genl_info_pm_nl(info);
@@ -1515,7 +1515,7 @@ static int mptcp_nl_remove_id_zero_address(struct net *net,
 	return 0;
 }
 
-static int mptcp_nl_cmd_del_addr(struct sk_buff *skb, struct genl_info *info)
+static int mptcp_pm_nl_del_addr_doit(struct sk_buff *skb, struct genl_info *info)
 {
 	struct nlattr *attr = info->attrs[MPTCP_PM_ENDPOINT_ADDR];
 	struct pm_nl_pernet *pernet = genl_info_pm_nl(info);
@@ -1650,7 +1650,7 @@ static void __reset_counters(struct pm_nl_pernet *pernet)
 	pernet->addrs = 0;
 }
 
-static int mptcp_nl_cmd_flush_addrs(struct sk_buff *skb, struct genl_info *info)
+static int mptcp_pm_nl_flush_addrs_doit(struct sk_buff *skb, struct genl_info *info)
 {
 	struct pm_nl_pernet *pernet = genl_info_pm_nl(info);
 	LIST_HEAD(free_list);
@@ -1706,7 +1706,7 @@ static int mptcp_nl_fill_addr(struct sk_buff *skb,
 	return -EMSGSIZE;
 }
 
-static int mptcp_nl_cmd_get_addr(struct sk_buff *skb, struct genl_info *info)
+static int mptcp_pm_nl_get_addr_doit(struct sk_buff *skb, struct genl_info *info)
 {
 	struct nlattr *attr = info->attrs[MPTCP_PM_ENDPOINT_ADDR];
 	struct pm_nl_pernet *pernet = genl_info_pm_nl(info);
@@ -1756,8 +1756,8 @@ static int mptcp_nl_cmd_get_addr(struct sk_buff *skb, struct genl_info *info)
 	return ret;
 }
 
-static int mptcp_nl_cmd_dump_addrs(struct sk_buff *msg,
-				   struct netlink_callback *cb)
+static int mptcp_pm_nl_get_addr_dumpit(struct sk_buff *msg,
+				       struct netlink_callback *cb)
 {
 	struct net *net = sock_net(msg->sk);
 	struct mptcp_pm_addr_entry *entry;
@@ -1815,7 +1815,7 @@ static int parse_limit(struct genl_info *info, int id, unsigned int *limit)
 }
 
 static int
-mptcp_nl_cmd_set_limits(struct sk_buff *skb, struct genl_info *info)
+mptcp_pm_nl_set_limits_doit(struct sk_buff *skb, struct genl_info *info)
 {
 	struct pm_nl_pernet *pernet = genl_info_pm_nl(info);
 	unsigned int rcv_addrs, subflows;
@@ -1841,7 +1841,7 @@ mptcp_nl_cmd_set_limits(struct sk_buff *skb, struct genl_info *info)
 }
 
 static int
-mptcp_nl_cmd_get_limits(struct sk_buff *skb, struct genl_info *info)
+mptcp_pm_nl_get_limits_doit(struct sk_buff *skb, struct genl_info *info)
 {
 	struct pm_nl_pernet *pernet = genl_info_pm_nl(info);
 	struct sk_buff *msg;
@@ -1950,7 +1950,7 @@ int mptcp_pm_nl_set_flags(struct net *net, struct mptcp_pm_addr_entry *addr, u8
 	return 0;
 }
 
-static int mptcp_nl_cmd_set_flags(struct sk_buff *skb, struct genl_info *info)
+static int mptcp_pm_nl_set_flags_doit(struct sk_buff *skb, struct genl_info *info)
 {
 	struct mptcp_pm_addr_entry remote = { .addr = { .family = AF_UNSPEC }, };
 	struct mptcp_pm_addr_entry addr = { .addr = { .family = AF_UNSPEC }, };
@@ -2314,11 +2314,11 @@ void mptcp_event(enum mptcp_event_type type, const struct mptcp_sock *msk,
 	nlmsg_free(skb);
 }
 
-static const struct genl_ops mptcp_pm_ops[] = {
+static const struct genl_ops mptcp_pm_nl_ops[] = {
 	{
 		.cmd		= MPTCP_PM_CMD_ADD_ADDR,
 		.validate	= GENL_DONT_VALIDATE_STRICT,
-		.doit		= mptcp_nl_cmd_add_addr,
+		.doit		= mptcp_pm_nl_add_addr_doit,
 		.policy		= mptcp_pm_endpoint_nl_policy,
 		.maxattr	= MPTCP_PM_ENDPOINT_ADDR,
 		.flags		= GENL_UNS_ADMIN_PERM,
@@ -2326,7 +2326,7 @@ static const struct genl_ops mptcp_pm_ops[] = {
 	{
 		.cmd		= MPTCP_PM_CMD_DEL_ADDR,
 		.validate	= GENL_DONT_VALIDATE_STRICT,
-		.doit		= mptcp_nl_cmd_del_addr,
+		.doit		= mptcp_pm_nl_del_addr_doit,
 		.policy		= mptcp_pm_endpoint_nl_policy,
 		.maxattr	= MPTCP_PM_ENDPOINT_ADDR,
 		.flags		= GENL_UNS_ADMIN_PERM,
@@ -2334,8 +2334,8 @@ static const struct genl_ops mptcp_pm_ops[] = {
 	{
 		.cmd		= MPTCP_PM_CMD_GET_ADDR,
 		.validate	= GENL_DONT_VALIDATE_STRICT,
-		.doit		= mptcp_nl_cmd_get_addr,
-		.dumpit		= mptcp_nl_cmd_dump_addrs,
+		.doit		= mptcp_pm_nl_get_addr_doit,
+		.dumpit		= mptcp_pm_nl_get_addr_dumpit,
 		.policy		= mptcp_pm_endpoint_nl_policy,
 		.maxattr	= MPTCP_PM_ENDPOINT_ADDR,
 		.flags		= GENL_UNS_ADMIN_PERM,
@@ -2343,7 +2343,7 @@ static const struct genl_ops mptcp_pm_ops[] = {
 	{
 		.cmd		= MPTCP_PM_CMD_FLUSH_ADDRS,
 		.validate	= GENL_DONT_VALIDATE_STRICT,
-		.doit		= mptcp_nl_cmd_flush_addrs,
+		.doit		= mptcp_pm_nl_flush_addrs_doit,
 		.policy		= mptcp_pm_endpoint_nl_policy,
 		.maxattr	= MPTCP_PM_ENDPOINT_ADDR,
 		.flags		= GENL_UNS_ADMIN_PERM,
@@ -2351,7 +2351,7 @@ static const struct genl_ops mptcp_pm_ops[] = {
 	{
 		.cmd		= MPTCP_PM_CMD_SET_LIMITS,
 		.validate	= GENL_DONT_VALIDATE_STRICT,
-		.doit		= mptcp_nl_cmd_set_limits,
+		.doit		= mptcp_pm_nl_set_limits_doit,
 		.policy		= mptcp_pm_set_limits_nl_policy,
 		.maxattr	= MPTCP_PM_ATTR_SUBFLOWS,
 		.flags		= GENL_UNS_ADMIN_PERM,
@@ -2359,14 +2359,14 @@ static const struct genl_ops mptcp_pm_ops[] = {
 	{
 		.cmd		= MPTCP_PM_CMD_GET_LIMITS,
 		.validate	= GENL_DONT_VALIDATE_STRICT,
-		.doit		= mptcp_nl_cmd_get_limits,
+		.doit		= mptcp_pm_nl_get_limits_doit,
 		.policy		= mptcp_pm_set_limits_nl_policy,
 		.maxattr	= MPTCP_PM_ATTR_SUBFLOWS,
 	},
 	{
 		.cmd		= MPTCP_PM_CMD_SET_FLAGS,
 		.validate	= GENL_DONT_VALIDATE_STRICT,
-		.doit		= mptcp_nl_cmd_set_flags,
+		.doit		= mptcp_pm_nl_set_flags_doit,
 		.policy		= mptcp_pm_set_flags_nl_policy,
 		.maxattr	= MPTCP_PM_ATTR_ADDR_REMOTE,
 		.flags		= GENL_UNS_ADMIN_PERM,
@@ -2374,7 +2374,7 @@ static const struct genl_ops mptcp_pm_ops[] = {
 	{
 		.cmd		= MPTCP_PM_CMD_ANNOUNCE,
 		.validate	= GENL_DONT_VALIDATE_STRICT,
-		.doit		= mptcp_nl_cmd_announce,
+		.doit		= mptcp_pm_nl_announce_doit,
 		.policy		= mptcp_pm_announce_nl_policy,
 		.maxattr	= MPTCP_PM_ATTR_TOKEN,
 		.flags		= GENL_UNS_ADMIN_PERM,
@@ -2382,7 +2382,7 @@ static const struct genl_ops mptcp_pm_ops[] = {
 	{
 		.cmd		= MPTCP_PM_CMD_REMOVE,
 		.validate	= GENL_DONT_VALIDATE_STRICT,
-		.doit		= mptcp_nl_cmd_remove,
+		.doit		= mptcp_pm_nl_remove_doit,
 		.policy		= mptcp_pm_remove_nl_policy,
 		.maxattr	= MPTCP_PM_ATTR_LOC_ID,
 		.flags		= GENL_UNS_ADMIN_PERM,
@@ -2390,7 +2390,7 @@ static const struct genl_ops mptcp_pm_ops[] = {
 	{
 		.cmd		= MPTCP_PM_CMD_SUBFLOW_CREATE,
 		.validate	= GENL_DONT_VALIDATE_STRICT,
-		.doit		= mptcp_nl_cmd_sf_create,
+		.doit		= mptcp_pm_nl_subflow_create_doit,
 		.policy		= mptcp_pm_subflow_create_nl_policy,
 		.maxattr	= MPTCP_PM_ATTR_ADDR_REMOTE,
 		.flags		= GENL_UNS_ADMIN_PERM,
@@ -2398,7 +2398,7 @@ static const struct genl_ops mptcp_pm_ops[] = {
 	{
 		.cmd		= MPTCP_PM_CMD_SUBFLOW_DESTROY,
 		.validate	= GENL_DONT_VALIDATE_STRICT,
-		.doit		= mptcp_nl_cmd_sf_destroy,
+		.doit		= mptcp_pm_nl_subflow_destroy_doit,
 		.policy		= mptcp_pm_subflow_create_nl_policy,
 		.maxattr	= MPTCP_PM_ATTR_ADDR_REMOTE,
 		.flags		= GENL_UNS_ADMIN_PERM,
@@ -2410,8 +2410,8 @@ static struct genl_family mptcp_genl_family __ro_after_init = {
 	.version	= MPTCP_PM_VER,
 	.netnsok	= true,
 	.module		= THIS_MODULE,
-	.ops		= mptcp_pm_ops,
-	.n_ops		= ARRAY_SIZE(mptcp_pm_ops),
+	.ops		= mptcp_pm_nl_ops,
+	.n_ops		= ARRAY_SIZE(mptcp_pm_nl_ops),
 	.resv_start_op	= MPTCP_PM_CMD_SUBFLOW_DESTROY + 1,
 	.mcgrps		= mptcp_pm_mcgrps,
 	.n_mcgrps	= ARRAY_SIZE(mptcp_pm_mcgrps),
diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index d042d32beb4d..0f92e5b13a8a 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -145,7 +145,7 @@ int mptcp_userspace_pm_get_local_id(struct mptcp_sock *msk,
 	return mptcp_userspace_pm_append_new_local_addr(msk, &new_entry);
 }
 
-int mptcp_nl_cmd_announce(struct sk_buff *skb, struct genl_info *info)
+int mptcp_pm_nl_announce_doit(struct sk_buff *skb, struct genl_info *info)
 {
 	struct nlattr *token = info->attrs[MPTCP_PM_ATTR_TOKEN];
 	struct nlattr *addr = info->attrs[MPTCP_PM_ATTR_ADDR];
@@ -208,7 +208,7 @@ int mptcp_nl_cmd_announce(struct sk_buff *skb, struct genl_info *info)
 	return err;
 }
 
-int mptcp_nl_cmd_remove(struct sk_buff *skb, struct genl_info *info)
+int mptcp_pm_nl_remove_doit(struct sk_buff *skb, struct genl_info *info)
 {
 	struct nlattr *token = info->attrs[MPTCP_PM_ATTR_TOKEN];
 	struct nlattr *id = info->attrs[MPTCP_PM_ATTR_LOC_ID];
@@ -270,7 +270,7 @@ int mptcp_nl_cmd_remove(struct sk_buff *skb, struct genl_info *info)
 	return err;
 }
 
-int mptcp_nl_cmd_sf_create(struct sk_buff *skb, struct genl_info *info)
+int mptcp_pm_nl_subflow_create_doit(struct sk_buff *skb, struct genl_info *info)
 {
 	struct nlattr *raddr = info->attrs[MPTCP_PM_ATTR_ADDR_REMOTE];
 	struct nlattr *token = info->attrs[MPTCP_PM_ATTR_TOKEN];
@@ -394,7 +394,7 @@ static struct sock *mptcp_nl_find_ssk(struct mptcp_sock *msk,
 	return NULL;
 }
 
-int mptcp_nl_cmd_sf_destroy(struct sk_buff *skb, struct genl_info *info)
+int mptcp_pm_nl_subflow_destroy_doit(struct sk_buff *skb, struct genl_info *info)
 {
 	struct nlattr *raddr = info->attrs[MPTCP_PM_ATTR_ADDR_REMOTE];
 	struct nlattr *token = info->attrs[MPTCP_PM_ATTR_TOKEN];
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 3612545fa62e..4d6e40416f84 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -877,10 +877,10 @@ void mptcp_pm_remove_addrs_and_subflows(struct mptcp_sock *msk,
 					struct list_head *rm_list);
 
 void mptcp_free_local_addr_list(struct mptcp_sock *msk);
-int mptcp_nl_cmd_announce(struct sk_buff *skb, struct genl_info *info);
-int mptcp_nl_cmd_remove(struct sk_buff *skb, struct genl_info *info);
-int mptcp_nl_cmd_sf_create(struct sk_buff *skb, struct genl_info *info);
-int mptcp_nl_cmd_sf_destroy(struct sk_buff *skb, struct genl_info *info);
+int mptcp_pm_nl_announce_doit(struct sk_buff *skb, struct genl_info *info);
+int mptcp_pm_nl_remove_doit(struct sk_buff *skb, struct genl_info *info);
+int mptcp_pm_nl_subflow_create_doit(struct sk_buff *skb, struct genl_info *info);
+int mptcp_pm_nl_subflow_destroy_doit(struct sk_buff *skb, struct genl_info *info);
 
 void mptcp_event(enum mptcp_event_type type, const struct mptcp_sock *msk,
 		 const struct sock *ssk, gfp_t gfp);

-- 
2.40.1


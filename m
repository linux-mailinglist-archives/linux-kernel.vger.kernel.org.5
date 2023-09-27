Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBC707AFA74
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 07:56:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbjI0F4S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 01:56:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229952AbjI0Fzh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 01:55:37 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D968CDE;
        Tue, 26 Sep 2023 22:55:33 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 450A0C433C7;
        Wed, 27 Sep 2023 05:55:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695794133;
        bh=PS/DrRUCszB6uX0dXeIxFFme7S+AAfTHo23ufuCd1jw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=J90fN2w540AAQBs38jLZ5lBDyABNI1rj8qR5gszHVNYgU5InzUoC1G5VLNc8FufX6
         ObZcBvqFgj6ikAvMWz9WpHQIhX90bMXqN+/xa+viDiXwFbTGGKXSmBEIA7Lf+qXc5/
         xX9yOJEouAvfOhjMrSGENSm6+0yXtsbu/oogahuMYgncpQNoaWz4CQWDMIOiR76J5P
         JXpaq0an4ii9XHBBVf0QfZJMYtvPqy+00flqfV+Y0fcmQ+vvwiKYXUlegz1D3YzwLt
         2PqGOHz6TpqaG8EcB8rcZTLEwfdCJtKHe2z4OmsZLfHhYk4tdJiG58tIzwMTCEsomG
         hheFD2E2IHZDg==
Date:   Wed, 27 Sep 2023 08:55:28 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Dust Li <dust.li@linux.alibaba.com>
Cc:     Albert Huang <huangjie.albert@bytedance.com>,
        Karsten Graul <kgraul@linux.ibm.com>,
        Wenjia Zhang <wenjia@linux.ibm.com>,
        Jan Karcher <jaka@linux.ibm.com>,
        "D. Wythe" <alibuda@linux.alibaba.com>,
        Tony Lu <tonylu@linux.alibaba.com>,
        Wen Gu <guwen@linux.alibaba.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net/smc: add support for netdevice in
 containers.
Message-ID: <20230927055528.GP1642130@unreal>
References: <20230925023546.9964-1-huangjie.albert@bytedance.com>
 <20230927034209.GE92403@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230927034209.GE92403@linux.alibaba.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 27, 2023 at 11:42:09AM +0800, Dust Li wrote:
> On Mon, Sep 25, 2023 at 10:35:45AM +0800, Albert Huang wrote:
> >If the netdevice is within a container and communicates externally
> >through network technologies like VXLAN, we won't be able to find
> >routing information in the init_net namespace. To address this issue,
> 
> Thanks for your founding !
> 
> I think this is a more generic problem, but not just related to VXLAN ?
> If we use SMC-R v2 and the netdevice is in a net namespace which is not
> init_net, we should always fail, right ? If so, I'd prefer this to be a bugfix.

BTW, does this patch take into account net namespace of ib_device?

Thanks

> 
> Best regards,
> Dust
> 
> >we need to add a struct net parameter to the smc_ib_find_route function.
> >This allow us to locate the routing information within the corresponding
> >net namespace, ensuring the correct completion of the SMC CLC interaction.
> >
> >Signed-off-by: Albert Huang <huangjie.albert@bytedance.com>
> >---
> > net/smc/af_smc.c | 3 ++-
> > net/smc/smc_ib.c | 7 ++++---
> > net/smc/smc_ib.h | 2 +-
> > 3 files changed, 7 insertions(+), 5 deletions(-)
> >
> >diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
> >index bacdd971615e..7a874da90c7f 100644
> >--- a/net/smc/af_smc.c
> >+++ b/net/smc/af_smc.c
> >@@ -1201,6 +1201,7 @@ static int smc_connect_rdma_v2_prepare(struct smc_sock *smc,
> > 		(struct smc_clc_msg_accept_confirm_v2 *)aclc;
> > 	struct smc_clc_first_contact_ext *fce =
> > 		smc_get_clc_first_contact_ext(clc_v2, false);
> >+	struct net *net = sock_net(&smc->sk);
> > 	int rc;
> > 
> > 	if (!ini->first_contact_peer || aclc->hdr.version == SMC_V1)
> >@@ -1210,7 +1211,7 @@ static int smc_connect_rdma_v2_prepare(struct smc_sock *smc,
> > 		memcpy(ini->smcrv2.nexthop_mac, &aclc->r0.lcl.mac, ETH_ALEN);
> > 		ini->smcrv2.uses_gateway = false;
> > 	} else {
> >-		if (smc_ib_find_route(smc->clcsock->sk->sk_rcv_saddr,
> >+		if (smc_ib_find_route(net, smc->clcsock->sk->sk_rcv_saddr,
> > 				      smc_ib_gid_to_ipv4(aclc->r0.lcl.gid),
> > 				      ini->smcrv2.nexthop_mac,
> > 				      &ini->smcrv2.uses_gateway))
> >diff --git a/net/smc/smc_ib.c b/net/smc/smc_ib.c
> >index 9b66d6aeeb1a..89981dbe46c9 100644
> >--- a/net/smc/smc_ib.c
> >+++ b/net/smc/smc_ib.c
> >@@ -193,7 +193,7 @@ bool smc_ib_port_active(struct smc_ib_device *smcibdev, u8 ibport)
> > 	return smcibdev->pattr[ibport - 1].state == IB_PORT_ACTIVE;
> > }
> > 
> >-int smc_ib_find_route(__be32 saddr, __be32 daddr,
> >+int smc_ib_find_route(struct net *net, __be32 saddr, __be32 daddr,
> > 		      u8 nexthop_mac[], u8 *uses_gateway)
> > {
> > 	struct neighbour *neigh = NULL;
> >@@ -205,7 +205,7 @@ int smc_ib_find_route(__be32 saddr, __be32 daddr,
> > 
> > 	if (daddr == cpu_to_be32(INADDR_NONE))
> > 		goto out;
> >-	rt = ip_route_output_flow(&init_net, &fl4, NULL);
> >+	rt = ip_route_output_flow(net, &fl4, NULL);
> > 	if (IS_ERR(rt))
> > 		goto out;
> > 	if (rt->rt_uses_gateway && rt->rt_gw_family != AF_INET)
> >@@ -235,6 +235,7 @@ static int smc_ib_determine_gid_rcu(const struct net_device *ndev,
> > 	if (smcrv2 && attr->gid_type == IB_GID_TYPE_ROCE_UDP_ENCAP &&
> > 	    smc_ib_gid_to_ipv4((u8 *)&attr->gid) != cpu_to_be32(INADDR_NONE)) {
> > 		struct in_device *in_dev = __in_dev_get_rcu(ndev);
> >+		struct net *net = dev_net(ndev);
> > 		const struct in_ifaddr *ifa;
> > 		bool subnet_match = false;
> > 
> >@@ -248,7 +249,7 @@ static int smc_ib_determine_gid_rcu(const struct net_device *ndev,
> > 		}
> > 		if (!subnet_match)
> > 			goto out;
> >-		if (smcrv2->daddr && smc_ib_find_route(smcrv2->saddr,
> >+		if (smcrv2->daddr && smc_ib_find_route(net, smcrv2->saddr,
> > 						       smcrv2->daddr,
> > 						       smcrv2->nexthop_mac,
> > 						       &smcrv2->uses_gateway))
> >diff --git a/net/smc/smc_ib.h b/net/smc/smc_ib.h
> >index 4df5f8c8a0a1..ef8ac2b7546d 100644
> >--- a/net/smc/smc_ib.h
> >+++ b/net/smc/smc_ib.h
> >@@ -112,7 +112,7 @@ void smc_ib_sync_sg_for_device(struct smc_link *lnk,
> > int smc_ib_determine_gid(struct smc_ib_device *smcibdev, u8 ibport,
> > 			 unsigned short vlan_id, u8 gid[], u8 *sgid_index,
> > 			 struct smc_init_info_smcrv2 *smcrv2);
> >-int smc_ib_find_route(__be32 saddr, __be32 daddr,
> >+int smc_ib_find_route(struct net *net, __be32 saddr, __be32 daddr,
> > 		      u8 nexthop_mac[], u8 *uses_gateway);
> > bool smc_ib_is_valid_local_systemid(void);
> > int smcr_nl_get_device(struct sk_buff *skb, struct netlink_callback *cb);
> >-- 
> >2.37.1 (Apple Git-137.1)
> 

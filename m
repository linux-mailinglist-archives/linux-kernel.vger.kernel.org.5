Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 778867BC633
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 10:45:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234175AbjJGIpO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Oct 2023 04:45:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234152AbjJGIpH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Oct 2023 04:45:07 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20750C2
        for <linux-kernel@vger.kernel.org>; Sat,  7 Oct 2023 01:44:44 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1c5db4925f9so22802535ad.1
        for <linux-kernel@vger.kernel.org>; Sat, 07 Oct 2023 01:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1696668283; x=1697273083; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DYsTV8KQJWPLnxFgGwY07YV1sQ8Lujc5noM4wlj3swY=;
        b=i9Y8JQmwfQqJop84DuisE1icfL0vhmW8XcScyqc2zOUTQuTR7IPVhnBMVHkv4GVBXL
         iUghLCwdBfOsST9UzpPItj604USqSCCYA8nc0Vfwy/ovyvaVDVkTpY2FBhPqh8MXrYO5
         hl8fJE4QAswjwXrFGnFG5jyjXhuYmHSykZ/dHboHAdBHK54ZsPTZfdLPpBxiwqbL/QBu
         h4q0UMq7z7vfh6GYo9BAB14OCrSsobbAp1cWLRbgWOfag2qW56A469tixam3fzrUo0/j
         E4abxO4Y4HRuf9SZKUX6eBmWBzOClDL17FZEzvHMQg6PjiKZWLc4lGL9u1lJHSKXWQhF
         Xpnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696668283; x=1697273083;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DYsTV8KQJWPLnxFgGwY07YV1sQ8Lujc5noM4wlj3swY=;
        b=MaekZ0m6tXe8WkEz3ZYf4GUDQ5yVlFg5jBDBbgpFSpVfolGkKp0E+5x9IbMBkiU8ur
         aLX4BcLpEtI+rmCB14u9NEGAXyaxQuvhdReUh3bbga2FT8t8Z2M4popJ4gSt1yr3XxX5
         ASZ/IHCn/5z4rH8XqOB+0iNe9f+aqLCrqWKn2zc0mTJ2e1weiqgWULMwW4KUyOzPLRfb
         sm4jMJcjWQi/5ELjg0+huy6dAKCfwJNA6XveusnHFWqnoO+VO4mrdrofBRqCbJloDgsb
         3AgSLvGe4lF0qpemxLSj8iFkqL2amYLVmf5Qi420TK4Q0KPwvuexndoGPsCagcFGrD2S
         lytw==
X-Gm-Message-State: AOJu0YwiUmjQ9hmLKilQJxMM0CqN0y4yG4WDG/I6STJXrD0Y3K4dZ8dF
        wBffJULtxZ5UuKcUn1fEr7j/wh9D9s7H5hOb5f0=
X-Google-Smtp-Source: AGHT+IFfYluDDpg6ygH4dFg5jy5tmXVAf4NvvaUhFb/Bu6EObCEfHdWAO6/qFYUW1VtuzlH5uGhaHw==
X-Received: by 2002:a17:902:ec90:b0:1c7:27a1:a9e5 with SMTP id x16-20020a170902ec9000b001c727a1a9e5mr12310794plg.33.1696668283532;
        Sat, 07 Oct 2023 01:44:43 -0700 (PDT)
Received: from C02FG34NMD6R.bytedance.net ([203.208.189.14])
        by smtp.gmail.com with ESMTPSA id e4-20020a17090301c400b001c75627545csm5298205plh.135.2023.10.07.01.44.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Oct 2023 01:44:42 -0700 (PDT)
From:   Albert Huang <huangjie.albert@bytedance.com>
To:     Karsten Graul <kgraul@linux.ibm.com>,
        Wenjia Zhang <wenjia@linux.ibm.com>,
        Jan Karcher <jaka@linux.ibm.com>,
        "D. Wythe" <alibuda@linux.alibaba.com>,
        Tony Lu <tonylu@linux.alibaba.com>
Cc:     Albert Huang <huangjie.albert@bytedance.com>,
        Wen Gu <guwen@linux.alibaba.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net] net/smc: fix smc clc failed issue when netdevice not in init_net
Date:   Sat,  7 Oct 2023 16:44:19 +0800
Message-Id: <20231007084420.80236-1-huangjie.albert@bytedance.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the netdevice is within a container and communicates externally
through network technologies such as VxLAN, we won't be able to find
routing information in the init_net namespace. To address this issue,
we need to add a struct net parameter to the smc_ib_find_route function.
This allow us to locate the routing information within the corresponding
net namespace, ensuring the correct completion of the SMC CLC interaction.

Signed-off-by: Albert Huang <huangjie.albert@bytedance.com>
---
 net/smc/af_smc.c | 3 ++-
 net/smc/smc_ib.c | 7 ++++---
 net/smc/smc_ib.h | 2 +-
 3 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index bacdd971615e..7a874da90c7f 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -1201,6 +1201,7 @@ static int smc_connect_rdma_v2_prepare(struct smc_sock *smc,
 		(struct smc_clc_msg_accept_confirm_v2 *)aclc;
 	struct smc_clc_first_contact_ext *fce =
 		smc_get_clc_first_contact_ext(clc_v2, false);
+	struct net *net = sock_net(&smc->sk);
 	int rc;
 
 	if (!ini->first_contact_peer || aclc->hdr.version == SMC_V1)
@@ -1210,7 +1211,7 @@ static int smc_connect_rdma_v2_prepare(struct smc_sock *smc,
 		memcpy(ini->smcrv2.nexthop_mac, &aclc->r0.lcl.mac, ETH_ALEN);
 		ini->smcrv2.uses_gateway = false;
 	} else {
-		if (smc_ib_find_route(smc->clcsock->sk->sk_rcv_saddr,
+		if (smc_ib_find_route(net, smc->clcsock->sk->sk_rcv_saddr,
 				      smc_ib_gid_to_ipv4(aclc->r0.lcl.gid),
 				      ini->smcrv2.nexthop_mac,
 				      &ini->smcrv2.uses_gateway))
diff --git a/net/smc/smc_ib.c b/net/smc/smc_ib.c
index 9b66d6aeeb1a..89981dbe46c9 100644
--- a/net/smc/smc_ib.c
+++ b/net/smc/smc_ib.c
@@ -193,7 +193,7 @@ bool smc_ib_port_active(struct smc_ib_device *smcibdev, u8 ibport)
 	return smcibdev->pattr[ibport - 1].state == IB_PORT_ACTIVE;
 }
 
-int smc_ib_find_route(__be32 saddr, __be32 daddr,
+int smc_ib_find_route(struct net *net, __be32 saddr, __be32 daddr,
 		      u8 nexthop_mac[], u8 *uses_gateway)
 {
 	struct neighbour *neigh = NULL;
@@ -205,7 +205,7 @@ int smc_ib_find_route(__be32 saddr, __be32 daddr,
 
 	if (daddr == cpu_to_be32(INADDR_NONE))
 		goto out;
-	rt = ip_route_output_flow(&init_net, &fl4, NULL);
+	rt = ip_route_output_flow(net, &fl4, NULL);
 	if (IS_ERR(rt))
 		goto out;
 	if (rt->rt_uses_gateway && rt->rt_gw_family != AF_INET)
@@ -235,6 +235,7 @@ static int smc_ib_determine_gid_rcu(const struct net_device *ndev,
 	if (smcrv2 && attr->gid_type == IB_GID_TYPE_ROCE_UDP_ENCAP &&
 	    smc_ib_gid_to_ipv4((u8 *)&attr->gid) != cpu_to_be32(INADDR_NONE)) {
 		struct in_device *in_dev = __in_dev_get_rcu(ndev);
+		struct net *net = dev_net(ndev);
 		const struct in_ifaddr *ifa;
 		bool subnet_match = false;
 
@@ -248,7 +249,7 @@ static int smc_ib_determine_gid_rcu(const struct net_device *ndev,
 		}
 		if (!subnet_match)
 			goto out;
-		if (smcrv2->daddr && smc_ib_find_route(smcrv2->saddr,
+		if (smcrv2->daddr && smc_ib_find_route(net, smcrv2->saddr,
 						       smcrv2->daddr,
 						       smcrv2->nexthop_mac,
 						       &smcrv2->uses_gateway))
diff --git a/net/smc/smc_ib.h b/net/smc/smc_ib.h
index 4df5f8c8a0a1..ef8ac2b7546d 100644
--- a/net/smc/smc_ib.h
+++ b/net/smc/smc_ib.h
@@ -112,7 +112,7 @@ void smc_ib_sync_sg_for_device(struct smc_link *lnk,
 int smc_ib_determine_gid(struct smc_ib_device *smcibdev, u8 ibport,
 			 unsigned short vlan_id, u8 gid[], u8 *sgid_index,
 			 struct smc_init_info_smcrv2 *smcrv2);
-int smc_ib_find_route(__be32 saddr, __be32 daddr,
+int smc_ib_find_route(struct net *net, __be32 saddr, __be32 daddr,
 		      u8 nexthop_mac[], u8 *uses_gateway);
 bool smc_ib_is_valid_local_systemid(void);
 int smcr_nl_get_device(struct sk_buff *skb, struct netlink_callback *cb);
-- 
2.37.1 (Apple Git-137.1)


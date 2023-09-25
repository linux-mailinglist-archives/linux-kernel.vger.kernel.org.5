Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D06DB7ACE30
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 04:36:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231772AbjIYCgc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 22:36:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230194AbjIYCga (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 22:36:30 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E92FC2
        for <linux-kernel@vger.kernel.org>; Sun, 24 Sep 2023 19:36:02 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1c61acd1285so4888155ad.2
        for <linux-kernel@vger.kernel.org>; Sun, 24 Sep 2023 19:36:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1695609361; x=1696214161; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dzmBYOC+iwFysYemk8kdLeE2Dt2aHmz4Un9SzH6Y5Wg=;
        b=bEPsr68MnOBQdj+Rj5S5E9z+oTlmdfS3vCrMIPE2MugjG3iq6EtHs+RL3S0noErXHF
         Gtf6ucm30U2aeRbb59OuRWRh6Bqan4lbe3206VlgZlpDgP/HJH86yZCc3XGYQGIv9S20
         BuQEGUd+s71KazqxFCeAyiGAqM++LRocDdekkc5SenypHyLqCVKDopwscI5pBBbqG+bD
         Sql6HNSekdhWUxlJD/v6B5ArwDocOSa5qt+GqxFtO3/x8lkxrsWN+nNAvR55N7uckpG7
         9AVm02ydI4EtbuJkwQeZ8d2Z2GvneG2Ic5lUZ74HDzAvGnNy5SON8QvcUwiqynXiWh49
         AFSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695609361; x=1696214161;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dzmBYOC+iwFysYemk8kdLeE2Dt2aHmz4Un9SzH6Y5Wg=;
        b=ZnjB5htCChRN8F71KmCu0M1Se7g9eyfF0CimmWUbkVTnsO/H24BQjBC7tCr2SYO83P
         u2uM8/671WGbp5OQV94HB6lVKB9jlCDwPNo/d29aXIcHXLMcxn2EcnX3+mN7pMCWKIgQ
         vkUL3vfR3xkcoqHvfe9VUXv6PIYMgNdzXafIAuOFSS6GrpT9QFTb5kCBmqL5uc791Orm
         COaZ66lNveqhU0wP5HPj16Bs7AXtfHbabHBhblgFrOZOMo9MgYVqvWeOiV37kIfHsw5P
         6H8SEbw5bhi6NENvWkTKBNjd8R9QOv3NJWPSZhoo161NSWzhr2oXWfH2h3fqoImYSe+0
         vNEw==
X-Gm-Message-State: AOJu0YwgfKB406L3V1kIBzuDrjPBPMOno/pQC/rUyCLDPwRKU/lnDvlX
        ZdjaHN+irMU6wi5Q+Xjk6qtgIA==
X-Google-Smtp-Source: AGHT+IGI/P4ONGXx2/V7iBF+Z7EgcwNg8/ly8pcWV1DYWBNVGQ2Hpvcgq3ygJUmT517X+1OMzu2zig==
X-Received: by 2002:a17:902:bd97:b0:1bb:9506:d47c with SMTP id q23-20020a170902bd9700b001bb9506d47cmr3693386pls.19.1695609361476;
        Sun, 24 Sep 2023 19:36:01 -0700 (PDT)
Received: from C02FG34NMD6R.bytedance.net ([203.208.189.6])
        by smtp.gmail.com with ESMTPSA id u15-20020a170902e5cf00b001a5fccab02dsm7516445plf.177.2023.09.24.19.35.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Sep 2023 19:36:00 -0700 (PDT)
From:   Albert Huang <huangjie.albert@bytedance.com>
To:     Karsten Graul <kgraul@linux.ibm.com>,
        Wenjia Zhang <wenjia@linux.ibm.com>,
        Jan Karcher <jaka@linux.ibm.com>
Cc:     Albert Huang <huangjie.albert@bytedance.com>,
        "D. Wythe" <alibuda@linux.alibaba.com>,
        Tony Lu <tonylu@linux.alibaba.com>,
        Wen Gu <guwen@linux.alibaba.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next] net/smc: add support for netdevice in containers.
Date:   Mon, 25 Sep 2023 10:35:45 +0800
Message-Id: <20230925023546.9964-1-huangjie.albert@bytedance.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the netdevice is within a container and communicates externally
through network technologies like VXLAN, we won't be able to find
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


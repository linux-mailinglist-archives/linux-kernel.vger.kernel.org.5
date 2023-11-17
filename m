Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F6937EEFF1
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 11:18:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345798AbjKQKSl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 05:18:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345722AbjKQKSk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 05:18:40 -0500
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1DC685;
        Fri, 17 Nov 2023 02:18:32 -0800 (PST)
X-UUID: 89447f97b7be4fe2a5abb71fe48af864-20231117
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.32,REQID:8c676f36-530e-4e2c-8dbc-4bdd016b5871,IP:15,
        URL:0,TC:0,Content:-5,EDM:25,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,AC
        TION:release,TS:20
X-CID-INFO: VERSION:1.1.32,REQID:8c676f36-530e-4e2c-8dbc-4bdd016b5871,IP:15,UR
        L:0,TC:0,Content:-5,EDM:25,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTI
        ON:release,TS:20
X-CID-META: VersionHash:5f78ec9,CLOUDID:0e952d60-c89d-4129-91cb-8ebfae4653fc,B
        ulkID:2311171818217W1R421N,BulkQuantity:0,Recheck:0,SF:19|44|66|38|24|17|1
        02,TC:nil,Content:0,EDM:5,IP:-2,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL
        :0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI
X-UUID: 89447f97b7be4fe2a5abb71fe48af864-20231117
X-User: chentao@kylinos.cn
Received: from vt.. [(116.128.244.169)] by mailgw
        (envelope-from <chentao@kylinos.cn>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 680025267; Fri, 17 Nov 2023 18:18:18 +0800
From:   Kunwu Chan <chentao@kylinos.cn>
To:     jhs@mojatatu.com, xiyou.wangcong@gmail.com, jiri@resnulli.us,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com
Cc:     kunwu.chan@hotmail.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Kunwu Chan <chentao@kylinos.cn>
Subject: [PATCH] net: sched: Fix restricted __be16 degrades to integer
Date:   Fri, 17 Nov 2023 18:18:15 +0800
Message-Id: <20231117101815.1867175-1-chentao@kylinos.cn>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

net/sched/cls_api.c:2010:25: warning: restricted __be16 degrades to integer
net/sched/cls_api.c:2695:50: warning: restricted __be16 degrades to integer

Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
---
 net/sched/cls_api.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/sched/cls_api.c b/net/sched/cls_api.c
index f73f39f61f66..4c47490eb0c1 100644
--- a/net/sched/cls_api.c
+++ b/net/sched/cls_api.c
@@ -2007,7 +2007,7 @@ static int tcf_fill_node(struct net *net, struct sk_buff *skb,
 		tcm->tcm_ifindex = TCM_IFINDEX_MAGIC_BLOCK;
 		tcm->tcm_block_index = block->index;
 	}
-	tcm->tcm_info = TC_H_MAKE(tp->prio, tp->protocol);
+	tcm->tcm_info = TC_H_MAKE(tp->prio, be16_to_cpu(tp->protocol));
 	if (nla_put_string(skb, TCA_KIND, tp->ops->kind))
 		goto nla_put_failure;
 	if (nla_put_u32(skb, TCA_CHAIN, tp->chain->index))
@@ -2692,7 +2692,7 @@ static bool tcf_chain_dump(struct tcf_chain *chain, struct Qdisc *q, u32 parent,
 		    TC_H_MAJ(tcm->tcm_info) != tp->prio)
 			continue;
 		if (TC_H_MIN(tcm->tcm_info) &&
-		    TC_H_MIN(tcm->tcm_info) != tp->protocol)
+		    TC_H_MIN(tcm->tcm_info) != be16_to_cpu(tp->protocol))
 			continue;
 		if (*p_index > index_start)
 			memset(&cb->args[1], 0,
-- 
2.34.1


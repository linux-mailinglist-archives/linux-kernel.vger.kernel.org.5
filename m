Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13E9E7F06D1
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Nov 2023 15:18:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231249AbjKSOSQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Nov 2023 09:18:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbjKSOSP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Nov 2023 09:18:15 -0500
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A556D8;
        Sun, 19 Nov 2023 06:18:11 -0800 (PST)
X-UUID: 8eb5c85fb2714c018d1e8a618d27cac0-20231119
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.32,REQID:661f8516-2c44-4979-83c9-b67b63f7962d,IP:5,U
        RL:0,TC:0,Content:-5,EDM:25,RT:0,SF:-9,FILE:0,BULK:0,RULE:Release_Ham,ACTI
        ON:release,TS:16
X-CID-INFO: VERSION:1.1.32,REQID:661f8516-2c44-4979-83c9-b67b63f7962d,IP:5,URL
        :0,TC:0,Content:-5,EDM:25,RT:0,SF:-9,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:16
X-CID-META: VersionHash:5f78ec9,CLOUDID:62273a60-c89d-4129-91cb-8ebfae4653fc,B
        ulkID:23111922180477X7G00C,BulkQuantity:0,Recheck:0,SF:66|24|17|19|45|102,
        TC:nil,Content:0,EDM:5,IP:-2,URL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL
        :0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI,
        TF_CID_SPAM_ULN
X-UUID: 8eb5c85fb2714c018d1e8a618d27cac0-20231119
X-User: chentao@kylinos.cn
Received: from vt.. [(116.128.244.169)] by mailgw
        (envelope-from <chentao@kylinos.cn>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 941921833; Sun, 19 Nov 2023 22:18:03 +0800
From:   Kunwu Chan <chentao@kylinos.cn>
To:     edumazet@google.com
Cc:     chentao@kylinos.cn, davem@davemloft.net, dsahern@kernel.org,
        kuba@kernel.org, kunwu.chan@hotmail.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        pabeni@redhat.com
Subject: [PATCH v2] ipv4: Correct/silence an endian warning in __ip_do_redirect
Date:   Sun, 19 Nov 2023 22:17:59 +0800
Message-Id: <20231119141759.420477-1-chentao@kylinos.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CANn89iLHd9oxO6yXmZMfO5cTsnSzqa==ZBCnNEySKpiH86q54Q@mail.gmail.com>
References: <CANn89iLHd9oxO6yXmZMfO5cTsnSzqa==ZBCnNEySKpiH86q54Q@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

net/ipv4/route.c:783:46: warning: incorrect type in argument 2 (different base types)
net/ipv4/route.c:783:46:    expected unsigned int [usertype] key
net/ipv4/route.c:783:46:    got restricted __be32 [usertype] new_gw

Fixes: 969447f226b4 ("ipv4: use new_gw for redirect neigh lookup")
Suggested-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
---
 net/ipv4/route.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index 3290a4442b4a..16615d107cf0 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -780,7 +780,7 @@ static void __ip_do_redirect(struct rtable *rt, struct sk_buff *skb, struct flow
 			goto reject_redirect;
 	}
 
-	n = __ipv4_neigh_lookup(rt->dst.dev, new_gw);
+	n = __ipv4_neigh_lookup(rt->dst.dev, (__force u32)new_gw);
 	if (!n)
 		n = neigh_create(&arp_tbl, &new_gw, rt->dst.dev);
 	if (!IS_ERR(n)) {
-- 
2.34.1


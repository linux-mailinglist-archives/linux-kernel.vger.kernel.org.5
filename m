Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 518BB7EF599
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 16:48:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232579AbjKQPss (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 10:48:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231589AbjKQPsq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 10:48:46 -0500
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94D4D8E;
        Fri, 17 Nov 2023 07:48:41 -0800 (PST)
X-UUID: 42202419321f4071949da05307dc4218-20231117
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.32,REQID:0a6c0f97-5bf5-41bc-bedf-f1ff9792820f,IP:15,
        URL:0,TC:0,Content:-5,EDM:25,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,AC
        TION:release,TS:20
X-CID-INFO: VERSION:1.1.32,REQID:0a6c0f97-5bf5-41bc-bedf-f1ff9792820f,IP:15,UR
        L:0,TC:0,Content:-5,EDM:25,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTI
        ON:release,TS:20
X-CID-META: VersionHash:5f78ec9,CLOUDID:55ab8495-10ce-4e4b-85c2-c9b5229ff92b,B
        ulkID:231117234836C0FXRSJW,BulkQuantity:0,Recheck:0,SF:38|24|17|19|44|66|1
        02,TC:nil,Content:0,EDM:5,IP:-2,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL
        :0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI,TF_CID_SPAM_SNR
X-UUID: 42202419321f4071949da05307dc4218-20231117
X-User: chentao@kylinos.cn
Received: from vt.. [(116.128.244.169)] by mailgw
        (envelope-from <chentao@kylinos.cn>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 572890764; Fri, 17 Nov 2023 23:48:35 +0800
From:   Kunwu Chan <chentao@kylinos.cn>
To:     davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com
Cc:     kunwu.chan@hotmail.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Kunwu Chan <chentao@kylinos.cn>
Subject: [PATCH] ipv6: Correct/silence an endian warning in ip6_multipath_l3_keys
Date:   Fri, 17 Nov 2023 23:48:31 +0800
Message-Id: <20231117154831.2518110-1-chentao@kylinos.cn>
X-Mailer: git-send-email 2.34.1
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

net/ipv6/route.c:2332:39: warning: incorrect type in assignment (different base types)
net/ipv6/route.c:2332:39:    expected unsigned int [usertype] flow_label
net/ipv6/route.c:2332:39:    got restricted __be32

Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
---
 net/ipv6/route.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index b132feae3393..692c811eb786 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -2329,7 +2329,7 @@ static void ip6_multipath_l3_keys(const struct sk_buff *skb,
 	} else {
 		keys->addrs.v6addrs.src = key_iph->saddr;
 		keys->addrs.v6addrs.dst = key_iph->daddr;
-		keys->tags.flow_label = ip6_flowlabel(key_iph);
+		keys->tags.flow_label = be32_to_cpu(ip6_flowlabel(key_iph));
 		keys->basic.ip_proto = key_iph->nexthdr;
 	}
 }
-- 
2.34.1


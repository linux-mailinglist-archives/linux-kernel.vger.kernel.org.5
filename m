Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CFF47EEEB2
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 10:32:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345821AbjKQJcP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 04:32:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235745AbjKQJby (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 04:31:54 -0500
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30BB31BF4;
        Fri, 17 Nov 2023 01:31:22 -0800 (PST)
X-UUID: 741c89e8083b44548c3e8f5979b47101-20231117
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.32,REQID:1dbef51b-9855-4ee6-a412-64bef59f35a1,IP:5,U
        RL:0,TC:0,Content:0,EDM:25,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTI
        ON:release,TS:15
X-CID-INFO: VERSION:1.1.32,REQID:1dbef51b-9855-4ee6-a412-64bef59f35a1,IP:5,URL
        :0,TC:0,Content:0,EDM:25,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:15
X-CID-META: VersionHash:5f78ec9,CLOUDID:2ca5c472-1bd3-4f48-b671-ada88705968c,B
        ulkID:231117172305AN6C5S4D,BulkQuantity:1,Recheck:0,SF:66|38|24|17|19|44|1
        02,TC:nil,Content:0,EDM:5,IP:-2,URL:0,File:nil,Bulk:40,QS:nil,BEC:nil,COL:
        0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_FSD,TF_CID_SPAM_FSI,TF_CID_SPAM_SNR,TF_CID_SPAM_FAS
X-UUID: 741c89e8083b44548c3e8f5979b47101-20231117
X-User: chentao@kylinos.cn
Received: from vt.. [(116.128.244.169)] by mailgw
        (envelope-from <chentao@kylinos.cn>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 842865564; Fri, 17 Nov 2023 17:31:14 +0800
From:   Kunwu Chan <chentao@kylinos.cn>
To:     jhs@mojatatu.com, xiyou.wangcong@gmail.com, jiri@resnulli.us,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com
Cc:     kunwu.chan@hotmail.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Kunwu Chan <chentao@kylinos.cn>
Subject: [PATCH] net: sched: Fix an endian bug in tcf_proto_create
Date:   Fri, 17 Nov 2023 17:31:10 +0800
Message-Id: <20231117093110.1842011-1-chentao@kylinos.cn>
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

net/sched/cls_api.c:390:22: warning: incorrect type in assignment (different base types)
net/sched/cls_api.c:390:22:    expected restricted __be16 [usertype] protocol
net/sched/cls_api.c:390:22:    got unsigned int [usertype] protocol

Fixes: 33a48927c193 ("sched: push TC filter protocol creation into a separate function")

Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
---
 net/sched/cls_api.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/sched/cls_api.c b/net/sched/cls_api.c
index 1976bd163986..f73f39f61f66 100644
--- a/net/sched/cls_api.c
+++ b/net/sched/cls_api.c
@@ -387,7 +387,7 @@ static struct tcf_proto *tcf_proto_create(const char *kind, u32 protocol,
 		goto errout;
 	}
 	tp->classify = tp->ops->classify;
-	tp->protocol = protocol;
+	tp->protocol = cpu_to_be16(protocol);
 	tp->prio = prio;
 	tp->chain = chain;
 	spin_lock_init(&tp->lock);
-- 
2.34.1


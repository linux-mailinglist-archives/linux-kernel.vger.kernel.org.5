Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 696787F0E8C
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 10:08:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232370AbjKTJIW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 04:08:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232176AbjKTJIU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 04:08:20 -0500
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EE8FB8
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 01:08:13 -0800 (PST)
X-UUID: a9430cdac30a41a1804c6ba6df71fe60-20231120
X-CID-O-RULE: Release_Ham
X-CID-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.32,REQID:b82c19e5-d93e-450f-80f3-6122677b0c13,IP:10,
        URL:0,TC:0,Content:0,EDM:25,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACT
        ION:release,TS:20
X-CID-INFO: VERSION:1.1.32,REQID:b82c19e5-d93e-450f-80f3-6122677b0c13,IP:10,UR
        L:0,TC:0,Content:0,EDM:25,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:20
X-CID-META: VersionHash:5f78ec9,CLOUDID:f336da72-1bd3-4f48-b671-ada88705968c,B
        ulkID:23112017080368A5O3NH,BulkQuantity:0,Recheck:0,SF:17|19|44|66|38|24|1
        02,TC:nil,Content:0,EDM:5,IP:-2,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL
        :0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI
X-UUID: a9430cdac30a41a1804c6ba6df71fe60-20231120
X-User: gehao@kylinos.cn
Received: from localhost.localdomain [(116.128.244.171)] by mailgw
        (envelope-from <gehao@kylinos.cn>)
        (Generic MTA)
        with ESMTP id 1345845564; Mon, 20 Nov 2023 17:08:01 +0800
From:   Hao Ge <gehao@kylinos.cn>
To:     vadim.fedorenko@linux.dev, arkadiusz.kubalewski@intel.com
Cc:     michal.michalik@intel.com, davem@davemloft.net,
        linux-kernel@vger.kernel.org, gehao618@163.com,
        Hao Ge <gehao@kylinos.cn>
Subject: [PATCH] dpll: Fix potential msg  memleak in dpll_nl_pin_id_get_doit
Date:   Mon, 20 Nov 2023 17:07:58 +0800
Message-Id: <20231120090758.31378-1-gehao@kylinos.cn>
X-Mailer: git-send-email 2.25.1
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

We should clean the skb resource if genlmsg_put_reply failed.

Fixes: 9d71b54b65b1 ("dpll: netlink: Add DPLL framework base functions")
Signed-off-by: Hao Ge <gehao@kylinos.cn>
---
 drivers/dpll/dpll_netlink.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/dpll/dpll_netlink.c b/drivers/dpll/dpll_netlink.c
index a6dc3997bf5c..54051cd34d43 100644
--- a/drivers/dpll/dpll_netlink.c
+++ b/drivers/dpll/dpll_netlink.c
@@ -1093,9 +1093,10 @@ int dpll_nl_pin_id_get_doit(struct sk_buff *skb, struct genl_info *info)
 		return -ENOMEM;
 	hdr = genlmsg_put_reply(msg, info, &dpll_nl_family, 0,
 				DPLL_CMD_PIN_ID_GET);
-	if (!hdr)
+	if (!hdr) {
+		nlmsg_free(msg);
 		return -EMSGSIZE;
-
+	}
 	pin = dpll_pin_find_from_nlattr(info);
 	if (!IS_ERR(pin)) {
 		ret = dpll_msg_add_pin_handle(msg, pin);
-- 
2.25.1


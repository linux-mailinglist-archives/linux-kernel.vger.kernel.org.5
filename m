Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 067107F232E
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 02:37:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232753AbjKUBhm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 20:37:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbjKUBhk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 20:37:40 -0500
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 667BEC3;
        Mon, 20 Nov 2023 17:37:34 -0800 (PST)
X-UUID: 62c48a5a100b4b4ead9a4fb32c438a00-20231121
X-CID-O-RULE: Release_Ham
X-CID-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.32,REQID:965a29ac-56dc-46d8-a307-4f1ab437876e,IP:20,
        URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTI
        ON:release,TS:5
X-CID-INFO: VERSION:1.1.32,REQID:965a29ac-56dc-46d8-a307-4f1ab437876e,IP:20,UR
        L:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:5
X-CID-META: VersionHash:5f78ec9,CLOUDID:11ed4860-c89d-4129-91cb-8ebfae4653fc,B
        ulkID:2311210937206P72F2ON,BulkQuantity:0,Recheck:0,SF:17|19|44|66|38|24|1
        02,TC:nil,Content:0,EDM:-3,IP:-2,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,CO
        L:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI
X-UUID: 62c48a5a100b4b4ead9a4fb32c438a00-20231121
X-User: gehao@kylinos.cn
Received: from localhost.localdomain [(116.128.244.171)] by mailgw
        (envelope-from <gehao@kylinos.cn>)
        (Generic MTA)
        with ESMTP id 458859203; Tue, 21 Nov 2023 09:37:17 +0800
From:   Hao Ge <gehao@kylinos.cn>
To:     vadim.fedorenko@linux.dev, arkadiusz.kubalewski@intel.com
Cc:     jiri@resnulli.us, michal.michalik@intel.com, davem@davemloft.net,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        Hao Ge <gehao@kylinos.cn>
Subject: [PATCH v2] dpll: Fix potential msg memleak when genlmsg_put_reply failed
Date:   Tue, 21 Nov 2023 09:37:09 +0800
Message-Id: <20231121013709.73323-1-gehao@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <0c6e0cd5-d975-41cc-824e-10b5e28251a2@linux.dev>
References: <0c6e0cd5-d975-41cc-824e-10b5e28251a2@linux.dev>
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
v1 -> v2: change title due to add some similar fix for some similar cases
---
 drivers/dpll/dpll_netlink.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/dpll/dpll_netlink.c b/drivers/dpll/dpll_netlink.c
index a6dc3997bf5c..442a0ebeb953 100644
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
@@ -1123,8 +1124,10 @@ int dpll_nl_pin_get_doit(struct sk_buff *skb, struct genl_info *info)
 		return -ENOMEM;
 	hdr = genlmsg_put_reply(msg, info, &dpll_nl_family, 0,
 				DPLL_CMD_PIN_GET);
-	if (!hdr)
+	if (!hdr) {
+		nlmsg_free(msg);
 		return -EMSGSIZE;
+	}
 	ret = dpll_cmd_pin_get_one(msg, pin, info->extack);
 	if (ret) {
 		nlmsg_free(msg);
@@ -1256,8 +1259,10 @@ int dpll_nl_device_id_get_doit(struct sk_buff *skb, struct genl_info *info)
 		return -ENOMEM;
 	hdr = genlmsg_put_reply(msg, info, &dpll_nl_family, 0,
 				DPLL_CMD_DEVICE_ID_GET);
-	if (!hdr)
+	if (!hdr) {
+		nlmsg_free(msg);
 		return -EMSGSIZE;
+	}
 
 	dpll = dpll_device_find_from_nlattr(info);
 	if (!IS_ERR(dpll)) {
@@ -1284,8 +1289,10 @@ int dpll_nl_device_get_doit(struct sk_buff *skb, struct genl_info *info)
 		return -ENOMEM;
 	hdr = genlmsg_put_reply(msg, info, &dpll_nl_family, 0,
 				DPLL_CMD_DEVICE_GET);
-	if (!hdr)
+	if (!hdr) {
+		nlmsg_free(msg);
 		return -EMSGSIZE;
+	}
 
 	ret = dpll_device_get_one(dpll, msg, info->extack);
 	if (ret) {
-- 
2.25.1


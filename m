Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3CD77F9207
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Nov 2023 10:47:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229460AbjKZJha (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Nov 2023 04:37:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjKZJh3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Nov 2023 04:37:29 -0500
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C925FB
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 01:37:32 -0800 (PST)
X-UUID: 3f9bbc6d8e9b48aba667ee1e0f313a0b-20231126
X-CID-O-RULE: Release_Ham
X-CID-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.33,REQID:4e935d8f-4b1f-4b86-8762-f3fc8d4820c5,IP:15,
        URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTI
        ON:release,TS:0
X-CID-INFO: VERSION:1.1.33,REQID:4e935d8f-4b1f-4b86-8762-f3fc8d4820c5,IP:15,UR
        L:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:0
X-CID-META: VersionHash:364b77b,CLOUDID:05c1f4fc-4a48-46e2-b946-12f04f20af8c,B
        ulkID:231126173724GJO4SPNI,BulkQuantity:0,Recheck:0,SF:66|38|24|17|19|44|1
        02,TC:nil,Content:0,EDM:-3,IP:-2,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,CO
        L:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI
X-UUID: 3f9bbc6d8e9b48aba667ee1e0f313a0b-20231126
X-User: chentao@kylinos.cn
Received: from vt.. [(116.128.244.169)] by mailgw
        (envelope-from <chentao@kylinos.cn>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 571591659; Sun, 26 Nov 2023 17:37:23 +0800
From:   Kunwu Chan <chentao@kylinos.cn>
To:     mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu,
        bgray@linux.ibm.com, maddy@linux.vnet.ibm.com,
        bigeasy@linutronix.de, hemant@linux.vnet.ibm.com,
        anju@linux.vnet.ibm.com, kjain@linux.ibm.com
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        kunwu.chan@hotmail.com, Kunwu Chan <chentao@kylinos.cn>
Subject: [PATCH] powerpc/imc-pmu: Fix null pointer dereference in update_events_in_group
Date:   Sun, 26 Nov 2023 17:37:19 +0800
Message-Id: <20231126093719.1440305-1-chentao@kylinos.cn>
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

kasprintf() returns a pointer to dynamically allocated memory
which can be NULL upon failure.

Fixes: 885dcd709ba9 ("powerpc/perf: Add nest IMC PMU support")
Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
---
 arch/powerpc/perf/imc-pmu.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/powerpc/perf/imc-pmu.c b/arch/powerpc/perf/imc-pmu.c
index 5d12ca386c1f..8664a7d297ad 100644
--- a/arch/powerpc/perf/imc-pmu.c
+++ b/arch/powerpc/perf/imc-pmu.c
@@ -299,6 +299,8 @@ static int update_events_in_group(struct device_node *node, struct imc_pmu *pmu)
 	attr_group->attrs = attrs;
 	do {
 		ev_val_str = kasprintf(GFP_KERNEL, "event=0x%x", pmu->events[i].value);
+		if (!ev_val_str)
+			continue;
 		dev_str = device_str_attr_create(pmu->events[i].name, ev_val_str);
 		if (!dev_str)
 			continue;
@@ -306,6 +308,8 @@ static int update_events_in_group(struct device_node *node, struct imc_pmu *pmu)
 		attrs[j++] = dev_str;
 		if (pmu->events[i].scale) {
 			ev_scale_str = kasprintf(GFP_KERNEL, "%s.scale", pmu->events[i].name);
+			if (!ev_scale_str)
+				continue;
 			dev_str = device_str_attr_create(ev_scale_str, pmu->events[i].scale);
 			if (!dev_str)
 				continue;
@@ -315,6 +319,8 @@ static int update_events_in_group(struct device_node *node, struct imc_pmu *pmu)
 
 		if (pmu->events[i].unit) {
 			ev_unit_str = kasprintf(GFP_KERNEL, "%s.unit", pmu->events[i].name);
+			if (!ev_unit_str)
+				continue;
 			dev_str = device_str_attr_create(ev_unit_str, pmu->events[i].unit);
 			if (!dev_str)
 				continue;
-- 
2.34.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 901D1768B81
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 08:04:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230001AbjGaGEp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 02:04:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229900AbjGaGEn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 02:04:43 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0174F19A;
        Sun, 30 Jul 2023 23:04:34 -0700 (PDT)
X-UUID: 1ca36db42f6811ee9cb5633481061a41-20230731
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=+lnUzFtifQcG2A6oHumF4miAfjUWpISRACM82jysLOM=;
        b=U0mSJuHlJj/D1hiHM0qjsQDbUgb7jHOx9fDIjDPpelPP6sMIAvvQOvk7etVus7OBHwMNdkI6tJTfqCCgxp/SfAFHM067O37HDqQ1MSQGDhD4qS0uEasVFsWSbYUlUWcC4sAztJPD0RnVHHloqw6bk2wcPP8fFDV3Cdwr0edJZXA=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.30,REQID:5d266df9-6e50-4a0b-af6d-6c682bb7c215,IP:0,U
        RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:-25
X-CID-META: VersionHash:1fcc6f8,CLOUDID:7821a242-d291-4e62-b539-43d7d78362ba,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 1ca36db42f6811ee9cb5633481061a41-20230731
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <clive.lin@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1318058727; Mon, 31 Jul 2023 14:04:29 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 31 Jul 2023 14:04:28 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 31 Jul 2023 14:04:28 +0800
From:   Clive Lin <clive.lin@mediatek.com>
To:     <rafael@kernel.org>, <pavel@ucw.cz>, <len.brown@intel.com>
CC:     <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <chung-kai.yang@mediatek.com>, <ccj.yeh@mediatek.com>,
        <clive.lin@mediatek.com>, <ching-hao.hsu@mediatek.com>
Subject: [PATCH] PM: QoS: Add check to make sure CPU latency is non-negative
Date:   Mon, 31 Jul 2023 14:03:54 +0800
Message-ID: <20230731060354.4802-1-clive.lin@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CPU latency should never be negative, which will be incorrectly high
when converted to unsigned data type. Commit 8d36694245f2 ("PM: QoS:
Add check to make sure CPU freq is non-negative") makes sure CPU freq
is non-negative to fix incorrect behavior in freq_qos. Adding a check
to make sure CPU latency is non-negative can prevent this problem
from happening in cpu_latency_qos.

Signed-off-by: Clive Lin <clive.lin@mediatek.com>
---
 kernel/power/qos.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/kernel/power/qos.c b/kernel/power/qos.c
index 782d3b41c1f3..4244b069442e 100644
--- a/kernel/power/qos.c
+++ b/kernel/power/qos.c
@@ -220,6 +220,11 @@ static struct pm_qos_constraints cpu_latency_constraints = {
 	.type = PM_QOS_MIN,
 };
 
+static inline bool cpu_latency_qos_value_invalid(s32 value)
+{
+	return value < 0 && value != PM_QOS_DEFAULT_VALUE;
+}
+
 /**
  * cpu_latency_qos_limit - Return current system-wide CPU latency QoS limit.
  */
@@ -263,7 +268,7 @@ static void cpu_latency_qos_apply(struct pm_qos_request *req,
  */
 void cpu_latency_qos_add_request(struct pm_qos_request *req, s32 value)
 {
-	if (!req)
+	if (!req || cpu_latency_qos_value_invalid(value))
 		return;
 
 	if (cpu_latency_qos_request_active(req)) {
@@ -289,7 +294,7 @@ EXPORT_SYMBOL_GPL(cpu_latency_qos_add_request);
  */
 void cpu_latency_qos_update_request(struct pm_qos_request *req, s32 new_value)
 {
-	if (!req)
+	if (!req || cpu_latency_qos_value_invalid(new_value))
 		return;
 
 	if (!cpu_latency_qos_request_active(req)) {
-- 
2.18.0


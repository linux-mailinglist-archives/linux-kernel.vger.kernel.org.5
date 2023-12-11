Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98CF780C3ED
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 10:04:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234100AbjLKJEM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 04:04:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbjLKJEL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 04:04:11 -0500
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09E9DF2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 01:04:14 -0800 (PST)
X-UUID: ddb7c8ac5a7740c39319e8105f29cf2c-20231211
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.33,REQID:1d2c04cf-5843-4420-b84c-766dfd178ec5,IP:5,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:-10
X-CID-INFO: VERSION:1.1.33,REQID:1d2c04cf-5843-4420-b84c-766dfd178ec5,IP:5,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:-10
X-CID-META: VersionHash:364b77b,CLOUDID:c34d87fd-4a48-46e2-b946-12f04f20af8c,B
        ulkID:2312111704042F6WSKZH,BulkQuantity:0,Recheck:0,SF:17|19|44|66|38|24|1
        02,TC:nil,Content:0,EDM:-3,IP:-2,URL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil
        ,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_FSD,TF_CID_SPAM_FSI,TF_CID_SPAM_ULN,TF_CID_SPAM_SNR,
        TF_CID_SPAM_FAS
X-UUID: ddb7c8ac5a7740c39319e8105f29cf2c-20231211
X-User: chentao@kylinos.cn
Received: from vt.. [(116.128.244.169)] by mailgw
        (envelope-from <chentao@kylinos.cn>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1939800852; Mon, 11 Dec 2023 17:04:02 +0800
From:   Kunwu Chan <chentao@kylinos.cn>
To:     will@kernel.org, mark.rutland@arm.com
Cc:     Ganapatrao.Kulkarni@cavium.com, suzuki.poulose@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Kunwu Chan <chentao@kylinos.cn>,
        Kunwu Chan <kunwu.chan@hotmail.com>
Subject: [PATCH] drivers/perf: Fix some null pointer dereference issues in thunderx2_pmu.c
Date:   Mon, 11 Dec 2023 17:03:47 +0800
Message-Id: <20231211090347.265240-1-chentao@kylinos.cn>
X-Mailer: git-send-email 2.39.2
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

devm_kasprintf() returns a pointer to dynamically allocated memory
which can be NULL upon failure.

Fixes: 69c32972d593 ("drivers/perf: Add Cavium ThunderX2 SoC UNCORE PMU driver")
Cc: Kunwu Chan <kunwu.chan@hotmail.com>
Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
---
 drivers/perf/thunderx2_pmu.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/perf/thunderx2_pmu.c b/drivers/perf/thunderx2_pmu.c
index 1edb9c03704f..07edb174a0d7 100644
--- a/drivers/perf/thunderx2_pmu.c
+++ b/drivers/perf/thunderx2_pmu.c
@@ -742,6 +742,8 @@ static int tx2_uncore_pmu_register(
 
 	tx2_pmu->pmu.name = devm_kasprintf(dev, GFP_KERNEL,
 			"%s", name);
+	if (!tx2_pmu->pmu.name)
+		return -ENOMEM;
 
 	return perf_pmu_register(&tx2_pmu->pmu, tx2_pmu->pmu.name, -1);
 }
@@ -881,6 +883,11 @@ static struct tx2_uncore_pmu *tx2_uncore_pmu_init_dev(struct device *dev,
 		return NULL;
 	}
 
+	if (!tx2_pmu->name) {
+		dev_err(dev, "PMU type %d: Fail to allocate memory\n", type);
+		devm_kfree(dev, tx2_pmu);
+		return NULL;
+	}
 	return tx2_pmu;
 }
 
-- 
2.39.2


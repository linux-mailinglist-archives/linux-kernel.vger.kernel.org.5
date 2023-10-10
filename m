Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C7747BF2C7
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 08:11:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442196AbjJJGLG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 02:11:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379414AbjJJGLE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 02:11:04 -0400
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BAC39D
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 23:11:01 -0700 (PDT)
X-UUID: ce3d942ff2a44ad3b728ecdcedaf844a-20231010
X-CID-O-RULE: Release_Ham
X-CID-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.32,REQID:c49a5ea7-1b9b-42fd-a0bb-4dfab2ba0dd4,IP:15,
        URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTI
        ON:release,TS:0
X-CID-INFO: VERSION:1.1.32,REQID:c49a5ea7-1b9b-42fd-a0bb-4dfab2ba0dd4,IP:15,UR
        L:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:0
X-CID-META: VersionHash:5f78ec9,CLOUDID:10d39df0-9a6e-4c39-b73e-f2bc08ca3dc5,B
        ulkID:231010101005VJRJ2L0N,BulkQuantity:2,Recheck:0,SF:24|17|19|44|102,TC:
        nil,Content:0,EDM:-3,IP:-2,URL:0,File:nil,Bulk:40,QS:nil,BEC:nil,COL:0,OSI
        :0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI
X-UUID: ce3d942ff2a44ad3b728ecdcedaf844a-20231010
X-User: chentao@kylinos.cn
Received: from localhost.localdomain [(116.128.244.169)] by mailgw
        (envelope-from <chentao@kylinos.cn>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 189130116; Tue, 10 Oct 2023 14:10:43 +0800
From:   "Kunwu.Chan" <chentao@kylinos.cn>
To:     kevinyang.wang@amd.com
Cc:     Alexander.Deucher@amd.com, Asad.Kamal@amd.com,
        Christian.Koenig@amd.com, Hawking.Zhang@amd.com, Le.Ma@amd.com,
        Lijo.Lazar@amd.com, Xinhui.Pan@amd.com, airlied@gmail.com,
        amd-gfx@lists.freedesktop.org, chentao@kylinos.cn,
        dan.carpenter@linaro.org, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, evan.quan@amd.com,
        kunwu.chan@hotmail.com, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/amd/pm: Fix a memory leak on an error path
Date:   Tue, 10 Oct 2023 14:10:39 +0800
Message-Id: <20231010061039.75878-1-chentao@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <PH7PR12MB5997C208CDD4587332346CD782CDA@PH7PR12MB5997.namprd12.prod.outlook.com>
References: <PH7PR12MB5997C208CDD4587332346CD782CDA@PH7PR12MB5997.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing free on an error path.

Fixes: 511a95552ec8 ("drm/amd/pm: Add SMU 13.0.6 support")
Signed-off-by: Kunwu.Chan <chentao@kylinos.cn>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index ce971a93d28b..c26e12ff532c 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -1981,8 +1981,10 @@ static ssize_t smu_v13_0_6_get_gpu_metrics(struct smu_context *smu, void **table
 
 	metrics = kzalloc(sizeof(MetricsTable_t), GFP_KERNEL);
 	ret = smu_v13_0_6_get_metrics_table(smu, metrics, true);
-	if (ret)
+	if (ret) {
+		kfree(metrics);
 		return ret;
+	}
 
 	smu_cmn_init_soft_gpu_metrics(gpu_metrics, 1, 3);
 
-- 
2.25.1


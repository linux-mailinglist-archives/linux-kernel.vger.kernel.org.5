Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29AC57F5710
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 04:34:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344514AbjKWDdx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 22:33:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232584AbjKWDdv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 22:33:51 -0500
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2876199;
        Wed, 22 Nov 2023 19:33:56 -0800 (PST)
X-UUID: a4cb450929be4957b020d6d1885e0822-20231123
X-CID-O-RULE: Release_Ham
X-CID-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.32,REQID:31d8fe63-6051-4232-9283-7126707a066e,IP:15,
        URL:0,TC:0,Content:0,EDM:25,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACT
        ION:release,TS:25
X-CID-INFO: VERSION:1.1.32,REQID:31d8fe63-6051-4232-9283-7126707a066e,IP:15,UR
        L:0,TC:0,Content:0,EDM:25,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:25
X-CID-META: VersionHash:5f78ec9,CLOUDID:583a6160-c89d-4129-91cb-8ebfae4653fc,B
        ulkID:2311231133474R7T9XYL,BulkQuantity:0,Recheck:0,SF:19|44|66|38|24|17|1
        02,TC:nil,Content:0,EDM:5,IP:-2,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL
        :0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI
X-UUID: a4cb450929be4957b020d6d1885e0822-20231123
X-User: chentao@kylinos.cn
Received: from vt.. [(116.128.244.169)] by mailgw
        (envelope-from <chentao@kylinos.cn>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 591889600; Thu, 23 Nov 2023 11:33:46 +0800
From:   Kunwu Chan <chentao@kylinos.cn>
To:     robdclark@gmail.com, quic_abhinavk@quicinc.com,
        dmitry.baryshkov@linaro.org, sean@poorly.run,
        marijn.suijten@somainline.org, airlied@gmail.com, daniel@ffwll.ch,
        jordan@cosmicpenguin.net, konrad.dybcio@linaro.org
Cc:     kunwu.chan@hotmail.com, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Kunwu Chan <chentao@kylinos.cn>
Subject: [PATCH] drm/msm/gpu: Fix null-pointer dereference in zap_shader_load_mdt
Date:   Thu, 23 Nov 2023 11:33:29 +0800
Message-Id: <20231123033329.27477-1-chentao@kylinos.cn>
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

kasprintf() returns a pointer to dynamically allocated memory
which can be NULL upon failure. Ensure the allocation was successful
by checking the pointer validity.

Fixes: a9e2559c931d ("drm/msm/gpu: Move zap shader loading to adreno")
Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
---
 drivers/gpu/drm/msm/adreno/adreno_gpu.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.c b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
index 3fe9fd240cc7..0ebf86ffd57b 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
@@ -144,6 +144,10 @@ static int zap_shader_load_mdt(struct msm_gpu *gpu, const char *fwname,
 		char *newname;
 
 		newname = kasprintf(GFP_KERNEL, "qcom/%s", fwname);
+		if (!newname) {
+			ret = -ENOMEM;
+			goto out;
+		}
 
 		ret = qcom_mdt_load(dev, fw, newname, pasid,
 				mem_region, mem_phys, mem_size, NULL);
-- 
2.34.1


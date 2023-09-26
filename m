Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D10C7AE554
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 07:56:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233692AbjIZF4u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 01:56:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233689AbjIZF4r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 01:56:47 -0400
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FE1810A
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 22:56:40 -0700 (PDT)
X-UUID: 48b130231b3f480fa2b389aa17cc4c13-20230926
X-CID-O-RULE: Release_Ham
X-CID-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.31,REQID:274d52f7-406d-450b-9626-9226bea3d323,IP:5,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:-10
X-CID-INFO: VERSION:1.1.31,REQID:274d52f7-406d-450b-9626-9226bea3d323,IP:5,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:-10
X-CID-META: VersionHash:0ad78a4,CLOUDID:710a47bf-14cc-44ca-b657-2d2783296e72,B
        ulkID:23092613562995M22TSX,BulkQuantity:0,Recheck:0,SF:19|44|38|24|17|102,
        TC:nil,Content:0,EDM:-3,IP:-2,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
        ,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI
X-UUID: 48b130231b3f480fa2b389aa17cc4c13-20230926
X-User: liucong2@kylinos.cn
Received: from localhost.localdomain [(116.128.244.169)] by mailgw
        (envelope-from <liucong2@kylinos.cn>)
        (Generic MTA)
        with ESMTP id 827163063; Tue, 26 Sep 2023 13:56:29 +0800
From:   Cong Liu <liucong2@kylinos.cn>
To:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Aurabindo Pillai <aurabindo.pillai@amd.com>,
        Tom Chung <chiahsuan.chung@amd.com>
Cc:     Cong Liu <liucong2@kylinos.cn>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] drm/amd/display: Fix null pointer dereference in error message
Date:   Tue, 26 Sep 2023 13:56:17 +0800
Message-Id: <20230926055618.119195-1-liucong2@kylinos.cn>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes a null pointer dereference in the error message that is
printed when the Display Core (DC) fails to initialize. The original
message includes the DC version number, which is undefined if the DC is
not initialized.

Fixes: 9788d087caff ("drm/amd/display: improve the message printed when loading DC")
Signed-off-by: Cong Liu <liucong2@kylinos.cn>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 8e98dda1e084..bf52a909f558 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1703,8 +1703,7 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
 		DRM_INFO("Display Core v%s initialized on %s\n", DC_VER,
 			 dce_version_to_string(adev->dm.dc->ctx->dce_version));
 	} else {
-		DRM_INFO("Display Core v%s failed to initialize on %s\n", DC_VER,
-			 dce_version_to_string(adev->dm.dc->ctx->dce_version));
+		DRM_INFO("Display Core failed to initialize with v%s!\n", DC_VER);
 		goto error;
 	}
 
-- 
2.34.1


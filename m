Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 522AC7A00A3
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 11:46:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236874AbjINJqq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 05:46:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237547AbjINJqS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 05:46:18 -0400
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67D86210C
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 02:46:12 -0700 (PDT)
X-UUID: bebcfc2cd5234480a8d300e4f6e5c3b5-20230914
X-CID-O-RULE: Release_Ham
X-CID-RULE: EDM_GE969F26
X-CID-O-INFO: VERSION:1.1.31,REQID:fd810b43-069c-4082-a0de-37e72278df8d,IP:10,
        URL:0,TC:0,Content:0,EDM:-25,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,AC
        TION:release,TS:-30
X-CID-INFO: VERSION:1.1.31,REQID:fd810b43-069c-4082-a0de-37e72278df8d,IP:10,UR
        L:0,TC:0,Content:0,EDM:-25,RT:0,SF:-15,FILE:0,BULK:0,RULE:EDM_GE969F26,ACT
        ION:release,TS:-30
X-CID-META: VersionHash:0ad78a4,CLOUDID:4256ef13-4929-4845-9571-38c601e9c3c9,B
        ulkID:230914174555IULG59O1,BulkQuantity:0,Recheck:0,SF:19|44|38|24|17|102,
        TC:nil,Content:0,EDM:1,IP:-2,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,
        OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_AEC,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,
        TF_CID_SPAM_FSI
X-UUID: bebcfc2cd5234480a8d300e4f6e5c3b5-20230914
X-User: liucong2@kylinos.cn
Received: from localhost.localdomain [(116.128.244.171)] by mailgw
        (envelope-from <liucong2@kylinos.cn>)
        (Generic MTA)
        with ESMTP id 1588511505; Thu, 14 Sep 2023 17:45:53 +0800
From:   Cong Liu <liucong2@kylinos.cn>
To:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Stanley Yang <Stanley.Yang@amd.com>,
        Hawking Zhang <Hawking.Zhang@amd.com>
Cc:     Cong Liu <liucong2@kylinos.cn>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] fix a memory leak in amdgpu_ras_feature_enable
Date:   Thu, 14 Sep 2023 17:45:33 +0800
Message-Id: <20230914094533.213548-1-liucong2@kylinos.cn>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes a memory leak in the amdgpu_ras_feature_enable() function.
The leak occurs when the function sends a command to the firmware to enable
or disable a RAS feature for a GFX block. If the command fails, the kfree()
function is not called to free the info memory.

Fixes: bf7aa8bea9cb ("drm/amdgpu: Free ras cmd input buffer properly")
Signed-off-by: Cong Liu <liucong2@kylinos.cn>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 8eb6f6943778..b4a8ea946410 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -802,6 +802,7 @@ int amdgpu_ras_feature_enable(struct amdgpu_device *adev,
 				enable ? "enable":"disable",
 				get_ras_block_str(head),
 				amdgpu_ras_is_poison_mode_supported(adev), ret);
+			kfree(info);
 			return ret;
 		}
 
-- 
2.34.1


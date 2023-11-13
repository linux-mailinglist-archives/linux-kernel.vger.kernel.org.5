Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62B407E9591
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 04:36:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233026AbjKMDgs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Nov 2023 22:36:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232997AbjKMDgq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Nov 2023 22:36:46 -0500
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A11D4172B
        for <linux-kernel@vger.kernel.org>; Sun, 12 Nov 2023 19:36:39 -0800 (PST)
X-UUID: d2f97b69a6fe4cc58d719ffe4d8ba132-20231113
X-CID-O-RULE: Release_Ham
X-CID-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.32,REQID:3696d87d-a252-4f52-a8fd-2f3009e7089d,IP:15,
        URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:10
X-CID-INFO: VERSION:1.1.32,REQID:3696d87d-a252-4f52-a8fd-2f3009e7089d,IP:15,UR
        L:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:10
X-CID-META: VersionHash:5f78ec9,CLOUDID:7fb15095-10ce-4e4b-85c2-c9b5229ff92b,B
        ulkID:231113113630XH0FCV1I,BulkQuantity:0,Recheck:0,SF:24|17|19|44|66|38|1
        02,TC:nil,Content:0,EDM:-3,IP:-2,URL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil
        ,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI,
        TF_CID_SPAM_ULN
X-UUID: d2f97b69a6fe4cc58d719ffe4d8ba132-20231113
X-User: heminhong@kylinos.cn
Received: from localhost.localdomain [(116.128.244.169)] by mailgw
        (envelope-from <heminhong@kylinos.cn>)
        (Generic MTA)
        with ESMTP id 1227971306; Mon, 13 Nov 2023 11:36:29 +0800
From:   heminhong <heminhong@kylinos.cn>
To:     jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
        rodrigo.vivi@intel.com, tvrtko.ursulin@linux.intel.com,
        airlied@gmail.com, daniel@ffwll.ch, ville.syrjala@linux.intel.com,
        animesh.manna@intel.com, uma.shankar@intel.com,
        ankit.k.nautiyal@intel.com
Cc:     intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, heminhong <heminhong@kylinos.cn>
Subject: [PATCH] drm/i915: eliminate warnings
Date:   Mon, 13 Nov 2023 11:36:13 +0800
Message-Id: <20231113033613.30339-1-heminhong@kylinos.cn>
X-Mailer: git-send-email 2.25.1
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

Current, the dewake_scanline variable is defined as unsigned int,
an unsigned int variable that is always greater than or equal to 0.
when _intel_dsb_commit function is called by intel_dsb_commit function,
the dewake_scanline variable may have an int value.
So the dewake_scanline variable is necessary to defined as an int.

Signed-off-by: heminhong <heminhong@kylinos.cn>
---
 drivers/gpu/drm/i915/display/intel_dsb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/display/intel_dsb.c b/drivers/gpu/drm/i915/display/intel_dsb.c
index 78b6fe24dcd8..7fd6280c54a7 100644
--- a/drivers/gpu/drm/i915/display/intel_dsb.c
+++ b/drivers/gpu/drm/i915/display/intel_dsb.c
@@ -340,7 +340,7 @@ static int intel_dsb_dewake_scanline(const struct intel_crtc_state *crtc_state)
 }
 
 static void _intel_dsb_commit(struct intel_dsb *dsb, u32 ctrl,
-			      unsigned int dewake_scanline)
+			      int dewake_scanline)
 {
 	struct intel_crtc *crtc = dsb->crtc;
 	struct drm_i915_private *dev_priv = to_i915(crtc->base.dev);
-- 
2.25.1


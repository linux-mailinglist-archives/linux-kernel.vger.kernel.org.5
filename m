Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 480367E1B59
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 08:38:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231186AbjKFHiH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 02:38:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231190AbjKFHiE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 02:38:04 -0500
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DEE3112
        for <linux-kernel@vger.kernel.org>; Sun,  5 Nov 2023 23:37:56 -0800 (PST)
X-UUID: 272ee5e3370f4af59d4d6569884386e7-20231106
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.32,REQID:650d6552-cc29-407a-8975-6d33b1b6e4b1,IP:5,U
        RL:0,TC:0,Content:0,EDM:25,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTI
        ON:release,TS:15
X-CID-INFO: VERSION:1.1.32,REQID:650d6552-cc29-407a-8975-6d33b1b6e4b1,IP:5,URL
        :0,TC:0,Content:0,EDM:25,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:15
X-CID-META: VersionHash:5f78ec9,CLOUDID:6a6332fc-4a48-46e2-b946-12f04f20af8c,B
        ulkID:231106153745CC6A3BO8,BulkQuantity:0,Recheck:0,SF:66|24|17|19|44|102,
        TC:nil,Content:0,EDM:5,IP:-2,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,
        OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI
X-UUID: 272ee5e3370f4af59d4d6569884386e7-20231106
X-User: oushixiong@kylinos.cn
Received: from localhost.localdomain [(116.128.244.169)] by mailgw
        (envelope-from <oushixiong@kylinos.cn>)
        (Generic MTA)
        with ESMTP id 364484791; Mon, 06 Nov 2023 15:37:44 +0800
From:   oushixiong <oushixiong@kylinos.cn>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc:     Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Shixiong Ou <oushixiong@kylinos.cn>
Subject: [PATCH] drm/atomic-helper: Call stall_checks() before allocate drm_crtc_commit
Date:   Mon,  6 Nov 2023 15:37:42 +0800
Message-Id: <20231106073742.158905-1-oushixiong@kylinos.cn>
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

From: Shixiong Ou <oushixiong@kylinos.cn>

Calling stall_checks() before allocating drm_crtc_commit not after that.

Signed-off-by: Shixiong Ou <oushixiong@kylinos.cn>
---
 drivers/gpu/drm/drm_atomic_helper.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/drm_atomic_helper.c
index 2444fc33dd7c..94ea878b240d 100644
--- a/drivers/gpu/drm/drm_atomic_helper.c
+++ b/drivers/gpu/drm/drm_atomic_helper.c
@@ -2283,6 +2283,10 @@ int drm_atomic_helper_setup_commit(struct drm_atomic_state *state,
 	funcs = state->dev->mode_config.helper_private;
 
 	for_each_oldnew_crtc_in_state(state, crtc, old_crtc_state, new_crtc_state, i) {
+		ret = stall_checks(crtc, nonblock);
+		if (ret)
+			return ret;
+
 		commit = kzalloc(sizeof(*commit), GFP_KERNEL);
 		if (!commit)
 			return -ENOMEM;
@@ -2291,10 +2295,6 @@ int drm_atomic_helper_setup_commit(struct drm_atomic_state *state,
 
 		new_crtc_state->commit = commit;
 
-		ret = stall_checks(crtc, nonblock);
-		if (ret)
-			return ret;
-
 		/*
 		 * Drivers only send out events when at least either current or
 		 * new CRTC state is active. Complete right away if everything
-- 
2.25.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7C1D7D7B23
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 05:02:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230518AbjJZDC3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 23:02:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjJZDC0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 23:02:26 -0400
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96FCF184
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 20:02:22 -0700 (PDT)
X-UUID: 481f77edae6f497cb21b70ea84cbe3e5-20231026
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.32,REQID:6b262220-f460-431a-acea-bc1b81d06392,IP:5,U
        RL:-32768,TC:0,Content:0,EDM:-30,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ha
        m,ACTION:release,TS:-40
X-CID-INFO: VERSION:1.1.32,REQID:6b262220-f460-431a-acea-bc1b81d06392,IP:5,URL
        :-32768,TC:0,Content:0,EDM:-30,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,
        ACTION:release,TS:-40
X-CID-META: VersionHash:5f78ec9,CLOUDID:9bd954d7-04a0-4e50-8742-3543eab8cb8e,B
        ulkID:231026110216IKV1SZ4E,BulkQuantity:0,Recheck:0,SF:66|24|17|19|44,TC:n
        il,Content:0,EDM:2,IP:-2,URL:nil,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OS
        I:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI
X-UUID: 481f77edae6f497cb21b70ea84cbe3e5-20231026
X-User: oushixiong@kylinos.cn
Received: from localhost.localdomain [(116.128.244.169)] by mailgw
        (envelope-from <oushixiong@kylinos.cn>)
        (Generic MTA)
        with ESMTP id 1144456334; Thu, 26 Oct 2023 11:02:15 +0800
From:   oushixiong <oushixiong@kylinos.cn>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc:     Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Shixiong Ou <oushixiong@kylinos.cn>
Subject: [PATCH] drm/atomic-helper: Call stall_checks() before allocate drm_crtc_commit
Date:   Thu, 26 Oct 2023 11:02:13 +0800
Message-Id: <20231026030213.115505-1-oushixiong@kylinos.cn>
X-Mailer: git-send-email 2.25.1
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

From: Shixiong Ou <oushixiong@kylinos.cn>

It is wrong to call stall_checks() after allocating memory
for struct drm_crtc_commit as it will cause memory leaks if
too many nonblock commit works return -EBUSY.
So it needs to call stall_checks() before allocate drm_crtc_commit.

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


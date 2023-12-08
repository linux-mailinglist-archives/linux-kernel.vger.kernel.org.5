Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55515809979
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 03:45:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573010AbjLHCpO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 21:45:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573005AbjLHCpM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 21:45:12 -0500
Received: from mxct.zte.com.cn (mxct.zte.com.cn [58.251.27.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61A541708
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 18:45:18 -0800 (PST)
Received: from mxde.zte.com.cn (unknown [10.35.20.165])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxct.zte.com.cn (FangMail) with ESMTPS id 4Smb8p25Pwz5SgL
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 10:45:14 +0800 (CST)
Received: from mxhk.zte.com.cn (unknown [192.168.250.138])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mxde.zte.com.cn (FangMail) with ESMTPS id 4Smb8g5DRTz64Yhq
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 10:45:07 +0800 (CST)
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxhk.zte.com.cn (FangMail) with ESMTPS id 4Smb8b4FnLz5B101;
        Fri,  8 Dec 2023 10:45:03 +0800 (CST)
Received: from xaxapp02.zte.com.cn ([10.88.97.241])
        by mse-fl2.zte.com.cn with SMTP id 3B82itc9067680;
        Fri, 8 Dec 2023 10:44:55 +0800 (+08)
        (envelope-from yang.guang5@zte.com.cn)
Received: from mapi (xaxapp02[null])
        by mapi (Zmail) with MAPI id mid31;
        Fri, 8 Dec 2023 10:44:56 +0800 (CST)
Date:   Fri, 8 Dec 2023 10:44:56 +0800 (CST)
X-Zmail-TransId: 2afa657283282d5-bc543
X-Mailer: Zmail v1.0
Message-ID: <202312081044568085747@zte.com.cn>
Mime-Version: 1.0
From:   <yang.guang5@zte.com.cn>
To:     <harry.wentland@amd.com>
Cc:     <jiang.xuexin@zte.com.cn>, <chen.haonan2@zte.com.cn>,
        <cgel.zte@gmail.com>, <sunpeng.li@amd.com>,
        <rodrigo.siqueira@amd.com>, <alexander.deucher@amd.com>,
        <christian.koenig@amd.com>, <xinhui.pan@amd.com>,
        <airlied@gmail.com>, <daniel@ffwll.ch>, <wenjing.liu@amd.com>,
        <jun.lei@amd.com>, <qingqing.zhuo@amd.com>, <alvin.lee2@amd.com>,
        <samson.tam@amd.com>, <aric.cyr@amd.com>, <chiawen.huang@amd.com>,
        <gabe.teeger@amd.com>, <amd-gfx@lists.freedesktop.org>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIIGxpbnV4LW5leHRdIGRybS9hbWQvZGlzcGxheTogcmVwbGFjZSBremFsbG9jIGFuZCBtZW1jcHkgd2l0aCBrbWVtZHVw?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl2.zte.com.cn 3B82itc9067680
X-Fangmail-Gw-Spam-Type: 0
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 65728339.000/4Smb8p25Pwz5SgL
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yang Guang <yang.guang5@zte.com.cn>

Convert kzalloc/memcpy operations to memdup makes for 
cleaner code and avoids memcpy() failures

Signed-off-by: Chen Haonan <chen.haonan2@zte.com.cn>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 76b47f178127..867e1a0fdef6 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -2264,12 +2264,10 @@ struct dc_state *dc_copy_state(struct dc_state *src_ctx)

 #ifdef CONFIG_DRM_AMD_DC_FP
 	if (new_ctx->bw_ctx.dml2) {
-		dml2 = kzalloc(sizeof(struct dml2_context), GFP_KERNEL);
-		if (!dml2)
-			return NULL;
-
-		memcpy(dml2, src_ctx->bw_ctx.dml2, sizeof(struct dml2_context));
-		new_ctx->bw_ctx.dml2 = dml2;
+		dml2 = kmemdup(src_ctx->bw_ctx.dml2, sizeof(struct dml2_context), GFP_KERNEL);
+		if (!dml2)
+			return NULL;
+		new_ctx->bw_ctx.dml2 = dml2;
 	}
 #endif

-- 
2.25.1

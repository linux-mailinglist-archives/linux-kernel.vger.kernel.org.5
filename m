Return-Path: <linux-kernel+bounces-6300-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C68DC8196F0
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 03:47:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63CBA1F25C4C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 02:47:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5195015AF8;
	Wed, 20 Dec 2023 02:47:02 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31C0F14F72
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 02:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mxct.zte.com.cn (unknown [192.168.251.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4Svyd457zFz8XrRJ
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 10:46:48 +0800 (CST)
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mxct.zte.com.cn (FangMail) with ESMTPS id 4Svycr233Gz4xVcb;
	Wed, 20 Dec 2023 10:46:36 +0800 (CST)
Received: from xaxapp03.zte.com.cn ([10.88.97.17])
	by mse-fl2.zte.com.cn with SMTP id 3BK2kTsI065941;
	Wed, 20 Dec 2023 10:46:29 +0800 (+08)
	(envelope-from yang.guang5@zte.com.cn)
Received: from mapi (xaxapp03[null])
	by mapi (Zmail) with MAPI id mid31;
	Wed, 20 Dec 2023 10:46:30 +0800 (CST)
Date: Wed, 20 Dec 2023 10:46:30 +0800 (CST)
X-Zmail-TransId: 2afb6582558662c-ceb76
X-Mailer: Zmail v1.0
Message-ID: <202312201046309071520@zte.com.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <yang.guang5@zte.com.cn>
To: <harry.wentland@amd.com>
Cc: <jiang.xuexin@zte.com.cn>, <chen.haonan2@zte.com.cn>, <cgel.zte@gmail.com>,
        <sunpeng.li@amd.com>, <rodrigo.siqueira@amd.com>,
        <alexander.deucher@amd.com>, <christian.koenig@amd.com>,
        <xinhui.pan@amd.com>, <airlied@gmail.com>, <daniel@ffwll.ch>,
        <alex.hung@amd.com>, <hamza.mahfooz@amd.com>, <wayne.lin@amd.com>,
        <hersenxs.wu@amd.com>, <srinivasan.shanmugam@amd.com>,
        <mario.limonciello@amd.com>, <amd-gfx@lists.freedesktop.org>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIIGxpbnV4LW5leHRdIGRybS9hbWQvZGlzcGxheTogdXNlIGtjYWxsb2MgaW5zdGVhZCBvZiBvcGVuIGNvZGVkIGFyaXRobWV0aWM=?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl2.zte.com.cn 3BK2kTsI065941
X-Fangmail-Gw-Spam-Type: 0
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 65825598.000/4Svyd457zFz8XrRJ

From: Yang Guang <yang.guang5@zte.com.cn>

Dynamic size calculations (especially multiplication) should not be 
performed in memory allocator (or similar) function arguments due 
to the risk of them overflowing. This could lead to values wrapping 
around and a smaller allocation being made than the caller was 
expecting. Using those allocations could lead to linear overflows 
of heap memory and other misbehaviors. 

Signed-off-by: Chen Haonan <chen.haonan2@zte.com.cn>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index d7ac020bd8af..d6d63bd7482e 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -9204,7 +9204,7 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
 		 * Here we create an empty update on each plane.
 		 * To fix this, DC should permit updating only stream properties.
 		 */
-		dummy_updates = kzalloc(sizeof(struct dc_surface_update) * MAX_SURFACES, GFP_ATOMIC);
+		dummy_updates = kcalloc(MAX_SURFACES, sizeof(struct dc_surface_update), GFP_ATOMIC);
 		for (j = 0; j < status->plane_count; j++)
 			dummy_updates[j].surface = status->plane_states[0];

-- 
2.25.1


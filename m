Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 716447EB385
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 16:28:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233601AbjKNP2M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 10:28:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232193AbjKNP2L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 10:28:11 -0500
Received: from 16.mo581.mail-out.ovh.net (16.mo581.mail-out.ovh.net [46.105.72.216])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D011ED
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 07:28:06 -0800 (PST)
Received: from director6.ghost.mail-out.ovh.net (unknown [10.109.146.76])
        by mo581.mail-out.ovh.net (Postfix) with ESMTP id 5AF6027B14
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 15:28:04 +0000 (UTC)
Received: from ghost-submission-6684bf9d7b-kk79p (unknown [10.110.103.114])
        by director6.ghost.mail-out.ovh.net (Postfix) with ESMTPS id 0FB981FE70;
        Tue, 14 Nov 2023 15:28:00 +0000 (UTC)
Received: from foxhound.fi ([37.59.142.102])
        by ghost-submission-6684bf9d7b-kk79p with ESMTPSA
        id QNnGNgCSU2UGzg4Aqzq3ag
        (envelope-from <jose.pekkarinen@foxhound.fi>); Tue, 14 Nov 2023 15:28:00 +0000
Authentication-Results: garm.ovh; auth=pass (GARM-102R00447b4aba0-d8b9-4512-b764-96c8bb41a9fd,
                    39B655737E19CE8DAD14488E69459E8CEBC9C448) smtp.auth=jose.pekkarinen@foxhound.fi
X-OVh-ClientIp: 83.100.46.156
From:   =?UTF-8?q?Jos=C3=A9=20Pekkarinen?= <jose.pekkarinen@foxhound.fi>
To:     harry.wentland@amd.com, sunpeng.li@amd.com,
        Rodrigo.Siqueira@amd.com, alexander.deucher@amd.com,
        christian.koenig@amd.com, Xinhui.Pan@amd.com,
        skhan@linuxfoundation.org
Cc:     =?UTF-8?q?Jos=C3=A9=20Pekkarinen?= <jose.pekkarinen@foxhound.fi>,
        airlied@gmail.com, daniel@ffwll.ch, Wayne.Lin@amd.com,
        qingqing.zhuo@amd.com, lyude@redhat.com,
        srinivasan.shanmugam@amd.com, aurabindo.pillai@amd.com,
        sungjoon.kim@amd.com, wenjing.liu@amd.com, hamza.mahfooz@amd.com,
        mikita.lipski@amd.com, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linux.dev
Subject: [PATCH v2] drm/amd/display: fix NULL dereference
Date:   Tue, 14 Nov 2023 17:27:51 +0200
Message-Id: <20231114152751.30167-1-jose.pekkarinen@foxhound.fi>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 10521253157812807361
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvkedrudefvddgjeehucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucenucfjughrpefhvfevufffkffogggtgfesthekredtredtjeenucfhrhhomheplfhoshorucfrvghkkhgrrhhinhgvnhcuoehjohhsvgdrphgvkhhkrghrihhnvghnsehfohighhhouhhnugdrfhhiqeenucggtffrrghtthgvrhhnpeeftdelueetieetvdettdetueeivedujeefffdvteefkeelhefhleelfeetteejjeenucfkphepuddvjedrtddrtddruddpkeefrddutddtrdegiedrudehiedpfeejrdehledrudegvddruddtvdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduvdejrddtrddtrddupdhmrghilhhfrhhomhepoehjohhsvgdrphgvkhhkrghrihhnvghnsehfohighhhouhhnugdrfhhiqedpnhgspghrtghpthhtohepuddprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdpoffvtefjohhsthepmhhoheekuddpmhhouggvpehsmhhtphhouhht
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following patch will fix a minor issue where a debug message is
referencing an struct that has just being checked whether is null or
not. This has been noticed by using coccinelle, in the following output:

drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c:540:25-29: ERROR: aconnector is NULL but dereferenced.

Fixes: 5d72e247e58c9 ("drm/amd/display: switch DC over to the new DRM logging macros")
Signed-off-by: José Pekkarinen <jose.pekkarinen@foxhound.fi>
---
[v1 -> v2]: Remove the debugging message, requested by Hamza

 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
index ed784cf27d39..c7a29bb737e2 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
@@ -536,11 +536,8 @@ bool dm_helpers_dp_read_dpcd(
 
 	struct amdgpu_dm_connector *aconnector = link->priv;
 
-	if (!aconnector) {
-		drm_dbg_dp(aconnector->base.dev,
-			   "Failed to find connector for link!\n");
+	if (!aconnector)
 		return false;
-	}
 
 	return drm_dp_dpcd_read(&aconnector->dm_dp_aux.aux, address, data,
 				size) == size;
-- 
2.39.2


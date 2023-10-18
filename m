Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C2CB7CD3EF
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 08:15:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344470AbjJRGPt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 02:15:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbjJRGPr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 02:15:47 -0400
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E548A93
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 23:15:43 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R691e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0VuPi1lq_1697609732;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0VuPi1lq_1697609732)
          by smtp.aliyun-inc.com;
          Wed, 18 Oct 2023 14:15:41 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     harry.wentland@amd.com
Cc:     sunpeng.li@amd.com, Rodrigo.Siqueira@amd.com,
        alexander.deucher@amd.com, christian.koenig@amd.com,
        Xinhui.Pan@amd.com, airlied@gmail.com, daniel@ffwll.ch,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH] drm/amd/display: Use swap() instead of open coding it
Date:   Wed, 18 Oct 2023 14:15:31 +0800
Message-Id: <20231018061531.11565-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Swap is a function interface that provides exchange function. To avoid
code duplication, we can use swap function.

./drivers/gpu/drm/amd/display/dc/dml2/dml2_dc_resource_mgmt.c:445:127-128: WARNING opportunity for swap().

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=6903
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/gpu/drm/amd/display/dc/dml2/dml2_dc_resource_mgmt.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml2_dc_resource_mgmt.c b/drivers/gpu/drm/amd/display/dc/dml2/dml2_dc_resource_mgmt.c
index 36baf35bb170..5cbb2db9dfd1 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml2_dc_resource_mgmt.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml2_dc_resource_mgmt.c
@@ -425,7 +425,6 @@ static void sort_pipes_for_splitting(struct dc_plane_pipe_pool *pipes)
 {
 	bool sorted, swapped;
 	unsigned int cur_index;
-	unsigned int temp;
 	int odm_slice_index;
 
 	for (odm_slice_index = 0; odm_slice_index < pipes->num_pipes_assigned_to_plane_for_odm_combine; odm_slice_index++) {
@@ -441,10 +440,7 @@ static void sort_pipes_for_splitting(struct dc_plane_pipe_pool *pipes)
 		swapped = false;
 		while (!sorted) {
 			if (pipes->pipes_assigned_to_plane[odm_slice_index][cur_index] > pipes->pipes_assigned_to_plane[odm_slice_index][cur_index + 1]) {
-				temp = pipes->pipes_assigned_to_plane[odm_slice_index][cur_index];
-				pipes->pipes_assigned_to_plane[odm_slice_index][cur_index] = pipes->pipes_assigned_to_plane[odm_slice_index][cur_index + 1];
-				pipes->pipes_assigned_to_plane[odm_slice_index][cur_index + 1] = temp;
-
+				swap(pipes->pipes_assigned_to_plane[odm_slice_index][cur_index], pipes->pipes_assigned_to_plane[odm_slice_index][cur_index + 1]);
 				swapped = true;
 			}
 
-- 
2.20.1.7.g153144c


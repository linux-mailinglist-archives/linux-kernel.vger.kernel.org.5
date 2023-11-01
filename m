Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 542937DDB46
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 04:01:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376272AbjKAC6j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 22:58:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345437AbjKAC6i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 22:58:38 -0400
Received: from mail.nfschina.com (unknown [42.101.60.195])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 27F2DA4;
        Tue, 31 Oct 2023 19:58:35 -0700 (PDT)
Received: from localhost.localdomain (unknown [180.167.10.98])
        by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPA id A887A605164A1;
        Wed,  1 Nov 2023 10:58:04 +0800 (CST)
X-MD-Sfrom: suhui@nfschina.com
X-MD-SrcIP: 180.167.10.98
From:   Su Hui <suhui@nfschina.com>
To:     alexander.deucher@amd.com, christian.koenig@amd.com,
        Xinhui.Pan@amd.com, airlied@gmail.com, daniel@ffwll.ch
Cc:     Su Hui <suhui@nfschina.com>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] drm/radeon/ni_dpm: add an error code check in ni_dpm_init
Date:   Wed,  1 Nov 2023 10:57:53 +0800
Message-Id: <20231101025752.988228-1-suhui@nfschina.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ni_patch_single_dependency_table_based_on_leakage() return zero or
negative error code. But ni_patch_dependency_tables_based_on_leakage()
doesn't check the return value of the first function call. It's same for
ni_dpm_init(). It's better to add this error code check.

Signed-off-by: Su Hui <suhui@nfschina.com>
---
 drivers/gpu/drm/radeon/ni_dpm.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/radeon/ni_dpm.c b/drivers/gpu/drm/radeon/ni_dpm.c
index 3e1c1a392fb7..f521dc929a06 100644
--- a/drivers/gpu/drm/radeon/ni_dpm.c
+++ b/drivers/gpu/drm/radeon/ni_dpm.c
@@ -1010,6 +1010,8 @@ static int ni_patch_dependency_tables_based_on_leakage(struct radeon_device *rde
 
 	ret = ni_patch_single_dependency_table_based_on_leakage(rdev,
 								&rdev->pm.dpm.dyn_state.vddc_dependency_on_sclk);
+	if (ret)
+		return ret;
 
 	ret = ni_patch_single_dependency_table_based_on_leakage(rdev,
 								&rdev->pm.dpm.dyn_state.vddc_dependency_on_mclk);
@@ -4098,7 +4100,12 @@ int ni_dpm_init(struct radeon_device *rdev)
 	rdev->pm.dpm.dyn_state.vddc_dependency_on_dispclk.entries[3].clk = 72000;
 	rdev->pm.dpm.dyn_state.vddc_dependency_on_dispclk.entries[3].v = 900;
 
-	ni_patch_dependency_tables_based_on_leakage(rdev);
+	ret = ni_patch_dependency_tables_based_on_leakage(rdev);
+	if (ret) {
+		kfree(rdev->pm.dpm.dyn_state.vddc_dependency_on_dispclk.entries);
+		r600_free_extended_power_table(rdev);
+		return ret;
+	}
 
 	if (rdev->pm.dpm.voltage_response_time == 0)
 		rdev->pm.dpm.voltage_response_time = R600_VOLTAGERESPONSETIME_DFLT;
-- 
2.30.2


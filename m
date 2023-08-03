Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5DD776E443
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 11:24:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234025AbjHCJX6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 05:23:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230523AbjHCJX4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 05:23:56 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0596FE48
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 02:23:55 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-4fe2d152f62so1282216e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 03 Aug 2023 02:23:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf.com; s=google; t=1691054633; x=1691659433;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DKE5RPCVa4ZdeYnCra9n15ebxdPiozynuD4jWbZ/+EU=;
        b=Fl5doOIX4WD/qvdR+ht1Wd1QHAIDUlpDjXH/YRXlTANpbCIZ8AbkIE65tOb+ZaA1ol
         DKcZeCM5YBmjp2AmbNLj9kGa0x8UIe9hfqfvK9hCWUdoEtvCaQgogCQRWmovC5PVcF/T
         05xE9fzq2Pqlu55FnPXJ73/YS5Cn6r46OBJdLgLvbzDz1pYSw+XVECDU8VBRsOglZ83E
         FBlQysam9VW5iHy1N44Xrzg5965F7mlwNQ+AMGxRa2xP0qUNbWkaeOzohS+8PCqX6T5P
         dYzJtp7QPr+foHHCIGVSUSDreQsPxO9/Zi85C6H6U5mcQFOuO7LNKVgZjy1JzXbDHkrL
         roVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691054633; x=1691659433;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DKE5RPCVa4ZdeYnCra9n15ebxdPiozynuD4jWbZ/+EU=;
        b=JOVc/YrNsUhxaYeWl3cYok1I3sh3SKQgZT7RYhxabsC80sIBuQ1oV72RxgwNcsxZ/E
         5ykudjwKVszA+FQTxXO6wKJizntDRMT4n1Qn423TwXn365zBH3fTY7stRlDYBt3zkacG
         j/y4Al1wKo1uMBh4rtTJDyPKgiOyGCgQ52KOf1ElvS2oMJpm6nkXRrfV/cCw90MDzQgx
         gRuA0jq2EdKJUC9s5hhZKiX8R/PP3pK4KPCxs6iGif/q6GxpFTxO46OrI4sTew8HYyHv
         n2poHtRJK90DsgKOg64M9GRSrJ12iaiD8vMRcZmoQDv6KMGB2kXd+iZslrY1gkkUvUFX
         LJNQ==
X-Gm-Message-State: ABy/qLbV5Rof3KRixb2zj82mCUDhUeBQNEeQfCIsKyXRHY4HQ+agKg6W
        4POvRuv7/8RQ9PE3napGaRJrzw==
X-Google-Smtp-Source: APBJJlGcKEvuwsZDe77Nz1Pb30gbPEvm1CNLmx3c4bRUnw9Q3s/GD77kQYFkTGOXIxrIYkh9KPUcsg==
X-Received: by 2002:a05:6512:546:b0:4f6:6b:a43b with SMTP id h6-20020a056512054600b004f6006ba43bmr5967812lfl.52.1691054633058;
        Thu, 03 Aug 2023 02:23:53 -0700 (PDT)
Received: from lmajczak1-l.roam.corp.google.com ([83.142.187.84])
        by smtp.gmail.com with ESMTPSA id q19-20020ac25293000000b004fe0ab60530sm3306750lfm.49.2023.08.03.02.23.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 02:23:52 -0700 (PDT)
From:   Lukasz Majczak <lma@semihalf.com>
To:     David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
Cc:     Guenter Roeck <linux@roeck-us.net>, upstream@semihalf.com,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Lukasz Majczak <lma@semihalf.com>, stable@vger.kernel.org
Subject: [PATCH] drm/dp_mst: Fix NULL deref in get_mst_branch_device_by_guid_helper()
Date:   Thu,  3 Aug 2023 11:23:08 +0200
Message-ID: <20230803092308.79197-1-lma@semihalf.com>
X-Mailer: git-send-email 2.41.0.640.ga95def55d0-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Check mgr->mst_primary, before passing it to
the get_mst_branch_device_by_guid_helper(), otherwise NULL dereference
may occur in the call to memcpy() and cause:

[12579.365869] BUG: kernel NULL pointer dereference, address: 0000000000000049
[12579.365878] #PF: supervisor read access in kernel mode
[12579.365880] #PF: error_code(0x0000) - not-present page
[12579.365882] PGD 0 P4D 0
[12579.365887] Oops: 0000 [#1] PREEMPT SMP NOPTI
...
[12579.365895] Workqueue: events_long drm_dp_mst_up_req_work
[12579.365899] RIP: 0010:memcmp+0xb/0x29
[12579.365921] Call Trace:
[12579.365927] get_mst_branch_device_by_guid_helper+0x22/0x64
[12579.365930] drm_dp_mst_up_req_work+0x137/0x416
[12579.365933] process_one_work+0x1d0/0x419
[12579.365935] worker_thread+0x11a/0x289
[12579.365938] kthread+0x13e/0x14f
[12579.365941] ? process_one_work+0x419/0x419
[12579.365943] ? kthread_blkcg+0x31/0x31
[12579.365946] ret_from_fork+0x1f/0x30

Similar check is done in e.g: drm_dp_mst_topology_get_mstb_validated().

Fixes: 5e93b8208d3c ("drm/dp/mst: move GUID storage from mgr, port to only mst branch")
Cc: <stable@vger.kernel.org> # 4.14+
Signed-off-by: Lukasz Majczak <lma@semihalf.com>
---
 drivers/gpu/drm/display/drm_dp_mst_topology.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/display/drm_dp_mst_topology.c b/drivers/gpu/drm/display/drm_dp_mst_topology.c
index ed96cfcfa304..703cd97b1d11 100644
--- a/drivers/gpu/drm/display/drm_dp_mst_topology.c
+++ b/drivers/gpu/drm/display/drm_dp_mst_topology.c
@@ -2595,19 +2595,19 @@ static struct drm_dp_mst_branch *
 drm_dp_get_mst_branch_device_by_guid(struct drm_dp_mst_topology_mgr *mgr,
 				     const uint8_t *guid)
 {
-	struct drm_dp_mst_branch *mstb;
+	struct drm_dp_mst_branch *mstb = NULL;
 	int ret;
 
 	/* find the port by iterating down */
 	mutex_lock(&mgr->lock);
-
-	mstb = get_mst_branch_device_by_guid_helper(mgr->mst_primary, guid);
-	if (mstb) {
-		ret = drm_dp_mst_topology_try_get_mstb(mstb);
-		if (!ret)
-			mstb = NULL;
+	if (mgr->mst_primary) {
+		mstb = get_mst_branch_device_by_guid_helper(mgr->mst_primary, guid);
+		if (mstb) {
+			ret = drm_dp_mst_topology_try_get_mstb(mstb);
+			if (!ret)
+				mstb = NULL;
+		}
 	}
-
 	mutex_unlock(&mgr->lock);
 	return mstb;
 }
-- 
2.41.0.640.ga95def55d0-goog


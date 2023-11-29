Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 408AA7FD69A
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 13:20:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233592AbjK2MTu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 07:19:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233528AbjK2MT3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 07:19:29 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD82A2101;
        Wed, 29 Nov 2023 04:19:27 -0800 (PST)
Received: from localhost.localdomain (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: vignesh)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id D7655660732A;
        Wed, 29 Nov 2023 12:19:22 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1701260366;
        bh=drt9Nf1tdYoCGDZuOe/qO8JK0dZNg1Oz/Fl7Gto/UZI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ri4WVuOtDg/bxRqtZJK8ogTvFXmvqnAP/JkoBlpF7lpuxfbIcwi9JLLzT7/HsFcPi
         vSiObrgMAuKWp18v1JfnlkIRp1SFiIeH0RfeR3Oqn6A7XPLfMYcgCancb59Sl48mO7
         3iUWHc2aTCo6SkG7TLpoZA+HeK3Sdeycrbahud1QkfmNVJCOf+hStJjI3JCOW5O5vB
         L/AmHhz7RjKzXRXHLwd1TExZG7Wsv28bU6a6AJgLxWjgLfz00z1evdPtI+zcUl/RER
         SmbMTcWhhWSo1Ju8VFc7PDloT3RjUltMAr7NuO9ws4UzWbahB/37Udy7UVh+A0EEAn
         2ycI9vcIHP+3g==
From:   Vignesh Raman <vignesh.raman@collabora.com>
To:     helen.koike@collabora.com, airlied@gmail.com, daniel@ffwll.ch
Cc:     david.heidelberg@collabora.com, sergi.blanch.torne@collabora.com,
        guilherme.gallo@collabora.com, daniels@collabora.com,
        gustavo.padovan@collabora.com, emma@anholt.net,
        robdclark@gmail.com, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        virtualization@lists.linux-foundation.org,
        linux-rockchip@lists.infradead.org, linux-arm-msm@vger.kernel.org
Subject: [PATCH v6 08/10] drm: ci: uprev IGT
Date:   Wed, 29 Nov 2023 17:48:39 +0530
Message-Id: <20231129121841.253223-9-vignesh.raman@collabora.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231129121841.253223-1-vignesh.raman@collabora.com>
References: <20231129121841.253223-1-vignesh.raman@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

virtio-gpu kernel driver reports 16 for count_crtcs
which exceeds IGT_MAX_PIPES set to 8 in igt-gpu-tools.
This results in below memory corruption,

 malloc(): corrupted top size
 Received signal SIGABRT.
 Stack trace:
  #0 [fatal_sig_handler+0x17b]
  #1 [__sigaction+0x40]
  #2 [pthread_key_delete+0x14c]
  #3 [gsignal+0x12]
  #4 [abort+0xd3]
  #5 [__fsetlocking+0x290]
  #6 [timer_settime+0x37a]
  #7 [__default_morecore+0x1f1b]
  #8 [__libc_calloc+0x161]
  #9 [drmModeGetPlaneResources+0x44]
  #10 [igt_display_require+0x194]
  #11 [__igt_unique____real_main1356+0x93c]
  #12 [main+0x3f]
  #13 [__libc_init_first+0x8a]
  #14 [__libc_start_main+0x85]
  #15 [_start+0x21]
 
This is fixed in igt-gpu-tools by increasing IGT_MAX_PIPES to 16.  
https://patchwork.freedesktop.org/series/126327/
 
Uprev IGT to include the patches which fixes this issue.

Signed-off-by: Vignesh Raman <vignesh.raman@collabora.com>
---

v6:
  - Added a new patch in the series to uprev IGT to fix memory corruption

---
 drivers/gpu/drm/ci/gitlab-ci.yml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/ci/gitlab-ci.yml b/drivers/gpu/drm/ci/gitlab-ci.yml
index aeb9bab1b069..dac92cc2777c 100644
--- a/drivers/gpu/drm/ci/gitlab-ci.yml
+++ b/drivers/gpu/drm/ci/gitlab-ci.yml
@@ -5,7 +5,7 @@ variables:
   UPSTREAM_REPO: git://anongit.freedesktop.org/drm/drm
   TARGET_BRANCH: drm-next
 
-  IGT_VERSION: d1db7333d9c5fbbb05e50b0804123950d9dc1c46
+  IGT_VERSION: d2af13d9f5be5ce23d996e4afd3e45990f5ab977
 
   DEQP_RUNNER_GIT_URL: https://gitlab.freedesktop.org/anholt/deqp-runner.git
   DEQP_RUNNER_GIT_TAG: v0.15.0
-- 
2.40.1


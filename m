Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E87BD79904A
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 21:38:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345085AbjIHTiT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 15:38:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345074AbjIHThc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 15:37:32 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 062591704;
        Fri,  8 Sep 2023 12:37:11 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1724EC433CB;
        Fri,  8 Sep 2023 19:36:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694201819;
        bh=l05wLca+GLs2HPmojVCoJBmTQZU4/uSUnmvjn5E8K1o=;
        h=From:To:Cc:Subject:Date:From;
        b=NogmhBzK42et/A66vkzZzTT2ngv2ZxPEXJiVaf8EDc/5ekGepFRSJ20evHhb+V5qz
         fcmXIO8MuHdz5lS/Cuqhv0HwogcxS5/lMKCSEnyR+TbcxPJ3SMeWLUWxqdBHYWSrVc
         QesJoxxFmymsZdVA+16lKcxJhfTm4ljEk1pGj0bW+2WNOLkGXzVa1Ct6Dg2x5C7Bsl
         FSzUTVCxAGtMcUmLY3f/VkuJ/+fIWvFiZjqVovz8n5LGFducLVpnd9XCP7CZbsONDG
         YZdl26tjsJq/RS+EZ3SMQ0esH+2pBmToUt/5/jgrC12CBLwafdxy/nMCToIMXHPElh
         r408uJBdr+feg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Tuo Li <islituo@gmail.com>, BassCheck <bass@buaa.edu.cn>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Inki Dae <inki.dae@samsung.com>,
        Sasha Levin <sashal@kernel.org>, sw0312.kim@samsung.com,
        kyungmin.park@samsung.com, airlied@gmail.com, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 1/3] drm/exynos: fix a possible null-pointer dereference due to data race in exynos_drm_crtc_atomic_disable()
Date:   Fri,  8 Sep 2023 15:36:53 -0400
Message-Id: <20230908193656.3464052-1-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.14.325
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tuo Li <islituo@gmail.com>

[ Upstream commit 2e63972a2de14482d0eae1a03a73e379f1c3f44c ]

The variable crtc->state->event is often protected by the lock
crtc->dev->event_lock when is accessed. However, it is accessed as a
condition of an if statement in exynos_drm_crtc_atomic_disable() without
holding the lock:

  if (crtc->state->event && !crtc->state->active)

However, if crtc->state->event is changed to NULL by another thread right
after the conditions of the if statement is checked to be true, a
null-pointer dereference can occur in drm_crtc_send_vblank_event():

  e->pipe = pipe;

To fix this possible null-pointer dereference caused by data race, the
spin lock coverage is extended to protect the if statement as well as the
function call to drm_crtc_send_vblank_event().

Reported-by: BassCheck <bass@buaa.edu.cn>
Link: https://sites.google.com/view/basscheck/home
Signed-off-by: Tuo Li <islituo@gmail.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Added relevant link.
Signed-off-by: Inki Dae <inki.dae@samsung.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/exynos/exynos_drm_crtc.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/exynos/exynos_drm_crtc.c b/drivers/gpu/drm/exynos/exynos_drm_crtc.c
index 4787560bf93e7..e1aa518ea0ba1 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_crtc.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_crtc.c
@@ -43,13 +43,12 @@ static void exynos_drm_crtc_atomic_disable(struct drm_crtc *crtc,
 	if (exynos_crtc->ops->disable)
 		exynos_crtc->ops->disable(exynos_crtc);
 
+	spin_lock_irq(&crtc->dev->event_lock);
 	if (crtc->state->event && !crtc->state->active) {
-		spin_lock_irq(&crtc->dev->event_lock);
 		drm_crtc_send_vblank_event(crtc, crtc->state->event);
-		spin_unlock_irq(&crtc->dev->event_lock);
-
 		crtc->state->event = NULL;
 	}
+	spin_unlock_irq(&crtc->dev->event_lock);
 }
 
 static int exynos_crtc_atomic_check(struct drm_crtc *crtc,
-- 
2.40.1


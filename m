Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1E6878E7A1
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 10:10:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244106AbjHaIKI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 04:10:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242791AbjHaIKF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 04:10:05 -0400
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5AFFFCE7
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 01:09:58 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="6.02,216,1688396400"; 
   d="scan'208";a="178287328"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 31 Aug 2023 17:09:58 +0900
Received: from localhost.localdomain (unknown [10.226.92.179])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id 780704010DFE;
        Thu, 31 Aug 2023 17:09:52 +0900 (JST)
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Douglas Anderson <dianders@chromium.org>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Subject: [PATCH v6 2/4] drm/bridge: Drop conditionals around of_node pointers
Date:   Thu, 31 Aug 2023 09:09:36 +0100
Message-Id: <20230831080938.47454-3-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230831080938.47454-1-biju.das.jz@bp.renesas.com>
References: <20230831080938.47454-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is based on commit c9e358dfc4a8 ("driver-core: remove
conditionals around devicetree pointers").

Having conditional around the of_node pointer of the drm_bridge
structure turns out to make driver code use ugly #ifdef blocks. Drop the
conditionals to simplify drivers. While this slightly increases the size
of struct drm_bridge on non-OF system, the number of bridges used today
and foreseen tomorrow on those systems is very low, so this shouldn't be
an issue.

So drop #if conditionals by adding struct device_node forward declaration.

Suggested-by: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
v5->v6:
 * Updated commit description.
 * Added Rb tag from Douglas Anderson and Laurent
v5:
 * Split from patch#2
 * Updated commit description
 * Added struct device_node forward declaration.
---
 include/drm/drm_bridge.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/drm/drm_bridge.h b/include/drm/drm_bridge.h
index c339fc85fd07..843736627f60 100644
--- a/include/drm/drm_bridge.h
+++ b/include/drm/drm_bridge.h
@@ -32,6 +32,8 @@
 #include <drm/drm_mode_object.h>
 #include <drm/drm_modes.h>
 
+struct device_node;
+
 struct drm_bridge;
 struct drm_bridge_timings;
 struct drm_connector;
@@ -716,10 +718,8 @@ struct drm_bridge {
 	struct drm_encoder *encoder;
 	/** @chain_node: used to form a bridge chain */
 	struct list_head chain_node;
-#ifdef CONFIG_OF
 	/** @of_node: device node pointer to the bridge */
 	struct device_node *of_node;
-#endif
 	/** @list: to keep track of all added bridges */
 	struct list_head list;
 	/**
-- 
2.25.1


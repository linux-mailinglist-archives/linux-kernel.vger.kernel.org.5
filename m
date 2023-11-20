Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEC577F134C
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 13:30:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233422AbjKTMaP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 07:30:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233208AbjKTMaN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 07:30:13 -0500
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AF62FF
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 04:30:09 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7E158FF80E;
        Mon, 20 Nov 2023 12:30:04 +0000 (UTC)
From:   Quentin Schulz <foss+kernel@0leil.net>
To:     Sandy Huang <hjc@rock-chips.com>,
        =?utf-8?q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Mark Yao <markyao0591@gmail.com>
Cc:     Quentin Schulz <foss+kernel@0leil.net>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Fabio Estevam <festevam@gmail.com>,
        Quentin Schulz <quentin.schulz@theobroma-systems.com>
Subject: [PATCH v2 0/2] drm/rockchip: lvds: improve erroring out when drm_of_find_panel_or_bridge fails
Date:   Mon, 20 Nov 2023 13:29:47 +0100
Message-ID: <20231120-rk-lvds-defer-msg-v2-0-9c59a5779cf9@theobroma-systems.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.12.4
Content-Transfer-Encoding: 8bit
X-GND-Sasl: foss@0leil.net
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

drm_of_find_panel_or_bridge may return a different error code than
EPROBE_DEFER so let's not overwrite it.

At the same time, let's demote the DRM_DEV_ERROR message to
dev_err_probe so that the scary message isn't shown (by default)
whenever EPROBE_DEFER is returned to not mislead users.

Signed-off-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>
---
Changes in v2:
- add a patch for not overwriting return code with EPROBE_DEFER
- use dev_err_probe instead of DRM_DEV_DEBUG
- Link to v1: https://lore.kernel.org/r/20231117-rk-lvds-defer-msg-v1-1-1e6894cf9a74@theobroma-systems.com

---
Quentin Schulz (2):
      drm/rockchip: lvds: do not overwrite error code
      drm/rockchip: lvds: do not print scary message when probing defer

 drivers/gpu/drm/rockchip/rockchip_lvds.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)
---
base-commit: 98b1cc82c4affc16f5598d4fa14b1858671b2263
change-id: 20231117-rk-lvds-defer-msg-b2944b73d791

Best regards,
-- 
Quentin Schulz <quentin.schulz@theobroma-systems.com>


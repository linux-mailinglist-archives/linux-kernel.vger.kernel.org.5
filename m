Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9502579359E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 08:51:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237147AbjIFGve (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 02:51:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232402AbjIFGvc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 02:51:32 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F83ACC3
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 23:51:28 -0700 (PDT)
Received: from [127.0.1.1] (91-154-35-171.elisa-laajakaista.fi [91.154.35.171])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id BCE43283;
        Wed,  6 Sep 2023 08:49:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1693982998;
        bh=60B1PjRhq+lXms9qS+iZ6PMaTqkaYXtbI6EvSCvPa+0=;
        h=From:Subject:Date:To:Cc:From;
        b=nqISk7FIqNe7YwzTvUDpm9DA/5ZKCZ2+yOjOBXt95ylUDqTKfuDta+xv1/noH0p7M
         nHYxAPg/VfaQWHIaDZBZjIoYhb1PE2Bzmf06jSATUjQFGMBHhwsePzZ0wqNW4Hd89t
         1RGuFBJma3yJiR2aahqi4TsWP58WO86jKn/wZ/pc=
From:   Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Subject: [PATCH v4 00/12] drm/bridge: tc358768: Fixes and timings
 improvements
Date:   Wed, 06 Sep 2023 09:50:47 +0300
Message-Id: <20230906-tc358768-v4-0-31725f008a50@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEgh+GQC/3XMvQ7CIBSG4VsxzGLgQCl18j6MA7+WwWKgIZqm9
 y7txFDH7+Q874KyS8FldD0tKLkScohTHfx8QmZU09PhYOtGQIARSTieDetkLySmWgx8cB4cs6i
 +v5Pz4bOn7o+6x5DnmL57udDtehApFBNMlbec616C0Ldgncpx0lElezHxhbZWgcZT0XioHjjow
 Xa+J0z98azxAI1n1RsJnHRWGWLogV/X9Qd+Ye4xJwEAAA==
To:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        =?utf-8?q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@gmail.com>,
        Maxim Schwalm <maxim.schwalm@gmail.com>,
        Francesco Dolcini <francesco@dolcini.it>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Aradhya Bhatia <a-bhatia1@ti.com>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Thierry Reding <treding@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2447;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=60B1PjRhq+lXms9qS+iZ6PMaTqkaYXtbI6EvSCvPa+0=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBk+CFjXsbXgw9bb7GfuHawpErgk9D6VZ8y2uaaf
 DeF58XneOmJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCZPghYwAKCRD6PaqMvJYe
 9ZesD/9H0x9hD44zUbMj9C57jrPzuGADqu8PQhsqaiUF6E6Ft+Si6bSKjbYC+8w0E3xwKnGkWhf
 s4gzSJ97RTnZTd71hbCRwG03rSyfr6qJe0dZGnPjE9II/XZlncPO7QDtNF7i0I0rcWpnbN6hJth
 Dzbw5FUdKh6jMDtgPod+54kr1OszdWAIB7jkjovAv/z7jKGNVmmm/zHNZdNIwH5e4rdeDK5WwwQ
 9lcLIK53plJjVPwOOLt0eMrSLY9iI9JLsBgpdQKsosl/xgf6JxPsiDh5e5IO98Wg+3xbcOusQKk
 O+isk+W5ZjpiLZb0QQ8zvHhGl5MTSwTq1PTZuoKWiNh9av+yAgi+C4Wz6MP6kratUKYqq+8/c3A
 u4bjWNJ6hvhMf9KqnFkY1HP+eEnYHyLVsPkdtEkhfyYEe4eIT3sngWVfWqGNPVmS3q6K41DaULd
 PRhu6qAYOwqicHQDE1wvvtOJ83I3mM88wimL46ZbDgj6CtEjRDBdSEhb4BJo06x63saMecwQyi0
 4Kqyp1yhrcRAFvNEf+JqfxvM73c4euDlHTf8BSnB+kmkhW5ZhJNXhsAKbBs+DwmjZ4MSEAGzzWu
 +rkh5yUcVgC2U1l5I6g7FQoVrrbDOvNLTMGt/TsW9oDlYGx3p5x/s/k4uCKXTeeXYUY7XBEx34B
 gOVhxBKtKWFnlnQ==
X-Developer-Key: i=tomi.valkeinen@ideasonboard.com; a=openpgp;
 fpr=C4380C3E965EFD81079FF3A7FA3DAA8CBC961EF5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series contains various fixes and cleanups for TC358768. The target
of this work is to get TC358768 working on Toradex's AM62 based board,
which has the following display pipeline:

AM62 DPI -> TC358768 -> LT8912B -> HDMI connector

The main thing the series does is to improve the DSI HSW, HFP and VSDly
calculations.

 Tomi

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
Changes in v4:
- Add Tested-by tags
- Fix a typo in a comment 
- Link to v3: https://lore.kernel.org/r/20230822-tc358768-v3-0-c82405dac0c1@ideasonboard.com

Changes in v3:
- Add Peter's reviewed-bys
- Move "Default to positive h/v syncs" earlier in the series to avoid
  regression in the middle of the series
- Link to v2: https://lore.kernel.org/r/20230816-tc358768-v2-0-242b9d5f703a@ideasonboard.com

Changes in v2:
- Add "drm/tegra: rgb: Parameterize V- and H-sync polarities" so that
  Tegra can configure the polarities correctly.
- Add "drm/bridge: tc358768: Default to positive h/v syncs" as we don't
  (necessarily) have the polarities set in the mode.
- Drop "drm/bridge: tc358768: Add DRM_BRIDGE_ATTACH_NO_CONNECTOR
  support" as it's not needed for DRM_BRIDGE_ATTACH_NO_CONNECTOR
  support.
- Link to v1: https://lore.kernel.org/r/20230804-tc358768-v1-0-1afd44b7826b@ideasonboard.com

---
Thierry Reding (1):
      drm/tegra: rgb: Parameterize V- and H-sync polarities

Tomi Valkeinen (11):
      drm/bridge: tc358768: Fix use of uninitialized variable
      drm/bridge: tc358768: Default to positive h/v syncs
      drm/bridge: tc358768: Fix bit updates
      drm/bridge: tc358768: Cleanup PLL calculations
      drm/bridge: tc358768: Use struct videomode
      drm/bridge: tc358768: Print logical values, not raw register values
      drm/bridge: tc358768: Use dev for dbg prints, not priv->dev
      drm/bridge: tc358768: Rename dsibclk to hsbyteclk
      drm/bridge: tc358768: Clean up clock period code
      drm/bridge: tc358768: Fix tc358768_ns_to_cnt()
      drm/bridge: tc358768: Attempt to fix DSI horizontal timings

 drivers/gpu/drm/bridge/tc358768.c | 381 ++++++++++++++++++++++++++++----------
 drivers/gpu/drm/tegra/rgb.c       |  16 +-
 2 files changed, 295 insertions(+), 102 deletions(-)
---
base-commit: f45acf7acf75921c0409d452f0165f51a19a74fd
change-id: 20230804-tc358768-1b6949ef2e3d

Best regards,
-- 
Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>


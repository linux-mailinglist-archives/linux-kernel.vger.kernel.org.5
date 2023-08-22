Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78BB07846E6
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 18:20:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237654AbjHVQUF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 12:20:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237626AbjHVQUE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 12:20:04 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3FA0CE4
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 09:20:02 -0700 (PDT)
Received: from [127.0.1.1] (91-154-35-171.elisa-laajakaista.fi [91.154.35.171])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 5A659899;
        Tue, 22 Aug 2023 18:18:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1692721123;
        bh=ag03oyDbmHdzswgBEwrUV7EhP85TJysi1yNOhgU1Bkc=;
        h=From:Subject:Date:To:Cc:From;
        b=EJe1V771TuAqggmH8jv9g/JhEFkzLwQNCpM66gw/t+TLLZmPORFSvRWXcRik1kpVc
         7i21C7RH7k57SRmN7akkzULb32LWDh2j1lGoNPtltYyjRlstw7C8fp8ml2519F0DUf
         QXGJwOCDfYGc4buVJrGeJx38xfRBMjOzQt369j2s=
From:   Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Subject: [PATCH v3 00/12] drm/bridge: tc358768: Fixes and timings
 improvements
Date:   Tue, 22 Aug 2023 19:19:33 +0300
Message-Id: <20230822-tc358768-v3-0-c82405dac0c1@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABXg5GQC/22MsQ6DIBRFf8UwlwYeiNip/9F0AHlUhkoDhrQx/
 nvRycHx3NxzFpIxBczk1iwkYQk5xKmCuDRkGM30QhpcZQIMBNNM0nkQre6UptyqXvboAYUj9f5
 J6MN3Tz2elceQ55h+e7nwbT2JFE4Z5cY7KW2nQdl7cGhynGw0yV2H+CZbq8DB5+rgQ/VBgu1d6
 zsmzIm/rusftJS01+cAAAA=
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
        Thierry Reding <thierry.reding@gmail.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2285;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=ag03oyDbmHdzswgBEwrUV7EhP85TJysi1yNOhgU1Bkc=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBk5OAmznVyC23Pg5VTyH+et0kZyb3T0wfiCoI31
 3KJ9LcrgSOJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCZOTgJgAKCRD6PaqMvJYe
 9dH7D/oDhr/9KV2z9LahVNgLlkuZV+1VbsCGJHHkx3xRryh0vpOhzKJGZUQFOLVARm6Qmh2J127
 j8emwmrqty45Ens2FH7yqoHp2/mxB+Z7AAF65Qv+ycbmxBM5wZcbepbUELdEsadZ7LfEXm1ehyo
 XGwGX62YYPHVhhXaPGIMsy1TY/pWQe1U7jNGjxMTeGGFv0Qdrspro+PQ3cBSFxUZF5U3XTDUo8g
 f+yVvHb1w2MRwTq39Frj3zUV8thNjw8fAIzYesq4zRAZ3vPsyznr9lho+66XEW5I4wuu7PTeqq4
 DrkPCJnXQwf+esEC7mQFnj/rTLncuePYEwUDaosqLwLZs9iN+eF/30usqixD6ePqc4mhKH6Uc82
 wksy7dLtxfgt4nwArNbZGBWeB60SIY9qBCWYA+QTc7iXp2TUwZQAT99XwR8p3jUooSqv5/+SEQB
 +AMRWPFg0Galwtka+hMYTTSFXECwz8V7P2u/lHYiIwVExT8wea3k5sxthmmHTAuOkGIa+LaFRRG
 emtnnnKPWnW5z8K6ulf7K+qK2JBRzTGeDSZdGd/0Xznf2sBfQoXsJ5NscP4HIggyXQ+cUCrJ3DB
 lSPQ/LmFkjqRCwvzsilt9SgwZ8ufcrBmHKSBLGQNujy/+82IMATknh2Hqt3QR8UrV+qV11DpipL
 4i/M4jQUFT7d52w==
X-Developer-Key: i=tomi.valkeinen@ideasonboard.com; a=openpgp;
 fpr=C4380C3E965EFD81079FF3A7FA3DAA8CBC961EF5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
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
base-commit: 25205087df1ffe06ccea9302944ed1f77dc68c6f
change-id: 20230804-tc358768-1b6949ef2e3d

Best regards,
-- 
Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>


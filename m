Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09C4376FEB2
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 12:44:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231504AbjHDKon (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 06:44:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjHDKol (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 06:44:41 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E04746B5
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 03:44:40 -0700 (PDT)
Received: from [127.0.1.1] (91-154-35-171.elisa-laajakaista.fi [91.154.35.171])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 9E84F2E4;
        Fri,  4 Aug 2023 12:43:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1691145813;
        bh=ec+E8wh10rTaYnjVd1fUIk4t7tXWKF9z3ngkuGu00y0=;
        h=From:Subject:Date:To:Cc:From;
        b=N6qSUObe49EJZwIYLC5D06tzMhL/pIgcZb83zyVK70/4PSj7CgX8QTTiFf+gZby75
         /RxSnMJ7rC21yQqVZis4aWIoUVoNPE94v6IKEUP0PveHpKSwFxvq3W1CvubDWQR6qe
         bNnpLAHHFp7hAcYzWNQHtY+x3tpkjht3g6OootjM=
From:   Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Subject: [PATCH 00/11] drm/bridge: tc358768: Fixes and timings improvements
Date:   Fri, 04 Aug 2023 13:44:05 +0300
Message-Id: <20230804-tc358768-v1-0-1afd44b7826b@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHXWzGQC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI2MDCwMT3ZJkY1MLczMLXcMkM0sTy9Q0o1TjFCWg8oKi1LTMCrBR0bG1tQC
 Z9mO/WgAAAA==
To:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        =?utf-8?q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@gmail.com>,
        Francesco Dolcini <francesco@dolcini.it>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Aradhya Bhatia <a-bhatia1@ti.com>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1452;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=ec+E8wh10rTaYnjVd1fUIk4t7tXWKF9z3ngkuGu00y0=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBkzNaNljbbUNDMOkcnzROAG9dzBPvp0n+U4KrJI
 NnEwdQg3SyJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCZMzWjQAKCRD6PaqMvJYe
 9YkRD/wO66ceb4plELU/Cr2ySadEAsZDWKtMN85jgtyFNlOen+4smHFqxwqnd9Gz1CaxCjyPLDH
 Ti9FSLn4C5GZDUwFjpvW8ATvgoWRRT9QfCEYoChuPvPGGHbDvm881d/BqqIhWMnu2eQYp61G8yX
 WZgyEg/HFdGeCnlnhP/yQ1SBUwj4WyQkfQzuDiNi/ShtVdOqY+iU2dcYZ28z7tGUPwK+pQCzVa0
 Sgh5IAv1di3DOpU7JyqvrlEtQAPMb8m85LHO66R3m60tJV3DQzTdtBit6poI9LqdkKTMjEl+4N2
 c2DYcg6vHJm8sbQGTR0/utqfMbBqtGuFLDm7Qau/sZszknYcqVFd+IrLkUWAtN+3r5Gf4SFkDKO
 tIL7RJ5bQVExivwdHecyDwxJNnEuVTsyi6UwvdUtNTteT7OjO7PY1EufucNHk4RIxjSTC48qXhE
 wXzUaL0YUEqKlLCRBd8gZsJFraukZkUaKestpTSeBTFvyrEbkmzKbjP1jx40wfNM1euzda1iqfD
 mmaoThjToyFzQHtKOGCDZsvzzi4HMlYf8wwmkeirI2PtS64VeGz57sOtUG4j0ITvOtoWhTTr7Q3
 pvGYtYKV2ZGRHmLppjhzCJJXvuuilgSBOrxqO0DAkLPoHaKC7928BmNzS+MNNZWc44ur2wUn8+o
 e8VJyc4tu4j3Ttg==
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

The two main things the series does:
- Improves DSI HSW, HFP and VSDly calculations
- Adds DRM_BRIDGE_ATTACH_NO_CONNECTOR support

 Tomi

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
Tomi Valkeinen (11):
      drm/bridge: tc358768: Fix use of uninitialized variable
      drm/bridge: tc358768: Fix bit updates
      drm/bridge: tc358768: Cleanup PLL calculations
      drm/bridge: tc358768: Use struct videomode
      drm/bridge: tc358768: Print logical values, not raw register values
      drm/bridge: tc358768: Use dev for dbg prints, not priv->dev
      drm/bridge: tc358768: Rename dsibclk to hsbyteclk
      drm/bridge: tc358768: Clean up clock period code
      drm/bridge: tc358768: Fix tc358768_ns_to_cnt()
      drm/bridge: tc358768: Attempt to fix DSI horizontal timings
      drm/bridge: tc358768: Add DRM_BRIDGE_ATTACH_NO_CONNECTOR support

 drivers/gpu/drm/bridge/tc358768.c | 427 +++++++++++++++++++++++++++-----------
 1 file changed, 309 insertions(+), 118 deletions(-)
---
base-commit: b0e9267d4ccce9be9217337f4bc364ca24cf7f73
change-id: 20230804-tc358768-1b6949ef2e3d

Best regards,
-- 
Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>


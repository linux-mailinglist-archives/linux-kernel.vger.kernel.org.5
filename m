Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E1CB7DCDDD
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 14:30:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344541AbjJaN1S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 09:27:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344534AbjJaN1R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 09:27:17 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A54DDE
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 06:27:15 -0700 (PDT)
Received: from [127.0.1.1] (91-158-149-209.elisa-laajakaista.fi [91.158.149.209])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 155F22E4;
        Tue, 31 Oct 2023 14:26:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1698758816;
        bh=DKmaSBfPjAsmOSB9gUuE7vHDo+c0zsyY9ydX30rB1A8=;
        h=From:Subject:Date:To:Cc:From;
        b=Hfc7h1WL+b3dTT6me8poqawgiL8QZbdMP5u8V5EQ42fcmlG656uKpIAyB+L24Kdub
         azU2DSd0fdnFCt96ZkxS9RRqQl13cy34Ok6AqmIPvXbkku3KinzvrAozWWQrydgME3
         FlcwcA4DrND1rxEt+mUriTAJSaK7aD/co8Gi7xQY=
From:   Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Subject: [PATCH 0/2] drm/bridge: tc358767: Fix
 DRM_BRIDGE_ATTACH_NO_CONNECTOR case
Date:   Tue, 31 Oct 2023 15:26:54 +0200
Message-Id: <20231031-tc358767-v1-0-392081ad9f4b@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJ8AQWUC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI2NDA2ND3ZJkY1MLczNzXVOLVOPUpJQ0S9M0AyWg8oKi1LTMCrBR0bG1tQC
 xyQPxWgAAAA==
To:     Aradhya Bhatia <a-bhatia1@ti.com>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=927;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=DKmaSBfPjAsmOSB9gUuE7vHDo+c0zsyY9ydX30rB1A8=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBlQQCrxVSQlEDB/+qxvhhun+vLisEHOP1uoyRNr
 KEWcd0zosWJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCZUEAqwAKCRD6PaqMvJYe
 9ZsFD/9XnGfVZTV3Dap6sY6rAeOcpa1qfhRmVPBfc2A02r53KFsXmBH3L4TMAYy3tw/BegW4Aw0
 6cXWmCOQjQAhoQa4VAJSmS+FfVPJEqusm1LjpS7V7Q30eTlkvLy/+tdKYeZGMllsnC6tyOi/OyC
 QW5uXAaM7dA87qWzOTcNZpqus9S4tfjFa2rr+vjfPFqPEDc6VadiENqBrtMtA5NoylHDN4b3qMM
 fmH5JYu6dlISL5Vn9DBTtgdE5lD29BVrtJf8bbDMDRwEJcCS5Wcia5EbYv6PTyfBYiFJ0fM4bpx
 lSBCZn/7fG7u76geGEWX8P2jF4v2cSYshGKCB50zDDjjTEvO+9p6GGk5CwDY3OcEe7DyQPqixNT
 ts7ws2eTlTraOqNxNByha6Ab0tLCmQiTolQVUsilFH2PBVyPSPK4fqup2iJ1TmXub4CJudyNmJZ
 Vtmb10z51IhOTnkMI6xQVfpL6Df+sw7GlXR1HEIJSR35zHvSCTW6B9pF4Z10JyLmFc8rpXek5pc
 pk65TRVZD/eHe8r9puGsBvKQVDQE05WgaI5XUcL2OGk0ypIFSD7yrWVlfVmTqx3X9T9qiTQxofX
 GqxnlWC7cp4YUJtoxdAhFkjDsDJubeAJ7k4sF7nmXKwyhXj/dOe5uVwLRhysLeJbWPQYNg2r7td
 T6VWaSEdaMmEQkw==
X-Developer-Key: i=tomi.valkeinen@ideasonboard.com; a=openpgp;
 fpr=C4380C3E965EFD81079FF3A7FA3DAA8CBC961EF5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These two patches are needed to make tc358767 work in the
DRM_BRIDGE_ATTACH_NO_CONNECTOR case, at least when using a DP connector.
The first patch, "drm/bridge: tc358767: Support input format negotiation
hook" was already sent separately, but I included it here for
completeness, as both are needed to get a working display.

I have tested this with TI AM654 EVM with a tc358767 add-on card.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
Aradhya Bhatia (1):
      drm/bridge: tc358767: Support input format negotiation hook

Tomi Valkeinen (1):
      drm/bridge: tc358767: Fix link properties discovery

 drivers/gpu/drm/bridge/tc358767.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)
---
base-commit: 79d94360d50fcd487edcfe118a47a2881534923f
change-id: 20231031-tc358767-58e3ebdf95f0

Best regards,
-- 
Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>


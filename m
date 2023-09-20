Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF3A37A86AC
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 16:35:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234927AbjITOft (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 10:35:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232318AbjITOfr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 10:35:47 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DB20AD;
        Wed, 20 Sep 2023 07:35:42 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71722C433C7;
        Wed, 20 Sep 2023 14:35:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695220542;
        bh=HFDW8UoD5QLd6nTbuqGijlmAZk0/AapjhKvVeBKKueU=;
        h=From:Subject:Date:To:Cc:From;
        b=G+iqEvtI91oD9Gvhu+88PxzS8E24ExbtGQ5fcakyWpDsmhiFwhb0RUSjNDOw8GBoY
         37EFpMiql+e16zqxJJuPvMkvRKCPmlolTlzAUSznrPjoiDaNbl/UnXmOH4aMFSed4Y
         CJUh5T/3jVp+BqdeOufDkILWisc2pHuCSHiFSskri3CxtYvRiT1/wRS7fBzCN9sLSp
         44pIHJyxK7DutAdStUiI75mJQy4B3LJwM3qgjwrfDA4aIAgKqHbitfqn0NAlVF18dF
         pI44W4LmbLZg9Bu4qdmblOSTDmWj7y/MxikAEim6JJbFxzfFV3fthz3V5KtLyn/nhu
         dui7/UIfveZjA==
From:   Maxime Ripard <mripard@kernel.org>
Subject: [PATCH RFC v2 00/37] drm/connector: Create HDMI Connector
 infrastructure
Date:   Wed, 20 Sep 2023 16:35:15 +0200
Message-Id: <20230920-kms-hdmi-connector-state-v2-0-17932daddd7d@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACMDC2UC/4WNQQqDMBBFryKz7pQkxsR2VSj0AN0WF6KjDmpSE
 pEW8e4NXqDL/z/v/Q0iBaYI12yDQCtH9i4FdcqgGWrXE3KbMiihclFKjeMccWhnxsY7R83iA8a
 lXgiNNLa0ZOxFWUj4O1DHn0P9gufjDlUqB46J+B53qzym/+ZVokChS1HotstNoW8jBUfT2Yceq
 n3ff/7/jnPGAAAA
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, Emma Anholt <emma@anholt.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Sandy Huang <hjc@rock-chips.com>,
        =?utf-8?q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>
Cc:     Hans Verkuil <hverkuil@xs4all.nl>, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-sunxi@lists.linux.dev,
        Maxime Ripard <mripard@kernel.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=5802; i=mripard@kernel.org;
 h=from:subject:message-id; bh=HFDW8UoD5QLd6nTbuqGijlmAZk0/AapjhKvVeBKKueU=;
 b=owGbwMvMwCX2+D1vfrpE4FHG02pJDKnczBZcvZvWvvnx9OB3fnaN/W8nFaj9Oz5dIO7b2kjDS
 baeucd2dJSyMIhxMciKKbLECJsviTs163UnG988mDmsTCBDGLg4BWAiPl8ZGe6lP2ufnP3PYeFl
 tv7ZBlaV2b6t0usis3xFq2/JeNee9mT4H1tSKODo+Wy7bMD8ZXsip8zcqlN23W1leYiYb7r9yaQ
 URgA=
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here's a series that creates a subclass of drm_connector specifically
targeted at HDMI controllers.

The idea behind this series came from a recent discussion on IRC during
which we discussed infoframes generation of i915 vs everything else. 

Infoframes generation code still requires some decent boilerplate, with
each driver doing some variation of it.

In parallel, while working on vc4, we ended up converting a lot of i915
logic (mostly around format / bpc selection, and scrambler setup) to
apply on top of a driver that relies only on helpers.

While currently sitting in the vc4 driver, none of that logic actually
relies on any driver or hardware-specific behaviour.

The only missing piece to make it shareable are a bunch of extra
variables stored in a state (current bpc, format, RGB range selection,
etc.).

The initial implementation was relying on some generic subclass of
drm_connector to address HDMI connectors, with a bunch of helpers that
will take care of all the "HDMI Spec" related code. Scrambler setup is
missing at the moment but can easily be plugged in.

The feedback was that creating a connector subclass like was done for
writeback would prevent the adoption of those helpers since it couldn't
be used in all situations (like when the connector driver can implement
multiple output) and required more churn to cast between the
drm_connector and its subclass. The decision was thus to provide a set
of helper and to store the required variables in drm_connector and
drm_connector_state. This what has been implemented now.

Hans Verkuil also expressed interest in implementing a mechanism in v4l2
to retrieve infoframes from HDMI receiver and implementing an
infoframe-decode tool.

This series thus leverages the infoframe generation code to expose it
through debugfs.

This entire series is only build-tested at the moment. Let me know what
you think,
Maxime

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
Changes in v2:
- Change from a subclass to a set of helpers for drm_connector and
  drm_connector state
- Don't assume that all drivers support RGB, YUV420 and YUV422 but make
  them provide a bitfield instead.
- Don't assume that all drivers support the Broadcast RGB property but
  make them call the registration helper.
- Document the Broacast RGB property
- Convert the inno_hdmi and sun4i_hdmi driver.
- Link to v1: https://lore.kernel.org/r/20230814-kms-hdmi-connector-state-v1-0-048054df3654@kernel.org

---
Maxime Ripard (37):
      drm/connector: Introduce an HDMI connector
      drm/connector: hdmi: Create a custom state
      drm/connector: hdmi: Add Broadcast RGB property
      drm/connector: hdmi: Add helper to get the RGB range
      drm/connector: hdmi: Add output BPC to the connector state
      drm/connector: hdmi: Add support for output format
      drm/connector: hdmi: Add HDMI compute clock helper
      drm/connector: hdmi: Calculate TMDS character rate
      drm/connector: hdmi: Add custom hook to filter TMDS character rate
      drm/connector: hdmi: Compute bpc and format automatically
      drm/connector: hdmi: Add Infoframes generation
      drm/connector: hdmi: Create Infoframe DebugFS entries
      drm/vc4: hdmi: Create destroy state implementation
      drm/vc4: hdmi: Switch to HDMI connector
      drm/rockchip: inno_hdmi: Remove useless mode_fixup
      drm/rockchip: inno_hdmi: Remove useless copy of drm_display_mode
      drm/rockchip: inno_hdmi: Switch encoder hooks to atomic
      drm/rockchip: inno_hdmi: Get rid of mode_set
      drm/rockchip: inno_hdmi: no need to store vic
      drm/rockchip: inno_hdmi: Remove unneeded has audio flag
      drm/rockchip: inno_hdmi: Remove useless input format
      drm/rockchip: inno_hdmi: Remove useless output format
      drm/rockchip: inno_hdmi: Remove useless colorimetry
      drm/rockchip: inno_hdmi: Remove useless enum
      drm/rockchip: inno_hdmi: Remove tmds rate from structure
      drm/rockchip: inno_hdmi: Remove useless coeff_csc matrix
      drm/rockchip: inno_hdmi: Remove useless mode_valid
      drm/rockchip: inno_hdmi: Move infoframe disable to separate function
      drm/rockchip: inno_hdmi: Create mask retrieval functions
      drm/rockchip: inno_hdmi: Switch to infoframe type
      drm/rockchip: inno_hdmi: Remove unused drm device pointer
      drm/rockchip: inno_hdmi: Switch to HDMI connector
      drm/sun4i: hdmi: Convert encoder to atomic
      drm/sun4i: hdmi: Move mode_set into enable
      drm/sun4i: hdmi: Switch to container_of_const
      drm/sun4i: hdmi: Consolidate atomic_check and mode_valid
      drm/sun4i: hdmi: Switch to HDMI connector

 Documentation/gpu/kms-properties.csv      |   1 -
 drivers/gpu/drm/Kconfig                   |   1 +
 drivers/gpu/drm/drm_atomic.c              |  10 +
 drivers/gpu/drm/drm_atomic_state_helper.c | 634 ++++++++++++++++++++++++++++++
 drivers/gpu/drm/drm_atomic_uapi.c         |   4 +
 drivers/gpu/drm/drm_connector.c           | 196 +++++++++
 drivers/gpu/drm/drm_debugfs.c             | 110 ++++++
 drivers/gpu/drm/rockchip/inno_hdmi.c      | 409 +++++++------------
 drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c    | 203 +++++-----
 drivers/gpu/drm/vc4/vc4_hdmi.c            | 624 ++++-------------------------
 drivers/gpu/drm/vc4/vc4_hdmi.h            |  44 +--
 drivers/gpu/drm/vc4/vc4_hdmi_phy.c        |   6 +-
 include/drm/drm_atomic_state_helper.h     |  15 +
 include/drm/drm_connector.h               | 245 ++++++++++++
 14 files changed, 1557 insertions(+), 945 deletions(-)
---
base-commit: 0bb80ecc33a8fb5a682236443c1e740d5c917d1d
change-id: 20230814-kms-hdmi-connector-state-616787e67927

Best regards,
-- 
Maxime Ripard <mripard@kernel.org>


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B8267D3E43
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 19:47:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230080AbjJWRro (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 13:47:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjJWRrm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 13:47:42 -0400
X-Greylist: delayed 608 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 23 Oct 2023 10:47:39 PDT
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9752EA3
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 10:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Cc:
 To: From; q=dns/txt; s=fe-e1b5cab7be; t=1698083255;
 bh=bw+oJl8a4emYyVVF8XnSKkK9A1IjjDgr8zM8RdIaZMg=;
 b=oyAeEohwVkOLyrto8jhiIqWlLlxSkEv1Hsfr8zSkJJYPlECWCGB6TgMlv2t2n+kjTf8dkLSZL
 ecPduqloiJO5VqLR6Dm+E4Oiy9MD9AkZ7xX8nMCet5DPVE9M/kZLLGmsKFs9qrtmCUasEOdldWU
 glKcS4u2zPNDnJTo5OCQVMK70FeU/WPB8oiXzSmMxnMTwcKMi1H4MEjDHC8t2dqzUm8ngTIfKQI
 lC4qwLyu3kDrFiLyrqL0gtlhUkDQo/s7FXaZpYKUkJ+KQcB2fwgfA7mN0r2SV8Fhf/oaA+veV9H
 2R6d7X3sXd9QGftBjeFahLwOTGZ9VSBUaTJ9L+5zS7sg==
From:   Jonas Karlman <jonas@kwiboo.se>
To:     Heiko Stuebner <heiko@sntech.de>, Sandy Huang <hjc@rock-chips.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Christopher Obbard <chris.obbard@collabora.com>,
        dri-devel@lists.freedesktop.org,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH v5 0/2] drm/rockchip: vop: Add NV15, NV20 and NV30 support
Date:   Mon, 23 Oct 2023 17:37:13 +0000
Message-ID: <20231023173718.188102-1-jonas@kwiboo.se>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 6536af54288c5302e78a77d6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series add support for displaying 10-bit 4:2:0 and 4:2:2 formats produced
by the Rockchip Video Decoder on RK322X, RK3288, RK3328, RK3368 and RK3399.
Also include 10-bit 4:4:4 support since VOP can support that also.

First patch adds new fourcc 10-bit YUV formats with 4:2:2/4:4:4 sub-sampling.
Second patch adds support for displaying the new fourcc formats.

These patches have been in use by LibreELEC and other distros for the
past 3+ years, hoping they can be merged this time around.

A rough libdrm/modetest patch [2] have been used to validate use of
NV15, NV20 and NV30 formats on RK3288, RK3328 and RK3399 boards.

  modetest -s <connector_id>@<crtc_id>:<mode>-<vrefresh>@<format>

Tinker Board R2.0 (rk3288w):
  modetest -s 50:1920x1080-60@NV15

Rock Pi 4 (rk3399):
  modetest -s 52@44:1920x1080-60@NV15

Rock64 (rk3328):
  modetest -s 42:1920x1080-60@NV15

Changes in v5:
- Use drm_format_info_min_pitch() for correct bpp
- Add missing NV21, NV61 and NV42 formats

Changes in v4:
- Rework RK3328/RK3399 win0/1 data to not affect RK3368

Changes in v3:
- No changes, rebased on next-20230616
- R-B tags was collected

Changes in v2:
- Add NV30 format
- R-B tags was not collected due to NV30 changes

This series is also available at [1] and libdrm/modetest patch at [2].

[1] https://github.com/Kwiboo/linux-rockchip/commits/v6.6-rc7-vop-nv15
[2] https://github.com/Kwiboo/libdrm/commits/nv15

Jonas Karlman (2):
  drm/fourcc: Add NV20 and NV30 YUV formats
  drm/rockchip: vop: Add NV15, NV20 and NV30 support

 drivers/gpu/drm/drm_fourcc.c                |  8 +++
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c | 36 ++++++++---
 drivers/gpu/drm/rockchip/rockchip_drm_vop.h |  1 +
 drivers/gpu/drm/rockchip/rockchip_vop_reg.c | 66 +++++++++++++++++----
 include/uapi/drm/drm_fourcc.h               |  2 +
 5 files changed, 96 insertions(+), 17 deletions(-)

-- 
2.42.0


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01CF47CB09C
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 18:56:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234465AbjJPQ4w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 12:56:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234346AbjJPQ4g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 12:56:36 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D022F110F
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 09:53:59 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-4060b623e64so29835805e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 09:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697475238; x=1698080038; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vIIdmNh1k8eBG9uBUahNJ3kj0YyYALSyO9RgB2j97yc=;
        b=cteGmrEu6H+z8BZKwXN9UyqYzyNf55jHNpfI17PhSUJTZgWnKI58onbeP6HHzSLEho
         ++0VpyV86HovZfoyxiExnFUUwqc4kbsjmtdD6uXUQU1E0EZGE6WHeJCBejwbmU07/2qP
         hxDDwc8oH1o1b6d2xRBMOYTKHZdgVzYEwALphk33lorBPLojTTHHfRbPwGUrfKoBxwe9
         C/4hhKadBJm/ZbT1JTipZGyerYgHT5oZFpsjAyh/VjUTTgucsfqZlzsVG3vEsCPjgkz1
         ojfxGkpfjZ7M4hRvHupF8gxhH5kI8bhqnws4hGflScTvzkKuzX5V/x9vsoexOi3E3uFg
         bfxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697475238; x=1698080038;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vIIdmNh1k8eBG9uBUahNJ3kj0YyYALSyO9RgB2j97yc=;
        b=sqb/1vqHtGK+L3/pBZNQFPY3rF0YOdfWJAIhk0s2r5t91IcUdHNOLJdh3LSwGUKzZc
         pcwDrS0x7WFKccnSHXQHiB4pZd8GCqg9BuPaeXDfyXjdPP32ZUIIHIUfNjE6/30MmtxC
         WXtn1NpX1Uv4RxIvHlRkzJdjlKQBPIpYtlOwn6Q1TtScqaTQhoP5ft6r/nnVj2oMZ2wM
         9kAU2l5kMOipsICzz89NiPbrIQO9ln4zi41av6Rn+6IIa8XU/63IFm5MYwcgWlMQloN4
         IDSZJVdoD/C1zDZSRYlgI8a+Gg2DfFqljClRL3l7VgIrtdxRvFfMj4zfRWwbjpXjNJAn
         LaBw==
X-Gm-Message-State: AOJu0Yz0UMy0Zs2MiqIqq6LubEd521WuKE1O4oQm0JTYKeUbzeaROUP5
        avm2F/omp/4VjeGGt7f25XdOJA==
X-Google-Smtp-Source: AGHT+IGNQrJKWVZTwl1M8CB81+la/NYfwFevzUPH8Cxa+b0iPaxGyHdMaaObw+TNq7n1VkEeyw/20g==
X-Received: by 2002:a05:600c:4fd4:b0:405:3622:382c with SMTP id o20-20020a05600c4fd400b004053622382cmr6366074wmq.17.1697475238254;
        Mon, 16 Oct 2023 09:53:58 -0700 (PDT)
Received: from eriador.lumag.spb.ru ([45.84.211.189])
        by smtp.gmail.com with ESMTPSA id s19-20020a05600c45d300b0040648217f4fsm7638996wmo.39.2023.10.16.09.53.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 09:53:57 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Dave Stevenson <dave.stevenson@raspberrypi.com>,
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
        Daniel Vetter <daniel@ffwll.ch>,
        Douglas Anderson <dianders@chromium.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Jessica Zhang <quic_jesszhan@quicinc.com>
Cc:     Marek Vasut <marex@denx.de>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org
Subject: [RFC PATCH 00/10] drm/mipi-dsi: another attempt at sorting out DSI link powerup
Date:   Mon, 16 Oct 2023 19:53:45 +0300
Message-ID: <20231016165355.1327217-1-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is well known that DSI dosn't fully fit into the DRM enable/disable
model thanks to the intermediate LP-11 state: (roughly) the link is already
up, but the video stream is not yet enabled.

Previously we have handled this by forcing DSI link powerup in the
mode_set callback. This worked, but it was not an ideal solution. For
example, it didn't play well with the atomicity part.

Then Dave attempted to solve the issue by adding pre_enable_prev_first.
It also seemed to work fine, until we stumbled at the issue of the
driver being unable to negotiate whether the bridge/panel didn't enable
pre_enable_prev_first because it is not updated yet or because it
doesn't need the callbacks to be inverted.

This series is yet another attempt at solving the DSI link powerup
story. It adds two flags for the DSI evice. One of them should trigger
implicit link powerup at the atomic_pre_enable / atomic_post_disable
callbacks. Another one requests excplicit DSI link power control.

Dmitry Baryshkov (10):
  Revert "drm/bridge: tc358762: Split register programming from
    pre-enable to enable"
  drm/mipi-dsi: document DSI hosts limitations
  drm/mipi-dsi: add API for manual control over the DSI link power state
  drm/msm/dsi: use dsi_mgr_bridge_power_off in
    dsi_mgr_bridge_post_disable
  drm/msm/dsi: implement manual power control
  drm/bridge: tc358762: add support for manual DSI power control
  drm/bridge: ps8640: require manual DSI power control
  drm/bridge: lt9611: mark for automatic DSI power control
  drm/bridge: lt9611uxc: implement automatic DSI power control
  drm/msm/dsi: drop (again) the ps8640 workaround

 drivers/gpu/drm/bridge/lontium-lt9611.c    |  2 +-
 drivers/gpu/drm/bridge/lontium-lt9611uxc.c |  2 +-
 drivers/gpu/drm/bridge/parade-ps8640.c     | 14 ++++-
 drivers/gpu/drm/bridge/tc358762.c          | 24 +++++---
 drivers/gpu/drm/drm_mipi_dsi.c             | 31 ++++++++++
 drivers/gpu/drm/msm/dsi/dsi.h              |  4 ++
 drivers/gpu/drm/msm/dsi/dsi_host.c         | 44 ++++++++++++++
 drivers/gpu/drm/msm/dsi/dsi_manager.c      | 70 +++++++++++++---------
 include/drm/drm_mipi_dsi.h                 | 33 ++++++++--
 9 files changed, 180 insertions(+), 44 deletions(-)

-- 
2.42.0


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C64DD78CC6B
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 20:48:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237770AbjH2SsL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 14:48:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238245AbjH2Srn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 14:47:43 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA76EAD
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 11:47:39 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1bee82fad0fso29494335ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 11:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1693334859; x=1693939659;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dx+edCyWT7zKxIInG8qNdrcdM7Jww6Q6gVOtGT7ALUw=;
        b=NXBOd2mkw+gBkwUStDBV8PaGrgZhqCKwaBrY9Usk61+UBBtfDS7Uj7teurMoc22HQb
         3V5SHImgrwViJcGhvlCFMtXqOLx3dqfDPhULkiewQIPMxijOSEnXsKzFpiSIxv02jyRE
         +Jf3CDHT970kefX0aposB1huf8Yi6tErzFupQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693334859; x=1693939659;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dx+edCyWT7zKxIInG8qNdrcdM7Jww6Q6gVOtGT7ALUw=;
        b=MfO80tkgS8ClKKwbQaJfe4SPsJOpmM3oRi7FxdusDzET824HO+sAuvTacvn+7RF5fY
         hyZy/oyv9cMZfc/i1UZumATlGsxEZ1MQVBt0721IDU0Z+59miAgUwiS9irA1nOnKzTeq
         Wlo9t0FRT6nS4+2ZVR0BAxzzYAencHTnc9QNm6LmDhOJtMfd+c7oh1ukUiOHOY8QKu0p
         jj/Ppzr1tSR1rqI1Ssj7xUOGTBGPslXnqsM8APZfEGWfi2mHjyxu/tZnNsBC/BOxiNJf
         hs1LlXKGWhzJVhalRSoSNmJiQV7X9RxEUQvUq2JWwnkwsOM4zhuxgTVR8NGA/Z8hbixU
         02rw==
X-Gm-Message-State: AOJu0Yw6LQ2kFhFkFhL6uO+tpmIbo8mOEKpRA9D9gbifT9ENP517lU/4
        VFbNAchg3zaWQFbqluv13evYtg==
X-Google-Smtp-Source: AGHT+IES+SJEkk4EUF9mvR0kkp/iKD9S9fLPoptNHth9XsbuVQ5O48L+bHDHC/h6NFzIK11AbzCyfA==
X-Received: by 2002:a17:903:1205:b0:1c2:54c:8beb with SMTP id l5-20020a170903120500b001c2054c8bebmr1955615plh.31.1693334858992;
        Tue, 29 Aug 2023 11:47:38 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:11a:201:d603:22a7:5e5e:d239])
        by smtp.gmail.com with ESMTPSA id o15-20020a170902d4cf00b001b9e86e05b7sm9697953plg.0.2023.08.29.11.47.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Aug 2023 11:47:38 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        Sean Paul <sean@poorly.run>, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org,
        Vinod Polimera <quic_vpolimer@quicinc.com>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>
Subject: [PATCH 0/7] drm/msm/dp: Simplify DPCD related code with helpers
Date:   Tue, 29 Aug 2023 11:47:25 -0700
Message-ID: <20230829184735.2841739-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.42.0.rc2.253.gd59a3bf2b4-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This driver open-codes a few of the DPCD register reads when it can be
simplified by using the helpers instead. This series reworks the MSM DP
driver to use the DPCD helpers and removes some dead code along the way.
There's the potential for even more code reduction around the test
registers, but I haven't tried to do that yet.

Stephen Boyd (7):
  drm/msm/dp: Replace open-coded drm_dp_read_dpcd_caps()
  drm/msm/dp: Use drm_dp_read_sink_count() helper
  drm/msm/dp: Remove dead code related to downstream cap info
  drm/msm/dp: Remove aux_cfg_update_done and related code
  drm/msm/dp: Simplify with drm_dp_{max_link_rate,max_lane_count}()
  drm/msm/dp: Inline dp_link_parse_sink_count()
  drm/msm/dp: Remove dp_display_is_ds_bridge()

Cc: Vinod Polimera <quic_vpolimer@quicinc.com>
Cc: Kuogee Hsieh <quic_khsieh@quicinc.com>

 drivers/gpu/drm/msm/dp/dp_display.c |   9 +--
 drivers/gpu/drm/msm/dp/dp_link.c    |  38 +---------
 drivers/gpu/drm/msm/dp/dp_panel.c   | 105 +++++-----------------------
 drivers/gpu/drm/msm/dp/dp_panel.h   |  10 +--
 4 files changed, 22 insertions(+), 140 deletions(-)


base-commit: 2dde18cd1d8fac735875f2e4987f11817cc0bc2c
-- 
https://chromeos.dev


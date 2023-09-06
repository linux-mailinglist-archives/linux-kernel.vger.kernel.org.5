Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B1877942E0
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 20:12:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243469AbjIFSMl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 14:12:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233762AbjIFSMk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 14:12:40 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7EDC19BC
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 11:12:29 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-68a3ced3ec6so116865b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Sep 2023 11:12:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1694023949; x=1694628749; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rzB/a+Y/lgN6TI3eOxXMKAuw0gNhLZ5Kr4Exadxywqo=;
        b=C+CzTbcjEHUf3yQsEjRfD9PMntW7j/Cl+D28GEPf66/vLntnSvERPwsi1kU4eYVbVE
         v7l9efFKsDtH00mitIxEuhPOTGTqvEEUJutUnv4frCY/IosxumEfFCLLXrGiqJ7qBuUg
         I2XAn/bBVorbGqm56E9sfG1oxVKxTjcnglodY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694023949; x=1694628749;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rzB/a+Y/lgN6TI3eOxXMKAuw0gNhLZ5Kr4Exadxywqo=;
        b=RNyHapazc+j21ZZ22GPmINwXxHmL0TAd6+lUD2kC1YOXf/Jlp/PB5U4d+78qFXFTH3
         igirEGXL4MBzccV4pBB5cFJU4vB9XWXIHuV55nSpLzVaOwI+EYf+2kjyTsPWgIXgkWWk
         yNWwnTwJ6BfLkdhfWpYYoZb7Awy6MyHRWigLTAgpKMWLws8qH+tcr/VbIFJTZHGG/y8s
         JnJfH+8O4SYjBgBjBd5JS97lPj5poe9cnBtO0w3sAC7LCOfS+g11K9pPW6x0yNpsHLAb
         CX7QKWWxHmooUZFjdebTISs4bG4Jm+3USQoOmH0fmKWZjSmOzZK3BF1a+5cP08rimVyZ
         g5Og==
X-Gm-Message-State: AOJu0YyQdkxovpbipusjdzgyZQZpuHrfLFcccwOw55+oF4mhK2Q/zHEu
        j6hAmwmyGiFPHS6M/PYkF1LJZQ==
X-Google-Smtp-Source: AGHT+IFw80g3ey9sUj6HYD/2kE56XDAkqaOhhVXfaGukTfoWlgxr29tf8KH2PEk4eYpkhtgk61cguQ==
X-Received: by 2002:a05:6a21:3e0b:b0:14c:5dc3:f1d5 with SMTP id bk11-20020a056a213e0b00b0014c5dc3f1d5mr15722364pzc.32.1694023949115;
        Wed, 06 Sep 2023 11:12:29 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:11a:201:a404:ed4a:5a1e:3b4a])
        by smtp.gmail.com with ESMTPSA id c10-20020a62e80a000000b0064fde7ae1ffsm11080552pfi.38.2023.09.06.11.12.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Sep 2023 11:12:28 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        Sean Paul <sean@poorly.run>, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org
Subject: [PATCH 0/2] drm/msm/dp: More DPCD cleanups
Date:   Wed,  6 Sep 2023 11:12:24 -0700
Message-ID: <20230906181226.2198441-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a follow-on to this series[1]. I can resend the whole pile if
desired.

[1] https://lore.kernel.org/r/20230829184735.2841739-1-swboyd@chromium.org

Stephen Boyd (2):
  drm/msm/dp: Inline dp_display_is_sink_count_zero()
  drm/msm/dp: Remove error message when downstream port not connected

 drivers/gpu/drm/msm/dp/dp_display.c | 10 +---------
 drivers/gpu/drm/msm/dp/dp_panel.c   |  1 -
 2 files changed, 1 insertion(+), 10 deletions(-)


base-commit: 2dde18cd1d8fac735875f2e4987f11817cc0bc2c
prerequisite-patch-id: c637903336fb0fd5593f0016f0c863305c43a6b9
prerequisite-patch-id: 8610693078de9cd5041266c70c4d044d15a5f701
prerequisite-patch-id: e10675f41cc68dcefa566f7f288b2df72afdb116
prerequisite-patch-id: 63280d764b830e3d25455ae642840cff5f90e118
prerequisite-patch-id: 567e00d48c5a296b454079a51483f2acce357347
prerequisite-patch-id: 1c18472728edc1ca8800dd6ed6ff12cb98084ea8
prerequisite-patch-id: c6f74b922b3a4f2255bcdab11fe3a2ecf7891262
-- 
https://chromeos.dev


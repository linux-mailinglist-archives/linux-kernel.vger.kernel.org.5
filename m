Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43511806170
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 23:07:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346460AbjLEWFy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 17:05:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346479AbjLEWFl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 17:05:41 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20254D40;
        Tue,  5 Dec 2023 14:05:48 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id 41be03b00d2f7-5c6734e0c22so1680969a12.0;
        Tue, 05 Dec 2023 14:05:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701813947; x=1702418747; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Lt1kIBCZQd3LG/iBwo/J1swllC6IeMh/7niRSSG8eSM=;
        b=KiI9iW8/vZH6wVEg2akCBm+IZzAOP2WxbGHKfqXBcLOfPjJvgzTdGTCDsn/XyR6D3Y
         hbhmQOT/dYPpPWl6MskXnyRFN0FKciAIsmthwZX+5QIv7R2T1wScaKAqV54Egmx+dtE+
         LPHD8R0vSfn64enrBkEm/iwr+EH+JZX+tKW7tLpXr2GMTcv8cRwkq8JDWl4Ae63ls8iP
         ySyXUeWb7I5w0dx8N5oPLLAcvzuONH8sYGyH83Vng6q2KWxsv/y3z3Ezljr/B6Nh63p3
         LymicdqfvisGF3aokMaitKHNxXrpc0X7vnTXdBa/GT9MtZFk5Uc5ixUvaWdTXitvmSTa
         IBdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701813947; x=1702418747;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Lt1kIBCZQd3LG/iBwo/J1swllC6IeMh/7niRSSG8eSM=;
        b=PZF9P/lq2ZkJJZQgjymjr36KJqhRCwDv3AT5j57GbQkWejDQtfVKmop4GTIwJk82LM
         3/RuubqyYRhB1MvgB7vCHJnKD8021klazA7NtStbWq6W0OpsJNR/mU3eVIX6N364qjxd
         UFL+sB12Gbm/072KMrj/StEjJ5OPArEOH2PcYapP2lnFafYZ7y1DFgvakSDfUxXSHgHc
         Ht+vk/RPzsnTk/HqvCjM0DRylgzXTMXMHmHcEl9n/5MWijb4CnprGpoMKKof5XWKwjw8
         qM3l8sToFnR+wMxT9oW+Kt8gDEoRgVNB7oyinJRwq0Z6VLkDBsNpKjcoY623EV/WHH6E
         dm3w==
X-Gm-Message-State: AOJu0Yx4k0zkhAhXHeqAuQAfgW9rel4F1UawHrWS+FI8yVT4NCoLjWBV
        Ko6gmvSR38VzcUIlcVKMjPE=
X-Google-Smtp-Source: AGHT+IGCYdrq8ZCbOguCKZk5oP4hEivw111igFkO+eYDHvqYTmFBPkRzxrRBea62JTpfvkPxKwziLA==
X-Received: by 2002:a17:90b:1e0b:b0:286:bd82:1435 with SMTP id pg11-20020a17090b1e0b00b00286bd821435mr1671891pjb.22.1701813947284;
        Tue, 05 Dec 2023 14:05:47 -0800 (PST)
Received: from localhost ([2a00:79e1:2e00:1301:e1c5:6354:b45d:8ffc])
        by smtp.gmail.com with ESMTPSA id bt10-20020a17090af00a00b00286e69c8fb1sm1498921pjb.52.2023.12.05.14.05.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 14:05:46 -0800 (PST)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        Rob Clark <robdclark@chromium.org>,
        Akhil P Oommen <quic_akhilpo@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-kernel@vger.kernel.org (open list),
        linux-pm@vger.kernel.org (open list:SUSPEND TO RAM),
        Marijn Suijten <marijn.suijten@somainline.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Sean Paul <sean@poorly.run>, Stephen Boyd <swboyd@chromium.org>
Subject: [PATCH 0/5] drm/msm/adreno: Introduce/rework device hw catalog
Date:   Tue,  5 Dec 2023 14:03:26 -0800
Message-ID: <20231205220526.417719-1-robdclark@gmail.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rob Clark <robdclark@chromium.org>

Split the single flat gpulist table into per-gen tables that exist in
their own per-gen files, and start moving more info into the device
table.  This at least gets all the big tables of register settings out
of the heart of the a6xx_gpu code.  Probably more could be moved, to
remove at least some of the per-gen if/else ladders, but this seemed
like a reasonably good start.

Rob Clark (5):
  drm/msm/adreno: Split up giant device table
  drm/msm/adreno: Split catalog into separate files
  drm/msm/adreno: Move hwcg regs to a6xx hw catalog
  drm/msm/adreno: Move hwcg table into a6xx specific info
  drm/msm/adreno: Move CP_PROTECT settings to hw catalog

 drivers/gpu/drm/msm/Makefile               |    5 +
 drivers/gpu/drm/msm/adreno/a2xx_catalog.c  |   53 +
 drivers/gpu/drm/msm/adreno/a3xx_catalog.c  |   75 ++
 drivers/gpu/drm/msm/adreno/a4xx_catalog.c  |   51 +
 drivers/gpu/drm/msm/adreno/a5xx_catalog.c  |  145 +++
 drivers/gpu/drm/msm/adreno/a6xx_catalog.c  | 1118 ++++++++++++++++++++
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c      |  817 +-------------
 drivers/gpu/drm/msm/adreno/a6xx_gpu.h      |   11 +
 drivers/gpu/drm/msm/adreno/adreno_device.c |  559 +---------
 drivers/gpu/drm/msm/adreno/adreno_gpu.h    |   22 +-
 10 files changed, 1506 insertions(+), 1350 deletions(-)
 create mode 100644 drivers/gpu/drm/msm/adreno/a2xx_catalog.c
 create mode 100644 drivers/gpu/drm/msm/adreno/a3xx_catalog.c
 create mode 100644 drivers/gpu/drm/msm/adreno/a4xx_catalog.c
 create mode 100644 drivers/gpu/drm/msm/adreno/a5xx_catalog.c
 create mode 100644 drivers/gpu/drm/msm/adreno/a6xx_catalog.c

-- 
2.42.0


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED4DC765DE2
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 23:22:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229939AbjG0VWk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 17:22:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjG0VWi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 17:22:38 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58FAD30E8;
        Thu, 27 Jul 2023 14:22:37 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-686f8614ce5so943559b3a.3;
        Thu, 27 Jul 2023 14:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690492957; x=1691097757;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AW9Y79n7Axnf4OMyAvU6E9fxTGTVMF/uH4OXVJGy0wc=;
        b=LoQO9MruCx3aDX53QSt31jjbpqI7Vjb69Z3uSMTxVty0V9yJrQgPTvrfQu4/IsKKCa
         c7H0MlcS6fR41OmXGSkhIRHRmrnTH5HkihdTYHpm/rVKDQ7GsQmhynlaGpD0RtNl4mWx
         w0JK8qHntfJP2Nmx8nSju3jlJlGsk3chkC/pbIWURgdr9jsd5D4cmXUmAUPYCqtsVvhs
         Zddz6UBSLk4ZYehSsWx5V3GYHPM13r8WtBa/hMfjSiw+QlB9oC801VZk1FUfZTWDLUKg
         o2SeGIsAGwkehzUHHvvDdu3W90RJAfkf+B2bTF0Olfws1V0vYW1wkCURwJjCGeAPTZYW
         g58A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690492957; x=1691097757;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AW9Y79n7Axnf4OMyAvU6E9fxTGTVMF/uH4OXVJGy0wc=;
        b=L3F+nksS9Kk+Kf9yZDZEK0DN6rKEcdbqyBpuvx9jC6zDaLHZMKKgUCvQzGrVnWR1d9
         Z6j6wV96wQDrEi4feQRoje+WZKWtJpXWch2tMfEUXkSHxSG4/JIAvREcd8RjGG5a3XGM
         9wCIBy1tL+gL6msbHEVKQ3ssVxEsKi4aKUFbq+lx3yGgQUPtM0gMVT3YWmbZ5vWaKDWz
         HlbmOUJYzpP5af3hGOFUGCjKDZaw1aUfLDnrHJ7pCOFIOEhcEpDz5DFqUCqDF6yal+lw
         yghRz01jyamnF1AdBFRoq+76Fw4h3Jr4VcE9YfL1ZuZv5Ha03o3gMQnEqILwMIZbi2Ih
         5RqA==
X-Gm-Message-State: ABy/qLZA7pVnORiAkKUpnHQSdQ8/6gdPPsyQzELEv14sK98jYdH7cJbR
        rqO9OJIbtI2AVDGBAMBKhmik9xWkPfZLRg==
X-Google-Smtp-Source: APBJJlFHi1voxlxXheXlidoFFam4W3IYbNYZSFTSlKjdlMcn4KoCpsM8VrL8jH/ByC1+CMZirkg6PQ==
X-Received: by 2002:a05:6a21:329c:b0:12f:6aee:7e43 with SMTP id yt28-20020a056a21329c00b0012f6aee7e43mr316185pzb.57.1690492956735;
        Thu, 27 Jul 2023 14:22:36 -0700 (PDT)
Received: from localhost ([2a00:79e1:abd:4a00:69d1:d8aa:25be:a2b6])
        by smtp.gmail.com with ESMTPSA id u8-20020a62ed08000000b00666912d8a52sm1869099pfh.197.2023.07.27.14.22.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 14:22:36 -0700 (PDT)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Akhil P Oommen <quic_akhilpo@quicinc.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Clark <robdclark@chromium.org>,
        Adam Skladowski <a39.skl@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Chia-I Wu <olvaffe@gmail.com>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS), Douglas Anderson <dianders@chromium.org>,
        Elliot Berman <quic_eberman@quicinc.com>,
        Guru Das Srinagesh <quic_gurus@quicinc.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Johan Hovold <johan+linaro@kernel.org>,
        linux-kernel@vger.kernel.org (open list),
        Marijn Suijten <marijn.suijten@somainline.org>,
        Mukesh Ojha <quic_mojha@quicinc.com>,
        Rob Clark <robdclark@gmail.com>, Rob Herring <robh@kernel.org>,
        Sean Paul <sean@poorly.run>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH v2 00/13] drm/msm/adreno: Move away from legacy revision matching
Date:   Thu, 27 Jul 2023 14:20:05 -0700
Message-ID: <20230727212208.102501-1-robdclark@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rob Clark <robdclark@chromium.org>

Downstream seems to be moving to using the chip_id as simply an opaque
identifier, and if we want to avoid headaches with userspace mesa
supporting both kgsl and upstream, we should move away from the
assumption that certain bits in the chip_id have a specific meaning.

v2 adds a patch to move adreno_info to adreno_platform_config rather
than needing to look it up in multiple places.

Rob Clark (13):
  drm/msm/adreno: Remove GPU name
  drm/msm/adreno: Remove redundant gmem size param
  drm/msm/adreno: Remove redundant revn param
  drm/msm/adreno: Use quirk identify hw_apriv
  drm/msm/adreno: Use quirk to identify cached-coherent support
  drm/msm/adreno: Allow SoC specific gpu device table entries
  drm/msm/adreno: Move speedbin mapping to device table
  drm/msm/adreno: Bring the a630 family together
  drm/msm/adreno: Add adreno family
  drm/msm/adreno: Add helper for formating chip-id
  drm/msm/adreno: Move adreno info to config
  dt-bindings: drm/msm/gpu: Extend bindings for chip-id
  drm/msm/adreno: Switch to chip-id for identifying GPU

 .../devicetree/bindings/display/msm/gpu.yaml  |   6 +
 drivers/gpu/drm/msm/adreno/a2xx_gpu.c         |   2 +-
 drivers/gpu/drm/msm/adreno/a4xx_gpu.c         |   2 +-
 drivers/gpu/drm/msm/adreno/a5xx_gpu.c         |   4 +-
 drivers/gpu/drm/msm/adreno/a5xx_power.c       |   2 +-
 drivers/gpu/drm/msm/adreno/a6xx_gmu.c         |  16 +-
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c         | 189 ++---------
 drivers/gpu/drm/msm/adreno/adreno_device.c    | 294 ++++++++++++------
 drivers/gpu/drm/msm/adreno/adreno_gpu.c       |  53 ++--
 drivers/gpu/drm/msm/adreno/adreno_gpu.h       | 154 ++++++---
 10 files changed, 365 insertions(+), 357 deletions(-)

-- 
2.41.0


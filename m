Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C7F67846B5
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 18:16:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237567AbjHVQQb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 12:16:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235021AbjHVQQa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 12:16:30 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F395137
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 09:16:28 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2bb9a063f26so74810401fa.2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 09:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692720987; x=1693325787;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+aamOY9tWQl1yDw6EglxMSOp5KjQTwYClXfZ+RS9kD8=;
        b=zxwtHOBu51pGYphJZU/FsnIVY14v80PUR2G6elLozRHCPVviQqeNevne+eTjsz2Sfz
         TLkaDOoM2FgTSGXsbbAqTo+cRS2TFUfxDtxrFkYYY1UwKdtUOcklAqxCqwEXwEMJAkXO
         11U9Ot1qc4x3utKo04CEMBAB1hYJUdQsKvhSjcgS/ZJH4acPSzgPVFPSm01EesdiJppN
         byBvSNVOkWwdNwXop1oIyXEsa+zB+a+22GZJ1IV2tbuz5z+9+1yK5sXiCxP9ZDKKGCRx
         8w1Zv41Z8YpmxygY2vbVEtPC6OwKKEDayd5zAfONPV94XH+eXTzOLLmaiImMR12x0YpI
         BgRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692720987; x=1693325787;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+aamOY9tWQl1yDw6EglxMSOp5KjQTwYClXfZ+RS9kD8=;
        b=KCciWu4oquXMjeTPNLTGoz+OqVzoupqDxH1ee6u5IyVkdJ2iAmkgiGq+0BEiPZtNNj
         hUAMf8G1q9o519J/H1tCGjvOxWfmgiJed1TwSKMktC9bmt6UeAoxSKameb5doP0uHd+m
         o0xemk5sAyx/m0J9ATlemE2+ih4NgD1JyJoUN9o27KMM74Bv7wmGvNIuSuqD0EtM3PdL
         t0bzSxbtbVedoWjhh8B51jjOe20DZd5LjUHkGsNa05PPydtxPXPa9ti6B12zrWjFjdGs
         KlzFeucunoenX9a9/9CLp+Zo+8jFVNpdT0s4aqtCGnfsF02ZgskN6wqpNpIEhQIX92eR
         fGQw==
X-Gm-Message-State: AOJu0Yw6CtCSCrLrM9I3b+JxDnI6yPOjw9Gpc0fMnr+jAbr2p0ZdhMLC
        dqMVklY84Epzq/oGquDTqduQDyv66VGYQccCOcA=
X-Google-Smtp-Source: AGHT+IGoQO15/tEGDHhkk5R2/Kfphc/BQactKKbeUPEgxihemSj0oFRMtypm/SWkLhfrkVVLoF+BGQ==
X-Received: by 2002:a05:651c:21b:b0:2b6:eefc:3e4f with SMTP id y27-20020a05651c021b00b002b6eefc3e4fmr7849412ljn.21.1692720986749;
        Tue, 22 Aug 2023 09:16:26 -0700 (PDT)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id t23-20020a7bc3d7000000b003fe1fe56202sm16516130wmj.33.2023.08.22.09.16.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Aug 2023 09:16:25 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     rfoss@kernel.org, todor.too@gmail.com, bryan.odonoghue@linaro.org,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        mchehab@kernel.org, hverkuil-cisco@xs4all.nl,
        laurent.pinchart@ideasonboard.com, sakari.ailus@linux.intel.com,
        andrey.konovalov@linaro.org
Cc:     linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 0/9] media: qcom: camss: Bugfix series
Date:   Tue, 22 Aug 2023 17:16:11 +0100
Message-ID: <20230822161620.1915110-1-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

V1:
- Drops dt_id = vc * 4 in favour of a patch in a later series - Hans
  Link: https://git.codelinaro.org/bryan.odonoghue/kernel/-/commit/d4c382c5d6ee153b410a01e172b3e811011d0b14
- Adds Konrad's Acked-by as indicated

V0:
This series covers a number of Fixes: all of which are for application to
stable as well as -next with the exception of the second patch which is a
fix for a SHA that is still in -next.

Link: https://git.codelinaro.org/bryan.odonoghue/kernel/-/tree/linux-next-23-08-07-db410c-rb3-camss-dts-v3

This series is part of a larger set of fixes, improvements developed/found
when adding a new SoC.

Link: https://git.codelinaro.org/bryan.odonoghue/kernel/-/tree/lenovo-x13s-v6.5-rc4-x13s-camss-patches

First pass on that larger series is to get all of the current Fixes: in the
branch out.

Andrey Konovalov (1):
  media: qcom: camss: Fix csid-gen2 for test pattern generator

Bryan O'Donoghue (8):
  media: qcom: camss: Fix pm_domain_on sequence in probe
  media: qcom: camss: Fix V4L2 async notifier error path
  media: qcom: camss: Fix vfe_get() error jump
  media: qcom: camss: Fix VFE-17x vfe_disable_output()
  media: qcom: camss: Fix VFE-480 vfe_disable_output()
  media: qcom: camss: Fix missing vfe_lite clocks check
  media: qcom: camss: Fix invalid clock enable bit disjunction
  media: qcom: camss: Fix set CSI2_RX_CFG1_VC_MODE when VC is greater
    than 3

 .../platform/qcom/camss/camss-csid-gen2.c     | 11 ++++----
 .../qcom/camss/camss-csiphy-3ph-1-0.c         |  2 +-
 .../media/platform/qcom/camss/camss-vfe-170.c | 19 +++-----------
 .../media/platform/qcom/camss/camss-vfe-480.c | 19 +++-----------
 drivers/media/platform/qcom/camss/camss-vfe.c |  5 ++--
 drivers/media/platform/qcom/camss/camss.c     | 26 +++++++++----------
 6 files changed, 28 insertions(+), 54 deletions(-)

-- 
2.41.0


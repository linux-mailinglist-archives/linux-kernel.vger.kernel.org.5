Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF3CF77F967
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 16:39:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352124AbjHQOi5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 10:38:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351990AbjHQOiS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 10:38:18 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 914BE2D74
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 07:38:16 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-31792ac0fefso6600525f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 07:38:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692283095; x=1692887895;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Vcmi1whAad9h02nNDVeVHC4+C/O4Vuc5lp027jllJ/g=;
        b=iZlaSUEJFUAYJWiJOZMeQQNGfEhTP4BS3yfnhMGerYrN+VuT2PdGd91wQcUZFblVrc
         WdK65lFu4DDQ7JEKmZ161kwYrQug/PXAyztqbaomItSGAd1wdytC/kz56aGeRDQyxWuN
         eNwKdgS/d2zRq5jOBcYQ/HXAs6kA5dDzInKGZ9kOiqlFCJHqSZhUHok/OIpNpSE1T3OW
         GM4qwzyJdx25DxViWQ/WnTjKqTloyl7hnvVEZj7Mes/1banW8s7E4Mup4nQ+jcbfN1r2
         0+GKcc26qrDAUZgllguIHNOCpleJni78zQSWPeMKShPIamDfym+reSRea5EQMpY4qsAD
         eRcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692283095; x=1692887895;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Vcmi1whAad9h02nNDVeVHC4+C/O4Vuc5lp027jllJ/g=;
        b=Iybn+ojykBrvp07T9m1wsXH14RVUXZqyOHzMzqKXYHBUoNZ6tsLAr7IfbWbQLg3txA
         rfBvauq13V68AatLpVPYuyRAQZrLfG13+ATbNuMFQrSQ1eJ7jojB2pwp8L0TSnH84oZE
         ow0/z891WGb+AdSeOykchOQH9drXfpEw8OLgo2CHnca5dzPY5rS3nqahh2Grajt41Y69
         5RF3E63m+miZ3aIVCP+L/4B51jskEqOOatmEOUjWe3iQqRPQ4bSNAR5tEFSdND2k4Seg
         NuE5+qI/PXG3Ez7++JJbvm2W/w1n+2UczulvFHPo7HL8j90bMr8a3ov48jKDjq5Stspn
         9dUw==
X-Gm-Message-State: AOJu0YxddYzPbnbkJxAxDWOW6xlpdwx1HSztT4uR6+sL7w3EHKeyjRYR
        6tOhBdkYaHgloY+wS4N9zDI6BQ==
X-Google-Smtp-Source: AGHT+IFF8vlscKL16vWcg27fvlDcmWJ9mfPAxw2HKXFE75Z9MtW/oElFzWiiWRF/3rBoOWfZlSIM3A==
X-Received: by 2002:a5d:4cc8:0:b0:317:67bf:3387 with SMTP id c8-20020a5d4cc8000000b0031767bf3387mr4979948wrt.60.1692283095045;
        Thu, 17 Aug 2023 07:38:15 -0700 (PDT)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id i8-20020a5d4388000000b0030647449730sm25218232wrq.74.2023.08.17.07.38.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Aug 2023 07:38:14 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     rfoss@kernel.org, todor.too@gmail.com, bryan.odonoghue@linaro.org,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        mchehab@kernel.org, hverkuil-cisco@xs4all.nl,
        laurent.pinchart@ideasonboard.com, sakari.ailus@linux.intel.com,
        andrey.konovalov@linaro.org
Cc:     linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 00/13] media: qcom: camss: Add parameter passing to remove several outstanding bugs
Date:   Thu, 17 Aug 2023 15:37:59 +0100
Message-ID: <20230817143812.677554-1-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.41.0
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

V2:
- Replaces &camss->res with pointer to res - Konrad
- Squashes patch for NULL removal - Konrad
- Left suggestion on ICC initialisation points alone, doesn't seem to fit Konrad/bod

Link: https://git.codelinaro.org/bryan.odonoghue/kernel/-/tree/linux-next-23-08-07-db410c-rb3-camss-dts-v3+maintenance-bugfixes-v2

V1:
- I forgot to include patch # 14 in V0 of this series.
  This patch leverages previous changes to unwind the fixed polling of
  RDI[0..2] allowing driver data to articulate on a per-VFE basis how many
  RDIs to poll.

Link: https://git.codelinaro.org/bryan.odonoghue/kernel/-/tree/linux-next-23-08-07-db410c-rb3-camss-dts-v3+maintenance-bugfixes-v1

V0:
This second series of bugfixes stacks ontop of the Fixes series sent earlier.

Link: https://lore.kernel.org/linux-arm-msm/20230814141007.3721197-1-bryan.odonoghue@linaro.org/T/#t

Rather than send both series as one giant series, I opted to send a pure
Fixes series above, with this second series a non-backport series i.e. no
Fixes tags in this series.

The existing CAMSS code relies on some hard-coded parameters buried inside
of the driver, instead of passed via compat .data as arguably ought to be
the case.

This brittle model is an extending morass of spaghetti code. More than that
in CAMSS Video Front Ends (VFEs) and the number of Raw Data Interfaces
(RDIs) per VFE can vary from SoC to SoC. Indeed sm8250 has VFE and VFE Lite
blocks which have a different number of RDIs per block.

The use of defines as opposed to per-compat parameters inside of ISRs leads
to either under-polling or over-polling the number of RDIs.

On top of all of that we have some hard-coded statements for clock names
which breaks easily.

We can solve the under/over polling loop problem by transitioning loop
controls from macros to parameters passed via probe().

Similarly and unsurprisingly we can also solve the hard-coded clock problem
by adding some string processing routines that take passed arguments.

There is still some additional maintenance work to be done in this driver
but before adding one more SoC the code needs to be made more extensible
and less brittle.

Link: https://git.codelinaro.org/bryan.odonoghue/kernel/-/commits/dc346c7f46c0680bcfb84fded6db97497fffe49a

Bryan O'Donoghue (13):
  media: qcom: camss: Amalgamate struct resource with struct
    resource_ispif
  media: qcom: camss: Start to move to module compat matched resources
  media: qcom: camss: Pass icc bandwidth table as a platform parameter
  media: qcom: camss: Pass remainder of variables as resources
  media: qcom: camss: Pass line_num from compat resources
  media: qcom: camss: Assign the correct number of RDIs per VFE
  media: qcom: camss: Use >= CAMSS_SDM845 for vfe_get/vfe_put
  media: qcom: camss: Untangle if/else spaghetti in camss
  media: qcom: camss: Improve error printout on icc_get fail
  media: qcom: camss: Allow clocks vfeN vfe_liteN or vfe_lite
  media: qcom: camss: Functionally decompose CSIPHY clock lookups
  media: qcom: camss: Add support for setting CSIPHY clock name csiphyX
  media: qcom: camss: Support RDI3 for VFE 17x

 .../media/platform/qcom/camss/camss-csid.c    |  24 +-
 .../qcom/camss/camss-csiphy-3ph-1-0.c         |   8 +-
 .../media/platform/qcom/camss/camss-csiphy.c  |  67 ++--
 .../media/platform/qcom/camss/camss-ispif.c   |  32 +-
 .../media/platform/qcom/camss/camss-ispif.h   |   4 +-
 .../media/platform/qcom/camss/camss-vfe-170.c |  17 +-
 .../media/platform/qcom/camss/camss-vfe-4-1.c |   2 -
 .../media/platform/qcom/camss/camss-vfe-4-7.c |   2 -
 .../media/platform/qcom/camss/camss-vfe-4-8.c |   2 -
 .../media/platform/qcom/camss/camss-vfe-480.c |   5 +-
 drivers/media/platform/qcom/camss/camss-vfe.c |  78 +++--
 .../media/platform/qcom/camss/camss-video.c   |  16 +-
 drivers/media/platform/qcom/camss/camss.c     | 293 +++++++++---------
 drivers/media/platform/qcom/camss/camss.h     |  31 +-
 14 files changed, 322 insertions(+), 259 deletions(-)

-- 
2.41.0


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EE4D778EDE
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 14:15:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234910AbjHKMPd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 08:15:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjHKMPb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 08:15:31 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F78AE55
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 05:15:27 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-4fe44955decso2233008e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 05:15:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691756125; x=1692360925;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Zv4D1GbqB9ZbsMi2EXSpye3Fn8OSo1vne5gRlJ3Jxx4=;
        b=qWLm3kD1Ky4tjPSWEkoJO7hwurBoHTGscGrARyUUaQ4YUvBM2ho6eCIL+lbqyN+rq2
         Hv0r6HC94Rre02mAEjucnEW6DdycwboDO1xZfw48EU9fVJWUvCMlWRBhG4MKhuK0XEZV
         TcwDOQh1XK/H8cDqN+eky0Shbzim+JuJuyehKUsItINzab6U6QPd86769S7To8cLRktt
         KN6yapB9f7N+zA1y5+PGjD2TMy7LFl+VxjIEDL/wQQax5YEaHdkPb+dGVoUWgJF+3Vbm
         EXqHl+jaqsp2wNd2qPE4Wd8uxAN4YxLS001w1/fls+vV5VHtmDM8aHtFRsiBv7Xk5R0b
         7qcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691756125; x=1692360925;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Zv4D1GbqB9ZbsMi2EXSpye3Fn8OSo1vne5gRlJ3Jxx4=;
        b=WRIijvt0zoUJXSGIQmj7L0w+cKBqB7BJk5Y9u2dhq54C6KHxcWmTK6dP0OLyRUzYBX
         bKQpUyfb5oHSWaybd5TfBVyVEN2OX+lRqtSgjxhMVFy8Sl/hsxGj3ZxgoPrmmm8wDoEb
         foPaI+fADuMWqfmiJV1gOjPQ9oZzIRnB79WJ/27+HoOjLURlDnDgDMyFd7VkncC/WyoG
         OWGCQGF2q5d/K0Sm7cTN245GiY3GItyIT79p+3Y4N+JE3NQA/mwZz60HLAMxLbfGb6FO
         fR9GeoKD5L3+gxjBVQgatuApr0n5N3HpIOrq4reOY8W7ScdZJ1244Jj0Yq9x3/w6AKuX
         6ugw==
X-Gm-Message-State: AOJu0YxJtIdNh441+dRhvm77dNHA0H4ZPQYYzji7DAvdMaKQ37LWilTD
        wHrKL2YKb4zI5Bv/0YWhl5NEiw==
X-Google-Smtp-Source: AGHT+IFhSczT38AwuVtfp7EdIrNxloj+5FVCduWCuoWeXnKglCczq0TSsDoPHfrTa8kwVL92tbhgrw==
X-Received: by 2002:a05:6512:696:b0:4f8:6b98:f4dd with SMTP id t22-20020a056512069600b004f86b98f4ddmr1953606lfe.32.1691756125423;
        Fri, 11 Aug 2023 05:15:25 -0700 (PDT)
Received: from [192.168.1.101] (abyj188.neoplus.adsl.tpnet.pl. [83.9.29.188])
        by smtp.gmail.com with ESMTPSA id m12-20020a2e870c000000b002b9ec22d9fasm848487lji.29.2023.08.11.05.15.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Aug 2023 05:15:24 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: [PATCH 00/20] Retire DEFINE_QBCM/DEFINE_QNODE macros
Date:   Fri, 11 Aug 2023 14:15:11 +0200
Message-Id: <20230811-topic-icc_retire_macrosd-v1-0-c03aaeffc769@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAE8m1mQC/x2N0QqDMAxFf0XyvICtOsZ+ZQxp0zgDrpVEx0D89
 5U9ngvnngOMVdjg3hyg/BGTkiu4SwM0h/xilFQZfOu79uYcbmUVQiEalTdRHt+BtFhCn3rqp6E
 brpGg6jEYY9SQaa4HeV+WOq7Kk3z/vcfzPH9ABbtlfwAAAA==
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Georgi Djakov <djakov@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1691756123; l=2517;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=FiDUMnSBdWJzoYcyBNMnjUE7y8sQMKXFNcH57iH1p8I=;
 b=PPz6vRUqwAebWI9mn+JLBDnLT+zNIMgvSsSNcnC0IkYLusTJcvT5Hsxo0UdY0ob/TpW9jgGYv
 jcuqSbpyAIlBIZ2xUyp4tL5Cu+5th39Z8MwJJoSCG6jJ5eYlvzqw4Se
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is ripped out of the bigger patch series at [1], as this part
doesn't really have any dependencies and (hopefully) brings no
functional change.

Compile-tested for the most part, bloat-o-meter reports no size change

[1] https://lore.kernel.org/linux-arm-msm/20230708-topic-rpmh_icc_rsc-v1-0-b223bd2ac8dd@linaro.org/

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
Konrad Dybcio (20):
      interconnect: qcom: sc7180: Retire DEFINE_QNODE
      interconnect: qcom: sdm670: Retire DEFINE_QNODE
      interconnect: qcom: sdm845: Retire DEFINE_QNODE
      interconnect: qcom: sdx55: Retire DEFINE_QNODE
      interconnect: qcom: sdx65: Retire DEFINE_QNODE
      interconnect: qcom: sm6350: Retire DEFINE_QNODE
      interconnect: qcom: sm8150: Retire DEFINE_QNODE
      interconnect: qcom: sm8250: Retire DEFINE_QNODE
      interconnect: qcom: sm8350: Retire DEFINE_QNODE
      interconnect: qcom: icc-rpmh: Retire DEFINE_QNODE
      interconnect: qcom: sc7180: Retire DEFINE_QBCM
      interconnect: qcom: sdm670: Retire DEFINE_QBCM
      interconnect: qcom: sdm845: Retire DEFINE_QBCM
      interconnect: qcom: sdx55: Retire DEFINE_QBCM
      interconnect: qcom: sdx65: Retire DEFINE_QBCM
      interconnect: qcom: sm6350: Retire DEFINE_QBCM
      interconnect: qcom: sm8150: Retire DEFINE_QBCM
      interconnect: qcom: sm8250: Retire DEFINE_QBCM
      interconnect: qcom: sm8350: Retire DEFINE_QBCM
      interconnect: qcom: icc-rpmh: Retire DEFINE_QBCM

 drivers/interconnect/qcom/bcm-voter.h |    8 -
 drivers/interconnect/qcom/icc-rpmh.h  |   10 -
 drivers/interconnect/qcom/sc7180.c    | 1613 ++++++++++++++++++++++++++---
 drivers/interconnect/qcom/sdm670.c    | 1386 ++++++++++++++++++++++---
 drivers/interconnect/qcom/sdm845.c    | 1655 +++++++++++++++++++++++++++---
 drivers/interconnect/qcom/sdx55.c     |  843 ++++++++++++++--
 drivers/interconnect/qcom/sdx65.c     |  830 +++++++++++++--
 drivers/interconnect/qcom/sm6350.c    | 1526 +++++++++++++++++++++++++---
 drivers/interconnect/qcom/sm8150.c    | 1686 ++++++++++++++++++++++++++++---
 drivers/interconnect/qcom/sm8250.c    | 1745 ++++++++++++++++++++++++++++----
 drivers/interconnect/qcom/sm8350.c    | 1798 +++++++++++++++++++++++++++++----
 11 files changed, 11786 insertions(+), 1314 deletions(-)
---
base-commit: 39a1ff5094638b367bbd17e6a79591c67eed1a67
change-id: 20230811-topic-icc_retire_macrosd-2d4c4f5356bc

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@linaro.org>


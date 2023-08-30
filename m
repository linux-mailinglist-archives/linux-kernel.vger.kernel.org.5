Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51B0D78D227
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 04:41:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241734AbjH3Cka (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 22:40:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241730AbjH3CkV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 22:40:21 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1CD3D7
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 19:40:18 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-4ff9b389677so7907841e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 19:40:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693363217; x=1693968017; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TYl22KxB6jGXLk1gj90BJzrDvJpaGX8RVj0kioZtfHs=;
        b=rrlDL6o7Yi662KWF1olz2PRh4tHCGgSydDmlkwFpLvrNGpYuXAeGX8cncaluWxVW5U
         r8NsBuGmVhl/mXzTJ+mYC/1+l8UgxNvn8U9fz7orUNtXMU9bUmErGMHmm4krMPUlciq3
         ciQebuhbZwlSZI3u1Z+pgMdNt/k5UHI08nNyFzhHrZKa5aMPzylL4gqyqNNOdGXlCkWu
         GnTaS91NqG9hEZnCWhaj5JgVBgU1uD6iRR0zdbbbipvWvRVhDm1+afKHDE5lMyujX/++
         x43xihnwb92Lq9M2fe1p+5F5YoVjKBh5/4bg0aSLdq7F28Jm5RFXOpbpvK2p0Nfk4+EY
         y6yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693363217; x=1693968017;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TYl22KxB6jGXLk1gj90BJzrDvJpaGX8RVj0kioZtfHs=;
        b=enfoqHeefg4WIYGBxFuTDyOCWSCcYOZeMg+kup+RikZ0FC2Qz8KmiycQWSXfRJ5i10
         2ytaJKbg1xrvaXJq0fnk3ORaVfudAMoQj1DBbeLVpRh4Pk+iDQbb1/i3ki4lZjSLQ7OD
         MAito5q+RC65HjMAoMT+jvQH3XvF4lfCEXaZjhqQ0yD2H+fTJwthNtCbRkoM7N5s0Bze
         pFrB4JesET8ib/nrauCwaQ94nN0P4nY2IhoT99+v6IJ1Mv8MR9jp60jBmBrarg6IMIKo
         d9Pj+xksvcr94ilz6aPJ/BgYJj2xKkprR7qsuf/Wf4fNkQi5/TQNxowSpm2ema5m9fpb
         QxOA==
X-Gm-Message-State: AOJu0YySnbTmN2qLCGtCdm33p2Df9KFAn0ZN+uce7XrwT43gCtZE8mEl
        zMccLQmJbwGCwtXYM6i+od4qqXyVSNlWXiPWNQbHAA==
X-Google-Smtp-Source: AGHT+IFG7M9utsj2NkARucjHfHCoDgpRvP30BdMWVw/RB4/vr0a9l+pK0NT1SMrWbu8mxGVpXpaprg==
X-Received: by 2002:ac2:4184:0:b0:500:bf38:2d7c with SMTP id z4-20020ac24184000000b00500bf382d7cmr410768lfh.60.1693363216925;
        Tue, 29 Aug 2023 19:40:16 -0700 (PDT)
Received: from [192.168.1.101] (abyl195.neoplus.adsl.tpnet.pl. [83.9.31.195])
        by smtp.gmail.com with ESMTPSA id w7-20020ac254a7000000b004fb99da37e3sm2183878lfk.220.2023.08.29.19.40.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Aug 2023 19:40:16 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: [PATCH 0/4] EUSB2 repeater init sequence override
Date:   Wed, 30 Aug 2023 04:40:14 +0200
Message-Id: <20230830-topic-eusb2_override-v1-0-ab23825385a8@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAA6s7mQC/x2N0QrCMAwAf2Xk2UDXSVF/RUTSNnOB0Y5kG8LYv
 1t8vIPjDjBWYYNHd4DyLia1NOgvHaSJyodRcmPwzg/uNjhc6yIJebPo33VnVcmMRCHk8Z4oXHt
 oaSRjjEolTS0u2zw3uSiP8v2/nq/z/AExXG+BewAAAA==
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Abel Vesa <abel.vesa@linaro.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1693363215; l=926;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=CfJBIElEn8UI8i/wAQYUM9vwf/SxwqhC6FM1s62h6D4=;
 b=9pCj0G48P0rsXKvDwG5QSQkgHWdFXZzPaJUDmsNer/zmmDH30ywNwYxecNhmxl2lY2j7YL8J4
 GK7026qV+BxAjebkEXulloRHYo2XjVfml0HA6VQlYMHK11Ec59fsw5k
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The EUSB2 repeater goes through a tuning sequence as part of its
initialization. This series ensures the tuning is "clean" and can be
overriden for devices that need it.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
Konrad Dybcio (4):
      dt-bindings: phy: qcom,snps-eusb2-repeater: Add magic tuning overrides
      phy: qualcomm: phy-qcom-eusb2-repeater: Use regmap_fields
      phy: qualcomm: phy-qcom-eusb2-repeater: Zero out untouched tuning regs
      phy: qualcomm: phy-qcom-eusb2-repeater: Add tuning overrides

 .../bindings/phy/qcom,snps-eusb2-repeater.yaml     |  21 ++++
 drivers/phy/qualcomm/phy-qcom-eusb2-repeater.c     | 135 +++++++++++++++------
 2 files changed, 121 insertions(+), 35 deletions(-)
---
base-commit: ae782d4e2bf53b0b642ae860794f7a39470f995a
change-id: 20230830-topic-eusb2_override-aa66df9ca641

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@linaro.org>


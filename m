Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E1AD78C124
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 11:22:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234604AbjH2JVt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 05:21:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234631AbjH2JVZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 05:21:25 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CA50194
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 02:21:22 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-500bb392ab7so2701336e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 02:21:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693300880; x=1693905680;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EvxG2XS3ovsqpY9CWnyIipGSAuM9fJsVY92rZQvm+do=;
        b=a/jqBAOjHtcwXa7o+AVLr98eqw3mP3NbtQxBhUlrZe5fP+Qr7QNQ0Co9jNcKeAuQ/D
         BLV/AliSoCfSyZbi94hS22J8lkAVVMolKDgbgqfjM1zdK1XL1qR5M/CUtklhdKhEAcXy
         yqZTi/rfFi2+1G3TqIWeZvGlG4rflSWyy1Tuf9u/Ot2eVv7cT+RvTPGm44HHeWfzF/FJ
         Yy9J3TmIss2ZKF1iEeaYZOelSppTKd63EiQz6IdsCxv/lHvfd1Xqsi341cx7yZULBMdM
         HVPG7SEs2gFPU1/te1V+oau2OGcHHubQCIGEBjTVz5sEF7k5fCbl8qZN1gHqTUh02/Zp
         1G1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693300880; x=1693905680;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EvxG2XS3ovsqpY9CWnyIipGSAuM9fJsVY92rZQvm+do=;
        b=ZkcdjYrQnNtKtpXmzU7IgVCDG/JjYoQfnggqSAyFanP90cTyDsMpCS/NxfqOEo3lkz
         w6ZoQ8uZEI3RAK8uR4ft7/utNVI3ZgQc/d+QXz+F+UCAUP1kbdToE6JuKAOHhtG7Tbro
         fE+3z9Fd/7CJ3YUwbpZZtMLQ2RlOXJbg2Izbj1fqHMQli/0x0POPp/CmrTFZpC2jCV3w
         XKO22spF3nssxQsYie/gzmxn9WQKwDVQx8mM0mWrdfOa7sr1vwVrrzlYOEREZ/RcCXlk
         lhcmli9OEPsIglojPEGgVmXnzgT6f5ZGNDyd/QR8/qZ+kdBhgc0CTiAWgTCzyB3cLBlY
         n+Lw==
X-Gm-Message-State: AOJu0YyoS/JLB/bpW1cS8xsEIj6Q6cePEjoWuk95vdQd+AZSMjEZrt0/
        9FYSe6+oJ8z9lYYoH5x0WkQD0Q==
X-Google-Smtp-Source: AGHT+IHrKVUSasIwgjzB2r2GSLsMR4E8asW7JlJgTc0SoIjMGCFvkRPekXwYi7verQV0nuDTuzPJSQ==
X-Received: by 2002:a05:6512:5c4:b0:500:9f85:7a30 with SMTP id o4-20020a05651205c400b005009f857a30mr8799596lfo.26.1693300880240;
        Tue, 29 Aug 2023 02:21:20 -0700 (PDT)
Received: from umbar.unikie.fi ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id u20-20020ac24c34000000b004f858249932sm1884158lfq.90.2023.08.29.02.21.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Aug 2023 02:21:19 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/2] irqchip/qcom-pdc: support v3.2 HW
Date:   Tue, 29 Aug 2023 12:21:17 +0300
Message-Id: <20230829092119.1017194-1-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As Neil's patch has been dropped, because of the regression, squash the
fix for sm8150 into the original patch (so that we don't have broken
kernel commit).

Changes since v2:
- Fix PDC resource size if it is too short instead of setting version to
  dummy 0 value (Marc).
- Squashed the fix into the original patch.

Changes since v1:
- Changed IRQ_ENABLE handling based on Maulik's comments

Dmitry Baryshkov (1):
  arm64: dts: qcom: sm8150: extend the size of the PDC resource

Neil Armstrong (1):
  irqchip/qcom-pdc: Add support for v3.2 HW

 arch/arm64/boot/dts/qcom/sm8150.dtsi |  2 +-
 drivers/irqchip/qcom-pdc.c           | 73 ++++++++++++++++++++++------
 2 files changed, 60 insertions(+), 15 deletions(-)

-- 
2.39.2


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A526779B26
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 01:21:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235488AbjHKXUz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 19:20:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231126AbjHKXUx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 19:20:53 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93FF11AE
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 16:20:50 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2b9338e4695so38690261fa.2
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 16:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691796049; x=1692400849;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cV4tsrxG8dKLtwbvlLZrJHxxzCbK480ko/ypaGkgV4Q=;
        b=Ax3O2xJ5PLlPTu6RUI3touh7PyQ35gwyIOL3IUmkRUq5Eyt/nSyyM3FcLwY9bQ03kx
         kxAGQho4+1rSf4Drua8ucLK2+o/Cpa/dXj/mqtzp3YTp0z+TpIv8jfVy5NvvWHbFvgpF
         zD5yaGdJyGppndaUaTKeTTmFkA4JWNSIjNIVtoTPzcgwMya+fal9fHsgAUpQ0XWjLNxj
         4Nh04uA6XgxQ99IvV7YFsp0WQY6+6lM8d1hAtHpLgbq6Bbt1efOhPdHhdzlQaWB8R+Fi
         SGpA/5KaHOVMC7v0gGKScwyaIVpODxL7o7kn40voBy+hI7jbFgWkmWai4QlOMDh/TPcb
         dlHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691796049; x=1692400849;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cV4tsrxG8dKLtwbvlLZrJHxxzCbK480ko/ypaGkgV4Q=;
        b=FEEffjUBAxJ3ZHzWiYtQDMraShrTxrWlFYiBXTCtcXwtVe9yyYKvrXDDqEx7a8ppXO
         VTQ4jaL3axHiJjPrmaQVMI2VpFukPtLwVdrW64CJLia7XMosJ54MDfhJDkNEcKgCLPgP
         5MayqLNpR1wBnSt7rwKpo7au1kcNYe+S3mAzGUXnoPtExqroazFKIC/95FiMM7Soi1LB
         CRqnPA+aXGiUz+4lEqtEIJm2G0HacihHu0E3aFh84HI8/yDTWVwNZlQsh5Xesi7/gv9K
         YwAxDlyftoA42VU6FTLbFBRoSjEaZ1SYWx/9C0W//ZXEQ21oVL2Zt4TjuBH3nZO+y0Cf
         Em1A==
X-Gm-Message-State: AOJu0YxnPPO/Y0wgBSXM+kuGHJC4+IdyZ8R/63boDP2hXg72u1OlVLVu
        UZfYWj+PRjz4ALsFa2teyd+PHw==
X-Google-Smtp-Source: AGHT+IGP6H12hOqxQ1FPiFqeG+WhBodEDlQUpkBuCAnbXz8oCsiAfhsSV8isxE/5pyiBXOgt1lpcrQ==
X-Received: by 2002:a2e:9bd7:0:b0:2b9:ee3e:2407 with SMTP id w23-20020a2e9bd7000000b002b9ee3e2407mr2656190ljj.38.1691796048866;
        Fri, 11 Aug 2023 16:20:48 -0700 (PDT)
Received: from [192.168.1.101] (abyj188.neoplus.adsl.tpnet.pl. [83.9.29.188])
        by smtp.gmail.com with ESMTPSA id z26-20020a2e965a000000b002b9ea00a7bbsm1038210ljh.60.2023.08.11.16.20.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Aug 2023 16:20:48 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: [PATCH v2 00/11] Hook up ACV enable_mask for everybody
Date:   Sat, 12 Aug 2023 01:20:43 +0200
Message-Id: <20230811-topic-acv-v2-0-765ad70e539a@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEvC1mQC/22NTQ6CMBBGr2Jm7RhaEdGV9zAshjLAJKQlU2w0h
 LtbWbt8L9/PCpFVOML9sIJykijBZ7DHA7iR/MAoXWawhT0XtTG4hFkckkt4teSopq7qSwM531J
 kbJW8G3PDv6Ypy1m5l/d+8GwyjxKXoJ/9L5mf/TedDBZI9aWt+Fb2ZdU9JvGk4RR0gGbbti8s2
 qfvuAAAAA==
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Mike Tipton <quic_mdtipton@quicinc.com>,
        Georgi Djakov <djakov@kernel.org>,
        Melody Olvera <quic_molvera@quicinc.com>,
        Odelu Kukatla <okukatla@codeaurora.org>,
        Richard Acayan <mailingradian@gmail.com>,
        David Dai <daidavid1@codeaurora.org>,
        Rob Herring <robh@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Luca Weiss <luca.weiss@fairphone.com>,
        Sibi Sankar <sibis@codeaurora.org>,
        Jonathan Marek <jonathan@marek.ca>,
        Vinod Koul <vkoul@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1691796047; l=2199;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=ZhqVasBs5JcNfqRzP2c924DJFqpbO689MilHfaR3h0M=;
 b=g/bUkj2s/Ckk77tqNlAI929FpEGa/h6+MIsQB9RWnJi1JwMv0aFVuyypjeW4Z29ZCCPMstgnx
 ibwuYjFnYarD7fL1QGe9w2u+BfXVL12p8G4/GbZtniseDVauM9sZIqI
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

In the downstream kernel, ACV enable_mask has not been mentioned
explicitly, rather being handled by a sneaky if-condition [1], [2].

Add it to all RPMh platforms to actually enable that BCM.

Based atop [3].

[1] https://git.codelinaro.org/clo/la/kernel/msm-4.19/-/blob/LA.UM.10.2.1.c25/drivers/soc/qcom/msm_bus/msm_bus_arb_rpmh.c#L556-567
[2] https://git.codelinaro.org/clo/la/kernel/msm-4.19/-/blob/LA.UM.10.2.1.c25/drivers/soc/qcom/msm_bus/msm_bus_arb_rpmh.c#L475-495
[3] https://lore.kernel.org/linux-arm-msm/20230811-topic-icc_retire_macrosd-v1-0-c03aaeffc769@linaro.org/T/#t

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
Changes in v2:
- Remove the define and use raw BIT(3) as the APPS mask may change (Mike)
- Pick up tags (Bjorn)
- Link to v1: https://lore.kernel.org/r/20230811-topic-acv-v1-0-a85b6e94f46d@linaro.org

---
Konrad Dybcio (11):
      interconnect: qcom: qdu1000: Set ACV enable_mask
      interconnect: qcom: sc7180: Set ACV enable_mask
      interconnect: qcom: sc7280: Set ACV enable_mask
      interconnect: qcom: sc8180x: Set ACV enable_mask
      interconnect: qcom: sc8280xp: Set ACV enable_mask
      interconnect: qcom: sdm670: Set ACV enable_mask
      interconnect: qcom: sdm845: Set ACV enable_mask
      interconnect: qcom: sm6350: Set ACV enable_mask
      interconnect: qcom: sm8150: Set ACV enable_mask
      interconnect: qcom: sm8250: Set ACV enable_mask
      interconnect: qcom: sm8350: Set ACV enable_mask

 drivers/interconnect/qcom/qdu1000.c  | 1 +
 drivers/interconnect/qcom/sc7180.c   | 1 +
 drivers/interconnect/qcom/sc7280.c   | 1 +
 drivers/interconnect/qcom/sc8180x.c  | 1 +
 drivers/interconnect/qcom/sc8280xp.c | 1 +
 drivers/interconnect/qcom/sdm670.c   | 1 +
 drivers/interconnect/qcom/sdm845.c   | 1 +
 drivers/interconnect/qcom/sm6350.c   | 1 +
 drivers/interconnect/qcom/sm8150.c   | 1 +
 drivers/interconnect/qcom/sm8250.c   | 1 +
 drivers/interconnect/qcom/sm8350.c   | 1 +
 11 files changed, 11 insertions(+)
---
base-commit: ee4aa20e094643232438b896f49a405361406fbf
change-id: 20230811-topic-acv-72aca8ad6f41

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@linaro.org>


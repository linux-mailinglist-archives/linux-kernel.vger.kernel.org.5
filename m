Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1B5B78DF6D
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 22:14:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244566AbjH3TPJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 15:15:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244238AbjH3Msv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 08:48:51 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87056193
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 05:48:48 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2bcb89b4767so83695921fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 05:48:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693399727; x=1694004527; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bY6Ts8AN6wULo96E7oKoB6J6G/OTH3Af15URc3xEMoA=;
        b=n2lmKWfbLfegfvS/Q/G/o9QfsyqNfh1syxUX6fyIpwQmXtIJ7ZNjRslMcqtnJEegYh
         17Q0enxRpgTphYeHKw9nPhg0baqnDzXHgbnbwHjGU1x4qciUOm8vmaEIImzR9Mg5Dgk+
         z4XVmWs+hW1QoKyDzulsWBmELYcvKQIRWxIwNvtljrQo1r3bHPQ+JgBXSQ8toX35REnu
         AJtjFE5zxAUlQ4ds595W4mRJjJ1qR3xBSTTdX2bzL+vrSjNoETnsZqnDg9RGACbAbVZV
         zK0BCbX3VEmrg8svPDZkhnHfqwNPaOqC+5DeHpilZ6uOZQtAjnPUmZn6aGAxlDqTujdX
         8WfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693399727; x=1694004527;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bY6Ts8AN6wULo96E7oKoB6J6G/OTH3Af15URc3xEMoA=;
        b=EKg7rYX7z/L+LlhyvWkYRFlHS4K37KQZ8ZBEdcpfiE52p3EtmAkfj5pRviU4ZAQQB+
         YZxOkWUMRS/9N2/IMlHkyn5ddpha+EvMgl4c+Gc0UHDJIQLJ/fvzk7q0EIlTAfin5MNQ
         TdDYl9/nS6KHQQ9sFAlSkkbp7UMO22CbB9gF0AWCjRSaXjI4y1EvdkfufQUDUX4beQfG
         vrh4qb8yXkxKgfZHeez4rERTjSFv8IfEoo9hDuoF0c/g8vXAxUPUE6DqcDZH0hlytMFN
         maCG7D5v5MeuBCbzWReKHHNXh9m4pe5sU3scVUzAR1PgniLpHE8LZS2tUIDv7u6W+2oR
         M+pQ==
X-Gm-Message-State: AOJu0Yx2BcRQVLdjeBmUHWP3xQadzvyewhDwD7S90RLqLJQfhL+AIVWm
        IO77jkOJe+6mvsB1K+apulK+DhnnIsFIcnskzpGTPQ==
X-Google-Smtp-Source: AGHT+IG+D0lOo9lrJZs4kvBiHpFPiLDgGrGIGGnT3fYaPcIYMUuKqyNtN8gSy6DepAKYbhlKShZt0w==
X-Received: by 2002:a2e:968c:0:b0:2b6:eb68:fe76 with SMTP id q12-20020a2e968c000000b002b6eb68fe76mr1943138lji.25.1693399726751;
        Wed, 30 Aug 2023 05:48:46 -0700 (PDT)
Received: from [192.168.1.101] (abyl195.neoplus.adsl.tpnet.pl. [83.9.31.195])
        by smtp.gmail.com with ESMTPSA id y23-20020a2e7d17000000b002b94b355527sm2602662ljc.32.2023.08.30.05.48.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Aug 2023 05:48:46 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: [PATCH 0/7] 8550 dma coherent and more
Date:   Wed, 30 Aug 2023 14:48:39 +0200
Message-Id: <20230830-topic-8550_dmac2-v1-0-49bb25239fb1@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKc672QC/x2NWwqDMBAAryL73YU0QRu9SpGSx1oXNEqiRRDv7
 tLPGRjmhEKZqUBXnZDpx4WXJPB8VBBGl76EHIVBK22UNQq3ZeWAtq7VJ84uaHy1tomNNbH1A0j
 mXSH02aUwSpj2aRK5Zhr4+H/e/XXdobsSEXcAAAA=
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Abel Vesa <abel.vesa@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Sai Prakash Ranjan <quic_saipraka@quicinc.com>,
        Vinod Koul <vkoul@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1693399725; l=1120;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=Q2YXK69Spz2pE0ISEYTPLsY9leUsqULG9hqpcmUi0EI=;
 b=irxyzxwv56ierVsx6/JI+hChLN2S3zTCLQiO+0kIHxLCtxbluCGgOzIBHGnQshC4bjv2vvMWG
 pIDYsYCpaTzBNE/aq7n33CfICvNyoFIMVO2T0AfwYLFzfMAM9DKFj05
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

Qualcomm made some under-the-hood changes and made more peripherals
capable of coherent transfers with SM8550.

This series marks them as such and brings fixups to usb and psci-cpuidle.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
Konrad Dybcio (7):
      dt-bindings: dmaengine: qcom: gpi: Allow dma-coherent
      dt-bindings: qcom: geni-se: Allow dma-coherent
      arm64: dts: qcom: sm8550: Fix up CPU idle states
      arm64: dts: qcom: sm8550: Mark QUPs and GPI dma-coherent
      arm64: dts: qcom: sm8550: Mark APPS SMMU as dma-coherent
      arm64: dts: qcom: sm8550: Add missing DWC3 quirks
      arm64: dts: qcom: sm8550: Mark DWC3 as dma-coherent

 .../devicetree/bindings/dma/qcom,gpi.yaml          |  2 +
 .../devicetree/bindings/soc/qcom/qcom,geni-se.yaml |  2 +
 arch/arm64/boot/dts/qcom/sm8550.dtsi               | 52 ++++++++++++++++------
 3 files changed, 42 insertions(+), 14 deletions(-)
---
base-commit: 56585460cc2ec44fc5d66924f0a116f57080f0dc
change-id: 20230830-topic-8550_dmac2-7986d683d9bf

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@linaro.org>


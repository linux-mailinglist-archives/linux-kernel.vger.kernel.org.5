Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A433786DFB
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 13:34:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241024AbjHXLd7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 07:33:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241017AbjHXLdf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 07:33:35 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87A191993
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 04:33:32 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-319559fd67dso5969867f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 04:33:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692876811; x=1693481611;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yC8fuqTzuiabrnYWwAhiJIKgyhh3Mk1H5rlP+xTvTnI=;
        b=igQv/zrnXwHM5gwk8wWQESGx3C+u/yZGYbbhqE/71fO2mGsqYeLjKR/39WqnIyMoKK
         fo2iaeQdN55xgyTC7dkEsjcTPcH/WoE+i6YIDK0+BA8v84tmiBqCzZxS9sH6ZAACGbmI
         YsOtv17vEGgCyPcCFWMUdXSDP9HHAEpUUKvt0kBsJv2PMgGmjyLjmyISWu76EddxCTDn
         EbaqmGaR44oHPFgDcKqrljPyp6kkRaN/CfP5fgGJ9d7CVWHLHbTi3rn2O49ciwhhiUnH
         dxWJ6usUTvXjp2PglDox+rlrOUKT/luxPlYffiNznVPUV5VRqZlA2H4RHtPe+gSY1fra
         GVwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692876811; x=1693481611;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yC8fuqTzuiabrnYWwAhiJIKgyhh3Mk1H5rlP+xTvTnI=;
        b=cQkOXPWV3CWC2W9W07T2qGgfQnVUeO7gbx7NdJ2Gs1Go0lpVLhoq/MpriQslepX6Az
         OPN+btquhTLG0VL87rgs27BzmN4Jw/lTBQlUgv+QKel71zPOf/MeTScmBf4RbCuriDri
         rhWfnIFC9+2dAVdzy2MB2Rdj89zNfmvRbq9c7Za4z8hZaRHXLzb5DGTjeTqyw6id2CMq
         TrIfOyPEk3/LaXb6ofGRVBQAPTgmjhMu+O9CwwLmaJCaSOVyz/8WyCcDClC3ckJKsn4T
         BwJPv4iYqLrM80+V8t9WD0iB5ZQ2Ze+6nw7MOCohfcC3r+P02qptOaSgEGQflJf8T59r
         YlMg==
X-Gm-Message-State: AOJu0YwQr+xy7XwKmnKRsF8DE/JTijswzocQx2wrVpCXOQQh2aTSXqoH
        Q96YzfSJzF1pTZD9mS0fIX5jhA==
X-Google-Smtp-Source: AGHT+IEuKIOqpYdFLoEc3uJDous6FKrrl9wXIPxcO+vuIcm6WuADk3WDktemifszunQw4zVYDY2uEA==
X-Received: by 2002:a05:6000:1807:b0:316:fc86:28ae with SMTP id m7-20020a056000180700b00316fc8628aemr10125694wrh.15.1692876810636;
        Thu, 24 Aug 2023 04:33:30 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id e11-20020a5d65cb000000b003179d7ed4f3sm22063938wrw.12.2023.08.24.04.33.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Aug 2023 04:33:30 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH v2 0/7] arm64: qcom: sm8550: enable RNG
Date:   Thu, 24 Aug 2023 13:33:19 +0200
Message-Id: <20230824-topic-sm8550-rng-v2-0-dfcafbb16a3e@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAP8/52QC/32NQQ6CQAxFr0K6tqZTHJ248h6GBYEKTXSGdAjRE
 O7uyAFcvpf891fIYioZrtUKJotmTbEAHyroxjYOgtoXBiauKTDjnCbtML+C94QWB+xC7U58CbU
 wQZlNJg9978l7U3jUPCf77A+L+9k/scUhYRBH5L07+97dnhpbS8dkAzTbtn0Bi1oLc7EAAAA=
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Vinod Koul <vkoul@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-crypto@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>,
        =?utf-8?q?=EF=BF=BCOm_Prakash_Singh?= <quic_omprsing@quicinc.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1392;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=ouJjqlHbJ9Q1ClPHm6B8a1xk6Kp+RJrUCNvbJ68Jc/8=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBk50AGVZrb06NDM7Lo+iLktpmxPB8RGE+vbQWDsN4b
 l9WNHzuJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZOdABgAKCRB33NvayMhJ0SShD/
 495Rv4XzpodSbsg30ceHZ7dtVHdXZn/Vn4A4F03LybVg2rkjntADljZ9CGLUyPAY+mwKABxAwORAVZ
 D1TY0lnzWrb0zO58uMvwzM3hOE+oCoMN2AaPg7KZSFMtoEnYxlRg3jHf2kpB3zQOFa7GVuAGlbuWpM
 ubgL4pASC9qdibXzcK7AmGe/O4zQYUfHOJ2PnxTfITRsH56cHeyld1pzvZ3kpn2dkw90Iy7FEuU669
 b3ukeyO/8xsTU1Ss8/TIE2yrQ+WeDJ4QEk0AaW1XOjoyjoxvsDfjKAq9G5ZNDnDFJ4RYzrfsudtFSv
 Px3YWv5DtOLIM2z0flvEVmo6mJovxMtZPb6gxP0Oe6monA+3hcDd6PCLkq8BHtDxDgFq7S/8VhGeoL
 dbO6COS4hJ+XsRZ/f8Xvhj62FkDASbn3X3jYAO31hyJ6zyUa9A4FHgaYpVnz9gUtNnZySCuWrX8i7j
 PKHckt3WGsnHA8WA0fSU2eVWCA5K3Tq1XQWhJ20cDozyJK6jdYfK8/lzE9yrHhB89v06S3+PLVvmdy
 PpZ8tPaKcz0JBw6uXKes5HcybWlmnD1WA9/MH5K1MnWpYO7eEB8DOcIZ0dlij7xMOmpYoySHQ8yoeT
 euli+hqPMwnRzhITixnU/qxMXdANI75Vk8u4I8CzUfa4FKBYCW6TTlN60ETw==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable RNG on SM8550 by reverting the PRNG bindings & DT
for SM8450 and correctly document it as a True Random Number Generator.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
Changes in v2:
- Revert SM8450 DT & bindings
- Add new qcom,trng compatible and use it for SM8450 & SM8550
- Explicitly didn't collect the Reviewed-by tags due to the compatible change
- Link to v1: https://lore.kernel.org/r/20230822-topic-sm8550-rng-v1-0-8e10055165d1@linaro.org

---
Neil Armstrong (7):
      Revert "dt-bindings: crypto: qcom,prng: Add SM8450"
      Revert "arm64: dts: qcom: sm8450: Add PRNG"
      dt-bindings: crypto: qcom,prng: document that RNG on SM8450 is a TRNG
      crypto: qcom-rng - Add support for trng
      dt-bindings: crypto: qcom,prng: document SM8550
      arm64: dts: qcom: sm8550: add TRNG node
      arm64: dts: qcom: sm8450: add TRNG node

 Documentation/devicetree/bindings/crypto/qcom,prng.yaml | 8 +++++---
 arch/arm64/boot/dts/qcom/sm8450.dtsi                    | 2 +-
 arch/arm64/boot/dts/qcom/sm8550.dtsi                    | 5 +++++
 drivers/crypto/qcom-rng.c                               | 1 +
 4 files changed, 12 insertions(+), 4 deletions(-)
---
base-commit: 28c736b0e92e11bfe2b9997688213dc43cb22182
change-id: 20230822-topic-sm8550-rng-c83142783e20

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71DAC7DB78B
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 11:13:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232707AbjJ3KN5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 06:13:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232533AbjJ3KNs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 06:13:48 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BAF4D5C
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 03:03:37 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2c503dbe50dso61573951fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 03:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698660216; x=1699265016; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=J4WXg5FFhPdJh2p+z19uU60HLvzYJe05E4XQH5aoWQQ=;
        b=hgQdUeMfqF4K71J0RGYjSvsHGHVp8HmEZqc1pKr5SbQSioWUe7W0z746cLpKDZV4AT
         xK5jBKpxpZDg/rR+LX3PFk2HIgSz1c80bY6Zzuuw2qeozUAfTSQ/nXdXoyVm1ng3ogzt
         L9z+XQ4aUPQ5oc3xx2hdwCUzGiQtXLP+5eDX52Jdd+uRu+8u95z1y44FBUKQQtiBmzC7
         I4v3Q64Ho+91T0hACwszl5gBR0KevYPIWf3tkGF0/oQymiPkccGfVYqqUvW4cV4mXHv+
         ZyHTPxEijj7bvEuDrRiC0+iarJVdfHlSHoHa6eMCBjGqT1V9f1+ZG/7wrtaCAopfRRZw
         gV5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698660216; x=1699265016;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J4WXg5FFhPdJh2p+z19uU60HLvzYJe05E4XQH5aoWQQ=;
        b=e8YSUj2ojvRyxPcA90lqSXi4XOatz49sNlhqj3KxDmdUYO/3h49aD+tOKrGyEfbhcR
         7R3JMVUMtwe8l1etMit8r37KGqom+hjf0P7xugRoVT/aJpeU/DepoFs9I5kfbXFe7waZ
         AA3YgnkDVOw9ZO1uNZLWY/HGC6jCozVbAju2CTUZyvwojL5botOXaerpL9y3+7LXRHnX
         dU/4QQcldc1FYhywKdGpmbMemzj4uLhvsH4MB4LdepHvLWopSTcqVDEnqycLBjn5r9pQ
         mdZNu5P1WqPMjh5y2Ymgia2PdHtUUgG8x1CP/OfpwrL7vSX0HI4ug5nzGMz9Td32dQDr
         DoLQ==
X-Gm-Message-State: AOJu0Yz4jl/dkmx31V5ptl3dmAvnm3f3sgcEJKXmjB+u4fcprQEa57D4
        WxxtgioqflHfZxYvkvvp0OiF1Q==
X-Google-Smtp-Source: AGHT+IEyWsndrlRmsCWgAt18UNf77cnwF5bu84hyhhXNy+Rm1RHzDJO5+4hv9uvXGkclCypCJO6hIQ==
X-Received: by 2002:a2e:998a:0:b0:2c5:1602:53f6 with SMTP id w10-20020a2e998a000000b002c5160253f6mr7382568lji.34.1698660215681;
        Mon, 30 Oct 2023 03:03:35 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id p8-20020a05600c358800b0040472ad9a3dsm8776700wmq.14.2023.10.30.03.03.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Oct 2023 03:03:35 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH v2 0/3] remoteproc: qcom: Introduce DSP support for SM8650
Date:   Mon, 30 Oct 2023 11:03:12 +0100
Message-Id: <20231030-topic-sm8650-upstream-remoteproc-v2-0-609ee572e0a2@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGB/P2UC/4WNQQ6CMBAAv0J6dk1bpTae+IfhUMsCmwhttpVoC
 H+3Eu8eZw4zq0jIhElcq1UwLpQozAX0oRJ+dPOAQF1hoaU+KakM5BDJQ5qsqSU8Y8qMbgLGKWS
 MHDwY4+wF8W56RFEykbGn1764tYVHSjnwez8u6mt/cV3/jy8KJDjbaYlnj8r65kGz43AMPIh22
 7YPtn+2UNEAAAA=
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1933;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=NHO6e72SKI0Q7Hd1WQctl1TnAFjlj2Q8A1xAE8AkJGc=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBlP391plT259Vk9SzLRk+8qS9Bkzkmw189igaQrDws
 ux783UuJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZT9/dQAKCRB33NvayMhJ0XjMD/
 4rRaWuAdVYnilewLCEHXsdEJN7iKSPIa6dOiM9kUCZMSQKOsKDF6eqzyM07tDr9MsOAkEpSZ4xJDtZ
 GVi3ydAK0GKv4eFZ72qqvmTCcwWHtyrycvnzN3/DbtLozEpHwYYNrfbW2HR5OinO21WSbUoat2N45P
 d5cwd/Xm27F+mn7TAXzsj3L5F9MJPuh9z/kz0bRJzVGFavJct8zu8+GiHvjNMkpMj/XqW+yl7lu/Tl
 tYTEMNsHSVksGX9MkzlWbGCvj2xNXKevJzSVtgZ44ROaHF3OuES0h/tOF9zlMx3tAvv7FPcGMh8lWn
 aHSoB8R+gV+lzABBBvTyf3Ayoa/KEOrnXlM4AQ2xZYGHLhuTQ4diqvT23Y5Hi1oUoD4gfmLmlMF0YW
 +oQAK+z9rJt1e5JOAIxh3fDVA0v77b4HOjx0d+nyZrBDZVL85eHseAT+6dW9UQwrI+EQY7IQm7+4oo
 LHMLY4LSaYgdhtj/KsYtJriZ4knzEi3Ww/FuppJ4dcjr5+LKT4bCylm4+ybgpOIWqptd5k70cc0E3r
 0W6CDAUNlKuNfCGUTyT06vQ251cNlE9smmjtj59RCHjvnZj9o3KzKBNrW0s8yTFUoWLLVX0jYOXqUa
 KjA0d1ozNQxga5VLfKxAJExD9zLY+99a8pJjsDYy+lEZsQTh2gyamzB1ReIA==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the bindings and driver changes for DSP support on the
SM8650 platform in order to enable the aDSP, cDSP and MPSS
subsystems to boot.

Compared to SM8550, where SM8650 uses the same dual firmware files,
(dtb file and main firmware) the memory zones requirement has changed:
- cDSP: now requires 2 memory zones to be configured as shared
  between the cDSP and the HLOS subsystem
- MPSS: In addition to the memory zone required for the SM8550
  MPSS, another one is required to be configured for MPSS
  usage only.

In order to handle this and avoid code duplication, the region_assign_*
code patch has been made more generic and is able handle multiple
DSP-only memory zones (for MPSS) or DSP-HLOS shared memory zones (cDSP)
in the same region_assign functions.

Dependencies: None

For convenience, a regularly refreshed linux-next based git tree containing
all the SM8650 related work is available at:
https://git.codelinaro.org/neil.armstrong/linux/-/tree/topic/sm8650/upstream/integ

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
Changes in v2:
- Fixed sm8650 entries in allOf:if:then to match Krzysztof's comments
- Collected reviewed-by on patch 3
- Link to v1: https://lore.kernel.org/r/20231025-topic-sm8650-upstream-remoteproc-v1-0-a8d20e4ce18c@linaro.org

---
Neil Armstrong (3):
      dt-bindings: remoteproc: qcom,sm8550-pas: document the SM8650 PAS
      remoteproc: qcom: pas: make region assign more generic
      remoteproc: qcom: pas: Add SM8650 remoteproc support

 .../bindings/remoteproc/qcom,sm8550-pas.yaml       |  44 +++++-
 drivers/remoteproc/qcom_q6v5_pas.c                 | 152 ++++++++++++++++-----
 2 files changed, 159 insertions(+), 37 deletions(-)
---
base-commit: fe1998aa935b44ef873193c0772c43bce74f17dc
change-id: 20231016-topic-sm8650-upstream-remoteproc-66a87eeb6fee

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>


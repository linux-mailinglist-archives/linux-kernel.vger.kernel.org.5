Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1268E80E687
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 09:45:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231347AbjLLIpW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 03:45:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229794AbjLLIpU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 03:45:20 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64F8CD5
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 00:45:25 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-550dd0e3304so4018497a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 00:45:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702370724; x=1702975524; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ppbHQCYSLppdUFWWFW0lWAd6TucauVUU4s32x2RiPZ0=;
        b=oMPOOqW7ueV8Vvvu6PcGcwo/lVfPQB8GB7q4rjFuF8Y0DZaHb5o87z0HVoGRuWs4Yt
         iIHxTmxIoQKFhtRZ/dqxdFZE9BspCUUoCxyDfuchKUzXScDdJDrT68VLciB5aUflSiPi
         yWZ9QZqYDS5XUOSFJQ0Ov9/GRIRBvV8jjmudSvwDU9zP/iYxeeduiNtbIYajtYHw7AKk
         uzNiUTI5pGDcgSPEWV+8eRa2UoUYw6ckPa9Eq9bw/rHqpkyfHjvUaj0FJ8Aqx6QUaSHW
         Fs8jaHceq+zQfAuZVtzsEjwW9ZhXzl53RrAaMfj55u4X++7litI6hGc+QmnAxhXpgusi
         tl7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702370724; x=1702975524;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ppbHQCYSLppdUFWWFW0lWAd6TucauVUU4s32x2RiPZ0=;
        b=tPl6ODyWyJ5ZMwkTk45YCOlUOIUzYNZqRv9b/TC6j92ESNkkgnPIMrWJBnZ5yTfzM8
         KspdTQEM3gZTKR0rhe/KVpjIiL7yRQHlMw7enxYsqRV9ty6c2Av0VFdM0HGW96hHPh2R
         q+EVYc2/BxDQDQb88XI62EE1xFfzenqzBA0OgjyHPwv/4bE8BqMbLEdVs/0Avxsqaz87
         vAVW/+MRDGg+bO47a1eZIv/+KVthY0+2ltEBqJIMiP7PTehDFnpYVlb5B4AuvNLh4FRT
         h8crafXVsKk+YyMxSOYsQJmfp2Dc9fWYGyvOOa4udk2SiURuqcThKm/dPSeSd9erMEN3
         CZkA==
X-Gm-Message-State: AOJu0YwsXPEcaftDz5s4EXLr8i0xT3Er+OFizS86Vlgh4hXPpwbzMPiP
        b09YcJNQrrddtWvlonriSiq47A==
X-Google-Smtp-Source: AGHT+IG461CE58DfQwEvLrH77MxkX0z0TE6W4JC9lMkEpoJudRh2B5fAl6/htiSe24WyJoA/xUQYXA==
X-Received: by 2002:a50:9b1b:0:b0:551:5646:ade8 with SMTP id o27-20020a509b1b000000b005515646ade8mr663044edi.34.1702370723657;
        Tue, 12 Dec 2023 00:45:23 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id c27-20020a50d65b000000b0054c9bbd07e7sm4650471edj.54.2023.12.12.00.45.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 00:45:23 -0800 (PST)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH v5 0/3] remoteproc: qcom: Introduce DSP support for SM8650
Date:   Tue, 12 Dec 2023 09:45:16 +0100
Message-Id: <20231212-topic-sm8650-upstream-remoteproc-v5-0-e749a1a48268@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJwdeGUC/43QTWrDMBAF4KsErasy+rWcVe8RupDlcSKoLTNyR
 Urw3SuHQlqyqJdvFt/jzY1lpIiZHQ83RlhijmmqwbwcWLj46Yw89jUzCVIJEJYvaY6B59FZA/x
 zzguhHznhmBacKQVurXcNYmcHRFaZmXCI13vF6b3mS8xLoq97YxHb9QeX5n+8CA7cu14C6oDCh
 bePOHlKr4nObNOL/CUq2CHKKlpoEU0jEbx8EtVDFLDjAUVVse96HXznsdPNk6gfogS3Q9Tb6tY
 GhWaAVqg/4rqu3yaeVXfHAQAA
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
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Mukesh Ojha <quic_mojha@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=2551;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=Iwq0UgF1Yfv2WGtfwDWdmFW885Pn0Zt75TkNM8ie22Y=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBleB2gJrAs43nJqREqAHg1quOoAM11tEKc/BpKQWLA
 UuKNAt2JAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZXgdoAAKCRB33NvayMhJ0baOEA
 C27sssh9IXoAtR1jXjfupwN1RCi9y8Y4ylNBJ7kFAm2h+yZDNEnEQfQ8Qa3dSx8A6zcyY540U4nJXN
 e32uSvmE8H1tF5v2UddXzu4ShNIQNpdHdR3FQaM7+N1zOeB7Qe4pAIl497SFfYMuYjA9EnMaOufMqe
 8dGiaGXAdQ2QZR2HYU9B9AWBU8ul2NoDGP6yBEHR8ISNFwaYk9Z8DnE3X5tV/u0E81LlWHzu+Y1iMy
 nmcy9MD3BwokhIRuBCZtoAovGRC1fUFCW6hvWToXA8W7PKvXj0rGAWsqr920DpPzLogf60FqiBswub
 rMM5Lk784pVXDVC1Vr8z8DAAnFH7jogYxSCB5owQfJIgXCstLcEJLYrO4WpWaIoIyyDHmIf0P8Qgzg
 xJouPL7OGltD/6SQcQBfKCO+Ab+1flPAQQ7zqfCGNKfki2JZKJ+toyRFaN7ZL952HEgHzCv7l+2Klb
 zjQ+MVU9Y6gwVqIYGQRBZcfcUs3AsLn3mHuaZbpFmr1oeNSzJrdXvZgtIhQrPWKMZoHwDX2u6aN660
 2CTT0wQlkTWQRCcySiAbM4Rc5tC4vUtBjePNsNnyUWpKihtX/Qk7n+R9iUuMVgT5ewnN9Sabj6mquc
 aiu0JxZER79G0Df/6UWF5NDo27yaUK2pt9IUHLMdPytizNWPsYH5y/zdNzDQ==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
Changes in v5:
- Rename _perms to _owners per Konrad suggestion
- Link to v4: https://lore.kernel.org/r/20231208-topic-sm8650-upstream-remoteproc-v4-0-a96c3e5f0913@linaro.org

Changes in v4:
- Collected review from Mukesh Ojha
- Fixed adsp_unassign_memory_region() as suggested by Mukesh Ojha
- Link to v3: https://lore.kernel.org/r/20231106-topic-sm8650-upstream-remoteproc-v3-0-dbd4cabaeb47@linaro.org

Changes in v3:
- Collected bindings review tags
- Small fixes suggested by Mukesh Ojha
- Link to v2: https://lore.kernel.org/r/20231030-topic-sm8650-upstream-remoteproc-v2-0-609ee572e0a2@linaro.org

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
 drivers/remoteproc/qcom_q6v5_pas.c                 | 150 ++++++++++++++++-----
 2 files changed, 159 insertions(+), 35 deletions(-)
---
base-commit: bbd220ce4e29ed55ab079007cff0b550895258eb
change-id: 20231016-topic-sm8650-upstream-remoteproc-66a87eeb6fee

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>


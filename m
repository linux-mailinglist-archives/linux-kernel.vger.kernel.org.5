Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC5387F4556
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 13:05:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344005AbjKVMFs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 07:05:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343732AbjKVMFh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 07:05:37 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C43810C1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 04:05:32 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-9ff26d7c0a6so429930566b.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 04:05:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700654730; x=1701259530; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=F3iRTyYm++LfKkBAqCvb+FLSd+8UJIkyMkD3WQQLyuE=;
        b=ocKnreAjVz1PLzY/hHEvNAMh+CyZ8lJI9EfE53jW6pbP+tGVl4cSoa5fBp26Xk1kuk
         ig0QiYEG/Z/THQzvfggJT/o2I5X8pUBxeh6XxIqOjGgQK7iuOz9nsNWKAgSrUm+PRfco
         knUEDDtAdPOPhhWoISFxP8zwmbIbH02SkMjMXC155Z4OcxO1bMnqOHD2VSRRfJd9wXaB
         4mfBvaCrhesPy+hRDXGjYbuBwXYGdi5EAaa8JxbRu3IauNNIxS0nrjtsrz8mLYcso7kz
         PXM10PfYGf9vS7dmx+cjgMtXqxOfBbtvrRd5Cp9SLKZ4LNFXLvvq5xDP5tupheIwn6Fs
         k/Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700654730; x=1701259530;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F3iRTyYm++LfKkBAqCvb+FLSd+8UJIkyMkD3WQQLyuE=;
        b=ViNh3jYz1FWIffuoII0Ip38Y/QGS2VWtfV6y6ys9HVVhEFHPQezMZv5po4Qvd2Zn/6
         8cEBXxTyRPL+yKhLnBjiWtNe1X6v6P/rShtUWgVzoKtqMblBEKaxwk3cV5296Cthaja2
         Z+3vpi/0kDQlyRQKvGjFMWCW+oy+T3hGNvE7pWR0yT8Vverm8jhs5UD53en2+KdPWrie
         0bc/atcsN+UDA6dT/K1ecfNCEJ5qlg4K1uRPzEaKEukywFKgxJAa3nzsuftdTFffgHbB
         UnCZSsApv8XeNodkQqLrV4IJyamm0CLjkYOpxFtWDc8tGOEc9a4TiGj0IOrX2C4A4VOX
         P8/w==
X-Gm-Message-State: AOJu0YzYXjk5ciHpUz3QR+Mpmz1Bx56N2fMUPMrk1Nbub4JDaqhtY1jT
        6agAIoVwUCaS1OhZ2Am5n+XqEQ==
X-Google-Smtp-Source: AGHT+IGDuvN3XpxCMad1R4oTrZlqTFp4K28uSJGx5TCUw6otAoFmnB30kMshZ4Dfx1vmSXvLFKSpJQ==
X-Received: by 2002:a17:907:2913:b0:9ff:cdf3:553 with SMTP id eq19-20020a170907291300b009ffcdf30553mr1258514ejc.61.1700654730525;
        Wed, 22 Nov 2023 04:05:30 -0800 (PST)
Received: from [127.0.1.1] ([86.123.99.122])
        by smtp.gmail.com with ESMTPSA id kq14-20020a170906abce00b009fcb10eecb2sm4383416ejb.84.2023.11.22.04.05.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 04:05:30 -0800 (PST)
From:   Abel Vesa <abel.vesa@linaro.org>
Subject: [PATCH 0/2] phy: qcom: qmp-usb: Add support for X1E80100 USB3 PHY
Date:   Wed, 22 Nov 2023 14:05:20 +0200
Message-Id: <20231122-phy-qualcomm-usb3-uniphy-x1e80100-v1-0-3f5bd223d5b4@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIDuXWUC/x2NQQ7CIBAAv9Ls2U1YiJH6FeMBcCubUFohmJqmf
 xc9zhxmdqhchCtchx0Kv6XKkjvQaYAQXX4yyqMzaKUNkda4xg++mkthmWds1RtsWX5yI7aKlML
 xYoK1+jwST9A73lVGX1wOsZdyS6nLtfAk2398ux/HF/QYbuWIAAAA
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Abel Vesa <abel.vesa@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=834; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=eXw1PqnDXRaa9q9LSnWqKj7Y4vQ414LWHrJ5zXCLXcY=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBlXe6CIfxfp+7KFdffH/AKuF0jZrge2rhNCZck9
 Xitrixfu2CJAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCZV3uggAKCRAbX0TJAJUV
 VscqEADCMX8wxjIQDp7Ts+yxwcdjGaIvk4Dk0x3mRQOs2yib9BEsK+wOoAVG64XaTFhmrZcOxo7
 gIXHi7EniFlc8vmYWA0uibbT6Z0OFIboDtINccW7bgJy71VaizIt33NIZChKg2KfE8ppUerdRQv
 /IRGtaCFuuPoRpDizOLXNsWCutzpjbTecAPcl8TKZY7fILlj3rUg9i+57Pl0o2yB67shUrHDKJi
 gYqeOgjFrcee6zZTVJJRoQ4dI21kshKnDEtTSG5TMDSVHcaBin2C6bPTFoqIvDSCLil9phFetUk
 BUCqXbtafZKL/pXvbAgopZtXMUUEsvC+YfOI2n/VgKx0MO08D0Uw/B0FNK4kyTI8wkQymkDfSFu
 uB/iUshNkj5xTjde2WUr+NV0cVcBP7EULmeVxqYKU3AiDzTr2t1l0qCWjrAt+QrxxcgZ68njFQ3
 g78MwreFBaOCB5F2rZrFQMsVubB/4X4F6B9oEAT8KxRf1ycF3Ht6pDR04wNFsHuOC76cGWK8rq2
 qVoFS97bb5H8es0G3rARQWNkBOOf4wBmIaSJOLLYOCkf/MQXyUKS19Ow7xOW+uZZl28Cb78sz7M
 5mnwIRJc75dE7qQs/ycLzjP0fsbUQjK/JTMGVS1a66A7ko6JTxaYOTsn5hgEA/uyPZWUm4+VGcJ
 PMdiO0Yr5cAvwtg==
X-Developer-Key: i=abel.vesa@linaro.org; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds support for USB3 PHYs instances found on X1E80100.
It depends on the v7 register offsets added by the following patchset:

https://lore.kernel.org/all/20231122-phy-qualcomm-v6-v6-20-v7-new-offsets-v1-0-d9340d362664@linaro.org/

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
Abel Vesa (2):
      dt-bindings: phy: qcom,sc8280xp-qmp-usb3-uni: Add X1E80100 USB PHY binding
      phy: qcom-qmp-usb: Add Qualcomm X1E80100 USB3 PHY support

 .../phy/qcom,sc8280xp-qmp-usb3-uni-phy.yaml        |   1 +
 drivers/phy/qualcomm/phy-qcom-qmp-usb.c            | 152 +++++++++++++++++++++
 2 files changed, 153 insertions(+)
---
base-commit: 07b677953b9dca02928be323e2db853511305fa9
change-id: 20231122-phy-qualcomm-usb3-uniphy-x1e80100-973c882591ef

Best regards,
-- 
Abel Vesa <abel.vesa@linaro.org>


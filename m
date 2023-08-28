Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0B1478A709
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 10:06:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229571AbjH1IF4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 04:05:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbjH1IFX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 04:05:23 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F239126
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 01:05:16 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-3fee5ddc23eso27397075e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 01:05:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693209914; x=1693814714;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xQWIgjZcrLdmFQXZMQGeTrQD+VX6S0/LEZgiPsTk788=;
        b=ivMyzFwN7GKeEzFaH+j7cT+cQ+CEp6YTPOFst5quHHf90kSEMgnjobXtLV955zuVbA
         5D7foVRv9ZjoMkrAQT34NmNEGWOxwcHfhzHhH2/0YyIRP59HWa/orjcs34H9RohCpv+V
         nA46vxspuy7Krqu8pK5XDS+JD3bb5jEShzHUPBhuJhe39GESWg9iVyBKA5ryvThwvHef
         IEVYbwQzfyNjlcgcjeDjVxaRJJ9iRzS3oMOZT8Nz+cNZ1786P3Qgze8kJ6JTex7Q/3LF
         aro6aEV40bwL3TLXqusddrjC1iT6Pk2NWOwExE0IPyUrqNMDAq7MVERwV6AU2Gy7wHpC
         QuyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693209914; x=1693814714;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xQWIgjZcrLdmFQXZMQGeTrQD+VX6S0/LEZgiPsTk788=;
        b=hvyO6waB5IH5fautMY3scejPfDLixr3RUo0Upnmum0ucaO4GcFnsJzHOlSsHZlzU2G
         N+9eakPqBHPxQbEgfPm9tZAwY5h3bjeSxKWulgzy2X7sfkiULqJE4FfvFGdS/F17TEZ+
         XgIoYemainghQMuL2FtmnHkCyXfbCejHKIV4LYxOpdmKIC5TmFiITg5qPfEJRyE5MHlw
         yaT/dlHQdMcqjkg9GMzlymrDgohCZcNq6HVWIExqd7XL+Y2HLuhziAUw03QBr6v9zcB5
         PqCRHSI0O2UNA9BdIH+a9gIcRuUa3OmOL69tpF/GDPqTyfy+swKRiMJxOX9a/2icfFfN
         F20A==
X-Gm-Message-State: AOJu0YxLuU1QyGcvipIYq41Oz0X0QsMu+dpL6zB4gVnc1W0W4LqlNFIi
        piQUC5R1rSP8TWdWW06I+7i1aw==
X-Google-Smtp-Source: AGHT+IEmm18taWHcuOdw/1CJSDok2/75X8BzPvf5HcLg7r+OiWlmnjtMwNYn8PnTv8vHnQSCPWgikQ==
X-Received: by 2002:a7b:c410:0:b0:401:bf87:9895 with SMTP id k16-20020a7bc410000000b00401bf879895mr4005260wmi.22.1693209914529;
        Mon, 28 Aug 2023 01:05:14 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id z16-20020a1c4c10000000b003fa96fe2bd9sm13067035wmf.22.2023.08.28.01.05.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Aug 2023 01:05:14 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH v3 0/6] arm64: qcom: sm8550: enable RNG
Date:   Mon, 28 Aug 2023 10:04:35 +0200
Message-Id: <20230828-topic-sm8550-rng-v3-0-7a0678ca7988@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABNV7GQC/33NQQrCMBCF4auUrI0kk6YGV95DXKTptB3QpCQlK
 KV3N+1KQVz+D+abhSWMhImdq4VFzJQo+BLqUDE3Wj8gp640AwFKGAA+h4kcTw+jteDRD9wZJWs
 4GYUgWDmbIvb03MnrrfRIaQ7xtX/Iclv/YFlywQ1KIbSWje7k5U7exnAMcWCbluFTqH8IUISud
 7ZvW9lYhV/Cuq5vkOkbtfMAAAA=
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
        Om Prakash Singh <quic_omprsing@quicinc.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1536;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=tAwKpjXNPLYzwCCz0Ox35Z3YVqxCI2ttvIS2BJuYOrM=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBk7FU2iePQa/OEgPZPW7wG+eW8L396zXtv9b94JbuG
 GPBKcYCJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZOxVNgAKCRB33NvayMhJ0SaoEA
 DHBEu45yiAKGpz5N/1YMQAEoGIckBhdjvd2Y5Nb9UB07uXSJcQmOHyjy7CVU3oi+JJsGcwIbTqdbzT
 0TD6fHcnqOMTlleFTJCVvUczsTCGk/rMNvAX4HfJ8YgJyMuy/5h2Rwryw2pSOtp1nCEKvORf7Qv1i2
 dmkgM1ArtxYySbpbXgVvRhrc6pXr0XRRWOfCHtJX5WpdTnVlD8W2d7JqY4KJeaTrEbH3e0TtlTbcqr
 iSf5/Lt5xS+0UqohNaYXkm9vTOjqe212eJfzHStywoSoqdGM94E1ZborZ56WtNZ0kqncbM/SovToO3
 oRNSdXRz8q1nX3GaXr+rI99I1Q9qTAw6rXSlTIg6z102P2zVETdgG8j71rJ589exl/dUaMcUdy/78z
 NnB/vaIRfZt9LYAqtfju8876k3tP5JnjrNkR3cXWbSRroyuKvAVqVNIcClsUVviGyOSPHi5gfZZIrX
 zTziz00MXf+Rcjcws3otFvam55yzOtImgdNrhDGpN4NXwXjYPoGXqpY1aabkR+/Ha+z7ZuD1ZWDrpt
 69vkrdHhhsT43ZM81KQbI+p8IzuhFtIckdfsrFiV2f2kh+JPau2EfZ+t+8JsgR9L9FT9RV5g4/Mbie
 YDEdGfPQyHvI0VG2ZzrZRCFTFDAjSP5KksWK7k0l+TFkfhdozxrnA9O0tRMA==
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

Enable RNG on SM8550 by reverting the PRNG bindings & DT
for SM8450 and correctly document it as a True Random Number Generator.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
Changes in v3:
- Removed invalid character in commit msg
- Added review tags
- Removed applied patch 1
- Link to v2: https://lore.kernel.org/r/20230824-topic-sm8550-rng-v2-0-dfcafbb16a3e@linaro.org

Changes in v2:
- Revert SM8450 DT & bindings
- Add new qcom,trng compatible and use it for SM8450 & SM8550
- Explicitly didn't collect the Reviewed-by tags due to the compatible change
- Link to v1: https://lore.kernel.org/r/20230822-topic-sm8550-rng-v1-0-8e10055165d1@linaro.org

---
Neil Armstrong (6):
      Revert "arm64: dts: qcom: sm8450: Add PRNG"
      dt-bindings: crypto: qcom,prng: document that RNG on SM8450 is a TRNG
      crypto: qcom-rng - Add support for trng
      dt-bindings: crypto: qcom,prng: document SM8550
      arm64: dts: qcom: sm8550: add TRNG node
      arm64: dts: qcom: sm8450: add TRNG node

 .../devicetree/bindings/crypto/qcom,prng.yaml      | 26 +++++++++++++++++-----
 arch/arm64/boot/dts/qcom/sm8450.dtsi               |  2 +-
 arch/arm64/boot/dts/qcom/sm8550.dtsi               |  5 +++++
 drivers/crypto/qcom-rng.c                          |  1 +
 4 files changed, 28 insertions(+), 6 deletions(-)
---
base-commit: 2ee82481c392eec06a7ef28df61b7f0d8e45be2e
change-id: 20230822-topic-sm8550-rng-c83142783e20

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>


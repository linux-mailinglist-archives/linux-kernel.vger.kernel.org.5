Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C422C792C79
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 19:34:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232891AbjIERdA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 13:33:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232344AbjIERc0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 13:32:26 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 653FC25BC6
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 09:58:35 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-31dcd553fecso2268953f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Sep 2023 09:58:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693933045; x=1694537845; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=u6kNwqRygWFRS5KQ5/JjmBSWEbqa5XGk45okpfYEhOI=;
        b=rY4reqF7kns97dIO6Lkj7g4hlgb630ljx9rwJp8+KGendIpbm1m4IfphM9fAWWUr2S
         165YWs97+lwovELxVRX+BK1Ix+8zZWR2rFwIGOcDZyIjAina160e36vj1cMVaz4f0CYS
         s9lvkcNC7gaRsQTR/nyPyISAajgSC3jbasZA1cj/aXcXfGMbzHygEF7TmTs4LO8G0uo2
         oj8dVtxlLj+BEw+RUAnc1jEm9Eedme8gqpoUEjT2rliPpWpHBNGlCmz9VuXcWlmjdaPM
         UHGa0oP4831DEHdHo2qsPapT39S88pkP+d/XDWEu3StS6Som6NkmG4Mrf0La+nLWkKzl
         lARg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693933045; x=1694537845;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u6kNwqRygWFRS5KQ5/JjmBSWEbqa5XGk45okpfYEhOI=;
        b=KWebKK7qQugjaj4+/mOp/M2XcF0z1TQyvakq3Jb4kh7nlkemDANTQxF4ezF9/a3G8/
         SGGW/4UxosrJ2tb3UAYKCAKoJa7sRbz1NZQRJ9GADFeDmt1MIV8XkZq9y+D16W97UH+f
         41SxsBPFmlKr8xw2desL/J8t7r2VBmrduZrl/gxsT5Idu/WswZ1dwUcol6QbMs1QtD5W
         FjUNUufp4idRRUc1iuE9kMWam22vAUQBIuAZTWYOJAQktcaX4DenArQEm76mQ58f3Gz/
         V5d6tpnZMgowap0FsEEi6GpLAFVTm5qrcyewy5W/1JNOgOBOsTbqsYiHv/L0N80UUn6I
         Kb3w==
X-Gm-Message-State: AOJu0YxIUX44Z3CxgurOnOHLy0+LfE8Dli9VZ/7yKhLxxaSSIYxApvG3
        hpu2B8x0qSlmPibOSR3UtmIYH9qoXMn8r/Sbszg=
X-Google-Smtp-Source: AGHT+IG6fE0DFLC4mYCTNB761pLBJXI5zEAPWKwDAUwTMhFfQUCno/UDPuizMGw8KuJR95wGbAxJtA==
X-Received: by 2002:a17:906:d0:b0:9a6:1eab:9c84 with SMTP id 16-20020a17090600d000b009a61eab9c84mr287940eji.9.1693930767760;
        Tue, 05 Sep 2023 09:19:27 -0700 (PDT)
Received: from krzk-bin.. (77-252-46-238.static.ip.netia.com.pl. [77.252.46.238])
        by smtp.gmail.com with ESMTPSA id v26-20020a170906489a00b0099cc36c4681sm7743165ejq.157.2023.09.05.09.19.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Sep 2023 09:19:27 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 00/12] arm64: dts: qcom: correct UFS pad supply
Date:   Tue,  5 Sep 2023 18:19:08 +0200
Message-Id: <20230905161920.252013-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Not tested on hardware.

Best regards,
Krzysztof

Krzysztof Kozlowski (12):
  arm64: dts: qcom: sm6125-sprout: drop incorrect UFS phy max current
  arm64: dts: qcom: sm6125-sprout: correct UFS pad supply
  arm64: dts: qcom: sm6115-pro1x: correct UFS pad supply
  arm64: dts: qcom: sm6115p-j606f: correct UFS pad supply
  arm64: dts: qcom: apq8096-db820c: correct UFS pad supply
  arm64: dts: qcom: msm8996-oneplus: correct UFS pad supply
  arm64: dts: qcom: msm8996-gemini: correct UFS pad supply
  arm64: dts: qcom: msm8998-pro1: correct UFS pad supply
  arm64: dts: qcom: msm8998-mtp: correct UFS pad supply
  arm64: dts: qcom: msm8998-oneplus: correct UFS pad supply
  arm64: dts: qcom: msm8998-sagit: correct UFS pad supply
  arm64: dts: qcom: sm4250-billie2: correct UFS pad supply

 arch/arm64/boot/dts/qcom/apq8096-db820c.dts              | 2 +-
 arch/arm64/boot/dts/qcom/msm8996-oneplus-common.dtsi     | 2 +-
 arch/arm64/boot/dts/qcom/msm8996-xiaomi-common.dtsi      | 2 +-
 arch/arm64/boot/dts/qcom/msm8998-fxtec-pro1.dts          | 2 +-
 arch/arm64/boot/dts/qcom/msm8998-mtp.dts                 | 2 +-
 arch/arm64/boot/dts/qcom/msm8998-oneplus-common.dtsi     | 2 +-
 arch/arm64/boot/dts/qcom/msm8998-xiaomi-sagit.dts        | 2 +-
 arch/arm64/boot/dts/qcom/sm4250-oneplus-billie2.dts      | 2 +-
 arch/arm64/boot/dts/qcom/sm6115-fxtec-pro1x.dts          | 2 +-
 arch/arm64/boot/dts/qcom/sm6115p-lenovo-j606f.dts        | 2 +-
 arch/arm64/boot/dts/qcom/sm6125-xiaomi-laurel-sprout.dts | 4 +---
 11 files changed, 11 insertions(+), 13 deletions(-)

-- 
2.34.1


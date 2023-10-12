Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6ED607C6C58
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 13:31:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378330AbjJLLbQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 07:31:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343858AbjJLLbK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 07:31:10 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7C79C6
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 04:31:05 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-3226cc3e324so824007f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 04:31:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697110264; x=1697715064; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CnuoW+FQCD/OpcgflvSx0Oe2LZM8hD2I1654SS3PYOc=;
        b=pPD4LXApcviScq+lACrJ/cbam//ID6+iVyoZoX4FtxOhp3C7nJT4HCP3UnKwCotz0I
         dzdYR+4pyFKwBJzv/NsyetIGGGrxP3dAaB84Ufkp8bxYsbaoulAb7tQDLj5ws4q+d3WH
         yKw6sK/R7IkKy19lKVmWqHdHqFuOyP52SP+bTZ+hb5uSNyB6aNqkTsookAvvSU51dT4y
         RdU0g6ls9hO2aucYbyfgthNx4TMfXQkv73SrML8wjqtaLlSHanSbWcBe/FmHKaIAzgu4
         7uCPoeVG3/3BN7nOvmTCQAXu2VNU72aTfwtGCFhMy9nDZpEgUWKp5+F8rkV7Ytwbgx7Y
         zlVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697110264; x=1697715064;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CnuoW+FQCD/OpcgflvSx0Oe2LZM8hD2I1654SS3PYOc=;
        b=oZrhOwdgbvuDmpF0QVW8lTYHTWs0twTQ3xr0rPaQ0yohYOrxaxF2IRJIUosIKxKkUL
         nE28rf1CN9lLK5gHWGoo/Jnqs7HzgHtoaA6akkkjEuuWDkaoJ0gu1o9kriPY6dHaEUZy
         3OU9m+gEpZAGNeC4cuh718e/XTWd6iK9dMupJ55Mwp4gRn7I9LV4RJfJhg2pm0rS7kq/
         EUSs5APuj0W44VrM9b3UKcidQPKxklmPdj9qGxxbz4qrTF4/0tbMZf8jW6G90capk9xE
         46kDYFBcCoV90zFvM+AeA7lm7VyQb9C48qQg3EWGPFo9Yyp7070nsGzgdthiUbEXcS9K
         knJg==
X-Gm-Message-State: AOJu0YzWEWo7vfvkG4sTUt7rp6kYa9OLbnUyv599ER2S6YGChAvJcwF6
        FcNyND9bFI5yK9Llm+3T3H/A6g==
X-Google-Smtp-Source: AGHT+IGBdXRT0UtMVp+RpimAXsw2HQh3MU7GuKMfnrtGP6iY7VsQcYh19478v3IKMkocVBje2WrYow==
X-Received: by 2002:a05:6000:250:b0:32d:825b:e7da with SMTP id m16-20020a056000025000b0032d825be7damr3858653wrz.41.1697110264167;
        Thu, 12 Oct 2023 04:31:04 -0700 (PDT)
Received: from x13s-linux.nxsw.local ([37.228.218.3])
        by smtp.gmail.com with ESMTPSA id l14-20020a5d480e000000b0031c5e9c2ed7sm18244891wrq.92.2023.10.12.04.31.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 04:31:03 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     andersson@kernel.org, agross@kernel.org, konrad.dybcio@linaro.org,
        mturquette@baylibre.com, sboyd@kernel.org,
        dmitry.baryshkov@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        jonathan@marek.ca, quic_tdas@quicinc.com,
        vladimir.zapolskiy@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        bryan.odonoghue@linaro.org
Subject: [PATCH v4 0/4] Add sc8280xp CCI and CAMSS core dtsi
Date:   Thu, 12 Oct 2023 12:30:56 +0100
Message-Id: <20231012113100.3656480-1-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.40.1
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

V4:
- Adds RB - Krzysztof
- Drops indicated newline - Krzysztof
- Moves "This patch depends-on" below the "---" - Krsysztof

Link next:
https://git.codelinaro.org/bryan.odonoghue/kernel/-/tree/linux-next-23-10-10-sc8280xp-camss-v4

V3:
- Expands description of ports to clarify mapping of port to CSIPHY
  Rob

- Adds the dependency link into the commit log of patch #3 - bod

Link next:
https://git.codelinaro.org/bryan.odonoghue/kernel/-/tree/linux-next-23-10-10-sc8280xp-camss-v3

V2:
- Drops specific sc8280xp-cci compat - Konrad
- Drops minItems where maxItems are equal - Krzysztof
- Uses suggested description for CAMSS - Krzysztof
- Leaves indentation of ports/properties - Rob
- NoISP. Supports bayer encoded upstream currently only - Krzysztof
- Endpoint. Adds an example endpoint - Krzysztof

Link next:
https://git.codelinaro.org/bryan.odonoghue/kernel/-/tree/linux-next-23-10-10-sc8280xp-camss-v2

V1:
The sc8280xp provides a standard Camera Control Interface and Camera
SubSystem hardware interface similar to antecedent parts sdm845 and
sm8250.

Per the target segments for this part, sc8280xp has more of everything.
More CCI, VFE, CSIPHY and therefore more interrupt lines and clocks to
declare.

CCI x 4
CSIPHY x 4
VFE x 4
VFE Lite x 4
CSID x 4

Bootable 6.5.y x13s:
https://git.codelinaro.org/bryan.odonoghue/kernel/-/tree/lenovo-x13s-linux-6.5.y

Linux next:
https://git.codelinaro.org/bryan.odonoghue/kernel/-/tree/linux-next-23-10-06-sc8280xp-camss

This patch depends-on:
https://lore.kernel.org/lkml/20231004161853.86382-2-bryan.odonoghue@linaro.org/T/

Bryan O'Donoghue (4):
  arm64: dts: qcom: sc8280xp: Add in CAMCC for sc8280xp
  arm64: dts: qcom: sc8280xp: camss: Add CCI definitions
  media: dt-bindings: media: camss: Add qcom,sc8280xp-camss binding
  arm64: dts: qcom: sc8280xp: camss: Add CAMSS block definition

 .../bindings/media/qcom,sc8280xp-camss.yaml   | 581 ++++++++++++++++
 arch/arm64/boot/dts/qcom/sc8280xp.dtsi        | 624 ++++++++++++++++++
 2 files changed, 1205 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/qcom,sc8280xp-camss.yaml

-- 
2.40.1


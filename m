Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F5D67C5D24
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 20:55:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346179AbjJKSzv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 14:55:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233239AbjJKSzs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 14:55:48 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FE13A9
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 11:55:45 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-40572aeb73cso2343985e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 11:55:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697050543; x=1697655343; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=b18JSG/gE5pF19poGgo0WtqeEPHBkEaz7XetM6ld2MU=;
        b=da1gYhmBNeZo4doTEz/K/NLUTpZV6F8kDBypaxeqTBOMSAfLpHYSNEbKalzxRaC7n7
         mbFaevGxxwGcBX24/M9YXh7VBUEY8M9ZyFptPMjcf5yoOTXyukwfmRN04hmBPcEXfbXJ
         8d5GcM1hpvx7pbNK4gjuj+AsRfSTakKwxEbUSSFq0Mf/7DuoMbb6fAf5Ql3kogyQzhJH
         pyeSO4Krne/qekNHSsltQSrK0z2LWvM41cvTbSjS9sKkyMVJaITeBY3btRkoi1UjB8K6
         Scv/yUZh1y/epGNjqAxl+l749QssQiIVMcTrBUHn2nCkWtSthxFUwZyikqdr1OLrjEK8
         ymPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697050543; x=1697655343;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b18JSG/gE5pF19poGgo0WtqeEPHBkEaz7XetM6ld2MU=;
        b=Ed+We99T6rvhq/xOfDJq7FNAfl3Lg5hsk5PpPdlIHMul6GVQlcDC88dHjKCc2IPWvt
         GNZ6JRDRdAZ5TEfIUOaTWX7B4OiKUmTKV07onspb3nZX/YNDlINplrhokNUyi0bn3zix
         gnH2/ov0PVjNY8BFNmknshaKFNooO9+nRHDvCLC38PpIgKgngrgDZ61FjSaie724B8xq
         hXeOmiDH1lwFMOtbRwHYchFL/arh2AspBi9hiFY4gkyGaPd7sWzXba7lF4tfvtV5mXUr
         1YF02WdpwycA3F+j0MA6Jgu73uXm6x/wiATiquI1RpTuoHriR2j5NSksV0d2+BKSqBbp
         O8Cg==
X-Gm-Message-State: AOJu0Yxu3wpsX6fqpVHaqYAhmjRoCYNm7vCQRVh5ziAQpB9Flff2O6PX
        9wkeTLKBhXjaQt/ySGIrONE+zw==
X-Google-Smtp-Source: AGHT+IGBwWbpnBz8UGPlE37JYSwSN5Vabh/delGPT+w/bUyZq/8/UYqL1fPkOEbt+Tg8dAb5Ov5Pzw==
X-Received: by 2002:a05:600c:3ba1:b0:406:872d:7725 with SMTP id n33-20020a05600c3ba100b00406872d7725mr18712930wms.1.1697050543639;
        Wed, 11 Oct 2023 11:55:43 -0700 (PDT)
Received: from x13s-linux.nxsw.local ([37.228.218.3])
        by smtp.gmail.com with ESMTPSA id n22-20020a7bcbd6000000b004060f0a0fdbsm19928294wmi.41.2023.10.11.11.55.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 11:55:43 -0700 (PDT)
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
Subject: [PATCH v3 0/4] Add sc8280xp CCI and CAMSS core dtsi
Date:   Wed, 11 Oct 2023 19:55:36 +0100
Message-Id: <20231011185540.2282975-1-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

V3:
- Expands description of ports to clarify mapping of port to CSIPHY
  Rob

- Adds the dependency link into the commit log of patch #3 - bod

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

 .../bindings/media/qcom,sc8280xp-camss.yaml   | 582 ++++++++++++++++
 arch/arm64/boot/dts/qcom/sc8280xp.dtsi        | 624 ++++++++++++++++++
 2 files changed, 1206 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/qcom,sc8280xp-camss.yaml

-- 
2.40.1


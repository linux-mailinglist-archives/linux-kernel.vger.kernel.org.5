Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA1877D805D
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 12:14:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231127AbjJZKOA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 06:14:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234816AbjJZKNz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 06:13:55 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85EE11AC
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 03:13:51 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-32db188e254so504231f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 03:13:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698315230; x=1698920030; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B2S3KLqr2zv8LfJ920TgSSqGSC34BGJsKn/tmN9yzWw=;
        b=Qvg0DlO4O+QpeF7nhKXXUU6AOYWBdtuxes9L58RUGrVbrs8KJqUIWe10bpfxycf0E8
         irviwtofb3Yo3FsB9CPiVqtIimiSPAFwT5WQIPXTb99muR01CdR6bYc2zXxCoGmzMdwy
         FZieSbvibpc7BvRnilkRCTOEpPacluWBsUC74hrFMx8x7D2Cg/XulPgUwkLoAoes+1Uc
         +kZB7trgvqjYHUz0EIeSYq/4zzovmkhCNCe72v3zLtfLhGePdLnyAvQfoUyrk4v59ve/
         zNUImF4q2YQ2xfQhOqaEDyP17IkQGxOktGenj70AoHSj6zezl9t/nobVyuY1w2HbZKoj
         uacw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698315230; x=1698920030;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B2S3KLqr2zv8LfJ920TgSSqGSC34BGJsKn/tmN9yzWw=;
        b=gr2w+/kVwe7Tes/+2FAsU2aWvpQs+b8L4kU648RpUWoXK5ACjL0kekSUH5vPDeDbxY
         Gv/IE+L4GIwBaKa1bXiKI0mghTWcDmzS3uIyWeVaEESF9wGhQpxMpE7a7DRGPAMfuisn
         ROuU2h2W5EU7IRWVxDjZ+21k+yloOSfzsYFOfXw5H5Uq2AIlI6mvjuLpppPVpnQmyDL3
         Vlqv0vzg20TVMoH3fX75MU8SPLX4Rd0yT7h3+zuRkrWtSfj83+Mcv6Urb9cAf24cXdQE
         Nwfq0Kd0tJ23hLs5NK8JygWK+3PqFFwamXunYc1qwtIyUQ95vz+4snCtRfEUp+lAI4ke
         /Qcg==
X-Gm-Message-State: AOJu0YzlFyyJ9aDNlGxEfvYMolpReGH6JYEljQStH+ZNn6NZ4gTS2AWg
        RgxHXMVcbJk+r4kQkz7mkA5wUA==
X-Google-Smtp-Source: AGHT+IGIsCr8pMMmLUUYUNtgo0omdTQjmkxXltUehCDdin4S+gU+YNHB8zuLLwMy/F51Eqtsk5eUAA==
X-Received: by 2002:adf:f982:0:b0:32d:bdca:b244 with SMTP id f2-20020adff982000000b0032dbdcab244mr14783978wrr.7.1698315229870;
        Thu, 26 Oct 2023 03:13:49 -0700 (PDT)
Received: from x13s-linux.nxsw.local ([37.228.218.3])
        by smtp.gmail.com with ESMTPSA id m21-20020a056000181500b003271be8440csm13913103wrh.101.2023.10.26.03.13.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Oct 2023 03:13:49 -0700 (PDT)
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
Subject: [PATCH v4 0/4] Add sc8280xp CAMCC bindings and driver
Date:   Thu, 26 Oct 2023 11:13:39 +0100
Message-Id: <20231026101343.3300-1-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <aef93a48cf270d5078ccdc39d95113a4.sboyd@kernel.org>
References: <aef93a48cf270d5078ccdc39d95113a4.sboyd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v4:
- Resend of v3.2 addendum as v4 for tooling purposes

Link: https://lore.kernel.org/linux-arm-msm/20231024093919.226050-1-bryan.odonoghue@linaro.org/
Link: https://git.codelinaro.org/bryan.odonoghue/kernel/-/tree/qcom-linux-clk-for-6.7-camcc-sc8280xp-v4 

V3.1
- Drops dependency from below, since that patch needs a rebase
  on clk-next now anyway.
- Adds Krzysztof's RB as indicated to patches 1,2,4

Link: https://git.codelinaro.org/bryan.odonoghue/kernel/-/tree/qcom-linux-clk-for-6.7-camcc-sc8280xp-v3.1 

V3:

This patch depends-on:
https://lore.kernel.org/linux-arm-msm/20230923112105.18102-4-quic_luoj@quicinc.com

- Resolves CLK_CRITICAL camcc_gdsc_clk by making camcc_gdsc_clk
  always-on and dropping the CLK_CRITICAL flag.
  We want camcc_gdsc_clk for retention, however CLK_CRITICAL is not
  compatible with pm_runtime suspend and power collapse. - Konrad, Bod

- Uses gcc.yaml instead of camcc-common.yaml - Krzysztof

- Drops fix for 8550, TBH I didn't know use for socname-ip.yaml
  with compat strings for different drivers was OK, so long as the
  content of the yaml was compliant for both. - Krzysztof

- Drops clock-names, adds RB as indicated - Konrad

- Reworks "really_probe" to account for patch from Lou Jie which
  is RB from Stephen Boyd but not in any -next tree I can point to right
  now. - Konrad, Bod

- :g/CAM_CC/s//CAMCC/g - Bod

Link: https://git.codelinaro.org/bryan.odonoghue/kernel/-/commits/clk-for-6.7-camcc-sc8280xp-v3
 
V2:

I've expanded the scope of this series to include some fixups for the
camcc.yaml in general.

- Adds qcom,camcc-common.yaml
  There are a number of repeated patterns in the various camcc yaml
  files which we can contain in a common camcc .yaml instead.
  I used gcc.yaml as a base per Krzysztof's suggestion.

- Adding the common values file I noticed that sm8450 and sm8550 were
  both listed as compatible strings in qcom,sm8450-camcc.yaml.

  This appears to be in error though since sm8450 and sm8550 are
  not compat strings of the same driver but different drivers entirely.

- Switches to indexing, instead of fw_name for clocks - Konrad

- Adds the GCC AHB to the clock index - Bod/Konrad

- Changes reference "cam_cc" to "camcc" throughout camcc-sc8280xp.c

Link: https://git.codelinaro.org/bryan.odonoghue/kernel/-/tree/linux-next-26-10-23-sc8280xp-camcc-v2

V1:
This is a bog-standard series to add in the CAMCC for 8280xp.
As a precursor to adding in sc8280xp I thought a bit of tidy up on the
existing yaml for the camcc controllers in general would be worthwhile.

As a result there's a precursor patch which aggregates the various camcc
yaml files into one location.

The sc8280xp looks like sdm845 with more blocks. Similar to sc8280xp we
park GDSC to CXO. Thanks to Dmitry for the suggestion the GDSC parking.

Link: https://git.codelinaro.org/bryan.odonoghue/kernel/-/tree/linux-next-23-09-23-sc8280xp-camcc


Bryan O'Donoghue (4):
  dt-bindings: clock: Use gcc.yaml for common clock properties
  dt-bindings: clock: Add SC8280XP CAMCC
  clk: qcom: camcc-sc8280xp: Add sc8280xp CAMCC
  arm64: dts: qcom: sc8280xp: Add in CAMCC for sc8280xp

 .../bindings/clock/qcom,camcc-sm8250.yaml     |   18 +-
 .../bindings/clock/qcom,sc7180-camcc.yaml     |   18 +-
 .../bindings/clock/qcom,sc7280-camcc.yaml     |   18 +-
 .../bindings/clock/qcom,sdm845-camcc.yaml     |   18 +-
 .../bindings/clock/qcom,sm8450-camcc.yaml     |   20 +-
 arch/arm64/boot/dts/qcom/sc8280xp.dtsi        |   15 +
 drivers/clk/qcom/Kconfig                      |    9 +
 drivers/clk/qcom/Makefile                     |    1 +
 drivers/clk/qcom/camcc-sc8280xp.c             | 3044 +++++++++++++++++
 .../dt-bindings/clock/qcom,sc8280xp-camcc.h   |  179 +
 10 files changed, 3270 insertions(+), 70 deletions(-)
 create mode 100644 drivers/clk/qcom/camcc-sc8280xp.c
 create mode 100644 include/dt-bindings/clock/qcom,sc8280xp-camcc.h

-- 
2.40.1


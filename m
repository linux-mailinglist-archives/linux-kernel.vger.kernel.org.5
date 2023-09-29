Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 135907B2AAB
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 05:44:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229799AbjI2DoN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 23:44:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbjI2DoK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 23:44:10 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73BD419F
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 20:44:08 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-4063e3ce085so55813005e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 20:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695959047; x=1696563847; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=f4TogETOCk+xUnLHxKgeSQ2bXIzP6bF1+E5N8t7kwTQ=;
        b=ULCbDuiUqCqev47nQy+9QuXSa+SRY2UvFvLSt492XnLYcOO1q+3HV2m2lHMvT4ZGaJ
         GP1sTnW43mQG7sbOH6mwFqvJOrSAVxaR/M4VgyDstmPIRvsbl3AnZsYVAWBEoHBvB643
         2QBnj3YaVw3OQ4VJ1jP4TA9Jtn3sEXPJkUGRhR3CSG1AV+kMvZUSeQesaL/lASTo4G35
         urw82VeJAjwhLn3r3TsxWcDs2mr8Hp0g/Svex5cfbebzykT5vOxRbohhVP+6Ia3mUTuJ
         v89O3LgrrGl+9a+8MHFOn93j630eo6taFnKdyBx49DtxdTIHFzqrdsZefDdE6CZmhao1
         efCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695959047; x=1696563847;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f4TogETOCk+xUnLHxKgeSQ2bXIzP6bF1+E5N8t7kwTQ=;
        b=RY8B5cVganeTnNFM3+orNIlPsy63Ip69n9njPMAuX/S8ibTcst/G78JL7LVTxobjGf
         A0eN8c8eRBTWCOtum8409e3D+HtN9jxxJ6HkSKCFvBPDpIDYAUX4pkU22eEmd3Gbo3Ya
         nAgdI8sS/gAHDw0VQIfG2bCX4GcnzrGg2KX6EvhRkyrrhk6zJOc/50wk9O6rKQpKZ+af
         ZRxJt0Q01eXwYFZ+tM+Gy7WRp+YBCmBsOjSG5dcBmt9iv90QMJEQxFJJdsWuxC438OlZ
         THhlEXxos3vLUBo4eAs8WXfuUj9jxIPvQA6TE7FE4OHfYPkYonAL+wCWArsOp6nuvk42
         PAtg==
X-Gm-Message-State: AOJu0YwoOgCBuWbUT2d9p0q+KC6CgHrkoWOlAKvAV6iy9JAYilew4bp6
        P6AvYLZDe7v2mhRRcoEpv/TLYg==
X-Google-Smtp-Source: AGHT+IGpmAG6fkpT14Ex6tGOcQHHs82ZxMcFTf2OUK4PGyRogEEkYcbfxLlzFKTpKe31H7+LnvYFBA==
X-Received: by 2002:adf:ea84:0:b0:321:6f5f:78ab with SMTP id s4-20020adfea84000000b003216f5f78abmr2787348wrm.56.1695959046265;
        Thu, 28 Sep 2023 20:44:06 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id c10-20020a5d4f0a000000b0031f3ad17b2csm20645177wru.52.2023.09.28.20.44.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Sep 2023 20:44:05 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH v5 0/2] irqchip/qcom-pdc: support v3.2 HW
Date:   Fri, 29 Sep 2023 05:43:59 +0200
Message-Id: <20230929-topic-sm8x50-upstream-pdc-ver-v5-0-800111572104@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAP9HFmUC/43NzY7CIBiF4VsxrOcz/BbqyvswLih8KMlYGqjEi
 em9D7rRiYvO8j2L59xJwRyxkN3mTjLWWGIaW6ivDXFnO54Qom9NOOWCGs5gTlN0UC7mpihcpzJ
 ntBeYvIOKGRiTDgepkCGSZkwZQ7w9/cOx9TmWOeWf511lj/W/cmXAoPM6SO97pVm//46jzWmb8
 ok86MrfOb7G8cYJKtRgvDAm6A9OvHNijRONs1b73g6m4yg/OPnieqrWOAkUguuEcNoHI4c/3LI
 sv1PV3BO4AQAA
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>
Cc:     "Maulik Shah (mkshah)" <quic_mkshah@quicinc.com>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2375;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=hp7/MUaWObFj4XQkLlCEpU20zP1F2wzCk3sZcwXu3oo=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBlFkgEe/N4IU87QFHf1GiPai0/S5qTEmIo0SSbQXwX
 EqgDs82JAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZRZIBAAKCRB33NvayMhJ0bl9EA
 ClWbZWFmCrHt0MjMMg4/z14o0pR8Bdo7rn5iVIJe4YI+YqJKywi9/9Xz01nOOTSI/GKqRgi1uqABgx
 7A4DkUVHrdi177UDA0EBflf+lAvuFBuNWP0hs1GMEL1W0G6GqvqlfpKqRcnMHwltlM6DjtwKlgCokB
 +7gSmAOOhMcvDIcXO5ZMcSFRuBMtCiyfnY1meaEr3Nqay4b6vIGQoKK1kqwogxbdD+516W+F8Uqhr0
 uiMEpC0a6pZiBORasjjHZTpKzimiAGBHe10fKMC9DHLXSnlyv0va7OuzpMoxE18l5Yi1V4Y+9ekcKT
 B6cKuFRn2JCxHoHClR8+jvdOTk17+cUjxfWgrUclBR7NkU9rU6ZzZ1WpNPc/ksn6kCSa+Y4nv46/JE
 hBuLtddrSxdLHB+jhwDoIz6/iS1ehuzv7OfXM5uU4pHvE0aNDcE1s3nWoWiNHjxw37XWjka94Hk5SM
 /XzNwMgpdD/H/R6egeV1hQ3BOSjYzgni/j0lMOtztx/KsRVo9W0OTnCgBFpft5IM7EAt2GKQtMBJGi
 bn3Bwcw6nVfZhPL1xh815eH+2n6n8y/ZQWsjZfmQWGLhxv/DoNGE6fOHCDnFGO9ek/BL1pvNrBpV8L
 0xFM3DbcdlHuDKuofGrgIV1/0S5qP4wcUAeIMUsAtwt6dpEkZsGTkowqY6tg==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Starting from HW version 3.2 the IRQ_ENABLE bit has moved to the
IRQ_i_CFG register and requires a change of the driver to avoid
writing into an undefined register address.

Get the HW version from registers and set the IRQ_ENABLE bit to the
correct register depending on the HW version.

Since SM8150 DT uses a too smal PDC reg size, it's required to:
- fix SM8150 DT
- extend the PDC reg from the driver if used with old unfixed DT

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
Changes in v5:
- Rebased on v6.6-rc1
- Fixup the SoB chain as pointed out by Ingo on the PR
- Link to v4: https://lore.kernel.org/r/20230905-topic-sm8x50-upstream-pdc-ver-v4-0-fc633c7df84b@linaro.org

Changes in v4:
- Continue Dmitry's serie at https://lore.kernel.org/all/20230829092119.1017194-1-dmitry.baryshkov@linaro.org/
- Dmitry's changes:
   - Fix PDC resource size if it is too short instead of setting version to dummy 0 value (Marc).
   - Squashed the fix into the original patch.
- Changes requested by Marc on Dmitry's serie:
   - explicit PDC_VERSION is a reg offset
   - remove the enum
   - move the enable_intr to a shared function
   - add a warning when reg size doesn't match max size
- Link to v3: https://lore.kernel.org/r/20230823-topic-sm8x50-upstream-pdc-ver-v3-1-aa7d9ab862e4@linaro.org

Changes in v3:
- Simplify qcom_pdc_gic_set_type()
- Used __assign_bit in pdc_setup_pin_mapping()
- remove BIT() from IRQ_i_CFG_IRQ_ENABLE to be used with __assign_bit()
- Add Reviewed-by tag
- Link to v2: https://lore.kernel.org/r/20230822-topic-sm8x50-upstream-pdc-ver-v2-1-3035b8d388f7@linaro.org

Changes in v2:
- Changed IRQ_ENABLE handling based on Maulik's comments
- Link to v1: https://lore.kernel.org/r/20230821-topic-sm8x50-upstream-pdc-ver-v1-1-6d7f4dd95719@linaro.org

---
Dmitry Baryshkov (1):
      arm64: dts: qcom: sm8150: extend the size of the PDC resource

Neil Armstrong (1):
      irqchip/qcom-pdc: Add support for v3.2 HW

 arch/arm64/boot/dts/qcom/sm8150.dtsi |  2 +-
 drivers/irqchip/qcom-pdc.c           | 69 ++++++++++++++++++++++++++----------
 2 files changed, 52 insertions(+), 19 deletions(-)
---
base-commit: 0bb80ecc33a8fb5a682236443c1e740d5c917d1d
change-id: 20230821-topic-sm8x50-upstream-pdc-ver-114ceb45e1ee

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>


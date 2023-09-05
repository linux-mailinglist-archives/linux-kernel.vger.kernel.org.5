Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4D94792A2B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 18:58:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355078AbjIEQeK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:34:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354655AbjIENTg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 09:19:36 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8472119B
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 06:19:32 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-401d2e11dacso20740085e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Sep 2023 06:19:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693919971; x=1694524771; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4hLpU3WrzAqu1YGPEaYn5w1M/gu/DFgYtPSQF4kAnjM=;
        b=q+FPSo9zZ/5G5U+LTtTHHKJdM/IiMGKs/5LISAIK2bjzgnufZNBsSYefpfGN6ZH0T1
         Z/GPUMoEhGi668UnD/idyrRvHNy7+AB/xLGr68TNMUKDQHjeLAKB/+rYlnOup7gePvfN
         jvjpViESNgwqDUFmxC986gK7L3XbkjQKVVCbju+Av7y5WvGS04i2S2NKjgxhz/5o6mKI
         Ye1WmMWKZh/hbDqnBY/2jxXhQQw6otEZY0qZ3lbZ6ZC43u6Bnn4/HJTmIW/PQ7GIaHXh
         cgE9Mma3vMRyBx71WLGH04EaGDtUwRMX2hgyp/UoOIbz4x5FMewclHP9yrtwQTOj9R/q
         YSvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693919971; x=1694524771;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4hLpU3WrzAqu1YGPEaYn5w1M/gu/DFgYtPSQF4kAnjM=;
        b=k4Rw8qX56hYS5BahAdqau7ylio0TsDzPcqeqEi1czE4diOUkWI/81t6rFZ4IW86Gvf
         JxxnXKG615hjYe+gjsKzbhAQzHOsqkhg0qILDx2tShRQpDcCYEUc4JNK2YPUm+bVAlii
         IsBnBisWZGFDmKdC1rYRuRrl6qsWmU4yVJQbHJAOyr/aw9RZkRnAXlTqOddRBYfZ1/2m
         OlShcAWabEekGlKeD8uDlSu0lwSRM7BK/7AIbsptkvibkzQi36f9M3Qd96fPOs4NskZU
         x+74awXf4bFMriXeEzs/VXZ49YHTXkpucZ+ZwPhRyTSxOTEYljH3CXfnu/9/merWxBWD
         baPA==
X-Gm-Message-State: AOJu0YwLTxhEnf3mt2SZLAWYbCGbbkBJ8xw1Ejb2Sci7z+3WkUwqrSIJ
        3NIjPeX5Ts7E7m2PBgiXxtXboQ==
X-Google-Smtp-Source: AGHT+IGHAUuPdrwWZQcmSPMRSnNTRFc74/U3fvMYJHJDieudFMZEysMnAOqQSDpO+GGITt2mGqSu8w==
X-Received: by 2002:a05:600c:2286:b0:401:b3a5:ec04 with SMTP id 6-20020a05600c228600b00401b3a5ec04mr10231309wmf.16.1693919970771;
        Tue, 05 Sep 2023 06:19:30 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id s5-20020a7bc385000000b003fe61c33df5sm20131063wmj.3.2023.09.05.06.19.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Sep 2023 06:19:30 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH v4 0/2] irqchip/qcom-pdc: support v3.2 HW
Date:   Tue, 05 Sep 2023 15:19:24 +0200
Message-Id: <20230905-topic-sm8x50-upstream-pdc-ver-v4-0-fc633c7df84b@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANwq92QC/43NvQ6CMBiF4Vsxnf0M/QGKk/dhHAr9gCZCSYsNh
 nDvFiaMA47vGZ4zE4/OoCfX00wcBuON7WOI84lUreobBKNjE5YwnkhGYbSDqcB3ckoTeA1+dKg
 6GHQFAR1QKiosRYoUkURjcFibafPvj9it8aN17+0u0HX9Vw4UKGQ6r4XWRZrT4vY0vXL2Yl1DV
 jqwPceOOBY5nvC0lJpLWec/HN9z/IjjkVMq14UqZcZQfHHLsnwAYdLYcmkBAAA=
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2169;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=aiJtXRB76S99lVqDw6o854sEeT0xLBomEqFA71zt6W8=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBk9yrgYnsa6cXTe6f29+SIVGC6lvGGRi5KPj3uhRvs
 xUkmYD+JAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZPcq4AAKCRB33NvayMhJ0YDYD/
 0Yb0YKGl6g+AFnqv33cQJUHS6jbtzxYIhJwpK7tyrr8LnbN4ANcVmEg6xw/rohwqegQH2sRWgRfJcA
 3pY0XOh235+PZNF07PKOATIAusnjEvICidPvdiOIuN7K51o2uYApb1jYOqIAWKhGe9x3OqL4Yp1NQi
 /qVd+Ah120XOJe3V+uhxP3dJL1bHxKdIaCWTFOjWS7Mn4txP5ejhozskEzimiG8ElBmzf4F9PYR/QF
 qZqaOf1LXB3L6xqx6+P8fg5yKwlFgbFSnd6YOY68SCkr+RZqL6hG1np5qy4rD5BILA2b5b+DNdoRem
 WSh1kn7JmYe4l9DtriHhmwMO8UCzSceJk7ttS1utDGQ/IeF2C62fqvez36vn7SMaHLfEZgeYFmim/Q
 IurOeqE25s90LPlh3oNdbTe0blD6iJ/0j4MfGSwpvZigVj0ijAyXpMcfB9HC3+m1aPqtVPJlXc6AZQ
 OyjAbLGQO3MrIJF+WKTiNJO8+O147WcRQ8nghlashlj6ED5sw5cKyC7zPCpHO6Wznh4x5us7EfixEC
 0nuk6BJiFXRhmj/4gxjHEukrnGJ3hsbRdKDRRAbTER2IjchP0gwEit+93+RRSNi8HURPa6NA2bPt8B
 d0PuCnmAjsxLLwx8MrdIEGOBcWNtl/6wroX/4qa+AGteOFnD+EzBESCxhG2A==
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
base-commit: 47d9bb711707d15b19fad18c8e2b4b027a264a3a
change-id: 20230821-topic-sm8x50-upstream-pdc-ver-114ceb45e1ee

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>


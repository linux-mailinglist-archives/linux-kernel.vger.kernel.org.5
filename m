Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7D167D6359
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 09:35:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234101AbjJYHfv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 03:35:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234015AbjJYHfU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 03:35:20 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ED271BF3
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 00:33:56 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-32da7ac5c4fso3555588f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 00:33:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698219235; x=1698824035; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GrfbcuwNlTwyLcYogLMFiWCSoSNX4VqPPgIIWBUGDNI=;
        b=IcKqe3ZMbxVBk4b+UPwlUqdQyqj4XFYieG2HRPou96OVXqlSpZg8CkBtX1QZm6E3NP
         zxF2KXJqdvONVX/6ewdb+cVImCc5TKAAH2bdDetAEamPUz8fif7zoGkcTRATWSm/1/fQ
         1NunF6+1XRDvYWwIQxN+uDf3WJpNvg58a9bm1kSz6w+uMNFDS5iKJdDVsU3OYRYJeH3v
         zCCyvk38g/97aCPXiOxcuuqjTobS/4QE/39MGv/33hszUQbd5S0/uveB/nEAFaDJqEvE
         8ZCMnbFxhbZlTpGzdI2kkREIUwp//ylzWgbdUw3RTm0Ht/AVzj1G6oHaVB2CFLhadawa
         DArg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698219235; x=1698824035;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GrfbcuwNlTwyLcYogLMFiWCSoSNX4VqPPgIIWBUGDNI=;
        b=pY78Y1L/5MRxmy/L379x3Bh4Mh7r13fV6fyjNc9dkTZdO6Mmb2gQWxr8hkHevo2exk
         wnyBphsbaCiMe6j+Dqywho0eds+Pvt9Hi4Y15j7IXG1ZHN6nmIv/qwDWewnBBhy1478G
         tQJqaD1AVYgFIi65eeN15JyBE+ZuTX6/hiyfx2RPlekviI0Qsk4d0NZynQ3ixZFGofVt
         uYo7Wafv3tfcxXc47c1bCJyz8tdxbFN2gLGrXXS3nlR5J3wuKzu5+MufHhgRsJX9C5ek
         Hrs21ri6C6rZk/+ngM3KMs4roN42GWRCXEtLhPMOpXf3w7HIAbcOSjfjLQt88/bmagvC
         kicA==
X-Gm-Message-State: AOJu0YwZ+0hHAMcNkjg3vFGfuKxmMebnNN60Y9L1hssYSF3+vGsdh7cz
        ox4WJX9s6uM/qhPQxxZfISgKAA==
X-Google-Smtp-Source: AGHT+IHQMIavMxtXbbVlgJhx7eeBOBeGAhAjpReKFHjbMtG45n+Gy3xr2uIxR5/wFUFF9zNN48jXng==
X-Received: by 2002:a05:6000:50:b0:321:6f5f:789f with SMTP id k16-20020a056000005000b003216f5f789fmr10133469wrx.39.1698219234705;
        Wed, 25 Oct 2023 00:33:54 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id k17-20020a5d66d1000000b00327cd5e5ac1sm11546605wrw.1.2023.10.25.00.33.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 00:33:54 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH 0/3] pinctrl: qcom: Introduce Pinctrl/GPIO for SM8650
Date:   Wed, 25 Oct 2023 09:33:50 +0200
Message-Id: <20231025-topic-sm8650-upstream-tlmm-v1-0-4e3d84a3a46b@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAN7EOGUC/x3MQQqDMBAF0KvIrB1IjIrtVaQLSb/tgNGQiUUQ7
 27o8m3eSYokUHpWJyX8RGVbC2xdkf9O6wcs72JqTOOssT3nLYpnDUPfGd6j5oQpcF5C4BYerms
 xO/ugEsSEWY5/Pr6u6wZZtdWGbAAAAA==
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1637;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=m6+6Lw3b6NzvC5o8Z3ERp2+18RGFKp8bBRONhG0avNo=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBlOMTgAlruNS1Xcec/bkmeC0l8C8zHe5uu+bo/fkMr
 OfLTmzSJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZTjE4AAKCRB33NvayMhJ0WvED/
 4k4lo3g57mR+I5gMlRF8hq+LgocRZt+Qi8q+BZhwdi01zYN7N12x4ooMr1p7L2Z+Gl7drFBC9x7+Y7
 l6CC3lpS3HFuzVHDCm8KhEU1ddbTiZtDXkMgTEA+27fFYDGagCRW9ojuxaJmvNcOWgzJBAZI+9ChKA
 Zfg/NNXVf/iMEuMQ5Qafy6vpfH4e8cKrfwxgbC6LDpP2e1A0TwDIxBtu275c5QGAZEDHvRnP3Q5vih
 Z0XtdQfzN4axUvLw5VU8SzkW61eAbWTxwNsN5sQYLPheU21uQKHeaeUCJXIjSk7JIpvngQVk8kaNBz
 JhE8KCFBDnHbRJiDN7I7rD/YB3N/2ItoJWBnlxLyrMvabPLs4gGJtwTrmDhHsXjY/Iz1jQORNhC1ft
 MWsvA7h8EnZ15ZziQyO7Vf9xpO/OcfKFTRZ3M9VqBPeMBHvD3YmIpvBvuiONoEv/WTPRyf6zVrMSym
 5uHbSQj7ob8i4+amZuKX7VBrOfUdeq28hTmD9ZgCqeTFYkupsjqY1Px/pRGYqvSPfHRcZ9s716mosQ
 AlQfRdwnZgPPzE1RW47lVaaTY+Q4G/+K729ysryMxivgK7UdKo7AaIvKP6egiXCIE14JHkd2PRd8om
 h/NPl4Pe3l7EJw7Y4K524o5Ge+2Nuyt+3KGMReOQ8EGRCufgAOk66Xvuai4g==
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

The SM8650 Top Level Mode Multiplexer supports 211 GPIOs,
and the usual UFS Reset, SDC Clk/Cmd/Data special pins.

An handful of pins can have their IRQ generated by the PDC
module, and for this support for the new wakeup_present &
wakeup_enable_bit is required to allow the "wakeup" event
to be passed to PDC and generate an interrupt or a wakeup
system event.

As SM8550, it also supports the i2c_pull_bit bit to enable the
on-SoC load resistor for I2C busses.

Dependencies: None

For convenience, a regularly refreshed linux-next based git tree containing
all the SM8650 related work is available at:
https://git.codelinaro.org/neil.armstrong/linux/-/tree/topic/sm85650/upstream/integ

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
Neil Armstrong (3):
      dt-bindings: pinctrl: document the SM8650 Top Level Mode Multiplexer
      pinctrl: qcom: handle intr_target_reg wakeup_present/enable bits
      pinctrl: qcom: Introduce the SM8650 Top Level Mode Multiplexer driver

 .../bindings/pinctrl/qcom,sm8650-tlmm.yaml         |  157 ++
 drivers/pinctrl/qcom/Kconfig.msm                   |    8 +
 drivers/pinctrl/qcom/Makefile                      |    1 +
 drivers/pinctrl/qcom/pinctrl-msm.c                 |   32 +
 drivers/pinctrl/qcom/pinctrl-msm.h                 |    5 +
 drivers/pinctrl/qcom/pinctrl-sm8650.c              | 1762 ++++++++++++++++++++
 6 files changed, 1965 insertions(+)
---
base-commit: fe1998aa935b44ef873193c0772c43bce74f17dc
change-id: 20231016-topic-sm8650-upstream-tlmm-4ece354ef319

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>


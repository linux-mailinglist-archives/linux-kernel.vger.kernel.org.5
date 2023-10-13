Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F7FB7C7EAE
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 09:37:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229870AbjJMHhO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 03:37:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbjJMHhM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 03:37:12 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E323BD
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 00:37:09 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-3296b49c546so1507814f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 00:37:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1697182628; x=1697787428; darn=vger.kernel.org;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=QwkBCdmPcWNU+7PsxxS80Z7HY5APZAn6IaUDRF9z/7g=;
        b=afrbKrDIKG/tg4AdpJONU+1GImk7PLAJzJpO+ZX8JRaBXM4M+Busu6qDuqN2+B/sSg
         3IYcuGFpvGtnCpGtZ7C/KA4RxgCG9YEzaxtYklQMKHWE7ft/+ds7f7jm3K4WWTkYSX16
         gHlFMpPCJP5WRjbvJ6+mzx7m9Eqfa+lheP0FNno7j97JJ7aCu8CSe4feI+wIunYjU+mx
         p2175nWu+jM2X/XQ/nm57blM7RQ5LhlZLvh+VwWNkEybViALHHEDV3rUS6TVbRSFlgRb
         S0B755R4uxKlK/VmgVwk1r7ftbIWm7cyc9Xy8l/s7KKipc4A3re3PVAICWi7nxk5voq6
         g9ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697182628; x=1697787428;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QwkBCdmPcWNU+7PsxxS80Z7HY5APZAn6IaUDRF9z/7g=;
        b=sUARidRELownnZwXlVOtGUXOpyRMgLhraFkNd+3Z6SQy0rvVs9qO4gPoDbKnTPDc5L
         Mj2Xg2asCxNiaV14g4p6aNJpsAWPCcswfLkezYcmtueeRVWP0f4jpgVDpLa+QqoQmojI
         uOHKhfi8xzep6bapgZPGJ3rjJllFHfuqChBg5gRv/uq8mvMP6T820T3e4J6iS8i8FkhJ
         3brMuOrmz42RP59xoBdyC/mTMeK4O5dwRnZ//u4Ru8bcUpikskqkZuUsqLeDf21I/gSf
         kE/nfgT/QWPedrMhM4Rp420ypOwNG+cTO5mMeleXLgIOEnRj7Nli9TOT/fuaDll2DLgF
         ha7w==
X-Gm-Message-State: AOJu0YxOPr9eBbjHrdlUJ5SNQH/LXwdTkNxBewEmbSV5qVUKf0R0t7iD
        4qjW+SHjTfRjK+X2kL64SennrQ==
X-Google-Smtp-Source: AGHT+IF47D5nfuOO1fNDgKrLpZfZIR3LU3/kd21Io+xC0N4oet37n+Sg+1yz+OLQlDvBMZndbRb35Q==
X-Received: by 2002:a05:6000:5c6:b0:32d:5870:8b8a with SMTP id bh6-20020a05600005c600b0032d58708b8amr9030172wrb.56.1697182627837;
        Fri, 13 Oct 2023 00:37:07 -0700 (PDT)
Received: from localhost ([2a01:e0a:3c5:5fb1:b50c:c5d5:8b1b:e06d])
        by smtp.gmail.com with ESMTPSA id r6-20020a5d4946000000b0032da022855fsm235205wrs.111.2023.10.13.00.37.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Oct 2023 00:37:07 -0700 (PDT)
References: <20231010062917.3624223-1-xianwei.zhao@amlogic.com>
 <20231010062917.3624223-2-xianwei.zhao@amlogic.com>
 <20231010132151.GA557938-robh@kernel.org>
 <291f03f9-72aa-2842-b44a-c88c812df4f1@amlogic.com>
User-agent: mu4e 1.8.13; emacs 29.1
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Xianwei Zhao <xianwei.zhao@amlogic.com>,
        Rob Herring <robh@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Chuan Liu <chuan.liu@amlogic.com>
Subject: Re: [PATCH V2 1/4] dt-bindings: clock: add Amlogic C3 PLL clock
 controller bindings
Date:   Fri, 13 Oct 2023 09:35:26 +0200
In-reply-to: <291f03f9-72aa-2842-b44a-c88c812df4f1@amlogic.com>
Message-ID: <1jr0lzvuql.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed 11 Oct 2023 at 10:50, Xianwei Zhao <xianwei.zhao@amlogic.com> wrote:

> Hi Rob,
>     Thanks for your advise.
>
> On 2023/10/10 21:21, Rob Herring wrote:
>> [ EXTERNAL EMAIL ]
>> On Tue, Oct 10, 2023 at 02:29:14PM +0800, Xianwei Zhao wrote:
>>> Add the C3 PLL clock controller dt-bindings for Amlogic C3 SoC family
>>>
>>> Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
>>> ---
>>> V1 -> V2: Fix errors when check dtbinding use "make dt_binding_check"
>> Your patches aren't bisectable. It's fine if you want to combine patch 1
>> and 2 into 1 patch. Or just use the raw numbers here instead of the
>> header.
>> 
> I will combine patch 1 and 2 into 1 patch in V3.

I'd prefer if you used raw ids or even fake node for the example, like
<&pll_in> and <&mpll_in> for readability, rather than combining the patches

>>> ---
>>>   .../bindings/clock/amlogic,c3-pll-clkc.yaml   | 59 +++++++++++++++++++
>>>   .../dt-bindings/clock/amlogic,c3-pll-clkc.h   | 42 +++++++++++++
>>>   2 files changed, 101 insertions(+)
>>>   create mode 100644 Documentation/devicetree/bindings/clock/amlogic,c3-pll-clkc.yaml
>>>   create mode 100644 include/dt-bindings/clock/amlogic,c3-pll-clkc.h
>>>
>>> diff --git a/Documentation/devicetree/bindings/clock/amlogic,c3-pll-clkc.yaml b/Documentation/devicetree/bindings/clock/amlogic,c3-pll-clkc.yaml
>>> new file mode 100644
>>> index 000000000000..a646992917b7
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/clock/amlogic,c3-pll-clkc.yaml
>>> @@ -0,0 +1,59 @@
>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>> +# Copyright (C) 2022-2023 Amlogic, Inc. All rights reserved
>>> +%YAML 1.2
>>> +---
>>> +$id: http://devicetree.org/schemas/clock/amlogic,c3-pll-clkc.yaml#
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: Amlogic C3 serials PLL Clock Controller
>> s/serials/Serials/
>> 
> Will fix
>>> +
>>> +maintainers:
>>> +  - Chuan Liu <chuan.liu@amlogic.com>
>>> +
>>> +properties:
>>> +  compatible:
>>> +    const: amlogic,c3-pll-clkc
>>> +
>>> +  reg:
>>> +    maxItems: 1
>>> +
>>> +  clocks:
>>> +    minItems: 1
>>> +    items:
>>> +      - description: input pll_in
>>> +      - description: input mclk_pll_in
>>> +
>>> +  clock-names:
>>> +    minItems: 1
>>> +    items:
>>> +      - const: pll_in
>>> +      - const: mclk_pll_in
>>> +
>>> +  "#clock-cells":
>>> +    const: 1
>>> +
>>> +required:
>>> +  - compatible
>>> +  - reg
>>> +  - clocks
>>> +  - clock-names
>>> +  - "#clock-cells"
>>> +
>>> +additionalProperties: false
>>> +
>>> +examples:
>>> +  - |
>>> +    #include <dt-bindings/clock/amlogic,c3-peripherals-clkc.h>
>>> +    apb {
>>> +        #address-cells = <2>;
>>> +        #size-cells = <2>;
>>> +
>>> +        clkc_pll: clock-controller@8000 {
>> Drop unused labels.
>> 
> Will delete clkc_pll.
>>> +          compatible = "amlogic,c3-pll-clkc";
>> Your indentation is not consistent.
>> 
> Will fix it in V3.
>>> +          reg = <0x0 0x8000 0x0 0x1a4>;
>>> +          clocks = <&clkc_periphs CLKID_PLL_IN>,
>>> +                   <&clkc_periphs CLKID_MCLK_PLL_IN>;
>>> +          clock-names = "pll_in", "mclk_pll_in";
>>> +          #clock-cells = <1>;
>>> +        };
>>> +    };
>>> diff --git a/include/dt-bindings/clock/amlogic,c3-pll-clkc.h b/include/dt-bindings/clock/amlogic,c3-pll-clkc.h
>>> new file mode 100644
>>> index 000000000000..aa731e8fae29
>>> --- /dev/null
>>> +++ b/include/dt-bindings/clock/amlogic,c3-pll-clkc.h
>>> @@ -0,0 +1,42 @@
>>> +/* SPDX-License-Identifier: (GPL-2.0-only OR MIT) */
>>> +/*
>>> + * Copyright (c) 2023 Amlogic, Inc. All rights reserved.
>>> + * Author: Chuan Liu <chuan.liu@amlogic.com>
>>> + */
>>> +
>>> +#ifndef _DT_BINDINGS_CLOCK_AMLOGIC_C3_PLL_CLKC_H
>>> +#define _DT_BINDINGS_CLOCK_AMLOGIC_C3_PLL_CLKC_H
>>> +
>>> +#define CLKID_FIXED_PLL_DCO                  0
>>> +#define CLKID_FIXED_PLL                              1
>>> +#define CLKID_FCLK_DIV40_DIV                 2
>>> +#define CLKID_FCLK_DIV40                     3
>>> +#define CLKID_FCLK_DIV2_DIV                  4
>>> +#define CLKID_FCLK_DIV2                              5
>>> +#define CLKID_FCLK_DIV2P5_DIV                        6
>>> +#define CLKID_FCLK_DIV2P5                    7
>>> +#define CLKID_FCLK_DIV3_DIV                  8
>>> +#define CLKID_FCLK_DIV3                              9
>>> +#define CLKID_FCLK_DIV4_DIV                  10
>>> +#define CLKID_FCLK_DIV4                              11
>>> +#define CLKID_FCLK_DIV5_DIV                  12
>>> +#define CLKID_FCLK_DIV5                              13
>>> +#define CLKID_FCLK_DIV7_DIV                  14
>>> +#define CLKID_FCLK_DIV7                              15
>>> +#define CLKID_GP0_PLL_DCO                    16
>>> +#define CLKID_GP0_PLL                                17
>>> +#define CLKID_HIFI_PLL_DCO                   18
>>> +#define CLKID_HIFI_PLL                               19
>>> +#define CLKID_MCLK_PLL_DCO                   20
>>> +#define CLKID_MCLK_PLL                               21
>>> +#define CLKID_MCLK_PLL_CLK                   22
>>> +#define CLKID_MCLK0_SEL                              23
>>> +#define CLKID_MCLK0_SEL_OUT                  24
>>> +#define CLKID_MCLK0_DIV                              25
>>> +#define CLKID_MCLK0                          26
>>> +#define CLKID_MCLK1_SEL                              27
>>> +#define CLKID_MCLK1_SEL_OUT                  28
>>> +#define CLKID_MCLK1_DIV                              29
>>> +#define CLKID_MCLK1                          30
>>> +
>>> +#endif  /* _DT_BINDINGS_CLOCK_AMLOGIC_C3_PLL_CLKC_H */
>>>
>>> base-commit: 57b55c76aaf1ba50ecc6dcee5cd6843dc4d85239
>>> --
>>> 2.37.1
>>>


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0298A810D58
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 10:27:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231738AbjLMJ13 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 13 Dec 2023 04:27:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbjLMJ11 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 04:27:27 -0500
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33B29D0;
        Wed, 13 Dec 2023 01:27:31 -0800 (PST)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id CE8A924E2A1;
        Wed, 13 Dec 2023 17:27:29 +0800 (CST)
Received: from EXMBX068.cuchost.com (172.16.6.68) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 13 Dec
 2023 17:27:29 +0800
Received: from [192.168.120.47] (171.223.208.138) by EXMBX068.cuchost.com
 (172.16.6.68) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 13 Dec
 2023 17:27:28 +0800
Message-ID: <62bb91ad-5d4b-4ec6-80c8-6c3edf5d25cd@starfivetech.com>
Date:   Wed, 13 Dec 2023 17:27:26 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 2/4] pwm: opencores: Add PWM driver support
Content-Language: en-US
To:     Rob Herring <robh+dt@kernel.org>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>, <linux-pwm@vger.kernel.org>,
        "Emil Renner Berthing" <kernel@esmil.dk>,
        Thierry Reding <thierry.reding@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
        Hal Feng <hal.feng@starfivetech.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "Palmer Dabbelt" <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
References: <20231208094209.1910934-1-william.qiu@starfivetech.com>
 <20231208094209.1910934-3-william.qiu@starfivetech.com>
 <CAL_JsqK8fsAocOu3OBdz1kzNiApf1J0Uc0spn8gfdJaVnomFHQ@mail.gmail.com>
From:   William Qiu <william.qiu@starfivetech.com>
In-Reply-To: <CAL_JsqK8fsAocOu3OBdz1kzNiApf1J0Uc0spn8gfdJaVnomFHQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Originating-IP: [171.223.208.138]
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX068.cuchost.com
 (172.16.6.68)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/12/12 1:41, Rob Herring wrote:
> On Fri, Dec 8, 2023 at 3:42 AM William Qiu <william.qiu@starfivetech.com> wrote:
>>
>> Add driver for OpenCores PWM Controller. And add compatibility code
>> which based on StarFive SoC.
>>
>> Co-developed-by: Hal Feng <hal.feng@starfivetech.com>
>> Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
>> Signed-off-by: William Qiu <william.qiu@starfivetech.com>
>> ---
>>  MAINTAINERS              |   7 ++
>>  drivers/pwm/Kconfig      |  12 ++
>>  drivers/pwm/Makefile     |   1 +
>>  drivers/pwm/pwm-ocores.c | 229 +++++++++++++++++++++++++++++++++++++++
>>  4 files changed, 249 insertions(+)
>>  create mode 100644 drivers/pwm/pwm-ocores.c
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 788be9ab5b73..7a11a22da09e 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -16204,6 +16204,13 @@ F:     Documentation/i2c/busses/i2c-ocores.rst
>>  F:     drivers/i2c/busses/i2c-ocores.c
>>  F:     include/linux/platform_data/i2c-ocores.h
>>
>> +OPENCORES PWM DRIVER
>> +M:     William Qiu <william.qiu@starfivetech.com>
>> +M:     Hal Feng <hal.feng@starfivetech.com>
>> +S:     Supported
>> +F:     Documentation/devicetree/bindings/pwm/opencores,pwm.yaml
>> +F:     drivers/pwm/pwm-ocores.c
>> +
>>  OPENRISC ARCHITECTURE
>>  M:     Jonas Bonn <jonas@southpole.se>
>>  M:     Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
>> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
>> index 4b956d661755..d87e1bb350ba 100644
>> --- a/drivers/pwm/Kconfig
>> +++ b/drivers/pwm/Kconfig
>> @@ -444,6 +444,18 @@ config PWM_NTXEC
>>           controller found in certain e-book readers designed by the original
>>           design manufacturer Netronix.
>>
>> +config PWM_OCORES
>> +       tristate "OpenCores PWM support"
>> +       depends on HAS_IOMEM && OF
>> +       depends on COMMON_CLK && RESET_CONTROLLER
>> +       depends on ARCH_STARFIVE || COMPILE_TEST
>> +       help
>> +         If you say yes to this option, support will be included for the
>> +         OpenCores PWM. For details see https://opencores.org/projects/ptc.
>> +
>> +         To compile this driver as a module, choose M here: the module
>> +         will be called pwm-ocores.
>> +
>>  config PWM_OMAP_DMTIMER
>>         tristate "OMAP Dual-Mode Timer PWM support"
>>         depends on OF
>> diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
>> index c5ec9e168ee7..517c4f643058 100644
>> --- a/drivers/pwm/Makefile
>> +++ b/drivers/pwm/Makefile
>> @@ -40,6 +40,7 @@ obj-$(CONFIG_PWM_MICROCHIP_CORE)      += pwm-microchip-core.o
>>  obj-$(CONFIG_PWM_MTK_DISP)     += pwm-mtk-disp.o
>>  obj-$(CONFIG_PWM_MXS)          += pwm-mxs.o
>>  obj-$(CONFIG_PWM_NTXEC)                += pwm-ntxec.o
>> +obj-$(CONFIG_PWM_OCORES)       += pwm-ocores.o
>>  obj-$(CONFIG_PWM_OMAP_DMTIMER) += pwm-omap-dmtimer.o
>>  obj-$(CONFIG_PWM_PCA9685)      += pwm-pca9685.o
>>  obj-$(CONFIG_PWM_PXA)          += pwm-pxa.o
>> diff --git a/drivers/pwm/pwm-ocores.c b/drivers/pwm/pwm-ocores.c
>> new file mode 100644
>> index 000000000000..996ca3805901
>> --- /dev/null
>> +++ b/drivers/pwm/pwm-ocores.c
>> @@ -0,0 +1,229 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * OpenCores PWM Driver
>> + *
>> + * https://opencores.org/projects/ptc
>> + *
>> + * Copyright (C) 2018-2023 StarFive Technology Co., Ltd.
>> + *
>> + * Limitations:
>> + * - The hardware only do inverted polarity.
>> + * - The hardware minimum period / duty_cycle is (1 / pwm_apb clock frequency) ns.
>> + * - The hardware maximum period / duty_cycle is (U32_MAX / pwm_apb clock frequency) ns.
>> + */
>> +
>> +#include <linux/clk.h>
>> +#include <linux/io.h>
>> +#include <linux/module.h>
>> +#include <linux/of.h>
>> +#include <linux/of_device.h>
> 
> You probably don't need this header and the implicit includes it makes
> are dropped now in linux-next. Please check what you actually need and
> make them explicit.
> 
> Rob
Will drop.

Thank you for spending time on this patchset.

Best Regards
William

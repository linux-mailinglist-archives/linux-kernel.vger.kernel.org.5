Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E0C87667B1
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 10:48:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235154AbjG1Is2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 04:48:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235247AbjG1IsG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 04:48:06 -0400
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A46A46A0;
        Fri, 28 Jul 2023 01:47:32 -0700 (PDT)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id 561BF24E355;
        Fri, 28 Jul 2023 16:47:30 +0800 (CST)
Received: from EXMBX068.cuchost.com (172.16.6.68) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 28 Jul
 2023 16:47:30 +0800
Received: from [192.168.120.59] (171.223.208.138) by EXMBX068.cuchost.com
 (172.16.6.68) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 28 Jul
 2023 16:47:29 +0800
Message-ID: <51547f1a-4eb4-2ccd-1e06-8adb2b4b70bd@starfivetech.com>
Date:   Fri, 28 Jul 2023 16:47:27 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v5 0/3] Add initialization of clock for StarFive JH7110
 SoC
To:     <devicetree@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>
CC:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Ziv Xu <ziv.xu@starfivetech.com>
References: <20230719092545.1961401-1-william.qiu@starfivetech.com>
Content-Language: en-US
From:   William Qiu <william.qiu@starfivetech.com>
In-Reply-To: <20230719092545.1961401-1-william.qiu@starfivetech.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [171.223.208.138]
X-ClientProxiedBy: EXCAS062.cuchost.com (172.16.6.22) To EXMBX068.cuchost.com
 (172.16.6.68)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/7/19 17:25, William Qiu wrote:
> Hi,
> 
> This patchset adds initial rudimentary support for the StarFive
> Quad SPI controller driver. And this driver will be used in
> StarFive's VisionFive 2 board. In 6.4, the QSPI_AHB and QSPI_APB
> clocks changed from the default ON state to the default OFF state,
> so these clocks need to be enabled in the driver.At the same time,
> dts patch is added to this series.
> 
> Changes v4->v5:
> - Rebased to v6.5rc2.
> - Changed the way to initialization the clocks.
> - Changed the layout for the SPI flash.
> 
> Changes v3->v4:
> - Added minItems for clocks.
> - Added clock names property.
> - Fixed formatting issues.
> 
> Changes v2->v3:
> - Rebased to v6.4rc6.
> - Renamed the clock names.
> - Changed the variable definition type.
> 
> Changes v1->v2:
> - Renamed the clock names.
> - Specified a different array of clocks.
> - Used clk_bulk_ APIs.
> 
> The patch series is based on v6.5rc2.
> 
> William Qiu (3):
>   dt-bindings: qspi: cdns,qspi-nor: Add clocks for StarFive JH7110 SoC
>   spi: cadence-quadspi: Add clock configuration for StarFive JH7110 QSPI
>   riscv: dts: starfive: Add QSPI controller node for StarFive JH7110 SoC
> 
>  .../bindings/spi/cdns,qspi-nor.yaml           | 12 +++-
>  .../jh7110-starfive-visionfive-2.dtsi         | 36 ++++++++++
>  arch/riscv/boot/dts/starfive/jh7110.dtsi      | 19 ++++++
>  drivers/spi/spi-cadence-quadspi.c             | 67 +++++++++++++++++++
>  4 files changed, 133 insertions(+), 1 deletion(-)
> 
> --
> 2.34.1
> 
Hi everyone,

Could you please help me review this patch series to see if there is
anything that needs to be modified?
Thanks for taking time to review this patch series.

Best Regards,
William

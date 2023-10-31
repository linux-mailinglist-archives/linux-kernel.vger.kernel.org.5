Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31D457DD5CB
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 19:07:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376607AbjJaSHc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 14:07:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347017AbjJaSHb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 14:07:31 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68EE2B4;
        Tue, 31 Oct 2023 11:07:28 -0700 (PDT)
Received: from [100.116.17.117] (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: cristicc)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 1520966072F7;
        Tue, 31 Oct 2023 18:07:25 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1698775646;
        bh=ARXAsPmFxCGbvMvWFqVbwkT8xs88S/Oot9kZ7ny7v/Q=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Zd+wjSr1TMzzlQWdtl0zpPfdYESDiPbAODKkE5qPYSsIW3TSCCtSX+x9wZfxPDjRL
         eoAfnuuFjrRgRjzwxx0PYphqSkBhPLjgZOI1Bs8p6L63rf+guamOzwqv+hHDoO7JsY
         UrsSy3BawDmzIQjs1cKt2CW4r+ahoDh2F68Fk+hlIGXDnaNA+OKgVrokUU2+hMxR7g
         vqssdH7/6JMW3Wax36527BZAyhHCbBWe0DvjxGAhTIN6sVB+K3m9Z6ki/z7TXZIzLH
         FspdVYI6KG9IGq8FsXIz34mFahY53ukYuvuRMj8SdfQMi1Trv3BrheqsoAafOq9CU9
         /+Cw4Cz39ePmw==
Message-ID: <519fae84-cc40-47ab-8e6b-9967ce046104@collabora.com>
Date:   Tue, 31 Oct 2023 20:07:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/12] net: stmmac: dwmac-starfive: Add support for
 JH7100 SoC
Content-Language: en-US
To:     Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Samin Guo <samin.guo@starfivetech.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>
Cc:     netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, kernel@collabora.com
References: <20231029042712.520010-1-cristian.ciocaltea@collabora.com>
 <20231029042712.520010-6-cristian.ciocaltea@collabora.com>
 <CAJM55Z8K5QztgU9NYiJ1kv+-BSsgP=LCABN7BYDtQ30_G1Nc7w@mail.gmail.com>
From:   Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
In-Reply-To: <CAJM55Z8K5QztgU9NYiJ1kv+-BSsgP=LCABN7BYDtQ30_G1Nc7w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/31/23 16:33, Emil Renner Berthing wrote:
> Cristian Ciocaltea wrote:
>> Add a missing quirk to enable support for the StarFive JH7100 SoC.
>>
>> Additionally, for greater flexibility in operation, allow using the
>> rgmii-rxid and rgmii-txid phy modes.
>>
>> Co-developed-by: Emil Renner Berthing <kernel@esmil.dk>
>> Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
>> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
> 
> Hi Cristian,
> 
> Thanks for working on this! This driver has code to update the phy clock for
> different line speeds. I don't think that will work without the
> CLK_SET_RATE_PARENT flag added to the clock in [1] which in turn depends on
> [2].
> 
> [1]: https://github.com/esmil/linux/commit/b200c3054b58a49ba25af67aff82d9045e3c3666
> [2]: https://github.com/esmil/linux/commit/dce189542c16bf0eb8533d96c0305cb59d149dae
> 
> Two more comments below..

Hi Emil,

Thanks for the review!

I've been only testing this at 1000 Mbps and so far it seems to work
fine. I will try with different line speeds and report back.

>> ---
>>  drivers/net/ethernet/stmicro/stmmac/Kconfig   |  6 ++--
>>  .../ethernet/stmicro/stmmac/dwmac-starfive.c  | 32 ++++++++++++++++---
>>  2 files changed, 31 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/stmicro/stmmac/Kconfig b/drivers/net/ethernet/stmicro/stmmac/Kconfig
>> index a2b9e289aa36..c3c2c8360047 100644
>> --- a/drivers/net/ethernet/stmicro/stmmac/Kconfig
>> +++ b/drivers/net/ethernet/stmicro/stmmac/Kconfig
>> @@ -165,9 +165,9 @@ config DWMAC_STARFIVE
>>  	help
>>  	  Support for ethernet controllers on StarFive RISC-V SoCs
>>
>> -	  This selects the StarFive platform specific glue layer support for
>> -	  the stmmac device driver. This driver is used for StarFive JH7110
>> -	  ethernet controller.
>> +	  This selects the StarFive platform specific glue layer support
>> +	  for the stmmac device driver. This driver is used for the
>> +	  StarFive JH7100 and JH7110 ethernet controllers.
>>
>>  config DWMAC_STI
>>  	tristate "STi GMAC support"
>> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-starfive.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-starfive.c
>> index 5d630affb4d1..88c431edcea0 100644
>> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-starfive.c
>> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-starfive.c
>> @@ -15,13 +15,20 @@
>>
>>  #include "stmmac_platform.h"
>>
>> -#define STARFIVE_DWMAC_PHY_INFT_RGMII	0x1
>> -#define STARFIVE_DWMAC_PHY_INFT_RMII	0x4
>> -#define STARFIVE_DWMAC_PHY_INFT_FIELD	0x7U
>> +#define STARFIVE_DWMAC_PHY_INFT_RGMII		0x1
>> +#define STARFIVE_DWMAC_PHY_INFT_RMII		0x4
>> +#define STARFIVE_DWMAC_PHY_INFT_FIELD		0x7U
>> +
>> +#define JH7100_SYSMAIN_REGISTER49_DLYCHAIN	0xc8
>> +
>> +struct starfive_dwmac_data {
>> +	unsigned int gtxclk_dlychain;
>> +};
>>
>>  struct starfive_dwmac {
>>  	struct device *dev;
>>  	struct clk *clk_tx;
>> +	const struct starfive_dwmac_data *data;
>>  };
>>
>>  static void starfive_dwmac_fix_mac_speed(void *priv, unsigned int speed, unsigned int mode)
>> @@ -67,6 +74,8 @@ static int starfive_dwmac_set_mode(struct plat_stmmacenet_data *plat_dat)
>>
>>  	case PHY_INTERFACE_MODE_RGMII:
>>  	case PHY_INTERFACE_MODE_RGMII_ID:
>> +	case PHY_INTERFACE_MODE_RGMII_RXID:
>> +	case PHY_INTERFACE_MODE_RGMII_TXID:
>>  		mode = STARFIVE_DWMAC_PHY_INFT_RGMII;
>>  		break;
>>
>> @@ -89,6 +98,14 @@ static int starfive_dwmac_set_mode(struct plat_stmmacenet_data *plat_dat)
>>  	if (err)
>>  		return dev_err_probe(dwmac->dev, err, "error setting phy mode\n");
>>
>> +	if (dwmac->data) {
> 
> I think you want something like this so future quirks don't need to touch this
> code:
> 
> 	if (dwmac->data && dwmac->data->gtxclk_dlychain)

Yes, but that would prevent having a quirk that explicitly wants to write 0.

I was initially thinking to something more generic, like providing a
list of register-value pairs, but I'm not sure this is going to be ever
needed.

I'm still open to apply the suggested change, though.

>> +		err = regmap_write(regmap, JH7100_SYSMAIN_REGISTER49_DLYCHAIN,
>> +				   dwmac->data->gtxclk_dlychain);
>> +		if (err)
>> +			return dev_err_probe(dwmac->dev, err,
>> +					     "error selecting gtxclk delay chain\n");
>> +	}
>> +
>>  	return 0;
>>  }
>>
>> @@ -114,6 +131,8 @@ static int starfive_dwmac_probe(struct platform_device *pdev)
>>  	if (!dwmac)
>>  		return -ENOMEM;
>>
>> +	dwmac->data = device_get_match_data(&pdev->dev);
>> +
>>  	dwmac->clk_tx = devm_clk_get_enabled(&pdev->dev, "tx");
>>  	if (IS_ERR(dwmac->clk_tx))
>>  		return dev_err_probe(&pdev->dev, PTR_ERR(dwmac->clk_tx),
>> @@ -144,8 +163,13 @@ static int starfive_dwmac_probe(struct platform_device *pdev)
>>  	return stmmac_dvr_probe(&pdev->dev, plat_dat, &stmmac_res);
>>  }
>>
>> +static const struct starfive_dwmac_data jh7100_data = {
>> +	.gtxclk_dlychain = 4
> 
> Please add a , at the end of this line. I know it's unlikely that we need to
> add more properties, but it's still good practice to do. This way such patches
> won't need to touch this line.

Sure, will do.

>> +};
>> +
>>  static const struct of_device_id starfive_dwmac_match[] = {
>> -	{ .compatible = "starfive,jh7110-dwmac"	},
>> +	{ .compatible = "starfive,jh7100-dwmac", .data = &jh7100_data },
>> +	{ .compatible = "starfive,jh7110-dwmac" },
>>  	{ /* sentinel */ }
>>  };
>>  MODULE_DEVICE_TABLE(of, starfive_dwmac_match);
>> --
>> 2.42.0
>>

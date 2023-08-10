Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CBD87779DD
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 15:47:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235234AbjHJNrT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 09:47:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234000AbjHJNrR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 09:47:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D66FA212B
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 06:47:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6BFDB65CE9
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 13:47:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65E03C433C8;
        Thu, 10 Aug 2023 13:47:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691675235;
        bh=QkyBBRbhaAkBlqKoL0aRnLOyMswVogqYwOnrfamsuyI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=AyPw5yEFAHz2Y86hjai0dOH62HvASem+iQ1Gnh6MPraVhYC9FrPXveuwnF8+CI8ip
         kfe5BEc4clCP/zCrKuzm7hIXN7l04ukqxmHzRkh6tiIkcI7mxLQKfjB13/qyYtJmvG
         Wqw57Nm1mz/DlCoJryqUsIKza2yd+8VlfE+wyVP5Nm2lx7JAe187L688uFcgKqOhYz
         sNla0vRV+mqybIHhF0rg4FYi2qieMkIpLzpYPdoolH67vfQf3DUltLvLdurBFCF6G4
         HRVcXDqTaaV1QBD/u2OK6d/YsNEvtfVewprr3PO6NZYk/iaum6xlKCqCY7Chm4vSf9
         H4U5KF32ZWfwQ==
Message-ID: <0bea4002-8160-bebc-2243-c7d4044eb5ad@kernel.org>
Date:   Thu, 10 Aug 2023 22:47:12 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 2/9] mfd: max14577: Fix Wvoid-pointer-to-enum-cast warning
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Lee Jones <lee@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        patches@opensource.cirrus.com
Cc:     Andi Shyti <andi.shyti@kernel.org>
References: <20230810095849.123321-1-krzysztof.kozlowski@linaro.org>
 <20230810095849.123321-2-krzysztof.kozlowski@linaro.org>
From:   Chanwoo Choi <chanwoo@kernel.org>
In-Reply-To: <20230810095849.123321-2-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23. 8. 10. 18:58, Krzysztof Kozlowski wrote:
> 'dev_type' is an enum, thus cast of pointer on 64-bit compile test with
> W=1 causes:
> 
>   max14577.c:406:5: error: cast to smaller integer type 'enum maxim_device_type' from 'const void *' [-Werror,-Wvoid-pointer-to-enum-cast]
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  drivers/mfd/max14577.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/mfd/max14577.c b/drivers/mfd/max14577.c
> index 25ed8846b7fb..1f4f5002595c 100644
> --- a/drivers/mfd/max14577.c
> +++ b/drivers/mfd/max14577.c
> @@ -402,8 +402,7 @@ static int max14577_i2c_probe(struct i2c_client *i2c)
>  
>  		of_id = of_match_device(max14577_dt_match, &i2c->dev);
>  		if (of_id)
> -			max14577->dev_type =
> -				(enum maxim_device_type)of_id->data;
> +			max14577->dev_type = (uintptr_t)of_id->data;
>  	} else {
>  		max14577->dev_type = id->driver_data;
>  	}

Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>

-- 
Best Regards,
Samsung Electronics
Chanwoo Choi


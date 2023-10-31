Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BED847DCA6C
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 11:09:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236120AbjJaKJ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 06:09:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbjJaKJ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 06:09:56 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3676A1;
        Tue, 31 Oct 2023 03:09:53 -0700 (PDT)
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39V8stnD014473;
        Tue, 31 Oct 2023 11:09:26 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
        message-id:date:mime-version:subject:to:references:cc:from
        :in-reply-to:content-type:content-transfer-encoding; s=
        selector1; bh=4teyTP8wthQuYWyxvRw9scjnKMkSjcXFG9zTOb3dtFo=; b=y6
        8CxtLD2QDXlZmSTxJz9tLVRx+DWoFOzsd5deHSlX8594VX7dvCg8qSYgAnfF8dMl
        NTs8g0dh0aS1EB+xVbybXf0relr6lYKz7KKsuZSQVRCma/9+Dul8St+5YcTD+Rwm
        cLK1vG56vUjQcZ08zW91OwOe5F9ruIh/bD/02KErp/i2aqKhOW3vN7owjJYjwozA
        VwxCTTZ8oPx44BzUXDLn202iCqfgRswYNxem1vtzcrd8g0yHPzvnBr2xjMaFguFi
        A2oiwAxMMIDENUm3leymlwhcanqFxdZ4Ug+5i8BamxmRv4Je+F24pMNFSxsQLqk5
        MUvI5emzNnqD2IIIYklw==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3u29yanhrx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 Oct 2023 11:09:26 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 9D24A100050;
        Tue, 31 Oct 2023 11:09:21 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 8F76621ED27;
        Tue, 31 Oct 2023 11:09:21 +0100 (CET)
Received: from [10.201.20.136] (10.201.20.136) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 31 Oct
 2023 11:09:20 +0100
Message-ID: <77e47143-2351-4f78-81b6-35ed4664f358@foss.st.com>
Date:   Tue, 31 Oct 2023 11:09:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pinctrl: stm32: Add check for devm_kcalloc
Content-Language: en-US
To:     Chen Ni <nichen@iscas.ac.cn>, <linus.walleij@linaro.org>
References: <20231031080807.3600656-1-nichen@iscas.ac.cn>
CC:     <mcoquelin.stm32@gmail.com>, <alexandre.torgue@foss.st.com>,
        <robh@kernel.org>, <geert+renesas@glider.be>, <bero@baylibre.com>,
        <jernej.skrabec@gmail.com>, <dario.binacchi@amarulasolutions.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
From:   Valentin CARON <valentin.caron@foss.st.com>
In-Reply-To: <20231031080807.3600656-1-nichen@iscas.ac.cn>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.201.20.136]
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-30_13,2023-10-31_03,2023-05-22_02
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chen,

Thank you for your patch:

Acked-by: Valentin Caron <valentin.caron@foss.st.com>

Regards,
Valentin

On 10/31/23 09:08, Chen Ni wrote:
> Add check for the return value of devm_kcalloc() and return the error
> if it fails in order to avoid NULL pointer dereference.
>
> Fixes: 32c170ff15b0 ("pinctrl: stm32: set default gpio line names using pin names")
> Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
> ---
>   drivers/pinctrl/stm32/pinctrl-stm32.c | 5 +++++
>   1 file changed, 5 insertions(+)
>
> diff --git a/drivers/pinctrl/stm32/pinctrl-stm32.c b/drivers/pinctrl/stm32/pinctrl-stm32.c
> index a73385a431de..419eca49ccec 100644
> --- a/drivers/pinctrl/stm32/pinctrl-stm32.c
> +++ b/drivers/pinctrl/stm32/pinctrl-stm32.c
> @@ -1378,6 +1378,11 @@ static int stm32_gpiolib_register_bank(struct stm32_pinctrl *pctl, struct fwnode
>   	}
>   
>   	names = devm_kcalloc(dev, npins, sizeof(char *), GFP_KERNEL);
> +	if (!names) {
> +		err = -ENOMEM;
> +		goto err_clk;
> +	}
> +
>   	for (i = 0; i < npins; i++) {
>   		stm32_pin = stm32_pctrl_get_desc_pin_from_gpio(pctl, bank, i);
>   		if (stm32_pin && stm32_pin->pin.name)

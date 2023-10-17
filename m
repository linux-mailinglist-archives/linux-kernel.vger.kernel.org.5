Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C00DA7CBDEF
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 10:41:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234680AbjJQIl2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 04:41:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234620AbjJQIl1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 04:41:27 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4120F1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 01:41:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A93F6C433C7;
        Tue, 17 Oct 2023 08:41:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697532085;
        bh=muMzWO31TZ8A1A4Uzs0Bm4qdZrR4NRkH9zXXTuLMLdI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=NF6upC6YOuHt+7kdNf/9bjdjnrDoAb8KhWbnKYrvQHT/NcB6N7OMNimqy2z6+LdhC
         hKujVU+W4Nx8gfRVNRDsLh0o3lk8OJ168nZqsp+g2ViAFlUOoYace4wEy5OUCNl8ZH
         CDyAd/S35wh7D/ZCYWP+vGGC+rFDKCOkZRfDaZPtaX4sAabesqNHdXM/RVYfoGP90T
         egseLLmfAeR2sMSZyhQbmQ6222acAOvixHSeSs1s9q8tXtysAe/72CkCrFal3b0t5h
         j0HRv23rWVYOX1j3dkgK8JbBg4fdyAR/56gvGfUZ6eQe86m+ZwyUaoPwhoO4WZTWp4
         maceJuNBqcVKA==
Message-ID: <c2b7a88c-2a6d-49f6-974a-5f21915aea3c@kernel.org>
Date:   Tue, 17 Oct 2023 17:41:22 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH extcon-next] extcon: realtek: add the error handler for
 nvmem_cell_read
Content-Language: en-US
To:     Stanley Chang <stanley_chang@realtek.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
Cc:     Dan Carpenter <dan.carpenter@linaro.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        linux-kernel@vger.kernel.org
References: <20231016053510.28881-1-stanley_chang@realtek.com>
From:   Chanwoo Choi <chanwoo@kernel.org>
In-Reply-To: <20231016053510.28881-1-stanley_chang@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23. 10. 16. 14:35, Stanley Chang wrote:
> There are following smatch warning:
> drivers/extcon/extcon-rtk-type-c.c:905 __updated_type_c_parameter_by_efuse()
> error: 'buf' dereferencing possible ERR_PTR()
> 
> The nvmem_cell_read may fail to read. So, driver must handle failure cases.
> 
> Fixes: 8a590d7371f0 ("extcon: add Realtek DHC RTD SoC Type-C driver")
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Closes: https://lore.kernel.org/all/a469dd51-f5d5-4e8f-ba36-6c7cea046fb8@moroto.mountain/
> Signed-off-by: Stanley Chang <stanley_chang@realtek.com>
> ---
>  drivers/extcon/extcon-rtk-type-c.c | 86 +++++++++++++++---------------
>  1 file changed, 44 insertions(+), 42 deletions(-)
> 
> diff --git a/drivers/extcon/extcon-rtk-type-c.c b/drivers/extcon/extcon-rtk-type-c.c
> index 00465cfba23e..a592bab77538 100644
> --- a/drivers/extcon/extcon-rtk-type-c.c
> +++ b/drivers/extcon/extcon-rtk-type-c.c
> @@ -901,25 +901,26 @@ static int __updated_type_c_parameter_by_efuse(struct type_c_data *type_c)
>  		int value_mask = (BIT(value_size) - 1);
>  
>  		buf = nvmem_cell_read(cell, &buf_size);
> -
> -		cc1_0p2v = get_value((buf[0] >> value_size * 0) & value_mask);
> -		cc1_0p8v = get_value((buf[0] >> value_size * 1) & value_mask);
> -		cc1_2p6v = get_value((buf[1] >> value_size * 0) & value_mask);
> -		cc1_0p66v = get_value((buf[1] >> value_size * 1) & value_mask);
> -		cc1_1p23v = get_value((buf[2] >> value_size * 0) & value_mask);
> -
> -		cc2_0p2v = get_value((buf[3] >> value_size * 0) & value_mask);
> -		cc2_0p8v = get_value((buf[3] >> value_size * 1) & value_mask);
> -		cc2_2p6v = get_value((buf[4] >> value_size * 0) & value_mask);
> -		cc2_0p66v = get_value((buf[4] >> value_size * 1) & value_mask);
> -		cc2_1p23v = get_value((buf[5] >> value_size * 0) & value_mask);
> -
> -		cc1_4p7k = get_value((buf[6] >> value_size * 0) & value_mask);
> -		cc1_12k = get_value((buf[6] >> value_size * 1) & value_mask);
> -		cc2_4p7k = get_value((buf[7] >> value_size * 0) & value_mask);
> -		cc2_12k = get_value((buf[7] >> value_size * 1) & value_mask);
> -
> -		kfree(buf);
> +		if (!IS_ERR(buf)) {
> +			cc1_0p2v = get_value((buf[0] >> value_size * 0) & value_mask);
> +			cc1_0p8v = get_value((buf[0] >> value_size * 1) & value_mask);
> +			cc1_2p6v = get_value((buf[1] >> value_size * 0) & value_mask);
> +			cc1_0p66v = get_value((buf[1] >> value_size * 1) & value_mask);
> +			cc1_1p23v = get_value((buf[2] >> value_size * 0) & value_mask);
> +
> +			cc2_0p2v = get_value((buf[3] >> value_size * 0) & value_mask);
> +			cc2_0p8v = get_value((buf[3] >> value_size * 1) & value_mask);
> +			cc2_2p6v = get_value((buf[4] >> value_size * 0) & value_mask);
> +			cc2_0p66v = get_value((buf[4] >> value_size * 1) & value_mask);
> +			cc2_1p23v = get_value((buf[5] >> value_size * 0) & value_mask);
> +
> +			cc1_4p7k = get_value((buf[6] >> value_size * 0) & value_mask);
> +			cc1_12k = get_value((buf[6] >> value_size * 1) & value_mask);
> +			cc2_4p7k = get_value((buf[7] >> value_size * 0) & value_mask);
> +			cc2_12k = get_value((buf[7] >> value_size * 1) & value_mask);
> +
> +			kfree(buf);
> +		}
>  		nvmem_cell_put(cell);
>  	}
>  
> @@ -984,29 +985,30 @@ static int __updated_type_c_parameter_by_efuse_v2(struct type_c_data *type_c)
>  		int value_mask = (BIT(value_size) - 1);
>  
>  		buf = nvmem_cell_read(cell, &buf_size);
> -
> -		value_size = 5;
> -		value_mask = (BIT(value_size) - 1);
> -		cc1_4p7k = buf[0] & value_mask;
> -		cc1_12k = buf[1] & value_mask;
> -		cc2_4p7k = buf[2] & value_mask;
> -		cc2_12k = buf[3] & value_mask;
> -
> -		value_size = 4;
> -		value_mask = (BIT(value_size) - 1);
> -		cc1_0p2v = (buf[4] >> value_size * 0) & value_mask;
> -		cc1_0p66v = (buf[4] >> value_size * 1) & value_mask;
> -		cc1_0p8v = (buf[5] >> value_size * 0) & value_mask;
> -		cc1_1p23v = (buf[5] >> value_size * 1) & value_mask;
> -		cc1_2p6v = (buf[6] >> value_size * 0) & value_mask;
> -
> -		cc2_0p2v = (buf[6] >> value_size * 1) & value_mask;
> -		cc2_0p66v = (buf[7] >> value_size * 0) & value_mask;
> -		cc2_0p8v = (buf[7] >> value_size * 1) & value_mask;
> -		cc2_1p23v = (buf[8] >> value_size * 0) & value_mask;
> -		cc2_2p6v = (buf[8] >> value_size * 1) & value_mask;
> -
> -		kfree(buf);
> +		if (!IS_ERR(buf)) {
> +			value_size = 5;
> +			value_mask = (BIT(value_size) - 1);
> +			cc1_4p7k = buf[0] & value_mask;
> +			cc1_12k = buf[1] & value_mask;
> +			cc2_4p7k = buf[2] & value_mask;
> +			cc2_12k = buf[3] & value_mask;
> +
> +			value_size = 4;
> +			value_mask = (BIT(value_size) - 1);
> +			cc1_0p2v = (buf[4] >> value_size * 0) & value_mask;
> +			cc1_0p66v = (buf[4] >> value_size * 1) & value_mask;
> +			cc1_0p8v = (buf[5] >> value_size * 0) & value_mask;
> +			cc1_1p23v = (buf[5] >> value_size * 1) & value_mask;
> +			cc1_2p6v = (buf[6] >> value_size * 0) & value_mask;
> +
> +			cc2_0p2v = (buf[6] >> value_size * 1) & value_mask;
> +			cc2_0p66v = (buf[7] >> value_size * 0) & value_mask;
> +			cc2_0p8v = (buf[7] >> value_size * 1) & value_mask;
> +			cc2_1p23v = (buf[8] >> value_size * 0) & value_mask;
> +			cc2_2p6v = (buf[8] >> value_size * 1) & value_mask;
> +
> +			kfree(buf);
> +		}
>  		nvmem_cell_put(cell);
>  	}
>  

Applied it. Thanks.

-- 
Best Regards,
Samsung Electronics
Chanwoo Choi


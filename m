Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 872D17BBB60
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 17:11:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232677AbjJFPLa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 11:11:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230223AbjJFPL2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 11:11:28 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 531F4A6
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 08:11:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81E09C433C7;
        Fri,  6 Oct 2023 15:11:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696605084;
        bh=LZnilnoe+K2Y8QA22xh+sRmT3aVbXviQEKDD75nXatU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=qs+yDxIC0K5vFz2AyjtNVOe5RbHg3gTV0filMY/TKLjs8mPBw7btjSbgZCYfl/c0c
         rsflS20J7CPtXZZDDtiSOY4+yawj6xa6GCymE3YJei5nxEDEVEMZWkAc30tL4mChEs
         nGsm03JelGlbY7D0Bo/ou0mOFcd+imjajriRjAtciuZGy+z5sx5fFJSc3K3goeBzpU
         +N9jAY18eECFjf0ohEbSYsCNqIdIyisEUIl2ZiMsjSru5A6cUwyLyBC6OjXp4E0Puu
         4xMBcuhgNoz47MdSCa5CZ/ioLUS+u7IYECMAuMehpdPiog3EWPIufsKcZajnkEo53+
         c18WVYU3PCDrA==
Message-ID: <a557b83a-758f-e84f-bfe1-bba1b10b14a9@kernel.org>
Date:   Sat, 7 Oct 2023 00:11:24 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2 1/2] extcon: max77693: add device-tree compatible
 string
Content-Language: en-US
To:     Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-kernel@vger.kernel.org
Cc:     Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>
References: <CGME20231006100441eucas1p1642aee6baa9713864274aa254f4b5116@eucas1p1.samsung.com>
 <20231006100434.2908243-1-m.szyprowski@samsung.com>
From:   Chanwoo Choi <chanwoo@kernel.org>
In-Reply-To: <20231006100434.2908243-1-m.szyprowski@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23. 10. 6. 19:04, Marek Szyprowski wrote:
> Commit 57f706bf7307 ("ARM: dts: samsung: exynos4412-midas: add USB
> connector and USB OTG") added a 'muic' node to the MAX77693 PMIC
> definition in various device-tree files. Since that commit, the newly
> created MFD cell gained its own of_node and compatible string. This
> changed its modalias, what in turn broke automated loading of the driver
> module, because the new modalias is based on the of_node compatible
> string, not the platform device name.
> 
> Fix this by adding the needed device-tree compatible string.
> 
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>  drivers/extcon/extcon-max77693.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/extcon/extcon-max77693.c b/drivers/extcon/extcon-max77693.c
> index 1f1d9ab0c5c7..2c567e0b7b7f 100644
> --- a/drivers/extcon/extcon-max77693.c
> +++ b/drivers/extcon/extcon-max77693.c
> @@ -1258,9 +1258,16 @@ static int max77693_muic_probe(struct platform_device *pdev)
>  	return ret;
>  }
>  
> +static const struct of_device_id of_max77693_muic_dt_match[] = {
> +	{ .compatible = "maxim,max77693-muic", },
> +	{ /* sentinel */ },
> +};
> +MODULE_DEVICE_TABLE(of, of_max77693_muic_dt_match);
> +
>  static struct platform_driver max77693_muic_driver = {
>  	.driver		= {
>  		.name	= DEV_NAME,
> +		.of_match_table = of_max77693_muic_dt_match,
>  	},
>  	.probe		= max77693_muic_probe,
>  };


Applied it. Thanks.

-- 
Best Regards,
Samsung Electronics
Chanwoo Choi


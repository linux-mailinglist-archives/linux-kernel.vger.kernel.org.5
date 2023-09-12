Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A95E479D8A1
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 20:24:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237411AbjILSYR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 14:24:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237394AbjILSYN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 14:24:13 -0400
Received: from smtp.smtpout.orange.fr (smtp-29.smtpout.orange.fr [80.12.242.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BA1110EF
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 11:24:09 -0700 (PDT)
Received: from [192.168.1.18] ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id g83RqRmrEiBkug83RqO2gs; Tue, 12 Sep 2023 20:24:07 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1694543048;
        bh=BwabbmNDfoIMMoHR0PGecCbV9RImTYt/EdYJHgvIvUQ=;
        h=Date:Subject:From:To:References:In-Reply-To;
        b=OX266sJkHDWwgsJE5jCRB/QTRp50ddmqYY9P8Ul1ifjJBVPIxR4PPvO2+5UeejbxO
         mZmBNovtlnpkwro8LTEixZeQcqDYt3KlaH5rguQcmSnJSswX4B7vWyIjRdbI/FsxTE
         PJz5/a4gpD7QYUInCrAGGHKPNgqxYfDaxy0dLXgPspYNIwVRQlbuv1TaNSsq+3IaNS
         GGpr7heMMJ4G93QQ1SjuBDVCdzixU7vyr9WhecfI19T9kkmakyxeJzUEpv0ShVloC1
         IEZWX9woPVmVwgs+T8/cT5WuPo+BBDvm6fYMENko4biUvv3oEHGSp3Vzne7/BAjbsu
         TYSBRyEpgnGVg==
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Tue, 12 Sep 2023 20:24:07 +0200
X-ME-IP: 86.243.2.178
Message-ID: <dec51c56-9169-d0f0-bdcd-e99790a7d86a@wanadoo.fr>
Date:   Tue, 12 Sep 2023 20:24:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v3 4/5] clk: twl: add clock driver for TWL6032
Content-Language: fr
From:   Marion & Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Andreas Kemnade <andreas@kemnade.info>, dmitry.torokhov@gmail.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, lee@kernel.org, bcousson@baylibre.com,
        tony@atomide.com, mturquette@baylibre.com, sboyd@kernel.org,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-clk@vger.kernel.org
References: <20230911221346.1484543-1-andreas@kemnade.info>
 <20230911221346.1484543-5-andreas@kemnade.info>
 <a9b646c7-2c02-8a69-a4c8-7e981a630eef@wanadoo.fr>
In-Reply-To: <a9b646c7-2c02-8a69-a4c8-7e981a630eef@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 12/09/2023 à 19:15, Christophe JAILLET a écrit :
> Le 12/09/2023 à 00:13, Andreas Kemnade a écrit :
>> The TWL6032 has some clock outputs which are controlled like
>> fixed-voltage regulators, in some drivers for these chips
>> found in the wild, just the regulator api is abused for controlling
>> them, so simply use something similar to the regulator functions.
>> Due to a lack of hardware available for testing, leave out the
>> TWL6030-specific part of those functions.
>>
>> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
>> ---
>>   drivers/clk/Kconfig   |   9 ++
>>   drivers/clk/Makefile  |   1 +
>>   drivers/clk/clk-twl.c | 197 ++++++++++++++++++++++++++++++++++++++++++
>>   3 files changed, 207 insertions(+)
>>   create mode 100644 drivers/clk/clk-twl.c
>>
> 
> ...
> 
>> +static int twl_clks_probe(struct platform_device *pdev)
>> +{
>> +    struct clk_hw_onecell_data *clk_data;
>> +    const struct twl_clks_data *hw_data;
>> +
>> +    struct twl_clock_info *cinfo;
>> +    int ret;
>> +    int i;
>> +    int count;
>> +
>> +    hw_data = twl6032_clks;
>> +    for (count = 0; hw_data[count].init.name; count++)
>> +        ;
> 
> Nit: does removing the /* sentinel */ and using 
> ARRAY_SIZE(twl_clks_data) would make sense and be simpler?
> 
> CJ
> 
>> +
>> +    clk_data = devm_kzalloc(&pdev->dev,
>> +                struct_size(clk_data, hws, count),
>> +                GFP_KERNEL);
>> +    if (!clk_data)
>> +        return -ENOMEM;
>> +
>> +    clk_data->num = count;
>> +    cinfo = devm_kcalloc(&pdev->dev, count, sizeof(*cinfo), GFP_KERNEL);
>> +    if (!cinfo)
>> +        return -ENOMEM;
>> +
>> +    for (i = 0; i < count; i++) {
>> +        cinfo[i].base = hw_data[i].base;
>> +        cinfo[i].dev = &pdev->dev;
>> +        cinfo[i].hw.init = &hw_data[i].init;
>> +        ret = devm_clk_hw_register(&pdev->dev, &cinfo[i].hw);
>> +        if (ret) {
>> +            dev_err(&pdev->dev, "Fail to register clock %s, %d\n",
>> +                hw_data[i].init.name, ret);
>> +            return ret;
>> +        }
>> +        clk_data->hws[i] = &cinfo[i].hw;
>> +    }
>> +
>> +    ret = devm_of_clk_add_hw_provider(&pdev->dev,
>> +                      of_clk_hw_onecell_get, clk_data);
>> +    if (ret < 0)
>> +        dev_err(&pdev->dev, "Fail to add clock driver, %d\n", ret);
>> +
>> +    return ret;
> 
> Nit: should there be a V4, some prefer return 0 to be more explicit.

Oops, no, or a "return ret;" should be added as well a few lines above
(it would more future proof, so)

> 
>> +}
> 
> ...
> 
> 

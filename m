Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 573637DC73B
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 08:25:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343716AbjJaHZV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 03:25:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236654AbjJaHZG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 03:25:06 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1331EC2
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 00:25:03 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-9d224dca585so386936066b.1
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 00:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1698737101; x=1699341901; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Yjxq8E7gNPB9bFCXU5zCmu0wTmIMA9QI7im5HIAGob8=;
        b=UDnBLsrtcgKp5mOUD4ecc0dAOd3RJlcwFDNGlrzk6roVkb4SMOz6fOy5llcqV8+LRs
         QExgROkLruoMEOZKOtmazcUJazusLavMTqgr+/zjHi3qnuUQumzTQfs+e6+yvZZA6h/9
         7EViawuiKBERIA9HiNSH1PnJm1h7fyWiCEpgujnGDAFOUzrpATVXgmmZN1I3truXWvVr
         7JpIAKFTgZSotkShgvxpc6kKNfxm3UlgSgksDJJ4BJmiIdc4nFpzbtF4iaNrSfGmQ9u2
         JeJI3bRdFktDsWtJ0u10BgVOLFkWRGh+3mqiIxI8BIBwCfTuXLRpOHRZjr/yhg1MLMLb
         5c4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698737101; x=1699341901;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Yjxq8E7gNPB9bFCXU5zCmu0wTmIMA9QI7im5HIAGob8=;
        b=mafNlSlwboxBHwOAzbrhYgnRuxEmvXfZWpdbL1y9px16GB5oq0AxWPrUo3uoAWfUbb
         VyDPogmAnJcgWtuWl7WT1IfOdon+0y22k3yhdAnq8W4nTlv4BUN2nzo7qDmCTELnpnC/
         J58URgeAllTRf9tEOvCu1io5bs5BxIyxjZXcxqWMdpVmbonvTVYkwt+Ta78D0Ucg9IVh
         grjXZjuQDlNMS+orYoemoIhWxkzwbWsEvajRYx09vnyBWDi7Gm5pfIgqi414v820fxAX
         yqkMSuvWCbPoDLk0h+QkBXRiym6a8TXcRM4GpcIF1g7JZJE5+C7UIyPm/Uytj9d5D3rm
         s6aQ==
X-Gm-Message-State: AOJu0Yym3qUaVRQIhBap36GwDAQAlCq4QBRkpXA4SavvV3DZBtLov/+1
        +9dPmUTGMs2qVs1ylLLco49hSQ==
X-Google-Smtp-Source: AGHT+IGus17rAhpSQfGY8ZFCpaGrrZP3x/TVDAb5d+Mu4tTL5tpzmnsjSSEyrRdZtvyfw5pG3ZLGgQ==
X-Received: by 2002:a17:907:3184:b0:9c5:844f:a7f4 with SMTP id xe4-20020a170907318400b009c5844fa7f4mr9965783ejb.35.1698737101232;
        Tue, 31 Oct 2023 00:25:01 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.98])
        by smtp.gmail.com with ESMTPSA id w3-20020a170906d20300b009b28ad521f4sm478828ejz.4.2023.10.31.00.25.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Oct 2023 00:25:00 -0700 (PDT)
Message-ID: <48467507-877c-4789-85a9-932b0e79ed79@tuxon.dev>
Date:   Tue, 31 Oct 2023 09:24:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ti: fix possible memory leak in
 _ti_omap4_clkctrl_setup()
Content-Language: en-US
To:     Hangyu Hua <hbh25y@gmail.com>, kristo@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org, tony@atomide.com,
        dario.binacchi@amarulasolutions.com, claudiu.beznea@microchip.com,
        robh@kernel.org, andriy.shevchenko@linux.intel.com
Cc:     linux-omap@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20231027025057.11510-1-hbh25y@gmail.com>
From:   claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20231027025057.11510-1-hbh25y@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 27.10.2023 05:50, Hangyu Hua wrote:
> kstrndup() and kstrdup_and_replace() in clkctrl_get_name() can perform
> dynamic memory allocation. So clkctrl_name() needs to be freed when

s/clkctrl_name()/clkctrl_name

> provider->clkdm_name is NULL.
> 
> Fixes: bd46cd0b802d ("clk: ti: clkctrl: check return value of kasprintf()")
> Signed-off-by: Hangyu Hua <hbh25y@gmail.com>
> ---
> 
> 	v2: fix commit info.
> 
>  drivers/clk/ti/clkctrl.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/clk/ti/clkctrl.c b/drivers/clk/ti/clkctrl.c
> index 607e34d8e289..cb4aa8a45bb2 100644
> --- a/drivers/clk/ti/clkctrl.c
> +++ b/drivers/clk/ti/clkctrl.c
> @@ -591,6 +591,7 @@ static void __init _ti_omap4_clkctrl_setup(struct device_node *node)
>  		provider->clkdm_name = kasprintf(GFP_KERNEL,
>  						 "%s_clkdm", clkctrl_name);
>  		if (!provider->clkdm_name) {
> +			kfree(clkctrl_name);
>  			kfree(provider);
>  			return;
>  		}

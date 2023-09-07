Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C2397973DB
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 17:33:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238396AbjIGPbu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 11:31:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240265AbjIGPaf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 11:30:35 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B26D1700;
        Thu,  7 Sep 2023 08:30:09 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id B2EEE66072BA;
        Thu,  7 Sep 2023 11:43:14 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1694083395;
        bh=AtNfCg0ORcDFoK5Walc1Hu3UGCme85N5dgstHaeabAc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=NejBNi91GDBi0Au8P24t4H4LZjQGG9Ryf1BpDJdsXgET3EkPKMCZFUG7BCYuxsp0A
         L5J666GBfK2HyOu6yTaz/Zdt9srJi+5RKfsPZV35jTt1DuIjOV5nERNjqPd61FOF9M
         1HiviQkDD472ch4zIdW+FtQekf0Fqf3SaP8d0MbPWgZ0QpNRuBKobGhS7xydNgFhgX
         uUE0F5MmxWTv8He1c0FXyZ6t8nMYMInIUVo0N72Mqo1KXMOA4MxZJJvh5lfKIFp7+p
         X7z5G8hFmmvlxMnVt4LcbxoOqjM8OW9eDq+vbWzlIYRdMbQnJ7STxw4HIqlaHsKBtK
         d2YAIXSKPE/tQ==
Message-ID: <cd6eea67-df0f-08b1-61cd-57a3b4f9cf0d@collabora.com>
Date:   Thu, 7 Sep 2023 12:43:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH] power: supply: mt6370: Fix missing error code in
 mt6370_chg_toggle_cfo()
Content-Language: en-US
To:     Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
        Sebastian Reichel <sre@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        ChiaEn Wu <chiaen_wu@richtek.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Cc:     dan.carpenter@linaro.org, kernel-janitors@vger.kernel.org,
        error27@gmail.com
References: <20230906084815.2827930-1-harshit.m.mogalapalli@oracle.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230906084815.2827930-1-harshit.m.mogalapalli@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 06/09/23 10:48, Harshit Mogalapalli ha scritto:
> When mt6370_chg_field_get() suceeds, ret is set to zero and returning
> zero when flash led is still in strobe mode looks incorrect.
> 
> Fixes: 233cb8a47d65 ("power: supply: mt6370: Add MediaTek MT6370 charger driver")
> Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
> ---
> This is based on static analysis with smatch, only compile tested.
> ---
>   drivers/power/supply/mt6370-charger.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/power/supply/mt6370-charger.c b/drivers/power/supply/mt6370-charger.c
> index f27dae5043f5..a9641bd3d8cf 100644
> --- a/drivers/power/supply/mt6370-charger.c
> +++ b/drivers/power/supply/mt6370-charger.c
> @@ -324,7 +324,7 @@ static int mt6370_chg_toggle_cfo(struct mt6370_priv *priv)
>   
>   	if (fl_strobe) {
>   		dev_err(priv->dev, "Flash led is still in strobe mode\n");
> -		return ret;
> +		return -EINVAL;

I think that returning 0 here was intentional, but I agree on a return ret
here being both confusing and wrong.

That's how I get this logic:

The function is enabling strobe mode, but if the flash led is *already* in
strobe mode, the function exits cleanly because there's nothing to do, as
the enablement is already done.

Hence.... I believe that the right fix is not to return -EINVAL, but rather
to change that to `return 0` instead.

ChiaEn, can you please confirm, or deny my statement?

Regards,
Angelo

>   	}
>   
>   	/* cfo off */



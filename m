Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E586476E725
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 13:41:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235199AbjHCLlV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 07:41:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232651AbjHCLlS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 07:41:18 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52E8E26B2;
        Thu,  3 Aug 2023 04:41:17 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-4fe2d152f62so1506075e87.0;
        Thu, 03 Aug 2023 04:41:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691062875; x=1691667675;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1uUnmAhTsZuhS+3ah8RYgvZnDDiykSMehCW3D3I97ZY=;
        b=HblaFfRw7jzMnSvTX66pI8NNsF9Sq1zVY2YsxJXDmlBlMrxxj5C3WOoy3XcGfFb+tB
         sMGdJVczOcJaG8RRRQE+82A/dvpZEquhEYEjvmqpp3MisfjP81TlnCrF4JzvI6dUiqTL
         wuRIYmssfikf2JGLXLTUHGeDNlnIxtdWPgRnrTK7r6OMJqMM+UlVHu010gHrel4nWgwA
         m6VW8SytRgBEaI2THu8PFxiM0b4oLhbA3NaGZZ03LZqiileGARvNcc5e6Iwck6jYq4O+
         23nrxzHhzaSirc+5fMubUzFWIjVAgIjax3Q4lIGiABjkXy+kDPtdF0zx34Yi1yDbYTZ3
         P6kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691062875; x=1691667675;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1uUnmAhTsZuhS+3ah8RYgvZnDDiykSMehCW3D3I97ZY=;
        b=gBzL4tqCViouPJm6k/Jv9+LIIJpDPDJcucVwCE9mC2EkfU2fx3HBpdwzMMSbqFWWaX
         wqM56lENj0JxCb/HpLFYk00lD7cd9lAXQqa9QBnxwAmV1DeDiP9d8e5uScybv4ntIPbd
         uwRCKlF666/uQ9AiEZ4qsaQ/hHW0eQD9aAs9n+Wjw81FoUwju7oyYeeFMNUJNYrh6Dwk
         TlUR61lO/S19Ffl+UkTkSjYbhpoXjaQSp7EtZXzL3RAO9jLUtbqLgqkiNvtH5SFMtmg8
         T7oUX+SDIeL9z7tzWtLRXtaj/mf1aM4c2E6ZAk2BLBK2tzXEt8MhbMLDudmLtOEaVcbp
         psAA==
X-Gm-Message-State: ABy/qLYXNXepcWhaWBA0UUOmXfmC1hLjL5n944818I+A9vfGFqWreh2q
        Ksc6W278XD+jO8BQoeNmIhXdOtu6lXA=
X-Google-Smtp-Source: APBJJlH9RYeJH2vshOJEZj5JBHthnRRgTZtVKmPtIh2Jt5/fK965/zYZjmANKYPeFqVpleXqltxn1Q==
X-Received: by 2002:a19:921a:0:b0:4fd:fafd:1ed4 with SMTP id u26-20020a19921a000000b004fdfafd1ed4mr5883527lfd.2.1691062874911;
        Thu, 03 Aug 2023 04:41:14 -0700 (PDT)
Received: from [192.168.1.103] ([178.176.75.73])
        by smtp.gmail.com with ESMTPSA id w3-20020ac25983000000b004fba5eb0a64sm3316499lfn.42.2023.08.03.04.41.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Aug 2023 04:41:14 -0700 (PDT)
Subject: Re: [PATCH -next v2] usb: musb: Do not check 0 for
 platform_get_irq_byname()
To:     Zhu Wang <wangzhu9@huawei.com>, b-liu@ti.com,
        gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230803113121.77273-1-wangzhu9@huawei.com>
From:   Sergei Shtylyov <sergei.shtylyov@gmail.com>
Message-ID: <de55bcc0-ca9e-7a97-1591-9b2308fa26a0@gmail.com>
Date:   Thu, 3 Aug 2023 14:41:13 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20230803113121.77273-1-wangzhu9@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/3/23 2:31 PM, Zhu Wang wrote:

> When platform_get_irq_byname() is called to get a interrupt number, it
> may return -EINVAL or -ENXIO when failed, while current code returned

   You still don't mention -EPROBE_DEFER. Propagating it upstream is
the _main_ reason we must not override what platform_get_irq_byname()
returns!

> -ENODEV, so we replace it with the return value of
> platform_get_irq_byname(). And we found that platform_get_irq_byname()
> never returned zero by reading its code.

   It used to return 0 (as both IRQ0 and the error indication).
Historically, there were several patches fixing the inconsistencies...

> Commit ce753ad1549c ("platform: finally disallow IRQ0 in
> platform_get_irq() and its ilk") makes sure IRQ0 is not returned.
> 
> Signed-off-by: Zhu Wang <wangzhu9@huawei.com>
> 
> ---
> Changes in v2:
> - Update the commit message, present the reason of replacing the return
> value of the probe.
> ---
>  drivers/usb/musb/musb_core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
> index ecbd3784bec3..b24adb5b399f 100644
> --- a/drivers/usb/musb/musb_core.c
> +++ b/drivers/usb/musb/musb_core.c
> @@ -2610,8 +2610,8 @@ static int musb_probe(struct platform_device *pdev)
>  	int		irq = platform_get_irq_byname(pdev, "mc");
>  	void __iomem	*base;
>  
> -	if (irq <= 0)
> -		return -ENODEV;
> +	if (irq < 0)
> +		return irq;
>  
>  	base = devm_platform_ioremap_resource(pdev, 0);
>  	if (IS_ERR(base))
> 


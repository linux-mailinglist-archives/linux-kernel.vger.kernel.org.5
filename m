Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39F11769918
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 16:10:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231974AbjGaOKr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 10:10:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231629AbjGaOKo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 10:10:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEAC71716
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 07:09:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690812590;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=l+Mv5r6t8pSNTy6u7u7r06N3KDg61cGhEe9E1jY0jkI=;
        b=daqE8zc24Dgw7t9kJw1Yx4CYN6Ot24eKAX50m1CKHX8PIgbRv1uYluEVDwroskIx7E1tVZ
        u2EzoMfcXhANkfayW0P+JFnyv+cWItTE6B8cDBzoWKHZe1RqquKeXKf8EmLf62T5avmGOQ
        j28GblU+eQHAGrioym7BJgnImtqB6hA=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-557-7lSF6NPMM9OGk2ChR5Av2g-1; Mon, 31 Jul 2023 10:09:48 -0400
X-MC-Unique: 7lSF6NPMM9OGk2ChR5Av2g-1
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-76c95663db4so216888685a.0
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 07:09:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690812587; x=1691417387;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l+Mv5r6t8pSNTy6u7u7r06N3KDg61cGhEe9E1jY0jkI=;
        b=USaJhcU3yd5CzMRLe6RBKWrfTGLLu0jH4TKA1BECBW7jBkOcQIJ45g9YgJcZqgHj0p
         ttdu1V/tvB3TmzZXHf0lB7lzoUx0DSr/biTFN6waaz9SaThlCvCCdKaGLzi/+niyci4z
         nvGBASCgvqcpe+dPQ4tGznvFr5Acate5Vc9jlFKSyo/foPyfIt+OTLRnu0vKz+uxbl2q
         5Rx+fdCZHPIKPoV5GB7Qmp2olOIW0dIR+E+7eUhQKbdXuUhD1WfiVJvHXmIyK3fjkepp
         gx0U8VzpMFYhcXBC5wyK5X+9ECg7Ps0kKMa3W58Wpi3TDmtvXpTKBvZeUO9XLI5FU78c
         qfOA==
X-Gm-Message-State: ABy/qLYbC/zPA/iQ5Cap9UsbCTUniHs0H+Aivrk6U0YUarWdWrFtGTjU
        RGsD77S3TM+qj4SQd7B19pmPJzCoh2K0GflWK/lIkTVdSzz8lB4VU1134BkNTXjz71iXRjUiuvj
        Pq2AmsxRgUaxiag8dZXHUjb3B
X-Received: by 2002:a05:620a:4727:b0:765:3e81:e74c with SMTP id bs39-20020a05620a472700b007653e81e74cmr11407595qkb.21.1690812587625;
        Mon, 31 Jul 2023 07:09:47 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHIB/WwtEub8ysCiYcNlnMAPnvf2FYgsJFgo7Z+WgYzFftVBdtNg6b6tXRvs2eiCYRKYRnpNA==
X-Received: by 2002:a05:620a:4727:b0:765:3e81:e74c with SMTP id bs39-20020a05620a472700b007653e81e74cmr11407577qkb.21.1690812587414;
        Mon, 31 Jul 2023 07:09:47 -0700 (PDT)
Received: from [10.40.98.142] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id 22-20020a05620a06d600b00767ceac979asm3318877qky.42.2023.07.31.07.09.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Jul 2023 07:09:40 -0700 (PDT)
Message-ID: <7a28e9aa-46a1-e072-2101-5392cd21a5f0@redhat.com>
Date:   Mon, 31 Jul 2023 16:09:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v3 1/3] platform/x86: wmi-bmof: Use
 device_create_bin_file()
Content-Language: en-US
To:     Armin Wolf <W_Armin@gmx.de>, markgross@kernel.org, thomas@t-8ch.de
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230730204550.3402-1-W_Armin@gmx.de>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20230730204550.3402-1-W_Armin@gmx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 7/30/23 22:45, Armin Wolf wrote:
> Use device_create_bin_file() instead of sysfs_create_bin_file()
> to avoid having to access the device kobject.
> 
> Tested on a ASUS PRIME B650-PLUS.
> 
> Reviewed-by: Thomas Weißschuh <linux@weissschuh.net>
> Tested-by: Thomas Weißschuh <linux@weissschuh.net>
> Signed-off-by: Armin Wolf <W_Armin@gmx.de>

Thank you for your patch-series, I've applied the series to my
review-hans branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans

Note it will show up in my review-hans branch once I've pushed my
local branch there, which might take a while.

Once I've run some tests on this branch the patches there will be
added to the platform-drivers-x86/for-next branch and eventually
will be included in the pdx86 pull-request to Linus for the next
merge-window.

Regards,

Hans



> ---
> Changes since v1:
> - add Reviewed-by and Tested-by tags
> ---
>  drivers/platform/x86/wmi-bmof.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/platform/x86/wmi-bmof.c b/drivers/platform/x86/wmi-bmof.c
> index 80137afb9753..d0516cacfcb5 100644
> --- a/drivers/platform/x86/wmi-bmof.c
> +++ b/drivers/platform/x86/wmi-bmof.c
> @@ -75,7 +75,7 @@ static int wmi_bmof_probe(struct wmi_device *wdev, const void *context)
>  	priv->bmof_bin_attr.read = read_bmof;
>  	priv->bmof_bin_attr.size = priv->bmofdata->buffer.length;
> 
> -	ret = sysfs_create_bin_file(&wdev->dev.kobj, &priv->bmof_bin_attr);
> +	ret = device_create_bin_file(&wdev->dev, &priv->bmof_bin_attr);
>  	if (ret)
>  		goto err_free;
> 
> @@ -90,7 +90,7 @@ static void wmi_bmof_remove(struct wmi_device *wdev)
>  {
>  	struct bmof_priv *priv = dev_get_drvdata(&wdev->dev);
> 
> -	sysfs_remove_bin_file(&wdev->dev.kobj, &priv->bmof_bin_attr);
> +	device_remove_bin_file(&wdev->dev, &priv->bmof_bin_attr);
>  	kfree(priv->bmofdata);
>  }
> 
> --
> 2.39.2
> 


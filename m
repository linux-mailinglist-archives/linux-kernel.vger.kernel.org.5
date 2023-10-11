Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 693287C4E68
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 11:22:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231318AbjJKJWD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 05:22:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232254AbjJKJVw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 05:21:52 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22BDE94
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 02:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697016063;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9BZXi3cafQaZM1r+FnoQIQdzrRAZwPqZTTE72dK+CCg=;
        b=CrqP30dnu4E3K5cgoaU4Q3PVDw85JixBrxnbkj1jdLsOxntpqAIK5yKVKIvFnnd27PMShT
        7bK5ayBPOS49E1pwcaBOiy9skBlG2BBTlzm0Q0rMDauEr85CEpc/hFUW2sPm8q5SCIc8I/
        jWCa5scpPmHhbtZIVGgKAWe5wvAIf0Y=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-479-dzI_yl1mNOqkb9otmmdX1g-1; Wed, 11 Oct 2023 05:21:01 -0400
X-MC-Unique: dzI_yl1mNOqkb9otmmdX1g-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-9bd7c682b33so45059566b.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 02:21:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697016061; x=1697620861;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9BZXi3cafQaZM1r+FnoQIQdzrRAZwPqZTTE72dK+CCg=;
        b=wK7sZmayUZukXGy+yK0r0lc9sFE0VQyGz8u4JxbvZcUvB5G5zPpPYjkpoOnMbNkVtV
         jbsp4lPjPfHP0ZAtzhjV6stya6+rnVf1hH33t8dk625X9TyvUM3XkF3Ir5uHb9/zIgg6
         /peNwqfGzkCAY8GOwbe7HB2KCC6KW2f8F+K8C/hHx3OgWMQt4ZF+rnxGkzQ3WZhj32aL
         1XkjjprlTGkkiK20fUA0lvwLRJBiYB/fqL4R+YPLzQr7TqdPWmCiF7GfT3Ty0IQ6THJj
         bOU7DDVV38uSMoY44pEzWq/bXlOXbCDiNR6q994Q+Fv/2EXxzDNulMNgzfCD39tA5dy1
         KyDA==
X-Gm-Message-State: AOJu0YwPC77LEzUbR6NahfPun7DD7HJz1iqKA6VnUC7NvIfEcuFmSypT
        /UjBHuRw6bzV41KEbvbp7r/mhSckhtibpnCGSgG0l67BfzMuAh6J8gyMMOTY6Tm61AJ2pUCVrqk
        XNr/QVLOIe1wF05eADQ5rtSu5
X-Received: by 2002:a17:906:9c2:b0:9b2:82d2:a2db with SMTP id r2-20020a17090609c200b009b282d2a2dbmr17041504eje.28.1697016060828;
        Wed, 11 Oct 2023 02:21:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEIjE+vexgTdNocqUzGGts3lwcP8EtemggX4M6VYGYIKEYQL3MCjAYljc3FXQT/OnohfklGDw==
X-Received: by 2002:a17:906:9c2:b0:9b2:82d2:a2db with SMTP id r2-20020a17090609c200b009b282d2a2dbmr17041493eje.28.1697016060504;
        Wed, 11 Oct 2023 02:21:00 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id n12-20020a170906378c00b0099d45ed589csm9521785ejc.125.2023.10.11.02.20.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Oct 2023 02:20:59 -0700 (PDT)
Message-ID: <b878b61f-05e4-42fa-00fa-44f5f1707030@redhat.com>
Date:   Wed, 11 Oct 2023 11:20:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [UPDATE][PATCH] platform/x86/intel-uncore-freq: Conditionally
 create attribute for read frequency
Content-Language: en-US, nl
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        markgross@kernel.org, ilpo.jarvinen@linux.intel.com,
        andriy.shevchenko@linux.intel.com
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231004181915.1887913-1-srinivas.pandruvada@linux.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20231004181915.1887913-1-srinivas.pandruvada@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 10/4/23 20:19, Srinivas Pandruvada wrote:
> When the current uncore frequency can't be read, don't create attribute
> "current_freq_khz" as any read will fail later. Some user space
> applications like turbostat fail to continue with the failure. So, check
> error during attribute creation.
> 
> Fixes: 414eef27283a ("platform/x86/intel/uncore-freq: Display uncore current frequency")
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> ---
> Added fixes tag which added current_freq_khz. But after this
> tag there is reorg of code, so need manual backport for some versions.
> I will separately submit to stable trees after merge.

Thank you for your patch/series, I've applied this patch
(series) to the pdx86 fixes branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=fixes

Note it will show up in the pdx86 fixes branch once I've pushed
my local branch there, which might take a while.

I will include this patch in my next fixes pull-req to Linus
for the current kernel development cycle.

Regards,

Hans




> 
>  .../x86/intel/uncore-frequency/uncore-frequency-common.c  | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/platform/x86/intel/uncore-frequency/uncore-frequency-common.c b/drivers/platform/x86/intel/uncore-frequency/uncore-frequency-common.c
> index 1152deaa0078..33ab207493e3 100644
> --- a/drivers/platform/x86/intel/uncore-frequency/uncore-frequency-common.c
> +++ b/drivers/platform/x86/intel/uncore-frequency/uncore-frequency-common.c
> @@ -176,7 +176,7 @@ show_uncore_data(initial_max_freq_khz);
>  
>  static int create_attr_group(struct uncore_data *data, char *name)
>  {
> -	int ret, index = 0;
> +	int ret, freq, index = 0;
>  
>  	init_attribute_rw(max_freq_khz);
>  	init_attribute_rw(min_freq_khz);
> @@ -197,7 +197,11 @@ static int create_attr_group(struct uncore_data *data, char *name)
>  	data->uncore_attrs[index++] = &data->min_freq_khz_dev_attr.attr;
>  	data->uncore_attrs[index++] = &data->initial_min_freq_khz_dev_attr.attr;
>  	data->uncore_attrs[index++] = &data->initial_max_freq_khz_dev_attr.attr;
> -	data->uncore_attrs[index++] = &data->current_freq_khz_dev_attr.attr;
> +
> +	ret = uncore_read_freq(data, &freq);
> +	if (!ret)
> +		data->uncore_attrs[index++] = &data->current_freq_khz_dev_attr.attr;
> +
>  	data->uncore_attrs[index] = NULL;
>  
>  	data->uncore_attr_group.name = name;


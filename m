Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE408782EF0
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 18:58:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236885AbjHUQ6c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 12:58:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236898AbjHUQ6T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 12:58:19 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1605F10F
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 09:57:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692637047;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CXGwgpHlf7D764T66ilzjBpaazpa9epIZyJVOx09W+I=;
        b=f9VWf6Ox6/GDWqvt3mgwUun/ZNk8ykbMF0S+GB7VyDLWZuGws7bY/0F7yI9UcJOT31I4s0
        93PRCbCDK3yKxwjYmLh3wnMRNdlGTElBwX56tU12J5d5wjvXe2RmF3sh1ew4WPGBkmZZq1
        AjOfSUna9X/0Cgz/z0vMOAl7YZpIlIw=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-395-EPqoiiGWNy6ldlHeS9qWsg-1; Mon, 21 Aug 2023 12:57:23 -0400
X-MC-Unique: EPqoiiGWNy6ldlHeS9qWsg-1
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-2bb93f9a54fso35225081fa.3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 09:57:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692637041; x=1693241841;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CXGwgpHlf7D764T66ilzjBpaazpa9epIZyJVOx09W+I=;
        b=jryl6axWKeQk9trsbNgZQbU9PzgfwF62cCpjx0iyVYN3iNceKTVT+MN5OWJaNdG7Gv
         sgn3tBZ2okBH1q+lOpQdKCdolbfRFzTXN+1CfRn/OrNIsEG9dGZHqDm6c9slmv+cCnXU
         Fd27/r85JFskM2gR7IeYaHHM7qJnZhCfTHfPRuM1wXH8Gsu+m/dhkJdkKdijI/wVY0FW
         uYueWxMxHIXV/qpHRGADh9Iduq7R2BTD3znq/39Fe9Ujb3aF2+8F3sfe8zHbIWyC56Ai
         aB1Scqo+wpLqa0+4uAN4sb3R4rJebU+YaYBQggwuXCKWQ/kLICNJl6XFjffErZBvGY98
         elGw==
X-Gm-Message-State: AOJu0Yxhm/j7BCkR2a0EI1mm0VFQ0ySl0b3FIdvZExRINuZo/7gCwzZh
        dTJwzo0RxOiS66TU7iOh+8iF9PUZqiOhjrusfaZp9aj6YKgIRDOKBwP73CKxQzVGxYVmeCsdjv9
        SW6xxUQIuG8gdah75qBdMTVEPSutSvURJ
X-Received: by 2002:a2e:8ec6:0:b0:2b6:e78e:1e58 with SMTP id e6-20020a2e8ec6000000b002b6e78e1e58mr5737989ljl.5.1692637041430;
        Mon, 21 Aug 2023 09:57:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEXXokZi+oG0+t0TFrhKlNiKjd9bBY8JtXoMrFYUu8TiarXbXIKYyckEfoETRvAcowQEwbL1Q==
X-Received: by 2002:a2e:8ec6:0:b0:2b6:e78e:1e58 with SMTP id e6-20020a2e8ec6000000b002b6e78e1e58mr5737978ljl.5.1692637041132;
        Mon, 21 Aug 2023 09:57:21 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id xa13-20020a170907b9cd00b0099bd5d28dc4sm6839118ejc.195.2023.08.21.09.57.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Aug 2023 09:57:20 -0700 (PDT)
Message-ID: <fb7d2d63-972a-b056-c7ae-a9995f1bf66b@redhat.com>
Date:   Mon, 21 Aug 2023 18:57:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] Update steps order list elements are evaluated
Content-Language: en-US, nl
To:     Jorge Lopez <jorgealtxwork@gmail.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        thomas@t-8ch.de, ilpo.jarvinen@linux.intel.com,
        dan.carpenter@linaro.org
References: <20230821144205.13529-1-jorge.lopez2@hp.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20230821144205.13529-1-jorge.lopez2@hp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 8/21/23 16:42, Jorge Lopez wrote:
> Update steps how order list elements data and elements size are
> evaluated
> 
> Signed-off-by: Jorge Lopez <jorge.lopez2@hp.com>
> 
> ---
> Based on the latest platform-drivers-x86.git/for-next

Thank you for your patch, I've applied this patch to my review-hans 
branch:
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
>  .../platform/x86/hp/hp-bioscfg/order-list-attributes.c | 10 +++-------
>  1 file changed, 3 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/platform/x86/hp/hp-bioscfg/order-list-attributes.c b/drivers/platform/x86/hp/hp-bioscfg/order-list-attributes.c
> index cffc1c9ba3e7..1ff09dfb7d7e 100644
> --- a/drivers/platform/x86/hp/hp-bioscfg/order-list-attributes.c
> +++ b/drivers/platform/x86/hp/hp-bioscfg/order-list-attributes.c
> @@ -258,7 +258,6 @@ static int hp_populate_ordered_list_elements_from_package(union acpi_object *ord
>  				eloc++;
>  			break;
>  		case ORD_LIST_ELEMENTS:
> -			size = ordered_list_data->elements_size;
>  
>  			/*
>  			 * Ordered list data is stored in hex and comma separated format
> @@ -270,17 +269,14 @@ static int hp_populate_ordered_list_elements_from_package(union acpi_object *ord
>  
>  			part_tmp = tmpstr;
>  			part = strsep(&part_tmp, COMMA_SEP);
> -			if (!part)
> -				strscpy(ordered_list_data->elements[0],
> -					tmpstr,
> -					sizeof(ordered_list_data->elements[0]));
>  
> -			for (olist_elem = 1; olist_elem < MAX_ELEMENTS_SIZE && part; olist_elem++) {
> +			for (olist_elem = 0; olist_elem < MAX_ELEMENTS_SIZE && part; olist_elem++) {
>  				strscpy(ordered_list_data->elements[olist_elem],
>  					part,
>  					sizeof(ordered_list_data->elements[olist_elem]));
> -				part = strsep(&part_tmp, SEMICOLON_SEP);
> +				part = strsep(&part_tmp, COMMA_SEP);
>  			}
> +			ordered_list_data->elements_size = olist_elem;
>  
>  			kfree(str_value);
>  			str_value = NULL;


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F8C180C591
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 11:04:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234682AbjLKKEp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 05:04:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234742AbjLKKEm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 05:04:42 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4948E8
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 02:04:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1702289087;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zTI8ORsYY/KaDfknA8aoZfsjhbA8xLRWljuvGCGEoQY=;
        b=Sb2yF3EcXLrIpwa+SJcvjhl54Jsc2ot6jpAmBnCif8fP5bVVHOlOviObqxtkK5CUlOI5U8
        8S7k2QeutUNchRV3X8b88G0F2nIQsfV6tTzjCvr759zI6ql5STzHlyFF7tTrEHvYKHsgE3
        ysXfZymgxHSAEHK50fXK50ypETyiNxw=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-173-_GqimkH9NnyKeOeaacGjjQ-1; Mon, 11 Dec 2023 05:04:46 -0500
X-MC-Unique: _GqimkH9NnyKeOeaacGjjQ-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a1f99db3dd0so62257466b.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 02:04:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702289085; x=1702893885;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zTI8ORsYY/KaDfknA8aoZfsjhbA8xLRWljuvGCGEoQY=;
        b=RIGX14terkFWIY8Cyic8dJPsmkMVjL3/GMz4SoSv95Rf6JwIuTb6Ed6sym3fGW5xZn
         hL76IQBTaRVhvIBaKMjd+mTSvCvZZWX4nFHxfD85fXML1SN4dMwkyF3OEZSHjqFz9RPQ
         /zaVSnjZhXTCLroix+dwcOrE0v9UcpCSLNKDa2yLu2HTnhf6sMkG966uwbc7MrQMcRuY
         ivTK9+q4OkLgdFV+HIC2IFGROt6fLQ/13XnuSsJvIjUlmtdW/RXB/Vx4v5HWwakDyyGI
         ZYn7srGKlho2dpLUbCJNvjuZLDzaSHoyO2fimN+aCW3uUaIAVzKexPRdomRAv0WiD+cA
         POHA==
X-Gm-Message-State: AOJu0YxBKlTDNbHzKtZTj3/8oaeUsu3+SlghK9L5to8RHl7i2JNRlDdP
        ZmK4x6fUcnN3cZBFK6zaqMHqQFXK6NikLsGrhfvP8QQ+fnUTJk9PS9ktTyXBCiVjuLetR55PcJF
        IuDxm3DNSBXIvCA9urEjUpG2k
X-Received: by 2002:a17:906:22d8:b0:a1e:7be8:9564 with SMTP id q24-20020a17090622d800b00a1e7be89564mr1585300eja.57.1702289085238;
        Mon, 11 Dec 2023 02:04:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFQxXHVdGAsaXewCyy8e6XmNCwLR86ivVqJcefy3RPgEgbK280kkHNwsj+v2/GrQb5QUMERWQ==
X-Received: by 2002:a17:906:22d8:b0:a1e:7be8:9564 with SMTP id q24-20020a17090622d800b00a1e7be89564mr1585295eja.57.1702289084910;
        Mon, 11 Dec 2023 02:04:44 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id ss20-20020a170907c01400b00a18850d2240sm4661237ejc.143.2023.12.11.02.04.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Dec 2023 02:04:44 -0800 (PST)
Message-ID: <e779d481-0953-4ac6-86a9-711d88e9ffcd@redhat.com>
Date:   Mon, 11 Dec 2023 11:04:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] clk: x86: lpss-atom: Drop unneeded 'extern' in the
 header
Content-Language: en-US, nl
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
References: <20231208165238.3309058-1-andriy.shevchenko@linux.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20231208165238.3309058-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 12/8/23 17:52, Andy Shevchenko wrote:
> 'extern' for the functions is not needed, drop it.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

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
>  include/linux/platform_data/x86/clk-lpss.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/platform_data/x86/clk-lpss.h b/include/linux/platform_data/x86/clk-lpss.h
> index 41df326583f9..7f132029316a 100644
> --- a/include/linux/platform_data/x86/clk-lpss.h
> +++ b/include/linux/platform_data/x86/clk-lpss.h
> @@ -15,6 +15,6 @@ struct lpss_clk_data {
>  	struct clk *clk;
>  };
>  
> -extern int lpss_atom_clk_init(void);
> +int lpss_atom_clk_init(void);
>  
>  #endif /* __CLK_LPSS_H */


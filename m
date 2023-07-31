Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BD0B769912
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 16:10:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231628AbjGaOKR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 10:10:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229851AbjGaOKM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 10:10:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D0C7E3
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 07:09:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690812566;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IPp29UYo0ZZddIYLEdBescKIwjWYQfioETTd4hLKE4c=;
        b=NSVbmt6fnTj5xSOanwmSn8R23vQDbwfE4yxNX3tFuAdFW7Qbne5QtLH+jaWEgx1PXZbyit
        orVPuyqzxdIjIiManv0xrGXcVu8J1p9LXhSd9lyCp6KMxMxFfE6KN8SAIyCD/pjk4ql3U2
        4U4hIk/G/177OKlgBtpc9fFflRwabb0=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-483-kQ8a__gQP_CObQ9m9XBp2Q-1; Mon, 31 Jul 2023 10:09:23 -0400
X-MC-Unique: kQ8a__gQP_CObQ9m9XBp2Q-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-99bebfada8cso200349266b.1
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 07:09:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690812562; x=1691417362;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IPp29UYo0ZZddIYLEdBescKIwjWYQfioETTd4hLKE4c=;
        b=SXuZUZpd0q9qtdiO045TZNEHVtAVWJ9PguY8JPbz+fVAS1g09M+S+9sso72DVyYlUi
         Gh3NGyJlLLN4CVWrYyxEg1wrLc5kZE84FMzZscZ+UtMoxeFxgGPOXTTg0sYo6MiRLN/f
         3WGs/KV+FmVS3GtqbY/cj3lj/7gO86CCp93eOiJyjtXdjDrViiGVHXT23+6CgaZoi1yi
         W5jfoMM3qN8G65JssAQohPJbLNj3gDZX8rMcuSNm6oQ+HlzLsADa7kpWuWFYpbFM2BCP
         JbxGC4U0/WorWKG0rPXUGxi6/kqsfbytT41dnlbBMtAVKH3tqJpsVdaLg5/icsCzB/UL
         pH6g==
X-Gm-Message-State: ABy/qLYSb/rO8ZoCeLvs6ApDi3LhtXsmYNaIEr/YfMp3+BDwoba2t0Dq
        tzCjxVmA/+ymje/hm0WP64EywSs+j6KVZgBowAlsyb/TOwMdwgYdMwryqKGCONT6hYhh+1yVwCz
        BaVUZRQoIFGkG8rkYe9sbcjytVIC62aSX
X-Received: by 2002:a17:906:31c2:b0:99c:2289:63bc with SMTP id f2-20020a17090631c200b0099c228963bcmr606180ejf.74.1690812562136;
        Mon, 31 Jul 2023 07:09:22 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGgvsAduj5hcGrxn6IIMNMQ0lttvvuISFEQmMGpFG4MQZI4sH6v4L+gh/Aw3Nd7GZfzjF+ZUw==
X-Received: by 2002:a17:906:31c2:b0:99c:2289:63bc with SMTP id f2-20020a17090631c200b0099c228963bcmr606163ejf.74.1690812561854;
        Mon, 31 Jul 2023 07:09:21 -0700 (PDT)
Received: from [10.40.98.142] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id qq5-20020a17090720c500b009882e53a42csm6189153ejb.81.2023.07.31.07.09.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Jul 2023 07:09:11 -0700 (PDT)
Message-ID: <102f30e6-f159-3983-825c-7cb819c201f0@redhat.com>
Date:   Mon, 31 Jul 2023 16:09:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH -next] platform/x86/amd/pmf: Fix unsigned comparison with
 less than zero
Content-Language: en-US
To:     Yang Li <yang.lee@linux.alibaba.com>, Shyam-sundar.S-k@amd.com
Cc:     markgross@kernel.org, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org, Abaci Robot <abaci@linux.alibaba.com>
References: <20230727014315.51375-1-yang.lee@linux.alibaba.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20230727014315.51375-1-yang.lee@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

On 7/27/23 03:43, Yang Li wrote:
> The return value from the call to amd_pmf_get_pprof_modes() is int.
> However, the return value is being assigned to an unsigned char
> variable 'mode', so making 'mode' an int.
> 
> silence the warning:
> ./drivers/platform/x86/amd/pmf/sps.c:183:5-9: WARNING: Unsigned expression compared with zero: mode < 0
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=5995
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>

Thank you for your patch, I've applied this patch to my fixes
branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=fixes

Note it will show up in my fixes branch once I've pushed my
local branch there, which might take a while.

I will include this patch in my next fixes pull-req to Linus
for the current kernel development cycle.

Regards,

Hans

> ---
>  drivers/platform/x86/amd/pmf/sps.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/platform/x86/amd/pmf/sps.c b/drivers/platform/x86/amd/pmf/sps.c
> index ab69d517a36a..a70e67749be3 100644
> --- a/drivers/platform/x86/amd/pmf/sps.c
> +++ b/drivers/platform/x86/amd/pmf/sps.c
> @@ -176,7 +176,8 @@ int amd_pmf_get_pprof_modes(struct amd_pmf_dev *pmf)
>  
>  int amd_pmf_power_slider_update_event(struct amd_pmf_dev *dev)
>  {
> -	u8 mode, flag = 0;
> +	u8 flag = 0;
> +	int mode;
>  	int src;
>  
>  	mode = amd_pmf_get_pprof_modes(dev);


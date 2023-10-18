Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7E627CDD5B
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 15:33:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344679AbjJRNdM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 09:33:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231549AbjJRNdK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 09:33:10 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FD15FA
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 06:32:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697635941;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=h1y+Lbjba0uPhpStIL3iIJrOQN2PixRm2K4anBzJjcY=;
        b=HKs7jqJTRQNyZGmpdpyXW3+zNoKYV4WMmuWyAnhzjrw+gi0lr/WEWpd3Np7McrzLImzZCj
        M67DFCfb5nS+SH1/egJkmlM+k+hgqROB2uUNnGHA+4oSeFfHrGZkUsT1ba7fxRdH1cvAnz
        oWpAWSGmE2NFy2gs9o8FdCJD3jlQA5s=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-578-3Hf_NS3nOD2irotMgKi21g-1; Wed, 18 Oct 2023 09:32:14 -0400
X-MC-Unique: 3Hf_NS3nOD2irotMgKi21g-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-9ae686dafedso501032266b.3
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 06:32:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697635934; x=1698240734;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h1y+Lbjba0uPhpStIL3iIJrOQN2PixRm2K4anBzJjcY=;
        b=nivMMwtnKysPNJOgBaIh64nujbLPU8QR7ogyFUnTia261tfqyaniZ62wcD3JZxLHSW
         J3k2KzJ3yUVPueMgEPholfLeNjAUA9PAmcLW2JBqUxE7g5C/wocGGERs1mt3ZD7ZyxxT
         rX9fZnVTiAsYPAzJDMg19t17aagWCimvla0W0Dt2uq6HiIjM+v5aPWkFSvBCWq3Tlb01
         5Ho4fU92bwMAZsy09ibrRrsRyoT3Gr8bcn0MT3XeQqfb5L7qBf1NLgMFbZaCSrXHbOVa
         BguSLdqJNsQdiQ65+10NiGEItpQ3dhIpfVMM3gFHMHDwIrlmfiGdjyH82g28ogriiH+1
         WL5w==
X-Gm-Message-State: AOJu0Yz+HwXcJ/q6VyAk7bix0HgT8iCv+eXTX/1Blpo/qyKZyryO2XhA
        dzqMRtuq8IZBE7TkxJiP7CoLJ8j3IwJtLoGzaH1NPmX79z1WwqqZnwhuIA1cmInZlO5Qg5ISL0S
        yQJ6TUMO4e850h1hm3xtA3vUS
X-Received: by 2002:a17:907:e94:b0:9b2:df16:851d with SMTP id ho20-20020a1709070e9400b009b2df16851dmr4365542ejc.57.1697635933851;
        Wed, 18 Oct 2023 06:32:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH18mFmch1lYXp4g0X+gAssWRNeJUjZzrtjpyVVD5oGhpJ+O6KHlNN4MAH6Vp3mXSq+C3I8AA==
X-Received: by 2002:a17:907:e94:b0:9b2:df16:851d with SMTP id ho20-20020a1709070e9400b009b2df16851dmr4365517ejc.57.1697635933504;
        Wed, 18 Oct 2023 06:32:13 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id c30-20020a1709063f1e00b0099bd1ce18fesm1726852ejj.10.2023.10.18.06.32.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Oct 2023 06:32:11 -0700 (PDT)
Message-ID: <d86cbcd0-e41b-81d7-2708-231f128f134a@redhat.com>
Date:   Wed, 18 Oct 2023 15:32:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] platform/surface: platform_profile: Propagate error if
 profile registration fails
Content-Language: en-US, nl
To:     Armin Wolf <W_Armin@gmx.de>, luzmaximilian@gmail.com
Cc:     ilpo.jarvinen@linux.intel.com, markgross@kernel.org,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231014235449.288702-1-W_Armin@gmx.de>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20231014235449.288702-1-W_Armin@gmx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 10/15/23 01:54, Armin Wolf wrote:
> If platform_profile_register() fails, the driver does not propagate
> the error, but instead probes successfully. This means when the driver
> unbinds, the a warning might be issued by platform_profile_remove().
> 
> Fix this by propagating the error back to the caller of
> surface_platform_profile_probe().
> 
> Compile-tested only.
> 
> Fixes: b78b4982d763 ("platform/surface: Add platform profile driver")
> Signed-off-by: Armin Wolf <W_Armin@gmx.de>

Thank you for your patch/series, I've applied this patch
(series) to the pdx86 fixes branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=fixes

Note it will show up in the pdx86 fixes branch once I've pushed
my local branch there, which might take a while.

I will include this patch in my next fixes pull-req to Linus
for the current kernel development cycle.

Regards,

Hans



> ---
>  drivers/platform/surface/surface_platform_profile.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/platform/surface/surface_platform_profile.c b/drivers/platform/surface/surface_platform_profile.c
> index f433a13c3689..a5a3941b3f43 100644
> --- a/drivers/platform/surface/surface_platform_profile.c
> +++ b/drivers/platform/surface/surface_platform_profile.c
> @@ -159,8 +159,7 @@ static int surface_platform_profile_probe(struct ssam_device *sdev)
>  	set_bit(PLATFORM_PROFILE_BALANCED_PERFORMANCE, tpd->handler.choices);
>  	set_bit(PLATFORM_PROFILE_PERFORMANCE, tpd->handler.choices);
> 
> -	platform_profile_register(&tpd->handler);
> -	return 0;
> +	return platform_profile_register(&tpd->handler);
>  }
> 
>  static void surface_platform_profile_remove(struct ssam_device *sdev)
> --
> 2.39.2
> 


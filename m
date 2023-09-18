Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E131A7A4C15
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 17:26:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233777AbjIRP0L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 11:26:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230206AbjIRP0K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 11:26:10 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 703A4170E
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 08:23:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695050484;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZJxOEUwKq2KwnFmZk3pOWmt+ygYn9o53lf6vTBXs108=;
        b=D4Imi09B/fF1/+JxI5wcuD68UmmMSAyj6kg2812w20HxsIDiX7iIGwn/Npj3px8kjvpmlb
        JkqqgzNk8vTR/tJ5MdzxffiYK7LE/dXhPoFogEdcBfVyAUCIDBn3d5VTh7IUo6lAq/u7Y5
        XvD59JF+4VuTFvw3d04yPF2UhEuUTFY=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-245-ew4HfqXLPuKOrZ8D_F21JQ-1; Mon, 18 Sep 2023 09:21:04 -0400
X-MC-Unique: ew4HfqXLPuKOrZ8D_F21JQ-1
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-502e77e60afso2543776e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 06:21:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695043263; x=1695648063;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZJxOEUwKq2KwnFmZk3pOWmt+ygYn9o53lf6vTBXs108=;
        b=qFZDZA0jc/d4vlti2Th89KenqpsYuCVA0b9klkzYlcDbqQK0wfDDdAmzTI3lXtMe0J
         zODctF/je/m05tFKtd2di7KadqRKQRAAo1s2Veyv6/kSVkPfL6T1ZGBvv57UYeKnafy3
         PMtPVpzgN5YCtyunliVnLdfamXHurmmN/LZEIGmdBH10Uc7sTzQSWwhgDfigtaZwuX9W
         5T5mAWc/uMAhknnBXZjFUcTQkKQfQnM/GAF9WVh54WDwanbSYFIVR2QIWq0bYUC48yWC
         rhVvvjtRUMZagiGNK+sVM7skgd8qzhZCW6/FxYQgCgrv3N+znB59T6wvYmGcuUeShZXN
         MEHQ==
X-Gm-Message-State: AOJu0Yxa+4Bhjz5e8YkwFE/vfze9/IpgcyiARvGUk8vZfduO70oxqBcQ
        tjrjQsgokXizA0/FV2BfNPQmcr/ylw5gM2EjMgT335/+soQ33FQE3sh5CBX+pMgI7DLm0j9coPJ
        Lbvnxh6+Ay3mtxLw3b/smb+in
X-Received: by 2002:a19:7113:0:b0:500:9a45:62f with SMTP id m19-20020a197113000000b005009a45062fmr6427103lfc.8.1695043263247;
        Mon, 18 Sep 2023 06:21:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEg3y8j6ulHCSsYRNzSopEL/zg2ePatS9CF1ypxa0pAhrRRg0cuUohYCdUZGe8vuUkbYRI1hg==
X-Received: by 2002:a19:7113:0:b0:500:9a45:62f with SMTP id m19-20020a197113000000b005009a45062fmr6427097lfc.8.1695043262906;
        Mon, 18 Sep 2023 06:21:02 -0700 (PDT)
Received: from [10.40.98.142] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id l1-20020a056402028100b0052237dfa82fsm5973258edv.64.2023.09.18.06.21.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Sep 2023 06:21:02 -0700 (PDT)
Message-ID: <37947c4f-abd1-afeb-ed5e-54e7a3aba28b@redhat.com>
Date:   Mon, 18 Sep 2023 15:21:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 1/1] MAINTAINERS: Add myself into x86 platform driver
 maintainers
Content-Language: en-US
To:     =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Mark Gross <markgross@kernel.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
References: <20230918102901.17669-1-ilpo.jarvinen@linux.intel.com>
 <20230918102901.17669-2-ilpo.jarvinen@linux.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20230918102901.17669-2-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 9/18/23 12:29, Ilpo Järvinen wrote:
> Hans has been asking for another person to help as the maintainer of
> the x86 platform driver because Mark has not been able to find time to
> do that. I got asked for the task and have been reviewing the relevant
> patches for a while now but lets make it more official by adding the
> MAINTAINERS entries.
> 
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

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
>  MAINTAINERS | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 90f13281d297..b04cbcec521f 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -13617,6 +13617,7 @@ F:	drivers/net/ethernet/mellanox/mlxfw/
>  
>  MELLANOX HARDWARE PLATFORM SUPPORT
>  M:	Hans de Goede <hdegoede@redhat.com>
> +M:	Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
>  M:	Mark Gross <markgross@kernel.org>
>  M:	Vadim Pasternak <vadimp@nvidia.com>
>  L:	platform-driver-x86@vger.kernel.org
> @@ -14211,6 +14212,7 @@ F:	drivers/platform/surface/surface_gpe.c
>  
>  MICROSOFT SURFACE HARDWARE PLATFORM SUPPORT
>  M:	Hans de Goede <hdegoede@redhat.com>
> +M:	Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
>  M:	Mark Gross <markgross@kernel.org>
>  M:	Maximilian Luz <luzmaximilian@gmail.com>
>  L:	platform-driver-x86@vger.kernel.org
> @@ -23424,6 +23426,7 @@ F:	drivers/platform/x86/x86-android-tablets/
>  
>  X86 PLATFORM DRIVERS
>  M:	Hans de Goede <hdegoede@redhat.com>
> +M:	Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
>  M:	Mark Gross <markgross@kernel.org>
>  L:	platform-driver-x86@vger.kernel.org
>  S:	Maintained


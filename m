Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF4357630C7
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 11:04:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233115AbjGZJEM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 05:04:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231821AbjGZJDs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 05:03:48 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FA3B59EF
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 01:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690361952;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xeRT9Jy7eVenEoTjFFWWmP+a03yBpOH5hVPtQnivUcw=;
        b=Zznh+HXMDpeFSZHFoUVh3kcRMSjQyAe206Mmyr/4B7wyaZiyZjts0HgPtQ9J+E6de4tN2O
        SmibCdqonlhsrcPzeNwLdavvms2ollAeunD4IcDI/YeNeUpUto7+dAX1QP0D6PcF1xuGKJ
        TbSo/3OkUeVLFP5+02gsjKgsAmfHgQU=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-553-qra2sYabMXeN53aoYJ1Kbw-1; Wed, 26 Jul 2023 04:59:10 -0400
X-MC-Unique: qra2sYabMXeN53aoYJ1Kbw-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-989249538a1so428215966b.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 01:59:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690361945; x=1690966745;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xeRT9Jy7eVenEoTjFFWWmP+a03yBpOH5hVPtQnivUcw=;
        b=DH1DDzBMtAaqQ8cqnbQRDVDilJ/0Z1G5OXbtRglsGoYN6TsN8jQAK2L45KACUjJHxb
         uNku5tSUia5gIiIRLX5/IPmpK7Rz9wY6KiLZ+s6XnpddwQ81UJySi2TX0fueqVqrEHnW
         RgiTQQs5GVHQvWn3eNXwv4AlBVGoFOBkaq+oxEx/5y3nIVHf6292cBFfilGMxCYqfAhS
         EdmzMnxV12YXNHM1bhmDvEgTpwqzXzcLPT22gD48tfKYsUo6kDMXEd19kFflwXxON48U
         qKJWGgcNpSnypV409WBb1YHijwYm6WHHHoPkHFI9CIduTtJOpx4EOCX9ZyQpsaaTlOu+
         Y9SA==
X-Gm-Message-State: ABy/qLZsW4zCn0Eg65+hLzKdvvyDhrbBFMOBp88/n7R7yVFN6pqZX156
        jtCkz/xWXv4L13F5JWvcGN8jxRhJEPEsI475JE6MRatCAksLo6ZYRWpgGAr8OR73G3OB6lnCCej
        l2Pn/Wo9royOYSu1qVI8v9UnsjNvX5FEs
X-Received: by 2002:a17:906:3098:b0:99b:b3a1:437b with SMTP id 24-20020a170906309800b0099bb3a1437bmr1128251ejv.40.1690361945546;
        Wed, 26 Jul 2023 01:59:05 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGce74iNdoqahohZBou7UapwNEzH+hZVT14Xqe7CfDrQV51dAMGR6N625plRzskQ5Ljavku+Q==
X-Received: by 2002:a17:906:3098:b0:99b:b3a1:437b with SMTP id 24-20020a170906309800b0099bb3a1437bmr1128238ejv.40.1690361945266;
        Wed, 26 Jul 2023 01:59:05 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a18-20020a1709065f9200b0096f6a131b9fsm9234448eju.23.2023.07.26.01.59.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jul 2023 01:59:04 -0700 (PDT)
Message-ID: <4ef7791f-57f3-c27f-f414-9a39e014b86e@redhat.com>
Date:   Wed, 26 Jul 2023 10:59:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] platform: Explicitly include correct DT includes
Content-Language: en-US, nl
To:     Rob Herring <robh@kernel.org>, Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Mark Gross <markgross@kernel.org>,
        Vadim Pasternak <vadimp@nvidia.com>
Cc:     devicetree@vger.kernel.org, chrome-platform@lists.linux.dev,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
References: <20230714174909.4062739-1-robh@kernel.org>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20230714174909.4062739-1-robh@kernel.org>
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

On 7/14/23 19:49, Rob Herring wrote:
> The DT of_device.h and of_platform.h date back to the separate
> of_platform_bus_type before it as merged into the regular platform bus.
> As part of that merge prepping Arm DT support 13 years ago, they
> "temporarily" include each other. They also include platform_device.h
> and of.h. As a result, there's a pretty much random mix of those include
> files used throughout the tree. In order to detangle these headers and
> replace the implicit includes with struct declarations, users need to
> explicitly include the correct includes.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>

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
>  drivers/platform/chrome/cros_ec.c          | 1 +
>  drivers/platform/mellanox/mlxreg-hotplug.c | 1 -
>  drivers/platform/mellanox/mlxreg-io.c      | 1 -
>  3 files changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/platform/chrome/cros_ec.c b/drivers/platform/chrome/cros_ec.c
> index 8b7949220382..5d36fbc75e1b 100644
> --- a/drivers/platform/chrome/cros_ec.c
> +++ b/drivers/platform/chrome/cros_ec.c
> @@ -12,6 +12,7 @@
>  #include <linux/interrupt.h>
>  #include <linux/module.h>
>  #include <linux/of_platform.h>
> +#include <linux/platform_device.h>
>  #include <linux/platform_data/cros_ec_commands.h>
>  #include <linux/platform_data/cros_ec_proto.h>
>  #include <linux/slab.h>
> diff --git a/drivers/platform/mellanox/mlxreg-hotplug.c b/drivers/platform/mellanox/mlxreg-hotplug.c
> index b7dcc64cd238..6ddfea0d4c5b 100644
> --- a/drivers/platform/mellanox/mlxreg-hotplug.c
> +++ b/drivers/platform/mellanox/mlxreg-hotplug.c
> @@ -12,7 +12,6 @@
>  #include <linux/i2c.h>
>  #include <linux/interrupt.h>
>  #include <linux/module.h>
> -#include <linux/of_device.h>
>  #include <linux/platform_data/mlxreg.h>
>  #include <linux/platform_device.h>
>  #include <linux/spinlock.h>
> diff --git a/drivers/platform/mellanox/mlxreg-io.c b/drivers/platform/mellanox/mlxreg-io.c
> index ddc08abf398c..83ba037408cd 100644
> --- a/drivers/platform/mellanox/mlxreg-io.c
> +++ b/drivers/platform/mellanox/mlxreg-io.c
> @@ -11,7 +11,6 @@
>  #include <linux/hwmon.h>
>  #include <linux/hwmon-sysfs.h>
>  #include <linux/module.h>
> -#include <linux/of_device.h>
>  #include <linux/platform_data/mlxreg.h>
>  #include <linux/platform_device.h>
>  #include <linux/regmap.h>


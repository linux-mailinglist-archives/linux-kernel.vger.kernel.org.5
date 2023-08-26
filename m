Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 174AF7895F5
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Aug 2023 12:28:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232029AbjHZK1y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Aug 2023 06:27:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231993AbjHZK12 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Aug 2023 06:27:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB1321FFE
        for <linux-kernel@vger.kernel.org>; Sat, 26 Aug 2023 03:26:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1693045597;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hgjehK23Y8dKnBIGq/90eR6N9qpsiDO03ILle5ORVqM=;
        b=RS2UriJ+F1bcb+Vm0yaUIwR6i/u17OnsrGx4vtGQDl9ePaaIl9VAXlOxPY5G9p3/EDOtUz
        mccCt9RI4ElgficDMijkfMT2RgGLdiZqZKpMmaESOR8xIZZIj4pho5QZkyOd5PFcoKIH/b
        vRTCZw8OF3RfbVe5ar0K7Qm4hatiBOo=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-321-kHIUu7-JOviLhAoZvwTR5w-1; Sat, 26 Aug 2023 06:26:36 -0400
X-MC-Unique: kHIUu7-JOviLhAoZvwTR5w-1
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-52a06f5f4e2so1480094a12.2
        for <linux-kernel@vger.kernel.org>; Sat, 26 Aug 2023 03:26:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693045595; x=1693650395;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hgjehK23Y8dKnBIGq/90eR6N9qpsiDO03ILle5ORVqM=;
        b=RoipXrxUN1vO+dnIEN70VMHOEAzTDIsL0rHBjnp7K3Z2kr7IObgsUOSXwTK3ROp03Y
         bcXKbWJtElIlhSrFjjgppYWmfs6sp35e6NwCcyT3eQboWQ6I7KoBNnoPR0n1iff78DGt
         JS5zGI15JjN0GhtkqE/lMHzov1xa4h1k30p/pu5ujiviZhsP0vlnrIU8PTdUmgt41T5S
         OANKW0fj4Kid2s5zGah3I/0lGDqxnFjIHbvTFOCcF7s5HGSJPy/YS9EUE2Ejoljy4jdP
         IAZZSMlgjG7pPY1nDg1XYIa7broHLsDl74Cmhd+yCfA0fn+0HoLfjqJAS1WQjUNM+Uy4
         ovQg==
X-Gm-Message-State: AOJu0Ywkkrce+jVHFoNGoZgjgLkn5xmwj0aCpc9JzDKqlNQjBKBhgwOY
        LF22drsi/DQ2sk8tTAP1/spLKhw2bTtwrmZeGtzzKi+sYJgQtPHdOZh/tqE5+wL6PtkKY7aT22H
        mZ/8AgSPx83sg7vkPPnZSngTv
X-Received: by 2002:a05:6402:5178:b0:523:4d60:71c0 with SMTP id d24-20020a056402517800b005234d6071c0mr12825988ede.33.1693045595105;
        Sat, 26 Aug 2023 03:26:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGVRF161f0x3klD3Re4TcVObGkJ68TCSIolyHtb11kjX63CJv8xb2+Dt/gmLSQsPsm79mY0oA==
X-Received: by 2002:a05:6402:5178:b0:523:4d60:71c0 with SMTP id d24-20020a056402517800b005234d6071c0mr12825977ede.33.1693045594826;
        Sat, 26 Aug 2023 03:26:34 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id p8-20020aa7d308000000b005288f0e547esm1997934edq.55.2023.08.26.03.26.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 26 Aug 2023 03:26:34 -0700 (PDT)
Message-ID: <7bc47fa9-3b8e-23c2-6bf1-ccd230433ed0@redhat.com>
Date:   Sat, 26 Aug 2023 12:26:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] platform/x86/amd/pmf: Fix a missing cleanup path
Content-Language: en-US, nl
To:     Mario Limonciello <mario.limonciello@amd.com>,
        Shyam-sundar.S-k@amd.com
Cc:     markgross@kernel.org, Patil.Reddy@amd.com,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230823185421.23959-1-mario.limonciello@amd.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20230823185421.23959-1-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 8/23/23 20:54, Mario Limonciello wrote:
> On systems that support slider notifications but don't otherwise support
> granular slider the SPS cleanup path doesn't run.
> 
> This means that loading/unloading/loading leads to failures because
> the sysfs files don't get setup properly when reloaded.
> 
> Add the missing cleanup path.Thank you for your patch, I've applied this patch to my review-hans 
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




> Fixes: 33c9ab5b493a ("platform/x86/amd/pmf: Notify OS power slider update")
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>



> ---
>  drivers/platform/x86/amd/pmf/core.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/platform/x86/amd/pmf/core.c b/drivers/platform/x86/amd/pmf/core.c
> index 7780705917b76..8f93681c5c9c5 100644
> --- a/drivers/platform/x86/amd/pmf/core.c
> +++ b/drivers/platform/x86/amd/pmf/core.c
> @@ -317,7 +317,8 @@ static void amd_pmf_init_features(struct amd_pmf_dev *dev)
>  
>  static void amd_pmf_deinit_features(struct amd_pmf_dev *dev)
>  {
> -	if (is_apmf_func_supported(dev, APMF_FUNC_STATIC_SLIDER_GRANULAR)) {
> +	if (is_apmf_func_supported(dev, APMF_FUNC_STATIC_SLIDER_GRANULAR) ||
> +	    is_apmf_func_supported(dev, APMF_FUNC_OS_POWER_SLIDER_UPDATE)) {
>  		power_supply_unreg_notifier(&dev->pwr_src_notifier);
>  		amd_pmf_deinit_sps(dev);
>  	}
> 
> base-commit: 65c6ea33e7f63799090158866cdcfdfe8d63ce16


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDA647F9F85
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 13:26:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233416AbjK0MZ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 07:25:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233380AbjK0MZv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 07:25:51 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCB7590
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 04:25:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701087956;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OixCjm5XLTh8o7ZbELqAMS9awpLnV4P6pYGe0vBMdiE=;
        b=MSzghaws59sKRD3wbRUvgwvxgXBffjF0Nx1mdlxZjPa06X66lK4MFBtNaYZR1PuC2S0m3J
        67cpkT07WwdPVqR8BMtoz/heiP+velGoD3iui2GIoHi2KeQgiTWu32WMExCgoQUaiquc6N
        2TRNzNmS6ynOk6xfZA1K3fBboDCaZ5Q=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-531-Ac0GttROOriIYwSPj-u7OA-1; Mon, 27 Nov 2023 07:25:55 -0500
X-MC-Unique: Ac0GttROOriIYwSPj-u7OA-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a02aa8a129fso296090766b.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 04:25:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701087954; x=1701692754;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OixCjm5XLTh8o7ZbELqAMS9awpLnV4P6pYGe0vBMdiE=;
        b=SAilaHMfCYn7FT+Xs/zOLNia4ZRjq/i6t6ZyeOYaiLaKHV2p3xmshrkV9Z/zc/qn5f
         V7gNNvpen5PjxOheOA2En/EP7CkkslNxM2xoKB5X5i43rwL8WFyi0JfBIejGaIW6NBP1
         HRRw2A2QQQ4H9/3jopdf/pj+/bw0RmI+OHzfNvs5L+2USWEYY8HcUsGUaeG3aZkAQJpl
         mRIYemLD9heY6+nt7Iucsa8XONZaSfEQ3fvmwAyEEVrAWRTADh29A8bh7fuA4UgklXKZ
         BpgrvMS3Gd0tVJBHK1l/qgJDpEdr6BGPNmJ8iHCgqy2a16oGMVZcEOaT0f0MDNhe15D/
         fPsg==
X-Gm-Message-State: AOJu0YxYLhSy45QPiPHglTEqB0TCVpAb59ttzDhwABnkuMBMT+JwfmKt
        xTFr5PYR0T79PC3t25vDabe5mD3oqDUnOq61+FD34lvPDk/GL9CpaECht9hHlNxYfnExFwG0BUc
        SKkcOz+zhoC5++2rdWTjDAFZQ
X-Received: by 2002:a17:906:d92d:b0:9e4:a597:ffe with SMTP id rn13-20020a170906d92d00b009e4a5970ffemr7963060ejb.44.1701087954532;
        Mon, 27 Nov 2023 04:25:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFvE7hHwT1et8XO/IBRQQTOKN20AvggPvMb1hA3AmufMEP1Ghz/kOtda7N+PtRDKjb9/3hjTw==
X-Received: by 2002:a17:906:d92d:b0:9e4:a597:ffe with SMTP id rn13-20020a170906d92d00b009e4a5970ffemr7963043ejb.44.1701087954201;
        Mon, 27 Nov 2023 04:25:54 -0800 (PST)
Received: from [10.40.98.142] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id t27-20020a1709063e5b00b009fd727116b4sm5611223eji.129.2023.11.27.04.25.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Nov 2023 04:25:53 -0800 (PST)
Message-ID: <0bc244e5-9c5c-4fd1-a545-32c22d717bf7@redhat.com>
Date:   Mon, 27 Nov 2023 13:25:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] platform/x86: asus-laptop: remove redundant braces in if
 statements
Content-Language: en-US
To:     Edson Juliano Drosdeck <edson.drosdeck@gmail.com>,
        corentin.chary@gmail.com
Cc:     ilpo.jarvinen@linux.intel.com, markgross@kernel.org,
        acpi4asus-user@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <20231016191349.3856-1-edson.drosdeck@gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20231016191349.3856-1-edson.drosdeck@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 10/16/23 21:13, Edson Juliano Drosdeck wrote:
> Adhere to Linux kernel coding style.
> 
> Reported by checkpatch:
> 
> WARNING: braces {} are not necessary for single statement blocks
> 
> Signed-off-by: Edson Juliano Drosdeck <edson.drosdeck@gmail.com>

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
>  drivers/platform/x86/asus-laptop.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/platform/x86/asus-laptop.c b/drivers/platform/x86/asus-laptop.c
> index 761029f39314..bf03ea1b1274 100644
> --- a/drivers/platform/x86/asus-laptop.c
> +++ b/drivers/platform/x86/asus-laptop.c
> @@ -1816,9 +1816,8 @@ static void asus_dmi_check(void)
>  		return;
>  
>  	/* On L1400B WLED control the sound card, don't mess with it ... */
> -	if (strncmp(model, "L1400B", 6) == 0) {
> +	if (strncmp(model, "L1400B", 6) == 0)
>  		wlan_status = -1;
> -	}
>  }
>  
>  static bool asus_device_present;


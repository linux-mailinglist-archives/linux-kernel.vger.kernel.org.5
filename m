Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC490782A5F
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 15:22:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235362AbjHUNWR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 09:22:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232888AbjHUNWQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 09:22:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41DEAE1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 06:21:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692624088;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fI9R9Pu6QRroB9MVGxLy/O6kwSpRxFk2cs5sNYWG5ik=;
        b=aiB+V9TKxwdd7bnpEEBrGeKevq0qzCAOQvOc9dg/B3vbe2PLxlrNeoLCXj4tp7o/WFlUea
        qJPgB2/L45rs9CLgrkmZIojbZLBLTyltK1BVUW6cPqBRnA2KGVRAtyafq1mM6LyBRwmJA/
        JziEOgsLO6CQB2U11gd4zP0KitD8bTI=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-622-YoCgDKnHMBqW8c6mpR2D0A-1; Mon, 21 Aug 2023 09:21:24 -0400
X-MC-Unique: YoCgDKnHMBqW8c6mpR2D0A-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-99cc32f2ec5so224868966b.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 06:21:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692624083; x=1693228883;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fI9R9Pu6QRroB9MVGxLy/O6kwSpRxFk2cs5sNYWG5ik=;
        b=as9Sj9ewUH8zxs9xrj6rhYMbnXDhCF/uWrjwsYiPG+01aqeiGdUqfaeLlt00bbrMW1
         9qmzwwMHR8A6KzG6pFJfaTi+LPHWi+PlySzL33FCIX2bBgDGFpSmknLVcBkgggksVDiw
         0oL32Doeo5gzUKbR9Zev6x/NStyQTVTz4OsXFnxnWhsfSsQzjcNV0LokmT7WIk1X240e
         4tyjosXZ3EzQOB7RMwRUpRA4/gDTEbLsBudtuFT+D9eef6LQcmhoXU3ba9zuSaZ95ssu
         D5Ae5gr/jROXb1Sdc8V5Vws+yW6aSMQ3h4xUwFn4k1vPHn6RwbdtQm+zsUzP9/V2hdg9
         YbYA==
X-Gm-Message-State: AOJu0Yx1vrRcqBBasXWohGQssgifIVGHGpZMTJ6K8bVGl1uZ8XitbvOe
        rFKDkdgC/SIGeZ3RUW8QWW3tZDjxFVDgkych6LkPpPxwRiDNqQYcq2ocL2gHlUb5ZVvpkYw4tsk
        nAGSmtTLAPjWuaLuXMeCes6Hp
X-Received: by 2002:a17:907:78d2:b0:99d:9adc:d69c with SMTP id kv18-20020a17090778d200b0099d9adcd69cmr5008389ejc.14.1692624083739;
        Mon, 21 Aug 2023 06:21:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGw135lOPM9jL9VIii6900OW1D6Sb7noMgkJWeT5b6zLcTwRGwL56otiOrdP8aVxodT7Ou6fA==
X-Received: by 2002:a17:907:78d2:b0:99d:9adc:d69c with SMTP id kv18-20020a17090778d200b0099d9adcd69cmr5008377ejc.14.1692624083466;
        Mon, 21 Aug 2023 06:21:23 -0700 (PDT)
Received: from [10.40.98.142] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id p18-20020a1709060e9200b009888aa1da11sm6517544ejf.188.2023.08.21.06.21.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Aug 2023 06:21:22 -0700 (PDT)
Message-ID: <51b145fc-aa13-66e7-427e-8dfebc7d06ca@redhat.com>
Date:   Mon, 21 Aug 2023 15:21:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v1 1/1] platform/x86/amd/pmf: Use str_on_off() helper
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        Muhammad Usama Anjum <usama.anjum@collabora.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Mark Gross <markgross@kernel.org>
References: <20230811131330.71263-1-andriy.shevchenko@linux.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20230811131330.71263-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

On 8/11/23 15:13, Andy Shevchenko wrote:
> We have a common helper to represent a boolean value as "on"/"off"
> string. Use it for the sake of the unified style.
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
>  drivers/platform/x86/amd/pmf/cnqf.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/platform/x86/amd/pmf/cnqf.c b/drivers/platform/x86/amd/pmf/cnqf.c
> index 539b186e9027..bc8899e15c91 100644
> --- a/drivers/platform/x86/amd/pmf/cnqf.c
> +++ b/drivers/platform/x86/amd/pmf/cnqf.c
> @@ -8,6 +8,7 @@
>   * Author: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
>   */
>  
> +#include <linux/string_choices.h>
>  #include <linux/workqueue.h>
>  #include "pmf.h"
>  
> @@ -399,7 +400,7 @@ static ssize_t cnqf_enable_store(struct device *dev,
>  			amd_pmf_set_sps_power_limits(pdev);
>  	}
>  
> -	dev_dbg(pdev->dev, "Received CnQF %s\n", input ? "on" : "off");
> +	dev_dbg(pdev->dev, "Received CnQF %s\n", str_on_off(input));
>  	return count;
>  }
>  
> @@ -409,7 +410,7 @@ static ssize_t cnqf_enable_show(struct device *dev,
>  {
>  	struct amd_pmf_dev *pdev = dev_get_drvdata(dev);
>  
> -	return sysfs_emit(buf, "%s\n", pdev->cnqf_enabled ? "on" : "off");
> +	return sysfs_emit(buf, "%s\n", str_on_off(pdev->cnqf_enabled));
>  }
>  
>  static DEVICE_ATTR_RW(cnqf_enable);


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCE7A78A97E
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 12:00:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230253AbjH1J76 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 05:59:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230248AbjH1J7l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 05:59:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 558F2B2
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 02:58:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1693216736;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TGsQ5davrprsdQETX+pkvJMdENgpfuEcOIYHperKLGU=;
        b=GmTfXBpuFvLF7xLqhTr/+llFZBzWilEemqlu1NPgV2YOm2JvvldLxwC0HwcCBezIZobOxQ
        R6cZEcNMAwkqXOZBgFACgKZrOUJ+fPaYCDt7lOFQpGkv0P7FPD1J5aghg0iQ3UZntpSqgM
        8W+E2dOZn4D3VcGaMspkvag4O/bBoU0=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-57-TLpWofb8NIOZbkklxoW6ZA-1; Mon, 28 Aug 2023 05:58:54 -0400
X-MC-Unique: TLpWofb8NIOZbkklxoW6ZA-1
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-51da39aa6dcso2601391a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 02:58:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693216733; x=1693821533;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TGsQ5davrprsdQETX+pkvJMdENgpfuEcOIYHperKLGU=;
        b=SRBAF9wh/JPXO16L2BgbOw1yWP6u6FKD2P1eDSrpoX4JZeDFgjUhJfnQmGVmrJDLQi
         EBka+SjMF/KnCRDSzdqxc3oPWJYuy9cY6UKv6zRy9RFj7Rh1A4XoZVheh1l4Ep0Y+pYU
         U8pmofVh6ji5B8sG+2Id7kAUbdfNI1ZI3m/p0u6cJPB7GXHfQ+7ZhPVzDBOqLddBURzg
         6P8rfMJIyy6iIyRzZfhraHPtcGFULrKDthyJyoduNvPptWY2r7yPIs9jseOR9bLZaj5F
         tOP92ddlRX0gtNJPA5D1iqXRQXx2ik7pBtEA26qj/n7EAuqUAXXcEfPiiv+2SMA7y/0e
         NoJA==
X-Gm-Message-State: AOJu0Yy5CuKz9tRW+6Fn5UtIuCkuW1+8vynG54lYNG/B1jtLfGxe9QXd
        lM1fdHTRC5z58xPEGkTD864lxHm1PKBUsKPJN08MBRnGxpO+sRiu79x1MuREM/voBxWWLtXXz6K
        4bk1eJol4jp0BGuLQldV1ngl4FFvV2E/P
X-Received: by 2002:aa7:d058:0:b0:522:1d23:a1f8 with SMTP id n24-20020aa7d058000000b005221d23a1f8mr19329641edo.26.1693216733080;
        Mon, 28 Aug 2023 02:58:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEmVcyQHIxT7y/Nbt26ZcVCAGNxVQ40kaqfma/E1FnS3UuKSSCS5hDVhojjnN2DyVGiFX1teA==
X-Received: by 2002:aa7:d058:0:b0:522:1d23:a1f8 with SMTP id n24-20020aa7d058000000b005221d23a1f8mr19329628edo.26.1693216732811;
        Mon, 28 Aug 2023 02:58:52 -0700 (PDT)
Received: from [10.40.98.142] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id k8-20020a05640212c800b0052a3b212157sm4244434edx.63.2023.08.28.02.58.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Aug 2023 02:58:51 -0700 (PDT)
Message-ID: <32942803-b0b9-ddcd-90f7-1fc37062a18f@redhat.com>
Date:   Mon, 28 Aug 2023 11:58:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] platform/x86: asus-wmi: corrections to egpu safety check
Content-Language: en-US
To:     "Luke D. Jones" <luke@ljones.dev>
Cc:     corentin.chary@gmail.com, markgross@kernel.org,
        linux-kernel@vger.kernel.org
References: <20230827231525.78693-1-luke@ljones.dev>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20230827231525.78693-1-luke@ljones.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Luke,

On 8/28/23 01:15, Luke D. Jones wrote:
> An incorrect if statement was preventing the enablement of the egpu.
> 
> Fixes: 1bddf53ccac0 ("platform/x86: asus-wmi: don't allow eGPU switching if eGPU not connected")
> Signed-off-by: Luke D. Jones <luke@ljones.dev>

Not sure which tree/branch this is based on but the commit-id for your Fixes:
is not correct.

in my tree this is commit d49f4d1a30ac (platform/x86: asus-wmi: don't allow
eGPU switching if eGPU not connected") .



> ---
>  drivers/platform/x86/asus-wmi.c | 15 +++++++--------
>  1 file changed, 7 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
> index 6db2d18a61e0..b51586986450 100644
> --- a/drivers/platform/x86/asus-wmi.c
> +++ b/drivers/platform/x86/asus-wmi.c
> @@ -731,19 +731,18 @@ static ssize_t egpu_enable_store(struct device *dev,
>  		return -EINVAL;
>  
>  	result = asus_wmi_get_devstate_simple(asus, ASUS_WMI_DEVID_EGPU_CONNECTED);

And this does not apply, because the:

	result = asus_wmi_get_devstate_simple()

you have here has been fixed in my tree to be

	err = asus_wmi_get_devstate_simple()

to match the error checks below which actually check "err" not "result"
I guess that a fix for this being squashed into my tree is also what
has resulted in the different commit ids.

Please rebase on top of:

https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=for-next

and submit a new version.

And please also Cc: platform-driver-x86@vger.kernel.org for the next version.

Regards,

Hans


> -	if (err < 0)
> -		return err;
> -	if (err < 1) {
> -		err = -ENODEV;
> -		pr_warn("Failed to set egpu disable: %d\n", err);
> +	if (err < 0) {
> +		pr_warn("Failed to get egpu connection status: %d\n", err);
>  		return err;
>  	}
>  
>  	if (asus->gpu_mux_mode_available) {
>  		result = asus_wmi_get_devstate_simple(asus, ASUS_WMI_DEVID_GPU_MUX);
> -		if (result < 0)
> +		if (result < 0) {
>  			/* An error here may signal greater failure of GPU handling */
> +			pr_warn("Failed to get gpu mux status: %d\n", err);
>  			return result;
> +		}
>  		if (!result && enable) {
>  			err = -ENODEV;
>  			pr_warn("Can not enable eGPU when the MUX is in dGPU mode: %d\n", err);
> @@ -753,12 +752,12 @@ static ssize_t egpu_enable_store(struct device *dev,
>  
>  	err = asus_wmi_set_devstate(ASUS_WMI_DEVID_EGPU, enable, &result);
>  	if (err) {
> -		pr_warn("Failed to set egpu disable: %d\n", err);
> +		pr_warn("Failed to set egpu state: %d\n", err);
>  		return err;
>  	}
>  
>  	if (result > 1) {
> -		pr_warn("Failed to set egpu disable (retval): 0x%x\n", result);
> +		pr_warn("Failed to set egpu state (retval): 0x%x\n", result);
>  		return -EIO;
>  	}
>  


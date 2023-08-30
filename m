Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 294DF78DE36
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 21:03:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236176AbjH3S7c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 14:59:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244572AbjH3NV1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 09:21:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70F461A3
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 06:20:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1693401631;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5CyHpSeJuiY1IirS3vd5gHIYSz7rC/rBYpdbUqUGYGA=;
        b=FQOOZPZg2gJIEMrZcOb8KLkHSMEHZ0XCfUix69KeoTWQfr58XuEfNdi5jS2CO2Ym4POOzb
        nxMD93hjRl8P6eH6uq4m0zowB+2FscGuqUngLCZ4EwXrg3Oq0/P0dTin3xAlX9AzbJpmuX
        WcWAIKmgnNbi5QnTA+QNte7bLy2nL2A=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-35-PjArZqP9NPmGpBypFyLOFQ-1; Wed, 30 Aug 2023 09:20:29 -0400
X-MC-Unique: PjArZqP9NPmGpBypFyLOFQ-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-30e3ee8a42eso3335167f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 06:20:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693401628; x=1694006428;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5CyHpSeJuiY1IirS3vd5gHIYSz7rC/rBYpdbUqUGYGA=;
        b=NEkoPZic/Z38cJnB7cHQ8Y7ADYPGx/ZgEyHZhBmKFs+4nNf4B/rzEf5WkVsc4aA++h
         YaUXLXixvPwK6aClLq6GqcFcoRwMEenSCKNkslaf7NnfBIWgtqflNnl0wBgghr+CZDad
         7q82yuUaJEipN5VCupgtbVJh9M8HzfpV2VbkIhiQcTjYxTfRjSvd+22yk7bfEg+YOfUa
         +M1hrNT51Yvg5Dqt3kyywu7bu0rxgCQfWkrIoIBnsQjR5/iyuZ9oJbRbITJRgLtTGLis
         aqhAPeleh7ZbYwda+a2VXZ5vWFfbASgIySWgMBEcbGnJoQ5kdZkmIWhC5FvhtKLSPcPY
         Vuww==
X-Gm-Message-State: AOJu0YzZIqkl6ae0r7cBBTXGXzgkv8b3fa961dHO3IspV3s8MzU395zf
        dooFkiz8pN3GG6SiL5onKOcEflBMY6CAHNQwAvZz7PVO+yoMIzAxQYMnX5ECwArpJBstQiUY0VF
        USDmAW/H7mvsRYJ2Rbf/f5waL1HItsA7n
X-Received: by 2002:a05:6000:1b07:b0:319:5a7c:6418 with SMTP id f7-20020a0560001b0700b003195a7c6418mr1873694wrz.43.1693401628350;
        Wed, 30 Aug 2023 06:20:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFFLiqBeI59Svx3p9VJvdvoiB3GXCVxyvVIzhXufgJ29dZw5qcPzzFa4WfZoV2R1WVn1srdaA==
X-Received: by 2002:a05:6000:1b07:b0:319:5a7c:6418 with SMTP id f7-20020a0560001b0700b003195a7c6418mr1873673wrz.43.1693401627973;
        Wed, 30 Aug 2023 06:20:27 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id n4-20020a170906688400b0099cf840527csm7125425ejr.153.2023.08.30.06.20.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Aug 2023 06:20:26 -0700 (PDT)
Message-ID: <0bf2e95f-7039-79a0-13eb-54c7d99eaecd@redhat.com>
Date:   Wed, 30 Aug 2023 15:20:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 1/1] platform/x86: asus-wmi: corrections to egpu safety
 check
Content-Language: en-US, nl
To:     =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        "Luke D. Jones" <luke@ljones.dev>
Cc:     corentin.chary@gmail.com, markgross@kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org
References: <20230830022908.36264-1-luke@ljones.dev>
 <20230830022908.36264-2-luke@ljones.dev>
 <24d07d16-5562-3737-7fe0-827b5145f2a8@linux.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <24d07d16-5562-3737-7fe0-827b5145f2a8@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

On 8/30/23 13:31, Ilpo Järvinen wrote:
> On Wed, 30 Aug 2023, Luke D. Jones wrote:
> 
>> An incorrect if statement was preventing the enablement of the egpu.
>>
>> Fixes: d49f4d1a30ac ("platform/x86: asus-wmi: don't allow eGPU switching if eGPU not connected")
>>
>> Signed-off-by: Luke D. Jones <luke@ljones.dev>
> 
> Please don't leave extra spaces into tags block.
> 
>> ---
>>  drivers/platform/x86/asus-wmi.c | 15 +++++++--------
>>  1 file changed, 7 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
>> index 9783893d2d6e..f54178d6f780 100644
>> --- a/drivers/platform/x86/asus-wmi.c
>> +++ b/drivers/platform/x86/asus-wmi.c
>> @@ -726,19 +726,18 @@ static ssize_t egpu_enable_store(struct device *dev,
>>  		return -EINVAL;
>>  
>>  	err = asus_wmi_get_devstate_simple(asus, ASUS_WMI_DEVID_EGPU_CONNECTED);
>> -	if (err < 0)
>> -		return err;
>> -	if (err < 1) {
>> -		err = -ENODEV;
>> -		pr_warn("Failed to set egpu disable: %d\n", err);
>> +	if (err < 0) {
>> +		pr_warn("Failed to get egpu connection status: %d\n", err);
> 
> So this is the Fixes: part? You should make own patch out of it.
> 
>>  		return err;
>>  	}
>>  
>>  	if (asus->gpu_mux_mode_available) {
>>  		result = asus_wmi_get_devstate_simple(asus, ASUS_WMI_DEVID_GPU_MUX);
>> -		if (result < 0)
>> +		if (result < 0) {
>>  			/* An error here may signal greater failure of GPU handling */
>> +			pr_warn("Failed to get gpu mux status: %d\n", err);
>>  			return result;
>> +		}
>>  		if (!result && enable) {
>>  			err = -ENODEV;
>>  			pr_warn("Can not enable eGPU when the MUX is in dGPU mode: %d\n", err);
>> @@ -748,12 +747,12 @@ static ssize_t egpu_enable_store(struct device *dev,
>>  
>>  	err = asus_wmi_set_devstate(ASUS_WMI_DEVID_EGPU, enable, &result);
>>  	if (err) {
>> -		pr_warn("Failed to set egpu disable: %d\n", err);
>> +		pr_warn("Failed to set egpu state: %d\n", err);
>>  		return err;
>>  	}
>>  
>>  	if (result > 1) {
>> -		pr_warn("Failed to set egpu disable (retval): 0x%x\n", result);
>> +		pr_warn("Failed to set egpu state (retval): 0x%x\n", result);
>>  		return -EIO;
>>  	}
>>  
>>
> 
> These others are good changes too but just not to be made in the same 
> patch.

Ilpo, you are right this should have really been 2 patches.

But the other changes are fixes (correction of wrong error messages) too,
which would be good to get out there.

So I've decided to take this as is, so that this can be included in
the main pdx86 pull-req for 6.6:

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



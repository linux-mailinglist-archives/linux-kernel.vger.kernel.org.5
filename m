Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F8F1783162
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 21:51:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229833AbjHUTP2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 15:15:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbjHUTP1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 15:15:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A879B1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 12:14:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692645278;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QhOSpxI2PDYs2OJIu7QJVbJYNk9LCU0AkkLRkJu15pg=;
        b=GuPrLB6/ArmvEhwmv5dBIWcrvdKLF7CaEAjeQK48BOI9vn+3f3aqFMas2yWPcXw2yrF3iJ
        vvRax4zGHe7nrR+g43lg85biFZGMkTsqcofZYv4FG9M4K9ntBi++MOgEMvvnl6Ik15z/Am
        qTIaLJdgkZnNVTUdJda/m+bTR0X4GLU=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-327-8qH561vVMJOguRcxVr-n0g-1; Mon, 21 Aug 2023 15:14:36 -0400
X-MC-Unique: 8qH561vVMJOguRcxVr-n0g-1
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-4ff9b3ead6fso3366971e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 12:14:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692645275; x=1693250075;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QhOSpxI2PDYs2OJIu7QJVbJYNk9LCU0AkkLRkJu15pg=;
        b=d7XdKiVZiHfi6bxaVPNTPOiAlxH4zoy+ppftypUsYvqg3KHKC+WDYOcB+wDQ2dpkai
         JfM04zS9ukYR+KYgPhS6OseEOPtS2ZC6JCVrLrgwkRrYXXFAUIqQj+MPIytaLo8CkYWA
         ZfF/h3Wi7ae5mCrtD4/e0BKDl5+aZFgxzNVGsHlYF+eeTk3fkrP55Igd9l77IIU4bQuV
         IrOwIH66e3FyKRP8lS6hyGrlVzbWdTehU7fiZ2UoPIQw0Ej4F5E9KX1osKx+SvtGqMQ+
         5M9XQIFNW2WesgMHDu3Mr+rOnBHyu7upd2JgaXL1Nrzi5ntOT56/p9H0UoG0t5Dp389Y
         qd9Q==
X-Gm-Message-State: AOJu0YwASI4MuyOud5qjfdRyxIUqsQHhD9pfr9NX0k2Z0xGPEkIS7Vkm
        y1MeGbt2G56F2zJ5eKOURcAo5FU3QViwc0l+NyvT/M5H5o0lu+Hd4fIzSVoxJicXlSiHSbnhfpU
        WEckUJKm3Nph82ZLf7aOneqpO
X-Received: by 2002:a05:6512:1192:b0:4fd:f85d:f67a with SMTP id g18-20020a056512119200b004fdf85df67amr6657045lfr.61.1692645275103;
        Mon, 21 Aug 2023 12:14:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEkPlo4TwcFOenNEUGpTvSs1j7u5WzB1RXf9hPFdX9z12+DHZYiX3tXqtVjXcSZ23fl8469ww==
X-Received: by 2002:a05:6512:1192:b0:4fd:f85d:f67a with SMTP id g18-20020a056512119200b004fdf85df67amr6657036lfr.61.1692645274807;
        Mon, 21 Aug 2023 12:14:34 -0700 (PDT)
Received: from ?IPV6:2a02:810d:4b3f:de9c:642:1aff:fe31:a15c? ([2a02:810d:4b3f:de9c:642:1aff:fe31:a15c])
        by smtp.gmail.com with ESMTPSA id mb12-20020a170906eb0c00b0099bd5b72d93sm6980949ejb.43.2023.08.21.12.14.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Aug 2023 12:14:34 -0700 (PDT)
Message-ID: <3b841ef8-e361-5775-168b-fc6a4417415a@redhat.com>
Date:   Mon, 21 Aug 2023 21:14:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH drm-misc-next 1/3] drm: drm_exec: build always builtin
Content-Language: en-US
To:     =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        airlied@gmail.com, daniel@ffwll.ch, matthew.brost@intel.com,
        thomas.hellstrom@linux.intel.com, sarah.walker@imgtec.com,
        donald.robson@imgtec.com, boris.brezillon@collabora.com,
        faith.ekstrand@collabora.com, bskeggs@redhat.com,
        Liam.Howlett@oracle.com
Cc:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20230820215320.4187-1-dakr@redhat.com>
 <20230820215320.4187-2-dakr@redhat.com>
 <3462dfaa-96a4-61fd-b31b-fb8d8eb6104c@amd.com>
From:   Danilo Krummrich <dakr@redhat.com>
Organization: RedHat
In-Reply-To: <3462dfaa-96a4-61fd-b31b-fb8d8eb6104c@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/21/23 11:49, Christian König wrote:
> Am 20.08.23 um 23:53 schrieb Danilo Krummrich:
>> drm_exec must always be builtin for the DRM GPUVA manager to depend on
>> it.
> 
> You should probably go the other way around and not always build in the 
> GPUVA manager.

Yes, I think that's reasonable. Currently, I don't see any core 
dependencies preventing that.

> 
> We have intentionally and with quite a bit of work moved the DRM_EXEC 
> and DRM_BUDDY into separate modules.
> 
> Regards,
> Christian.
> 
>>
>> Signed-off-by: Danilo Krummrich <dakr@redhat.com>
>> ---
>>   drivers/gpu/drm/Kconfig         | 6 ------
>>   drivers/gpu/drm/Makefile        | 3 +--
>>   drivers/gpu/drm/nouveau/Kconfig | 1 -
>>   3 files changed, 1 insertion(+), 9 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
>> index ab9ef1c20349..85122d4bb1e7 100644
>> --- a/drivers/gpu/drm/Kconfig
>> +++ b/drivers/gpu/drm/Kconfig
>> @@ -210,12 +210,6 @@ config DRM_TTM_KUNIT_TEST
>>             If in doubt, say "N".
>> -config DRM_EXEC
>> -    tristate
>> -    depends on DRM
>> -    help
>> -      Execution context for command submissions
>> -
>>   config DRM_BUDDY
>>       tristate
>>       depends on DRM
>> diff --git a/drivers/gpu/drm/Makefile b/drivers/gpu/drm/Makefile
>> index 215e78e79125..388e0964a875 100644
>> --- a/drivers/gpu/drm/Makefile
>> +++ b/drivers/gpu/drm/Makefile
>> @@ -23,6 +23,7 @@ drm-y := \
>>       drm_dumb_buffers.o \
>>       drm_edid.o \
>>       drm_encoder.o \
>> +    drm_exec.o \
>>       drm_file.o \
>>       drm_fourcc.o \
>>       drm_framebuffer.o \
>> @@ -80,8 +81,6 @@ obj-$(CONFIG_DRM_PANEL_ORIENTATION_QUIRKS) += 
>> drm_panel_orientation_quirks.o
>>   # Memory-management helpers
>>   #
>>   #
>> -obj-$(CONFIG_DRM_EXEC) += drm_exec.o
>> -
>>   obj-$(CONFIG_DRM_BUDDY) += drm_buddy.o
>>   drm_dma_helper-y := drm_gem_dma_helper.o
>> diff --git a/drivers/gpu/drm/nouveau/Kconfig 
>> b/drivers/gpu/drm/nouveau/Kconfig
>> index c52e8096cca4..2dddedac125b 100644
>> --- a/drivers/gpu/drm/nouveau/Kconfig
>> +++ b/drivers/gpu/drm/nouveau/Kconfig
>> @@ -10,7 +10,6 @@ config DRM_NOUVEAU
>>       select DRM_KMS_HELPER
>>       select DRM_TTM
>>       select DRM_TTM_HELPER
>> -    select DRM_EXEC
>>       select DRM_SCHED
>>       select I2C
>>       select I2C_ALGOBIT
> 


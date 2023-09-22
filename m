Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03B1E7AB49F
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 17:19:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232663AbjIVPSm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 11:18:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232677AbjIVPSg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 11:18:36 -0400
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E70F199;
        Fri, 22 Sep 2023 08:18:29 -0700 (PDT)
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3ae0b0e9a0bso972779b6e.3;
        Fri, 22 Sep 2023 08:18:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695395908; x=1696000708;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rH3oex4JuuDiGcojuJxgW82OemDVXIWofXHS33ZWUIc=;
        b=wfOHFqijGBDuHWwdg+xAAjFjejFVB/3xLd11QWj4UjffT89mIxxUX+VYNz2vURUrX2
         zVll98T0k8tELV7tIz01XIiqL9e1S47y17rU6Kcf92g0iTLtrQ5ud0TEprZh7lx3EMCz
         UYo/ta6KZwXU4BE2oyA2HGbL7BjA0lzjYqhBDiHct39yXF0otD1V5LpioM/mNWGUPwmt
         Bb/YZHspQWTR5wbkWqHVrZmGA4NZxelBywBcbmIsqsAFYMA1SVg/CK2OfBhOgWYdOleQ
         u9ejrbXDuRL0ZP/pMcfdo1EzW/h0F+TDqKGaAP6tww/oGZCl+eK5/eXWIQyjuJv7Pdi2
         Faew==
X-Gm-Message-State: AOJu0Yxe264e/QOUncOxmhjakzr5rLehTbSoQa/wZMnEMOTNI3ntJ5sJ
        IKVed1vzUOi037PzuNdcqHw=
X-Google-Smtp-Source: AGHT+IFL6jnK+1VnWoA0BKTfkAGhIIR5uNawDr9oaB9oYV3du5gT/rycKVzQ024myLLafN53aeC+bQ==
X-Received: by 2002:a05:6808:df4:b0:3a9:307a:62aa with SMTP id g52-20020a0568080df400b003a9307a62aamr8363337oic.22.1695395908443;
        Fri, 22 Sep 2023 08:18:28 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:70e9:c86f:4352:fcc? ([2620:15c:211:201:70e9:c86f:4352:fcc])
        by smtp.gmail.com with ESMTPSA id y5-20020aa78045000000b0069048fe6c8esm3302905pfm.203.2023.09.22.08.18.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Sep 2023 08:18:28 -0700 (PDT)
Message-ID: <ce9cef41-29e2-4056-a60b-b0e4ee1cc17e@acm.org>
Date:   Fri, 22 Sep 2023 08:18:26 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] scsi: scsi_error: Fix device reset is not triggered
Content-Language: en-US
To:     Wenchao Hao <haowenchao2@huawei.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        open-iscsi@googlegroups.com, linux-scsi@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, louhongxiang@huawei.com
References: <20230922093636.2645961-1-haowenchao2@huawei.com>
 <20230922093636.2645961-3-haowenchao2@huawei.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20230922093636.2645961-3-haowenchao2@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/22/23 02:36, Wenchao Hao wrote:
> Fix the issue of skipping scsi_try_bus_device_reset() for devices
> which is in progress of removing in following order:
> 
> T1:					T2:scsi_error_handle
> __scsi_remove_device
>    scsi_device_set_state(sdev, SDEV_DEL)
> 					// would skip device with SDEV_DEL state
>    					shost_for_each_device()
> 					  scsi_try_bus_device_reset
> 					flush all commands
>   ...
>   scsi_device is released
> 
> Some drivers like smartpqi only implement eh_device_reset_handler,
> if device reset is skipped, the commands which had been sent to
> firmware or devices hardware are not cleared. The error handle
> would flush all these commands in scsi_unjam_host().
> 
> When the commands are finished by hardware, use after free issue is
> triggered.
> 
> Add parameter "check_state" to macro shost_for_each_device() to
> determine if check device status when traversal scsi_device
> of Scsi_Host, and set this parameter to false when traversal
> in scsi_error_handle to address this issue.

The above is incomprehensible to me. Please explain more clearly why 
this change is needed.

> diff --git a/drivers/scsi/scsi.c b/drivers/scsi/scsi.c
> index d0911bc28663..db8b9e42267c 100644
> --- a/drivers/scsi/scsi.c
> +++ b/drivers/scsi/scsi.c
> @@ -704,6 +704,23 @@ int scsi_cdl_enable(struct scsi_device *sdev, bool enable)
>   	return 0;
>   }
>   
> +static int __scsi_device_get(struct scsi_device *sdev, bool check_state)

"check_state" is a bad argument name because it does not clearly explain 
the purpose of this argument. Would "include_deleted" perhaps be a 
better name?

> +{
> +	if (check_state &&
> +	    (sdev->sdev_state == SDEV_DEL || sdev->sdev_state == SDEV_CANCEL))
> +		goto fail;
> +	if (!try_module_get(sdev->host->hostt->module))
> +		goto fail;
> +	if (!get_device(&sdev->sdev_gendev))
> +		goto fail_put_module;
> +	return 0;
> +
> +fail_put_module:
> +	module_put(sdev->host->hostt->module);
> +fail:
> +	return -ENXIO;
> +}

Looking at the above code, I think we need two functions: one that does 
not include the sdev->sdev_state check and a second function that 
includes the sdev->sdev_state check (scsi_device_get()) and calls the 
first. That will result in code that is easier to read than calls to a 
function with a boolean argument.

> diff --git a/include/scsi/scsi_device.h b/include/scsi/scsi_device.h
> index c498a12f7715..e166d053c839 100644
> --- a/include/scsi/scsi_device.h
> +++ b/include/scsi/scsi_device.h
> @@ -389,21 +389,25 @@ extern void __starget_for_each_device(struct scsi_target *, void *,
>   
>   /* only exposed to implement shost_for_each_device */
>   extern struct scsi_device *__scsi_iterate_devices(struct Scsi_Host *,
> -						  struct scsi_device *);
> +						  struct scsi_device *,
> +						  bool);
>   
>   /**
>    * shost_for_each_device - iterate over all devices of a host
>    * @sdev: the &struct scsi_device to use as a cursor
>    * @shost: the &struct scsi_host to iterate over
> + * @check_state: if skip check scsi_device's state to skip some devices
> + *               scsi_device with SDEV_DEL or SDEV_CANCEL would be skipped
> + *               if this is true
>    *
>    * Iterator that returns each device attached to @shost.  This loop
>    * takes a reference on each device and releases it at the end.  If
>    * you break out of the loop, you must call scsi_device_put(sdev).
>    */
> -#define shost_for_each_device(sdev, shost) \
> -	for ((sdev) = __scsi_iterate_devices((shost), NULL); \
> +#define shost_for_each_device(sdev, shost, check_state) \
> +	for ((sdev) = __scsi_iterate_devices((shost), NULL, check_state); \
>   	     (sdev); \
> -	     (sdev) = __scsi_iterate_devices((shost), (sdev)))
> +	     (sdev) = __scsi_iterate_devices((shost), (sdev), check_state))
>   
>   /**
>    * __shost_for_each_device - iterate over all devices of a host (UNLOCKED)

Since only the SCSI error handler passes 0 as 'check_state' argument to 
shost_for_each_device(), instead of adding a boolean argument to that 
macro, please do the following:
* Introduce a new macro for the check_state = 1 case.
* Keep the semantics for shost_for_each_device().

With this approach no SCSI LLDs will have to be modified.

Thanks,

Bart.

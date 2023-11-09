Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 143A87E7124
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 19:06:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344941AbjKISGK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 13:06:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344811AbjKISGH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 13:06:07 -0500
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71E4C3A92;
        Thu,  9 Nov 2023 10:06:05 -0800 (PST)
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6b1d1099a84so1222813b3a.1;
        Thu, 09 Nov 2023 10:06:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699553165; x=1700157965;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fcU3cqWmeYEc8M7LFBLc/ovxLDKr3wrjLBH6khDlR80=;
        b=ppgkg8p3lM4trJQgE7ygUJ5hH4qYke4/GX5MsjYuu2aD47Cx7tl9R4oOB5CX+dySDK
         cgvUnXY6RLnHhBuKgDrGYhHJ0f2b6INEQm/r6VGVJabfnpWTQdedkhpa/tT6w3YY4m48
         GicUblmABnAnx3QajR3ngVupp/1PMypaMbZBqwuvwBsEh6uqWFz6rNeIrT/W7amNSFae
         9i3WKP22QsLyBUyYwCgGZzU4gLUeqQki3HoCySSjCmp2NhSqDYwmtxvOn9Ez/wq1VKhM
         P3Wx9X3UTxNZDxOhR9bmXaNinuhv2T2G2Eb1hwABUhbtfJOg/JGR3KXqE1+SsqkI6msQ
         oTfQ==
X-Gm-Message-State: AOJu0Yw1j7Rt6icsr75/x2WeFzoil2KnYgc9Ugv78JMwhiwDSi9i4pjq
        cpjqQiI3D48CqCUPAjnYR5TphkfhBCY=
X-Google-Smtp-Source: AGHT+IEp/GRnR0EqiboCHXyJC9BVAybeW22IUjOUYtV8AGykHa9A1xMf+HwtdNCtPfmVWkAGjnPaZg==
X-Received: by 2002:a05:6a20:8f13:b0:15e:d84:1c5e with SMTP id b19-20020a056a208f1300b0015e0d841c5emr6868531pzk.38.1699553164679;
        Thu, 09 Nov 2023 10:06:04 -0800 (PST)
Received: from ?IPV6:2620:0:1000:8411:3dcd:f87f:1890:c48e? ([2620:0:1000:8411:3dcd:f87f:1890:c48e])
        by smtp.gmail.com with ESMTPSA id ff24-20020a056a002f5800b0069337938be8sm10932129pfb.110.2023.11.09.10.06.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Nov 2023 10:06:04 -0800 (PST)
Message-ID: <e1ac57a7-920f-44c4-92d3-960811edede9@acm.org>
Date:   Thu, 9 Nov 2023 10:06:02 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] scsi: ufs: core: Add UFS RTC support
Content-Language: en-US
To:     Bean Huo <beanhuo@iokpp.de>, avri.altman@wdc.com,
        alim.akhtar@samsung.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, stanley.chu@mediatek.com,
        mani@kernel.org, quic_cang@quicinc.com, quic_asutoshd@quicinc.com,
        beanhuo@micron.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        mikebi@micron.com, lporzio@micron.com
References: <20231109125217.185462-1-beanhuo@iokpp.de>
 <20231109125217.185462-2-beanhuo@iokpp.de>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20231109125217.185462-2-beanhuo@iokpp.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/9/23 04:52, Bean Huo wrote:
> The objective of this patch is to incorporate Real Time Clock (RTC) support in Universal
> Flash Storage (UFS) device. This enhancement is crucial for the internal maintenance
> operations of the UFS device.

That sounds vague. Please explain why a UFS device should know the real
time since other storage devices don't need to know the real time.

> +		dev_info->rtc_time_baseline = mktime64(2010, 1, 1, 0, 0, 0) -
> +								mktime64(1970, 1, 1, 0, 0, 0);

The formatting of the above code is not compliant with the kernel coding
style. Please consider reformatting this patch with e.g.
git clang-format HEAD^.

> +	schedule_delayed_work(&hba->ufs_rtc_delayed_work,
> +							msecs_to_jiffies(UFS_RTC_UPDATE_EVERY_MS));

The formatting of the above code is not compliant with the style guide
either.

> @@ -9746,6 +9834,8 @@ static int __ufshcd_wl_suspend(struct ufs_hba *hba, enum ufs_pm_op pm_op)
>   	ret = ufshcd_vops_suspend(hba, pm_op, POST_CHANGE);
>   	if (ret)
>   		goto set_link_active;
> +
> +	cancel_delayed_work(&hba->ufs_rtc_delayed_work);

Why cancel_delayed_work() instead of cancel_delayed_work_sync()?

> @@ -9840,6 +9930,8 @@ static int __ufshcd_wl_resume(struct ufs_hba *hba, enum ufs_pm_op pm_op)
>   		if (ret)
>   			goto set_old_link_state;
>   		ufshcd_set_timestamp_attr(hba);
> +		schedule_delayed_work(&hba->ufs_rtc_delayed_work,
> +							msecs_to_jiffies(UFS_RTC_UPDATE_EVERY_MS));

The name of the constant "UFS_RTC_UPDATE_EVERY_MS" suggests that the
real-time clock is updated 1000 times per second while the comment above
the UFS_RTC_UPDATE_EVERY_MS constant says that it is updated once every
ten seconds. Please choose a better name for UFS_RTC_UPDATE_EVERY_MS,
e.g. UFS_RTC_UPDATE_INTERVAL_MS.

> diff --git a/include/ufs/ufs.h b/include/ufs/ufs.h
> index e77ab1786856..18b39c6b3a97 100644
> --- a/include/ufs/ufs.h
> +++ b/include/ufs/ufs.h
> @@ -14,6 +14,7 @@
>   #include <linux/bitops.h>
>   #include <linux/types.h>
>   #include <uapi/scsi/scsi_bsg_ufs.h>
> +#include <linux/rtc.h>

The include/ufs/ufs.h header file does not depend on anything declared
in <linux/rtc.h> so please move the above include directive into a .c
file.

> +	struct delayed_work ufs_rtc_delayed_work;

Please change the name of this structure member into
ufs_rtc_update_work.

Thanks,

Bart.


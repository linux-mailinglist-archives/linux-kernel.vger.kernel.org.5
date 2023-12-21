Return-Path: <linux-kernel+bounces-9002-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 595BE81BF27
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 20:30:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A9011C23FFE
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 19:30:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D1BD6E2A1;
	Thu, 21 Dec 2023 19:30:36 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5E9B634F7;
	Thu, 21 Dec 2023 19:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1d3e6c86868so9593975ad.1;
        Thu, 21 Dec 2023 11:30:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703187034; x=1703791834;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PaCuQQl7ykZXPvtbV2jmLW6ZX1gazXmMk5DzScPV8kQ=;
        b=wdjEQhQ9NpKcxy7MVLjIdsHVOMIS/mjRE8yT/82e9JLp4ji0Y+0tFHJ9MSQIHLvAhs
         WMO3zMEEBl/6vjQ/jeLcZ6z/32J8dW+UFft19pt7kSjFrr8wVbJBOM6RLr3MSRi28bkM
         VXRnizyuYkdXMBg7Eta5z0np4X4WpNY9QS20fQE8dbGNanJifJfhpOAcwCZ+vjF5OR6n
         HTTRC7Eaea6STKs8nsTAAjVt9k8VHBxGY4MOYDTnmqfzz9XpqTKOknHaKY+a7+Y95GD8
         ETW6vSZZ8ar1bfjrKPOioT4GWfvWjuYkz0qcw1/wHUsJxJi+lotJBIuFUamQkWxwWnBT
         x2Cg==
X-Gm-Message-State: AOJu0YwfxjNSweosfpsCV87gEtB18h1n3owWWVdfTfPmHPl4x+P4jVn9
	S/HDHSO7UHc+sQUniH018ho=
X-Google-Smtp-Source: AGHT+IGepjzFq9j/dF+YLX4nSwBc5YNSkf3wiaTW8FLOAYRR3psWsCWFF+YYf0IUgwZDQFzHrxazLQ==
X-Received: by 2002:a17:902:b195:b0:1d0:afea:78a8 with SMTP id s21-20020a170902b19500b001d0afea78a8mr113124plr.106.1703187033971;
        Thu, 21 Dec 2023 11:30:33 -0800 (PST)
Received: from ?IPV6:2620:0:1000:8411:872c:d7b7:41e9:3edd? ([2620:0:1000:8411:872c:d7b7:41e9:3edd])
        by smtp.gmail.com with ESMTPSA id l17-20020a170902eb1100b001bf11cf2e21sm1995752plb.210.2023.12.21.11.30.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Dec 2023 11:30:33 -0800 (PST)
Message-ID: <ca0b2a81-c0a0-4392-bcc1-5590caf699c7@acm.org>
Date: Thu, 21 Dec 2023 11:30:31 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v3 07/11] scsi: ufs: core: Perform read back after
 writing UTP_TASK_REQ_LIST_BASE_H
Content-Language: en-US
To: Andrew Halaney <ahalaney@redhat.com>, Andy Gross <agross@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>,
 Manivannan Sadhasivam <mani@kernel.org>,
 "James E.J. Bottomley" <jejb@linux.ibm.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Hannes Reinecke <hare@suse.de>, Janek Kotas <jank@cadence.com>,
 Alim Akhtar <alim.akhtar@samsung.com>, Avri Altman <avri.altman@wdc.com>,
 Can Guo <quic_cang@quicinc.com>
Cc: Will Deacon <will@kernel.org>, linux-arm-msm@vger.kernel.org,
 linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231221-ufs-reset-ensure-effect-before-delay-v3-0-2195a1b66d2e@redhat.com>
 <20231221-ufs-reset-ensure-effect-before-delay-v3-7-2195a1b66d2e@redhat.com>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20231221-ufs-reset-ensure-effect-before-delay-v3-7-2195a1b66d2e@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/21/23 11:09, Andrew Halaney wrote:
> Currently, the UTP_TASK_REQ_LIST_BASE_L/UTP_TASK_REQ_LIST_BASE_H regs
> are written to and then completed with an mb().
> 
> mb() ensure that the write completes, but completion doesn't mean that
> it isn't stored in a buffer somewhere. The recommendation for
> ensuring these bits have taken effect on the device is to perform a read
> back to force it to make it all the way to the device. This is
> documented in device-io.rst and a talk by Will Deacon on this can
> be seen over here:
> 
>      https://youtu.be/i6DayghhA8Q?si=MiyxB5cKJXSaoc01&t=1678
> 
> Let's do that to ensure the bits hit the device. Because the mb()'s
> purpose wasn't to add extra ordering (on top of the ordering guaranteed
> by writel()/readl()), it can safely be removed.
> 
> Fixes: 88441a8d355d ("scsi: ufs: core: Add hibernation callbacks")
> Signed-off-by: Andrew Halaney <ahalaney@redhat.com>
> ---
>   drivers/ufs/core/ufshcd.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
> index d1e33328ff3f..7bfb556e5b8e 100644
> --- a/drivers/ufs/core/ufshcd.c
> +++ b/drivers/ufs/core/ufshcd.c
> @@ -10351,7 +10351,7 @@ int ufshcd_system_restore(struct device *dev)
>   	 * are updated with the latest queue addresses. Only after
>   	 * updating these addresses, we can queue the new commands.
>   	 */
> -	mb();
> +	ufshcd_readl(hba, REG_UTP_TASK_REQ_LIST_BASE_H);
>   
>   	/* Resuming from hibernate, assume that link was OFF */
>   	ufshcd_set_link_off(hba);

Reviewed-by: Bart Van Assche <bvanassche@acm.org>


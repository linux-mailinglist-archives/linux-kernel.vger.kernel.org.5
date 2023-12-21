Return-Path: <linux-kernel+bounces-9001-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6174081BF24
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 20:30:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EA84283ADD
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 19:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AC23651BD;
	Thu, 21 Dec 2023 19:30:14 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71053651A4;
	Thu, 21 Dec 2023 19:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1d3fc184b6dso7336335ad.2;
        Thu, 21 Dec 2023 11:30:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703187012; x=1703791812;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d1dx7ZnncvUoc4xiYNPKPOmold5iHR3uYlgOM1Y/vcQ=;
        b=PzdaNrOKT8O4K+hl3t1nMAGDnoRCyOsOuSa5yZpyOqdBj1jNfMQp59rNtVjYATLEV5
         Ntsv2JTnUCnLZe2w9zwwhMeF7k+6dPohjqjqmhicrMqScbi7lkxa3ZFAn7T2wTQG8Fy6
         mi62uWPbtC2b/1DZb2aJ6rhgu+Z4vRbNDfBePNNM6WGHhX4TkxY33MmQVmP5+0k8OUtW
         BN+vUknp0DNXpgUFR8jBoBr1gWYUqPf2KdfmmHz73YWkmeFiYdnUkKQ0LqbxyouPDnOm
         9vCgO370LEIiILUdf238XjBTbIelCznZ3pxkZGH0T2EZZWmRaRMDcnK7wrF7CQwXAZ/k
         xilw==
X-Gm-Message-State: AOJu0Yz2QxyymH3ZKDx8pcSIYzCQMmWjw7DoprCw/GTRwRIhQwTOYASB
	RXrzhKaAVhaJJkSC1zkAF9U=
X-Google-Smtp-Source: AGHT+IEP+D8u3nRJ95vHVRIIyZ1wodYaJ/oI3f8SRAuc+HEQrb4cTIHUFPRrwSCKwyO49ox0LLKFdA==
X-Received: by 2002:a17:902:f691:b0:1d4:17e3:2cbd with SMTP id l17-20020a170902f69100b001d417e32cbdmr97375plg.80.1703187011665;
        Thu, 21 Dec 2023 11:30:11 -0800 (PST)
Received: from ?IPV6:2620:0:1000:8411:872c:d7b7:41e9:3edd? ([2620:0:1000:8411:872c:d7b7:41e9:3edd])
        by smtp.gmail.com with ESMTPSA id l17-20020a170902eb1100b001bf11cf2e21sm1995752plb.210.2023.12.21.11.30.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Dec 2023 11:30:11 -0800 (PST)
Message-ID: <8f02738d-1b0d-4288-a971-c56d9fca0843@acm.org>
Date: Thu, 21 Dec 2023 11:30:09 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v3 08/11] scsi: ufs: core: Perform read back after
 disabling interrupts
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
 <20231221-ufs-reset-ensure-effect-before-delay-v3-8-2195a1b66d2e@redhat.com>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20231221-ufs-reset-ensure-effect-before-delay-v3-8-2195a1b66d2e@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/21/23 11:09, Andrew Halaney wrote:
> Currently, interrupts are cleared and disabled prior to registering the
> interrupt. An mb() is used to complete the clear/disable writes before
> the interrupt is registered.
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
> Let's do that to ensure these bits hit the device. Because the mb()'s
> purpose wasn't to add extra ordering (on top of the ordering guaranteed
> by writel()/readl()), it can safely be removed.
> 
> Fixes: 199ef13cac7d ("scsi: ufs: avoid spurious UFS host controller interrupts")
> Signed-off-by: Andrew Halaney <ahalaney@redhat.com>
> ---
>   drivers/ufs/core/ufshcd.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
> index 7bfb556e5b8e..bb603769b029 100644
> --- a/drivers/ufs/core/ufshcd.c
> +++ b/drivers/ufs/core/ufshcd.c
> @@ -10568,7 +10568,7 @@ int ufshcd_init(struct ufs_hba *hba, void __iomem *mmio_base, unsigned int irq)
>   	 * Make sure that UFS interrupts are disabled and any pending interrupt
>   	 * status is cleared before registering UFS interrupt handler.
>   	 */
> -	mb();
> +	ufshcd_readl(hba, REG_INTERRUPT_ENABLE);
>   
>   	/* IRQ registration */
>   	err = devm_request_irq(dev, irq, ufshcd_intr, IRQF_SHARED, UFSHCD, hba);

Reviewed-by: Bart Van Assche <bvanassche@acm.org>


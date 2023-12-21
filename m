Return-Path: <linux-kernel+bounces-9000-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9231E81BF21
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 20:29:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D57428340F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 19:29:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9E2B6A005;
	Thu, 21 Dec 2023 19:29:29 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1882A651A4;
	Thu, 21 Dec 2023 19:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6d939e2f594so1079143b3a.3;
        Thu, 21 Dec 2023 11:29:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703186967; x=1703791767;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=isgbB05I9gmbhRhZEbvGcuTPYSEEWRPDvwZ/VHZ02KA=;
        b=iNSoKxfZZ+TawdqpfJDSKH3H+lDdEuUOJKHNIPDVEnubOR1lXY1R69lT6rvsc2yXZR
         HF97v7J1M5nkhVbBr/8VYlvCAz0VjcEGkLIgbzBBP61oRnlkB0fMtNbYE6WrjgMci+jy
         OgxtQpBgNUZFG3Ce8V43Fe80fMa3aQl3y5KydrG+YxU0NX51B6BZFOhpntmMyaboUqlK
         M4QLeu7zjwQ2cmL70d2lA4cYJRaSft9/I9PkON3FaWHeEBldm98A/fhZoDHt8CepNlu4
         a1tVRhGjAb4eR6OzS9fk1x178NL/0oxvPlR0WTMQg5x2KPVIrjzufOBdkf0e04dDqOnX
         TLLg==
X-Gm-Message-State: AOJu0YxL/nfxoaCaUmYQA/chYKYtH1srKjODN2xw/neIBIA3Hj3kEojy
	5GVXFGmhGU+0Zz8hV1gqXBE=
X-Google-Smtp-Source: AGHT+IF6XBXqKRcYggPfQlrQGUgBhhTAozoiHYVprr7xk9uM0JUurX8rXL8NkaXdGTtjaODgQFGMuQ==
X-Received: by 2002:a17:903:41c4:b0:1d3:4c35:1791 with SMTP id u4-20020a17090341c400b001d34c351791mr146003ple.55.1703186967275;
        Thu, 21 Dec 2023 11:29:27 -0800 (PST)
Received: from ?IPV6:2620:0:1000:8411:872c:d7b7:41e9:3edd? ([2620:0:1000:8411:872c:d7b7:41e9:3edd])
        by smtp.gmail.com with ESMTPSA id l17-20020a170902eb1100b001bf11cf2e21sm1995752plb.210.2023.12.21.11.29.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Dec 2023 11:29:26 -0800 (PST)
Message-ID: <edd975a7-d87a-4876-8e3e-9c038b2be089@acm.org>
Date: Thu, 21 Dec 2023 11:29:25 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v3 09/11] scsi: ufs: core: Perform read back after
 disabling UIC_COMMAND_COMPL
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
 <20231221-ufs-reset-ensure-effect-before-delay-v3-9-2195a1b66d2e@redhat.com>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20231221-ufs-reset-ensure-effect-before-delay-v3-9-2195a1b66d2e@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/21/23 11:09, Andrew Halaney wrote:
> Currently, the UIC_COMMAND_COMPL interrupt is disabled and a wmb() is
> used to complete the register write before any following writes.
> 
> wmb() ensures the writes complete in that order, but completion doesn't
> mean that it isn't stored in a buffer somewhere. The recommendation for
> ensuring this bit has taken effect on the device is to perform a read
> back to force it to make it all the way to the device. This is
> documented in device-io.rst and a talk by Will Deacon on this can
> be seen over here:
> 
>      https://youtu.be/i6DayghhA8Q?si=MiyxB5cKJXSaoc01&t=1678
> 
> Let's do that to ensure the bit hits the device. Because the wmb()'s
> purpose wasn't to add extra ordering (on top of the ordering guaranteed
> by writel()/readl()), it can safely be removed.
> 
> Fixes: d75f7fe495cf ("scsi: ufs: reduce the interrupts for power mode change requests")
> Signed-off-by: Andrew Halaney <ahalaney@redhat.com>
> ---
>   drivers/ufs/core/ufshcd.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
> index bb603769b029..75a03ee9a1ba 100644
> --- a/drivers/ufs/core/ufshcd.c
> +++ b/drivers/ufs/core/ufshcd.c
> @@ -4240,7 +4240,7 @@ static int ufshcd_uic_pwr_ctrl(struct ufs_hba *hba, struct uic_command *cmd)
>   		 * Make sure UIC command completion interrupt is disabled before
>   		 * issuing UIC command.
>   		 */
> -		wmb();
> +		ufshcd_readl(hba, REG_INTERRUPT_ENABLE);
>   		reenable_intr = true;
>   	}
>   	spin_unlock_irqrestore(hba->host->host_lock, flags);

Reviewed-by: Bart Van Assche <bvanassche@acm.org>


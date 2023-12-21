Return-Path: <linux-kernel+bounces-8999-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87DC681BF1E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 20:29:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2B391B227B7
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 19:29:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED4696A005;
	Thu, 21 Dec 2023 19:28:47 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66059651A4;
	Thu, 21 Dec 2023 19:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1d3e2972f65so5866995ad.3;
        Thu, 21 Dec 2023 11:28:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703186925; x=1703791725;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0Bco0ERQRj3rYAMBWppOOAWWH4RcSWSSR/RuHXwNzZw=;
        b=lf2metfXrrZuVaujnH+JQ9yRjLu4VoahGFZijYuoFg6DbJhBkxrl2/cRzyIqDX24pc
         Dl5imzvjaRfz2MMn0NDIuRFKgjQ4XefNwwIfUIiDr1lNj9Y8FcgccsLtt9M5+W1+jyNA
         DMBJRYUac+P8PpOqViXfcETVcGPyhcTo38DfErMD82uBwWrJHLr+2ILIIwS/zOcrLRSz
         dMBY6910ViLVrPUf+34pjejvHNyybbNx+vcufcKSMTv7KtwzwQLPxykfUFo2JHQBRrw8
         V1niMEk70QmhXMaSnhjEpJT40zgms5dlgS00gq335nyRt4ClPsa0m438bb6VYnxMekXc
         dDWw==
X-Gm-Message-State: AOJu0Ywm/AVC5nJ30+Zv/3lkRgjPikPdfT0PBk6SFkIl3uP3X1AsqxG9
	gR/pZxfw99k354M3XhJXYzw=
X-Google-Smtp-Source: AGHT+IHSHzhTy84vjyTXbw0y78oR/kW5cDCh5EFHZXHEFoI6LpSDZJKJUPgJMwCmOQ0BzrG8SpVJ0Q==
X-Received: by 2002:a17:902:c406:b0:1d3:fa3f:668a with SMTP id k6-20020a170902c40600b001d3fa3f668amr153251plk.58.1703186925077;
        Thu, 21 Dec 2023 11:28:45 -0800 (PST)
Received: from ?IPV6:2620:0:1000:8411:872c:d7b7:41e9:3edd? ([2620:0:1000:8411:872c:d7b7:41e9:3edd])
        by smtp.gmail.com with ESMTPSA id l17-20020a170902eb1100b001bf11cf2e21sm1995752plb.210.2023.12.21.11.28.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Dec 2023 11:28:44 -0800 (PST)
Message-ID: <b8056aae-e7d5-4814-957d-585ab803a3aa@acm.org>
Date: Thu, 21 Dec 2023 11:28:42 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v3 10/11] scsi: ufs: core: Perform read back to commit
 doorbell
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
 <20231221-ufs-reset-ensure-effect-before-delay-v3-10-2195a1b66d2e@redhat.com>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20231221-ufs-reset-ensure-effect-before-delay-v3-10-2195a1b66d2e@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/21/23 11:09, Andrew Halaney wrote:
> diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
> index 75a03ee9a1ba..caebd589e08c 100644
> --- a/drivers/ufs/core/ufshcd.c
> +++ b/drivers/ufs/core/ufshcd.c
> @@ -7050,7 +7050,7 @@ static int __ufshcd_issue_tm_cmd(struct ufs_hba *hba,
>   
>   	ufshcd_writel(hba, 1 << task_tag, REG_UTP_TASK_REQ_DOOR_BELL);
>   	/* Make sure that doorbell is committed immediately */
> -	wmb();
> +	ufshcd_readl(hba, REG_UTP_TASK_REQ_DOOR_BELL);
>   
>   	spin_unlock_irqrestore(host->host_lock, flags);

There is a wait_for_completion_io_timeout() call later in this function and
it is safe to write to the REG_UTP_TASK_REQ_DOOR_BELL register from multiple
threads concurrently so I think the above wmb() call can be left out entirely.

Thanks,

Bart.


Return-Path: <linux-kernel+bounces-19896-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2728C82765E
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 18:33:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97C2C284244
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 17:32:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D86F54BD7;
	Mon,  8 Jan 2024 17:31:29 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B91BF54BCA;
	Mon,  8 Jan 2024 17:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6d9bec20980so791997b3a.2;
        Mon, 08 Jan 2024 09:31:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704735087; x=1705339887;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=39272ZGTbY1zLfGfrdj1xG1tF4EI2nX02WVJoTjgMlg=;
        b=TsRcPF8CgjL8xFC6yqLImtdz9DMl2OnJEuzkPjpZuK3cRGuM+PLMNE3O6kZBZY7SVP
         C45+/8PkOrA8eghHxzOq3sKDzMI7iR0tNFgtLJAjngZIw9UmY/dv6NHzpigxZteo9JvC
         7Zh++bE8DIccmiuZor9JP3PNwIZ9Pa2gt8x8arEfeEH0ozoMop5SUMu3BkqWLBaLjDjv
         qrv5QYGy8j3t9s3GLzi0E++vCDwrGhQoKMOkJtrBabiKx0jNmigtFCY36WAWWVjrzCDB
         nBzcTg9OMLEcg2QFCVnOeAPHHFroBXzTlROX/MIuA0Btx41D0EOXo3BXQs70wyFZ7Z7Z
         x18w==
X-Gm-Message-State: AOJu0YwKZp/NFdSPnYHxX8mKo48ZPAbA1agM3YRzJnbj4WQmLQyRKfFa
	XbEvy7qVaV/Ur6f2E/rxSkg=
X-Google-Smtp-Source: AGHT+IHqUTUOu2xUUsCvTWYjqR6ZfFuBIEm7Vnf3BmP42N7vsGy5ZtvdrNxLirg2T5Y+w9XiRXqpzQ==
X-Received: by 2002:aa7:8758:0:b0:6d9:9984:66d9 with SMTP id g24-20020aa78758000000b006d9998466d9mr1587468pfo.37.1704735086803;
        Mon, 08 Jan 2024 09:31:26 -0800 (PST)
Received: from ?IPV6:2620:0:1000:8411:cee:c48d:78d6:ed9a? ([2620:0:1000:8411:cee:c48d:78d6:ed9a])
        by smtp.gmail.com with ESMTPSA id gx18-20020a056a001e1200b006d93ca7f8f3sm126390pfb.150.2024.01.08.09.31.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jan 2024 09:31:23 -0800 (PST)
Message-ID: <77fd81ae-269c-42c5-9788-dbbee31c05db@acm.org>
Date: Mon, 8 Jan 2024 09:31:18 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] ufs:mcq:Use ufshcd_mcq_req_to_hwq() to simplify
 updating hwq.
Content-Language: en-US
To: Chanwoo Lee <cw9316.lee@samsung.com>, alim.akhtar@samsung.com,
 avri.altman@wdc.com, jejb@linux.ibm.com, martin.petersen@oracle.com,
 stanley.chu@mediatek.com, quic_cang@quicinc.com, mani@kernel.org,
 quic_asutoshd@quicinc.com, powen.kao@mediatek.com, quic_nguyenb@quicinc.com,
 yang.lee@linux.alibaba.com, peter.wang@mediatek.com, athierry@redhat.com,
 linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: grant.jung@samsung.com, jt77.jang@samsung.com, dh0421.hwang@samsung.com,
 sh043.lee@samsung.com
References: <20240105021041.20400-1-cw9316.lee@samsung.com>
 <CGME20240105021138epcas1p3fdfa70996ddbd282c1067de02e39dbd4@epcas1p3.samsung.com>
 <20240105021041.20400-2-cw9316.lee@samsung.com>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20240105021041.20400-2-cw9316.lee@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/4/24 18:10, Chanwoo Lee wrote:
> From: ChanWoo Lee <cw9316.lee@samsung.com>
> 
> Use ufshcd_mcq_req_to_hwq() to remove unnecessary variables and simplify.
> 
> Signed-off-by: ChanWoo Lee <cw9316.lee@samsung.com>
> ---
>   drivers/ufs/core/ufshcd.c | 5 +----
>   1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
> index 30df6f6a72c6..c9d122302889 100644
> --- a/drivers/ufs/core/ufshcd.c
> +++ b/drivers/ufs/core/ufshcd.c
> @@ -5597,7 +5597,6 @@ static void ufshcd_mcq_compl_pending_transfer(struct ufs_hba *hba,
>   	struct ufshcd_lrb *lrbp;
>   	struct scsi_cmnd *cmd;
>   	unsigned long flags;
> -	u32 hwq_num, utag;
>   	int tag;
>   
>   	for (tag = 0; tag < hba->nutrs; tag++) {
> @@ -5607,9 +5606,7 @@ static void ufshcd_mcq_compl_pending_transfer(struct ufs_hba *hba,
>   		    test_bit(SCMD_STATE_COMPLETE, &cmd->state))
>   			continue;
>   
> -		utag = blk_mq_unique_tag(scsi_cmd_to_rq(cmd));
> -		hwq_num = blk_mq_unique_tag_to_hwq(utag);
> -		hwq = &hba->uhq[hwq_num];
> +		hwq = ufshcd_mcq_req_to_hwq(hba, scsi_cmd_to_rq(cmd));
>   
>   		if (force_compl) {
>   			ufshcd_mcq_compl_all_cqes_lock(hba, hwq);

Reviewed-by: Bart Van Assche <bvanassche@acm.org>


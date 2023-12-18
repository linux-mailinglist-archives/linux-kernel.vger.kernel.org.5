Return-Path: <linux-kernel+bounces-4412-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A0107817CB1
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 22:41:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C63401C21D49
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 21:41:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8623740B2;
	Mon, 18 Dec 2023 21:41:42 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A8C51DA3A;
	Mon, 18 Dec 2023 21:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-58e256505f7so2537406eaf.3;
        Mon, 18 Dec 2023 13:41:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702935700; x=1703540500;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0Lf6x/s/QNuvXO3/maFmMWf//6tmMOSX9Okk2scVa1c=;
        b=LcewoDHFMKU2Y0ff8fEFmnakzg9oFuextUFVB/e4hwggKflD6cQLzU40kcgzLPpDzP
         Mo+I7S6JUBCaE2sB6CGxRo0WIf3bkrMZKBciC3IclRbiQLry1rVXMlvMK5BLXs7rM9ca
         l2/S59ZnfDkM9vWUz5TmDcWDSpuYN9toqEHq7oe1yIsXp5ehk4Ysr8ch6yTMibRP+SQR
         vQhx5nS/6AtfiXQyt/7jtwkzh5E8TOgncZGo6zERFv9jgpoYNGtYhA9Zkfwaszl5j/w6
         OeXWH8qv5Jtx2s7qDKeMzt98LDOLu24VyIGswoxau+TV+vNvIK+n5zP8agskr7t67pvp
         L3Tg==
X-Gm-Message-State: AOJu0YyMY1BUOwA1a3uPi3FpouOjjGsV8vjbUydmA2KvDwtpOHbQPO41
	5pCyvdcDVwKQpHvt1J/AyBI=
X-Google-Smtp-Source: AGHT+IHRHJGjIg8FP0kWYFL8Nk9kN/wFY5Y7MonQIYe8IKswbaMMMSgMs9IHvnKqpDP+LztsZih95g==
X-Received: by 2002:a05:6358:e4a1:b0:172:d67c:61f1 with SMTP id by33-20020a056358e4a100b00172d67c61f1mr1664629rwb.14.1702935699775;
        Mon, 18 Dec 2023 13:41:39 -0800 (PST)
Received: from ?IPV6:2620:0:1000:8411:e67:7ba6:36a9:8cd5? ([2620:0:1000:8411:e67:7ba6:36a9:8cd5])
        by smtp.gmail.com with ESMTPSA id a21-20020a62e215000000b006d63ace8508sm3075061pfi.70.2023.12.18.13.41.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Dec 2023 13:41:39 -0800 (PST)
Message-ID: <7cdfa93b-70f7-4912-bda7-a6b50b93c665@acm.org>
Date: Mon, 18 Dec 2023 13:41:35 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] scsi: ufs: core: Let the sq_lock protect sq_tail_slot
 access
Content-Language: en-US
To: Can Guo <quic_cang@quicinc.com>, mani@kernel.org,
 adrian.hunter@intel.com, beanhuo@micron.com, avri.altman@wdc.com,
 junwoo80.lee@samsung.com, martin.petersen@oracle.com
Cc: linux-scsi@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 Alim Akhtar <alim.akhtar@samsung.com>,
 "James E.J. Bottomley" <jejb@linux.ibm.com>,
 Stanley Chu <stanley.chu@mediatek.com>,
 Asutosh Das <quic_asutoshd@quicinc.com>, Peter Wang
 <peter.wang@mediatek.com>, "Bao D. Nguyen" <quic_nguyenb@quicinc.com>,
 Arthur Simchaev <Arthur.Simchaev@wdc.com>,
 open list <linux-kernel@vger.kernel.org>
References: <1702913550-20631-1-git-send-email-quic_cang@quicinc.com>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <1702913550-20631-1-git-send-email-quic_cang@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/18/23 07:32, Can Guo wrote:
> If access sq_tail_slot without the protection from the sq_lock, race
> condition can have multiple SQEs copied to duplicate SQE slot(s), which can
> lead to multiple incredible stability issues. Fix it by moving the *dest
> initialization, in ufshcd_send_command(), back under protection from the
> sq_lock.
> 
> Fixes: 3c85f087faec ("scsi: ufs: mcq: Use pointer arithmetic in ufshcd_send_command()")
> Signed-off-by: Can Guo <quic_cang@quicinc.com>
> 
> diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
> index ae9936f..2994aac 100644
> --- a/drivers/ufs/core/ufshcd.c
> +++ b/drivers/ufs/core/ufshcd.c
> @@ -2274,9 +2274,10 @@ void ufshcd_send_command(struct ufs_hba *hba, unsigned int task_tag,
>   	if (is_mcq_enabled(hba)) {
>   		int utrd_size = sizeof(struct utp_transfer_req_desc);
>   		struct utp_transfer_req_desc *src = lrbp->utr_descriptor_ptr;
> -		struct utp_transfer_req_desc *dest = hwq->sqe_base_addr + hwq->sq_tail_slot;
> +		struct utp_transfer_req_desc *dest;
>   
>   		spin_lock(&hwq->sq_lock);
> +		dest = hwq->sqe_base_addr + hwq->sq_tail_slot;
>   		memcpy(dest, src, utrd_size);
>   		ufshcd_inc_sq_tail(hwq);
>   		spin_unlock(&hwq->sq_lock);

Reviewed-by: Bart Van Assche <bvanassche@acm.org>


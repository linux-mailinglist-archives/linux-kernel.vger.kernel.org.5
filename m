Return-Path: <linux-kernel+bounces-7304-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2900A81A543
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 17:35:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2F1D1F25877
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 16:35:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 395C941C8C;
	Wed, 20 Dec 2023 16:35:24 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 981E33E482;
	Wed, 20 Dec 2023 16:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1d3ef33e68dso5726155ad.1;
        Wed, 20 Dec 2023 08:35:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703090122; x=1703694922;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HD391STeMNLNh1weLgIASJ1OOCqGV6Q0hnzwpCWK4Lk=;
        b=KYOm6UAKCMScs1hldZfVmW8DAoLwDZnbYg/q8OBZLyZ8Sm4TIz39jotY+xmvPcPgzq
         D3qAspwJBWdASxg7kCOAhz9cSn8d3JWVSEwb2gV6p6gLBFC067JUUBkOAyP785KQOZcC
         MHVbHA34VbKEjl+H4wUHePCDaBxSWBE/ViN2iMzXt4/B6IC51biVYvEmpStVF7hmnwu1
         pHGJjW2taaR4WapelFDBM/7pb5UNpCJ6WcZiJYzQrLhcVS4bPNYza7MNEPqsYGK1zdMv
         UFHxDWio5Uu0m1wunvgT3lM4xnRDtiuQ02mHBX2g6vwC9E/8W9/Op9yBzomRfPDoJifg
         KQGg==
X-Gm-Message-State: AOJu0YzBP7eDI1AG6pwVb6AUYtWRrpVYv4hAtXHJBF9k31lWpXgWRCmv
	7kd6knda2IVKo5Q26UdBrLI=
X-Google-Smtp-Source: AGHT+IEo3QD8dwpbNAzdICvPQI2rxw3+DQ9hUsWZZwbrbT3Ja+FDdoTBh63Gm15U4ISJ7bP74F6//g==
X-Received: by 2002:a17:903:1249:b0:1d3:35e4:bcd7 with SMTP id u9-20020a170903124900b001d335e4bcd7mr4577791plh.34.1703090121356;
        Wed, 20 Dec 2023 08:35:21 -0800 (PST)
Received: from ?IPV6:2620:0:1000:8411:b2aa:4964:8bfa:71c? ([2620:0:1000:8411:b2aa:4964:8bfa:71c])
        by smtp.gmail.com with ESMTPSA id y16-20020a17090322d000b001d09c5424d4sm23163822plg.297.2023.12.20.08.35.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Dec 2023 08:35:20 -0800 (PST)
Message-ID: <a49a0fa7-4be3-4434-bd65-1d988b0017a4@acm.org>
Date: Wed, 20 Dec 2023 08:35:18 -0800
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
To: Manivannan Sadhasivam <mani@kernel.org>, Can Guo <quic_cang@quicinc.com>
Cc: adrian.hunter@intel.com, beanhuo@micron.com, avri.altman@wdc.com,
 junwoo80.lee@samsung.com, martin.petersen@oracle.com,
 linux-scsi@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 Alim Akhtar <alim.akhtar@samsung.com>,
 "James E.J. Bottomley" <jejb@linux.ibm.com>,
 Stanley Chu <stanley.chu@mediatek.com>,
 Asutosh Das <quic_asutoshd@quicinc.com>, Peter Wang
 <peter.wang@mediatek.com>, "Bao D. Nguyen" <quic_nguyenb@quicinc.com>,
 Arthur Simchaev <Arthur.Simchaev@wdc.com>,
 open list <linux-kernel@vger.kernel.org>
References: <1702913550-20631-1-git-send-email-quic_cang@quicinc.com>
 <20231220145031.GI3544@thinkpad>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20231220145031.GI3544@thinkpad>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/20/23 06:50, Manivannan Sadhasivam wrote:
> On Mon, Dec 18, 2023 at 07:32:17AM -0800, Can Guo wrote:
>> If access sq_tail_slot without the protection from the sq_lock, race
>> condition can have multiple SQEs copied to duplicate SQE slot(s), which can
>> lead to multiple incredible stability issues. Fix it by moving the *dest
>> initialization, in ufshcd_send_command(), back under protection from the
>> sq_lock.
>>
>> Fixes: 3c85f087faec ("scsi: ufs: mcq: Use pointer arithmetic in ufshcd_send_command()")
> 
> Cc: stable@vger.kernel.org

Hmm ... is the "Cc: stable" tag really required if a "Fixes:" tag is present?

Bart.



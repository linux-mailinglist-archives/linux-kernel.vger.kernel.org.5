Return-Path: <linux-kernel+bounces-25989-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65A4D82D95F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 14:01:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F37192827EF
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 13:01:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E9B6171AB;
	Mon, 15 Jan 2024 13:01:55 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A930171A7
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 13:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0E8A32F4;
	Mon, 15 Jan 2024 05:02:39 -0800 (PST)
Received: from [10.34.100.129] (e126645.nice.arm.com [10.34.100.129])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DAFA33F6C4;
	Mon, 15 Jan 2024 05:01:51 -0800 (PST)
Message-ID: <21e77238-4884-40ca-bc01-b7e4774b9239@arm.com>
Date: Mon, 15 Jan 2024 14:01:50 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] firmware/arm_sdei: Fix invalid argument to unregister
 private events.
Content-Language: en-US
To: Levi Yun <ppbuk5246@gmail.com>, james.morse@arm.com
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240110090107.26323-1-ppbuk5246@gmail.com>
From: Pierre Gondois <pierre.gondois@arm.com>
In-Reply-To: <20240110090107.26323-1-ppbuk5246@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello Levi,

On 1/10/24 10:01, Levi Yun wrote:
> To unregister private events in device freeze, it should call
> cpuhp_remove_state with sdei_hp_state not sdei_entry_point.
> otherwise, it seems to fail on cpuhp_cb_check.
> 

I think you can also add:
Fixes: d2c48b2387eb ("firmware: arm_sdei: Fix sleep from invalid context BUG")


> Signed-off-by: Levi Yun <ppbuk5246@gmail.com>
> ---
>   drivers/firmware/arm_sdei.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/firmware/arm_sdei.c b/drivers/firmware/arm_sdei.c
> index 285fe7ad490d..3e8051fe8296 100644
> --- a/drivers/firmware/arm_sdei.c
> +++ b/drivers/firmware/arm_sdei.c
> @@ -763,7 +763,7 @@ static int sdei_device_freeze(struct device *dev)
>   	int err;
>   
>   	/* unregister private events */
> -	cpuhp_remove_state(sdei_entry_point);
> +	cpuhp_remove_state(sdei_hp_state);

Maybe it would also be worth resetting 'sdei_hp_state':
   sdei_hp_state = 0;

>   
>   	err = sdei_unregister_shared();
>   	if (err)

Regards,
Pierre


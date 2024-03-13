Return-Path: <linux-kernel+bounces-102356-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2356B87B117
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 20:08:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B85CC1F23DB2
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 19:08:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4BAD71749;
	Wed, 13 Mar 2024 18:23:47 +0000 (UTC)
Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D275160EDA
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 18:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.154.21.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710354227; cv=none; b=sdJjx1Z0O0ahGOSOROSyYZRpoK5sOw0+DCd6YaqSauJtbu13YTtv325qvdUKwEp/coaKr7uPP/XRnLzz4+pK7bdrUoow45+chGZNvHM1R1G71VdbpopCMOudXasypdbOwTYehvgi/318OnDIO89lXbrzdMbTnOJyIVzn6XFf9sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710354227; c=relaxed/simple;
	bh=+L7RmxbS57YhWRV5vrUo1xvbeBgnnm0H6PxuTVlMG7U=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=ByFodjveSFbQW0N7VucLfJfGOWIaIeOcuXg/W4FskUqFayENNkJ5TQtnjeEOGrHTc0cAIb1iPn3rq0Yb5fy1lxLoxcN0VRnqL4Jo66vh9Fq6ujIn0FlqJQATcUstbYQ8MlPTyxStxFSz8VqBtnYAtGZeWbYkTfZ6ukkcP8qqr8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru; spf=pass smtp.mailfrom=omp.ru; arc=none smtp.client-ip=90.154.21.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omp.ru
Received: from [192.168.1.105] (178.176.77.133) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Wed, 13 Mar
 2024 21:23:38 +0300
Subject: Re: [PATCH] fixp-arith: prevent division by zero in fixp_sin32_rad()
To: Roman Smirnov <r.smirnov@omp.ru>, <linux-kernel@vger.kernel.org>
CC: <lvc-project@linuxtesting.org>
References: <20240312094852.15400-1-r.smirnov@omp.ru>
From: Sergey Shtylyov <s.shtylyov@omp.ru>
Organization: Open Mobile Platform
Message-ID: <ef045b6e-14cd-a2a8-f89f-35d38776ed8b@omp.ru>
Date: Wed, 13 Mar 2024 21:23:38 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240312094852.15400-1-r.smirnov@omp.ru>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: msexch01.omp.ru (10.188.4.12) To msexch01.omp.ru
 (10.188.4.12)
X-KSE-ServerInfo: msexch01.omp.ru, 9
X-KSE-AntiSpam-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 6.1.0, Database issued on: 03/13/2024 18:03:29
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 0
X-KSE-AntiSpam-Info: Lua profiles 184146 [Mar 13 2024]
X-KSE-AntiSpam-Info: Version: 6.1.0.4
X-KSE-AntiSpam-Info: Envelope from: s.shtylyov@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 10 0.3.10
 53c821b925e16276b831986eabc71d60ab82ee60
X-KSE-AntiSpam-Info: {rep_avail}
X-KSE-AntiSpam-Info:
	127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;omp.ru:7.1.1
X-KSE-AntiSpam-Info: ApMailHostAddress: 178.176.77.133
X-KSE-AntiSpam-Info: Rate: 0
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dmarc=temperror header.from=omp.ru;spf=temperror
 smtp.mailfrom=omp.ru;dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 03/13/2024 18:09:00
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 3/13/2024 4:59:00 PM
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit

On 3/12/24 12:48 PM, Roman Smirnov wrote:

> The parameter twopi can have a zero value. It is necessary
> to prevent division by zero.
> 
> Found by Linux Verification Center (linuxtesting.org) with Svace.
> 
> Signed-off-by: Roman Smirnov <r.smirnov@omp.ru>
> ---
>  include/linux/fixp-arith.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/fixp-arith.h b/include/linux/fixp-arith.h
> index e485fb0c1201..434eee8bd9ef 100644
> --- a/include/linux/fixp-arith.h
> +++ b/include/linux/fixp-arith.h
> @@ -118,8 +118,9 @@ static inline s32 fixp_sin32_rad(u32 radians, u32 twopi)
>  
>  	/*
>  	 * Avoid too large values for twopi, as we don't want overflows.
> +	 * Also prevent division by zero.
>  	 */
> -	BUG_ON(twopi > 1 << 18);
> +	BUG_ON(!twopi || twopi > 1 << 18);

    Not really sure ATM that BUG_ON() is better than division by 0
(which should cause exception 0 on x86 but I'm not sure about e.g.
ARM32/64)...

>  
>  	degrees = (radians * 360) / twopi;
>  	tmp = radians - (degrees * twopi) / 360;
> 

Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>

[...]

MBR, Sergey


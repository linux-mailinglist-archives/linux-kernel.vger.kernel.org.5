Return-Path: <linux-kernel+bounces-63598-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 93BF3853209
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 14:35:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 435BA1F23557
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 13:35:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3986C56468;
	Tue, 13 Feb 2024 13:35:09 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FB5956444;
	Tue, 13 Feb 2024 13:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707831308; cv=none; b=uTHdBg/77H24H5R/qEXVNgQEy04TzWR//79SPFRlNvQUPN3mlbNhjH2Yh/ijXu5jK7EX94gjSbJ3qQJq0lmObspUgDD2t6vizFPwqjhvp7fLwPWSYg3Tuqa4gH5wM84XB4aM4fZzIwgJbk0B0Y7aWsotbuMzcOjN7WFUks5Jh8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707831308; c=relaxed/simple;
	bh=0fLC0KnFKKogrD8BSsniO+ZMxs8BKJuQFY0rr2JzJhE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jHk3WMLkmnF+861gRNJUWyxgPhyw9Us+jcMuUZqTvqghm3Mc5+2JDVaZhfRkpuY0oPBO1cdv2hKTBFVB5riz07eH4dKMRKdEeoLC0yN+ywoBLO+Bc0fSBAo0Yq4poTzFv59Trc/E1JVAlm5prq/t9suFrHVhGe9HzR+c7nkxUts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1071DDA7;
	Tue, 13 Feb 2024 05:35:47 -0800 (PST)
Received: from [10.1.30.52] (e133047.arm.com [10.1.30.52])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5AC373F762;
	Tue, 13 Feb 2024 05:35:03 -0800 (PST)
Message-ID: <94199ff4-1511-4f67-9794-b93195f8bac9@arm.com>
Date: Tue, 13 Feb 2024 13:35:01 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mmc: sd: Add a variable to check a faulty device
Content-Language: en-US
To: =?UTF-8?B?7J207Iq57Z2s?= <sh043.lee@samsung.com>,
 'Avri Altman' <Avri.Altman@wdc.com>, linux-mmc@vger.kernel.org,
 linux-kernel@vger.kernel.org, ulf.hansson@linaro.org,
 gregkh@linuxfoundation.org
Cc: grant.jung@samsung.com, jt77.jang@samsung.com, dh0421.hwang@samsung.com,
 junwoo80.lee@samsung.com, jangsub.yi@samsung.com, cw9316.lee@samsung.com,
 sh8267.baek@samsung.com, wkon.kim@samsung.com
References: <CGME20240213051332epcas1p1f45d02dc34d1b95ea5608ab779d6b6cc@epcas1p1.samsung.com>
 <20240213051716.6596-1-sh043.lee@samsung.com>
 <BL0PR04MB65642D0389544F022A1D2222FC4F2@BL0PR04MB6564.namprd04.prod.outlook.com>
 <000101da5e61$f97e8cf0$ec7ba6d0$@samsung.com>
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <000101da5e61$f97e8cf0$ec7ba6d0$@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 13/02/2024 09:49, 이승희 wrote:
> 
> 
>> -----Original Message-----
>> From: Avri Altman <Avri.Altman@wdc.com>
>> Sent: Tuesday, February 13, 2024 5:42 PM
>> To: Seunghui Lee <sh043.lee@samsung.com>; linux-mmc@vger.kernel.org;
>> linux-kernel@vger.kernel.org; ulf.hansson@linaro.org;
>> gregkh@linuxfoundation.org
>> Cc: grant.jung@samsung.com; jt77.jang@samsung.com;
>> dh0421.hwang@samsung.com; junwoo80.lee@samsung.com; jangsub.yi@samsung.com;
>> cw9316.lee@samsung.com; sh8267.baek@samsung.com; wkon.kim@samsung.com
>> Subject: RE: [PATCH] mmc: sd: Add a variable to check a faulty device
>>
>>> In mobile devices, suspend/resume situations are frequent.
>>> In the case of a defective SD card in which initialization fails,
>>> unnecessary initialization time is consumed for each resume.
>>> A field is needed to check that SD card initialization has failed on
>>> the host. It could be used to remove unnecessary initialization.
>> I don't see where you are using this new init_failed field?
>> Maybe instead, elaborate the logic to free_card: to detect a broken sd.
>> e.g. instead of just if (!oldcard), if (!oldcard || ! mmc_sd_alive(host))
>> or something.
>>
>> Thanks,
>> Avri
>>
> Thank you for your suggestion.
> I'm going to use it in mmc_rescan as below.
> 
> e.g.
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c index a8c17b4cd737..461cd75dc7ab 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -2210,7 +2210,7 @@ void mmc_rescan(struct work_struct *work)
>                 container_of(work, struct mmc_host, detect.work);
>         int i;
>  
> -       if (host->rescan_disable)
> +       if (host->rescan_disable || host->init_failed)
>                 return;

I've seen SD cards that fail the first initialization attempt for both
'valid' reasons (e.g. weird insertion timing) and things like out-of-spec
initialization time from the card, outright disabling these on the first
fail is a bit too much IMO.

Kind Regards,
Christian


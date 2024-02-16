Return-Path: <linux-kernel+bounces-69398-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85FFA85886F
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 23:20:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49D05288F7B
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 22:20:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3928D148305;
	Fri, 16 Feb 2024 22:20:42 +0000 (UTC)
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCE5A1482FC;
	Fri, 16 Feb 2024 22:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708122041; cv=none; b=oYeu7HQM+Hl7GA5KZNyLlrVR0lD60QpvXqGDTW7zv80uctcaF9CffeyhzJY/CdbOdH1y/K+LipfrR0qTZkWLDd33bjL1b7Fijso3QjbtjoIydLBpdUkwJn5RcA7GYVYHBVmQM1psy0b2f9AeB8dcZdLygxgT2hHx/7gayMbDTKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708122041; c=relaxed/simple;
	bh=msPNsztnskSmyeaJgNI4jRF+Vl1VLSTD1gWXdq5dqVY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kLrWdpA0Rqx2ws1hJYhu+yiLfebHt9cMqQzHH65oEe4BOxB6w1lIkO5zyHZuEqnObw4hht1KXsKyIsDhgnq0FUxACEcHmG0uam7eC9ieh6+jXPEOvaPp+u93oDegiw9gNogVtMbD+N37+9AX/Y0pe/cH7EzwNFpiph6/kkfejrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.44.133] (unknown [185.238.219.92])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id F26D061E5FE01;
	Fri, 16 Feb 2024 23:20:13 +0100 (CET)
Message-ID: <512bdab4-1779-4407-aa7b-57d1af015fc1@molgen.mpg.de>
Date: Fri, 16 Feb 2024 23:20:11 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: =?UTF-8?Q?Re=3A_init=5Ftis=28=29_takes_50_ms_on_Dell_XPS_13_9360_?=
 =?UTF-8?Q?=E2=80=93_almost_10_=25_of_whole_time_until_initrd?=
Content-Language: en-US
To: Jarkko Sakkinen <jarkko@kernel.org>, Peter Huewe <peterhuewe@gmx.de>
Cc: linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
References: <0eba23c7-f62a-4a85-a383-60dec9d198f9@molgen.mpg.de>
 <CZ6UFX5R09DD.EWDFS24L16G1@seitikki>
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <CZ6UFX5R09DD.EWDFS24L16G1@seitikki>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Jarkko,


Thank you for your reply.

Am 16.02.24 um 23:07 schrieb Jarkko Sakkinen:
> On Wed Feb 14, 2024 at 3:10 PM UTC, Paul Menzel wrote:

>> Trying to optimize the boot time of Linux on the Dell XPS 13 9360,
>> probing of MSFT0101:00 takes 52 ms, making `init_tis()` taking almost 10
>> % alone until starting the initrd:
>>
>>       [    0.000000] Linux version 6.8.0-rc4 (build@bohemianrhapsody.molgen.mpg.de) (gcc (Debian 13.2.0-13) 13.2.0,
>> GNU ld (GNU Binutils for Debian) 2.42) #20 SMP PREEMPT_DYNAMIC Mon Feb 12 09:40:49 CET 2024
>>       […]
>>       [    0.000000] DMI: Dell Inc. XPS 13 9360/0596KF, BIOS 2.21.0 06/02/2022
>>       […]
>>       [    0.320057] calling  init_tis+0x0/0x100 @ 1
>>       [    0.332190] tpm_tis MSFT0101:00: 2.0 TPM (device-id 0xFE, rev-id 4)
>>       [    0.372164] probe of MSFT0101:00 returned 0 after 52101 usecs
>>       [    0.372186] initcall init_tis+0x0/0x100 returned 0 after 52127 usecs
>>       […]
>>       [    0.588643] Freeing unused decrypted memory: 2036K
>>       [    0.589068] Freeing unused kernel image (initmem) memory: 3976K
>>       [    0.606115] Write protecting the kernel read-only data: 22528k
>>       [    0.606527] Freeing unused kernel image (rodata/data gap) memory: 276K
>>       [    0.652327] x86/mm: Checked W+X mappings: passed, no W+X pages found.
>>       [    0.652329] x86/mm: Checking user space page tables
>>       [    0.695968] x86/mm: Checked W+X mappings: passed, no W+X pages found.
>>       [    0.696104] Run /init as init process
>>       […]
>>
>> For users, where boot time is most important, can this be moved out of
>> the hot path somehow?
> 
> It can't be IRQ probing as IRQ's are *disabled* by default. So we can
> disclose that.
> 
> I think the delay is caused by tpm2_probe(), which is called by
> tpm_tis_core_init(). It sends an idempotent TPM2 command to the TPM
> chip to know whether it is TPM 1.x or TPM2 chip.
> 
> That detection is definitely required.
> 
> Even some other subsystems in the kernel require to know the correct
> TPM version, like hwrng and IMA.
Understood. The TPM in my laptop does not change, so could this be 
cached, or does a Linux CLI paramater exist, that I can specify the version?


Kind regards,

Paul


Return-Path: <linux-kernel+bounces-75788-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A793885EEEE
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 03:07:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8E621C2210D
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 02:07:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68A0C17553;
	Thu, 22 Feb 2024 02:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="bHC2M4Rk"
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71FEA13FF1;
	Thu, 22 Feb 2024 02:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708567655; cv=none; b=u255SuA9RjF8+TqS2c2wwPP16r1dUALUvyywefYJzASCR1rs5jowuRsZ3SSDfzrBeaSZDblJtOR7R2XTCKbkm3vfijlfENFjP1xhK2qu9BqIDEWHIq0jxxmS+8LeM91TYnt0VOIRQlDhKGE5m50qmzo83/4aHbFcaZ/juqu7Yb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708567655; c=relaxed/simple;
	bh=wpfrzY5wnM49lInKxaLzb9/hPGzdAubLDvCFyOqjldc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FtAZ6RoiNC8KlJssg3yYmH0Gt/YLRysp/JnxbWRsCzlaAqcXHJxsITqPNS0cqcEJFHlw/K3kIQHZyJxEIhaIaYMRUAtfzdK4bWC5bvAExGE/IWao1NqTsyuhscBF+EMVp/NkyKHEoHzgr3K6VlBD5KBM0gfzlCqyjAJNKADl54Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=bHC2M4Rk; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1708567644; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=lDGwJr9TuPvJsHHw5w4m96qLqRHU5UZ2FIU9NMbibkY=;
	b=bHC2M4Rk2wv0ylI87krt3QbgBa+WsZdcKjeeVawCMgE59rh2AuqctJIQw80gUR5agkL0oeaTDmalmtdsjFdxIx627a9T3mWcGvaLYmS3oWCSEVTZSO6Ah5UIDVnR2Uacs0OQ3FbX2m+PVgX7FOw9lzq/xDSbRS2TaIwdEWzw8m4=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=35;SR=0;TI=SMTPD_---0W1.N3yS_1708567639;
Received: from 30.240.113.243(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0W1.N3yS_1708567639)
          by smtp.aliyun-inc.com;
          Thu, 22 Feb 2024 10:07:22 +0800
Message-ID: <bdf15819-46e0-498f-97e1-a0183f257086@linux.alibaba.com>
Date: Thu, 22 Feb 2024 10:07:18 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 1/3] ACPI: APEI: send SIGBUS to current task if
 synchronous memory error not recovered
To: Borislav Petkov <bp@alien8.de>, Ira Weiny <ira.weiny@intel.com>,
 "Luck, Tony" <tony.luck@intel.com>, "james.morse@arm.com"
 <james.morse@arm.com>
Cc: rafael@kernel.org, wangkefeng.wang@huawei.com, tanxiaofei@huawei.com,
 mawupeng1@huawei.com, tony.luck@intel.com, linmiaohe@huawei.com,
 naoya.horiguchi@nec.com, gregkh@linuxfoundation.org, will@kernel.org,
 jarkko@kernel.org, linux-acpi@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
 linux-edac@vger.kernel.org, x86@kernel.org, justin.he@arm.com,
 ardb@kernel.org, ying.huang@intel.com, ashish.kalra@amd.com,
 baolin.wang@linux.alibaba.com, tglx@linutronix.de, mingo@redhat.com,
 dave.hansen@linux.intel.com, lenb@kernel.org, hpa@zytor.com,
 robert.moore@intel.com, lvying6@huawei.com, xiexiuqi@huawei.com,
 zhuo.song@linux.alibaba.com, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Dan Williams <dan.j.williams@intel.com>
References: <20221027042445.60108-1-xueshuai@linux.alibaba.com>
 <20240204080144.7977-2-xueshuai@linux.alibaba.com>
 <20240219092528.GTZdMeiDWIDz613VeT@fat_crate.local>
Content-Language: en-US
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <20240219092528.GTZdMeiDWIDz613VeT@fat_crate.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2024/2/19 17:25, Borislav Petkov wrote:
> On Sun, Feb 04, 2024 at 04:01:42PM +0800, Shuai Xue wrote:
>> Synchronous error was detected as a result of user-space process accessing
>> a 2-bit uncorrected error. The CPU will take a synchronous error exception
>> such as Synchronous External Abort (SEA) on Arm64. The kernel will queue a
>> memory_failure() work which poisons the related page, unmaps the page, and
>> then sends a SIGBUS to the process, so that a system wide panic can be
>> avoided.
>>
>> However, no memory_failure() work will be queued when abnormal synchronous
>> errors occur. These errors can include situations such as invalid PA,
>> unexpected severity, no memory failure config support, invalid GUID
>> section, etc. In such case, the user-space process will trigger SEA again.
>> This loop can potentially exceed the platform firmware threshold or even
>> trigger a kernel hard lockup, leading to a system reboot.
>>
>> Fix it by performing a force kill if no memory_failure() work is queued
>> for synchronous errors.
>>
>> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
>> ---
>>  drivers/acpi/apei/ghes.c | 9 +++++++++
>>  1 file changed, 9 insertions(+)
>>
>> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
>> index 7b7c605166e0..0892550732d4 100644
>> --- a/drivers/acpi/apei/ghes.c
>> +++ b/drivers/acpi/apei/ghes.c
>> @@ -806,6 +806,15 @@ static bool ghes_do_proc(struct ghes *ghes,
>>  		}
>>  	}
>>  
>> +	/*
>> +	 * If no memory failure work is queued for abnormal synchronous
>> +	 * errors, do a force kill.
>> +	 */
>> +	if (sync && !queued) {
>> +		pr_err("Sending SIGBUS to current task due to memory error not recovered");
>> +		force_sig(SIGBUS);
>> +	}
> 
> Except that there are a bunch of CXL GUIDs being handled there too and
> this will sigbus those processes now automatically.

Before the CXL GUIDs added, @Tony confirmed that the HEST notifications are always
asynchronous on x86 platform, so only Synchronous External Abort (SEA) on ARM is
delivered as a synchronous notification.

Will the CXL component trigger synchronous events for which we need to terminate the
current process by sending sigbus to process?

> 
> Lemme add the whole bunch from
> 
>   671a794c33c6 ("acpi/ghes: Process CXL Component Events")
> 
> for comment to Cc.
> 

Thank you.

Best Regards,
Shuai


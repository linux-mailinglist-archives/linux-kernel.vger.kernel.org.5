Return-Path: <linux-kernel+bounces-82518-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EDD3A8685B4
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 02:24:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A48931F227EF
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 01:24:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 470696AB8;
	Tue, 27 Feb 2024 01:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Mn8SD9gT"
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F31C6AA1;
	Tue, 27 Feb 2024 01:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708997028; cv=none; b=m0vQcNWu4I8DDDvxxGDf5we2Ke/meTSsmckJo1wcMy21/nYSNZH3gKUwWb8luiBPGTWMmXhmEr/1I7MOoPXrA2O/TUOhxmC/8sm+gYnLau3d9ItHbAGIfXP1DLC9cGCwqCaIC7hsNED1wSvoOlcr7f7wDYC5hciwefEDHbQytYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708997028; c=relaxed/simple;
	bh=ZfTRand3rROT7XxZCWplDHZqLPJs59ZIp/+nD/e9qPg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fRJcVIJ3AOTtvo2+y2mnS6Ks/EAoETwwZ+pIccmdHdMv9alYtOPud8fBv7NZzBAiy/0PeNQTePCFQ7rUBGk38Jc4K2WTcBEjfsqX7hSgVHVJQejSUTlvq9UALhRn7iWILtsRWA58Aziz7jJYGY755fdeILin0Yc2PRtg/qz4Ncc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Mn8SD9gT; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1708997023; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=EsQRPyCzYcqHVkgKl+Bj2Ur2lyhbd0alTetMHoXUoF0=;
	b=Mn8SD9gT4Yo1hTDYF9VNyJ8I4Sc+ipWTMY0lBsBk4HRJnV0oZwxw7jsDHEJq25tt9uguvkr8Dn41Sk7d9SG+hMfWOo38Sj1wccOcJx/ULn8BT/RbzRKvvs0HX6oG9P8pWPq9qTicni1+IOtTFTzHmGuJ+YJisUlNAMs4SxyRquI=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=35;SR=0;TI=SMTPD_---0W1Kw74F_1708997019;
Received: from 30.240.112.180(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0W1Kw74F_1708997019)
          by smtp.aliyun-inc.com;
          Tue, 27 Feb 2024 09:23:42 +0800
Message-ID: <e18c242a-6389-4d8c-82f6-30e4606a2cec@linux.alibaba.com>
Date: Tue, 27 Feb 2024 09:23:39 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 1/3] ACPI: APEI: send SIGBUS to current task if
 synchronous memory error not recovered
Content-Language: en-US
To: Borislav Petkov <bp@alien8.de>, "james.morse@arm.com"
 <james.morse@arm.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Dan Williams <dan.j.williams@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 "Luck, Tony" <tony.luck@intel.com>, rafael@kernel.org,
 wangkefeng.wang@huawei.com, tanxiaofei@huawei.com, mawupeng1@huawei.com,
 linmiaohe@huawei.com, naoya.horiguchi@nec.com, gregkh@linuxfoundation.org,
 will@kernel.org, jarkko@kernel.org, linux-acpi@vger.kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
 linux-edac@vger.kernel.org, x86@kernel.org, justin.he@arm.com,
 ardb@kernel.org, ying.huang@intel.com, ashish.kalra@amd.com,
 baolin.wang@linux.alibaba.com, tglx@linutronix.de, mingo@redhat.com,
 dave.hansen@linux.intel.com, lenb@kernel.org, hpa@zytor.com,
 robert.moore@intel.com, lvying6@huawei.com, xiexiuqi@huawei.com,
 zhuo.song@linux.alibaba.com
References: <20221027042445.60108-1-xueshuai@linux.alibaba.com>
 <20240204080144.7977-2-xueshuai@linux.alibaba.com>
 <20240219092528.GTZdMeiDWIDz613VeT@fat_crate.local>
 <bdf15819-46e0-498f-97e1-a0183f257086@linux.alibaba.com>
 <65d82c9352e78_24f3f294d5@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <20240223120813.00005d1f@Huawei.com> <20240223121701.00004bcf@Huawei.com>
 <00126cf9-bb59-4c05-8046-478d0d7f4297@linux.alibaba.com>
 <20240226102918.GBZdxn_v0NbVjs2XMB@fat_crate.local>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <20240226102918.GBZdxn_v0NbVjs2XMB@fat_crate.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2024/2/26 18:29, Borislav Petkov wrote:
> On Sat, Feb 24, 2024 at 02:08:42PM +0800, Shuai Xue wrote:
>> @Borislav, do you have any other concerns?
> 
> Yes, this change needs to be further reviewed by an ARM person: I have
> no clue what those "abnormal synchronous errors" on ARM are 

Hi, Borislav,

May the `abnormal` is not inaccurate and misled you. I mean the preconditions
check before memory_failure_queue():

- `if (!(mem_err->validation_bits & CPER_MEM_VALID_PA))` in ghes_handle_memory_failure()
- `if (flags == -1)` in ghes_handle_memory_failure()
- `if (!IS_ENABLED(CONFIG_ACPI_APEI_MEMORY_FAILURE))` in ghes_do_memory_failure()
- `if (!pfn_valid(pfn) && !arch_is_platform_page(physical_addr)) ` in ghes_do_memory_failure()

If the preconditions are not passed, the user-space process will trigger SEA again.
This loop can potentially exceed the platform firmware threshold or even
trigger a kernel hard lockup, leading to a system reboot.

> and how
> they're supposed to be handled properly there:
> 
> - what happens if you get such an error when ghes is disabled there?

If ghes_disable is set, the GHES driver will not be inited by acpi_ghes_init(),
so none of error notifications will be handled. IMHO, it is expected.

> 
> - is that even the right place to handle them?
> 
> James?
> 

Leave this to @James.

Thank you.

Best Regards,
Shuai



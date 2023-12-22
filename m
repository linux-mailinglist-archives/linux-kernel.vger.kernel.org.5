Return-Path: <linux-kernel+bounces-9227-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BBE8381C291
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 02:08:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE5831C21F21
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 01:08:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49EFA138A;
	Fri, 22 Dec 2023 01:08:02 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E1BDA31;
	Fri, 22 Dec 2023 01:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=34;SR=0;TI=SMTPD_---0Vyz1YYc_1703207271;
Received: from 30.240.112.165(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0Vyz1YYc_1703207271)
          by smtp.aliyun-inc.com;
          Fri, 22 Dec 2023 09:07:54 +0800
Message-ID: <f8bff25f-714a-40ab-b450-5dee8d964463@linux.alibaba.com>
Date: Fri, 22 Dec 2023 09:07:50 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 1/4] ACPI: APEI: set memory failure flags as
 MF_ACTION_REQUIRED on synchronous events
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: bp@alien8.de, wangkefeng.wang@huawei.com, tanxiaofei@huawei.com,
 mawupeng1@huawei.com, tony.luck@intel.com, linmiaohe@huawei.com,
 naoya.horiguchi@nec.com, james.morse@arm.com, gregkh@linuxfoundation.org,
 will@kernel.org, jarkko@kernel.org, linux-acpi@vger.kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
 linux-edac@vger.kernel.org, acpica-devel@lists.linuxfoundation.org,
 stable@vger.kernel.org, x86@kernel.org, justin.he@arm.com, ardb@kernel.org,
 ying.huang@intel.com, ashish.kalra@amd.com, baolin.wang@linux.alibaba.com,
 tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
 lenb@kernel.org, hpa@zytor.com, robert.moore@intel.com, lvying6@huawei.com,
 xiexiuqi@huawei.com, zhuo.song@linux.alibaba.com
References: <20221027042445.60108-1-xueshuai@linux.alibaba.com>
 <20231218064521.37324-2-xueshuai@linux.alibaba.com>
 <CAJZ5v0hnKP9S+5PfuO1EzvpSdHM09s0HidGjfinf491xkdop3g@mail.gmail.com>
Content-Language: en-US
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <CAJZ5v0hnKP9S+5PfuO1EzvpSdHM09s0HidGjfinf491xkdop3g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 2023/12/21 21:55, Rafael J. Wysocki wrote:
> On Mon, Dec 18, 2023 at 7:45 AM Shuai Xue <xueshuai@linux.alibaba.com> wrote:
>>
>> There are two major types of uncorrected recoverable (UCR) errors :
>>
>> - Synchronous error: The error is detected and raised at the point of the
>>   consumption in the execution flow, e.g. when a CPU tries to access
>>   a poisoned cache line. The CPU will take a synchronous error exception
>>   such as Synchronous External Abort (SEA) on Arm64 and Machine Check
>>   Exception (MCE) on X86. OS requires to take action (for example, offline
>>   failure page/kill failure thread) to recover this uncorrectable error.
>>
>> - Asynchronous error: The error is detected out of processor execution
>>   context, e.g. when an error is detected by a background scrubber. Some data
>>   in the memory are corrupted. But the data have not been consumed. OS is
>>   optional to take action to recover this uncorrectable error.
>>
>> When APEI firmware first is enabled, a platform may describe one error
>> source for the handling of synchronous errors (e.g. MCE or SEA notification
>> ), or for handling asynchronous errors (e.g. SCI or External Interrupt
>> notification). In other words, we can distinguish synchronous errors by
>> APEI notification. For synchronous errors, kernel will kill the current
>> process which accessing the poisoned page by sending SIGBUS with
>> BUS_MCEERR_AR. In addition, for asynchronous errors, kernel will notify the
>> process who owns the poisoned page by sending SIGBUS with BUS_MCEERR_AO in
>> early kill mode. However, the GHES driver always sets mf_flags to 0 so that
>> all synchronous errors are handled as asynchronous errors in memory failure.
>>
>> To this end, set memory failure flags as MF_ACTION_REQUIRED on synchronous
>> events.
>>
>> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
>> Tested-by: Ma Wupeng <mawupeng1@huawei.com>
>> Reviewed-by: Kefeng Wang <wangkefeng.wang@huawei.com>
>> Reviewed-by: Xiaofei Tan <tanxiaofei@huawei.com>
>> Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>> Reviewed-by: James Morse <james.morse@arm.com>
> 
> Applied as 6.8 material.
> 
> The other patches in the series still need to receive tags from the
> APEI designated reviewers (as per MAINTAINERS).
> 
> Thanks!
> 

Thank you :)

I will wait more feedback of other patches from MAINTAINERS.

Cheers,
Shuai


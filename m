Return-Path: <linux-kernel+bounces-26021-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C13C82DA09
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 14:26:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92AE21C2130C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 13:26:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CCE5171A6;
	Mon, 15 Jan 2024 13:26:04 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04B43171A0;
	Mon, 15 Jan 2024 13:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4TDCYR4CzfzWmgG;
	Mon, 15 Jan 2024 21:24:59 +0800 (CST)
Received: from dggpemm100001.china.huawei.com (unknown [7.185.36.93])
	by mail.maildlp.com (Postfix) with ESMTPS id 85B5A18001C;
	Mon, 15 Jan 2024 21:25:58 +0800 (CST)
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm100001.china.huawei.com (7.185.36.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 15 Jan 2024 21:25:57 +0800
Message-ID: <e453b190-d387-4b74-bb2c-fbbd2a5c488d@huawei.com>
Date: Mon, 15 Jan 2024 21:25:57 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next v4 0/3] minor improvements for x86 mce processing
Content-Language: en-US
To: Tong Tiangen <tongtiangen@huawei.com>, Thomas Gleixner
	<tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
	<bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, <x86@kernel.org>,
	"H. Peter Anvin" <hpa@zytor.com>, Tony Luck <tony.luck@intel.com>, Andy
 Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Andrew
 Morton <akpm@linux-foundation.org>, Naoya Horiguchi <naoya.horiguchi@nec.com>
CC: <linux-kernel@vger.kernel.org>, <linux-edac@vger.kernel.org>,
	<linux-mm@kvack.org>, Guohanjun <guohanjun@huawei.com>
References: <20240111135548.3207437-1-tongtiangen@huawei.com>
From: Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <20240111135548.3207437-1-tongtiangen@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm100001.china.huawei.com (7.185.36.93)

Hi Borislav and Tony，

On 2024/1/11 21:55, Tong Tiangen wrote:
> In this patchset, we remove the unused macro EX_TYPE_COPY and centralize
> the processing of memory-failure to do_machine_check() to avoid calling
> memory_failure_queue() separately for different MC-Safe scenarios. In
> addition, MCE_IN_KERNEL_COPYIN is renamed MCE_IN_KERNEL_COPY_MC to expand
> its usage scope.

The patchset is a followup[1], as Borislav suggested[2], we firstly
cleanup unused EX_TYPE_COPY, then rename MCE_IN_KERNEL_COPYIN to
reduce confusion, could you give us some comments about it,
many thanks.

> 
> [1]https://lore.kernel.org/linux-mm/20230526063242.133656-1-wangkefeng.wang@huawei.com/
> 
[2] 
https://lore.kernel.org/linux-edac/20230602160138.GDZHoSYsWoPAinMszk@fat_crate.local/
> since v3:
>    1. Rebased on linux-next tag next-20240111.
>    2. Delete duplicate commit references on patch 3.
> 
> since v2:
>    1. remove redundant fixup type EX_TYPE_COPY.
>    2. rename MCE_IN_KERNEL_COPYIN to MCE_IN_KERNEL_COPY_MC.
>    3. update patch3's commit message and the processing logic of
>       EX_TYPE_DEFAULT_MCE_SAFE based on the discussion of [1].
> 
> Kefeng Wang (1):
>    x86/mce: set MCE_IN_KERNEL_COPY_MC for DEFAULT_MCE_SAFE exception
> 
> Tong Tiangen (2):
>    x86/mce: remove redundant fixup type EX_TYPE_COPY
>    x86/mce: rename MCE_IN_KERNEL_COPYIN to MCE_IN_KERNEL_COPY_MC
> 
>   arch/x86/include/asm/asm.h                 |  3 ---
>   arch/x86/include/asm/extable_fixup_types.h | 23 +++++++++++-----------
>   arch/x86/include/asm/mce.h                 |  8 ++++----
>   arch/x86/kernel/cpu/mce/core.c             |  2 +-
>   arch/x86/kernel/cpu/mce/severity.c         |  7 +++----
>   arch/x86/mm/extable.c                      |  9 ---------
>   mm/ksm.c                                   |  1 -
>   mm/memory.c                                | 13 ++++--------
>   8 files changed, 23 insertions(+), 43 deletions(-)
> 



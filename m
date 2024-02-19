Return-Path: <linux-kernel+bounces-71712-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2761F85A95C
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 17:53:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A8581C22AF5
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 16:53:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 061AC42060;
	Mon, 19 Feb 2024 16:53:46 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F64341C90
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 16:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708361625; cv=none; b=rXw8FGdZ/LBKlahFmI3gJoChELeidABALntl6sO0MKDvHVrVFP3Gong7KUex7umGzq1D3KvC47FAG0Vn3snWLrjc/ExMjJ/OjqBgjbG9duvkpJSBqwzojRTQSII+7P5O1fXrlefFDmvFnF0NxV9oQb5fvlyfPOIC9TUWO7d8eFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708361625; c=relaxed/simple;
	bh=KoQJFulaE3GjiTYeD949sVNOR6BpYwswM2yFF/Q1HPE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rM27Qj/8NmQZKJvgt67HG+sQnIygDecM/41jaX3HM3GoDp0pCQYRW3AiEA+pdpREBcwU5ujscffcpzSrg8d01KISWietdONtHBvLGYA20bT6Vht+9VgxkQclGeXmZXcLOTngxYiYZq31Rt3t7zgruFEDr6qWyc4iepmN7B96gQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 44A13DA7;
	Mon, 19 Feb 2024 08:54:22 -0800 (PST)
Received: from [10.1.197.60] (eglon.cambridge.arm.com [10.1.197.60])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 09FB93F762;
	Mon, 19 Feb 2024 08:53:39 -0800 (PST)
Message-ID: <66a54c8b-2013-48d9-8114-6f3f72cd2871@arm.com>
Date: Mon, 19 Feb 2024 16:53:38 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 00/24] x86/resctrl: monitored closid+rmid together,
 separate arch/fs locking
Content-Language: en-GB
To: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org,
 Fenghua Yu <fenghua.yu@intel.com>,
 Reinette Chatre <reinette.chatre@intel.com>, Ingo Molnar <mingo@redhat.com>,
 H Peter Anvin <hpa@zytor.com>, Babu Moger <Babu.Moger@amd.com>,
 shameerali.kolothum.thodi@huawei.com,
 D Scott Phillips OS <scott@os.amperecomputing.com>,
 carl@os.amperecomputing.com, lcherian@marvell.com,
 bobo.shaobowang@huawei.com, tan.shaopeng@fujitsu.com,
 baolin.wang@linux.alibaba.com, Jamie Iles <quic_jiles@quicinc.com>,
 Xin Hao <xhao@linux.alibaba.com>, peternewman@google.com,
 dfustini@baylibre.com, amitsinght@marvell.com,
 David Hildenbrand <david@redhat.com>
References: <20240213184438.16675-1-james.morse@arm.com>
 <20240217105543.GAZdCQr_nosDP4tGuO@fat_crate.local> <87zfvwieli.ffs@tglx>
From: James Morse <james.morse@arm.com>
In-Reply-To: <87zfvwieli.ffs@tglx>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Thomas,

On 19/02/2024 16:49, Thomas Gleixner wrote:
> On Sat, Feb 17 2024 at 11:55, Borislav Petkov wrote:
>> On Tue, Feb 13, 2024 at 06:44:14PM +0000, James Morse wrote:
>>> It's been back and forth for whether this series should be rebased onto Tony's
>>> SNC series. This version isn't, its based on tip/x86/cache.
>>> (I have the rebased-and-tested versions if anyone needs them)
>>
>> The set applied ontop of tip:x86/cache gives:
>>
>> vmlinux.o: in function `get_domain_from_cpu':
>> (.text+0x150f33): undefined reference to `lockdep_is_cpus_held'
>> ld: vmlinux.o: in function `rdt_ctrl_update':
>> (.text+0x150fbc): undefined reference to `lockdep_is_cpus_held'
> 
> Wants to be folded into patch 24.

Thanks - I'm just putting a v10 together to fix this.


Thanks,

James


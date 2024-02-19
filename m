Return-Path: <linux-kernel+bounces-71715-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1183385A962
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 17:54:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C14F628628A
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 16:54:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C600446A5;
	Mon, 19 Feb 2024 16:54:09 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1D3F41C7F
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 16:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708361649; cv=none; b=qiwd6jJEXn8RfcFYvIJN4avd4QomHqMF7Fj6ToyHqjOKQlUFAmucwxj4GON3izfJM1/uzTq8WhUzGeJV+scE1TLdU5Q1CgHEtHyqY0IvrDM+qS0XPYVQZ88Wocev5qrJv33neYFXNcXh2p2IJUOoA8Y6Cn4eFm6gj5RidmAfpIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708361649; c=relaxed/simple;
	bh=d3FFtmVDcy88mLXzI3vAbFxtqxVOVctxIqhCxkaIvgE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bPM92zPPVJuin+C8VtjB0ELiLIy56MegZOZcjLT/NlFAGlUkfOLDMIBej/LsiBMJS+BZJYcqR2esaEzFCMSF4k4xUYj6f0UMpAWddu1BnrCRRlB71Xf1LOiu4VtN8G8El5IbbKYWuaALpf21GuvRqnpWdy7zYcr+Dus7YWfQVRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B67DCDA7;
	Mon, 19 Feb 2024 08:54:46 -0800 (PST)
Received: from [10.1.197.60] (eglon.cambridge.arm.com [10.1.197.60])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 44D9A3F762;
	Mon, 19 Feb 2024 08:54:03 -0800 (PST)
Message-ID: <236e74ff-4a34-4e7a-9ed4-36a7112476a8@arm.com>
Date: Mon, 19 Feb 2024 16:54:03 +0000
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
To: Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org,
 Fenghua Yu <fenghua.yu@intel.com>,
 Reinette Chatre <reinette.chatre@intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
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
 <20240217105543.GAZdCQr_nosDP4tGuO@fat_crate.local>
From: James Morse <james.morse@arm.com>
In-Reply-To: <20240217105543.GAZdCQr_nosDP4tGuO@fat_crate.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Boris,

Thanks for the config, (as Thomas pointed out) this is coming from an awkward lockdep
annotation - turns out it also depends on HOTPLUG_CPU.

I'll post a v10 with the collected tags and this fixed.


Thanks,

James

On 17/02/2024 10:55, Borislav Petkov wrote:
> On Tue, Feb 13, 2024 at 06:44:14PM +0000, James Morse wrote:
>> Hello!
>>
>> It's been back and forth for whether this series should be rebased onto Tony's
>> SNC series. This version isn't, its based on tip/x86/cache.
>> (I have the rebased-and-tested versions if anyone needs them)
> 
> The set applied ontop of tip:x86/cache gives:
> 
> vmlinux.o: in function `get_domain_from_cpu':
> (.text+0x150f33): undefined reference to `lockdep_is_cpus_held'
> ld: vmlinux.o: in function `rdt_ctrl_update':
> (.text+0x150fbc): undefined reference to `lockdep_is_cpus_held'
> 
> Config
> 
> 00-14-04-randconfig-x86_64-26892.cfg
> 
> attached.
> 
> Thx.
> 



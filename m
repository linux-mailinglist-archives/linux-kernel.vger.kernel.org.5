Return-Path: <linux-kernel+bounces-33907-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B03F8371E2
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 20:07:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 61B49B33E93
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 18:35:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15BD85FDCE;
	Mon, 22 Jan 2024 18:07:00 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01DAC5FDAB
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 18:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705946819; cv=none; b=EFWU2GW995G1BY4OWj6z8kJBMq6j7YCgqOg+MlTfZQ6/nK0MO9UHXJkeVqEQE9p9nj/8owy9PXLvdeRaHyR28OJqwfdhOAfH12B2xbTVFXyRl95f9kLjNs5G8zcpxt9DgHpYQMHIaGgt/S666eOdahw9vg9Aornt2/qS5/3d4gE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705946819; c=relaxed/simple;
	bh=qDzRawGw69D2q6DbodKoqIW02mR+bt5R7SUpFXqkdCE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kVu5KZnDi/wUFUXeS3GG0YZaOr0+JXoGz8K+rvNKflHWdaCsSLMF+udrFCz5cNpU8fl53gBdHHMznW363NHrdSObXzLLbyWDlpiUd4mQOiH8FkfEAqoEr7n8NWh0c3VF0uhdtxDhHZt8L0Eo6t2LHNyheCt3H1zfTjLAbjkNtls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9FD831474;
	Mon, 22 Jan 2024 10:07:43 -0800 (PST)
Received: from [10.1.197.60] (eglon.cambridge.arm.com [10.1.197.60])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B3B3E3F5A1;
	Mon, 22 Jan 2024 10:06:54 -0800 (PST)
Message-ID: <4ffe1482-62b7-ebea-def5-9239320002be@arm.com>
Date: Mon, 22 Jan 2024 18:06:53 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v8 00/24] x86/resctrl: monitored closid+rmid together,
 separate arch/fs locking
Content-Language: en-GB
To: Carl Worth <carl@os.amperecomputing.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Cc: Fenghua Yu <fenghua.yu@intel.com>,
 Reinette Chatre <reinette.chatre@intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, H Peter Anvin <hpa@zytor.com>,
 Babu Moger <Babu.Moger@amd.com>, shameerali.kolothum.thodi@huawei.com,
 D Scott Phillips OS <scott@os.amperecomputing.com>, lcherian@marvell.com,
 bobo.shaobowang@huawei.com, tan.shaopeng@fujitsu.com,
 baolin.wang@linux.alibaba.com, Jamie Iles <quic_jiles@quicinc.com>,
 Xin Hao <xhao@linux.alibaba.com>, peternewman@google.com,
 dfustini@baylibre.com, amitsinght@marvell.com
References: <20231215174343.13872-1-james.morse@arm.com>
 <874jg9rh7k.fsf@rasp.cworth.amperemail.amperecomputing.com>
From: James Morse <james.morse@arm.com>
In-Reply-To: <874jg9rh7k.fsf@rasp.cworth.amperemail.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Carl,

On 22/12/2023 22:43, Carl Worth wrote:
> James Morse <james.morse@arm.com> writes:
>> This series does two things, it changes resctrl to call resctrl_arch_rmid_read()
>> in a way that works for MPAM, and it separates the locking so that the arch code
>> and filesystem code don't have to share a mutex. I tried to split this as two
>> series, but these touch similar call sites, so it would create more work.
>>
>> (What's MPAM? See the cover letter of the first series. [1])
> 
> Thanks, James. This is really useful for us at Ampere since it enables
> the MPAM driver on top of this series.
> 
> I've tested this series on an Ampere implementation, by successfully
> using resctrl to configure and exercise MPAM functionality.

Great! Thanks for this.


> I can't
> speak to the effects of the refactor on x86 since I have not tested that
> all.

> For the series:
> Tested-by: Carl Worth <carl@os.amperecomputing.com>

Thanks, I'll add an "# arm64" on the end of that to preserve your above comment about not
testing this on x86.


Thanks,

James


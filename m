Return-Path: <linux-kernel+bounces-33904-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66C3283704E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 19:42:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D58FBB23C99
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 18:35:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9219B5FB89;
	Mon, 22 Jan 2024 18:06:34 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75FF85F575
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 18:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705946794; cv=none; b=JaUqw0bh+rGD7seHronWuKvps8FUsAuOOFSDmCB9OxACNmcrxsvcqA3DTbW0qyQ9XPnLHMRz7u8aOjTXRsBCoNC7G0Acm+DiHnb/wOSAX5fNAAiKrE25TQEE7NETYBzIsTwTDSgYsVoRcKuza5EGWgfQtTOr3znis/2sRlfP8Bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705946794; c=relaxed/simple;
	bh=NtckBR3TcT+8he69QlRSmZ6hCyvdcL3370IbReUCHrw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rhwO+oacS+SHU20ADasPC+n1nwXlbgYgi+yn5Rixk47M4zC6KhZgOOhiP7YzOiliiIzSTSQa7bYQFSMZmwKsxJ5Z436LB0m2Z+8iGn4Z8IvPiH5UfaVD6iHZGTbTuiz1LZlmVwsF1Tle0Zg3DynMZVoON6bdmffJahkubfaEB0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 080A31474;
	Mon, 22 Jan 2024 10:07:18 -0800 (PST)
Received: from [10.1.197.60] (eglon.cambridge.arm.com [10.1.197.60])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 22DFD3F5A1;
	Mon, 22 Jan 2024 10:06:29 -0800 (PST)
Message-ID: <d679a449-cd7f-b21c-2bad-e3c6aeb9a956@arm.com>
Date: Mon, 22 Jan 2024 18:06:27 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v8 19/24] x86/resctrl: Add helpers for system wide
 mon/alloc capable
Content-Language: en-GB
To: babu.moger@amd.com, x86@kernel.org, linux-kernel@vger.kernel.org
Cc: Fenghua Yu <fenghua.yu@intel.com>,
 Reinette Chatre <reinette.chatre@intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, H Peter Anvin <hpa@zytor.com>,
 shameerali.kolothum.thodi@huawei.com,
 D Scott Phillips OS <scott@os.amperecomputing.com>,
 carl@os.amperecomputing.com, lcherian@marvell.com,
 bobo.shaobowang@huawei.com, tan.shaopeng@fujitsu.com,
 baolin.wang@linux.alibaba.com, Jamie Iles <quic_jiles@quicinc.com>,
 Xin Hao <xhao@linux.alibaba.com>, peternewman@google.com,
 dfustini@baylibre.com, amitsinght@marvell.com
References: <20231215174343.13872-1-james.morse@arm.com>
 <20231215174343.13872-20-james.morse@arm.com>
 <4283c1e1-5f3b-4e55-a40c-1a46b3d8e067@amd.com>
From: James Morse <james.morse@arm.com>
In-Reply-To: <4283c1e1-5f3b-4e55-a40c-1a46b3d8e067@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Babu,

On 03/01/2024 19:43, Moger, Babu wrote:
> On 12/15/23 11:43, James Morse wrote:
>> resctrl reads rdt_alloc_capable or rdt_mon_capable to determine
>> whether any of the resources support the corresponding features.
>> resctrl also uses the static-keys that affect the architecture's
>> context-switch code to determine the same thing.
>>
>> This forces another architecture to have the same static-keys.
>>
>> As the static-key is enabled based on the capable flag, and none of
>> the filesystem uses of these are in the scheduler path, move the
>> capable flags behind helpers, and use these in the filesystem
>> code instead of the static-key.
>>
>> After this change, only the architecture code manages and uses
>> the static-keys to ensure __resctrl_sched_in() does not need
>> runtime checks.
>>
>> This avoids multiple architectures having to define the same
>> static-keys.
>>
>> Cases where the static-key implicitly tested if the resctrl
>> filesystem was mounted all have an explicit check added by a
>> previous patch.

> Reviewed-by: Babu Moger <babu.moger@amd.com>


Thanks!

James


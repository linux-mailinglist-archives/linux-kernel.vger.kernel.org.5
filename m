Return-Path: <linux-kernel+bounces-52937-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C4746849E96
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 16:40:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 877AAB29F5C
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 15:39:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70D9C339BD;
	Mon,  5 Feb 2024 15:37:45 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6785A32C90
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 15:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707147465; cv=none; b=biBF89Bt3r59tmW7hZGcKYaaVj4+gHlInszpzFqI6gpwO0lRtyXxSquacln7wB9xlXJnwR84ravtNSW3CSfGCmu6i5SUfpkPRyRIu0Nv2j4XfJjlyXPfxsF5yWTvH7CDZ8yFuoTNE38K9jAvFywhnYjtKy3o4ZXZp3WQsw3Q8Lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707147465; c=relaxed/simple;
	bh=NAOhCgljajhu9rlMaYcMai/ExO7gay4hX8crqnQPk9k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s6mE2jUWR3oElwE7gqVgqmRnawUE7WMaL9E/O1L3Qt/QPrMUWxE00bP/iUVJR1G7zqERoALbzllFVn1MLXxLbuw9ejX1Vzon4IQl3dTjbdvHDDIm69mKBQK8rKuyOAoF7Ge6V/IySbWAti40MFy9xcH8krUbw/t2PEqG33eKeZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 618601FB;
	Mon,  5 Feb 2024 07:38:25 -0800 (PST)
Received: from [192.168.1.100] (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4D6B63F5A1;
	Mon,  5 Feb 2024 07:37:39 -0800 (PST)
Message-ID: <c773393c-221e-edd1-00b7-0ce6a2481c15@arm.com>
Date: Mon, 5 Feb 2024 15:37:34 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v4 2/7] arm64: KVM: Use shared area to pass PMU event
 state to hypervisor
Content-Language: en-US
To: Marc Zyngier <maz@kernel.org>
Cc: Oliver Upton <oliver.upton@linux.dev>, coresight@lists.linaro.org,
 linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
 broonie@kernel.org, suzuki.poulose@arm.com, acme@kernel.org,
 James Morse <james.morse@arm.com>, Zenghui Yu <yuzenghui@huawei.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linaro.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Anshuman Khandual <anshuman.khandual@arm.com>, Rob Herring
 <robh@kernel.org>, Miguel Luis <miguel.luis@oracle.com>,
 Jintack Lim <jintack.lim@linaro.org>, Ard Biesheuvel <ardb@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Arnd Bergmann <arnd@arndb.de>,
 Vincent Donnefort <vdonnefort@google.com>,
 Kristina Martsenko <kristina.martsenko@arm.com>,
 Fuad Tabba <tabba@google.com>, Joey Gouly <joey.gouly@arm.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>, Jing Zhang
 <jingzhangos@google.com>, linux-kernel@vger.kernel.org
References: <20240104162714.1062610-1-james.clark@arm.com>
 <20240104162714.1062610-3-james.clark@arm.com> <Zb1mCCi13AJ_YjFZ@linux.dev>
 <8a908ee8-620a-d9c2-734b-5a6402950072@arm.com> <ZcDc8-FQo8wKavA4@linux.dev>
 <867cjj6ohz.wl-maz@kernel.org> <ZcDg1sP3EYZG-i_3@linux.dev>
 <a7cc7791-c476-fd81-b79d-a151293b8302@arm.com> <864jen6k0i.wl-maz@kernel.org>
From: James Clark <james.clark@arm.com>
In-Reply-To: <864jen6k0i.wl-maz@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 05/02/2024 14:52, Marc Zyngier wrote:
> On Mon, 05 Feb 2024 14:17:10 +0000,
> James Clark <james.clark@arm.com> wrote:
>>
>> On 05/02/2024 13:21, Oliver Upton wrote:
>>> On Mon, Feb 05, 2024 at 01:15:36PM +0000, Marc Zyngier wrote:
>>>> On Mon, 05 Feb 2024 13:04:51 +0000,
>>>> Oliver Upton <oliver.upton@linux.dev> wrote:
>>>>>
>>>>> Unless someone has strong opinions about making this work in protected
>>>>> mode, I am happy to see tracing support limited to the 'normal' nVHE
>>>>> configuration. The protected feature as a whole is just baggage until
>>>>> upstream support is completed.
>>>>
>>>> Limiting tracing to non-protected mode is a must IMO. Allowing tracing
>>>> when pKVM is enabled is a sure way to expose secrets that should
>>>> stay... secret. The only exception I can think of is when
>>>> CONFIG_NVHE_EL2_DEBUG is enabled, at which point all bets are off.
>>>
>>> Zero argument there :) I left off the "and PMU" part of what I was
>>> saying, because that was a feature that semi-worked in protected mode
>>> before VM/VCPU shadowing support landed.
>>>
>>
>> In that case I can hide all this behind CONFIG_NVHE_EL2_DEBUG for pKVM.
>> This will also have the effect of disabling PMU again for pKVM because I
>> moved that into this new shared area.
> 
> I'm not sure what you have in mind, but dropping PMU support for
> non-protected guests when protected-mode is enabled is not an
> acceptable outcome.
> 
> Hiding the trace behind a debug option is fine as this is a global
> setting that has no userspace impact, but impacting guests isn't.
> 
> 	M.
> 

Hmmm in that case if there's currently no way to distinguish between
normal VMs and pVMs in protected-mode then what I was thinking of
probably won't work.

I'll actually just leave PMU as it is and only have tracing disabled in
protected-mode.

My only question now is whether to:

 * Keep this new shared area and use it for both PMU and trace status
   (well, for PMU only in protected mode as trace would always be
   disabled and doesn't actually need any state)

 * Delete patch 2, add a new normal per-cpu struct just for
   trace status that's only used in non-protected mode and revert to
   copying the PMU status into the vCPU on guest switch as it was
   previously.


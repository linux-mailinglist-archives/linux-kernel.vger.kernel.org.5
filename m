Return-Path: <linux-kernel+bounces-52803-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D2EDE849CD3
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 15:17:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EE4C286AEF
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 14:17:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48C092C69B;
	Mon,  5 Feb 2024 14:17:18 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07C402C688
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 14:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707142637; cv=none; b=heWA2oVnnyiKKlOxfFNWQNa1sW7E2IEYNf8jLnq95I11XCGxVlJKngRs53FCLIKQumnsbW4RgiRjv+vOmN5m+1/1UhQyLvQZgn7nkDKebCrxzpdwNqW+Cy1LYB8a0YnQdIW0H8RNGg+ozGHTD3B64YYFI43HvdABZO4XBdACC5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707142637; c=relaxed/simple;
	bh=nQTYnKbRzQLSB3AQO/WmD1zqTLESyqxm1/7PWB3Kn6M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ebLSvxj+QC0z4YBucubfNg1fMuldvN/IIE6Gyns+/wU5Eh8vzPzJp1aawx2DOg2KCIkuoqAxewaNjGuDdcmtAUEJxX+pxSAmsHaYS86VEK6Q7wLxTmTnzXt7mw1+nC1aq5m/gyH0TvSzo5xJoU1pDFcyd9BrkfbGP2UcN1YAjW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ECF051FB;
	Mon,  5 Feb 2024 06:17:57 -0800 (PST)
Received: from [192.168.1.100] (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4D44B3F5A1;
	Mon,  5 Feb 2024 06:17:11 -0800 (PST)
Message-ID: <a7cc7791-c476-fd81-b79d-a151293b8302@arm.com>
Date: Mon, 5 Feb 2024 14:17:10 +0000
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
To: Oliver Upton <oliver.upton@linux.dev>, Marc Zyngier <maz@kernel.org>
Cc: coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
 kvmarm@lists.linux.dev, broonie@kernel.org, suzuki.poulose@arm.com,
 acme@kernel.org, James Morse <james.morse@arm.com>,
 Zenghui Yu <yuzenghui@huawei.com>, Catalin Marinas
 <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
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
From: James Clark <james.clark@arm.com>
In-Reply-To: <ZcDg1sP3EYZG-i_3@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 05/02/2024 13:21, Oliver Upton wrote:
> On Mon, Feb 05, 2024 at 01:15:36PM +0000, Marc Zyngier wrote:
>> On Mon, 05 Feb 2024 13:04:51 +0000,
>> Oliver Upton <oliver.upton@linux.dev> wrote:
>>>
>>> Unless someone has strong opinions about making this work in protected
>>> mode, I am happy to see tracing support limited to the 'normal' nVHE
>>> configuration. The protected feature as a whole is just baggage until
>>> upstream support is completed.
>>
>> Limiting tracing to non-protected mode is a must IMO. Allowing tracing
>> when pKVM is enabled is a sure way to expose secrets that should
>> stay... secret. The only exception I can think of is when
>> CONFIG_NVHE_EL2_DEBUG is enabled, at which point all bets are off.
> 
> Zero argument there :) I left off the "and PMU" part of what I was
> saying, because that was a feature that semi-worked in protected mode
> before VM/VCPU shadowing support landed.
> 

In that case I can hide all this behind CONFIG_NVHE_EL2_DEBUG for pKVM.
This will also have the effect of disabling PMU again for pKVM because I
moved that into this new shared area.

The same place will be used to store the state for normal nVHE and at
least then there is some code re-use and flexibility to use trace and
PMU for debugging if needed. And the copy on every switch gets deleted.


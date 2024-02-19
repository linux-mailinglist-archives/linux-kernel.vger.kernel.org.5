Return-Path: <linux-kernel+bounces-70664-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9397859AD6
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 03:52:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBE171C21000
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 02:52:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7E2623CB;
	Mon, 19 Feb 2024 02:52:49 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2A5720F1;
	Mon, 19 Feb 2024 02:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708311169; cv=none; b=edkhAkOUTwvrMSGLR/QzU3Kxfm/VTXl6IcSBYx3bOzZGQGCHIB+tlbnfvonJjp2+qejS97A4DtWGWUBWS9Ftgy+XgkglVBMZu1perytWV32dymGsq+gVP9ys1lo/h4mCuYOcnr4ap8Ulkk+YdLTZheO8hqAkHWmszeHFG4XRdgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708311169; c=relaxed/simple;
	bh=/5quQyLZ0qlAalvNxnek0ybbYAycaAWEuCwqEblZfek=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Wg2CZ8VmBLizPIxwLAU/yYSadd93ZchzBFU41vlGkNEE4obwBlfs+GSgKhe3bxG330wilmbQGolIgMnIFrzCrVmIHrKuPS4tK51ac+jNkDBTpH5i1coZ60PbFz4V2bB/8yUdZNlGDFldQ+2HDc5MUCD1yYhz8bqYV4UQyhPzsGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 81CE4FEC;
	Sun, 18 Feb 2024 18:53:20 -0800 (PST)
Received: from [10.162.43.127] (a077893.blr.arm.com [10.162.43.127])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B10943F766;
	Sun, 18 Feb 2024 18:52:36 -0800 (PST)
Message-ID: <ff8cbe8c-c56e-4e04-8d89-040d2ba2fd0e@arm.com>
Date: Mon, 19 Feb 2024 08:22:33 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 05/11] coresight: replicator: Move ACPI support from
 AMBA driver to platform driver
Content-Language: en-US
To: Suzuki K Poulose <suzuki.poulose@arm.com>,
 linux-arm-kernel@lists.infradead.org
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Sudeep Holla <sudeep.holla@arm.com>, Mike Leach <mike.leach@linaro.org>,
 James Clark <james.clark@arm.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org, coresight@lists.linaro.org,
 linux-stm32@st-md-mailman.stormreply.com
References: <20240123054608.1790189-1-anshuman.khandual@arm.com>
 <20240123054608.1790189-6-anshuman.khandual@arm.com>
 <b72c54bf-17a8-453c-8fbb-fbc90abdb45a@arm.com>
 <b0c8b92e-53bc-4232-a748-ff3e6b94b112@arm.com>
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <b0c8b92e-53bc-4232-a748-ff3e6b94b112@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/15/24 16:55, Suzuki K Poulose wrote:
> On 15/02/2024 11:23, Suzuki K Poulose wrote:
>> Hi Anshuman
>>
>> On 23/01/2024 05:46, Anshuman Khandual wrote:
>>> Add support for the dynamic replicator device in the platform driver, which
>>> can then be used on ACPI based platforms. This change would now allow
>>> runtime power management for repliacator devices on ACPI based systems.
>>>
>>> The driver would try to enable the APB clock if available. Also, rename the
>>> code to reflect the fact that it now handles both static and dynamic
>>> replicators.
>>>
>>> Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>
>>> Cc: Sudeep Holla <sudeep.holla@arm.com>
>>> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
>>> Cc: Mike Leach <mike.leach@linaro.org>
>>> Cc: James Clark <james.clark@arm.com>
>>> Cc: linux-acpi@vger.kernel.org
>>> Cc: linux-arm-kernel@lists.infradead.org
>>> Cc: linux-kernel@vger.kernel.org
>>> Cc: coresight@lists.linaro.org
>>> Tested-by: Sudeep Holla <sudeep.holla@arm.com> # Boot and driver probe only
>>> Acked-by: Sudeep Holla <sudeep.holla@arm.com> # For ACPI related changes
>>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>>
>> I think the patch is doing three different things:
>>
>> 1) Use new helper to register/remove AMBA/Platform drivers
>> 2) Refactor replicator_probe() to make sure it can be reused for platform/amba driver, by moving the pm_runtime_put() to the callers.
>> 3) Actually moving the ACPI driver to Platform driver
>>
>> While (1) and (3) are obvious, (2) gave me hard time to review this
>> patch, without proper description. If you don't mind, are you able to
>> split the patch and add proper description of the 3 changes mentioned
>> above.
>>
> 
> You could even move (1) for all the existing drivers into a single patch
> or even fold it with the patch that introduces the helpers. That way it

There are only two existing coresight devices with both AMBA and platform
drivers available i.e replicator and funnel. Such devices could use these
new helpers right from the beginning. As you mentioned earlier such changes
might be folded back into the patch adding the helpers.

But coresight devices such as catu, tpiu, tmc, stm and debug don't have
platform drivers to begin with. Hence the helpers could only be used in
their respective patches adding platform drivers.

> is cleaner and easier to review. And (2) & (3) could be in the same patch for each driver, but please add something in the description for (2).

Please find the updated commit message here, does this look okay ?

    coresight: replicator: Move ACPI support from AMBA driver to platform driver

    Add support for the dynamic replicator device in the platform driver, which
    can then be used on ACPI based platforms. This change would now allow
    runtime power management for replicator devices on ACPI based systems.

    The driver would try to enable the APB clock if available. Also, rename the
    code to reflect the fact that it now handles both static and dynamic
    replicators. But first this refactors replicator_probe() making sure it can
    be used both for platform and AMBA drivers, by moving the pm_runtime_put()
    to the callers.


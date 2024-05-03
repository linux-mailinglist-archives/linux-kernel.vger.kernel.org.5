Return-Path: <linux-kernel+bounces-167331-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F0E98BA801
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 09:42:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1057C1F22382
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 07:42:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 832D6147C7B;
	Fri,  3 May 2024 07:42:10 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 821A21474AB;
	Fri,  3 May 2024 07:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714722130; cv=none; b=FM7XIKe8AMXsOSePy6kARrKsMT1qt/0+UiwQqcdjA4OFPi11aoKIzi/827jp+vZ1AO7oEkCi97nZrQTYRKOZTUwBiAqnhwQrxEYT3eO+BceZGIdmKTqozeodM1Z4CgnRpx1Z8KyZmwk4Vkzg8kb8FG0sqOBI6ocCwcPkTapkD/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714722130; c=relaxed/simple;
	bh=6edhduxDLDcnKBBZyI5XlvefnupBc6loVKJdVj0KwHg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tWR45LPaLo1Mqt3Et1eguKLWOAX4wybirFe3ecEWuhJ68J1GY3ZuCrDUdSglCELwwRC++J1f+2quCxFU3vVHNcehR2XHymUNFEeixzUag1+d4Iviu7qF0An1ygDJJk5YyMQvmmmOoLh2DBKb25Dw3tGQEd1C3wvzV5P2leG9Yo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0D7E32F4;
	Fri,  3 May 2024 00:42:32 -0700 (PDT)
Received: from [10.57.34.89] (unknown [10.57.34.89])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1080F3F73F;
	Fri,  3 May 2024 00:42:04 -0700 (PDT)
Message-ID: <0f8ccc3d-46ca-4632-9ecf-5da596ad5a1a@arm.com>
Date: Fri, 3 May 2024 09:42:02 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpufreq/cppc: fix perf_to_khz conversion exception
To: liwei <liwei728@huawei.com>
Cc: linux-acpi@vger.kernel.org, rafael@kernel.org,
 linux-kernel@vger.kernel.org, lenb@kernel.org, liwei391@huawei.com,
 viresh.kumar@linaro.org
References: <20240430101227.2133288-1-liwei728@huawei.com>
Content-Language: en-US
From: Pierre Gondois <pierre.gondois@arm.com>
In-Reply-To: <20240430101227.2133288-1-liwei728@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello Liwei,

Thanks for the fix. I think there might be a similar issue
in cppc_khz_to_perf(),

Regards,
Pierre

On 4/30/24 12:12, liwei wrote:
> When the nominal_freq recorded by the kernel is equal to lowest_freq and
> the frequency reduction operation is triggered externally, there is a
> conversion logic error in cppc_perf_to_khz(), causing the kernel to be
> unable to feedback the true frequency.
> 
> Fix this by adding the branch processing logic when nominal_freq is equal
> to lowest_freq.
> 
> Fixes: ec1c7ad47664 ("cpufreq: CPPC: Fix performance/frequency conversion")
> Signed-off-by: liwei <liwei728@huawei.com>
> ---
>   drivers/acpi/cppc_acpi.c | 10 ++++++++--
>   1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
> index a40b6f3946ef..92aac6974e0e 100644
> --- a/drivers/acpi/cppc_acpi.c
> +++ b/drivers/acpi/cppc_acpi.c
> @@ -1869,9 +1869,15 @@ unsigned int cppc_perf_to_khz(struct cppc_perf_caps *caps, unsigned int perf)
>   	u64 mul, div;
>   
>   	if (caps->lowest_freq && caps->nominal_freq) {
> -		mul = caps->nominal_freq - caps->lowest_freq;
> +		/* Avoid the special case when nominal_freq is equal to lowest_freq */
> +		if (caps->lowest_freq == caps->nominal_freq) {
> +			mul = caps->nominal_freq;
> +			div = caps->nominal_perf;
> +		} else {
> +			mul = caps->nominal_freq - caps->lowest_freq;
> +			div = caps->nominal_perf - caps->lowest_perf;
> +		}
>   		mul *= KHZ_PER_MHZ;
> -		div = caps->nominal_perf - caps->lowest_perf;
>   		offset = caps->nominal_freq * KHZ_PER_MHZ -
>   			 div64_u64(caps->nominal_perf * mul, div);
>   	} else {


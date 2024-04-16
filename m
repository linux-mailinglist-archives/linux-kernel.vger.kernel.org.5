Return-Path: <linux-kernel+bounces-147301-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D58A08A722F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 19:24:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FBEF1C20D8E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 17:24:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65451133284;
	Tue, 16 Apr 2024 17:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="N+VVVFIh"
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66BE91332A7;
	Tue, 16 Apr 2024 17:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713288276; cv=none; b=iwHlkIJOfFmhwG2QuaEp2mSaRu2pmRtS3kOWXVv+6kWIESr7msfP1/qaSOXSZ/1TlibDTM5fdykGzzWf8FlpcnIi6NIkzkw4v/EeOzcd2yIR7A9/aisKmQJhM4UaMsa4yks/DbJq13YjX75u7Lg4qe4D9mb2XcNbblMCjHdPZvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713288276; c=relaxed/simple;
	bh=XzlHoWbCewhBMWvTfN59eZpOMbP92r+tEx3PdmU5CvI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FPLXFh/pVuuN06ZGeMLNO/FqtpnsHhxuTTaJl1Oh78aYivRGlbcrd+OfFYgrKfA0JfLoMAACdKOt7BCzmV+kbOlpt7IpEyEaq+H9uDz/SLmRjhWpKaMmSKIJcuhkwtA5IpAYJs0dXKgf0RW6mABk6ZZdzKloCTF2CLJ0wgQqXPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=N+VVVFIh; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.192.9.210] (unknown [167.220.77.82])
	by linux.microsoft.com (Postfix) with ESMTPSA id AB92420FD413;
	Tue, 16 Apr 2024 10:24:28 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com AB92420FD413
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1713288268;
	bh=ls55kzA4NgbPtH5yXF9qjPYhHDVyOeLEqJj+MKe3bqM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=N+VVVFIhkTvl4mLN4zwmv18TFMdC9JISjm+SBtgcqQ/5V1d08QI196QyOuqKmgLgK
	 gCwBJDk+xncjm55NHbewVDIppAYbhxBgHvN1AqDBceTG6SQy0aGsRDxg/7cxLCwjzZ
	 kr5pbQVz9AIpAz7G1LQvGNTz83oE7ALyIynw3QIs=
Message-ID: <cc48b26a-f67e-43bc-a29f-2e9f36cecc45@linux.microsoft.com>
Date: Tue, 16 Apr 2024 10:24:27 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ACPI: CPPC: Fix bit_offset shift in MASK_VAL macro
To: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 Easwar Hariharan <eahariha@linux.microsoft.com>,
 "open list:ACPI" <linux-acpi@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>
Cc: Vanshidhar Konda <vanshikonda@os.amperecomputing.com>,
 stable@vger.kernel.org
References: <20240409052310.3162495-1-jarredwhite@linux.microsoft.com>
Content-Language: en-CA
From: Jarred White <jarredwhite@linux.microsoft.com>
In-Reply-To: <20240409052310.3162495-1-jarredwhite@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/8/2024 10:23 PM, Jarred White wrote:
> Commit 2f4a4d63a193 ("ACPI: CPPC: Use access_width over bit_width for
> system memory accesses") neglected to properly wrap the bit_offset shift
> when it comes to applying the mask. This may cause incorrect values to be
> read and may cause the cpufreq module not be loaded.
> 
> [   11.059751] cpu_capacity: CPU0 missing/invalid highest performance.
> [   11.066005] cpu_capacity: partial information: fallback to 1024 for all CPUs
> 
> Also, corrected the bitmask generation in GENMASK (extra bit being added).
> 
> Fixes: 2f4a4d63a193 ("ACPI: CPPC: Use access_width over bit_width for system memory accesses")
> Signed-off-by: Jarred White <jarredwhite@linux.microsoft.com>
> CC: Vanshidhar Konda <vanshikonda@os.amperecomputing.com>
> CC: stable@vger.kernel.org #5.15+
> ---
>   drivers/acpi/cppc_acpi.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
> index 4bfbe55553f4..00a30ca35e78 100644
> --- a/drivers/acpi/cppc_acpi.c
> +++ b/drivers/acpi/cppc_acpi.c
> @@ -170,8 +170,8 @@ show_cppc_data(cppc_get_perf_ctrs, cppc_perf_fb_ctrs, wraparound_time);
>   #define GET_BIT_WIDTH(reg) ((reg)->access_width ? (8 << ((reg)->access_width - 1)) : (reg)->bit_width)
>   
>   /* Shift and apply the mask for CPC reads/writes */
> -#define MASK_VAL(reg, val) ((val) >> ((reg)->bit_offset & 			\
> -					GENMASK(((reg)->bit_width), 0)))
> +#define MASK_VAL(reg, val) (((val) >> (reg)->bit_offset) & 			\
> +					GENMASK(((reg)->bit_width) - 1, 0))
>   
>   static ssize_t show_feedback_ctrs(struct kobject *kobj,
>   		struct kobj_attribute *attr, char *buf)

Hi Vanshi,

Could you review please?


Thanks,
Jarred


Return-Path: <linux-kernel+bounces-6864-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2FE1819EA6
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 13:07:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E642F1C21725
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 12:07:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BDEB2209D;
	Wed, 20 Dec 2023 12:07:04 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70BE122303;
	Wed, 20 Dec 2023 12:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B19171FB;
	Wed, 20 Dec 2023 04:07:46 -0800 (PST)
Received: from [192.168.1.3] (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 40BF53F5A1;
	Wed, 20 Dec 2023 04:07:00 -0800 (PST)
Message-ID: <a3ae638f-8efc-70d9-75fd-9473db3de24d@arm.com>
Date: Wed, 20 Dec 2023 12:06:59 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 2/3] perf scripts python: arm-cs-trace-disasm.py: set
 start vm addr of exectable file to 0
Content-Language: en-US
To: Ruidong Tian <tianruidong@linux.alibaba.com>, linux-kernel@vger.kernel.org
Cc: coresight@lists.linaro.org, suzuki.poulose@arm.com,
 mike.leach@linaro.org, alexander.shishkin@linux.intel.com,
 linux-arm-kernel@lists.infradead.org, adrian.hunter@intel.com,
 linux-perf-users@vger.kernel.org, leo.yan@linaro.org, al.grant@arm.com,
 mathieu.poirier@linaro.org, tor@ti.com, acme@redhat.com
References: <20231214123304.34087-1-tianruidong@linux.alibaba.com>
 <20231214123304.34087-3-tianruidong@linux.alibaba.com>
From: James Clark <james.clark@arm.com>
In-Reply-To: <20231214123304.34087-3-tianruidong@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 14/12/2023 12:33, Ruidong Tian wrote:
> For exectable ELF file, which e_type is ET_EXEC, dso start address is a
> absolute address other than offset. Just set vm_start to zero when dso
> start is 0x400000, which means it is a exectable file.
> 
> Signed-off-by: Ruidong Tian <tianruidong@linux.alibaba.com>
> ---
>  tools/perf/scripts/python/arm-cs-trace-disasm.py | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/scripts/python/arm-cs-trace-disasm.py b/tools/perf/scripts/python/arm-cs-trace-disasm.py
> index 46bf6b02eea1..c9e14af5b58c 100755
> --- a/tools/perf/scripts/python/arm-cs-trace-disasm.py
> +++ b/tools/perf/scripts/python/arm-cs-trace-disasm.py
> @@ -260,8 +260,9 @@ def process_event(param_dict):
>  
>  	if (options.objdump_name != None):
>  		# It doesn't need to decrease virtual memory offset for disassembly
> -		# for kernel dso, so in this case we set vm_start to zero.
> -		if (dso == "[kernel.kallsyms]"):
> +		# for kernel dso and executable file dso, so in this case we set
> +		# vm_start to zero.
> +		if (dso == "[kernel.kallsyms]" or dso_start == 0x400000):
>  			dso_vm_start = 0
>  		else:
>  			dso_vm_start = int(dso_start)

I confirmed that this fixes the disassembly for static binaries. It
would have been nice to check the type of the file rather than using a
magic number, but it's not that easy and I don't really see a chance of
the number having a false positive.

I wonder if it's worth putting a fixes tag on this one? For the other
ones I'd say no tag as they have a chance of breaking things.

Reviewed-by: James Clark <james.clark@arm.com>


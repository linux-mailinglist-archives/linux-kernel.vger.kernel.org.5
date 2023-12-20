Return-Path: <linux-kernel+bounces-6767-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BD40819D40
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 11:45:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F9AD1C25853
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 10:45:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2F7520B2E;
	Wed, 20 Dec 2023 10:44:54 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEF5920B0B;
	Wed, 20 Dec 2023 10:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E1A9D1FB;
	Wed, 20 Dec 2023 02:45:36 -0800 (PST)
Received: from [192.168.1.3] (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 779FD3F5A1;
	Wed, 20 Dec 2023 02:44:50 -0800 (PST)
Message-ID: <912a39f4-025e-26a1-7786-091fa211f293@arm.com>
Date: Wed, 20 Dec 2023 10:44:49 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 1/3] perf scripts python: arm-cs-trace-disasm.py: print
 dso base address
To: Ruidong Tian <tianruidong@linux.alibaba.com>, linux-kernel@vger.kernel.org
Cc: coresight@lists.linaro.org, suzuki.poulose@arm.com,
 mike.leach@linaro.org, alexander.shishkin@linux.intel.com,
 linux-arm-kernel@lists.infradead.org, adrian.hunter@intel.com,
 linux-perf-users@vger.kernel.org, leo.yan@linaro.org, al.grant@arm.com,
 mathieu.poirier@linaro.org, tor@ti.com, acme@redhat.com
References: <20231214123304.34087-1-tianruidong@linux.alibaba.com>
 <20231214123304.34087-2-tianruidong@linux.alibaba.com>
Content-Language: en-US
From: James Clark <james.clark@arm.com>
In-Reply-To: <20231214123304.34087-2-tianruidong@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 14/12/2023 12:33, Ruidong Tian wrote:
> arm-cs-trace-disasm just print offset for library dso:
> 
> 	0000000000002200 <memcpy>:
>             2200: d503201f      nop
>             2204: 8b020024      add     x4, x1, x2
>             2208: 8b020005      add     x5, x0, x2
> 
> This print DSO base address to get complete virtual address for
> userspace application:
> 
> 	0000000000002200 <memcpy>: (base address is 0x0000ffffb4c21000)
>             2200: d503201f      nop
>             2204: 8b020024      add     x4, x1, x2
>             2208: 8b020005      add     x5, x0, x2
> 

I believe the output format without the base address is consistent with
objdump. For compatibility I would say that it's better to keep it that way.

We could add this as an option, but have it disabled by default. I
suppose it depends how likely that someone is using this output in a
tool and processing it further whether an option is needed or not.

Although it's also not that clear what this is useful for, given that
all the other output is relative too? Maybe you could add an example to
the commit message, even if it's just for debugging. Would an option
that turned _all_ the output into virtual addresses not be more useful?

Thanks
James

> Signed-off-by: Ruidong Tian <tianruidong@linux.alibaba.com>
> ---
>  tools/perf/scripts/python/arm-cs-trace-disasm.py | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/tools/perf/scripts/python/arm-cs-trace-disasm.py b/tools/perf/scripts/python/arm-cs-trace-disasm.py
> index d59ff53f1d94..46bf6b02eea1 100755
> --- a/tools/perf/scripts/python/arm-cs-trace-disasm.py
> +++ b/tools/perf/scripts/python/arm-cs-trace-disasm.py
> @@ -108,6 +108,8 @@ def print_disam(dso_fname, dso_start, start_addr, stop_addr):
>  			m = disasm_re.search(line)
>  			if m is None:
>  				continue
> +		else:
> +			line += " (base address is 0x%016x)" % dso_start
>  		print("\t" + line)
>  
>  def print_sample(sample):


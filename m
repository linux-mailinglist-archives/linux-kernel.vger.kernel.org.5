Return-Path: <linux-kernel+bounces-6802-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4916819DC3
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 12:15:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3CB40B253AE
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 11:15:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6647D21119;
	Wed, 20 Dec 2023 11:15:46 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90F63210F3;
	Wed, 20 Dec 2023 11:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B2D781FB;
	Wed, 20 Dec 2023 03:16:28 -0800 (PST)
Received: from [192.168.1.3] (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 475643F5A1;
	Wed, 20 Dec 2023 03:15:42 -0800 (PST)
Message-ID: <f9be9348-52e7-7a35-1a4b-f37d4f3cd1ef@arm.com>
Date: Wed, 20 Dec 2023 11:15:37 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 3/3] perf scripts python: arm-cs-trace-disasm.py: do not
 ignore disam first sample
Content-Language: en-US
To: Ruidong Tian <tianruidong@linux.alibaba.com>, linux-kernel@vger.kernel.org
Cc: coresight@lists.linaro.org, suzuki.poulose@arm.com,
 mike.leach@linaro.org, alexander.shishkin@linux.intel.com,
 linux-arm-kernel@lists.infradead.org, adrian.hunter@intel.com,
 linux-perf-users@vger.kernel.org, leo.yan@linaro.org, al.grant@arm.com,
 mathieu.poirier@linaro.org, tor@ti.com, acme@redhat.com
References: <20231214123304.34087-1-tianruidong@linux.alibaba.com>
 <20231214123304.34087-4-tianruidong@linux.alibaba.com>
From: James Clark <james.clark@arm.com>
In-Reply-To: <20231214123304.34087-4-tianruidong@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 14/12/2023 12:33, Ruidong Tian wrote:
> arm-cs-trace-disasm ignore disam the first branch sample, For example as
> follow, the instructions beteween 0x0000ffffae878750 and
> 0x0000ffffae878754 is lose:
> 
>   ARM CoreSight Trace Data Assembler Dump
>   Event type: branches:uH
>   Sample = { cpu: 0000 addr: 0x0000ffffae878750 phys_addr: 0x0000000000000000 ip: 0x0000000000000000 pid: 4003489 tid: 4003489 period: 1 time: 26765151766034 }
>   Event type: branches:uH
>   Sample = { cpu: 0000 addr: 0x0000000000000000 phys_addr: 0x0000000000000000 ip: 0x0000ffffae878754 pid: 4003489 tid: 4003489 period: 1 time: 26765151766034 }
> 
> Initialize cpu_data earlier to fix it:
> 
>   ARM CoreSight Trace Data Assembler Dump
>   Event type: branches:uH
>   Sample = { cpu: 0000 addr: 0x0000000000000000 phys_addr: 0x0000000000000000 ip: 0x0000ffffae878754 pid: 4003489 tid: 4003489 period: 1 time: 26765151766034 }
>         0000000000028740 <ioctl>: (base address is 0x0000ffffae850000)
>            28750: b13ffc1f      cmn     x0, #4095
>            28754: 54000042      b.hs    0x2875c <ioctl+0x1c>
>             test 4003489/4003489 [0000]     26765.151766034  __GI___ioctl+0x14                        /usr/lib64/libc-2.32.so
>   Event type: branches:uH
>   Sample = { cpu: 0000 addr: 0x0000ffffa67535ac phys_addr: 0x0000000000000000 ip: 0x0000000000000000 pid: 4003489 tid: 4003489 period: 1 time: 26765151766034 }
> 
> Signed-off-by: Ruidong Tian <tianruidong@linux.alibaba.com>

I noticed that this is for the missing second branch sample. Technically
the first one is also still missing, but it doesn't have the origin set,
only the destination, so I'm not sure if we need to do anything with it,
but the first one always looks like this:

  0 [unknown] ([unknown]) =>     ffff8a3b9100 _start+0x0

Followed by this one which you now generate the disassembly for:

  ffff8a3b9104 _start+0x4 (ld-2.31.so) => ffff8a3b9b80 _dl_start+0x0

Either way:

Reviewed-by: James Clark <james.clark@arm.com>

> ---
>  .../scripts/python/arm-cs-trace-disasm.py     | 21 ++++++++++---------
>  1 file changed, 11 insertions(+), 10 deletions(-)
> 
> diff --git a/tools/perf/scripts/python/arm-cs-trace-disasm.py b/tools/perf/scripts/python/arm-cs-trace-disasm.py
> index c9e14af5b58c..b1eb4293cbef 100755
> --- a/tools/perf/scripts/python/arm-cs-trace-disasm.py
> +++ b/tools/perf/scripts/python/arm-cs-trace-disasm.py
> @@ -190,6 +190,17 @@ def process_event(param_dict):
>  	dso_end = get_optional(param_dict, "dso_map_end")
>  	symbol = get_optional(param_dict, "symbol")
>  
> +	cpu = sample["cpu"]
> +	ip = sample["ip"]
> +	addr = sample["addr"]
> +
> +	# Initialize CPU data if it's empty, and directly return back
> +	# if this is the first tracing event for this CPU.
> +	if (cpu_data.get(str(cpu) + 'addr') == None):
> +		cpu_data[str(cpu) + 'addr'] = addr
> +		return
> +
> +
>  	if (options.verbose == True):
>  		print("Event type: %s" % name)
>  		print_sample(sample)
> @@ -211,16 +222,6 @@ def process_event(param_dict):
>  	if (name[0:8] != "branches"):
>  		return
>  
> -	cpu = sample["cpu"]
> -	ip = sample["ip"]
> -	addr = sample["addr"]
> -
> -	# Initialize CPU data if it's empty, and directly return back
> -	# if this is the first tracing event for this CPU.
> -	if (cpu_data.get(str(cpu) + 'addr') == None):
> -		cpu_data[str(cpu) + 'addr'] = addr
> -		return
> -
>  	# The format for packet is:
>  	#
>  	#		  +------------+------------+------------+


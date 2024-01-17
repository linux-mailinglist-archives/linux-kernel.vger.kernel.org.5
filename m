Return-Path: <linux-kernel+bounces-28817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC275830359
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 11:16:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F9F5B218A1
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 10:16:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1945414A81;
	Wed, 17 Jan 2024 10:16:09 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A64F14266;
	Wed, 17 Jan 2024 10:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705486568; cv=none; b=a7oGdEVzethumJe6sBDQJueB3sNHE3kFheaGjNECDT+eEe0U1hLI8r0Rwf57Wl4WCH17j6dEKG/N7OOBc70EqDws8U3JI9M+n2UA7ja257ulbroN/EGTtyHvSQzazONF7K+oB56LkZnITq+E4hI4DBH12xxIG3WhEhWSXY/wY2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705486568; c=relaxed/simple;
	bh=iPYbxrB9RyA+DzLuG6LUAcCcNNcI6mgcuERiNUVMUEk=;
	h=Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 Content-Language:To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding; b=LFSAiPG+oMAb2LzQpHwMtdjyjbDo/Gq0BDFG/P+QQwP94Q+Cb/Lq5VBFQZ6EskUFak6KITRYVuHxEm4dS6XcBNGurWNS+ymG4uoJ68wBIcQiIOcI4/0cZ2+gjAZLxlQxVR6WBHXW2UFJSUGQU7CMtjGlGOt2fptjfl7RlYgMJMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 17F2D11FB;
	Wed, 17 Jan 2024 02:16:52 -0800 (PST)
Received: from [192.168.1.100] (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3484E3F5A1;
	Wed, 17 Jan 2024 02:16:04 -0800 (PST)
Message-ID: <7861aef3-8c0f-8ab3-6bd5-243eba3200b8@arm.com>
Date: Wed, 17 Jan 2024 10:16:03 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v3 1/1] perf scripts python: arm-cs-trace-disasm.py: add
 option to print virtual address
Content-Language: en-US
To: Ruidong Tian <tianruidong@linux.alibaba.com>, linux-kernel@vger.kernel.org
Cc: coresight@lists.linaro.org, suzuki.poulose@arm.com,
 mike.leach@linaro.org, alexander.shishkin@linux.intel.com,
 linux-arm-kernel@lists.infradead.org, adrian.hunter@intel.com,
 linux-perf-users@vger.kernel.org, leo.yan@linaro.org, al.grant@arm.com,
 mathieu.poirier@linaro.org, tor@ti.com, acme@redhat.com
References: <20231214123304.34087-1-tianruidong@linux.alibaba.com>
 <20240116020854.56030-1-tianruidong@linux.alibaba.com>
 <20240116020854.56030-2-tianruidong@linux.alibaba.com>
From: James Clark <james.clark@arm.com>
In-Reply-To: <20240116020854.56030-2-tianruidong@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 16/01/2024 02:08, Ruidong Tian wrote:
> arm-cs-trace-disasm just print offset for library dso now:
> 
>     0000000000002200 <memcpy>:
>         2200: d503201f      nop
>         2204: 8b020024      add     x4, x1, x2
>         2208: 8b020005      add     x5, x0, x2
> 
> Add a option `-a` to print virtual offset other than offset:
> 
>     # perf script -s scripts/python/arm-cs-trace-disasm.py -- -d llvm-objdump -a
>     ...
>     ffffb4c23200 <memcpy>:
>         ffffb4c23200: d503201f      nop
>         ffffb4c23204: 8b020024      add     x4, x1, x2
>         ffffb4c23208: 8b020005      add     x5, x0, x2
>     ...
> 
> Signed-off-by: Ruidong Tian <tianruidong@linux.alibaba.com>
> Reviewed-by: Leo Yan <leo.yan@linaro.org>

I think your s-o-b should always come last, so these should be the other
way around.

Also patch 3 is missing on v3 for some reason so you might want to
resend. No need to send it as a reply to the thread, you can just send
it as a complete new one.

Thanks
James

> ---
>  tools/perf/scripts/python/arm-cs-trace-disasm.py | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/scripts/python/arm-cs-trace-disasm.py b/tools/perf/scripts/python/arm-cs-trace-disasm.py
> index d973c2baed1c..78419498237e 100755
> --- a/tools/perf/scripts/python/arm-cs-trace-disasm.py
> +++ b/tools/perf/scripts/python/arm-cs-trace-disasm.py
> @@ -36,7 +36,10 @@ option_list = [
>  		    help="Set path to objdump executable file"),
>  	make_option("-v", "--verbose", dest="verbose",
>  		    action="store_true", default=False,
> -		    help="Enable debugging log")
> +		    help="Enable debugging log"),
> +	make_option("-a", "--vaddr", dest="vaddr",
> +			action="store_true", default=False,
> +			help="Enable virtual address")
>  ]
>  
>  parser = OptionParser(option_list=option_list)
> @@ -108,6 +111,14 @@ def print_disam(dso_fname, dso_start, start_addr, stop_addr):
>  			m = disasm_re.search(line)
>  			if m is None:
>  				continue
> +
> +		# Replace offset with virtual address
> +		if (options.vaddr == True):
> +			offset = re.search(r"^\s*([0-9a-fA-F]+)", line).group()
> +			if offset:
> +				virt_addr = dso_start + int(offset, 16)
> +				line = line.replace(offset.lstrip(), "%x" % virt_addr)
> +
>  		print("\t" + line)
>  
>  def print_sample(sample):


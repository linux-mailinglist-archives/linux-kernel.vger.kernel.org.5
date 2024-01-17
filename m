Return-Path: <linux-kernel+bounces-28814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04893830352
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 11:12:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A79A4288D0F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 10:12:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A31214AA2;
	Wed, 17 Jan 2024 10:12:19 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04D141428E;
	Wed, 17 Jan 2024 10:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705486338; cv=none; b=KEwmgt8I0vqbmfRShcEtOaAxycRirXtM5WMvm/wgMP+iQZbEbkmwuro9F24gAtxw157zn5B+OpCXQ8HcPgYPEL71MSoowsvtCUjTbSccZtosVo/w9uAvlaFKDsPfKftZDwdjb6NgsQh3k84vCcBPFXtZWXb0OOk0MdxT2aZjcHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705486338; c=relaxed/simple;
	bh=jA0lVxtWVSpGPxX9bL0TYkcvRfvP1PIFieyAA35c3Xw=;
	h=Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 Content-Language:To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding; b=h5AjaNs7cROzc14n8P+QyO1tPnrsm1i7HwrzmSBAPSyp9x9CfBA+KmSxH4Y+55Ndx2PVrfICLTh7cOhNsu1HQ2peDlTsyFfeYtLYyAitFuRCV3h/IsIlNoRXYwzpKB5vrrPI5MneoHmkFwR+50/DNJHk0mxK0jAI9ru7XXZL6lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7E51411FB;
	Wed, 17 Jan 2024 02:13:02 -0800 (PST)
Received: from [192.168.1.100] (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 941C23F5A1;
	Wed, 17 Jan 2024 02:12:14 -0800 (PST)
Message-ID: <e87a86a2-ce5b-07cb-a567-439696fe4775@arm.com>
Date: Wed, 17 Jan 2024 10:12:13 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v3 2/3] perf scripts python: arm-cs-trace-disasm.py: set
 start vm addr of exectable file to 0
Content-Language: en-US
To: Ruidong Tian <tianruidong@linux.alibaba.com>, linux-kernel@vger.kernel.org
Cc: coresight@lists.linaro.org, suzuki.poulose@arm.com,
 mike.leach@linaro.org, alexander.shishkin@linux.intel.com,
 linux-arm-kernel@lists.infradead.org, adrian.hunter@intel.com,
 linux-perf-users@vger.kernel.org, leo.yan@linaro.org, al.grant@arm.com,
 mathieu.poirier@linaro.org, tor@ti.com, acme@redhat.com
References: <20231214123304.34087-1-tianruidong@linux.alibaba.com>
 <20240116020854.56030-1-tianruidong@linux.alibaba.com>
 <20240116020854.56030-3-tianruidong@linux.alibaba.com>
From: James Clark <james.clark@arm.com>
In-Reply-To: <20240116020854.56030-3-tianruidong@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 16/01/2024 02:08, Ruidong Tian wrote:
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

Hi Ruidong,

Please pick up my review tag from V1 for this patch if you resend. You
can apply the review tags automatically with the b4 tool.

Thanks
James


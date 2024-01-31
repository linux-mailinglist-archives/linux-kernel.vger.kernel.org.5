Return-Path: <linux-kernel+bounces-46709-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A49FA84431C
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 16:33:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9F2CAB2EACD
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 15:27:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07B7012A14C;
	Wed, 31 Jan 2024 15:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IMUECFk4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40F531292FD;
	Wed, 31 Jan 2024 15:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706714832; cv=none; b=WwdVRgM6Dc8uOcAjkmuq+fJDCyf97qOCw1yuO82EKcmz1npL/fuOmFQGV25ISHJ/d4pYNv7JcEUwfuVY2mlgGUYGnlJQHI4L/eamLPRodjT60oxqlSH6CxarH7czH7ufWbfJi7hgWl+apZ73e2qLIMIVvFTSGw3d4RN0CEmc+Lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706714832; c=relaxed/simple;
	bh=19Hap+jLLwl5/KUouZC5xJUm2952vDYNgv2x4gYBsJ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dxngHwLC7dWLb9OtW7Q2Syxq7C0XwtYQ4jpRGWd5tvd/wJfpe9EhLNEV8j+GmzU/e88Ltw8rArqBWVJ/4bR4I3b/Rm2oY43G8AZgYlpwWWHzCJ0D5ZX21V4xI3neh4WaNaPyGSJuuBfvLLTNPre8YxbzDg6xDnW5vl9VaHRZzkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IMUECFk4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 953FBC43141;
	Wed, 31 Jan 2024 15:27:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706714831;
	bh=19Hap+jLLwl5/KUouZC5xJUm2952vDYNgv2x4gYBsJ8=;
	h=Date:From:To:List-Id:Cc:Subject:References:In-Reply-To:From;
	b=IMUECFk4IsuVJekwgnSVNtYRLCBMpnC1fVqiDc/WVEP2cs/45v0TH1d0Njhd3Wrvs
	 DHqmKcS89rbwbgoSwgxUJZbyx6Bp0Hro0yXENdlO0/SOEiofJbJjX26Odp6VBk7CgE
	 HuRrk4A60wHkDQQWqENmPVL3nTvjZEbq5SY6vn/EMk02MYtNwF43DeToI3BNlhZro2
	 3R91SRBIPwho2wLYHCSUdLpinOl1lD2iM+I+SsIP9nzPUvro64J4Vewd5dDtQmMspK
	 QJIZOQEaqUVqgufuZMEhuewAy0T8ZQBrta8JZ8RRekOzYiymyk76sVifG6A7Lw99fv
	 BE4DrcuAXZIOg==
Date: Wed, 31 Jan 2024 09:27:09 -0600
From: Rob Herring <robh@kernel.org>
To: Oreoluwa Babatunde <quic_obabatun@quicinc.com>
Cc: catalin.marinas@arm.com, will@kernel.org, frowand.list@gmail.com,
	vgupta@kernel.org, arnd@arndb.de, olof@lixom.net, soc@kernel.org,
	guoren@kernel.org, monstr@monstr.eu, palmer@dabbelt.com,
	aou@eecs.berkeley.edu, dinguyen@kernel.org, chenhuacai@kernel.org,
	tsbogend@alpha.franken.de, jonas@southpole.se,
	stefan.kristiansson@saunalahti.fi, shorne@gmail.com,
	mpe@ellerman.id.au, ysato@users.sourceforge.jp, dalias@libc.org,
	glaubitz@physik.fu-berlin.de, richard@nod.at,
	anton.ivanov@cambridgegreys.com, johannes@sipsolutions.net,
	chris@zankel.net, jcmvbkbc@gmail.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	kernel@quicinc.com
Subject: Re: [PATCH 07/46] Loongarch: reserved_mem: Implement the new
 processing order for reserved memory
Message-ID: <20240131152709.GA1272666-robh@kernel.org>
References: <20240126235425.12233-1-quic_obabatun@quicinc.com>
 <20240126235425.12233-8-quic_obabatun@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240126235425.12233-8-quic_obabatun@quicinc.com>

On Fri, Jan 26, 2024 at 03:53:46PM -0800, Oreoluwa Babatunde wrote:
> Call early_fdt_scan_reserved_mem() in place of
> early_init_fdt_scan_reserved_mem() to carry out the first stage of the
> reserved memory processing only.
> 
> The early_fdt_scan_reserved_mem() function is used to scan through the
> DT and mark all the reserved memory regions as reserved or nomap as
> needed, as well as allocate the memory required by the
> dynamically-placed
> reserved memory regions.
> 
> The second stage of the reserved memory processing is done by
> fdt_init_reserved_mem(). This function is used to store the information
> of the statically-placed reserved memory nodes in the reserved_mem
> array as well as call the region specific initialization function on all
> the stored reserved memory regions.
> 
> The call to fdt_init_reserved_mem() is placed right after
> early_fdt_scan_reserved_mem() since memblock allocated memory should
> already be writable at this point.
> 
> Signed-off-by: Oreoluwa Babatunde <quic_obabatun@quicinc.com>
> ---
>  arch/loongarch/kernel/setup.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/loongarch/kernel/setup.c b/arch/loongarch/kernel/setup.c
> index edf2bba80130..72b164d3ace0 100644
> --- a/arch/loongarch/kernel/setup.c
> +++ b/arch/loongarch/kernel/setup.c
> @@ -30,6 +30,7 @@
>  #include <linux/dma-map-ops.h>
>  #include <linux/libfdt.h>
>  #include <linux/of_fdt.h>
> +#include <linux/of_reserved_mem.h>
>  #include <linux/of_address.h>
>  #include <linux/suspend.h>
>  #include <linux/swiotlb.h>
> @@ -390,8 +391,9 @@ static void __init arch_mem_init(char **cmdline_p)
>  
>  	check_kernel_sections_mem();
>  
> -	early_init_fdt_scan_reserved_mem();
> +	early_fdt_scan_reserved_mem();

Looking at the loongarch code, there's an existing problem with the 
order of init. This is done after unflattening and copying the DT. That 
means the kernel could freely allocate memory for the DT in a reserved 
region.

Rob


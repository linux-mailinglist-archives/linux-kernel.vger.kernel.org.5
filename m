Return-Path: <linux-kernel+bounces-46728-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A9F3844341
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 16:42:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A8879B28308
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 15:41:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4944C12A143;
	Wed, 31 Jan 2024 15:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FRtAQL4P"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CF921292DB;
	Wed, 31 Jan 2024 15:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706715693; cv=none; b=BhdvEvTEHEdeL8qX2R9WSE6jBXGw39Bj/ARznhkK3t7S4GofSC1K1zy2JlMadE6APwxHkCLztwGBQ1pxmlg4eDcLHag8K5M55PKSMV4gCSkmNq1Gfq+TIFE9Usg5Ax7mXvKmp0oy34PI0meh0+9rW3aKa240F53B6Q2kI2XalTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706715693; c=relaxed/simple;
	bh=3qc1rD4OFMv152sahNdXzftZFYLPE8J6IdJzNl7A+Ds=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=diKQ/VDm9521SCHqRkRqA6GHQJyu/2hcRpcYrkEW9gYdItby9eHFPedSvsqzn57PL5ESH32F3tIBfHCswj+6pKN7UI+sL90T0/XzXGd0OhI3BiOFztC973Xsorr3j22qtbqnH5IpYtdmDFhxyERBtxe90mlLKQcYkqDrd4a+zbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FRtAQL4P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3173C433F1;
	Wed, 31 Jan 2024 15:41:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706715693;
	bh=3qc1rD4OFMv152sahNdXzftZFYLPE8J6IdJzNl7A+Ds=;
	h=Date:From:To:List-Id:Cc:Subject:References:In-Reply-To:From;
	b=FRtAQL4P2fhakKD2lJx59bZVG04GXx7y4JYKjGa+TfPz19YHtsNCYxdYxO2R/4cia
	 htqqKdIcuJ4VgdOENNbO4VDzCy3QNTuAAgSNWR0F56Qf4gIDusNFeUDRn1wQCCSsc/
	 tKrMQf3JkJYbv1lPvfRD3ECUcjr+aFr3RMdznjYszREWAJ3N31k/FJ+q3Iclhu9Qw8
	 aFltwZXEhhgSEBRWhGF1kC4N/rsqr28rXjRUsrCQ7Ohw+gONEC5Xk/GuskxqXocWUs
	 Gv83hNk5WwjGn0HXBvlbWsY+IJm5mWX3HntsBE07tD75eZTAmvtjDuWqvZe8Wj9MG1
	 rYiJHBtzdJtYw==
Date: Wed, 31 Jan 2024 09:41:30 -0600
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
Subject: Re: [PATCH 14/46] sh: reserved_mem: Implement the new processing
 order for reserved memory
Message-ID: <20240131154130.GA1336725-robh@kernel.org>
References: <20240126235425.12233-1-quic_obabatun@quicinc.com>
 <20240126235425.12233-15-quic_obabatun@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240126235425.12233-15-quic_obabatun@quicinc.com>

On Fri, Jan 26, 2024 at 03:53:53PM -0800, Oreoluwa Babatunde wrote:
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
> early_fdt_scan_reserved_mem() because memblock allocated memory should
> already be writable at this point.
> 
> Signed-off-by: Oreoluwa Babatunde <quic_obabatun@quicinc.com>
> ---
>  arch/sh/boards/of-generic.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/sh/boards/of-generic.c b/arch/sh/boards/of-generic.c
> index f7f3e618e85b..7bec409f077c 100644
> --- a/arch/sh/boards/of-generic.c
> +++ b/arch/sh/boards/of-generic.c
> @@ -8,6 +8,7 @@
>  #include <linux/of.h>
>  #include <linux/of_clk.h>
>  #include <linux/of_fdt.h>
> +#include <linux/of_reserved_mem.h>
>  #include <linux/clocksource.h>
>  #include <linux/irqchip.h>
>  #include <asm/machvec.h>
> @@ -110,7 +111,8 @@ static int noopi(void)
>  static void __init sh_of_mem_reserve(void)
>  {
>  	early_init_fdt_reserve_self();
> -	early_init_fdt_scan_reserved_mem();
> +	early_fdt_scan_reserved_mem();
> +	fdt_init_reserved_mem();

Looking at the sh code, there's an existing problem with the order of
init. This is called from paging_init() and is done after unflattening
and copying the DT. That means the kernel could freely allocate memory
for the DT in a reserved region.

Rob


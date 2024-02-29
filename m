Return-Path: <linux-kernel+bounces-86937-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5983586CD40
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 16:39:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F029B1F230E4
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 15:39:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFE2B14A0A7;
	Thu, 29 Feb 2024 15:39:07 +0000 (UTC)
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 566C21386A8
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 15:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709221147; cv=none; b=t26bwJIqh2o97inrM397avi8uzVeT4gNkAlXjlvcDTRACho9jKSL7tMUbHTyNZnlyZz2OnldaP52FhhIiETM6OXB1ebR7E/IlUI2ZLIrOnnLBVI8/v6Q2agZdB+b4d4UaAakwzQf1rnv/TNwkitdhWPREFkmBaQHTUhJ8EPQHBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709221147; c=relaxed/simple;
	bh=iOgbEivwbbXs3WXqpWMHM08jWcL18JmzqpU2dzE4bjc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lj5LaZPcwE1O4jLEq3QJywvfIlgCbV5iLXvx5Y2NDbiX8SE7mwK3gvhIhp+sdnyzpwJxc6ppIFtIuNIFwV9GC7DU4yTIsfuHo51rsqPw7b/Q4uf7nzC9tUKlmQBMuOzjt5UouIMRlWXWLt3QR+YTAx01Yj+QKnldcRnzUwma+78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4F7B720008;
	Thu, 29 Feb 2024 15:38:59 +0000 (UTC)
Message-ID: <97fec9bc-3b19-4b4e-8627-81c6f9298c4c@ghiti.fr>
Date: Thu, 29 Feb 2024 16:38:59 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -fixes] riscv: Sparse-Memory/vmemmap out-of-bounds fix
Content-Language: en-US
To: Dimitris Vlachos <dvlachos@ics.forth.gr>,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 palmer@dabbelt.com, alexghiti@rivosinc.com, paul.walmsley@sifive.com
Cc: clameter@sgi.com, akpm@linux-foundation.org, rppt@kernel.org,
 arnd@arndb.de, mick@ics.forth.gr, csd4492@csd.uoc.gr, maraz@ics.forth.gr
References: <20240229143833.107724-1-dvlachos@ics.forth.gr>
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <20240229143833.107724-1-dvlachos@ics.forth.gr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: alex@ghiti.fr

Hi Dimitri,

On 29/02/2024 15:38, Dimitris Vlachos wrote:
> Offset vmemmap so that the first page of vmemmap will be mapped
> to the first page of physical memory in order to ensure that
> vmemmap’s bounds will be respected during
> pfn_to_page()/page_to_pfn() operations.
> The conversion macros will produce correct SV39/48/57 addresses
> for every possible/valid DRAM_BASE inside the physical memory limits.
>
> This is the link to the relevant conversation and bug report.
> Link :https://lore.kernel.org/linux-riscv/20240202135030.42265-1-csd4492@csd.uoc.gr
>
> Co-developed-by: Alexandre Ghiti <alexghiti@rivosinc.com>


You can switch that to a Suggested-by, I did not write the code nor test 
anything :)


> Signed-off-by: Dimitris Vlachos <dvlachos@ics.forth.gr>
> Reported-by: Dimitris Vlachos <dvlachos@ics.forth.gr>


I think checkpatch will complain that a Link or Closes tag should follow 
a Reported-by: I would move the Link tag in your commit message here.

And we miss a Fixes tag too, I would go for:

Fixes: d95f1a542c3d ("RISC-V: Implement sparsemem")


> ---
>   arch/riscv/include/asm/pgtable.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
> index 0c94260b5..875c9a079 100644
> --- a/arch/riscv/include/asm/pgtable.h
> +++ b/arch/riscv/include/asm/pgtable.h
> @@ -84,7 +84,7 @@
>    * Define vmemmap for pfn_to_page & page_to_pfn calls. Needed if kernel
>    * is configured with CONFIG_SPARSEMEM_VMEMMAP enabled.
>    */
> -#define vmemmap		((struct page *)VMEMMAP_START)
> +#define vmemmap		((struct page *)VMEMMAP_START - (phys_ram_base >> PAGE_SHIFT))
>   
>   #define PCI_IO_SIZE      SZ_16M
>   #define PCI_IO_END       VMEMMAP_START

You can add:

Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>

Thanks,

Alex



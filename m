Return-Path: <linux-kernel+bounces-131075-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A8BCF8982C3
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 10:04:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 475251F293C0
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 08:04:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D4656027D;
	Thu,  4 Apr 2024 08:04:19 +0000 (UTC)
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CA865D73A
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 08:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712217858; cv=none; b=p2BIBfryHfoOIr1mqAxRH66edi4wBUxPKI55n+ytpFRT0RT00ZOd165i5dgBnb/WW7MPvEE4ZTn9A4GTaW6sIRYQ2HFf5lvzBGPWux8ROnuyWwlVkrG+44z3hzF9R4+LF2TfgCBX+VL5xaX6M3xy8J7mnX8e4lPxt8Zc9pkZJ/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712217858; c=relaxed/simple;
	bh=Ek5fSmDXp78lw8Lyzp8NrGztbcnXisYx47LKbLmVKvI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AIgqBCyo14PkS1eWG81GB8imvjkUV4Zt74YkjCXywaQteDfBgA4yt6eYi5zrQ6AeixkJF9+4B08VTg2IO5ixLbgNpme1Lswbhr7gAcZ8swD2oyeGBLGUuIGJ8ywMElXDEmkUFUlKNy0vJoQKORT3nST9npxICm8MKwuonun9qOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id 54BBAE0011;
	Thu,  4 Apr 2024 08:04:06 +0000 (UTC)
Message-ID: <ee75e516-87fd-462f-ba6a-8c33506057e1@ghiti.fr>
Date: Thu, 4 Apr 2024 10:04:05 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 05/13] riscv: Only send remote fences when some other
 CPU is online
Content-Language: en-US
To: Samuel Holland <samuel.holland@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, linux-riscv@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 Alexandre Ghiti <alexghiti@rivosinc.com>, Jisheng Zhang
 <jszhang@kernel.org>, Yunhui Cui <cuiyunhui@bytedance.com>
References: <20240327045035.368512-1-samuel.holland@sifive.com>
 <20240327045035.368512-6-samuel.holland@sifive.com>
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <20240327045035.368512-6-samuel.holland@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-Sasl: alex@ghiti.fr


On 27/03/2024 05:49, Samuel Holland wrote:
> If no other CPU is online, a local cache or TLB flush is sufficient.
> These checks can be constant-folded when SMP is disabled.
>
> Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
> ---
>
> (no changes since v4)
>
> Changes in v4:
>   - New patch for v4
>
>   arch/riscv/mm/cacheflush.c | 4 +++-
>   arch/riscv/mm/tlbflush.c   | 4 +++-
>   2 files changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/arch/riscv/mm/cacheflush.c b/arch/riscv/mm/cacheflush.c
> index d76fc73e594b..f5be1fec8191 100644
> --- a/arch/riscv/mm/cacheflush.c
> +++ b/arch/riscv/mm/cacheflush.c
> @@ -21,7 +21,9 @@ void flush_icache_all(void)
>   {
>   	local_flush_icache_all();
>   
> -	if (riscv_use_sbi_for_rfence())
> +	if (num_online_cpus() < 2)
> +		return;
> +	else if (riscv_use_sbi_for_rfence())
>   		sbi_remote_fence_i(NULL);
>   	else
>   		on_each_cpu(ipi_remote_fence_i, NULL, 1);
> diff --git a/arch/riscv/mm/tlbflush.c b/arch/riscv/mm/tlbflush.c
> index da821315d43e..0901aa47b58f 100644
> --- a/arch/riscv/mm/tlbflush.c
> +++ b/arch/riscv/mm/tlbflush.c
> @@ -79,7 +79,9 @@ static void __ipi_flush_tlb_all(void *info)
>   
>   void flush_tlb_all(void)
>   {
> -	if (riscv_use_sbi_for_rfence())
> +	if (num_online_cpus() < 2)
> +		local_flush_tlb_all();
> +	else if (riscv_use_sbi_for_rfence())
>   		sbi_remote_sfence_vma_asid(NULL, 0, FLUSH_TLB_MAX_SIZE, FLUSH_TLB_NO_ASID);
>   	else
>   		on_each_cpu(__ipi_flush_tlb_all, NULL, 1);


Could this be done directly in __sbi_rfence() instead?

Otherwise:

Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>



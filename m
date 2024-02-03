Return-Path: <linux-kernel+bounces-51007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B029C8484FC
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 10:24:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2EE91C23B0E
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 09:24:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 555CD5D732;
	Sat,  3 Feb 2024 09:24:36 +0000 (UTC)
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA5415D728;
	Sat,  3 Feb 2024 09:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706952275; cv=none; b=JhlmUpFtKmM8lIBnEu0WjiO8Uj+jKY52xD0gCs/SZv0ZBhi9n9tOl32m74wvr47Dk+os2TUHDxCjaqsIa5eGs6P/ELOCzWJzvP0xKFchxVvXQhDRzSbOhWO3pKNGNQLzLUBWEDBcvvREqJzjTWud2Az+IKpIBAbU82uTGMPOou4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706952275; c=relaxed/simple;
	bh=uH4mJz4z0y+IyQgvblzylCvq8UBc92LMdZ5tmXgKbLM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BwF2zMg09Uc6LZdSZO7fxEeDFwPx2YzMAM1avnnBYmiUBsNqNYP0FHgYqcd2A/RsGuTZFUmn++a03HexJH70qJiwRXd5EjgGCDwqpJ8NeFOQ904r5fvQDzQRGcBtDTSv1c7qmmJ+rtvNAwNeDR5yhAWFzLjCyV0lT9elpFq6vUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1rWCG4-0001ZP-Tq; Sat, 03 Feb 2024 10:24:21 +0100
Message-ID: <ad920491-9d73-4512-8996-badace520699@leemhuis.info>
Date: Sat, 3 Feb 2024 10:24:20 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: huge_memory: don't force huge page alignment on 32
 bit
Content-Language: en-US, de-DE
To: Yang Shi <shy828301@gmail.com>, jirislaby@kernel.org, surenb@google.com,
 riel@surriel.com, willy@infradead.org, cl@linux.com,
 akpm@linux-foundation.org,
 Linux kernel regressions list <regressions@lists.linux.dev>
Cc: yang@os.amperecomputing.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20240118133504.2910955-1-shy828301@gmail.com>
From: Thorsten Leemhuis <regressions@leemhuis.info>
In-Reply-To: <20240118133504.2910955-1-shy828301@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1706952274;0485d69a;
X-HE-SMSGID: 1rWCG4-0001ZP-Tq

On 18.01.24 14:35, Yang Shi wrote:
> From: Yang Shi <yang@os.amperecomputing.com>
> 
> The commit efa7df3e3bb5 ("mm: align larger anonymous mappings on THP
> boundaries") caused two issues [1] [2] reported on 32 bit system or compat
> userspace.
> 
> It doesn't make too much sense to force huge page alignment on 32 bit
> system due to the constrained virtual address space.
> 
> [1] https://lore.kernel.org/linux-mm/CAHbLzkqa1SCBA10yjWTtA2mKCsoK5+M1BthSDL8ROvUq2XxZMw@mail.gmail.com/T/#mf211643a0427f8d6495b5b53f8132f453d60ab95
> [2] https://lore.kernel.org/linux-mm/CAHbLzkqa1SCBA10yjWTtA2mKCsoK5+M1BthSDL8ROvUq2XxZMw@mail.gmail.com/T/#me93dff2ccbd9902c3e395e1c022fb454e48ecb1d

[FWIW, this is now 4ef9ad19e17676 ("mm: huge_memory: don't force huge
page alignment on 32 bit") in mainline]

Quick question: it it okay to ask Greg to pick this up for linux-6.7.y
series?

I'm wondering because Jiri's report ([1] in above quote) sounded like
this is something that will affect and annoy quite a few people with the
linux-6.7.y.

Ciao, Thorsten

> Fixes: efa7df3e3bb5 ("mm: align larger anonymous mappings on THP boundaries")
> Reported-by: Jiri Slaby <jirislaby@kernel.org>
> Reported-by: Suren Baghdasaryan <surenb@google.com>
> Tested-by: Jiri Slaby <jirislaby@kernel.org>
> Tested-by: Suren Baghdasaryan <surenb@google.com>
> Cc: Rik van Riel <riel@surriel.com>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Christopher Lameter <cl@linux.com>
> Signed-off-by: Yang Shi <yang@os.amperecomputing.com>
> ---
>  mm/huge_memory.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 94ef5c02b459..e9fbaccbe0c0 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -37,6 +37,7 @@
>  #include <linux/page_owner.h>
>  #include <linux/sched/sysctl.h>
>  #include <linux/memory-tiers.h>
> +#include <linux/compat.h>
>  
>  #include <asm/tlb.h>
>  #include <asm/pgalloc.h>
> @@ -811,6 +812,14 @@ static unsigned long __thp_get_unmapped_area(struct file *filp,
>  	loff_t off_align = round_up(off, size);
>  	unsigned long len_pad, ret;
>  
> +	/*
> +	 * It doesn't make too much sense to froce huge page alignment on
> +	 * 32 bit system or compat userspace due to the contrained virtual
> +	 * address space and address entropy.
> +	 */
> +	if (IS_ENABLED(CONFIG_32BIT) || in_compat_syscall())
> +		return 0;
> +
>  	if (off_end <= off_align || (off_end - off_align) < size)
>  		return 0;
>  


Return-Path: <linux-kernel+bounces-96814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A66AB8761C3
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 11:18:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 000EB2826C0
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 10:18:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4FFF53E28;
	Fri,  8 Mar 2024 10:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BxPOpg+b"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC6C75380F
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 10:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709893121; cv=none; b=u6i0/ZncFAu/Pr7svlUam6jHj60tKFWfFGibqfe/2rK07NokyrLSaBoy/o4xyX+G4UgK2Q21jP8lmQzTHWsGj+sfCdIXmz1oj5TL5PXSqGeuTH+LeiysrdqUUAetpruDqYqPbOfUG73Lx4bh/iDNoGIeB8zyBuSNqjnRW9Kgjic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709893121; c=relaxed/simple;
	bh=3uPEOLY0R8u0f839xVMRXXBi8YVsivNFPKf3O1J7qNs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=e4RomUpYCTBuCHanYNP/35ZdoSOjC2bJ8iRG4XH4XvItS28ryS09vr4RGJTAeB8ZaVoC4LpHB10w9RrDynCqKVFtbMWG+9oOWGDz+UPTuOH136x+HPyGGmprpu1htLL7S8rf72S5HfKozplYzaIo1pVWiDhN0h8ptN+AJZ4kb5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BxPOpg+b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9AFEC433F1;
	Fri,  8 Mar 2024 10:18:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709893120;
	bh=3uPEOLY0R8u0f839xVMRXXBi8YVsivNFPKf3O1J7qNs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=BxPOpg+bhV+KBS0mLQI78eSs3cndRSQ9NhacMpxaXzdjUxuWwewylGCD6cwzQTXtx
	 /61cECHK09553s0H9+wZ3aenaI/58yBw0xur53BgOWl5sBfrppOXtcGpddn310YOfH
	 HLLlHxK5hqoywWofwlrisjhw0/Bdhw23iJaoiGlp5L0JHaYEN3RFooLjemKAZLWnbx
	 eNSNohMWS8XKGxgSqQNYZ5YAK6d8udR8agt41n8NHvHpDZOyDGXLdVWYp3g53kzGto
	 QYSoazTKsXE1QA5oOWLDF4g/N89qO4HRz4V+pNy7fBVeqZxjwixYOgqGh/hG5JkVWk
	 ArJud5hIexy4A==
X-Mailer: emacs 29.2 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: Joel Savitz <jsavitz@redhat.com>, linux-kernel@vger.kernel.org
Cc: Joel Savitz <jsavitz@redhat.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	"Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
	Benjamin Gray <bgray@linux.ibm.com>,
	Paul Mackerras <paulus@ozlabs.org>, linuxppc-dev@lists.ozlabs.org,
	Gonzalo Siero <gsierohu@redhat.com>
Subject: Re: [PATCH] powerpc: align memory_limit to 16MB in early_parse_mem
In-Reply-To: <20240301203023.2197451-1-jsavitz@redhat.com>
References: <20240301203023.2197451-1-jsavitz@redhat.com>
Date: Fri, 08 Mar 2024 15:48:33 +0530
Message-ID: <87jzmduiva.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Joel Savitz <jsavitz@redhat.com> writes:

> On 64-bit powerpc, usage of a non-16MB-aligned value for the mem= kernel
> cmdline parameter results in a system hang at boot.
>
> For example, using 'mem=4198400K' will always reproduce this issue.
>
> This patch fixes the problem by aligning any argument to mem= to 16MB
> corresponding with the large page size on powerpc.
>
> Fixes: 2babf5c2ec2f ("[PATCH] powerpc: Unify mem= handling")
> Co-developed-by: Gonzalo Siero <gsierohu@redhat.com>
> Signed-off-by: Gonzalo Siero <gsierohu@redhat.com>
> Signed-off-by: Joel Savitz <jsavitz@redhat.com>
> ---
>  arch/powerpc/kernel/prom.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
> index 0b5878c3125b..8cd3e2445d8a 100644
> --- a/arch/powerpc/kernel/prom.c
> +++ b/arch/powerpc/kernel/prom.c
> @@ -82,8 +82,12 @@ static int __init early_parse_mem(char *p)
>  {
>  	if (!p)
>  		return 1;
> -
> +#ifdef CONFIG_PPC64
> +	/* Align to 16 MB == size of ppc64 large page */
> +	memory_limit = ALIGN(memparse(p, &p), 0x1000000);
> +#else
>  	memory_limit = PAGE_ALIGN(memparse(p, &p));
> +#endif
>  	DBG("memory limit = 0x%llx\n", memory_limit);
>  
>  	return 0;
> -- 
> 2.43.0

Can you try this change?

commit 5555bc55e1aa71f545cff31e1eccdb4a2e39df84
Author: Aneesh Kumar K.V (IBM) <aneesh.kumar@kernel.org>
Date:   Fri Mar 8 14:45:26 2024 +0530

    powerpc/mm: Align memory_limit value specified using mem= kernel parameter
    
    The value specified for the memory limit is used to set a restriction on
    memory usage. It is important to ensure that this restriction is within
    the linear map kernel address space range. The hash page table
    translation uses a 16MB page size to map the kernel linear map address
    space. htab_bolt_mapping() function aligns down the size of the range
    while mapping kernel linear address space. Since the memblock limit is
    enforced very early during boot, before we can detect the type of memory
    translation (radix vs hash), we align the memory limit value specified
    as a kernel parameter to 16MB. This alignment value will work for both
    hash and radix translations.
    
    Signed-off-by: Aneesh Kumar K.V (IBM) <aneesh.kumar@kernel.org>

diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
index 0b5878c3125b..9bd965d35352 100644
--- a/arch/powerpc/kernel/prom.c
+++ b/arch/powerpc/kernel/prom.c
@@ -824,8 +824,11 @@ void __init early_init_devtree(void *params)
 		reserve_crashkernel();
 	early_reserve_mem();
 
-	/* Ensure that total memory size is page-aligned. */
-	limit = ALIGN(memory_limit ?: memblock_phys_mem_size(), PAGE_SIZE);
+	if (memory_limit > memblock_phys_mem_size())
+		memory_limit = 0;
+
+	/* Align down to 16 MB which is large page size with hash page translation */
+	limit = ALIGN_DOWN(memory_limit ?: memblock_phys_mem_size(), SZ_16M);
 	memblock_enforce_memory_limit(limit);
 
 #if defined(CONFIG_PPC_BOOK3S_64) && defined(CONFIG_PPC_4K_PAGES)
diff --git a/arch/powerpc/kernel/prom_init.c b/arch/powerpc/kernel/prom_init.c
index e67effdba85c..d6410549e141 100644
--- a/arch/powerpc/kernel/prom_init.c
+++ b/arch/powerpc/kernel/prom_init.c
@@ -817,8 +817,8 @@ static void __init early_cmdline_parse(void)
 		opt += 4;
 		prom_memory_limit = prom_memparse(opt, (const char **)&opt);
 #ifdef CONFIG_PPC64
-		/* Align to 16 MB == size of ppc64 large page */
-		prom_memory_limit = ALIGN(prom_memory_limit, 0x1000000);
+		/* Align down to 16 MB which is large page size with hash page translation */
+		prom_memory_limit = ALIGN_DOWN(prom_memory_limit, SZ_16M);
 #endif
 	}
 


Return-Path: <linux-kernel+bounces-89224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD0E486ECEC
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 00:23:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4D151C217C4
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 23:23:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0A9F5EE87;
	Fri,  1 Mar 2024 23:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="LNakTF1E"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D5845915C
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 23:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709335423; cv=none; b=FAivZdn3R5wj1v2KJTTA49NQfX7wOZr5eMtX7HPkfQJJ8oRfGeveCCPZq8EtRMBuAbWMrpMezZiRmkus4teM7gcCHrLa0klin1Fm7Wi7epsvNkJhnxbH9PAULjORhQd8ci379mhS5nYYl1jdI4pjdasxRsY92IkMRMKJ60uJuKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709335423; c=relaxed/simple;
	bh=cLGuWTKqwwVl7Rmyebg7Ib4FHjwqx0p34yyX471brkw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=m2GVhMFTPwB8mql+ADX9nRaWskujdCxZuJ/2iDrMlpKzGI8xpJPU2hRKWdJxKa6aFEuP9ni4Y6WGeXo+mfxQcCQfZsENw0c1a0OK9zDDhSzgZbBDKTBNUr5xS14UbdB1JhPrrvT1lVueGsNY1shwrJ/0M7Te9p7NR+OntMaNkGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=LNakTF1E; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1709335418;
	bh=4kEIwFfqRv6oPsKGANVnLORvXnAWA3F6DnLBJl/uvnI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=LNakTF1Eajw7GrUdX4fOw/P+RRygl2XCgx3FWFdOrXuWkqdMoN3xtshaJDlmRXf1A
	 k4grncFThmejyovuYOleZ7mtKQnxO8CzsuOe5P3PYzuiafU0TOJ5hcWcbGNl4BHeBd
	 Mf4x5pJGt9oBPoZ7pmDJyMzuglL77dkK9GOrN9CjL4VDbqcf1DVgYIH9aGmjI0MdpK
	 j1GkC9KM/TmPox6aPHiNq+tMkkpMm/RChEpVmLr6rm0ZrFWh3ZnyxDtne4yQ/ETdsO
	 LyLllN0azhGnubCa6Wa1o5jwub/rtqmzj1gPWkxAYVjIvLTyDuL4wsvkjVm9VHSWOH
	 Wc2K6CRdjS6rg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4Tmkfx0Xjfz4wc4;
	Sat,  2 Mar 2024 10:23:37 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Joel Savitz <jsavitz@redhat.com>, linux-kernel@vger.kernel.org
Cc: Joel Savitz <jsavitz@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>, "Aneesh Kumar K.V"
 <aneesh.kumar@kernel.org>, "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
 Benjamin Gray <bgray@linux.ibm.com>, Paul Mackerras <paulus@ozlabs.org>,
 linuxppc-dev@lists.ozlabs.org, Gonzalo Siero <gsierohu@redhat.com>
Subject: Re: [PATCH] powerpc: align memory_limit to 16MB in early_parse_mem
In-Reply-To: <20240301203023.2197451-1-jsavitz@redhat.com>
References: <20240301203023.2197451-1-jsavitz@redhat.com>
Date: Sat, 02 Mar 2024 10:23:36 +1100
Message-ID: <87cysdfsef.fsf@mail.lhotse>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi Joel,

Joel Savitz <jsavitz@redhat.com> writes:
> On 64-bit powerpc, usage of a non-16MB-aligned value for the mem= kernel
> cmdline parameter results in a system hang at boot.

Can you give us any more details on that? It might be a bug we can fix.

> For example, using 'mem=4198400K' will always reproduce this issue.
>
> This patch fixes the problem by aligning any argument to mem= to 16MB
> corresponding with the large page size on powerpc.

The large page size depends on the MMU, with Radix it's 2MB or 1GB. So
depending on what's happening 16MB may not be enough.

What system are you testing on?

cheers

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


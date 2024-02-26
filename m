Return-Path: <linux-kernel+bounces-81214-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 14328867220
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 11:53:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C19D82903C0
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 10:53:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06BF54DA1A;
	Mon, 26 Feb 2024 10:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="Rd4/QsRv"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 762A01CA8A
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 10:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708944572; cv=none; b=fs0g1zQ0WabbJUXn4mz99IAN/CCXdyyH0UJFpNTKkDPAzBq8Rb+D8lGnt8X8h+iVRMLQxyt6r+TUv/EY8bz3nhEJI0Sh2M8RB2tXYh4fUZdp1XDAMcoavVxHBJTZanwVE/hIf1h0XxgwvrGREjbgWZswx9mCsVKm9fXyBDKjHDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708944572; c=relaxed/simple;
	bh=/oqHh0HNdPVucXXMMwm3P4MsoTj6ZRb447x7UxS2+L4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=u9ZHPevrCfAccqBjLeAlrPzXqR6QmXHCGGJo7l1cT3BObywGTjmwLcn65J/MKP44Y+lS9ZXTTPK3JRHr86+sQZ07ErpsRU+XMnpgsaRiWVcQFLgEs01g91mqYSGTVaRBLUCoYXhCG1f5u03vGZVkk758T/+Ixjm2CDE8lWx1rAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=Rd4/QsRv; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1708944565;
	bh=Cn2xDNXWkCC0F1GWz1ZczujdAI4K+h1xeT2o4u1IWRk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=Rd4/QsRvWBtrdProZoplXO/fbUiLEUJKHTsbbyYxAegHsyDyVD7+xOv4qwSpsqTEb
	 1LeCy3bDWRmPoLx/BSPpeeLFYwxmPrxo2+tgzNffX6BqObbGWscmyG6hS5U/n9g+8c
	 RRvUElATM4M5/UY+ue1FbbBWOLE+tsez1dHqcacQQPHgcdrHvw2TgJPBFfeSvUYBkl
	 XWVh/JS8VtyI1h8Tx4Su9uCJ5gLXoiYgCDxNUzdXMWCFJE9oiIMMVJZEU3y71/tOzM
	 atNcg08onRU/BEuP3mp3DUpFaODQ6jTacU6m4Ydwpn61Z019BmQUE7xUdyW5VNwubY
	 Fgt/1Z+fOMbDg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4Tjy6Y2gCnz4wcQ;
	Mon, 26 Feb 2024 21:49:24 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Kunwu Chan <chentao@kylinos.cn>, npiggin@gmail.com,
 christophe.leroy@csgroup.eu, aneesh.kumar@kernel.org,
 naveen.n.rao@linux.ibm.com
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, Kunwu Chan
 <chentao@kylinos.cn>
Subject: Re: [PATCH] powerpc/mm: Code cleanup for __hash_page_thp
In-Reply-To: <20240125092624.537564-1-chentao@kylinos.cn>
References: <20240125092624.537564-1-chentao@kylinos.cn>
Date: Mon, 26 Feb 2024 21:49:23 +1100
Message-ID: <87h6hva4b0.fsf@mail.lhotse>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Kunwu Chan <chentao@kylinos.cn> writes:
> This part was commented from commit 6d492ecc6489
> ("powerpc/THP: Add code to handle HPTE faults for hugepages")
> in about 11 years before.
>
> If there are no plans to enable this part code in the future,
> we can remove this dead code.

I agree the code can go. But I'd like it to be replaced with a comment
explaining what the dead code was trying to say.

cheers

> diff --git a/arch/powerpc/mm/book3s64/hash_hugepage.c b/arch/powerpc/mm/book3s64/hash_hugepage.c
> index c0fabe6c5a12..127a3a2c174b 100644
> --- a/arch/powerpc/mm/book3s64/hash_hugepage.c
> +++ b/arch/powerpc/mm/book3s64/hash_hugepage.c
> @@ -59,16 +59,6 @@ int __hash_page_thp(unsigned long ea, unsigned long access, unsigned long vsid,
>  
>  	rflags = htab_convert_pte_flags(new_pmd, flags);
>  
> -#if 0
> -	if (!cpu_has_feature(CPU_FTR_COHERENT_ICACHE)) {
> -
> -		/*
> -		 * No CPU has hugepages but lacks no execute, so we
> -		 * don't need to worry about that case
> -		 */
> -		rflags = hash_page_do_lazy_icache(rflags, __pte(old_pte), trap);
> -	}
> -#endif
>  	/*
>  	 * Find the slot index details for this ea, using base page size.
>  	 */
> -- 
> 2.39.2


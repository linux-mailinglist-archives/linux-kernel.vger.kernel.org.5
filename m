Return-Path: <linux-kernel+bounces-136883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C3ED89D95F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 14:46:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48BC31F23589
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 12:46:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5655512D753;
	Tue,  9 Apr 2024 12:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nMba09FJ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PcPEC9yZ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 418C51A5A2
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 12:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712666808; cv=none; b=VRL2O/3KVQvL7PfPouwjYN9b8E8xCKGa9swzYWMxj5KuY0f5330Llkc5o73WYwu55Hv1+GO5skKURo1hfvzJ9gwvTjGZQdGcGg5dZQJW/CBDX0qPBNrcdKJIy6k0s+MIXrCiZw/seLGghZEiUVYhldVKah1NFz7uNnfRvyUoqR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712666808; c=relaxed/simple;
	bh=hhe7bULcS36WOlmkF3amud2uzGxOfHlptakv8AMY3UY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=R0yoPjT13U//TLtTBYektvHI3oMsmZvKj6EBd04EVRpAq42zwJZdPB+UB7S/BEmMpkIZhMibo+hu8Ifgn4UszHM6yYYb0MWykzFynhNrOcaSBzVbpeP7koRjdU0TrEyTysbMV2b5jse3LB/3FJl9hK+eY6q7xw2kxqUGhKfl0EE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nMba09FJ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PcPEC9yZ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712666805;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3yKMAvfXpqgOmamqJLFQyikdCqDJcgZrBM+Mfxzj9Ao=;
	b=nMba09FJQYdaCAVkYKbj9HT6E+sKW7ycfzjgm6hYsasNpU24kFEfkucAVGaXQJuO3Q9Grm
	lXCMpqYjj9DwNGiKVXfy8BLTi8iPmHTTdYvnHvf25ZYJ8DASos0zPx2g2luR9MloVe3NEL
	wVKkC9k5Vu0D8bKT7gS6gC5l+NgrLrY7MjPIxO0E58JRG1ldqDYtTme7zb3EAGa/DPOBPx
	wXMxANlldSKaYs4LMvzPMMHAWj77azMYTKonB6urFLNJdE+opZIAl/8iUwUMidsiuM2+pM
	66feTrCDlk5WFFIMRx1D0XxAigH4rqaGq8+hZK0x03SCwqyFlhekC3C6TuRt1A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712666805;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3yKMAvfXpqgOmamqJLFQyikdCqDJcgZrBM+Mfxzj9Ao=;
	b=PcPEC9yZbT0DgiSOMVzN5gDc6MDVIWlZhamj8ZaxVwg/xZaJXTDVHs1Z3Ki4ecgthXx9DN
	ep9A8zdj9BPV2LAg==
To: Tony Luck <tony.luck@intel.com>, x86@kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 01/74] x86/cpu/vfm: Add/initialize x86_vfm field to
 struct cpuinfo_x86
In-Reply-To: <Zgr7vfS4ArMh4kWx@agluck-desk3>
References: <20240328163746.243023-1-tony.luck@intel.com>
 <20240328163746.243023-2-tony.luck@intel.com>
 <Zgr7vfS4ArMh4kWx@agluck-desk3>
Date: Tue, 09 Apr 2024 14:46:45 +0200
Message-ID: <871q7e7lfu.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Apr 01 2024 at 11:23, Tony Luck wrote:

> Refactor struct cpuinfo_x86 so that the vendor, family, and model
> fields are overlayed in a union with a 32-bit field that combines
> all three (together with a one byte reserved field in the upper
> byte).
>
> This will make it easy, cheap, and reliable to check all three
> values at once.
>
> Signed-off-by: Tony Luck <tony.luck@intel.com>

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>

> ---
>  arch/x86/include/asm/processor.h | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
>
> diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
> index 811548f131f4..4c5d166aa473 100644
> --- a/arch/x86/include/asm/processor.h
> +++ b/arch/x86/include/asm/processor.h
> @@ -108,9 +108,15 @@ struct cpuinfo_topology {
>  };
>  
>  struct cpuinfo_x86 {
> -	__u8			x86;		/* CPU family */
> -	__u8			x86_vendor;	/* CPU vendor */
> -	__u8			x86_model;
> +	union {
> +		struct {
> +			__u8	x86_model;
> +			__u8	x86;		/* CPU family */
> +			__u8	x86_vendor;	/* CPU vendor */
> +			__u8	x86_reserved;
> +		};
> +		__u32		x86_vfm;	/* combined vendor, family, model */
> +	};
>  	__u8			x86_stepping;
>  #ifdef CONFIG_X86_64
>  	/* Number of 4K pages in DTLB/ITLB combined(in pages): */


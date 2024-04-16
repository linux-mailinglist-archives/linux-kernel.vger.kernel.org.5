Return-Path: <linux-kernel+bounces-147763-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 074208A7959
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 01:49:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97C9D1F235FB
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 23:49:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9466013AA2D;
	Tue, 16 Apr 2024 23:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WCIlnxgQ"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DF338120A
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 23:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713311386; cv=none; b=B9t3AYB2pUyof2Lt9dsZp7pl0kVr/oTXAo9JrqT8yuwIx29HVppkgtujgLDSGcnp8REhGxB9zwoOSYfB2VRbTdbXH8aSRtS/uAnKnQJvFy+aqg3mXoyS54/g2YlpYZO+2jQ0MLWx1GCi7SwAFBbe1/wRwBsgJwIdbI08/dRGOsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713311386; c=relaxed/simple;
	bh=hCPWdA9rr94PgDxHtKhmizZTl5xiAfxrqjkcikl2tIE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tA/W6aGEM4uT7PfCbAMiPJkAcY+vgSmwS+15Dj3zM5fzwvp9U1fgdzilhGNcsbfja8/wWsJ0BeZaeI7aXpcwQu3cCjYsgp8ob880oawVNpgjxi0pSIrnccwUBJ86BtXLlkOiZ37QPlGyj+64+RlqYJ4fzkR2/f9a5jht1fBNnsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WCIlnxgQ; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-61aecbcb990so23245667b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 16:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713311384; x=1713916184; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=fSbkUvYlTazCeMlMO1vkJxtCst4vUOS04XJtlOnc/tU=;
        b=WCIlnxgQfJ+/9yfeo0G3k+UZnGvxp+qI/+rSiI9fmmGzRzNOzshn0q662UKk5r/C4j
         ZQEBAB1rk0ZisEJmuADe7De9MzZ97XxY8Wqg7IH8X2MvDfMEXdDVZ+f5jmZA2WIP+WJ6
         hUdf7xdMQIhd5hcndAtremBjnz2M1Pa6IuFpyvSD6+r1K7LwN9IVCMiYSInrW4+73S5Y
         3Fm4Bo2SqfEpXjEUue0ZqBDv4HsIDIttBUfV906AyvdI6nhajxUxe9XdARby0UBrBv4x
         yPXcZYfPA4R42AKsjG7wj3XCM2E9FE9tbRC+Fb1FrAmEnJgPOMRR1x+zoWzqYbIqLJCw
         fa8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713311384; x=1713916184;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fSbkUvYlTazCeMlMO1vkJxtCst4vUOS04XJtlOnc/tU=;
        b=hXzisLJTbA9yI5A5qiKolUNx2d3XvJMnJ9VQ2xBsrjYG3y9tECEjP2X5+yBBh12sIM
         yZQpDDYK6YKdtM/Ch99zVfiBizWMqyNJzhBWXcmdlf/bKI+McbJ1WaSOQNjkqAk7wxke
         CyWYiaA1tWy9wJ+xSyICcs0MkkfrwmKXZmRcHXd9ot42cSLLN1AYCM7NH8E3k7PQhW2b
         6+0z9ybUjouInv23t1kwWy/sNn0CfOcsCvpLGhYG6d5IFKUMbQlphIrdQqFvz+7kKRrb
         JAOiVDWyFqzSVCukdBisoQIBuvUV6EaWFWTpzw7sdxDpBHW04ppFdqNyd6WCwnJsDdUb
         NNKA==
X-Forwarded-Encrypted: i=1; AJvYcCWmvzaIhJ212CH6tDPUP+QHhcODo8ITT3+7A1Ou3az9AkMinaA1b6ezoBEUxCHswtxoL9fhaTcXKfkEgtb17eOF6ybCVAf2p2W7ml11
X-Gm-Message-State: AOJu0Yxap/MnJ+eC+/bqSzE9RZ9N2UxZ9CBpl4U5csfh9o8DLjHjfh3b
	APAoW93mhMol33YAHm5lDshUA1mxJWJ2PMHOu0wadSnDcJfhv7gOm53yDF3UbfR7guYWpQg0GLD
	uMw==
X-Google-Smtp-Source: AGHT+IEHIc969kNCjIAQo5sLy6rN3g3RiusseUIDfy+qVmLO08WVC1ABRW3gLNGFXHmkze9dLG/lv9x3/Ds=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:8407:0:b0:ddd:6bde:6c82 with SMTP id
 u7-20020a258407000000b00ddd6bde6c82mr3995520ybk.12.1713311384457; Tue, 16 Apr
 2024 16:49:44 -0700 (PDT)
Date: Tue, 16 Apr 2024 16:49:42 -0700
In-Reply-To: <20240413044129.52812-2-xry111@xry111.site>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240413044129.52812-1-xry111@xry111.site> <20240413044129.52812-2-xry111@xry111.site>
Message-ID: <Zh8Oli5MIyekLrbu@google.com>
Subject: Re: [PATCH v8 2/2] x86/mm: Don't disable PCID if the kernel is
 running on a hypervisor
From: Sean Christopherson <seanjc@google.com>
To: Xi Ruoyao <xry111@xry111.site>
Cc: Dave Hansen <dave.hansen@linux.intel.com>, Michael Kelley <mhklinux@outlook.com>, 
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, 
	linux-kernel@vger.kernel.org, Andrew Cooper <andrew.cooper3@citrix.com>
Content-Type: text/plain; charset="us-ascii"

On Sat, Apr 13, 2024, Xi Ruoyao wrote:
> The Intel erratum for "incomplete Global INVLPG flushes" says:
> 
>     This erratum does not apply in VMX non-root operation. It applies
>     only when PCIDs are enabled and either in VMX root operation or
>     outside VMX operation.
> 
> So if the kernel is running in a hypervisor, we are in VMX non-root
> operation and we should be safe to use PCID.
> 
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Michael Kelley <mhklinux@outlook.com>
> Cc: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
> Cc: Sean Christopherson <seanjc@google.com>
> Cc: Andrew Cooper <andrew.cooper3@citrix.com>
> Link: https://lore.kernel.org/all/168436059559.404.13934972543631851306.tip-bot2@tip-bot2/
> Link: https://cdrdv2.intel.com/v1/dl/getContent/740518 # RPL042, rev. 13
> Link: https://cdrdv2.intel.com/v1/dl/getContent/682436 # ADL063, rev. 24
> Signed-off-by: Xi Ruoyao <xry111@xry111.site>
> ---
>  arch/x86/mm/init.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/arch/x86/mm/init.c b/arch/x86/mm/init.c
> index c318cdc35467..6010f86c5acd 100644
> --- a/arch/x86/mm/init.c
> +++ b/arch/x86/mm/init.c
> @@ -275,6 +275,14 @@ static void __init probe_page_size_mask(void)
>   * microcode is not updated to fix the issue.
>   */
>  static const struct x86_cpu_id invlpg_miss_ids[] = {
> +	/* Only bare-metal is affected.  PCIDs in guests are OK.  */
> +	{
> +	  .vendor	= X86_VENDOR_INTEL,
> +	  .family	= 6,
> +	  .model	= INTEL_FAM6_ANY,
> +	  .feature	= X86_FEATURE_HYPERVISOR,

Isn't this inverted?  x86_match_cpu() will return NULL if the CPU doesn't have
HYPERVISOR.  We want it to return NULL if the CPU *does* have HYPERVISOR.

> +	  .driver_data	= 0,
> +	},
>  	INTEL_MATCH(INTEL_FAM6_ALDERLAKE,	0x2e),
>  	INTEL_MATCH(INTEL_FAM6_ALDERLAKE_L,	0x42c),
>  	INTEL_MATCH(INTEL_FAM6_ATOM_GRACEMONT,	0x11),
> -- 
> 2.44.0
> 


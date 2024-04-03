Return-Path: <linux-kernel+bounces-130182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A03A589750A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 18:20:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53EFF1F270AD
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 16:20:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07F9314EC77;
	Wed,  3 Apr 2024 16:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QoIgth2X"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50C4E947E
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 16:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712161236; cv=none; b=M4fZwHpwJsQj2zzouhHlYrwVpwNvu4GUD5yoNQpnOQXytwX+gs1V7xH/5WP90cVegBmlbeX4nr7tPenYOTt54HX+wnW0+Fh9AmvuraLHkRWiJY7DOra4JuXEaYYZyBnFNyDoZc7IvcsqSQXw+0TMoZdUBmFtXJ2R0+J92zl/DIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712161236; c=relaxed/simple;
	bh=SKjgQ1rezXkYAZkAsWgrEK+YYKJoAuGLpq/GsNbxYqM=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=HLaressRXJG8UDgaNUtA7I/miz2UoqhVaXFMLw/DpYYVKq5n6LoTe6kntl8M23fXmO8Zjh5SX6DfC5OnxnZJjMXWZkFczdhh5W/hHpDHp9u06iwVhUzAem6wI7SmkUhz3ghIZcIFfLUff9UhERI52uLTMPL77Trh/YP/Y32qxLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QoIgth2X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C135C433F1;
	Wed,  3 Apr 2024 16:20:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712161235;
	bh=SKjgQ1rezXkYAZkAsWgrEK+YYKJoAuGLpq/GsNbxYqM=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=QoIgth2X2LRa52jKpymcQxim2zHkAR5mCzB2kse7EnMVQ//RoMSwBiW7pi6H1Vfeo
	 OQ4J/feQ6+H9zLeWcbkdc3PQnAr+ad7Ywu4L+YXnajRAhBY6064VSqJG2ZPmEnBPHO
	 VVNwXjF/fxX5t7h8CwFiKy+ZDwy5Oo1XuihkQphJh42CyBO0frqYmjHo71+fMCstJr
	 PQ+NpKPLYO3L2+tM6xAC5AUBIR3EOHJi3zZWwde/KzZHG2DKQA7tqAsSMmg3Grrd2B
	 HIZjks76mfx7IsT2h1xQacdxSWurD9IoqyszBQJeSNZjytLDGp6z1WAx+6Le+XGu+Y
	 IGgw/cQI3JMnA==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 03 Apr 2024 19:20:31 +0300
Message-Id: <D0AMI3962WW0.3JKFCSUXVSSVL@kernel.org>
Cc: <anil.s.keshavamurthy@intel.com>, <aou@eecs.berkeley.edu>,
 <davem@davemloft.net>, <linux-arm-kernel@lists.infradead.org>,
 <mhiramat@kernel.org>, <naveen.n.rao@linux.ibm.com>, <palmer@dabbelt.com>,
 <paul.walmsley@sifive.com>
Subject: Re: [PATCH v2 1/4] arm64: patching: always use fixmap
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Mark Rutland" <mark.rutland@arm.com>, <linux-kernel@vger.kernel.org>,
 "Catalin Marinas" <catalin.marinas@arm.com>, "Will Deacon"
 <will@kernel.org>
X-Mailer: aerc 0.17.0
References: <20240403150154.667649-1-mark.rutland@arm.com>
 <20240403150154.667649-2-mark.rutland@arm.com>
In-Reply-To: <20240403150154.667649-2-mark.rutland@arm.com>

On Wed Apr 3, 2024 at 6:01 PM EEST, Mark Rutland wrote:
> For historical reasons, patch_map() won't bother to fixmap non-image
> addresses when CONFIG_STRICT_MODULE_RWX=3Dn, matching the behaviour prior
> to the introduction of CONFIG_STRICT_MODULE_RWX. However, as arm64
> doesn't select CONFIG_ARCH_OPTIONAL_KERNEL_RWX, CONFIG_MODULES implies
> CONFIG_STRICT_MODULE_RWX, so any kernel built with module support will
> use the fixmap for any non-image address.

Not familiar with the config flag but I'd guess it is essentially
w^x enforcement right for the sections?

> Historically we only used patch_map() for the kernel image and modules,
> but these days its also used by BPF and KPROBES to write to read-only
> pages of executable text. Currently these both depend on CONFIG_MODULES,
> but we'd like to change that in subsequent patches, which will require
> using the fixmap regardless of CONFIG_STRICT_MODULE_RWX.
>
> This patch changes patch_map() to always use the fixmap, and simplifies
> the logic:
>
> * Use is_image_text() directly in the if-else, rather than using a
>   temporary boolean variable.
>
> * Use offset_in_page() to get the offset within the mapping.
>
> * Remove uintaddr and cast the address directly when using
>   is_image_text().
>
> For kernels built with CONFIG_MODULES=3Dy, there should be no functional
> change as a result of this patch.
>
> For kernels built with CONFIG_MODULES=3Dn, patch_map() will use the fixma=
p
> for non-image addresses, but there are no extant users with non-image
> addresses when CONFIG_MODULES=3Dn, and hence there should be no functiona=
l
> change as a result of this patch alone.
>
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> ---
>  arch/arm64/kernel/patching.c | 10 +++-------
>  1 file changed, 3 insertions(+), 7 deletions(-)
>
> Catalin, Will, this is a prerequisite for the final two patches in the
> series. Are you happy for this go via the tracing tree?
>
> Mark.
>
> diff --git a/arch/arm64/kernel/patching.c b/arch/arm64/kernel/patching.c
> index 2555349303684..f0f3a2a82ca5a 100644
> --- a/arch/arm64/kernel/patching.c
> +++ b/arch/arm64/kernel/patching.c
> @@ -30,20 +30,16 @@ static bool is_image_text(unsigned long addr)
> =20
>  static void __kprobes *patch_map(void *addr, int fixmap)
>  {
> -	unsigned long uintaddr =3D (uintptr_t) addr;
> -	bool image =3D is_image_text(uintaddr);
>  	struct page *page;
> =20
> -	if (image)
> +	if (is_image_text((unsigned long)addr))
>  		page =3D phys_to_page(__pa_symbol(addr));
> -	else if (IS_ENABLED(CONFIG_STRICT_MODULE_RWX))
> -		page =3D vmalloc_to_page(addr);
>  	else
> -		return addr;
> +		page =3D vmalloc_to_page(addr);
> =20
>  	BUG_ON(!page);
>  	return (void *)set_fixmap_offset(fixmap, page_to_phys(page) +
> -			(uintaddr & ~PAGE_MASK));
> +					 offset_in_page(addr));

nit: could be a single line but i guess it is up to the taste (and
subsystem maintainer). I.e. checkpatch will allow it at least.

I don't mind it too much just mentioning for completeness.

>  }
> =20
>  static void __kprobes patch_unmap(int fixmap)

If my assumption about the config flag holds this makes sense:

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.rg>

BR, Jarkko


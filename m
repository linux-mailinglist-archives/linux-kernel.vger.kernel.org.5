Return-Path: <linux-kernel+bounces-76805-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 343F885FCD8
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 16:44:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DCEEB1F27670
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 15:44:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AC3215697E;
	Thu, 22 Feb 2024 15:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qk+5wVMZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9867156976
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 15:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708616512; cv=none; b=j6Nn/73/iAr2IbTlvNqb22BVxqOeWz/+ghnvhXDOiMK6g0DfCaOsDB6NoRnTmK2gzSTuMmdoSsfAVO9ueg6Fw0efKsnRpslhvVp/7W4raYNdqR5AZR0EfFmI6ejz1MM3EJDeB4fiSMJ0QeSYoF6Qi5DBcSbwcbiMMOr2qqdqTeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708616512; c=relaxed/simple;
	bh=nqgg4xZrpKp12QvERL+ahDDnpkHl69a5C+qcajcYEFw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P5GL4RTtfC/JkFasDyC6Imf3x9ZKRjBXvPdmRuv13cAK2mBoMU0Hy9ffNBHsy1zfLO+5PsEXNZ0wv8szxf6dp/D+3hDr4OjxOobhCP1DmQnujH0RKlRmTJPQRCzDwk1yDxOzsG83W8CsJsmImsjNuMmnhjNLsgBjQP8lkMyJ3LE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qk+5wVMZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC409C43390;
	Thu, 22 Feb 2024 15:41:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708616512;
	bh=nqgg4xZrpKp12QvERL+ahDDnpkHl69a5C+qcajcYEFw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Qk+5wVMZwcgL9wZU/PM2XA8D4i5s/MQ8EsK+MdEP0+gUzahW9vw3zydeagdg4t2IO
	 YcyGJAZpPQ9mMM4AlW5EfYuZEjoIu7wcU4zyfXIedmQXcq8u49tRGFb3Fq4SJ2ZSuz
	 66qQK9SIRNCJqevPFxQUt84yUxi+k6aQe/Pmu9oRRX0WIFFotbeHGnBgM0KwgpGmx6
	 OLlU1VoAYHsRPauGQevhHCQCe6io1q2FPZ8ypI1P2m2KOHJy5N8JH5mRIRCJGK7ybv
	 QSvu39MYUPdBnj0/Ak3NgW3zQqfmJcLJcbZMEUgtGSMWveI6DShDKUyxc9hJvc3WSz
	 HD6fuDr4fX6Xw==
Date: Thu, 22 Feb 2024 15:41:47 +0000
From: Will Deacon <will@kernel.org>
To: Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc: linux-kernel@vger.kernel.org, Andy Lutomirski <luto@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 05/10] arm64/vdso: Use generic union vdso_data_store
Message-ID: <20240222154146.GA8949@willie-the-truck>
References: <20240219153939.75719-1-anna-maria@linutronix.de>
 <20240219153939.75719-6-anna-maria@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240219153939.75719-6-anna-maria@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Mon, Feb 19, 2024 at 04:39:34PM +0100, Anna-Maria Behnsen wrote:
> There is already a generic union definition for vdso_data_store in vdso
> datapage header.
> 
> Use this definition to prevent code duplication.
> 
> Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: linux-arm-kernel@lists.infradead.org
> ---
>  arch/arm64/kernel/vdso.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/kernel/vdso.c b/arch/arm64/kernel/vdso.c
> index 5562daf38a22..89b6e7840002 100644
> --- a/arch/arm64/kernel/vdso.c
> +++ b/arch/arm64/kernel/vdso.c
> @@ -69,10 +69,7 @@ static struct vdso_abi_info vdso_info[] __ro_after_init = {
>  /*
>   * The vDSO data page.
>   */
> -static union {
> -	struct vdso_data	data[CS_BASES];
> -	u8			page[PAGE_SIZE];
> -} vdso_data_store __page_aligned_data;
> +static union vdso_data_store vdso_data_store __page_aligned_data;
>  struct vdso_data *vdso_data = vdso_data_store.data;
>  
>  static int vdso_mremap(const struct vm_special_mapping *sm,
> -- 
> 2.39.2

Acked-by: Will Deacon <will@kernel.org>

Will


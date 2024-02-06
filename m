Return-Path: <linux-kernel+bounces-54686-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AFAB84B278
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 11:28:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD7531C23726
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 10:28:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DD4112E1EA;
	Tue,  6 Feb 2024 10:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rDyATUQG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 819FC12CDBA
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 10:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707215279; cv=none; b=YQ0E4m/0IxPEmdwlFRHlZ8zPpaD/vGoAdmRRp4MI3r9EIP7M5uzPORc7C0u2T9P1RSSSFjrF1ZkRo0yT7i9oQUGKzyQriTJH5KWuky6VtflhzPWdNGK1Z0faUcM51oMd8YSF+gYXxCuNXscKnSUSO6AT0VyOPbBi2MXaTrjX45I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707215279; c=relaxed/simple;
	bh=u7wVea/4SlPP6+h8wkS+v2aRTJMeBzRcPmydx6VUVxg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sHEfYkbj4bugl0IF+o/drBh6gNU9Tb45vFR6ItFikrPO4K7uJJFNXoHR7xUJUwwZG9fzqQgMAes//YEkfkFvl6Pm6LPPemB51nG/iA3q2AhvqE3MdaiM7Mu7OM5vXvMRIe69flnV8btjBKsXPsqu9P0JOnTJBYtqAks8kXYC5Oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rDyATUQG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F2DFC433F1;
	Tue,  6 Feb 2024 10:27:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707215279;
	bh=u7wVea/4SlPP6+h8wkS+v2aRTJMeBzRcPmydx6VUVxg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rDyATUQGLxwlWacikkMc8egWhFadby+tHgYFnfV2j5PI1VZurWKjs76qQ/mVFMTP4
	 XQgkVTpQJG5MYyPUyDTyYDtp99q8EVkXl0dvjnpenPkgeD/Gqr0R+F4T5cQIHSOtFB
	 vEGV7bbUGRNjb3XDJMD8l9EMJF2Ki+v+9FrZWL27tKvcIgkyucAsMOzCRu1Z2gcrQE
	 J6YNFGdutLdnmQKoviIVcaLK5Z9wDh273+fwqL/QQGXjnlh9tt/GurukwU+OLMivqN
	 a1hbMwkvb2gy25OFKMI6jf81NsLrVzqCSa8rg8SguUMq1kKfEAbce2FA+LkgvuevAa
	 CUV/dDV8DdtHQ==
Date: Tue, 6 Feb 2024 18:15:04 +0800
From: Jisheng Zhang <jszhang@kernel.org>
To: Charlie Jenkins <charlie@rivosinc.com>
Cc: Alexandre Ghiti <alexghiti@rivosinc.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH -fixes] riscv: Fix arch_tlbbatch_flush() by clearing the
 batch cpumask
Message-ID: <ZcIGqBSHzjI1xVRX@xhacker>
References: <20240130115508.105386-1-alexghiti@rivosinc.com>
 <ZcF8z18dwnGsw0Ix@ghost>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZcF8z18dwnGsw0Ix@ghost>

On Mon, Feb 05, 2024 at 04:26:55PM -0800, Charlie Jenkins wrote:
> On Tue, Jan 30, 2024 at 12:55:08PM +0100, Alexandre Ghiti wrote:
> > We must clear the cpumask once we have flushed the batch, otherwise cpus
> > get accumulated and we end sending IPIs to more cpus than needed.
> > 
> > Fixes: 54d7431af73e ("riscv: Add support for BATCHED_UNMAP_TLB_FLUSH")
> > Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>

Reviewed-by: Jisheng Zhang <jszhang@kernel.org>
> > ---
> >  arch/riscv/mm/tlbflush.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/arch/riscv/mm/tlbflush.c b/arch/riscv/mm/tlbflush.c
> > index 99c3e037f127..c8efc3f87a0f 100644
> > --- a/arch/riscv/mm/tlbflush.c
> > +++ b/arch/riscv/mm/tlbflush.c
> > @@ -240,4 +240,5 @@ void arch_tlbbatch_flush(struct arch_tlbflush_unmap_batch *batch)
> >  {
> >  	__flush_tlb_range(NULL, &batch->cpumask,
> >  			  0, FLUSH_TLB_MAX_SIZE, PAGE_SIZE);
> > +	cpumask_clear(&batch->cpumask);
> >  }
> > -- 
> > 2.39.2
> > 
> > 
> > _______________________________________________
> > linux-riscv mailing list
> > linux-riscv@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-riscv
> 
> Reviewed-by: Charlie Jenkins <charlie@rivosinc.com>
> 


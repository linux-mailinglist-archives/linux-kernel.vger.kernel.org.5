Return-Path: <linux-kernel+bounces-62569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B27D852310
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 01:16:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EBBE8B24AE3
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 00:16:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E9DC1FCC;
	Tue, 13 Feb 2024 00:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HRu7Kq5N"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59A1A8F4D;
	Tue, 13 Feb 2024 00:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707783351; cv=none; b=QMqStliUnZ9FNemRheOolVdzBYxE9TWPk/BYUEIhQd+gfydM+KnKn0UmclDv2Ur/iPKknojuC2spg/H5MLealwEvPaHnVUMGxwes8Uk4duBhpcB0hYLQmT7772wnr2cgiIon4Er0s0UYj2Adu2CMSiUZ4d/JQa+TqZl+U7+YaLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707783351; c=relaxed/simple;
	bh=pGauPJe3pc7ZiPndNvLC3iAdr8bnuuyJx3XLyQ1nH+w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SbEb/2IKfxuZi/U/wStm/6irA3oNrvghU+I82kB9OVEqOOgjVIarOQuGQqDExE9NUQK7bd24YAVb8X9BB2S9JuUgEplyGL7etbhSAp2Qa+6pLaIbopMki4IJ/5p0+i0HNgLzxTmXwqo9DaPCdSY0eYinuMK4YwhUMKKnE1VrKbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HRu7Kq5N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DF56C433C7;
	Tue, 13 Feb 2024 00:15:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707783350;
	bh=pGauPJe3pc7ZiPndNvLC3iAdr8bnuuyJx3XLyQ1nH+w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HRu7Kq5N/r4Q6jC40gbj2fXRkIiJyYdybBD3jAEG3u44DQawDKCCRf+OriNIkmHaM
	 O3xoK/t+u2mlk2oGrPlWC1AVzhoCdxc4H/vMthGgbSyd2JPogTpSca5HWd1ojKQ+Hu
	 /I0MMY0o/MgkV63FyVi9cNFSYbRPOIURWXvlLAUpTxLJzeO6/LGRxtHp3q4jOh0tf3
	 kFviHv6324k/eNaAEuPr5p815McbZcv53aZhuxFNiZwumJpmJiH/e2/hT+y/Cj1od2
	 uI4ynLfy+l2Uv8xkpD76mgu2SIMTCWDt1l2CkMICuGW4EHWSEaGv/DuvHsMH5z4oeL
	 kFMgaFSlAMBMA==
Date: Mon, 12 Feb 2024 17:15:48 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Heiko Carstens <hca@linux.ibm.com>
Cc: gor@linux.ibm.com, agordeev@linux.ibm.com, borntraeger@linux.ibm.com,
	svens@linux.ibm.com, maskray@google.com, ndesaulniers@google.com,
	linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev, patches@lists.linux.dev
Subject: Re: [PATCH 04/11] s390: vmlinux.lds.S: Discard unnecessary sections
Message-ID: <20240213001548.GA3272429@dev-arch.thelio-3990X>
References: <20240207-s390-lld-and-orphan-warn-v1-0-8a665b3346ab@kernel.org>
 <20240207-s390-lld-and-orphan-warn-v1-4-8a665b3346ab@kernel.org>
 <20240212135511.65142-A-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240212135511.65142-A-hca@linux.ibm.com>

On Mon, Feb 12, 2024 at 02:55:11PM +0100, Heiko Carstens wrote:
> On Wed, Feb 07, 2024 at 05:14:56PM -0700, Nathan Chancellor wrote:
> > When building with CONFIG_LD_ORPHAN_WARN after selecting
> > CONFIG_ARCH_HAS_LD_ORPHAN_WARN, there are some warnings around certain
> > ELF sections that are unnecessary for the kernel's purposes.
> > 
> >   s390-linux-ld: warning: orphan section `.dynstr' from `arch/s390/kernel/head64.o' being placed in section `.dynstr'
> >   s390-linux-ld: warning: orphan section `.dynamic' from `arch/s390/kernel/head64.o' being placed in section `.dynamic'
> >   s390-linux-ld: warning: orphan section `.hash' from `arch/s390/kernel/head64.o' being placed in section `.hash'
> >   s390-linux-ld: warning: orphan section `.gnu.hash' from `arch/s390/kernel/head64.o' being placed in section `.gnu.hash'
> > 
> > Add them to the discards to clear up the warnings, which matches other
> > architectures.
> > 
> > Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> > ---
> >  arch/s390/kernel/vmlinux.lds.S | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> ...
> > -		*(.interp)
> > +		*(.interp .dynamic)
> > +		*(.dynstr .hash .gnu.hash)
> 
> This seems to be wrong, since it leads to 1000s of error messages when
> using the "crash" utility e.g. when looking into a live dump of system
> with the generated debug info:
> 
> BFD: /usr/lib/debug/usr/lib/modules/6.8.0-20240211.rc3.git0.bdca9b8dcf3f.300.fc39.s390x/vmlinux: attempt to load strings from a non-string section (number 0)
> 
> I will change this commit to the below; it seems to work and is in
> line with other architectures:

Thanks a lot for catching that, your final change seems good to me.
Here's to hoping I did not get anything else wrong :)

Cheers,
Nathan

> -----
> 
> When building with CONFIG_LD_ORPHAN_WARN after selecting
> CONFIG_ARCH_HAS_LD_ORPHAN_WARN, there are some warnings around certain
> ELF sections:
> 
>   s390-linux-ld: warning: orphan section `.dynstr' from `arch/s390/kernel/head64.o' being placed in section `.dynstr'
>   s390-linux-ld: warning: orphan section `.dynamic' from `arch/s390/kernel/head64.o' being placed in section `.dynamic'
>   s390-linux-ld: warning: orphan section `.hash' from `arch/s390/kernel/head64.o' being placed in section `.hash'
>   s390-linux-ld: warning: orphan section `.gnu.hash' from `arch/s390/kernel/head64.o' being placed in section `.gnu.hash'
> 
> Explicitly keep those sections like other architectures when
> CONFIG_RELOCATABLE is enabled, which is always true for s390.
> 
> [hca@linux.ibm.com: keep sections instead of discarding]
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> Link: https://lore.kernel.org/r/20240207-s390-lld-and-orphan-warn-v1-4-8a665b3346ab@kernel.org
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
> ---
>  arch/s390/kernel/vmlinux.lds.S | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/arch/s390/kernel/vmlinux.lds.S b/arch/s390/kernel/vmlinux.lds.S
> index 661a487a3048..d46e3c383952 100644
> --- a/arch/s390/kernel/vmlinux.lds.S
> +++ b/arch/s390/kernel/vmlinux.lds.S
> @@ -200,6 +200,21 @@ SECTIONS
>  		*(.rela*)
>  		__rela_dyn_end = .;
>  	}
> +	.dynamic ALIGN(8) : {
> +		*(.dynamic)
> +	}
> +	.dynsym ALIGN(8) : {
> +		*(.dynsym)
> +	}
> +	.dynstr ALIGN(8) : {
> +		*(.dynstr)
> +	}
> +	.hash ALIGN(8) : {
> +		*(.hash)
> +	}
> +	.gnu.hash ALIGN(8) : {
> +		*(.gnu.hash)
> +	}
>  
>  	. = ALIGN(PAGE_SIZE);
>  	__init_end = .;		/* freed after init ends here */
> -- 
> 2.40.1
> 


Return-Path: <linux-kernel+bounces-9357-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C45B081C487
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 06:04:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 455611F25E67
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 05:04:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 381C853AA;
	Fri, 22 Dec 2023 05:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YOt2YZlQ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 827AB5390
	for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 05:04:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70588C433C8;
	Fri, 22 Dec 2023 05:04:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703221448;
	bh=q+FYm6cQEIsutbwAwEytF6Eg5VuS0ddDhi1Ombl5s9I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YOt2YZlQ+xmRpHLj1toDmZoHJdAoZk86pfDaQMl4wB1nr4gqR2dbtnTovUR/EQfMc
	 fbY29i5kenMonsJ4FRNh3HoeNo/6e/wBRec5popMPubuqZ8Qm5+dGLjIkVyRudJ+gU
	 e02T6o/cJAEXChPKRpzT+FzEMATR+iqkhZBLara3zTmxicW8CNyfh7mXRDkQVB9mqz
	 wt69BT6h4Rske+FjNS8kQoigoVYZ89V4R8SNX1nLBlTA8jGxGaF4jCTqdHOfnEjHHw
	 gdDDsErpbBk+bxPeIXs481IT1eXcSQKmViZMh7Jyn4Lf8QcGxoPL5T57kJ3fCcOTDn
	 Hjg7EdOgszf+g==
Date: Thu, 21 Dec 2023 23:04:03 -0600
From: Eric Biggers <ebiggers@kernel.org>
To: Qingfang DENG <dqfext@gmail.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Conor Dooley <conor.dooley@microchip.com>,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	Jisheng Zhang <jszhang@kernel.org>
Subject: Re: [PATCH v2 1/2] riscv: introduce RISCV_EFFICIENT_UNALIGNED_ACCESS
Message-ID: <20231222050403.GB52600@quark.localdomain>
References: <20231203135753.1575-2-jszhang@kernel.org>
 <20231203135753.1575-1-jszhang@kernel.org>
 <20231205083924.48933-1-dqfext@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231205083924.48933-1-dqfext@gmail.com>

On Tue, Dec 05, 2023 at 04:39:24PM +0800, Qingfang DENG wrote:
> Hi,
> 
> You may as well remove the -mstrict-align CFLAGS in the Makefile, if
> this option is enabled:
> 
> --- a/arch/riscv/Makefile
> +++ b/arch/riscv/Makefile
> @@ -108,7 +108,9 @@ KBUILD_AFLAGS_MODULE += $(call as-option,-Wa$(comma)-mno-relax)
>  # unaligned accesses.  While unaligned accesses are explicitly allowed in the
>  # RISC-V ISA, they're emulated by machine mode traps on all extant
>  # architectures.  It's faster to have GCC emit only aligned accesses.
> +ifneq ($(CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS),y)
>  KBUILD_CFLAGS += $(call cc-option,-mstrict-align)
> +endif
>  

Agreed.  When CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS=y, we shouldn't use
-mstrict-align, so that the compiler can actually use unaligned memory accesses.

If I understand correctly, beyond the change requested above, people seem to be
happy with this patch.  Jisheng, can you resend it with the above feedback
addressed?  Thanks!

- Eric


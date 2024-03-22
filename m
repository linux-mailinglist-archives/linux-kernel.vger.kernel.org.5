Return-Path: <linux-kernel+bounces-111706-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 24955886FDC
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 16:37:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 569251C20EC5
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 15:37:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D04F35339D;
	Fri, 22 Mar 2024 15:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="na1dbiZm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15B6B524DF;
	Fri, 22 Mar 2024 15:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711121865; cv=none; b=p3BIsiPYhPXNQBSI3PSTju1zkBR5uHCUtYQlGgmdG4PzJckcmslkni9FIpl4hWeFvufYVo2pSQaIFagSQQtoXkwdFTdpf2gpiUxqp7R2ybzjeN2OgwTR0GSXtWuZsYp4u6f1fl0HoxBgdRXG8uWD4eF4k/Sn4Y+DDvKXzbN2fOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711121865; c=relaxed/simple;
	bh=GzNKDIuOGjs6k2ffastjq4w0MJc1MWTYP5L+bid8nNs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pLlFV5S8+kf7wEHRlbsit2M9IXnxH0AQli1t1KQ8BrHi1ZUqhelTK+OwOQzb+z3nLHxhqZdYbDiDmPuGt4l7SgGaZcB4q2rRqoC4FLCARXkv1/v2KrU0MF06vqPuioGuQbLPdTyKLhOIN52CkdB43gGIWglLNjEWgkSPTQK03KA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=na1dbiZm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6846C433C7;
	Fri, 22 Mar 2024 15:37:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711121864;
	bh=GzNKDIuOGjs6k2ffastjq4w0MJc1MWTYP5L+bid8nNs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=na1dbiZmzOLr8mIcs9+E2IaW2RUObCivfYvEzZKPG4SFSlvf9aq8eObRqP1IiD7wi
	 IDHtIaNcAMoWlxkFxZOSzpRS2+ZSZQUPoYd3peMdiBa2YeMNNAogI1/B/v/ljLHlGk
	 tjua4Bci0DInz97kRAPhVLM8s2xMOQukUw4UUWIcNK0ByHz6itpkD1UoGxykcwPFRP
	 BiIeWb4OS3zPFWNzTMtX9mnW1FRWibMz3sBaOhM6Z+vCnAVU0VX5ltSWBB+fHkw4rM
	 BxN6LPaYgIzD2wsfyGRTsSeYvl7obc/bNlsa2tohVoeZqxptYrWNVxon8+fpaahzVO
	 bUuy2wue7+X9w==
Date: Fri, 22 Mar 2024 15:37:38 +0000
From: Will Deacon <will@kernel.org>
To: Petr Tesarik <petrtesarik@huaweicloud.com>
Cc: Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Petr Tesarik <petr.tesarik1@huawei-partners.com>,
	Michael Kelley <mhklinux@outlook.com>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:DMA MAPPING HELPERS" <iommu@lists.linux.dev>,
	Roberto Sassu <roberto.sassu@huaweicloud.com>,
	Petr Tesarik <petr@tesarici.cz>
Subject: Re: [PATCH v3 2/2] bug: introduce ASSERT_VAR_CAN_HOLD()
Message-ID: <20240322153738.GC5634@willie-the-truck>
References: <20240321171902.85-1-petrtesarik@huaweicloud.com>
 <20240321171902.85-3-petrtesarik@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240321171902.85-3-petrtesarik@huaweicloud.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Thu, Mar 21, 2024 at 06:19:02PM +0100, Petr Tesarik wrote:
> From: Petr Tesarik <petr.tesarik1@huawei-partners.com>
> 
> Introduce an ASSERT_VAR_CAN_HOLD() macro to check at build time that a
> variable can hold the given value.
> 
> Use this macro in swiotlb to make sure that the list and pad_slots fields
> of struct io_tlb_slot are big enough to hold the maximum possible value of
> IO_TLB_SEGSIZE.
> 
> Signed-off-by: Petr Tesarik <petr.tesarik1@huawei-partners.com>
> ---
>  include/linux/build_bug.h | 10 ++++++++++
>  kernel/dma/swiotlb.c      |  2 ++
>  2 files changed, 12 insertions(+)
> 
> diff --git a/include/linux/build_bug.h b/include/linux/build_bug.h
> index 3aa3640f8c18..6e2486508af0 100644
> --- a/include/linux/build_bug.h
> +++ b/include/linux/build_bug.h
> @@ -86,4 +86,14 @@
>  		"Offset of " #field " in " #type " has changed.")
>  
>  
> +/*
> + * Compile time check that a variable can hold the given value
> + */
> +#define ASSERT_VAR_CAN_HOLD(var, value) ({		\
> +	typeof(value) __val = (value);			\
> +	typeof(var) __tmp = __val;			\
> +	BUILD_BUG_ON_MSG(__tmp != __val,		\
> +		#var " cannot hold " #value ".");	\
> +})

nit, but I think this prevents putting negative values into unsigned
types. Not sure whether we care? Arguably it's even correct to complain.

e.g.

	u16 s;
	ASSERT_VAR_CAN_HOLD(s, -1);

explodes for me.

Will


Return-Path: <linux-kernel+bounces-108699-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 948CE880EC7
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 10:38:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27D921F21554
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 09:38:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 234A63B796;
	Wed, 20 Mar 2024 09:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EFuQrpr1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B2B632C60
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 09:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710927477; cv=none; b=C4OIxexSekYr+ONYNz3uOPqwuMAT7XcFtHYawN65ZnMO8EZCI/HsDILzY5sK9P1Z9ydXRK4SnQmF0+PfakUPND+AAGc5Oc0isIQ8slzXdyxqvRVln9Q7Ga5n2CslQC6asrFYgyUazCX+S+yOXlf93wDLMCw8KWpWfR/kLc1cVB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710927477; c=relaxed/simple;
	bh=6en8ZZ+fOEyondqQ+Wkc9mV58Xe+D619z940m0qzrm8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nVZ2NDePpT96YrlaSsDU75+uR428d7nQ+AQNPM4EDKpUDzyJg9pJdsQn679tF7REBhy22CG0rZNfBOHAUcuEDnpbqTdcXM/vpKPCYu4vnwFulytCa9vB7/BSoYi088DWXOmUhsyl2qVpW1FrXfvADyvPgGL3HeZQ7ym2ryviU+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EFuQrpr1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFA07C43390;
	Wed, 20 Mar 2024 09:37:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710927476;
	bh=6en8ZZ+fOEyondqQ+Wkc9mV58Xe+D619z940m0qzrm8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EFuQrpr1jzAOMq8F2IC3MV1yHDLmeckZtzWRKrHwdvnnIsPr3aiWwWV0UCpseJgMY
	 CLVANZ2nMu20Vx/v7G0qEug+XY6D17CKFoScSKv7iSfSJc2Mk18dZpNZn4XDJFWD0v
	 D0+Iz0wZTgbvswkA8UBsLimhMs893ReE4MErG0J74+jQX4sBmANFRvKSvZ41ojznqH
	 QuINWdgXEerhnWjAkQVXdAWfUcu3ZMhme4xnes4TORjpi+glPdrPb1mPMv70cHmNA9
	 fONx+GdtQX9iLu0n0AOPGjt2ahtYbmAaywQkrxrgvSP6aksTyWRav+DygUuV1rn+pp
	 cjy7ab8i7wtKQ==
Date: Wed, 20 Mar 2024 11:36:51 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Baoquan He <bhe@redhat.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, x86@kernel.org,
	linuxppc-dev@lists.ozlabs.org, akpm@linux-foundation.org
Subject: Re: [PATCH 2/6] x86: remove memblock_find_dma_reserve()
Message-ID: <ZfquM06LOZB4vddu@kernel.org>
References: <20240318142138.783350-1-bhe@redhat.com>
 <20240318142138.783350-3-bhe@redhat.com>
 <Zfmz_1sbbvSWMj9C@kernel.org>
 <ZfqV1IEo3+cf9f9I@MiWiFi-R3L-srv>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZfqV1IEo3+cf9f9I@MiWiFi-R3L-srv>

On Wed, Mar 20, 2024 at 03:52:52PM +0800, Baoquan He wrote:
> On 03/19/24 at 05:49pm, Mike Rapoport wrote:
> > Hi Baoquan,
> > 
> > On Mon, Mar 18, 2024 at 10:21:34PM +0800, Baoquan He wrote:
> > > This is not needed any more.
> > 
> > I'd swap this and the first patch, so that the first patch would remove
> > memblock_find_dma_reserve() and it's changelog will explain why it's not
> > needed and then the second patch will simply drop unused set_dma_reserve()
> 
> Thanks, Mike.
> 
> My thought on the patch 1/2 splitting is:
> patch 1 is removing all relevant codes in mm, including the usage of
> dma_reserve in free_area_init_core() and exporting set_dma_reserve()
> to any ARCH which want to subtract the dma_reserve from DMA zone.
>
> Patch 2 purely remove the code in x86 ARCH about how to get dma_reserve.
 
I think it's better first to remove the usage of set_dma_reserve() in x86
and then clean up the unused code.

> Your suggestion is also good to me, I can rearrange the order and
> repost.

-- 
Sincerely yours,
Mike.


Return-Path: <linux-kernel+bounces-97005-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D7310876455
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 13:31:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 771711F21D1F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 12:31:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 957738BEF;
	Fri,  8 Mar 2024 12:30:59 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29A8A367;
	Fri,  8 Mar 2024 12:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709901059; cv=none; b=fcdOP5+2Li+zILVnmy6wlV83Tz+eZFqFmPTQAH91cSM+1CQXV5BHHA828vCMvVGBi/SDU3scL176WbEL3aWSTr4vEXmobSemfwUDAvp6zr0kIWCELwA9pk2vB92uplccqOz5MGDLA5YDamYSFdZwJEBPlM25dzkwPbwHLKOsakg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709901059; c=relaxed/simple;
	bh=S9r92EF9YDawhMvl/5KLi6FPSda8xf63QQBg3qAs0UQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C8JXyaJ2ZZtxUr/Yq8WmQMh8Ff8RvMWGxuUyjrjj4jEI464QDXlePNZaaWzXYjNwuukGQAPFOyYAkexrkmtlNHkPiSSUCQ8x1nbOMZZrUyAgGAEMa9ERRh8GIfwCXFRExyRXoFH4VGvXwWRa2uPrniH62U0HKxQu1jzWBnt3US0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F77EC433C7;
	Fri,  8 Mar 2024 12:30:56 +0000 (UTC)
Date: Fri, 8 Mar 2024 12:30:54 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Oliver Upton <oliver.upton@linux.dev>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
	Christoffer Dall <cdall@cs.columbia.edu>,
	Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>,
	Mark Brown <broonie@kernel.org>
Subject: Re: linux-next: manual merge of the kvm-arm tree with the arm64 tree
Message-ID: <ZesE_v3BrCrWq2PE@arm.com>
References: <20240308125433.134c0dbe@canb.auug.org.au>
 <ZeqvVtdca_I6ooYe@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZeqvVtdca_I6ooYe@linux.dev>

On Fri, Mar 08, 2024 at 06:25:26AM +0000, Oliver Upton wrote:
> On Fri, Mar 08, 2024 at 12:54:33PM +1100, Stephen Rothwell wrote:
> > Today's linux-next merge of the kvm-arm tree got a conflict in:
> > 
> >   arch/arm64/kernel/cpufeature.c
> > 
> > between commits:
> > 
> >   203f2b95a882 ("arm64/fpsimd: Support FEAT_FPMR")
> >   9cce9c6c2c3b ("arm64: mm: Handle LVA support as a CPU feature")
> >   352b0395b505 ("arm64: Enable 52-bit virtual addressing for 4k and 16k granule configs")
> >   2aea7b77aabc ("arm64: Use Signed/Unsigned enums for TGRAN{4,16,64} and VARange")
> > 
> > from the arm64 tree and commit:
> > 
> >   da9af5071b25 ("arm64: cpufeature: Detect HCR_EL2.NV1 being RES0")
> > 
> > from the kvm-arm tree.
> > 
> > I fixed it up (see below) and can carry the fix as necessary.
> 
> Thanks for reporting these Stephen. Fix looks good to me.
> 
> Catalin -- I think the conflicts are pretty simple here, but if we
> wanted to do something it'd probably be easiest if you pulled my
> kvm-arm64/feat_e2h0 branch. Looks like changes are coming from multiple
> topic branches in your tree.
> 
> No strong opinions either way, but I plan on sending the kvmarm PR
> tomorrow.

I'm happy to live with the conflicts really, Linus normally fixes those
at merge time.

-- 
Catalin


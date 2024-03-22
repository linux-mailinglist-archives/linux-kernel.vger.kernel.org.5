Return-Path: <linux-kernel+bounces-111732-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A919887011
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 16:55:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4CDDEB22C05
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 15:55:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C44BF56751;
	Fri, 22 Mar 2024 15:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sjwCIOQa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08CCC54919;
	Fri, 22 Mar 2024 15:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711122935; cv=none; b=S4kNedhZxs8MGJ4ZhMNUpfV+WuhTw5TJ+IkPi6pdG+F7SwAHEBnLOKsMdHR85DhuUuvQS1fwjV3mKgnQnPhuXcpMecrKWtqWnXHkpaeXIAvhBRBZmJ26OaNlNLveC1iDxFlXCapeoXYbYvf1USQrxMDIE9EdUDuyXiNktIFmBo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711122935; c=relaxed/simple;
	bh=KBxbC04wRzWWwKvLE9KMw4YX1znbdo8yfBBNgMOfrII=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QjbyfH83umUz8Xpq0fnYf6+J/mygtBJ0ayWSWYBH4gQdyd2BCrXp3sfbTDkxwD6v2gCSI+FVssr0KAHXtLm3LCWsbEugI9I3Aig+S5iB0vxKBOSfIVb63B+ZtZfz9vSZciwBMmKgn/BAdBMdyy0rCkYDty9ATDz7SQmH5Mee+jE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sjwCIOQa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDB1DC43390;
	Fri, 22 Mar 2024 15:55:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711122934;
	bh=KBxbC04wRzWWwKvLE9KMw4YX1znbdo8yfBBNgMOfrII=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sjwCIOQa4pcZ9lcWhOvJXf7sUt7tYQ0s7MDOdyVy7+NPkDN7E0HpkRFLsAeINXqP1
	 Qk020GAQ6KK+5cI572KTCPOfrW5YZcaHcSmNLBCK8f51BA5FCSsKSQpHnpP9iiyzJO
	 9ulMVTEY3wdUE8bqK90PrE4DFVp/J7LMBq5yJtipiWLHklZ5tWcxm/aXUGqb9ZWlRq
	 Jz3jIjiKH0nHLUJdLpFJEyc+Ji2LuRp5QGQrGK45C0bI66WQoupjR7jTejbxF24thL
	 oaHtxiYe0VExQdZhGS1LYIvfQe/Bc6Ct4fDRv/QvqUVJSwiq5xM34li0mnAhf8SmeM
	 8nA+ZSE9F/7Vg==
Date: Fri, 22 Mar 2024 15:55:29 +0000
From: Will Deacon <will@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Robin Murphy <robin.murphy@arm.com>, Tyler Hicks <code@tyhicks.com>,
	Jerry Snitselaar <jsnitsel@redhat.com>,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, Dexuan Cui <decui@microsoft.com>,
	Easwar Hariharan <eahariha@linux.microsoft.com>
Subject: Re: Why is the ARM SMMU v1/v2 put into bypass mode on kexec?
Message-ID: <20240322155529.GE5634@willie-the-truck>
References: <ZfKsAIt8RY/JcL/V@sequoia>
 <ZfNKv70oqqwMwIeS@sequoia>
 <120d0dec-450f-41f8-9e05-fd763e84f6dd@arm.com>
 <20240319154756.GB2901@willie-the-truck>
 <20240319175007.GC66976@ziepe.ca>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240319175007.GC66976@ziepe.ca>
User-Agent: Mutt/1.10.1 (2018-07-13)

Hey Jason,

On Tue, Mar 19, 2024 at 02:50:07PM -0300, Jason Gunthorpe wrote:
> On Tue, Mar 19, 2024 at 03:47:56PM +0000, Will Deacon wrote:
> 
> > Right, it's hard to win if DMA-active devices weren't quiesced properly
> > by the outgoing kernel. Either the SMMU was left in abort (leading to the
> > problems you list above) or the SMMU is left in bypass (leading to possible
> > data corruption). Which is better?
> 
> For whatever reason (and I really don't like this design) alot of work
> was done on x86 so that device continues to work as-was right up until
> the crash kernel does the first DMA operation. Including having the
> crash kernel non disruptively inherit and retain the IOMMU
> configuration. (eg see translation_pre_enabled() stuff in intel
> driver)

Right, I'm also not thrilled about trying to implement that :)
What we have at the moment seems to be good enough to avoid folks
complaining about it.

For the case Tyler is reporting, though, I _think_ it's just a standard
kexec() rather than a crashkernel.

Will


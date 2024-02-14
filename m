Return-Path: <linux-kernel+bounces-64934-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CF6CB8544D4
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 10:16:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53A4F1F25576
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 09:16:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D7C211716;
	Wed, 14 Feb 2024 09:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cSspDhts"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7483A2F2F;
	Wed, 14 Feb 2024 09:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707902184; cv=none; b=Bw28pSwvyRlCfa8+fQEnVHvzhAt3+03MkE0OGM+xQQj3JWvLXMnKkcXWqvmj6PCk33bYHFEarbBHEZjCoZuZSI3gNfHOk/w7maVLAeHP/QREQsc2wV6MWvOkBr6+TgoOQwzTRanBrGk/esLhFT74/n3YCB+Lzq0La24fJ5LL0kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707902184; c=relaxed/simple;
	bh=PoGYFcOFFkj9oOeE16Nie+zQv1wodqinpX/UuF65zXA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dhuloVYUEksn69BNd6Z5s4jHTQAraVDu8AkPWEn8q+dJgKpY9YIptFNJ5K81MyuP6ojhv9b2C1W7xXHA/+VM17Uni/EdQZLogllAaLHgb6saWWnsItvR+Zyh8kg//W/0lD69Z87v0H60eMiziJDfBu1uKUossg2TiPReBuTdaGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cSspDhts; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE697C433C7;
	Wed, 14 Feb 2024 09:16:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707902183;
	bh=PoGYFcOFFkj9oOeE16Nie+zQv1wodqinpX/UuF65zXA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cSspDhts8XThLBU3SI2dYn63nWVUKuUwLCiIYS6E01ECt1s0v+6zlXix2bO1hm1z5
	 24ny+psf5PHItrEDLL3eAa9T8OhXKVvbJ9Zfr0FBCKtO/QenxM6ZjzhsvaNnlDO+tu
	 JOuDmSfme2BKqexzspU/16ykdI6ZVP65S4DbqWvsAouCc2CdVJwtlNkAhS2DDidsY3
	 HnIsSKYeATcGyk3qraYK1GYnxlbAfo9dF0bvRznPoeC15TZ/XtPrOaMOQdykOtPoO6
	 yXbz/wOPhPXqfecKlhRasNayhLWK4X5dl7KlVQEGlLWGq+shZQhtKrA0mPvqf1KXYm
	 kwTIoIGl6WwXA==
Date: Wed, 14 Feb 2024 11:15:56 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: "Aiqun Yu (Maria)" <quic_aiquny@quicinc.com>,
	Vijayanand Jitta <quic_vjitta@quicinc.com>,
	Faiyaz Mohammed <quic_faiyazm@quicinc.com>, karahmed@amazon.de,
	qperret@google.com, robh@kernel.org, akpm@linux-foundation.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	robh+dt@kernel.org, frowand.list@gmail.com,
	devicetree@vger.kernel.org
Subject: Re: [PATCH] mm: memblock: avoid to create memmap for memblock nomap
 regions
Message-ID: <ZcyEzHva7pq-3Zav@kernel.org>
References: <YlW2TO0O8qDHpkGW@kernel.org>
 <7b18bea8-b996-601d-f490-cb8aadfffa1b@quicinc.com>
 <YnQBKPWtPa87y4NA@kernel.org>
 <42f28e7b-c001-7d01-1eb6-fe963491898e@quicinc.com>
 <Ynj+M9cRm6zdCMMi@kernel.org>
 <22aca197-8d18-2c9e-b3c4-f6fdc893ceb1@quicinc.com>
 <Yu1t8TpXT1f372v/@kernel.org>
 <76cb3b37-5887-404f-95b7-10a22a7ba65b@quicinc.com>
 <ZcxvKvSfJv6L2O9e@kernel.org>
 <CAA8EJpqpGN6yzd5pUs06aax=L5wDwPK6aM6R2X784y7ot+P-aQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA8EJpqpGN6yzd5pUs06aax=L5wDwPK6aM6R2X784y7ot+P-aQ@mail.gmail.com>

On Wed, Feb 14, 2024 at 10:11:40AM +0200, Dmitry Baryshkov wrote:
> On Wed, 14 Feb 2024 at 09:44, Mike Rapoport <rppt@kernel.org> wrote:
> >
> > On Thu, Feb 08, 2024 at 02:37:25PM +0800, Aiqun Yu (Maria) wrote:
> > >
> > > On 8/6/2022 3:22 AM, Mike Rapoport wrote:
> > > > Hi Vijay,
> > > >
> > > > On Wed, Aug 03, 2022 at 04:27:33PM +0530, Vijayanand Jitta wrote:
> > > > >
> > > > > On 5/9/2022 5:12 PM, Mike Rapoport wrote:
> > > > > > On Mon, May 09, 2022 at 04:37:30PM +0530, Faiyaz Mohammed wrote:
> > > > > > >
> > > > > > > On 5/5/2022 10:24 PM, Mike Rapoport wrote:
> > > > > > > > On Thu, May 05, 2022 at 08:46:15PM +0530, Faiyaz Mohammed wrote:
> > > > > > > > > On 4/12/2022 10:56 PM, Mike Rapoport wrote:
> > > > > > > > > > On Tue, Apr 12, 2022 at 12:39:32AM +0530, Faiyaz Mohammed wrote:
> > > > > > > > > > > This 'commit 86588296acbf ("fdt: Properly handle "no-map" field in the
> > > > > > > > > > > memory region")' is keeping the no-map regions in memblock.memory with
> > > > > > > > > > > MEMBLOCK_NOMAP flag set to use no-map memory for EFI using memblock api's,
> > > > > > > > > > > but during the initialization sparse_init mark all memblock.memory as
> > > > > > > > > > > present using for_each_mem_pfn_range, which is creating the memmap for
> > > > > > > > > > > no-map memblock regions. To avoid it skiping the memblock.memory regions
> > > > > > > > > > > set with MEMBLOCK_NOMAP set and with this change we will be able to save
> > > > > > > > > > > ~11MB memory for ~612MB carve out.
> > > > > > > > > > The MEMBLOCK_NOMAP is very fragile and caused a lot of issues already. I
> > > > > > > > > > really don't like the idea if adding more implicit assumptions about how
> > > > > > > > > > NOMAP memory may or may not be used in a generic iterator function.
> > > > > > > > > Sorry for delayed response.
> > > > > > > > > Yes, it is possible that implicit assumption can create
> > > > > > > > > misunderstanding. How about adding command line option and control the
> > > > > > > > > no-map region in fdt.c driver, to decide whether to keep "no-map" region
> > > > > > > > > with NOMAP flag or remove?. Something like below
> > > > > > > > I really don't like memblock_remove() for such cases.
> > > > > > > > Pretending there is a hole when there is an actual DRAM makes things really
> > > > > > > > hairy when it comes to memory map and page allocator initialization.
> > > > > > > > You wouldn't want to trade system stability and random memory corruptions
> > > > > > > > for 11M of "saved" memory.
> > > > > > >
> > > > > > > Creating memory map for holes memory is adding 11MB overhead which is
> > > > > > > huge on low memory target and same time 11MB memory saving is good enough
> > > > > > > on low memory target.
> > > > > > >
> > > > > > > Or we can have separate list of NOMAP like reserved?.
> > > > > > >
> > > > > > > Any other suggestion to address this issue?.
> > > > > >
> > > > > > Make your firmware to report the memory that Linux cannot use as a hole,
> > > > > > i.e. _not_ report it as memory.
> > > > >
> > > > > Thanks, Mike for the comments.
> > > > >
> > > > > Few concerns with this approach.
> > > > >
> > > > > 1) One concern is, even if firmware doesn't report these regions as
> > > > > memory, we would need addresses for these to be part of device tree so
> > > > > that the clients would be able to get these addresses. Otherwise there
> > > > > is no way for client to know these addresses.
> > > > >
> > > > > 2) This would also add a dependency on firmware to be able to pass these
> > > > > regions not as memory, though we know that these regions would be used
> > > > > by the clients. Isn't it better to have such control within the kernel ?
> > > >
> > > > If it is memory that is used by the kernel it should be reported as memory
> > > > and have the memory map.
> > > > If this is a hole in the memory layout from the kernel perspective, then
> > > > kernel should not bother with this memory.
> > > Hi Mike,
> > >
> > > We've put effort on bootloader side to implement the similar suggestion of
> > > os bootloader to convey the reserved memory by omit the hole from
> > > /memory@0{reg=[]} directly.
> > > While there is a concern from device tree spec perspective, link [1]: "A
> > > memory device node is required for all devicetrees and describes the
> > > physical memory layout for the system. "
> > > Do you have any idea on this pls?
> >
> > I'm not sure I understand your concern. Isn't there a /memory node that
> > describes the memory available to Linux in your devicetree?
> 
> That was the question. It looks like your opinion on /memory was that
> it describes "memory available to Linux", while device tree spec
> defines it as "physical memory layout".
 
I suggested a workaround that will allow to save memory map for the
carveout.
The memory map is a run time description of the physical memory layout and
core mm relies on availability of struct page for every physical frame.
Having only partial memory map will lead to subtle bugs and crashes, so
it's not an option.

> > > [1] https://github.com/devicetree-org/devicetree-specification/blob/main/source/chapter3-devicenodes.rst
> 
> -- 
> With best wishes
> Dmitry

-- 
Sincerely yours,
Mike.


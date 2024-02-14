Return-Path: <linux-kernel+bounces-64843-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98BDF854394
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 08:44:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD0C01C21B04
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 07:44:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9E76125A7;
	Wed, 14 Feb 2024 07:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gkj581Sl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E60C6125A1;
	Wed, 14 Feb 2024 07:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707896646; cv=none; b=O1To5RYFC8yHe9xpZW6YZcExqo/ChX/9j/jWMaPlFwIP0h8+X18uLCQL3a5HZs2hHqd3sCH5Wa3tr41arGcrvcw7tOOxmdYpgj8z9dVrFH0JjFvykXU53Iekcm8SBEXrag6YB0VLKHQ2/PkE4DlnjFwZFxijVUljwL90o1Hm9LI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707896646; c=relaxed/simple;
	bh=tb1JZh7YjHC54vuRohUqN9Z1NIGc0/Pz/uPDjKWR0AA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TBUneuR8UskzEDHHgTbdv1K7oFMRM6O3SjyUO+r6dD/JOWGiN5YUwqxjsoLb7/6QxQRKpFuwuhNMdzA1YsXgHsmlQ5klmgtMeKDGEYtyK5FieJMPiLnX0EWWlrnqZXSDldLO3b8l6s7+S3jAcMJ01WduEEc03imKiI3BQ63BZR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gkj581Sl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45C7EC43390;
	Wed, 14 Feb 2024 07:44:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707896645;
	bh=tb1JZh7YjHC54vuRohUqN9Z1NIGc0/Pz/uPDjKWR0AA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Gkj581SlUmdpPMZleIyFmicCmLzpseArp1VO3FbpTvalrb33rZVCKkDHZtuq/nAaf
	 XaAolWXwCCjSX/F7lBpKqtbn+N2s4EueUjdUjvyA6oQR3GrQ2Tz/PWLdkU04LJ6T3x
	 z/CmSTaC74QZYNBwEOWmEX+t852/xRcLGSlPaRwEZyzkiiuJilAuBy33fdEik6xyrC
	 n86DNuYeokTk7Mu7J5wiguwnxbaFQrkj35GRKx4Y4XHEDgV7iKQ5Iy/yj9t0PiRtph
	 yEOzSX0374cLbyBsENoEf07VqfuxQiuQV7pnUBd+VU4pz/W4vDjGWli18+OotbSOyq
	 xAmwFPGgvplqA==
Date: Wed, 14 Feb 2024 09:43:38 +0200
From: Mike Rapoport <rppt@kernel.org>
To: "Aiqun Yu (Maria)" <quic_aiquny@quicinc.com>
Cc: Vijayanand Jitta <quic_vjitta@quicinc.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Faiyaz Mohammed <quic_faiyazm@quicinc.com>, karahmed@amazon.de,
	qperret@google.com, robh@kernel.org, akpm@linux-foundation.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	robh+dt@kernel.org, frowand.list@gmail.com,
	devicetree@vger.kernel.org
Subject: Re: [PATCH] mm: memblock: avoid to create memmap for memblock nomap
 regions
Message-ID: <ZcxvKvSfJv6L2O9e@kernel.org>
References: <1649704172-13181-1-git-send-email-quic_faiyazm@quicinc.com>
 <YlW2TO0O8qDHpkGW@kernel.org>
 <7b18bea8-b996-601d-f490-cb8aadfffa1b@quicinc.com>
 <YnQBKPWtPa87y4NA@kernel.org>
 <42f28e7b-c001-7d01-1eb6-fe963491898e@quicinc.com>
 <Ynj+M9cRm6zdCMMi@kernel.org>
 <22aca197-8d18-2c9e-b3c4-f6fdc893ceb1@quicinc.com>
 <Yu1t8TpXT1f372v/@kernel.org>
 <76cb3b37-5887-404f-95b7-10a22a7ba65b@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <76cb3b37-5887-404f-95b7-10a22a7ba65b@quicinc.com>

On Thu, Feb 08, 2024 at 02:37:25PM +0800, Aiqun Yu (Maria) wrote:
> 
> On 8/6/2022 3:22 AM, Mike Rapoport wrote:
> > Hi Vijay,
> > 
> > On Wed, Aug 03, 2022 at 04:27:33PM +0530, Vijayanand Jitta wrote:
> > > 
> > > On 5/9/2022 5:12 PM, Mike Rapoport wrote:
> > > > On Mon, May 09, 2022 at 04:37:30PM +0530, Faiyaz Mohammed wrote:
> > > > > 
> > > > > On 5/5/2022 10:24 PM, Mike Rapoport wrote:
> > > > > > On Thu, May 05, 2022 at 08:46:15PM +0530, Faiyaz Mohammed wrote:
> > > > > > > On 4/12/2022 10:56 PM, Mike Rapoport wrote:
> > > > > > > > On Tue, Apr 12, 2022 at 12:39:32AM +0530, Faiyaz Mohammed wrote:
> > > > > > > > > This 'commit 86588296acbf ("fdt: Properly handle "no-map" field in the
> > > > > > > > > memory region")' is keeping the no-map regions in memblock.memory with
> > > > > > > > > MEMBLOCK_NOMAP flag set to use no-map memory for EFI using memblock api's,
> > > > > > > > > but during the initialization sparse_init mark all memblock.memory as
> > > > > > > > > present using for_each_mem_pfn_range, which is creating the memmap for
> > > > > > > > > no-map memblock regions. To avoid it skiping the memblock.memory regions
> > > > > > > > > set with MEMBLOCK_NOMAP set and with this change we will be able to save
> > > > > > > > > ~11MB memory for ~612MB carve out.
> > > > > > > > The MEMBLOCK_NOMAP is very fragile and caused a lot of issues already. I
> > > > > > > > really don't like the idea if adding more implicit assumptions about how
> > > > > > > > NOMAP memory may or may not be used in a generic iterator function.
> > > > > > > Sorry for delayed response.
> > > > > > > Yes, it is possible that implicit assumption can create
> > > > > > > misunderstanding. How about adding command line option and control the
> > > > > > > no-map region in fdt.c driver, to decide whether to keep "no-map" region
> > > > > > > with NOMAP flag or remove?. Something like below
> > > > > > I really don't like memblock_remove() for such cases.
> > > > > > Pretending there is a hole when there is an actual DRAM makes things really
> > > > > > hairy when it comes to memory map and page allocator initialization.
> > > > > > You wouldn't want to trade system stability and random memory corruptions
> > > > > > for 11M of "saved" memory.
> > > > > 
> > > > > Creating memory map for holes memory is adding 11MB overhead which is
> > > > > huge on low memory target and same time 11MB memory saving is good enough
> > > > > on low memory target.
> > > > > 
> > > > > Or we can have separate list of NOMAP like reserved?.
> > > > > 
> > > > > Any other suggestion to address this issue?.
> > > > 
> > > > Make your firmware to report the memory that Linux cannot use as a hole,
> > > > i.e. _not_ report it as memory.
> > > 
> > > Thanks, Mike for the comments.
> > > 
> > > Few concerns with this approach.
> > > 
> > > 1) One concern is, even if firmware doesn't report these regions as
> > > memory, we would need addresses for these to be part of device tree so
> > > that the clients would be able to get these addresses. Otherwise there
> > > is no way for client to know these addresses.
> > > 
> > > 2) This would also add a dependency on firmware to be able to pass these
> > > regions not as memory, though we know that these regions would be used
> > > by the clients. Isn't it better to have such control within the kernel ?
> > 
> > If it is memory that is used by the kernel it should be reported as memory
> > and have the memory map.
> > If this is a hole in the memory layout from the kernel perspective, then
> > kernel should not bother with this memory.
> Hi Mike,
> 
> We've put effort on bootloader side to implement the similar suggestion of
> os bootloader to convey the reserved memory by omit the hole from
> /memory@0{reg=[]} directly.
> While there is a concern from device tree spec perspective, link [1]: "A
> memory device node is required for all devicetrees and describes the
> physical memory layout for the system. "
> Do you have any idea on this pls?

I'm not sure I understand your concern. Isn't there a /memory node that
describes the memory available to Linux in your devicetree?
 
> [1] https://github.com/devicetree-org/devicetree-specification/blob/main/source/chapter3-devicenodes.rst
> > 
> > And I'm not buying "low memory target" argument if you have enough memory
> > to carve out ~600M for some mysterious clients.
>
> Just for your information, for low memory target, the carve out can be more
> than ~60M out of 128M in total.

If saving ~1M of memory map is important, hide the carve out from Linux
entirely.

> > > Let me know your comments on these.
> > > 
> > > Thanks,
> > > Vijay
> 
> -- 
> Thx and BRs,
> Aiqun(Maria) Yu

-- 
Sincerely yours,
Mike.


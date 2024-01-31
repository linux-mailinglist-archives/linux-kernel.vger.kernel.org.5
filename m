Return-Path: <linux-kernel+bounces-45511-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 860AA8431AA
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 01:07:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DAAFBB21877
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 00:07:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48462384;
	Wed, 31 Jan 2024 00:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WDMKUIkl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40B4F360;
	Wed, 31 Jan 2024 00:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706659633; cv=none; b=Xb7RUq+TKO0EXid9YkwQdR6HL2coXuKOESuYwMHEGd6LPD7bv+jcvaYuwvtb/DbO9BAtmR05EIXIb/7tmqs2Ph6U7XmlYDowmw77QGcAJ4ozUuvBUh1WgZ3R7tp+TJEW5QKs9BjiXeXm5E0jm0S2oljIH5K7TT/60b4pKE3hTfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706659633; c=relaxed/simple;
	bh=4IQeU0aHdZ9OyJPsxqDoj0X2DZjWXfdHf5qWMKXFsBo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GEAFPoF2Angba35fqbCTCidMYuwv+llRaEMA3oxwMTOaX9KxQhH8F6C5VL5zsZHuBtM8F95ZuhmnDHus+DIyXLViae5k3yEjFRI13tRLGgqfJtxpIyPB+yVGWZmZJl/+FlPYri7L9AjPyG970Eex9EjfmbE5xdJl8wwpC/EyxrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WDMKUIkl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67E6CC433C7;
	Wed, 31 Jan 2024 00:07:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706659632;
	bh=4IQeU0aHdZ9OyJPsxqDoj0X2DZjWXfdHf5qWMKXFsBo=;
	h=Date:From:To:List-Id:Cc:Subject:References:In-Reply-To:From;
	b=WDMKUIklvJcm6EcsZNKAPY/tr3zImhMVxuK+6CQzXx3/bqkePR8l3BDVDP05wgtfd
	 z8mNxq0EX9GgXIKa2en2de4C47Jl93ypnNnPJ2jL++MIrU05hBGDyWv7CFgOblKvSz
	 Hzo5RMVvFMnisIj9crEhIxJjUGLQBoeFMID/wXovHe38dXqecSLRKKnWZNQ3UM6ggp
	 PwgoZxxh3NF8D08IYo9SPpvoWmN9SbsoCuTe1Ag9FO2iPadbzNzRRLbw+uCrM0ULrX
	 5JOCzJO5UhFvn6RNC0O6HcwaHNqn/0Tkfu7Xo8KTSA2xWaof7iuOx0RV7OG08cP5/C
	 V1L92SX9fU73Q==
Date: Tue, 30 Jan 2024 18:07:10 -0600
From: Rob Herring <robh@kernel.org>
To: Oreoluwa Babatunde <quic_obabatun@quicinc.com>
Cc: catalin.marinas@arm.com, will@kernel.org, frowand.list@gmail.com,
	vgupta@kernel.org, arnd@arndb.de, olof@lixom.net, soc@kernel.org,
	guoren@kernel.org, monstr@monstr.eu, palmer@dabbelt.com,
	aou@eecs.berkeley.edu, dinguyen@kernel.org, chenhuacai@kernel.org,
	tsbogend@alpha.franken.de, jonas@southpole.se,
	stefan.kristiansson@saunalahti.fi, shorne@gmail.com,
	mpe@ellerman.id.au, ysato@users.sourceforge.jp, dalias@libc.org,
	glaubitz@physik.fu-berlin.de, richard@nod.at,
	anton.ivanov@cambridgegreys.com, johannes@sipsolutions.net,
	chris@zankel.net, jcmvbkbc@gmail.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	kernel@quicinc.com
Subject: Re: [PATCH 00/46] Dynamic allocation of reserved_mem array.
Message-ID: <20240131000710.GA2581425-robh@kernel.org>
References: <20240126235425.12233-1-quic_obabatun@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240126235425.12233-1-quic_obabatun@quicinc.com>

On Fri, Jan 26, 2024 at 03:53:39PM -0800, Oreoluwa Babatunde wrote:
> The reserved_mem array is used to store data for the different
> reserved memory regions defined in the DT of a device.  The array
> stores information such as region name, node, start-address, and size
> of the reserved memory regions.
> 
> The array is currently statically allocated with a size of
> MAX_RESERVED_REGIONS(64). This means that any system that specifies a
> number of reserved memory regions greater than MAX_RESERVED_REGIONS(64)
> will not have enough space to store the information for all the regions.
> 
> Therefore, this series extends the use of the static array for
> reserved_mem, and introduces a dynamically allocated array using
> memblock_alloc() based on the number of reserved memory regions
> specified in the DT.
> 
> Some architectures such as arm64 require the page tables to be setup
> before memblock allocated memory is writable.  Therefore, the dynamic
> allocation of the reserved_mem array will need to be done after the
> page tables have been setup on these architectures. In most cases that
> will be after paging_init().
> 
> Reserved memory regions can be divided into 2 groups.
> i) Statically-placed reserved memory regions
> i.e. regions defined in the DT using the @reg property.
> ii) Dynamically-placed reserved memory regions.
> i.e. regions specified in the DT using the @alloc_ranges
>     and @size properties.
> 
> It is possible to call memblock_reserve() and memblock_mark_nomap() on
> the statically-placed reserved memory regions and not need to save them
> to the reserved_mem array until memory is allocated for it using
> memblock, which will be after the page tables have been setup.
> For the dynamically-placed reserved memory regions, it is not possible
> to wait to store its information because the starting address is
> allocated only at run time, and hence they need to be stored somewhere
> after they are allocated.
> Waiting until after the page tables have been setup to allocate memory
> for the dynamically-placed regions is also not an option because the
> allocations will come from memory that have already been added to the
> page tables, which is not good for memory that is supposed to be
> reserved and/or marked as nomap.
> 
> Therefore, this series splits up the processing of the reserved memory
> regions into two stages, of which the first stage is carried out by
> early_init_fdt_scan_reserved_mem() and the second is carried out by
> fdt_init_reserved_mem().
> 
> The early_init_fdt_scan_reserved_mem(), which is called before the page
> tables are setup is used to:
> 1. Call memblock_reserve() and memblock_mark_nomap() on all the
>    statically-placed reserved memory regions as needed.
> 2. Allocate memory from memblock for the dynamically-placed reserved
>    memory regions and store them in the static array for reserved_mem.
>    memblock_reserve() and memblock_mark_nomap() are also called as
>    needed on all the memory allocated for the dynamically-placed
>    regions.
> 3. Count the total number of reserved memory regions found in the DT.
> 
> fdt_init_reserved_mem(), which should be called after the page tables
> have been setup, is used to carry out the following:
> 1. Allocate memory for the reserved_mem array based on the number of
>    reserved memory regions counted as mentioned above.
> 2. Copy all the information for the dynamically-placed reserved memory
>    regions from the static array into the new allocated memory for the
>    reserved_mem array.
> 3. Add the information for the statically-placed reserved memory into
>    reserved_mem array.
> 4. Run the region specific init functions for each of the reserve memory
>    regions saved in the reserved_mem array.

I don't see the need for fdt_init_reserved_mem() to be explicitly called 
by arch code. I said this already, but that can be done at the same time 
as unflattening the DT. The same conditions are needed for both: we need 
to be able to allocate memory from memblock.

To put it another way, if fdt_init_reserved_mem() can be called "early", 
then unflattening could be moved earlier as well. Though I don't think 
we should optimize that. I'd rather see all arches call the DT functions 
at the same stages.

> Once the above steps have been completed and the init process is done
> running, the original statically allocated reserved_mem array of size
> MAX_RESERVED_REGIONS(64) will be automatically freed back to buddy
> because it is no longer needed. This is done by marking the array as an
> "__initdata" object in Patch 0018.
> 
> Note:
> 
> - Per Architecture, this series is effectively only 10 patches. The
>   code for each architecture is split up into separate patches to
>   allow each architecture to be tested independently of changes from
>   other architectures. Should this series be accepted, this should
>   allow for each arcitecture change to be picked up independently as
>   well.

Only if patches 1 and 2 are accepted in one cycle and the arch ones in 
the next cycle. No need for that though, I can take the whole thing 
(when it's ready).


> 
>   Patch 0001: Splits up the processing of the reserved memory regions
>   between early_init_fdt_scan_reserved_mem and fdt_init_reserved_mem.
> 
>   Patch 0002: Introduces a copy of early_init_fdt_scan_reserved_mem()
>   which is used to separate it from fdt_init_reserved_mem() so that the
>   two functions can be called independently of each other.
> 
>   Patch 0003 - Patch 0016: Duplicated change for each architecture to
>   call early_init_fdt_scan_reserved_mem() and fdt_init_reserved_mem()
>   at their appropriate locations. Here fdt_init_reserved_mem() is called
>   either before of after the page tables have been setup depending on
>   the architecture requirements.
> 
>   Patch 0017: Deletes the early_init_fdt_scan_reserved_mem() function
>   since all architectures are now using the copy introduced in
>   Patch 0002.
> 
>   Patch 0018: Dynamically allocate memory for the reserved_mem array
>   based on the total number of reserved memory regions specified in the
>   DT.
> 
>   Patch 0019 - Patch 0029: Duplicated change for each architecture to
>   move the fdt_init_reserved_mem() function call to below the
>   unflatten_devicetree() function call. This is so that the unflatten
>   devicetree APIs can be used to process the reserved memory regions.
> 
>   Patch 0030: Make code changes to start using the unflatten devicetree
>   APIs to access the reserved memory regions defined in the DT.
> 
>   Patch 0031: Rename fdt_* functions as dt_* to refelct that the
>   flattened devicetree (fdt) APIs have been replaced with the unflatten
>   devicetree APIs.
> 
>   Patch 0032 - Patch 0045: Duplicated change for each architecture to
>   switch from the use of fdt_init_reserved_mem() to
>   dt_init_reserved_mem(), which is the same function but the later uses
>   the unflatten devicetree APIs.
> 
>   Patch 0046: Delete the fdt_init_reserved_mem() function as all
>   architectures have switched to using dt_init_reserved_mem() which was
>   introduced in Patch 0031.
> 
> - The limitation to this approach is that there is still a limit of
>   64 for dynamically-placed reserved memory regions. But from my current
>   analysis, these types of reserved memory regions are generally less
>   in number when compared to the statically-placed reserved memory
>   regions.
> 
> - I have looked through all architectures and placed the call to
>   memblock_alloc() for the reserved_mem array at points where I
>   believe memblock allocated memory are available to be written to.
>   I currently only have access to an arm64 device and this is where I am
>   testing the functionality of this series. Hence, I will need help from
>   architecture maintainers to test this series on other architectures to
>   ensure that the code is functioning properly on there.
> 
> Previous patch revisions:
> 1. [RFC V1 Patchset]:
> https://lore.kernel.org/all/20231019184825.9712-1-quic_obabatun@quicinc.com/
> 
> 2. [RFC V2 Patchset]:
> https://lore.kernel.org/all/20231204041339.9902-1-quic_obabatun@quicinc.com/
> - Extend changes to all other relevant architectures.
> - Add code to use unflatten devicetree APIs to process the reserved
>   memory regions.

Dropping RFC does not make this v1. RFC is a state of the patches not a 
version.

Rob


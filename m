Return-Path: <linux-kernel+bounces-48786-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CC28846153
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 20:47:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6B011F22F4E
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 19:47:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D08C43AC7;
	Thu,  1 Feb 2024 19:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T4NU3UIl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24FC48527E;
	Thu,  1 Feb 2024 19:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706816816; cv=none; b=l0oxrd7C6a3BDNGQyvmqOML99KvbmCjf874Ie98Up3zWBPEQ40RW9UNfxc/N/W6RxmEKK4hK+s3c1mQkJQP6O0CbHbccXKMuaHilL8ayQOacWTkjcNKFe/pPA3BCDhh9s3EpiEcYU8l8Xe/4B8PgVsVGMFbxgPVlB7C8gai0A3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706816816; c=relaxed/simple;
	bh=NluyzrHFJsYNvLhJgJPTCWrHJBLx84eu5Yc7tv6NdP8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BQMO+EMcVHLpr+kJdAQ6MEQNAskqYQ5rkc5VrFbA9NggRAqaObcDeN6I/DS1YRdvG6lewa/H80LnnJBzMb4Cc+hAj3jKy1MXh1Bem499RMMxwIpurwO+gmrpIvjq9BYkSxyH4X/r1wG6uCmbvx14ZeaGytbPBPIByO5mzFk9y4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T4NU3UIl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABBA3C433C7;
	Thu,  1 Feb 2024 19:46:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706816816;
	bh=NluyzrHFJsYNvLhJgJPTCWrHJBLx84eu5Yc7tv6NdP8=;
	h=Date:From:To:List-Id:Cc:Subject:References:In-Reply-To:From;
	b=T4NU3UIlM1yr+qTOCCKoiaBmecBzqwjhDsUDKKQwDXegVSiTzT4u93i4V0r05/oOt
	 WrU08x09BR4nnTHx75FSy7F3xQv0GCOi4N3w2AsiV7UQPq+k3Y/oVCrU1MevvLjagN
	 MkHloj+q0gmFbskns+0RbtSagyFVpOgqzM57P9RgbfURZwUB7JonoMU/HOCsp3JpSt
	 PkNpKRk5BiNCgG6Lli1LKnwAecI4fl6z8BCb5MbBXP9imx8xOw/GCzNR68KhTFS66J
	 miQS6CsBSkb9plo8F8PDoJ8UOV+kTk2nEL1vsEUhsw8rrjYTuVJ8Ua22N2EKOAJgcF
	 NhcqtlrryMi+Q==
Date: Thu, 1 Feb 2024 13:46:53 -0600
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
Message-ID: <20240201194653.GA1328565-robh@kernel.org>
References: <20240126235425.12233-1-quic_obabatun@quicinc.com>
 <20240131000710.GA2581425-robh@kernel.org>
 <51dc64bb-3101-4b4a-a54f-c0df6c0b264c@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <51dc64bb-3101-4b4a-a54f-c0df6c0b264c@quicinc.com>

On Thu, Feb 01, 2024 at 09:08:06AM -0800, Oreoluwa Babatunde wrote:
> 
> On 1/30/2024 4:07 PM, Rob Herring wrote:
> > On Fri, Jan 26, 2024 at 03:53:39PM -0800, Oreoluwa Babatunde wrote:
> >> The reserved_mem array is used to store data for the different
> >> reserved memory regions defined in the DT of a device.  The array
> >> stores information such as region name, node, start-address, and size
> >> of the reserved memory regions.
> >>
> >> The array is currently statically allocated with a size of
> >> MAX_RESERVED_REGIONS(64). This means that any system that specifies a
> >> number of reserved memory regions greater than MAX_RESERVED_REGIONS(64)
> >> will not have enough space to store the information for all the regions.
> >>
> >> Therefore, this series extends the use of the static array for
> >> reserved_mem, and introduces a dynamically allocated array using
> >> memblock_alloc() based on the number of reserved memory regions
> >> specified in the DT.
> >>
> >> Some architectures such as arm64 require the page tables to be setup
> >> before memblock allocated memory is writable.  Therefore, the dynamic
> >> allocation of the reserved_mem array will need to be done after the
> >> page tables have been setup on these architectures. In most cases that
> >> will be after paging_init().
> >>
> >> Reserved memory regions can be divided into 2 groups.
> >> i) Statically-placed reserved memory regions
> >> i.e. regions defined in the DT using the @reg property.
> >> ii) Dynamically-placed reserved memory regions.
> >> i.e. regions specified in the DT using the @alloc_ranges
> >>     and @size properties.
> >>
> >> It is possible to call memblock_reserve() and memblock_mark_nomap() on
> >> the statically-placed reserved memory regions and not need to save them
> >> to the reserved_mem array until memory is allocated for it using
> >> memblock, which will be after the page tables have been setup.
> >> For the dynamically-placed reserved memory regions, it is not possible
> >> to wait to store its information because the starting address is
> >> allocated only at run time, and hence they need to be stored somewhere
> >> after they are allocated.
> >> Waiting until after the page tables have been setup to allocate memory
> >> for the dynamically-placed regions is also not an option because the
> >> allocations will come from memory that have already been added to the
> >> page tables, which is not good for memory that is supposed to be
> >> reserved and/or marked as nomap.
> >>
> >> Therefore, this series splits up the processing of the reserved memory
> >> regions into two stages, of which the first stage is carried out by
> >> early_init_fdt_scan_reserved_mem() and the second is carried out by
> >> fdt_init_reserved_mem().
> >>
> >> The early_init_fdt_scan_reserved_mem(), which is called before the page
> >> tables are setup is used to:
> >> 1. Call memblock_reserve() and memblock_mark_nomap() on all the
> >>    statically-placed reserved memory regions as needed.
> >> 2. Allocate memory from memblock for the dynamically-placed reserved
> >>    memory regions and store them in the static array for reserved_mem.
> >>    memblock_reserve() and memblock_mark_nomap() are also called as
> >>    needed on all the memory allocated for the dynamically-placed
> >>    regions.
> >> 3. Count the total number of reserved memory regions found in the DT.
> >>
> >> fdt_init_reserved_mem(), which should be called after the page tables
> >> have been setup, is used to carry out the following:
> >> 1. Allocate memory for the reserved_mem array based on the number of
> >>    reserved memory regions counted as mentioned above.
> >> 2. Copy all the information for the dynamically-placed reserved memory
> >>    regions from the static array into the new allocated memory for the
> >>    reserved_mem array.
> >> 3. Add the information for the statically-placed reserved memory into
> >>    reserved_mem array.
> >> 4. Run the region specific init functions for each of the reserve memory
> >>    regions saved in the reserved_mem array.
> > I don't see the need for fdt_init_reserved_mem() to be explicitly called 
> > by arch code. I said this already, but that can be done at the same time 
> > as unflattening the DT. The same conditions are needed for both: we need 
> > to be able to allocate memory from memblock.
> >
> > To put it another way, if fdt_init_reserved_mem() can be called "early", 
> > then unflattening could be moved earlier as well. Though I don't think 
> > we should optimize that. I'd rather see all arches call the DT functions 
> > at the same stages.
> Hi Rob,
> 
> The reason we moved fdt_init_reserved_mem() back into the arch specific code
> was because we realized that there was no apparently obvious way to call
> early_init_fdt_scan_reserved_mem() and fdt_init_reserved_mem() in the correct
> order that will work for all archs if we placed fdt_init_reserved_mem() inside the
> unflatten_devicetree() function.
> 
> early_init_fdt_scan_reserved_mem() needs to be
> called first before fdt_init_reserved_mem(). But on some archs,
> unflatten_devicetree() is called before early_init_fdt_scan_reserved_mem(), which
> means that if we have fdt_init_reserved_mem() inside the unflatten_devicetree()
> function, it will be called before early_init_fdt_scan_reserved_mem().
> 
> This is connected to your other comments on Patch 7 & Patch 14.
> I agree, unflatten_devicetree() should NOT be getting called before we reserve
> memory for the reserved memory regions because that could cause memory to be
> allocated from regions that should be reserved.
> 
> Hence, resolving this issue should allow us to call fdt_init_reserved_mem() from
> the  unflatten_devicetree() function without it changing the order that we are
> trying to have.

There's one issue I've found which is unflatten_device_tree() isn't 
called for ACPI case on arm64. Turns out we need /reserved-memory 
handled in that case too. However, I think we're going to change 
calling unflatten_device_tree() unconditionally for another reason[1]. 

[1] https://lore.kernel.org/all/efe6a7886c3491cc9c225a903efa2b1e.sboyd@kernel.org/

> 
> I will work on implementing this and send another revision.

I think we should go with a simpler route that's just copy the an 
initial array in initdata to a properly sized, allocated array like the 
patch below. Of course it will need some arch fixes and a follow-on 
patch to increase the initial array size.

8<--------------------------------------------------------------------
From: Rob Herring <robh@kernel.org>
Date: Wed, 31 Jan 2024 16:26:23 -0600
Subject: [PATCH] of: reserved-mem: Re-allocate reserved_mem array to actual
 size

In preparation to increase the static reserved_mem array size yet again,
copy the initial array to an allocated array sized based on the actual
size needed. Now increasing the the size of the static reserved_mem
array only eats up the initdata space. For platforms with reasonable
number of reserved regions, we have a net gain in free memory.

In order to do memblock allocations, fdt_init_reserved_mem() is moved a
bit later to unflatten_device_tree(). On some arches this is effectively
a nop.

Signed-off-by: Rob Herring <robh@kernel.org>
---
RFC as this is compile tested only. This is an alternative to this
series[1].

[1] https://lore.kernel.org/all/20240126235425.12233-1-quic_obabatun@quicinc.com/
---
 drivers/of/fdt.c             |  4 ++--
 drivers/of/of_reserved_mem.c | 18 +++++++++++++-----
 2 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index bf502ba8da95..14360f5191ae 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -645,8 +645,6 @@ void __init early_init_fdt_scan_reserved_mem(void)
 			break;
 		memblock_reserve(base, size);
 	}
-
-	fdt_init_reserved_mem();
 }
 
 /**
@@ -1328,6 +1326,8 @@ bool __init early_init_dt_scan(void *params)
  */
 void __init unflatten_device_tree(void)
 {
+	fdt_init_reserved_mem();
+
 	__unflatten_device_tree(initial_boot_params, NULL, &of_root,
 				early_init_dt_alloc_memory_arch, false);
 
diff --git a/drivers/of/of_reserved_mem.c b/drivers/of/of_reserved_mem.c
index 7ec94cfcbddb..ae323d6b25ad 100644
--- a/drivers/of/of_reserved_mem.c
+++ b/drivers/of/of_reserved_mem.c
@@ -27,7 +27,8 @@
 #include "of_private.h"
 
 #define MAX_RESERVED_REGIONS	64
-static struct reserved_mem reserved_mem[MAX_RESERVED_REGIONS];
+static struct reserved_mem reserved_mem[MAX_RESERVED_REGIONS] __initdata;
+static struct reserved_mem *reserved_mem_p;
 static int reserved_mem_count;
 
 static int __init early_init_dt_alloc_reserved_memory_arch(phys_addr_t size,
@@ -354,6 +355,13 @@ void __init fdt_init_reserved_mem(void)
 			}
 		}
 	}
+
+	reserved_mem_p = memblock_alloc(sizeof(struct reserved_mem) * reserved_mem_count,
+					sizeof(struct reserved_mem));
+	if (WARN(!reserved_mem_p, "of: reserved-memory allocation failed, continuing with __initdata array!\n"))
+		reserved_mem_p = reserved_mem;
+	else
+		memcpy(reserved_mem_p, reserved_mem, sizeof(struct reserved_mem) * reserved_mem_count);
 }
 
 static inline struct reserved_mem *__find_rmem(struct device_node *node)
@@ -364,8 +372,8 @@ static inline struct reserved_mem *__find_rmem(struct device_node *node)
 		return NULL;
 
 	for (i = 0; i < reserved_mem_count; i++)
-		if (reserved_mem[i].phandle == node->phandle)
-			return &reserved_mem[i];
+		if (reserved_mem_p[i].phandle == node->phandle)
+			return &reserved_mem_p[i];
 	return NULL;
 }
 
@@ -507,8 +515,8 @@ struct reserved_mem *of_reserved_mem_lookup(struct device_node *np)
 
 	name = kbasename(np->full_name);
 	for (i = 0; i < reserved_mem_count; i++)
-		if (!strcmp(reserved_mem[i].name, name))
-			return &reserved_mem[i];
+		if (!strcmp(reserved_mem_p[i].name, name))
+			return &reserved_mem_p[i];
 
 	return NULL;
 }
-- 
2.43.0




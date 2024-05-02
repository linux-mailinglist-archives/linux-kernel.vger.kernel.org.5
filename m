Return-Path: <linux-kernel+bounces-166722-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2D1A8B9E8B
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 18:28:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C647C1C20B5B
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 16:28:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4D3E15E7E5;
	Thu,  2 May 2024 16:27:53 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3A4615CD72;
	Thu,  2 May 2024 16:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714667273; cv=none; b=KJAR+TI/TmWiR1Sqsj7gHpudBb97cl5eUZqBrfv62tFIc4zEZ54EPqSmkvYBfgkLHmG06luVu8SvNk8Q/5bwC8OeKNjDLcLV+1PTPF2CFsvpBEMQeyho9vF5c9dFhIK4m9AAI4JOEHGxCFV30aLyxScjx1JwzoJSjlLpd2Stth4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714667273; c=relaxed/simple;
	bh=nm7ON6oo8RB0X1OqiD304N5QacV8v6d8PFHWqL4dMw0=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Goa9JWrIqCbGwiZbweYP6xsm3gZT5zZ4+DizqLXCW9ZkVq0VSFMuXIQYOAKi8dtG+j2HWA3g1PrABMaZf5vrUwIqK4NTeH5/uZj6MAPc8oC76dntbqQP5URzpXSxsHBMRLTnR96q11CtvLde0ud4oMRV19fkY7pb5ku69+4XmI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VVfV33Mz3z67Lqc;
	Fri,  3 May 2024 00:27:23 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 913671400DB;
	Fri,  3 May 2024 00:27:44 +0800 (CST)
Received: from localhost (10.122.247.231) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 2 May
 2024 17:27:44 +0100
Date: Thu, 2 May 2024 17:27:42 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Robert Richter <rrichter@amd.com>
CC: "Rafael J. Wysocki" <rafael@kernel.org>, Thomas Gleixner
	<tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
	<bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, <x86@kernel.org>,
	Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
	Alison Schofield <alison.schofield@intel.com>, "Dan Williams"
	<dan.j.williams@intel.com>, <linux-acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>, Derick Marks
	<derick.w.marks@intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Len Brown
	<lenb@kernel.org>
Subject: Re: [PATCH v6 1/7] x86/numa: Fix SRAT lookup of CFMWS ranges with
 numa_fill_memblks()
Message-ID: <20240502172742.00002823@huawei.com>
In-Reply-To: <ZjOAOGInZDO65b_T@rric.localdomain>
References: <20240430092200.2335887-1-rrichter@amd.com>
	<20240430092200.2335887-2-rrichter@amd.com>
	<20240430154856.00006d15@Huawei.com>
	<ZjOAOGInZDO65b_T@rric.localdomain>
Organization: Huawei Technologies R&D (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Thu, 2 May 2024 13:59:52 +0200
Robert Richter <rrichter@amd.com> wrote:

> On 30.04.24 15:48:56, Jonathan Cameron wrote:
> > On Tue, 30 Apr 2024 11:21:54 +0200
> > Robert Richter <rrichter@amd.com> wrote:
> >   
> > > For configurations that have the kconfig option NUMA_KEEP_MEMINFO
> > > disabled numa_fill_memblks() only returns with NUMA_NO_MEMBLK (-1).
> > > SRAT lookup fails then because an existing SRAT memory range cannot be
> > > found for a CFMWS address range. This causes the addition of a
> > > duplicate numa_memblk with a different node id and a subsequent page
> > > fault and kernel crash during boot.
> > > 
> > > Fix this by making numa_fill_memblks() always available regardless of
> > > NUMA_KEEP_MEMINFO.
> > > 
> > > The fix also removes numa_fill_memblks() from sparsemem.h using
> > > __weak.
> > > 
> > > From Dan:
> > > 
> > > """
> > > It just feels like numa_fill_memblks() has absolutely no business being
> > > defined in arch/x86/include/asm/sparsemem.h.
> > > 
> > > The only use for numa_fill_memblks() is to arrange for NUMA nodes to be
> > > applied to memory ranges hot-onlined by the CXL driver.
> > > 
> > > It belongs right next to numa_add_memblk(), and I suspect
> > > arch/x86/include/asm/sparsemem.h was only chosen to avoid figuring out
> > > what to do about the fact that linux/numa.h does not include asm/numa.h
> > > and that all implementations either provide numa_add_memblk() or select
> > > the generic implementation.
> > > 
> > > So I would prefer that this do the proper fix and get
> > > numa_fill_memblks() completely out of the sparsemem.h path.
> > > 
> > > Something like the following which boots for me.
> > > """
> > > 
> > > Note that the issue was initially introduced with [1]. But since
> > > phys_to_target_node() was originally used that returned the valid node
> > > 0, an additional numa_memblk was not added. Though, the node id was
> > > wrong too, a message is seen then in the logs:
> > > 
> > >  kernel/numa.c:  pr_info_once("Unknown target node for memory at 0x%llx, assuming node 0\n",
> > > 
> > > [1] commit fd49f99c1809 ("ACPI: NUMA: Add a node and memblk for each
> > >     CFMWS not in SRAT")
> > > 
> > > Suggested-by: Dan Williams <dan.j.williams@intel.com>
> > > Link: https://lore.kernel.org/all/66271b0072317_69102944c@dwillia2-xfh.jf.intel.com.notmuch/
> > > Fixes: 8f1004679987 ("ACPI/NUMA: Apply SRAT proximity domain to entire CFMWS window")
> > > Cc: Derick Marks <derick.w.marks@intel.com>
> > > Cc: Dan Williams <dan.j.williams@intel.com>
> > > Cc: Alison Schofield <alison.schofield@intel.com>
> > > Signed-off-by: Robert Richter <rrichter@amd.com>  
> > 
> > Whilst I'm not particularly keen on an arch specific solution for this
> > and the stub is effectively pointless beyond making the build work, I guess
> > this works well enough for now.
> > 
> > Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > 
> > I was aiming to post the ARM64 handling this cycle but it hasn't quite happened yet :(
> > Maybe we can look at whether there is a better level share at than
> > the whole function once that is done.  
> 
> Thanks for review.
> 
> It seems better to change x86 to use the generic implementation of
> numa_add_memblk() in drivers/base/arch_numa.c. That already contains
> code to deal with and merge overlapping blocks, it also checks memory
> attributes. But that is not scope of this patch.
> 
There is some history that Dan pointed me at a while back... Maybe this one is fine
but in general people have tried and given up on unifying x86 memblock handling
with the generic version :(
https://lore.kernel.org/linux-mm/159457121480.754248.17292511837648775358.stgit@dwillia2-desk3.amr.corp.intel.com/

> -Robert



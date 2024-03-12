Return-Path: <linux-kernel+bounces-100257-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B0D7387941D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 13:24:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C6B8286634
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 12:24:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1333D79DD3;
	Tue, 12 Mar 2024 12:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g7HNev3/"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 577CD5B1E1
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 12:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710246267; cv=none; b=Q22eOJ5PBdH252GsiWobGnoeOKGEtLwUUjVQMT+g+AVWBrWPlN9HF+NuEP085ghsezmfTL2uEcOVlTo13kuJcXWehpl5h/2kshsXsdLpHdar0RoTtFdQ3NXcOj5hcDLxXQvlSP3oS4Pn+yoCx/KkdZHKTE6jjnFF+X1SKDWp1ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710246267; c=relaxed/simple;
	bh=Qp3RGcHrPVBEDvQui/FKPyzLuwwwRCqsPvPUZhw6WJY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lzY7e0Cla7UpXdG8TROaca/Mv1g3Kjs6RrXlc3mvy4NpcOfhaOdjsAIlV0zL4wfpCtkuJz94bnkBUyMY3opq6noYu5E1xvo8dyZAnpe5X2+KruiA/v9McM9bf/LFONyAj8brSPkVN2PzzWLqJHnfCkGy7Yc6KKyUyg9R158yjsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g7HNev3/; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710246266; x=1741782266;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Qp3RGcHrPVBEDvQui/FKPyzLuwwwRCqsPvPUZhw6WJY=;
  b=g7HNev3/LxKUgy9BgylfSnqKVdoU5dNbrgKatqxqB3LLFggL5cJ6dFQU
   w4Ka0WPPO1+03c1IPKo2aLjSbuCacMq8qmrqateserMBgO9lWBCoVangF
   +GopspoB9meNUdtoOdZAUdheplVI83NZ0+XBHuxC9tWpDZPJlfTE/nsM5
   8ucL7KzWj/Zyd8FeFEqqwRi/akz42mFE5mg6pXb1+DNTyfW1mu6dfv54X
   vLJuHEfEwnwqZDOajHdBldVwFbh1VnLO4/IwxgeqWiW15A907SoNP/SCP
   OJvPEoq9BpPo8a5aQuN2mv5AzL2gOH+Ss6fzYQg2ArN234M6DR6HqhOuL
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11010"; a="8768888"
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; 
   d="scan'208";a="8768888"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2024 05:24:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11010"; a="937051753"
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; 
   d="scan'208";a="937051753"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 12 Mar 2024 05:24:21 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 078A327D; Tue, 12 Mar 2024 14:24:19 +0200 (EET)
Date: Tue, 12 Mar 2024 14:24:19 +0200
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Yosry Ahmed <yosryahmed@google.com>
Cc: x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] x86/mm: Use IPIs to synchronize LAM enablement
Message-ID: <ru5q3ca23ouexs4aygkmn75ghbmyunx5vtdvd73xaogiv3k3ed@as5wvvtrgpjv>
References: <20240312035951.3535980-1-yosryahmed@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240312035951.3535980-1-yosryahmed@google.com>

On Tue, Mar 12, 2024 at 03:59:49AM +0000, Yosry Ahmed wrote:
> LAM can only be enabled when a process is single-threaded.  But _kernel_
> threads can temporarily use a single-threaded process's mm.
> 
> If LAM is enabled by a userspace process while a kthread is using its
> mm, the kthread will not observe LAM enablement (i.e.  LAM will be
> disabled in CR3). This could be fine for the kthread itself, as LAM only
> affects userspace addresses. However, if the kthread context switches to
> a thread in the same userspace process, CR3 may or may not be updated
> because the mm_struct doesn't change (based on pending TLB flushes). If
> CR3 is not updated, the userspace thread will run incorrectly with LAM
> disabled, which may cause page faults when using tagged addresses.
> Example scenario:
> 
> CPU 1                                   CPU 2
> /* kthread */
> kthread_use_mm()
>                                         /* user thread */
>                                         prctl_enable_tagged_addr()
>                                         /* LAM enabled on CPU 2 */
> /* LAM disabled on CPU 1 */
>                                         context_switch() /* to CPU 1 */
> /* Switching to user thread */
> switch_mm_irqs_off()
> /* CR3 not updated */
> /* LAM is still disabled on CPU 1 */
> 
> Synchronize LAM enablement by sending an IPI from
> prctl_enable_tagged_addr() to all CPUs running with the mm_struct to
> enable LAM. This makes sure LAM is enabled on CPU 1 in the above
> scenario before prctl_enable_tagged_addr() returns and userspace starts
> using tagged addresses, and before it's possible to run the userspace
> process on CPU 1.
> 
> In switch_mm_irqs_off(), move reading the LAM mask until after
> mm_cpumask() is updated. This ensures that if an outdated LAM mask is
> written to CR3, an IPI is received to update it right after IRQs are
> re-enabled.
> 
> Fixes: 82721d8b25d7 ("x86/mm: Handle LAM on context switch")
> Suggested-by: Andy Lutomirski <luto@kernel.org>
> Signed-off-by: Yosry Ahmed <yosryahmed@google.com>

Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

-- 
  Kiryl Shutsemau / Kirill A. Shutemov


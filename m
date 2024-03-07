Return-Path: <linux-kernel+bounces-95927-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 21FD787550C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 18:23:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF3951F229F4
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 17:22:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93014130AE3;
	Thu,  7 Mar 2024 17:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ew7PLEQC"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AF9F12F5BD
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 17:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709832173; cv=none; b=hAeyYZa83cdxubk9J3LuawAO2M+Us7LGbdAVm2qxPkGURr0roq6OaMosvEsZj1dAvY4i0drmn3PiynUBYD0Wt2lAYuWC6lJQdBoA8/JnZ49yvO1bppOsMayiaKnxraObFWXfRuNAbRoR9xJZBBuF/D6ZBuOJmZDkzGUroEpHv20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709832173; c=relaxed/simple;
	bh=TmbB09GJpy+aCGZ8NeqMnq6ND5GYUdhyNoFR8Mz5HZQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Oj3HRlgewXmHWy15M9QsDnX5+qUqzc9/Mmc+kCHIc3mzb6cJiBPHJhM2WkxpnCeCwzJZzwI3LWqJzRgiDYG6bM5n4fDr2qqvInmYBFf8r8ZdppTYtNROsgL48bDr07d+zWp+zqvdhYyyCJvSwOWVqwb5dPdXmFYiCgd9hQ/8sXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ew7PLEQC; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709832172; x=1741368172;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=TmbB09GJpy+aCGZ8NeqMnq6ND5GYUdhyNoFR8Mz5HZQ=;
  b=Ew7PLEQCz3nMPH28UK3vDAgoZSiLCr5Uv361yMtAnoagBxK9rP+2gbFB
   l1Tuhr4OELGp+dVP0nQRIJRRBT4/sCUbTz6CHvHEEjPkk9vD6EdyIEaUr
   gLDu8+KgEJxVj7yXTu/a/GwCmYnZQGBuVWfRcTecLydSvOCaYzGvDwD4t
   8R4ATcwAf1jhetIWn3n8721O8FrIsMv70IsAjeVf8ctYgrKHJXTeZ8XJg
   K+QR640UCKdiTh99h3mHVRElcJOJi2xOOk2IHpeti5XaYMk3q3opeLBqi
   /dE5/TM4K1C+RTVEETZC1qdAXts9w6Qs6/TWrcL7dG7muTQ7LubA/i06K
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11006"; a="26986031"
X-IronPort-AV: E=Sophos;i="6.07,107,1708416000"; 
   d="scan'208";a="26986031"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2024 09:22:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11006"; a="937046421"
X-IronPort-AV: E=Sophos;i="6.07,107,1708416000"; 
   d="scan'208";a="937046421"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 07 Mar 2024 09:22:37 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 3B719128; Thu,  7 Mar 2024 19:22:36 +0200 (EET)
Date: Thu, 7 Mar 2024 19:22:36 +0200
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Andy Lutomirski <luto@kernel.org>, x86@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 1/3] x86/mm: fix LAM cr3 mask inconsistency during
 context switch
Message-ID: <updn6j7jcqdru73vwt3fvxlx4t73rjrlk7h6i6js3lizeueoov@tz7fyrd3a4yi>
References: <20240307133916.3782068-1-yosryahmed@google.com>
 <20240307133916.3782068-2-yosryahmed@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240307133916.3782068-2-yosryahmed@google.com>

On Thu, Mar 07, 2024 at 01:39:14PM +0000, Yosry Ahmed wrote:
> In switch_mm_irqs_off(), we read the 'mm->context.lam_cr3_mask' into
> 'new_lam', which is later passed to load_new_mm_cr3(). However, there is
> a call to set_tlbstate_lam_mode() in between which will read
> 'mm->context.lam_cr3_mask' again and set 'cpu_tlbstate.lam' accordingly.
> If we race with another thread updating 'mm->context.lam_cr3_mask', the
> value in 'cpu_tlbstate.lam' could end up being different from CR3.

What other thread? LAM can only be enabled when the process has single
thread. And cannot be disabled. See MM_CONTEXT_LOCK_LAM.

> While we are at it, remove the misguiding comment that states that
> 'new_lam' may not match tlbstate_lam_cr3_mask() if a race occurs.

The comment is indeed misguiding, but for different reason. It is leftover
from the earlier version of LAM patchset.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov


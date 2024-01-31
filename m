Return-Path: <linux-kernel+bounces-46472-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E0DDD84403E
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 14:14:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FB431C277E2
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 13:14:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 727867BAE8;
	Wed, 31 Jan 2024 13:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fPRJyqkR"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F8FA79DB6
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 13:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706706865; cv=none; b=B2lw14jwd4AkISJPHiG0pEoCRApuPeHGswsAPIMFglZ8ivjnCaGGctEbgTMGGE3UMyx7q04fhIf5QBmOQfR939WnX4xQM2dYm4RxTyXrdt0JW2EAO15j8QXN8wuZmaF+hW6mefWUIj2P2e90r67RQBf8jSVsFhKvmmvJFICKjGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706706865; c=relaxed/simple;
	bh=1LIQJ8Y3luSRKHdrTOYwFouqxcWQUeQ9zxuAnECjIhY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mwd3YXBE/N0frU06tbOWY7CX5FhabM8+B4OUqF6gxLTmCcwMVWpEjW0nUiT0NDsawnQULC15jI5kUna7IgLbDX7jratotd0dKZjeo3rj1wZTsnJz+nZyXGHhbS2YxG7KK2sOzLP4H4IDovub0KC8eYBSXPtkPDkZmgMjo7uvc/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fPRJyqkR; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706706865; x=1738242865;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1LIQJ8Y3luSRKHdrTOYwFouqxcWQUeQ9zxuAnECjIhY=;
  b=fPRJyqkRRM/QJgUFH0SVfif/LkP8qqU/gKzH7BXSkdadlPHdOhts9T7j
   B63V6rPn/VGyKhX2VJMmzI6pyYt9APKaJoFJqd24vLRt7yizbqhvQR+xG
   JC/JZBLsGueEleEvyimrzRtx8ilOyhu11AzXRi6Addq6lPSYgfgAi5eSb
   6M1ge1u9AAGicBorggo2197Ty8/HFRniiEN4Uu6AQf30DStOFVZN7xl4h
   I2qhVQ5UnqA/iUdj3bm87PwfzbrHnMlLLNIxcasE0kCsFBYFbz2oq3gkr
   awECszE14ZNkCS15BdIfs4qAWayZ3UncsKaJzmMgyg5AR8KFT0GIK2FBB
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="10232777"
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; 
   d="scan'208";a="10232777"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2024 05:14:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="931837860"
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; 
   d="scan'208";a="931837860"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 31 Jan 2024 05:14:20 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 8E2206E4; Wed, 31 Jan 2024 15:04:03 +0200 (EET)
Date: Wed, 31 Jan 2024 15:04:03 +0200
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>
Cc: x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
	linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, Kai Huang <kai.huang@intel.com>, 
	Sean Christopherson <seanjc@google.com>
Subject: Re: [PATCHv4] x86/trampoline: Bypass compat mode in
 trampoline_start64() if not needed
Message-ID: <2qfzbafedurgpsnlbrrfcwed4kij5kbz6txaacp3fy73anfk3g@r75kdg6byw4b>
References: <20240126100101.689090-1-kirill.shutemov@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240126100101.689090-1-kirill.shutemov@linux.intel.com>

On Fri, Jan 26, 2024 at 12:01:01PM +0200, Kirill A. Shutemov wrote:
> The trampoline_start64() vector is used when a secondary CPU starts in
> 64-bit mode. The current implementation directly enters compatibility
> mode. It is necessary to disable paging and re-enable it in the correct
> paging mode: either 4- or 5-level, depending on the configuration.
> 
> The X86S[1] ISA does not support compatibility mode in ring 0, and
> paging cannot be disabled.
> 
> The trampoline_start64() function is reworked to only enter compatibility
> mode if it is necessary to change the paging mode. If the CPU is already
> in the desired paging mode, it will proceed in long mode.
> 
> This change will allow a secondary CPU to boot on an X86S machine as
> long as the CPU is already in the correct paging mode.
> 
> In the future, there will be a mechanism to switch between paging modes
> without disabling paging.
> 
> [1] https://www.intel.com/content/www/us/en/developer/articles/technical/envisioning-future-simplified-architecture.html
> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Reviewed-by: Andi Kleen <ak@linux.intel.com>
> Reviewed-by: Kai Huang <kai.huang@intel.com>
> Cc: Sean Christopherson <seanjc@google.com>

Any feedback?

-- 
  Kiryl Shutsemau / Kirill A. Shutemov


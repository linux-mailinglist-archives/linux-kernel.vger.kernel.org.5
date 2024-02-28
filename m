Return-Path: <linux-kernel+bounces-84977-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4977D86AE6B
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 12:58:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDE741F23733
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 11:58:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26AFC145FE1;
	Wed, 28 Feb 2024 11:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RDBVhHu5"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 945CD145B23;
	Wed, 28 Feb 2024 11:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709121113; cv=none; b=nS4j1L//Ugx+yd160Vj+lRd7yRzOSn4W8OpdN0Xq/LvXv7xtEOZdUUu30sfpgo6EIDUSbY+yu2AZTUTf4VkOhJUCqyRbdLnlW1rUMDxsvb1jgTIhQcRBTb2PG87hD0ooLuGnPlC4S8R+IEeFAVqlsv4t8ZWC62h0VN+sulJTzY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709121113; c=relaxed/simple;
	bh=UOHYABj412OrOe9R32rHntZ5qCSK4fekgltl0v2LzuA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cw0mtNxdE4/5cabJ8INPrUMwwL1oTn2AvMPmzOiZpr2bi71esQVbp0JRh2u2u3TXeA5X50JW/IV6HtKHptKGsKBxBjHqGMbTaOuYlUKbQ44inaWgPteUoRXgTgVfZeTUnbysBhdd4AHJhBmKxzgZtnrhR7ifDG2GtLFub5D+Rn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RDBVhHu5; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709121112; x=1740657112;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=UOHYABj412OrOe9R32rHntZ5qCSK4fekgltl0v2LzuA=;
  b=RDBVhHu5kI9HOB61cYAalpnZ0DtwYx+LtAapZMdpmtTti1t1X1gju8nt
   c1z44b/MnstlsBpEtN+coKHYcUxG8szJs55fjXU147XR/FnOJV/SYvtx8
   yStpCZHQMUL+2+mNzijJUbKbYQR4frglhlbWn6aAz0h0GnpSTay4K1KiS
   IiGNHTgknp78ZyywcGudpjPoepr7mb7nd/n70LtFkTbbMhbgfZVWvX1UA
   lGV2Ev2plHj8OAZ9T2oYa2HMzAJbZll6mnn+lcU7iL97KTVsl4aQE99Cl
   dUNihqUkChd2VgIlYe1JlCnAkwnkgD2olR3z51GWrqQCwPsqgsW9sn4np
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="7337755"
X-IronPort-AV: E=Sophos;i="6.06,190,1705392000"; 
   d="scan'208";a="7337755"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2024 03:51:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="937034059"
X-IronPort-AV: E=Sophos;i="6.06,190,1705392000"; 
   d="scan'208";a="937034059"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 28 Feb 2024 03:51:44 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id B730928A; Wed, 28 Feb 2024 13:51:42 +0200 (EET)
Date: Wed, 28 Feb 2024 13:51:42 +0200
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc: Liam.Howlett@oracle.com, akpm@linux-foundation.org, debug@rivosinc.com, 
	broonie@kernel.org, keescook@chromium.org, tglx@linutronix.de, mingo@redhat.com, 
	bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, luto@kernel.org, 
	peterz@infradead.org, hpa@zytor.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org, loongarch@lists.linux.dev, 
	linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org
Subject: Re: [PATCH v2 5/9] mm: Initialize struct vm_unmapped_area_info
Message-ID: <j7bfvig3gew3qruouxrh7z7ehjjafrgkbcmg6tcghhfh3rhmzi@wzlcoecgy5rs>
References: <20240226190951.3240433-1-rick.p.edgecombe@intel.com>
 <20240226190951.3240433-6-rick.p.edgecombe@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240226190951.3240433-6-rick.p.edgecombe@intel.com>

On Mon, Feb 26, 2024 at 11:09:47AM -0800, Rick Edgecombe wrote:
> diff --git a/arch/alpha/kernel/osf_sys.c b/arch/alpha/kernel/osf_sys.c
> index 5db88b627439..dd6801bb9240 100644
> --- a/arch/alpha/kernel/osf_sys.c
> +++ b/arch/alpha/kernel/osf_sys.c
> @@ -1218,7 +1218,7 @@ static unsigned long
>  arch_get_unmapped_area_1(unsigned long addr, unsigned long len,
>  		         unsigned long limit)
>  {
> -	struct vm_unmapped_area_info info;
> +	struct vm_unmapped_area_info info = {};
>  
>  	info.flags = 0;
>  	info.length = len;

Can we make a step forward and actually move initialization inside the
initializator? Something like below.

I understand that it is substantially more work, but I think it is useful.

diff --git a/arch/alpha/kernel/osf_sys.c b/arch/alpha/kernel/osf_sys.c
index 5db88b627439..c40ddede3b13 100644
--- a/arch/alpha/kernel/osf_sys.c
+++ b/arch/alpha/kernel/osf_sys.c
@@ -1218,14 +1218,12 @@ static unsigned long
 arch_get_unmapped_area_1(unsigned long addr, unsigned long len,
 		         unsigned long limit)
 {
-	struct vm_unmapped_area_info info;
+	struct vm_unmapped_area_info info = {
+		.length = len;
+		.low_limit = addr,
+		.high_limit = limit,
+	};

-	info.flags = 0;
-	info.length = len;
-	info.low_limit = addr;
-	info.high_limit = limit;
-	info.align_mask = 0;
-	info.align_offset = 0;
 	return vm_unmapped_area(&info);
 }

-- 
  Kiryl Shutsemau / Kirill A. Shutemov


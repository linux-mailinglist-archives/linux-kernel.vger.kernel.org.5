Return-Path: <linux-kernel+bounces-68600-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 53FC5857CFC
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 13:57:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97CF41F25EDB
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 12:57:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0877B78683;
	Fri, 16 Feb 2024 12:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IzCOcGHg"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B6E877F19
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 12:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708088216; cv=none; b=jbFcPBx8wkPcjPBF4ma81og6aaSz3XOBWT8QH77l+ZgbeptzHo23e1IlErhqOROGE4avsksw5+r8ZumNEx6AvUjFqMgjZ+p+Bb3kViVtZ7QVbwNJvSQm8nk0xPuD/Gkn2bEGuCoVOEX+2uRfTHnzLTBWNKxgEk8MAZXurLB8pU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708088216; c=relaxed/simple;
	bh=n3nIo7ta+lpOf6Vkf5nvSLxYrw9xngsA3TZcxZbTcZo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TMYRY26JnghVzpkrD59Ya1MbAlX9LY+aNhTPTvNvMPYkbeN2r0xsZEEDVefiFMgSb2L95O0TAmp5gnVuxICW1lv3xWRyoA6vzWqA5HDNbnlOQxNWCEwjKoP1M15wUW35bD3uPaQkRxeCCv8RwAdHGFub+SwoREWGAQtUeBH4a7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IzCOcGHg; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708088214; x=1739624214;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=n3nIo7ta+lpOf6Vkf5nvSLxYrw9xngsA3TZcxZbTcZo=;
  b=IzCOcGHg4ZSiMGe28XTQW/YGGmW7wQD9ULJg2LiiJbnHlXnz/AznAbnv
   W+MKJUI3iIJOvPb0zMB3DIdwUcecp7dedV71cn8obqEjtovD2ozFvLMl/
   SbnX1yJcOSWvQnEFmJPMND8/7+hNY+FyegTpJg6MqN3RqHQGu6DpHDqKA
   xD5V9Pyk+v5sLnnSjrpURws4ETqcEqV0RVpiTi7nzg1HF8vWqLUtDBvD8
   EXC68aaZh+unMUDU+7OXoj7rhydKr6kxN+NqDAgplehk2GMuu6uUFlAcs
   zVNOgorQu/iS65qXaQzrId+SHdcABIxRBMT9xNKSrk/Qy589tM0BcU7KP
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10985"; a="6041851"
X-IronPort-AV: E=Sophos;i="6.06,164,1705392000"; 
   d="scan'208";a="6041851"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2024 04:56:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10985"; a="935844562"
X-IronPort-AV: E=Sophos;i="6.06,164,1705392000"; 
   d="scan'208";a="935844562"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 16 Feb 2024 04:56:49 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 994342E9; Fri, 16 Feb 2024 14:56:48 +0200 (EET)
Date: Fri, 16 Feb 2024 14:56:48 +0200
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc: Liam.Howlett@oracle.com, akpm@linux-foundation.org, debug@rivosinc.com, 
	broonie@kernel.org, keescook@chromium.org, tglx@linutronix.de, mingo@redhat.com, 
	bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, luto@kernel.org, 
	peterz@infradead.org, hpa@zytor.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 3/8] mm: Use get_unmapped_area_vmflags()
Message-ID: <gs2yekj24y5jedpvpwvsfdhnr23epkpcatmwhcmyaerke7ooon@55dgxhlf5llq>
References: <20240215231332.1556787-1-rick.p.edgecombe@intel.com>
 <20240215231332.1556787-4-rick.p.edgecombe@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240215231332.1556787-4-rick.p.edgecombe@intel.com>

On Thu, Feb 15, 2024 at 03:13:27PM -0800, Rick Edgecombe wrote:
> @@ -1879,6 +1879,12 @@ get_unmapped_area(struct file *file, unsigned long addr, unsigned long len,
>  	return error ? error : addr;
>  }
>  
> +unsigned long
> +get_unmapped_area(struct file *file, unsigned long addr, unsigned long len,
> +		unsigned long pgoff, unsigned long flags)
> +{
> +	return __get_unmapped_area(file, addr, len, pgoff, flags, 0);
> +}
>  EXPORT_SYMBOL(get_unmapped_area);

Any reason it is not a static inline function in the header file?

-- 
  Kiryl Shutsemau / Kirill A. Shutemov


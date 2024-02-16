Return-Path: <linux-kernel+bounces-68570-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D5DE857C95
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 13:30:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 11358B23B18
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 12:30:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D3E57F462;
	Fri, 16 Feb 2024 12:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CISQ0CQc"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B8407E76A
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 12:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708086649; cv=none; b=nJlCgBSL2MSHUhF5tBG7PWKq2uV7rANFWSi1sQcTDzdLztP1HYeFudewbpwEpX+9zOhCIRYlNYhLPJ35ixqkgnHpS7Qq+GA8brqcs5Xpf9yWxznylID/CUgoHi28BYwTVzLPIi3F90YxMDAEcAki0V7Y/wcAlGZENrFzgyxNs08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708086649; c=relaxed/simple;
	bh=+BVthaD9VjyytlG+lIFukVqy3/6V+9dODatLq0TXa+0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XMNptbESpcrXtlvQdYvGM5i6bOjKwBJp03rbIe0hCv++QTwmVC6u/nEBqe5ttG2tULWPAV/jDWz6EiUdbdiLmF9qjqmK3KQjjypDu++iFyuDmiLedX4YD8JF34GSI/aeXA+BQRmKv7A67V4mOthONg3Fv04XIME5uj5ma+SPCFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CISQ0CQc; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708086647; x=1739622647;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+BVthaD9VjyytlG+lIFukVqy3/6V+9dODatLq0TXa+0=;
  b=CISQ0CQc4hib3iqyRZq/fXaKBiFnw2VWgh0GzxFsuPuxYGwyplWqTwkJ
   IunG8M8yFh+VfxTATgV4BbjpHawP5KyybM9kjFw/L7QPMe1l8K6wUwttt
   7dQqe0JCJZWQClAe34+7YtX66oLGc8sgF3CI3QFZcDhT7Xe1uAq0aQlsO
   /jjErJEueRDktKRB0T87kNZJxeGNEKcdOxgVoSP2MjrLCjuWI+MxxhWbi
   YaK9SswNUBqs/x/1kZIawwSSC22MBE+x2e2xsIb0Zd2A2TRJR77jgQLRk
   o2t1jbm2/yN4/ATP7jJ0xUKJviHAA/NCT3r8h4qpHqmSagKIlfTGR94OK
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10985"; a="2617715"
X-IronPort-AV: E=Sophos;i="6.06,164,1705392000"; 
   d="scan'208";a="2617715"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2024 04:30:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10985"; a="826573242"
X-IronPort-AV: E=Sophos;i="6.06,164,1705392000"; 
   d="scan'208";a="826573242"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga001.jf.intel.com with ESMTP; 16 Feb 2024 04:30:41 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 6005D2E9; Fri, 16 Feb 2024 14:30:40 +0200 (EET)
Date: Fri, 16 Feb 2024 14:30:40 +0200
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc: Liam.Howlett@oracle.com, akpm@linux-foundation.org, debug@rivosinc.com, 
	broonie@kernel.org, keescook@chromium.org, tglx@linutronix.de, mingo@redhat.com, 
	bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, luto@kernel.org, 
	peterz@infradead.org, hpa@zytor.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 1/8] mm: Switch mm->get_unmapped_area() to a flag
Message-ID: <b65wvw4nghmwt4w4xsxoqwgc72efn7qo3s2p4dtatbcbvmxord@jopa2yxxbu6n>
References: <20240215231332.1556787-1-rick.p.edgecombe@intel.com>
 <20240215231332.1556787-2-rick.p.edgecombe@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240215231332.1556787-2-rick.p.edgecombe@intel.com>

On Thu, Feb 15, 2024 at 03:13:25PM -0800, Rick Edgecombe wrote:
> diff --git a/include/linux/sched/coredump.h b/include/linux/sched/coredump.h
> index 02f5090ffea2..428e440424c5 100644
> --- a/include/linux/sched/coredump.h
> +++ b/include/linux/sched/coredump.h
> @@ -74,6 +74,7 @@ static inline int get_dumpable(struct mm_struct *mm)
>  #define MMF_DISABLE_THP_MASK	(1 << MMF_DISABLE_THP)
>  #define MMF_OOM_REAP_QUEUED	25	/* mm was queued for oom_reaper */
>  #define MMF_MULTIPROCESS	26	/* mm is shared between processes */
> +#define MMF_TOPDOWN		27	/* mm is shared between processes */
>  /*
>   * MMF_HAS_PINNED: Whether this mm has pinned any pages.  This can be either
>   * replaced in the future by mm.pinned_vm when it becomes stable, or grow into

Comment has to be updated.

Otherwise, looks good:

Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

-- 
  Kiryl Shutsemau / Kirill A. Shutemov


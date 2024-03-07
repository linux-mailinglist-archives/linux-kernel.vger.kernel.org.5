Return-Path: <linux-kernel+bounces-95944-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FEFC875538
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 18:32:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 005291F22CBA
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 17:32:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AC19131E2F;
	Thu,  7 Mar 2024 17:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I0YUjJL9"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83CC4130E46
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 17:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709832712; cv=none; b=MkhBgtpwPPhsB9IVKLQJt3zAdAXw7FQCiWJgiZVXZK5l8PyR0MXcu2S9zGqS1HR63rCZlnPHPU/Hr1s3XTnU3GmclFWz4o5fXh6F8A2iQSEx/CmaSew+Nq0tMFP+dV2Zn/CHArCqiA1sg/1e4Holhk5RW0T5goeFIuzk0jwitug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709832712; c=relaxed/simple;
	bh=vzADUwGQeVvOM48WKXm4UNqLNwBN9ej4gnBvU/nQcbU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uqx+UhsMN3LnX/wH1fmuWkcQxOsRA1RzjOH7Rf498D3psNEIInE9It9+yxBv6o6SgvBrlmLl3JKUJUsQD7VqGl9NY6ht0JBkVQ5yko6JJZbPvFJktmCepueRSUCNXsiMxb8FFNccGhoSnbi/WJb7r7RdtHERNQu/SV1s1OwFmOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I0YUjJL9; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709832711; x=1741368711;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vzADUwGQeVvOM48WKXm4UNqLNwBN9ej4gnBvU/nQcbU=;
  b=I0YUjJL9q425t3L8LmQFCI9qTawf/Z0swLZzDwA8GtqaoBp/kDSM3MAk
   +9lRwnwTrgYk/FQmehr6vMggyeg1sXBXCGqgSg1GyYF+RzyWsxJ3YJfax
   JBixwS8kDEihVpLEEMhDHh7U7ly6ohdHJNUhSvBKrdRycA0A+50goFaxW
   MoGVak/jehpAzkzclXewbf7IJgXDrJ42FjNou9B5UQ64cb0NNvFy43idS
   PoFKuOQHx/kaT4dFv0FP0DRfuOqytjT8Q4qEapqbGu2e/xv/DtDHwzdAs
   xXkoHL9soDl2ddMgpvpKor0NAseDPsBdMf0tatjOr6wtHC3qrGm847QiW
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11006"; a="26987286"
X-IronPort-AV: E=Sophos;i="6.07,107,1708416000"; 
   d="scan'208";a="26987286"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2024 09:31:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11006"; a="937046429"
X-IronPort-AV: E=Sophos;i="6.07,107,1708416000"; 
   d="scan'208";a="937046429"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 07 Mar 2024 09:31:45 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 8B8BB128; Thu,  7 Mar 2024 19:31:44 +0200 (EET)
Date: Thu, 7 Mar 2024 19:31:44 +0200
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Andy Lutomirski <luto@kernel.org>, x86@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 3/3] x86/mm: cleanup prctl_enable_tagged_addr()
 nr_bits error checking
Message-ID: <j3zncd7dxc6kzk5sdytqulkk76cluq6zctklpasa3y4ig3vwku@ibabr336aqv6>
References: <20240307133916.3782068-1-yosryahmed@google.com>
 <20240307133916.3782068-4-yosryahmed@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240307133916.3782068-4-yosryahmed@google.com>

On Thu, Mar 07, 2024 at 01:39:16PM +0000, Yosry Ahmed wrote:
> In prctl_enable_tagged_addr(), we check that nr_bits is in the correct
> range, but we do so in a twisted if/else block where the correct case is
> sandwiched between two error cases doing exactly the same thing.
> 
> Simplify the if condition and pull the correct case outside with the
> rest of the success code path.

I'm okay either way.

I structured the code this way as I had separate patch that adds also
LAM_U48. But it is unlikely to get upstreamed.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov


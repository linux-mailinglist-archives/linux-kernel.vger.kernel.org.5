Return-Path: <linux-kernel+bounces-101546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DF9787A891
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 14:39:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB452282A23
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 13:38:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB94041208;
	Wed, 13 Mar 2024 13:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dYlXAwbn"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 302A51DFFC
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 13:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710337134; cv=none; b=V/2XVGMJt6Ckwygz4RC1UYu4A1stdNW099IH0LcY7fq7M94gRj/1WyR/RTuNRJaDO4wgxdaGIag7TgSMq7GJanl2wJZIGXvqrBm+E7cSYQMffWZc3Y76u0fN9QRQ2wH8o+JCs8yYPETplOEfFsX0pNGwOWBtTAUwSSaYJogv+M8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710337134; c=relaxed/simple;
	bh=BOcy5v8jTDEf4Uwi1cewwmZO/FeGeMFiYXTFAhC4WZk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z5u9qaQaV0vRncyoy44+i/C5RtzWUIEU0Y6u2neYSOd7WKMOWeQU94g1ooEIDAbWG9sUgwjwyg20/vPaJ6Sf0LtwysojkOtkMvIFS7SENv/8MjHRl3eFbCT0phqQ3wYmPp+cuhRx16BjsqhbfakT5uxR5UhWmqfPohn4kwOvQhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dYlXAwbn; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710337132; x=1741873132;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=BOcy5v8jTDEf4Uwi1cewwmZO/FeGeMFiYXTFAhC4WZk=;
  b=dYlXAwbnZ9NPMF757OQKEEqK2vB93PnHQxWm5ZvzNqou7syrWTq/HwE4
   EQQPeBUCKAEjl+Grn04FXXm7SAVi0vsks7/uy6b4HSuVnDcZ+kergV14N
   OEdI7e17tXpd1iUcJcIVlmlJIXKY2c8088wF/0n1lFppmTNwX4H0u5rQe
   Vh1P9dUpoAhyZLCGy6xNeG25F7ccIw2NtjeI8/hgR4mJju/IUNgM1C00f
   Oy+dr0yPk50qqQlWgfdISz2cO+qYQepO1EZiON5W6FYPAsyUrXDsQEq0P
   NBQ6fEd5w7rtAAFaVyr/DaW8ukl0ibJenxkZgSiwV/JL0pPvBC/JS6Q2T
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11011"; a="5708196"
X-IronPort-AV: E=Sophos;i="6.07,122,1708416000"; 
   d="scan'208";a="5708196"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2024 06:38:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11011"; a="937054147"
X-IronPort-AV: E=Sophos;i="6.07,122,1708416000"; 
   d="scan'208";a="937054147"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 13 Mar 2024 06:38:48 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 18FE91057; Wed, 13 Mar 2024 15:38:46 +0200 (EET)
Date: Wed, 13 Mar 2024 15:38:46 +0200
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Yosry Ahmed <yosryahmed@google.com>
Cc: x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] x86/mm: Fix LAM inconsistency during context
 switch
Message-ID: <so22e3yeljtvz5axz2cgwtns3r5kimk43r65cognlazsgh4agz@zwdnsc266dw3>
References: <20240312155641.4003683-1-yosryahmed@google.com>
 <20240312155641.4003683-2-yosryahmed@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240312155641.4003683-2-yosryahmed@google.com>

On Tue, Mar 12, 2024 at 03:56:40PM +0000, Yosry Ahmed wrote:
> LAM can only be enabled when a process is single-threaded.  But _kernel_
> threads can temporarily use a single-threaded process's mm.  That means
> that a context-switching kernel thread can race and observe the mm's LAM
> metadata (mm->context.lam_cr3_mask) change.
> 
> The context switch code does two logical things with that metadata:
> populate CR3 and populate 'cpu_tlbstate.lam'.  If it hits this race,
> 'cpu_tlbstate.lam' and CR3 can end up out of sync.
> 
> This de-synchronization is currently harmless.  But it is confusing and
> might lead to warnings or real bugs.
> 
> Update set_tlbstate_lam_mode() to take in the LAM mask and untag mask
> instead of an mm_struct pointer, and while we are at it, rename it to
> cpu_tlbstate_update_lam(). This should also make it clearer that we are
> updating cpu_tlbstate. In switch_mm_irqs_off(), read the LAM mask once
> and use it for both the cpu_tlbstate update and the CR3 update.
> 
> Signed-off-by: Yosry Ahmed <yosryahmed@google.com>

Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

-- 
  Kiryl Shutsemau / Kirill A. Shutemov


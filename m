Return-Path: <linux-kernel+bounces-97959-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 131E1877254
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 17:34:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC95B1F215A0
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 16:34:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FF394A23;
	Sat,  9 Mar 2024 16:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cQqEUhko"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C81915B1
	for <linux-kernel@vger.kernel.org>; Sat,  9 Mar 2024 16:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710002084; cv=none; b=NYFh3BmG4SRgOBZD2Nv5CNZs9YV2Qa0WShl38fPKEuPwYm44QfqYcDeuoJ58WwOmqpX12b541dZu9Us6PIv6tTzPu5e8+r7JEyT8WxsdBc9oB8RhAxgspkJbQMOt/x4wbMx2r3KrMN5BqobEdRhbG0Sqw8wxFwJZKWh5mWAqK3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710002084; c=relaxed/simple;
	bh=DQDKbUDAAhaEkqP/f1HxAcFJ7R5k8edp3JBjX62hW+4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LIzopuhOcr3VGtw/XFLPJbPiMu8ijWv6moCxRByGaS+LA6u8ZUGfP70h6LduSfYoZ8V/PmoO+Ni5njVpM4S1CAN8FStcYYTdiVb1VPsnRCCQH5e7jnpEoHrOAJAyzVmWdxDtpIvg6Tr4KYycHr7gaZONTFizja1tcbBo1xOaT2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cQqEUhko; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710002083; x=1741538083;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=DQDKbUDAAhaEkqP/f1HxAcFJ7R5k8edp3JBjX62hW+4=;
  b=cQqEUhkoPSt/+OY+otS+WSwxe0rrM64N+F/5qmzZbV7AGZ7YzF3Zim6p
   V/X2DIHXqX+TQFoWKIVq84sOPJ03O/UDIhTBqIh/1DmT6FtH1hqQbR2eO
   ynFkdiVVRH89YbPM8cXfbHEAoECNb9iQF30Oy7JLJCGs5YnYFLa8bQrY1
   QBdfPhqUMAptHQVGU1bjRtmNK8rZD/PTjZoK6UgZAV9rU2eqvGFzOV4Jq
   khtsA5O0Er2qYsTF4T+Oooqa8vL2bOdlbFBWjABi/2mn9ONAAgcBZUu9V
   yj+ldOio3zziLLBYTVReBf37QlUk1iLG5myHlk1x/mnjBrlVyy7MWy4eY
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11008"; a="22171187"
X-IronPort-AV: E=Sophos;i="6.07,112,1708416000"; 
   d="scan'208";a="22171187"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2024 08:34:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11008"; a="937048341"
X-IronPort-AV: E=Sophos;i="6.07,112,1708416000"; 
   d="scan'208";a="937048341"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 09 Mar 2024 08:34:39 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 897662CB; Sat,  9 Mar 2024 18:34:38 +0200 (EET)
Date: Sat, 9 Mar 2024 18:34:38 +0200
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Dave Hansen <dave.hansen@intel.com>, Andy Lutomirski <luto@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	"Peter Zijlstra (Intel)" <peterz@infradead.org>, the arch/x86 maintainers <x86@kernel.org>, linux-mm@kvack.org, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 2/3] x86/mm: make sure LAM is up-to-date during
 context switching
Message-ID: <o5t3qrrlw37hdkcja2vny3ycpmhb4dowmdj74a2wrq2x4xctqk@5g5jvzen46qe>
References: <20240307133916.3782068-1-yosryahmed@google.com>
 <20240307133916.3782068-3-yosryahmed@google.com>
 <420fcb06-c3c3-4e8f-a82d-be2fb2ef444d@app.fastmail.com>
 <35b670e2-9ef5-4d3a-b6ea-f8016dfa088d@intel.com>
 <ZevHJ5o3G00_nBha@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZevHJ5o3G00_nBha@google.com>

On Sat, Mar 09, 2024 at 02:19:19AM +0000, Yosry Ahmed wrote:
> I don't see how skipping set_tlbstate_lam_mode() for kthreads fixes this
> problem. Do you mind elaborating?

Define what problem is.

Yes, in this scenario kthread gets more permissive LAM mode than it needs.
But nothing breaks.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov


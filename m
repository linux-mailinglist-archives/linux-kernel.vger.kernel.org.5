Return-Path: <linux-kernel+bounces-21704-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 116A0829300
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 05:24:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 95BE3B215E4
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 04:24:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CD3A63B9;
	Wed, 10 Jan 2024 04:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LuEeyAuV"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABBBE6117
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 04:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704860651; x=1736396651;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=cDti/wCs6rkD3xX+F00Cv6MwqIm3ji7E9FlSEIu2f3A=;
  b=LuEeyAuVBrI90Xmt4Y6QP/+E6YEUG4MQ2FqDQawTBPm4yAjpTEZQk/Ur
   /i0cNsHBMIA2x89oaiG/q3r2gHz0foTD+moxN0acl3tWiOvtC1tycSKMa
   poFkgnkiNCPc3gWnRlfoizuPhaQIMc3R8/kwSXoguKKEZHPpGjgHbHzgy
   ZrIEXQEsY3r1ZXD7mfkuBIcCihmtde0DlISmsZuXnocvdJ6t/1MYaOnKF
   Lu8hQhKUq2iz2ulnsW9URWanoKx/WZxZGuMjIIekX9ZI/adglZ3iTUfxo
   mAAkdQDMcWhevuggKmgwMPbaJIW13E9y88/L4geOWcmZX7LdoZUtmEGa/
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="395562661"
X-IronPort-AV: E=Sophos;i="6.04,184,1695711600"; 
   d="scan'208";a="395562661"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2024 20:24:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,184,1695711600"; 
   d="scan'208";a="16503453"
Received: from tassilo.jf.intel.com (HELO tassilo) ([10.54.38.190])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2024 20:24:11 -0800
Date: Tue, 9 Jan 2024 20:24:09 -0800
From: Andi Kleen <ak@linux.intel.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/mtrr: Check if fixed MTRRs exist before saving them
Message-ID: <ZZ4b6aq6s_GbpbcN@tassilo>
References: <20240105163711.9278-1-ak@linux.intel.com>
 <87plyajphp.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87plyajphp.ffs@tglx>

On Tue, Jan 09, 2024 at 08:06:26PM +0100, Thomas Gleixner wrote:
> On Fri, Jan 05 2024 at 08:37, Andi Kleen wrote:
> > This one place forgot to check the fixed capability.
> 
> What's the consequence of that missing chec

You get a WARN_ON for a WRMSR failing if you don't have the MSR.

> and shouldn't this have a Fixes tag?

It's more an ancient bug back dating back to my tenure in 2007, but here it is:

Fixes: 2b1f6278d77c ("[PATCH] x86: Save the MTRRs of the BSP before")

-Andi


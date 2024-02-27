Return-Path: <linux-kernel+bounces-84023-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A7E786A17F
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 22:22:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BA5F2B22B4A
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 21:21:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B2A214EFFD;
	Tue, 27 Feb 2024 21:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PhFEbu9g"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F05E51C4C
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 21:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709068907; cv=none; b=Qb5oFmaga0OxHL2CznntxAs1iNr46YDmzNw1MypxsK9kL0awiv0hxjAFkZazNk/fLR91gOYMrIDFtJc0iqSUPkvt+OJYML7FWX+ww8hHTdwuH4nMGJ3BQKyxpFBsCf4ttfUoK0/b8SgYedC8/pi9RAwdeghzoC9zRLybzXMmBdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709068907; c=relaxed/simple;
	bh=3yo6NVAS2DQ8uW8SbPYTo+nl5dHAveFgn5FWpm9zTbU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WmkHdn4RlifgUWOLXTq2XqVFwPL05nqh/HpKHJfwvDJjon7gbxX0kl2Dw+1KROb7mrKSexD0UL7pJNIyezxV3P7cIRC9Gd74t838z6Q3duobLFMS++gKJG5VGAuVoHedsRwcRQQ4ogd2dynSb7Ou8xB0nL0A6+sPIXbWTupntnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PhFEbu9g; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709068907; x=1740604907;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3yo6NVAS2DQ8uW8SbPYTo+nl5dHAveFgn5FWpm9zTbU=;
  b=PhFEbu9gziJkgbSo/VD1FOaLK/4Y73BJi02Z+8sYDhivXHGY/DZCCpW3
   sl7/8TLz+vdcL5pGhBm1QtFa8rMNBRhRyz/GAW9f8gbcmhqONnww5xISB
   HZff1EYLipdZlFfyO8FL1gYPdCznqE7rBtMg0OpaGG/jVn/NrEj7qjsfC
   oFeU9q7asUgP0aaVAiEl7cglqN+l/doEUP/dfe4lk0sD3hgn/yqdvkgmh
   cCGnFeiRDMoam3ZP6bYo1gCtrfPMry/0XIraZgxL7eVpIrTwXxNNQAs2E
   Hj0dmnY8dMgIIx2zmc71PKNebjaihj3b2MeAra0ufRbpAI8cebLFhmJmp
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="3566519"
X-IronPort-AV: E=Sophos;i="6.06,188,1705392000"; 
   d="scan'208";a="3566519"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2024 13:21:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="937032879"
X-IronPort-AV: E=Sophos;i="6.06,188,1705392000"; 
   d="scan'208";a="937032879"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 27 Feb 2024 13:21:40 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id B0AE12E6; Tue, 27 Feb 2024 23:21:39 +0200 (EET)
Date: Tue, 27 Feb 2024 23:21:39 +0200
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, Elena Reshetova <elena.reshetova@intel.com>, 
	Jun Nakajima <jun.nakajima@intel.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, "Kalra, Ashish" <ashish.kalra@amd.com>, 
	Sean Christopherson <seanjc@google.com>, "Huang, Kai" <kai.huang@intel.com>, Baoquan He <bhe@redhat.com>, 
	kexec@lists.infradead.org, linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv8 00/16] x86/tdx: Add kexec support
Message-ID: <cael54ieynou5fskoeea72wjt4yfttwv23emgog2gopl7j4mq2@tis765ccaqpm>
References: <20240227181616.3032032-1-kirill.shutemov@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240227181616.3032032-1-kirill.shutemov@linux.intel.com>

Please disregard. I've sent old patches by mistake.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov


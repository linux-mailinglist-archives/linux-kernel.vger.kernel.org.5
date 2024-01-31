Return-Path: <linux-kernel+bounces-47224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DD4B4844AAF
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 23:04:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1AFC61C21603
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 22:04:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CD2539FC7;
	Wed, 31 Jan 2024 22:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DD3qzf4i"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45777374F1
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 22:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.134.136.31
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706738646; cv=none; b=EfmK4yG7OOD9B5NkaxZGiX09TEv7cu682dp0fP+eWWkDXgBzWX9dnb5CPCkc/i3t62rH+ZmeVBSjc1rNjYXcnK2fTJPjdAoJTpIxkLpRxDQh5rRWCqxt7k3R5x0kOw5N7FOqyo8wedgqVlynJvZ2eW8hPkYjR17AKWKcjRnHysA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706738646; c=relaxed/simple;
	bh=QsbMchd88EV33UXYPAzC4sXUtwgesAtaPWm/veSFP/8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SvN/NnUi5Xcwh3cYKqA5jITGlD+4APqDI5T0REjkN6Etp15knpswQhZr6pwtB42+njx9q/h5z3DllieU/lMTbhCYqTFIIeB3u51GyoMAnCb+wKD4n/iT4eV11mysMBY9JaUbQFXXKfAd/bfI0c4Ma5VWWT01tebi8Il4uN1vTWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DD3qzf4i; arc=none smtp.client-ip=134.134.136.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706738645; x=1738274645;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=QsbMchd88EV33UXYPAzC4sXUtwgesAtaPWm/veSFP/8=;
  b=DD3qzf4iDE7R33VCeXAHGfMiNpzSDHinRJrwqrLXGd7R4pmCJo969Ebq
   JDuo7TuY6mWnVD61UFZRrouuXDWo2WmYD6GhXhCnxugYop6Uu7eKry/DV
   TAqt+DEs5lM3Io7DucPLDLmsGjjhhmw5YAQfFSZU3mg6bPMntAWIiR77u
   xIPybTUpCf7JmX2RZ3ofamj9r1bknR7yvnsEWa84E4B6Cx72EzlslrpSq
   8HLk231dWjRGN5jzgzHtBAt8Y3wTWu9h8dIsmK3BQKbWHDzttlC9fqJ5q
   QDKTQRmjHLOAVGgAWrIsLvp3bSPEVpiEqP9Pq+/4B8wmt4cVEziSC/xVQ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="467973417"
X-IronPort-AV: E=Sophos;i="6.05,233,1701158400"; 
   d="scan'208";a="467973417"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2024 14:04:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="908034612"
X-IronPort-AV: E=Sophos;i="6.05,233,1701158400"; 
   d="scan'208";a="908034612"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 31 Jan 2024 14:04:00 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 3445739B; Thu,  1 Feb 2024 00:03:59 +0200 (EET)
Date: Thu, 1 Feb 2024 00:03:59 +0200
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Dave Hansen <dave.hansen@intel.com>
Cc: "Huang, Kai" <kai.huang@intel.com>, linux-kernel@vger.kernel.org, 
	x86@kernel.org, tglx@linutronix.de, bp@alien8.de, mingo@redhat.com, 
	hpa@zytor.com, luto@kernel.org, peterz@infradead.org, thomas.lendacky@amd.com, 
	chao.gao@intel.com, bhe@redhat.com, nik.borisov@suse.com, pbonzini@redhat.com
Subject: Re: [PATCH 3/4] x86/kexec(): Reset TDX private memory on platforms
 with TDX erratum
Message-ID: <l3uo3n3li27czehll2wz34xxkcv5j2vcshgp5a6w7u4h4aidpu@4oe2cwye2e6z>
References: <cover.1706698706.git.kai.huang@intel.com>
 <b52ed259e0d487b3a968b98da91cb4f55a28ae82.1706698706.git.kai.huang@intel.com>
 <12a927df-e437-40ff-ba4d-ceca5446c5b1@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <12a927df-e437-40ff-ba4d-ceca5446c5b1@intel.com>

On Wed, Jan 31, 2024 at 01:21:39PM -0800, Dave Hansen wrote:
> >  #ifdef CONFIG_KEXEC_JUMP
> >  	if (image->preserve_context)
> >  		save_processor_state();
> > +	else
> > +		tdx_reset_memory();
> > +#else
> > +	tdx_reset_memory();
> >  #endif
> 
> Wow, that's awfully hard to read.  I really wish folks' gag reflex would
> kick in when they see stuff like this to get them to spend an additional
> 15 seconds to turn this into:
> 
> 	if (IS_ENABLED(CONFIG_KEXEC_JUMP) && image->preserve_context)
> 		save_processor_state();
> 	else
> 		tdx_reset_memory();

save_processor_state() is declared under CONFIG_PM_SLEEP, so I guess your
variant might break build in some cases without updated suspend.h.
-- 
  Kiryl Shutsemau / Kirill A. Shutemov


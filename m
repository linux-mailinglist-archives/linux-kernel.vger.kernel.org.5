Return-Path: <linux-kernel+bounces-162562-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 698EB8B5D61
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 17:22:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25E98281DD5
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 15:22:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E28B784FA7;
	Mon, 29 Apr 2024 15:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LbISdxnS"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBAD384FB1
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 15:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714403842; cv=none; b=tuXTvihgDWHYFiIiko3MPsx928lhxwNKgpHiw02wDGTsDY9DszofV/efRb76NFwRzsdfX/x38yvIHa/XKeph6mJ4qBDB5WkKo7xD1utAHHECD24EASV2ans7tpQtXONT6IKGmu8DlyoHqy6zDbmSgaRv5g+P/s/TeIW4qpE2l/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714403842; c=relaxed/simple;
	bh=MlSlRGaYiem3SuUQO4BAsBy3xzf+/yW9MMNWdq/F60Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CMAAidnW2sd2PbjG6PHpMo1BXErrhPkB16++SpTAUXHQsPGtQ+HjGja9bgisHXgDRYC72dzGglwM6pa0bY0KfHObTZQfUZBKmlLOhtzsZXchDiewYd/6rZU0FxZU37fLNhDoLjBMfdx/bjWrYYqjksKQEcrhvdsplrsSy57OdZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LbISdxnS; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714403842; x=1745939842;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MlSlRGaYiem3SuUQO4BAsBy3xzf+/yW9MMNWdq/F60Y=;
  b=LbISdxnSrmWPCv4ZuDaEPbUtejCg5JXzFijVLYfTmqsbnoMKRTl5RnZO
   rTIMfa8b7AHGAAJkKTtWmY/vrQ+Ys40ZaHYnZOf8WNeTv9M5mHmSvpDFq
   gatYl13jq4RwjKpx1Hy189jUrzzFLYGQeff5s/E7RgfR898CjzZRYKD4H
   DO1BPRdjEEVdjlHYGvX4RAKhWMNzo9Dqx1qfMznTsZDYkwj4ggn46vA/W
   gi7tSnSd+PoVOWxtes1e8veLSPLLykyffU/abSuTQHBatMy7lpHfG2FzM
   ha9BiSd5sSVQIR17T/giyR/ieK/jKjjNhtYDOv9SBCVdlcBlrUnib+1ux
   Q==;
X-CSE-ConnectionGUID: XFsWaQvoSI+i/m4vgXsn6g==
X-CSE-MsgGUID: Oi2dCnQrR2WTSKvs3tfMvw==
X-IronPort-AV: E=McAfee;i="6600,9927,11059"; a="10187909"
X-IronPort-AV: E=Sophos;i="6.07,239,1708416000"; 
   d="scan'208";a="10187909"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2024 08:17:01 -0700
X-CSE-ConnectionGUID: 3l6VczyNSXi1e+hlJ02smw==
X-CSE-MsgGUID: sLGm4kwkThqjbQ/IHUUlBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,239,1708416000"; 
   d="scan'208";a="26098655"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa009.fm.intel.com with ESMTP; 29 Apr 2024 08:16:56 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id D0D851A0; Mon, 29 Apr 2024 18:16:54 +0300 (EEST)
Date: Mon, 29 Apr 2024 18:16:54 +0300
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Borislav Petkov <bp@alien8.de>
Cc: Sean Christopherson <seanjc@google.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, Elena Reshetova <elena.reshetova@intel.com>, 
	Jun Nakajima <jun.nakajima@intel.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Ashish Kalra <ashish.kalra@amd.com>, 
	Kai Huang <kai.huang@intel.com>, Baoquan He <bhe@redhat.com>, kexec@lists.infradead.org, 
	linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv10 05/18] x86/kexec: Keep CR4.MCE set during kexec for
 TDX guest
Message-ID: <yh7wbdce5o35l4nkrkml3jp7tyzvzxwnfji2vmvnvaczsl6gdr@6qnwpw7g76a3>
References: <20240409113010.465412-1-kirill.shutemov@linux.intel.com>
 <20240409113010.465412-6-kirill.shutemov@linux.intel.com>
 <ZhVPIDDLkjOB96fI@google.com>
 <3q6jv3g4tezybmd667mqxio7ty22akxv7okrznmzx3tju2u4qo@2alzjkbgm2lh>
 <20240428171111.GKZi6DLy_ZwuZsZdFq@fat_crate.local>
 <e35yxpa2xdynm7focg6k4u2bjzojn24bmeaszh2jz52e4szc5f@6mgtrdnkewhe>
 <20240429144454.GHZi-yZkD0boKk5N17@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240429144454.GHZi-yZkD0boKk5N17@fat_crate.local>

On Mon, Apr 29, 2024 at 04:45:08PM +0200, Borislav Petkov wrote:
> On Mon, Apr 29, 2024 at 04:17:38PM +0300, Kirill A. Shutemov wrote:
> > As I mentioned above, clearing CR4.MCE triggers #VE. It is quirk of the
> > platform.
> 
> You mean when identity_mapped() runs as part of a kexec-ed kernel, it
> might clear CR4.MCE and that would trigger the #VE?

Yes, that's what happens in current upstream.

> So, if that is correct, you basically want to *preserve* the CR4.MCE
> setting across kexec?

Yes.

> But then __mcheck_cpu_init_generic() will go and set it
> unconditionally.

__mcheck_cpu_init_generic() will not change anything in this case as the
bit is already set. Everything is hunky-dory.

> So what exactly is the correct flow here?

TDX guest has CR4.MCE set from time 0 and it has to stay this way all the
time including kexec flow.

We have already modified early boot code to preserve CR4.MCE. See
77a512e35db7 ("x86/boot: Avoid #VE during boot for TDX platforms").
The patch extends it to kexec flow.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov


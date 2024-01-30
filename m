Return-Path: <linux-kernel+bounces-44815-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 804DD8427C4
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 16:15:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 378701F278DF
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 15:15:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E0A08121A;
	Tue, 30 Jan 2024 15:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A/LvQMKK"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 541FE6D1A8
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 15:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.55.52.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706627730; cv=none; b=rXkPzRj8eTYGcHphuqElMdbcYL1cwJt4e26ruNA/1vBesaf7SSg6F0NZ5C9qhnnZh5mpHqFiBhNlju4zG9CDUTFmEGCU3mC+vI7M5sqtFSbnnAlHgWW5yWAtbJyZuvN7amZCP/7PFycfbMN7pkjxqL87dvCrYAe/EpS9exCQxD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706627730; c=relaxed/simple;
	bh=cg4Vqit6KxU2rQTAj377CjGsVM4isPa7zNpJYoTP4as=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FFSDSLMs7HkK67CpnsrfgSc9LMpEHiUkn99M5NLwLZ2gwcQYfRc8if5qSRsyZKOyO989IytNQdThC63JIaqpBLdLWKofnweoMZoRHFAmLi6qRCv/ENU2dQ35yZ4R8DyHjBWfE3tiZwFIgX+vUoVeqWUxcC3KpXDlkFYG8gnnKyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A/LvQMKK; arc=none smtp.client-ip=192.55.52.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706627729; x=1738163729;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=cg4Vqit6KxU2rQTAj377CjGsVM4isPa7zNpJYoTP4as=;
  b=A/LvQMKKosaoNYic0i05z2Ua9dRzxELSBlZrPPtYhlBI6ObUbKJwtbWe
   7g968SEiVYVy6x4yEhQDXp/FTF7YiGvOanusgEFMJLnz1Ey3yImJs9Tox
   2nDM6NlYUgBVzYLcLsmZDi50Gw+3NuLdnUCgDKjI28xfm5Fo6+y7AftmG
   n6lHXF7gToG6uCkctAGGg19NXk1M1k3j67YhQ+6y0VDd49Bku9Onlu8GE
   J+x08bbUaRtW2kUjAqr1Ic2YrgdcaeKIMC0CsOEi5+JqM/xZcxHY6TDEA
   TyNfqdJio/O6fv0BpITKbkUIHPKsqJQMvNsJy2dZhjKWwPcOckUKGFHFG
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10968"; a="434482028"
X-IronPort-AV: E=Sophos;i="6.05,707,1701158400"; 
   d="scan'208";a="434482028"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2024 07:15:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10968"; a="737804714"
X-IronPort-AV: E=Sophos;i="6.05,707,1701158400"; 
   d="scan'208";a="737804714"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 30 Jan 2024 07:15:22 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 5FA15DE; Tue, 30 Jan 2024 17:15:21 +0200 (EET)
Date: Tue, 30 Jan 2024 17:15:21 +0200
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, 
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, Elena Reshetova <elena.reshetova@intel.com>, 
	Jun Nakajima <jun.nakajima@intel.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, "Kalra, Ashish" <ashish.kalra@amd.com>, 
	Sean Christopherson <seanjc@google.com>, "Huang, Kai" <kai.huang@intel.com>, Baoquan He <bhe@redhat.com>, 
	kexec@lists.infradead.org, linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv6 00/16] x86/tdx: Add kexec support
Message-ID: <qj3arfigftoolcdptm2yzqwufs6ywp2snqme5wknkt3odkon45@h76u2hnrswlq>
References: <20240124125557.493675-1-kirill.shutemov@linux.intel.com>
 <3f44458f-2b4a-4464-a3df-cb791298dafc@redhat.com>
 <g7jh422ild6c23hjxvf7q2xtygkumbpynz4hcops7nvg5izvpp@r3oyhvssph2o>
 <CABgObfZiyx8hRsD37xZq5TNs9sRq48vLUxbOKa=HZ1vcr67sWQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABgObfZiyx8hRsD37xZq5TNs9sRq48vLUxbOKa=HZ1vcr67sWQ@mail.gmail.com>

On Tue, Jan 30, 2024 at 03:59:34PM +0100, Paolo Bonzini wrote:
> On Tue, Jan 30, 2024 at 3:34 PM Kirill A. Shutemov
> <kirill.shutemov@linux.intel.com> wrote:
> >
> > On Tue, Jan 30, 2024 at 02:43:15PM +0100, Paolo Bonzini wrote:
> > > On 1/24/24 13:55, Kirill A. Shutemov wrote:
> > > > The patchset adds bits and pieces to get kexec (and crashkernel) work on
> > > > TDX guest.
> > > >
> > > > The last patch implements CPU offlining according to the approved ACPI
> > > > spec change poposal[1]. It unlocks kexec with all CPUs visible in the target
> > > > kernel. It requires BIOS-side enabling. If it missing we fallback to booting
> > > > 2nd kernel with single CPU.
> > > >
> > > > Please review. I would be glad for any feedback.
> > >
> > > Hi Kirill,
> > >
> > > I have a very basic question: is there a reason why this series does not
> > > revert commit cb8eb06d50fc, "x86/virt/tdx: Disable TDX host support when
> > > kexec is enabled"?
> >
> > My patchset enables kexec for TDX guest. The commit you refer blocks kexec
> > for host. TDX host and guest have totally different problems with handling
> > kexec. Kai looks on how to get host kexec functional.
> 
> Yeah, that was right there in the cover letter (and I should have
> gotten a clue from the many references to CC_* constants...). Somebody
> pointed me to this series as "the TDX kexec series from Intel" and I
> had some tunnel vision issues. Sorry for the noise!
> 
> But since I have your attention, do you have a pointer to the
> corresponding edk2 series?

Relevant code can be found here:

https://github.com/tianocore/edk2-staging/commits/tdvf-kexec/

-- 
  Kiryl Shutsemau / Kirill A. Shutemov


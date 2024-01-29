Return-Path: <linux-kernel+bounces-43483-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CDDFD841498
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 21:44:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F27C1F23370
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 20:44:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57CCB159576;
	Mon, 29 Jan 2024 20:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iQ9gsx7u"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEE061534EB
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 20:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706561054; cv=none; b=XyqV12AVH2fYxpdTluo+1mqlYWNcTJcE5ZnPCjFY1LisTOKfcEK/Fw8FXSbocHPkTnf/CEBpp0YMl8fO9lOSPEO3QJpvLivwflN1oKOk7NisKJ+AaV5OP1whCUyDCmubsAfHiIGHWT4p7MmupiPz2CtwDuiQoKNneb9W67oejNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706561054; c=relaxed/simple;
	bh=Elo6Kas6QgeP8iJYfbZQ29s6uVogIsyKYcHhQDUTX4w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VxJJSN0VymY8lyFr1NRwQ4X+MAiH8xH9viMiSqQKkDZDVUy91lQfF9CMdQTfmFqBuwlc67wjn2Bv6VhpxZZWPK4z+utgS8hQvOcQDAzzF6hQlogd16K4VU1haZy8m8PB+Nu4uMUGK1ko5yr4Uen1esu19FeU0q5WxjX6OlA9/Vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iQ9gsx7u; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706561053; x=1738097053;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Elo6Kas6QgeP8iJYfbZQ29s6uVogIsyKYcHhQDUTX4w=;
  b=iQ9gsx7uYHD3Ow405moXh8YF/f8oPpayxZTt/D9tYublkUhRIX36oIvP
   5HA1jvzwDCLrIfYf69ApCFXdw+vaUaMm7huZHyHFK2cEjROr0veGttdEQ
   N9pIkP7g+PMaPlEODJiCPN/PLole5wjukZijYffmTjoHsUYgqj2DFIy8N
   mRj/IqVXFi80dk/5w//skIfqpeM5QTDpYnv2nNoGkaPJ6Zz0DfHAdVWTY
   ro5W/pmfmCXNvFT8EUKUt6I4B8gDK7ZNx6G7qKeSWDSNDfOVz2ymWJR5H
   YuLALJ/sH8zyByDPmJiUuWhAPSTq5RmPUORUTucKx96Xd9Z1PFHAmTpHg
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10968"; a="2913273"
X-IronPort-AV: E=Sophos;i="6.05,227,1701158400"; 
   d="scan'208";a="2913273"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2024 12:44:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10968"; a="858241427"
X-IronPort-AV: E=Sophos;i="6.05,227,1701158400"; 
   d="scan'208";a="858241427"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga004.fm.intel.com with ESMTP; 29 Jan 2024 12:44:07 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id E906FFF; Mon, 29 Jan 2024 22:26:06 +0200 (EET)
Date: Mon, 29 Jan 2024 22:26:06 +0200
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
	"H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Theodore Ts'o <tytso@mit.edu>, 
	"Jason A. Donenfeld" <Jason@zx2c4.com>, 
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, Elena Reshetova <elena.reshetova@intel.com>, 
	Jun Nakajima <jun.nakajima@intel.com>, Tom Lendacky <thomas.lendacky@amd.com>, 
	"Kalra, Ashish" <ashish.kalra@amd.com>, Sean Christopherson <seanjc@google.com>, 
	linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [RFC] Randomness on confidential computing platforms
Message-ID: <dlhffyn7cccn5d4uvubggkrmtyxl4jodj5ukffafpsxsnqini3@5rcbybumab4c>
References: <20240126134230.1166943-1-kirill.shutemov@linux.intel.com>
 <276aaeee-cb01-47d3-a3bf-f8fa2e59016c@intel.com>
 <dqiaimv3qqh77cfm2huzja4vsho3jls7vjmnwgda7enw633ke2@qiqrdnno75a7>
 <f5236e76-27d0-4a90-bde5-513ac9446184@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f5236e76-27d0-4a90-bde5-513ac9446184@intel.com>

On Mon, Jan 29, 2024 at 10:55:38AM -0800, Dave Hansen wrote:
> On 1/29/24 08:41, Kirill A. Shutemov wrote:
> > On Mon, Jan 29, 2024 at 08:30:11AM -0800, Dave Hansen wrote:
> >> On 1/26/24 05:42, Kirill A. Shutemov wrote:
> >>> 3. Panic after enough re-tries of RDRAND/RDSEED instructions fail.
> >>>    Another DoS variant against the Guest.
> >>
> >> I think Sean was going down the same path, but I really dislike the idea
> >> of having TDX-specific (or CoCo-specific) policy here.
> >>
> >> How about we WARN_ON() RDRAND/RDSEED going bonkers?  The paranoid folks
> >> can turn on panic_on_warn, if they haven't already.
> > 
> > Sure, we can do it for kernel, but we have no control on what userspace
> > does.
> > 
> > Sensible userspace on RDRAND/RDSEED failure should fallback to kernel
> > asking for random bytes, but who knows if it happens in practice
> > everywhere.
> > 
> > Do we care?
> 
> I want to make sure I understand the scenario:
> 
>  1. We're running in a guest under TDX (or SEV-SNP)
>  2. The VMM (or somebody) is attacking the guest by eating all the
>     hardware entropy and RDRAND is effectively busted
>  3. Assuming kernel-based panic_on_warn and WARN_ON() rdrand_long()
>     failure, that rdrand_long() never gets called.

Never gets called during attack. It can be used before and after.

>  4. Userspace is using RDRAND output in some critical place like key
>     generation and is not checking it for failure, nor mixing it with
>     entropy from any other source
>  5. Userspace uses the failed RDRAND output to generate a key
>  6. Someone exploits the horrible key
> 
> Is that it?

Yes.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov


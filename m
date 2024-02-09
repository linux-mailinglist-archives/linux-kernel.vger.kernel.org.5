Return-Path: <linux-kernel+bounces-59947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 597F284FDC2
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 21:37:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DCE1C1F2B195
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 20:37:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB392CA66;
	Fri,  9 Feb 2024 20:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EX0cVzvS"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C41D11CA1
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 20:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707511046; cv=none; b=oFQjjmm7PPz9MsOh+Ahr8C9oiWE0t18pnTqlFz88fykQt3hbP4mHkOb+enNm/Z18xIThpOy12YmJBm4xj88J65KT6rFOmcECzYqs1UUWx8xT0f1wvL3B8rA73+5ta51cEQ8v3yIhyLqRY0Fqv6tjC4VPs5CS8cPZSSdjUs79/f0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707511046; c=relaxed/simple;
	bh=+jakRoEvADGltt2rjt8cuiOk6U4xLU0Ovul21Y+4JsY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ljf3VmrfYGFpty3ZBDksC4jIdiiI1/FQEFl8SXuvzzM8mJ96Y9xiungtE75xwkJQL9wPqgiOyhTuymc7PtnJN00CNiQ0ADOBUhm2PofzC1ZblNFiJZOWBd3A//tFiF+GwFy8FA9lwmS/6VKewx7k+k+u6PfQDvQ02gnnL3pbqc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EX0cVzvS; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707511044; x=1739047044;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=+jakRoEvADGltt2rjt8cuiOk6U4xLU0Ovul21Y+4JsY=;
  b=EX0cVzvS58WGBL3zCTxo6pnuXtdwJC2020nfyAc3pZrRTODktJ1Xphg6
   SZXWQLf5xcKuiIQSTGluaA/IfsrSRLg8AsH/MTYp1dXnYXdlXOGrcEzQI
   u66TCCasOaUo4rW3/twnxM2i/Als/SoIciAjYRrleSA81YBlMy7NmThnM
   y1cB1sSgDJnrdJOBmCKXa7/bePkcCbGYxo36o8+rsjD6u+8SrfTOqkiKF
   RBzxy3C8A05x1gICQQYDfGgvFU9tfW6einJyj7eajayoaZIRxCzy/6o+Q
   9QoGiY8DgAGKdSB5ZBOov8buWNJ9uN/ilGLxyBd1UYS4XPnUdeUvIhGnD
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10979"; a="12227232"
X-IronPort-AV: E=Sophos;i="6.05,257,1701158400"; 
   d="scan'208";a="12227232"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2024 12:37:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,257,1701158400"; 
   d="scan'208";a="39470158"
Received: from pkdiveka-mobl.amr.corp.intel.com (HELO [10.212.136.53]) ([10.212.136.53])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2024 12:37:23 -0800
Message-ID: <469bd890-36fb-4fbb-8060-36cd1169b654@intel.com>
Date: Fri, 9 Feb 2024 12:37:22 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] x86/random: Issue a warning if RDRAND or RDSEED fails
Content-Language: en-US
To: "Jason A. Donenfeld" <Jason@zx2c4.com>, Borislav Petkov <bp@alien8.de>
Cc: "Dr. Greg" <greg@enjellic.com>, "Daniel P. Berrang??"
 <berrange@redhat.com>, "Reshetova, Elena" <elena.reshetova@intel.com>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>,
 "x86@kernel.org" <x86@kernel.org>, Theodore Ts'o <tytso@mit.edu>,
 Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
 "Nakajima, Jun" <jun.nakajima@intel.com>,
 Tom Lendacky <thomas.lendacky@amd.com>, "Kalra, Ashish"
 <ashish.kalra@amd.com>, Sean Christopherson <seanjc@google.com>,
 "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <DM8PR11MB57507611D651E6D7CBC2A2F3E77D2@DM8PR11MB5750.namprd11.prod.outlook.com>
 <88a72370-e300-4bbc-8077-acd1cc831fe7@intel.com>
 <CAHmME9oSQbd3V8+qR0e9oPb7ppO=E7GrCW-a2RN8QNdY_ARbSQ@mail.gmail.com>
 <Zbk6h0ogqeInLa_1@redhat.com>
 <DM8PR11MB575052B985CA97B29A443F9AE77C2@DM8PR11MB5750.namprd11.prod.outlook.com>
 <20240206011247.GA29224@wind.enjellic.com> <ZcHoKUElwXGPzrWb@redhat.com>
 <20240206120445.GA1247@wind.enjellic.com>
 <20240206153529.GHZcJRwTdDkWXuopOQ@fat_crate.local>
 <20240208114444.GA23164@wind.enjellic.com>
 <20240209173102.GBZcZhVuFJZ8JOKTjG@fat_crate.local>
 <CAHmME9pEVNM6UVW+pKbTZEhsnrGvq5ERMOSC1ezdrCn96q36kA@mail.gmail.com>
From: Dave Hansen <dave.hansen@intel.com>
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
In-Reply-To: <CAHmME9pEVNM6UVW+pKbTZEhsnrGvq5ERMOSC1ezdrCn96q36kA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/9/24 11:49, Jason A. Donenfeld wrote:
> [As an aside, I would like to note that a different construction of
> RDRAND could keep outputting good random numbers for a reeeeeallly
> long time without needing to reseed, or without penalty if RDSEED is
> depleted, and so could be made to actually never fail. But given the
> design goals of RDRAND, this kind of crypto is highly likely to never
> be implemented, so I'm not even moving to suggest that AMD/Intel just
> 'fix' the crypto design goals of the instruction. It's not gonna
> happen for lots of reasons.]

Intel's RDRAND reseeding behavior is spelled out here:

> https://www.intel.com/content/www/us/en/developer/articles/guide/intel-digital-random-number-generator-drng-software-implementation-guide.html

In the "Guaranteeing DBRG Reseeding" section.

> It's a bit of a scheduling/queueing thing, where different security
> contexts shouldn't be able to starve others out of the finite resource
> indefinitely.
> 
> What I'm wondering is if that kind of fairness is even possible to
> achieve in the hardware or the microcode.
..

Even ignoring different security contexts, Intel's whitepaper claims
that no starvation happens with RDRAND:

> If multiple threads are invoking RDRAND simultaneously, total RDRAND
> throughput (across all threads) scales approximately linearly with
> the number of threads until no more hardware threads remain, the bus
> limits of the processor are reached, or the DRNG interface is fully
> saturated. Past this point, the maximum throughput is divided equally
> among the active threads. No threads get starved.

800 MB/sec of total RDRAND throughput across all threads, guaranteed
reseeding, and no starvation sounds pretty good to me.

Does that need improving?


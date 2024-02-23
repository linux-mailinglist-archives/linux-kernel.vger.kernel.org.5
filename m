Return-Path: <linux-kernel+bounces-78245-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 51C318610A7
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 12:42:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 839DF1C22549
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 11:42:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7524D664D7;
	Fri, 23 Feb 2024 11:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LUIqoF4d"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D4761758D
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 11:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708688568; cv=none; b=iR0WPv9N2uACfERykryniKluR5dk7E+3iglf8LwFkwJ/o2jQHBs5KU05hhKYMRWzvaMEVzE3BNe34D6D/MzL/IsHadDs+Np2bYjrojmn780J8cSnpe3ra+GZheC8mX4Xf42XAeDD88Wjr5uuINYZF/bA2FoUqpOueDtfOlJzgAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708688568; c=relaxed/simple;
	bh=vdBaLCWVdyZ71ZZvVpVhOOJKh3hy3RP5Mn3l/HmMOeE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HYwL+PWaDyZu4h8R4V5gEeV3mgTs5hkRoe9VfsqMmxO2FhND4xT3C5sD03uGSzlXsoD+LWyDJBMsLqMkjJkZ/oMDCXIka0N5MkqsbEwKKFXmYzcKECJQJJ/QcYRh/AbRXdWLJoGCYLwmAbHBEBdYDyaqRJ5PS8qjRNgerTwaBFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LUIqoF4d; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708688567; x=1740224567;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vdBaLCWVdyZ71ZZvVpVhOOJKh3hy3RP5Mn3l/HmMOeE=;
  b=LUIqoF4dTX9FpaeS5+xx0/2nesPUGNqrObi0OCggM9RqIBIHNj6jki7p
   EJLs9N9lDzxrxZ2A6UDFhVRt9djtntokwePQ2dwzTjwdjzX7enjCVD3cX
   2CAHBQTHbqJos/S5ROugV2yl8WD3epjfo04yV1ooAl4O1YEyWm6lCk1LH
   2LsfC6hDzK3riUXM5+bkl2wvq5dFVl2isCo6Gc/FnL0tISwIthcN19FyG
   Qt0aMGt1VuSUr5pM8qqWKIGMTQlG5SCpc1Gn13Io/gybvelsWgAsogSNJ
   lE8DG6BLez9NoH/OOyhg8rMxK8j5h8iAAJOjYal6eNDIDy7AM3552tNHW
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10992"; a="6784593"
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="6784593"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2024 03:41:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10992"; a="937024666"
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="937024666"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 23 Feb 2024 03:41:03 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id A491734C; Fri, 23 Feb 2024 13:41:01 +0200 (EET)
Date: Fri, 23 Feb 2024 13:41:01 +0200
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Dave Hansen <dave.hansen@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, pbonzini@redhat.com, tglx@linutronix.de, 
	x86@kernel.org, bp@alien8.de
Subject: Re: [RFC][PATCH 12/34] x86/cpu/intel: Actually use "address
 configuration" infrastructure for MKTME
Message-ID: <o5axftuoav5b57eu3w2xujur4wumquzpr667jmrq4poxuxxmvf@pvoiyfxyoyen>
References: <20240222183926.517AFCD2@davehans-spike.ostc.intel.com>
 <20240222183942.601EE2E5@davehans-spike.ostc.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240222183942.601EE2E5@davehans-spike.ostc.intel.com>

On Thu, Feb 22, 2024 at 10:39:42AM -0800, Dave Hansen wrote:
> 
> From: Dave Hansen <dave.hansen@linux.intel.com>
> 
> Now that the TME detection is only called once at boot, stop twiddling
> 'boot_cpu_data' directly and move over to 'bsp_addr_config'.
> 
> Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
> ---
> 
>  b/arch/x86/kernel/cpu/intel.c |    7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff -puN arch/x86/kernel/cpu/intel.c~intel-addr-reduce arch/x86/kernel/cpu/intel.c
> --- a/arch/x86/kernel/cpu/intel.c~intel-addr-reduce	2024-02-22 10:08:54.296682462 -0800
> +++ b/arch/x86/kernel/cpu/intel.c	2024-02-22 10:08:54.296682462 -0800
> @@ -401,11 +401,8 @@ detect_keyid_bits:
>  		mktme_status = MKTME_ENABLED;
>  	}
>  
> -	/*
> -	 * KeyID bits effectively lower the number of physical address
> -	 * bits.  Update cpuinfo_x86::x86_phys_bits accordingly.
> -	 */
> -	c->x86_phys_bits -= keyid_bits;
> +	/* KeyID bits effectively lower the number of physical address bits */
> +	bsp_addr_config.phys_addr_reduction_bits = keyid_bits;

Do we expect reduction_bits to stack? Like can multiple features steal
physical bits? Make use "+= keyid_bits" here?

-- 
  Kiryl Shutsemau / Kirill A. Shutemov


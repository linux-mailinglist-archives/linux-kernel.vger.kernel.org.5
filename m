Return-Path: <linux-kernel+bounces-41376-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2684483EFC7
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 20:35:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8C0B2852F6
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 19:35:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A2462E62D;
	Sat, 27 Jan 2024 19:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KY1n42pR"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 428E4B665
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jan 2024 19:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706384149; cv=none; b=kc3uy8bwc5gd9XPRIgx75lC4VA1j3Gq46frUEh4nIcvF8ToP8Yu2m6Kx7Rihpfhu0OHIH3Nqxkuxdd1HK0Amimwh3kpn1nQg/K4bsBmHnsIKfocYuzh5dj+4gGxN0kCLAWfHG1i7O+4gG+zj6/Z7gQ4GBNIxKJQfRnp0OWHZYwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706384149; c=relaxed/simple;
	bh=JsNjDeEosD68W82IVuf9LcDq0mJQmIvRYnUGnYlOl5o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uDkuKLjHKS/J4VcjRvBWzkX+bFC16/Iza6BHGRASQqDl4o/DMtQ8GgdXVVbFRwVIubv5cWV3yukwKOufkFVDo3J3GHtg1c6drePNKk/0hnw3ss+LXGz47rp2zoEZZyKUloTejyvSdS0awQeTmfY+EgVyouWsSSGubAV9u+wcYDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KY1n42pR; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706384148; x=1737920148;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JsNjDeEosD68W82IVuf9LcDq0mJQmIvRYnUGnYlOl5o=;
  b=KY1n42pRnqWZGCl3hAfgZS8po/RzROOdaOBw/VNiRu+JC57iG4rkuzB+
   CRtdEwQMfXIpD60dq/jzauNYrvJCSTBjDQQ0a24xYsic+1QADHG8gHD0M
   E69ieG47upBoZMJDHtWdkWuSjTm3v/2kSvXspQwbCaQnL7CMJj0S8Hw+N
   9LidgCWXVHmfYlhU2RBmp3//LxSbMSLijGXQcZ6COWuBLUx9gaylZWN45
   lx0lF9PvfW2i7g1X0rPplTn7UZvtQjy0HDZvnrZ9r2Aa8YO7CvI5iUbx1
   ilh3Yx5c21734Z5U+hG6WXJNQuQjOY9IOCEYJrr2fNTPRIJnxWt+16FOI
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10966"; a="16071603"
X-IronPort-AV: E=Sophos;i="6.05,220,1701158400"; 
   d="scan'208";a="16071603"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2024 11:35:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10966"; a="787430462"
X-IronPort-AV: E=Sophos;i="6.05,220,1701158400"; 
   d="scan'208";a="787430462"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 27 Jan 2024 11:35:42 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 21D451F1; Sat, 27 Jan 2024 21:35:41 +0200 (EET)
Date: Sat, 27 Jan 2024 21:35:41 +0200
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: 
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Elena Reshetova <elena.reshetova@intel.com>, 
	Jun Nakajima <jun.nakajima@intel.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, "Kalra, Ashish" <ashish.kalra@amd.com>, 
	Sean Christopherson <seanjc@google.com>, "Huang, Kai" <kai.huang@intel.com>, Baoquan He <bhe@redhat.com>, 
	kexec@lists.infradead.org, linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv6 16/16] x86/acpi: Add support for CPU offlining for ACPI
 MADT wakeup method
Message-ID: <vfk7v6ywaclyydshucnnuvsyg6e6sntyzimgqgjc7ye77z2ukr@lk4e3wz4ap3y>
References: <20240124125557.493675-1-kirill.shutemov@linux.intel.com>
 <20240124125557.493675-17-kirill.shutemov@linux.intel.com>
 <4aa2c961-a0dc-45dc-b996-57c8468660df@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4aa2c961-a0dc-45dc-b996-57c8468660df@linux.intel.com>

On Fri, Jan 26, 2024 at 12:03:14PM -0800, Kuppuswamy Sathyanarayanan wrote:
> > +	/* Don't wait longer than a second. */
> > +	timeout = USEC_PER_SEC;
> > +	while (READ_ONCE(acpi_mp_wake_mailbox->command) && --timeout)
> > +		udelay(1);
> > +
> > +	if (!timeout)
> Nit: IMO, since you are dumping failure error message (not timeout
> message), you can use non zero acpi_mp_wake_mailbox->command
> check. But it is up to you.

I think my version is pretty idiomatic. The same pattern used in other
places. For instance, test_nmi_ipi().
-- 
  Kiryl Shutsemau / Kirill A. Shutemov


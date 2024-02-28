Return-Path: <linux-kernel+bounces-85256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B6FF686B2FD
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 16:22:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C2F51F24FD9
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 15:22:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26FE915B98B;
	Wed, 28 Feb 2024 15:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aAPFYLJV"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E60C815B96C
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 15:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709133764; cv=none; b=G/CnfWA4whePXAyV9SBfooWIr+mSnzs0CJaQQcdh2le6sSy6jbJKw1SRoVNtWSfdJ2uc4LTw/R3QCLG8EbR5QHhc+gPPgmhvBNiZqb2wpSKL3WwNhV6Sdrb5+URn+wKX1ehPSuTvkPePjRh59CEas42Yd2UEU4+x+YI3c87nQac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709133764; c=relaxed/simple;
	bh=pVo3nZ1TRQ7aysEs3qhN7ATzV2rZ6Gtlgvl+QzdEatc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u61t0oKxkpslIbvbpF4QnE60kZDlVyLowb/nlyDVnMRMScV3a//dEyi0TJaUQaUdAKRGJfDLf+HSMlIl0+qmbDl1XtnC+NbP+Mv2d51BTIGmkQlYNia0Eyjo8nDd5f55c/+x8LnvZ7zsgyQdB6j/ZfoxVXdXcAlXFTj4/kPWEGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aAPFYLJV; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709133764; x=1740669764;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=pVo3nZ1TRQ7aysEs3qhN7ATzV2rZ6Gtlgvl+QzdEatc=;
  b=aAPFYLJVMAeHq0gV6LJWmfUfL3KCTFXlscM3hv1pl44ugA4QmTVY55XV
   ouQQf80ANsOSaFc/R9xj5nX2OyXzCRCEMdNajE7mAt9Imb0nMJHZiTXVL
   R5isg9QmTWpolqrXdz9TRn4ey5WomGPLSTkL6kRky7UUXQVwYdTua+YGj
   XfjnaNh/0Wt8jejUuNa3NJv3AkuuO8HDaJaqoL6WWUNyhG8gZJ58SUfPI
   eQwSi6TaavxCIdM8zgjOiIdtbV1+OE3wU7xBwdE5cc3XbCc+fJ5hFI5xE
   DAEQuarC6XEb8Jl9851iw7aokd/GFDFIyytPdDFkT5NjhKdrcUjy3axB0
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10998"; a="14088124"
X-IronPort-AV: E=Sophos;i="6.06,190,1705392000"; 
   d="scan'208";a="14088124"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2024 07:22:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10998"; a="937034395"
X-IronPort-AV: E=Sophos;i="6.06,190,1705392000"; 
   d="scan'208";a="937034395"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 28 Feb 2024 07:22:31 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id BCEB228A; Wed, 28 Feb 2024 17:22:30 +0200 (EET)
Date: Wed, 28 Feb 2024 17:22:30 +0200
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: "Huang, Kai" <kai.huang@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, 
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, Elena Reshetova <elena.reshetova@intel.com>, 
	Jun Nakajima <jun.nakajima@intel.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, "Kalra, Ashish" <ashish.kalra@amd.com>, 
	Sean Christopherson <seanjc@google.com>, Baoquan He <bhe@redhat.com>, kexec@lists.infradead.org, 
	linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv8 17/17] ACPI: tables: Print MULTIPROC_WAKEUP when MADT
 is parsed
Message-ID: <3jgmzzbjmwtf2rtrbiulhwjj5xwzc3icf4gxcmugyyq5n7pg5m@ua3poay4gmku>
References: <20240227212452.3228893-1-kirill.shutemov@linux.intel.com>
 <20240227212452.3228893-18-kirill.shutemov@linux.intel.com>
 <0a633c22-8426-42cf-9572-7812ffc75d0a@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0a633c22-8426-42cf-9572-7812ffc75d0a@intel.com>

On Wed, Feb 28, 2024 at 11:08:38AM +1300, Huang, Kai wrote:
> 
> 
> On 28/02/2024 10:24 am, Kirill A. Shutemov wrote:
> > When MADT is parsed, print MULTIPROC_WAKEUP information:
> > 
> > ACPI: MP Wakeup (version[1], mailbox[0x7fffd000], reset[0x7fffe068])
> > 
> > This debug information will be very helpful during bring up.
> > 
> > Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > Reviewed-by: Baoquan He <bhe@redhat.com>
> > ---
> >   drivers/acpi/tables.c | 14 ++++++++++++++
> >   1 file changed, 14 insertions(+)
> > 
> > diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
> > index b07f7d091d13..c59a3617bca7 100644
> > --- a/drivers/acpi/tables.c
> > +++ b/drivers/acpi/tables.c
> > @@ -198,6 +198,20 @@ void acpi_table_print_madt_entry(struct acpi_subtable_header *header)
> >   		}
> >   		break;
> > +	case ACPI_MADT_TYPE_MULTIPROC_WAKEUP:
> > +		{
> > +			struct acpi_madt_multiproc_wakeup *p =
> > +				(struct acpi_madt_multiproc_wakeup *)header;
> > +			u64 reset_vector = 0;
> > +
> > +			if (p->version >= ACPI_MADT_MP_WAKEUP_VERSION_V1)
> > +				reset_vector = p->reset_vector;
> > +
> > +			pr_debug("MP Wakeup (version[%d], mailbox[%#llx], reset[%#llx])\n",
> > +				 p->version, p->mailbox_address, reset_vector);
> > +		}
> > +		break;
> > +
> 
> Hmm.. I hate to say, but maybe it is better to put this patch at some early
> place in this series w/o mailbox version and reset_vector, and add
> incremental changes where mailbox/reset_vector is introduced in this series.
> 
> The advantage is in this way someone can just backport this patch to the old
> kernel if they care -- this should be part of commit f39642d0dbacd
> ("x86/acpi/x86/boot: Add multiprocessor wake-up support") anyway.

It is not subject for backporting. It is just a cosmetics fix (or debug
facility). Any new MADT type would generate a warning. Nothing wrong with
it.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov


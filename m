Return-Path: <linux-kernel+bounces-27276-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D36582ED27
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 11:53:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A8211F238A0
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 10:53:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89484199A3;
	Tue, 16 Jan 2024 10:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KbEWUu1G"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C68319445
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 10:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705402413; x=1736938413;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kwLew776p5vzcGbpOZt4QJk08QQAHvX8ubIV3cyIJIw=;
  b=KbEWUu1Ge8ZpC9QZ67NOETkzeOOGaG3IBJPCpG05thxetqI5xUEf8L2n
   1aWfXn7RsfgPVKYc8hEiNSIVIdyKXgFogJgYtWB7SkCX7xMQlgIKMSxqs
   7Udf97MCChaqGtZzTb9LPQIMkgun23HoZZGZdt4Q94EbStc3TAgQZlV0V
   XxR+efB8VF3x3SjDsl/2yEJd0Rlk8Ogpv4M280/MYN3aex54cd75SFeDv
   3k1BlUYy1URBelVtrputZRf83xEnKzH9i5ubGvvhvvfdeeIZYeFmEPUzQ
   NGr17oMO4nRUfl/ipD5whBZTI/fhAfm1wDJJHbar8BXLgbvHFleD8bqUU
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10954"; a="396983666"
X-IronPort-AV: E=Sophos;i="6.04,198,1695711600"; 
   d="scan'208";a="396983666"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2024 02:53:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10954"; a="818134005"
X-IronPort-AV: E=Sophos;i="6.04,198,1695711600"; 
   d="scan'208";a="818134005"
Received: from uschumac-mobl2.ger.corp.intel.com (HELO box.shutemov.name) ([10.251.213.254])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2024 02:53:27 -0800
Received: by box.shutemov.name (Postfix, from userid 1000)
	id BBABD10A17B; Tue, 16 Jan 2024 13:53:24 +0300 (+03)
Date: Tue, 16 Jan 2024 13:53:24 +0300
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Nikolay Borisov <nik.borisov@suse.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Elena Reshetova <elena.reshetova@intel.com>,
	Jun Nakajima <jun.nakajima@intel.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	"Kalra, Ashish" <ashish.kalra@amd.com>,
	Sean Christopherson <seanjc@google.com>,
	"Huang, Kai" <kai.huang@intel.com>, Baoquan He <bhe@redhat.com>,
	kexec@lists.infradead.org, linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCHv5 10/16] x86/tdx: Convert shared memory back to private
 on kexec
Message-ID: <20240116105324.5kz6b2b6cbv6g4xn@box.shutemov.name>
References: <20231222235209.32143-1-kirill.shutemov@linux.intel.com>
 <20231222235209.32143-11-kirill.shutemov@linux.intel.com>
 <89e8722b-661b-4319-8018-06705b366c62@suse.com>
 <20240116072822.pvzseyqry56eqa4j@box.shutemov.name>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240116072822.pvzseyqry56eqa4j@box.shutemov.name>

On Tue, Jan 16, 2024 at 10:28:22AM +0300, Kirill A. Shutemov wrote:
> > > @@ -809,12 +823,25 @@ static bool tdx_enc_status_changed(unsigned long vaddr, int numpages, bool enc)
> > >   static int tdx_enc_status_change_prepare(unsigned long vaddr, int numpages,
> > >   					 bool enc)
> > >   {
> > > +	atomic_inc(&conversions_in_progress);
> > > +
> > > +	/*
> > > +	 * Check after bumping conversions_in_progress to serialize
> > > +	 * against tdx_shutdown().

s/tdx_shutdown/tdx_kexec_stop_conversion/

> > > +	 */
> > > +	if (!conversion_allowed) {
> > > +		atomic_dec(&conversions_in_progress);
> > > +		return -EBUSY;
> > > +	}
> > 
> > nit: Can you make the inc of conversions_in_progress be done here, this
> > eliminated the atomic_dec in case they aren't. Somewhat simplifies the
> > logic.
> 
> Okay, fair enough. Will change.

Actually, no, it will breaks serialization.

Consider following scenario (includes change you proposed):

	    CPU0			      CPU1

tdx_enc_status_change_prepare()
  if (!conversion_allowed) // false
					tdx_kexec_stop_conversion()
					  conversion_allowed = false;
					  <...>
					  <return as no conversion in flight>
  <continue with conversion>

Incrementing conversion_in_progress before checking conversion_allowed
will make tdx_kexec_stop_conversion() to spin until CPU0 is done with
conversion.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov


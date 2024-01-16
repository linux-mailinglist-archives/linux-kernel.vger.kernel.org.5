Return-Path: <linux-kernel+bounces-27265-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 63F3782ECEB
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 11:46:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17F481F21D3E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 10:46:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D095618C18;
	Tue, 16 Jan 2024 10:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i67mAgAz"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE8DD18C16
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 10:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705401956; x=1736937956;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=U149l/P2gQncQeTKVFG2mholC+8inxIjrWVzckSmZk0=;
  b=i67mAgAznK8e2Gn+v9ebF/vQyY85UzOE+4us0/5X52CYHqur8Qf0VgSX
   iPqUqYdzQGPdBnJQtss99GhVvwL6DVnVauRWhp4ZQLPqW4honnzJx2Zmy
   pdPn7YUiZa/Po4pySteSJYJFMjqwZbRa5sPweaeDgNqEqW+v0Hxdx5jnv
   A1/ECTuzBxLgI6SjPyx2vfEFwfceZqNXeF7S2b2rUZHu+ZoZQwHRhrVx/
   MzpfnVyhHhukG/fIifV+OLeA6eXZNnj196DfX7xAgyHzXiQDn4EZjgFou
   OFOArZCvUO7JAgeRumAFYUPeswnsltLlpCBiRDehK7V6suOD2umlLwe1L
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10954"; a="399493504"
X-IronPort-AV: E=Sophos;i="6.04,198,1695711600"; 
   d="scan'208";a="399493504"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2024 02:45:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10954"; a="787403940"
X-IronPort-AV: E=Sophos;i="6.04,198,1695711600"; 
   d="scan'208";a="787403940"
Received: from uschumac-mobl2.ger.corp.intel.com (HELO box.shutemov.name) ([10.251.213.254])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2024 02:45:51 -0800
Received: by box.shutemov.name (Postfix, from userid 1000)
	id 7226210A17B; Tue, 16 Jan 2024 13:45:48 +0300 (+03)
Date: Tue, 16 Jan 2024 13:45:48 +0300
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
Message-ID: <20240116104548.4jmku5pq34p4lqn6@box.shutemov.name>
References: <20231222235209.32143-1-kirill.shutemov@linux.intel.com>
 <20231222235209.32143-11-kirill.shutemov@linux.intel.com>
 <89e8722b-661b-4319-8018-06705b366c62@suse.com>
 <20240116072822.pvzseyqry56eqa4j@box.shutemov.name>
 <bad09d97-d99b-4231-a481-c14ed0f8d59d@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bad09d97-d99b-4231-a481-c14ed0f8d59d@suse.com>

On Tue, Jan 16, 2024 at 10:01:47AM +0200, Nikolay Borisov wrote:
> 
> 
> On 16.01.24 г. 9:28 ч., Kirill A. Shutemov wrote:
> 
> <snip>
> 
> > > > @@ -41,6 +44,9 @@
> > > >    static atomic_long_t nr_shared;
> > > > +static atomic_t conversions_in_progress;
> > > > +static bool conversion_allowed = true;
> > > 
> > > Given the usage model of this variable, shouldn't it be simply accessed via
> > > READ/WRITE_ONCE macros?
> > 
> > What do you see it changing?
> 
> 
> Serving as documentation that you are accessing a shared variable without an
> explicit lock (unless I'm missing something). conversion_allowed can be read
> by multiple threads, no ? And it's written by a single thread?

I don't think READ_ONCE()/WRITE_ONCE() have documentation sense you imply.

I would argue adding them will add more confusion as they serve no purpose
in this context: issuing multiple loads/stores for the variable have no
impact on outcome.

> > kexec on AMD will not work without them, I think. But noops makes sense
> > anyway. Will fix.
> 
> I'm not disputing whether those are needed for AMD or not, that way I see it
> you make those callbacks mandatory in the case of CC_ATTR_GUEST_MEM_ENCRYPT
> being present, yet only implement them for TDX. So in the case of AMD they
> will be NULL and so AMD with kexec enabled (albeit erroneously) will crash,
> no ?

As I said, I will fix it.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov


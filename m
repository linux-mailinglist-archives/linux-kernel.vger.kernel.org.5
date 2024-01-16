Return-Path: <linux-kernel+bounces-27048-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C16882E9B0
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 07:51:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29FD01F23D71
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 06:51:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1444211198;
	Tue, 16 Jan 2024 06:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f+wjo1Py"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DE1210A3C
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 06:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705387862; x=1736923862;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=OPysNPwhIAnQcyfr8stWiSetUkU3Df0caepIuGAELpQ=;
  b=f+wjo1PyeSZNm+MdCutB69AEtDUkQoumvidaBXt7OeYXFXa7wqkdCCON
   pkf/noYX/8EuSRQUjvsSY7gWi12jDlHUIBmhjoWiRn8kLMZQSDpmRxhT6
   t/ARliqJ5L+hroSNIUb3FJj3aJTuYxJzOVbW4y/8yEoNnZ5IVnhAnbsmr
   cVdgEl1e3HwFSPSogA6wzQgBt4iR9Wyy4MCIPR/6x7bRTPIRUqkmmtnkW
   8JhizHbSasSfoiNK+OnFmo3n4QzVmzHHN67uLthdap0C5Qx2Fo7VqMQR1
   bxZp5fF7W6Rx0RM8GJTvMAnL+dnMooL7vhicuQxoclCabYIG9tz460boH
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10954"; a="6488761"
X-IronPort-AV: E=Sophos;i="6.04,198,1695711600"; 
   d="scan'208";a="6488761"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2024 22:51:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,198,1695711600"; 
   d="scan'208";a="25688932"
Received: from uschumac-mobl2.ger.corp.intel.com (HELO box.shutemov.name) ([10.251.213.254])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2024 22:50:57 -0800
Received: by box.shutemov.name (Postfix, from userid 1000)
	id 55B9010A17B; Tue, 16 Jan 2024 09:50:53 +0300 (+03)
Date: Tue, 16 Jan 2024 09:50:53 +0300
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
Subject: Re: [PATCHv5 16/16] x86/acpi: Add support for CPU offlining for ACPI
 MADT wakeup method
Message-ID: <20240116065053.7a6omvqi3jmncppg@box.shutemov.name>
References: <20231222235209.32143-1-kirill.shutemov@linux.intel.com>
 <20231222235209.32143-17-kirill.shutemov@linux.intel.com>
 <fa1e3873-6218-461b-85fa-1ff353380532@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fa1e3873-6218-461b-85fa-1ff353380532@suse.com>

On Mon, Jan 15, 2024 at 03:19:43PM +0200, Nikolay Borisov wrote:
> > +	/* Switch to identity mapping */
> > +	movq	%rsi, %rax
> > +	movq	%rax, %cr3
> 
> nit: Can't you move directly to cr3

For some reason, I thought I couldn't. Will fix.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov


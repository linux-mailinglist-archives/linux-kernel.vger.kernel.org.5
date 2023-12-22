Return-Path: <linux-kernel+bounces-9912-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 51CAF81CD28
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 17:34:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DE7A284869
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 16:34:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 320DF2556C;
	Fri, 22 Dec 2023 16:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fO+SlFyu"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 191D024A1F
	for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 16:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703262869; x=1734798869;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Nwu0jTUTyUVExiakxdbtIQfJuL2c3K4kO9Pr5Ymd8sQ=;
  b=fO+SlFyuw72KMKXLr1jBPOOFt1KrQ92h2oI63KQbvLW1X+jun1ZjkNHi
   szX8UNjeO8IT8Tpy42j6fNJuX0Wa4YXkvkyasIVj81PPFYptSaOhislU0
   i0QKyZB2qKYaXp8uyOYNpCAkIGSnfRt6+TQpo6xSk7suLe8B+r+foTZt0
   dMUJvwxf036t6St0dOxwi2P6gQ/QUGYddtkCJbKykVK6pslRmyJB0eFfv
   ncvC0TGlqofvcl+xKRCCzAvD/bRH3mbkMnHu8aI1i+ntHvNaJiSnoRDQh
   ZL6ec6B0MdpmazGNb9u4GAtnw5YD09vwbVbD8Rz1O3F0YVHp2XyJgm4DR
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10932"; a="395024981"
X-IronPort-AV: E=Sophos;i="6.04,297,1695711600"; 
   d="scan'208";a="395024981"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2023 08:34:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10932"; a="777082152"
X-IronPort-AV: E=Sophos;i="6.04,297,1695711600"; 
   d="scan'208";a="777082152"
Received: from hassanfa-mobl.ger.corp.intel.com (HELO box.shutemov.name) ([10.252.33.171])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2023 08:34:23 -0800
Received: by box.shutemov.name (Postfix, from userid 1000)
	id EC2FB10945B; Fri, 22 Dec 2023 19:34:20 +0300 (+03)
Date: Fri, 22 Dec 2023 19:34:20 +0300
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
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
Subject: Re: [PATCHv4 14/14] x86/acpi: Add support for CPU offlining for ACPI
 MADT wakeup method
Message-ID: <20231222163420.4mu5kmznfmsave6k@box.shutemov.name>
References: <20231205004510.27164-1-kirill.shutemov@linux.intel.com>
 <20231205004510.27164-15-kirill.shutemov@linux.intel.com>
 <877clfmcpy.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <877clfmcpy.ffs@tglx>

On Fri, Dec 15, 2023 at 09:29:13PM +0100, Thomas Gleixner wrote:
> So this waits and then does nothing if the wait fails. What's the point?
> 
> ...
> <SNIP 170 lines of pagetable muck>
> 
> Do we really need this specific hackery or is there some similar
> identity mapping muck which can be generalized?

I've addressed all your feedback, but this gave me pause. Looks like none
of kernel_ident_mapping_init() users frees memory on failure.

Is it okay to get this part as is and I will follow up with patchset that
fixes memory handling for all kernel_ident_mapping_init() users?

-- 
  Kiryl Shutsemau / Kirill A. Shutemov


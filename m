Return-Path: <linux-kernel+bounces-63950-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 07F368536AA
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 17:57:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B11A6288611
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 16:57:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A0336024B;
	Tue, 13 Feb 2024 16:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n3LMBlIq"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5927060241
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 16:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707843445; cv=none; b=JY7RCS5QvqssqJIq4fwPl/tg9KEzoqSz4BBpsnpLL9ENgoeOXiqgbDyFDlirE6OV4xkqefD7jRsYNdZBF6fUWp3jowa2NEunkXIHipdZrNNTigRxDYsu/3kp+rEbUDNuyblaWnXqoOdCrNBirBU7vBsD0VFj1LXNjSxvM3eLuBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707843445; c=relaxed/simple;
	bh=Jw8FkE8KKiGwtiIUrclqp1VCgjmVOjxfsPjaH1shq0I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g+rNQdOKg/vTyX/C/vD0Ym0CZh/qAxLtUL2LgPmivVoXTb6gKMptxVZBeU8VjcFS6NeNWEIImyELhX03TAd7XrAcvjg56EmRpVci3NJEZQrQodz0445fU1TP0EncfipgsrMT51gxprlBG1/l9dOCEv/wKwMbAT9cUol1OyVfGTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n3LMBlIq; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707843443; x=1739379443;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=Jw8FkE8KKiGwtiIUrclqp1VCgjmVOjxfsPjaH1shq0I=;
  b=n3LMBlIqQWLhdYkhBrkOm/iIRHBUUezec1wedwkB5tFVSJcA3EuRyekm
   8TOW7rMLz44sLKAXrAmvaXpW4MCWZ+UuhkLZIe/AoBDyYIuOPxW1iSOjA
   AfBYjh1CYF7A0RwkhQ3b9Apop+twyeMpbunmSQdj9ieXY2+4+3nBioHuE
   v75yEJIlXn5E+HXT2TIYHHjmgVnG7EucRb+VcUkBH3z5Ee3bCTpsOHLm0
   w4EFL4ZJoCFtp0FpSrqHV6fGBx5XKaN0kWTeRI6TIJif1LVGROsAVc2aq
   cvV90aN+bfYE7EoctEazHT3qDLsci3zknwcyUPbpOQbHXdoj3yo8PlH61
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="4828360"
X-IronPort-AV: E=Sophos;i="6.06,157,1705392000"; 
   d="scan'208";a="4828360"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2024 08:57:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="935398422"
X-IronPort-AV: E=Sophos;i="6.06,157,1705392000"; 
   d="scan'208";a="935398422"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 13 Feb 2024 08:57:20 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 73077184; Tue, 13 Feb 2024 18:57:19 +0200 (EET)
Date: Tue, 13 Feb 2024 18:57:19 +0200
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>, 
	Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Isaku Yamahata <isaku.yamahata@intel.com>, x86@kernel.org, linux-kernel@vger.kernel.org, 
	Juergen Gross <jgross@suse.com>
Subject: Re: [PATCH, RESEND] x86/pat: Simplifying the PAT programming protocol
Message-ID: <vquojgkflafiro5w27qijetm6uat6dfzijq3vszplirselombz@4xeofmdczpif>
References: <20240124130650.496056-1-kirill.shutemov@linux.intel.com>
 <20240131175738.GIZbqKEhlDKhaKfh_w@fat_crate.local>
 <67hqgqargmt6nln5mds672g263lka7glyzbvcdgt4owdg7xc2e@v6wvuizw5ond>
 <20240131202340.GLZbqsTJkeFQycXT0B@fat_crate.local>
 <fvzki5mtpbsoyljy354qnva5rllgukba7iuxufxjttceio5osd@tdvgddwttfqo>
 <20240213161514.GCZcuVku13t8p5wHnj@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240213161514.GCZcuVku13t8p5wHnj@fat_crate.local>

On Tue, Feb 13, 2024 at 05:15:14PM +0100, Borislav Petkov wrote:
> On Thu, Feb 01, 2024 at 12:17:32AM +0200, Kirill A. Shutemov wrote:
> > > So the "relaxation" is the removal of that CR0.CD requirement?
> 
> So I'm looking at the SDM, revisions 081US and 082US.
> 
> Section
> 
> "12.11.8 MTRR Considerations in MP Systems"

The point is that PAT programming doesn't need to follow MTRR
considerations anymore.

Previously "Programming the PAT" section had this:

   The operating system is responsible for ensuring that changes to a PAT
   entry occur in a manner that maintains the consistency of the processor
   caches and translation lookaside buffers (TLB). This is accomplished by
   following the procedure as specified in Section 12.11.8, “MTRR
   Considerations in MP Systems,” for changing the value of an MTRR in a
   multiple processor system. It requires a specific sequence of
   operations that includes flushing the processors caches and TLBs.

The new version points to MTTR consideration as one of possible way to
invalidate TLB and caches:

  The operating system (OS) is responsible for ensuring that changes to a
  PAT entry occur in a manner that maintains the consistency of the
  processor caches and translation lookaside buffers (TLB). It requires the
  OS to invalidate all affected TLB entries (including global entries) and
  all entries in all paging-structure caches. It may also require flushing
  of the processor caches in certain situations. This can be accomplished
  in various ways, including the sequence below or by following the
  procedure specified in Section 12.11.8, “MTRR Considerations in MP
  Systems.” (See Section 4.10.4, “Invalidation of TLBs and
  Paging-Structure Caches” for additional background information.) Also
  note that in a multi-processor environment, it is the software's
  responsibility to resolve differences in conflicting memory types across
  logical processors that may arise from changes to the PAT (e.g., if two
  logical processors map a linear address to the same physical address but
  have PATs that specify a different memory type for that physical
  address).

The new text follows with example of sequence that flushes TLB and
caches. And it doesn't touch CR0.CD.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov


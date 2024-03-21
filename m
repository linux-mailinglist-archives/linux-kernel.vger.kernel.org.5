Return-Path: <linux-kernel+bounces-110185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 99927885B3F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 15:59:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DBDE1F21411
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 14:59:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AD6285C7B;
	Thu, 21 Mar 2024 14:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="diMiwbZP"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E85185959
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 14:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711033142; cv=none; b=JoVUgTeP5V31C4/bbMV25nDxcn6jO/aW/n9TS5Pp8tqRmul6K/pun3TB8+WFSTekvagsi9Grb2fcNUIqWcJrvZXy02RPRFOK90MYrH/Yn+W8+zxyQRoGxJfvFiHK5ly3IlnVP+r+Yub29dHPw7psZH3DA/hmhegs5oEl33fYkog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711033142; c=relaxed/simple;
	bh=7eBq8ekEO6vw2vSin9bneMav1VFWO6ZkBD957BgambQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TwHM1CcJFQ4L5Qlo2Y2pRYez8EaFWNuAfJma1/T3xTN6cmEYfr9ZcX8QKnUj1AUK6hnuO/G/tm+ayZpktEmemyRUG9julB76NqscHzoWtj4IbUnfmonhpq7Z48CmjcJxSgHnxuivz0AmekOPEgRx9uZaHQx6eYxH4V1RYA0r0NM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=diMiwbZP; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711033140; x=1742569140;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7eBq8ekEO6vw2vSin9bneMav1VFWO6ZkBD957BgambQ=;
  b=diMiwbZPNkNHXOLhSHX/rJBLgXAXEpwmZsJ6uIejc2U9bSLINJ9wtzyi
   HqRnVhl7MNfdjpHsLNF1VUMrJqHIOb3Rum1Z1xvVZCmUO+MaYim3+5aCx
   V5x3S7tDeKH3SLruhel8F2UTv5IDDoK+HEvdCl1y3lmy8hIWeOt/nEFgH
   8JaJ8rnn2dPn593YNZjzll4MVatUmefohR1d9i1G/PuVNgHJzhSog5Jse
   LMJdkXteFxPhM4R2Zjt6hQiLEZzt8RwZRLigQ0eSdPXt0K+Oqb2byYdVO
   XBcrpDfmxq822Tj4pW/Yl6B1IDLJBfksk85QSFP8+2IMsAWgbC7mqy1oJ
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11020"; a="5879070"
X-IronPort-AV: E=Sophos;i="6.07,143,1708416000"; 
   d="scan'208";a="5879070"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2024 07:58:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11020"; a="937065372"
X-IronPort-AV: E=Sophos;i="6.07,143,1708416000"; 
   d="scan'208";a="937065372"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 21 Mar 2024 07:58:53 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 7C090791; Thu, 21 Mar 2024 16:58:52 +0200 (EET)
Date: Thu, 21 Mar 2024 16:58:52 +0200
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Ashish Kalra <Ashish.Kalra@amd.com>
Cc: tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com, 
	rafael@kernel.org, peterz@infradead.org, adrian.hunter@intel.com, 
	sathyanarayanan.kuppuswamy@linux.intel.com, elena.reshetova@intel.com, jun.nakajima@intel.com, 
	rick.p.edgecombe@intel.com, thomas.lendacky@amd.com, seanjc@google.com, michael.roth@amd.com, 
	kai.huang@intel.com, bhe@redhat.com, kexec@lists.infradead.org, 
	linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org, bdas@redhat.com, 
	vkuznets@redhat.com, dionnaglaze@google.com, anisinha@redhat.com, jroedel@suse.de
Subject: Re: [PATCH v2 2/3] x86/mm: Do not zap page table entries mapping
 unaccepted memory table during kdump.
Message-ID: <opa56dnwlyllrrnlfrhtbavnwmhxxatiuzifvx3bquv5qksidn@v2qxrvvw53jl>
References: <20240227212452.3228893-1-kirill.shutemov@linux.intel.com>
 <cover.1710744412.git.ashish.kalra@amd.com>
 <8e11825bb3e4a7472bf0cb30c72ae013c25ac8c9.1710744412.git.ashish.kalra@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8e11825bb3e4a7472bf0cb30c72ae013c25ac8c9.1710744412.git.ashish.kalra@amd.com>

On Mon, Mar 18, 2024 at 07:02:45AM +0000, Ashish Kalra wrote:
> From: Ashish Kalra <ashish.kalra@amd.com>
> 
> During crashkernel boot only pre-allocated crash memory is presented as
> E820_TYPE_RAM. This can cause page table entries mapping unaccepted memory
> table to be zapped during phys_pte_init(), phys_pmd_init(), phys_pud_init()
> and phys_p4d_init() as SNP/TDX guest use E820_TYPE_ACPI to store the
> unaccepted memory table and pass it between the kernels on
> kexec/kdump.
> 
> E820_TYPE_ACPI covers not only ACPI data, but also EFI tables and might
> be required by kernel to function properly.
> 
> The problem was discovered during debugging kdump for SNP guest. The
> unaccepted memory table stored with E820_TYPE_ACPI and passed between
> the kernels on kdump was getting zapped as the PMD entry mapping this
> is above the E820_TYPE_RAM range for the reserved crashkernel memory.
> 
> Signed-off-by: Ashish Kalra <ashish.kalra@amd.com>

Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

I guess it would be better if I take this patch into my kexec patchset. I
guess I just got lucky not to step onto the issue.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov


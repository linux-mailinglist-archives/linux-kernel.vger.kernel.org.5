Return-Path: <linux-kernel+bounces-44756-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A7C12842700
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 15:34:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9D4C1C25597
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 14:34:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C89D37C08A;
	Tue, 30 Jan 2024 14:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cWGtrYEx"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D10476901
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 14:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706625265; cv=none; b=ImnBQ6Nk3vw/sQ1na99iiObAbiCHojrl4T+MIknq+8IdF/U3uMElRMIsS24eQIq7WoU1UK8FIC/orG/ma3U+bncB4ZIJ3us1c7TMvPM5FdlaQTTTOlj/nbZfhXFkcp782CkZ7Vi7ztZ0vBfWxej5EoOBfoP3xO5kaIEhWr/p4I8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706625265; c=relaxed/simple;
	bh=eXnTC9Z2V42A4QwsNLM6X9tA1dlLLPk9DhFjZa7uZJw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fdr8qMpXqOGBw4Z1Pzc3OLovsN6k2vhfDzCgmm9Fo38PSbfatRHEKXgRLv/QBCdF0ZpjImuNh1uYtFHKusAZwqzYKjAtpayzHpjp9s8xmybJPtXGp+NSkTbqS6RwVwS9ql9fp80heNlUUoXio+jx1U1ht2CiwlV1UQSGzhhyWNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cWGtrYEx; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706625263; x=1738161263;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=eXnTC9Z2V42A4QwsNLM6X9tA1dlLLPk9DhFjZa7uZJw=;
  b=cWGtrYEx9VY5b11GQNdY0gB42o0HbBg852PcjeiToDCXF5g+jbEPhaHp
   kkmH6kdfUS9gu20tX1S3fyJlLHP3j7DPccqfcvoYZwJEx5W9ET11gMgpa
   6wVP4lBqUzoIDEtv5+1hszyB7JYF2YNm7izzPbBUAcOyJgyeEjBvOXVm2
   Kt9Am6cCOOtEqXWngePlwEu3MQx2iWkOMjceYtJU8Cag0Akf02dXrC8o6
   GYw237g9bTHTnNwotMzTvtf9FL06bvO2gx5XzaU+UeTNxYkWgCmbALO5n
   jwlkChRVGAhTJqNnZI7KBdlt+Z1cKAMArakS/493P/0iBezXSm319KrTx
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10968"; a="2231359"
X-IronPort-AV: E=Sophos;i="6.05,707,1701158400"; 
   d="scan'208";a="2231359"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2024 06:34:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10968"; a="961297757"
X-IronPort-AV: E=Sophos;i="6.05,707,1701158400"; 
   d="scan'208";a="961297757"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga005.jf.intel.com with ESMTP; 30 Jan 2024 06:34:10 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 59D49E6; Tue, 30 Jan 2024 15:55:57 +0200 (EET)
Date: Tue, 30 Jan 2024 15:55:57 +0200
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, 
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, Elena Reshetova <elena.reshetova@intel.com>, 
	Jun Nakajima <jun.nakajima@intel.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, "Kalra, Ashish" <ashish.kalra@amd.com>, 
	Sean Christopherson <seanjc@google.com>, "Huang, Kai" <kai.huang@intel.com>, Baoquan He <bhe@redhat.com>, 
	kexec@lists.infradead.org, linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv6 00/16] x86/tdx: Add kexec support
Message-ID: <g7jh422ild6c23hjxvf7q2xtygkumbpynz4hcops7nvg5izvpp@r3oyhvssph2o>
References: <20240124125557.493675-1-kirill.shutemov@linux.intel.com>
 <3f44458f-2b4a-4464-a3df-cb791298dafc@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3f44458f-2b4a-4464-a3df-cb791298dafc@redhat.com>

On Tue, Jan 30, 2024 at 02:43:15PM +0100, Paolo Bonzini wrote:
> On 1/24/24 13:55, Kirill A. Shutemov wrote:
> > The patchset adds bits and pieces to get kexec (and crashkernel) work on
> > TDX guest.
> > 
> > The last patch implements CPU offlining according to the approved ACPI
> > spec change poposal[1]. It unlocks kexec with all CPUs visible in the target
> > kernel. It requires BIOS-side enabling. If it missing we fallback to booting
> > 2nd kernel with single CPU.
> > 
> > Please review. I would be glad for any feedback.
> 
> Hi Kirill,
> 
> I have a very basic question: is there a reason why this series does not
> revert commit cb8eb06d50fc, "x86/virt/tdx: Disable TDX host support when
> kexec is enabled"?

My patchset enables kexec for TDX guest. The commit you refer blocks kexec
for host. TDX host and guest have totally different problems with handling
kexec. Kai looks on how to get host kexec functional.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov


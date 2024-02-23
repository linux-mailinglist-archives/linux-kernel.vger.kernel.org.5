Return-Path: <linux-kernel+bounces-78223-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CB14861070
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 12:33:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E1241C22518
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 11:33:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4844B78699;
	Fri, 23 Feb 2024 11:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c+KgcuPk"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEDA743168
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 11:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708687986; cv=none; b=R9NdjknfuLj9LBEFHEOs5XWVPO/RRJKWFRB0oqTrrdYFOjKS3dyR4SzFd7b7nYCwKKhV4APwrfH+aLxxxKDIB4wRB+3RCObESw4TmVEyaBdG7EMoBKCexKbf+WzwHomAszkG/MsmS5jQUPHAyz+vXdXhB4Qxl3rnMDLHzVLu8s8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708687986; c=relaxed/simple;
	bh=a2/sWvjONKNTR/WqUBkhrunN18P7D63UFgDsvKVgKGo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oFAZzAA0P9BH5O2gB/PL+sjNBQmRrPOR+X/eYZVQWoUX2gWft2ph83bVDUHhslMT15oU9NNLpA7w4pihsV4PAv4Oumu7/g+7saiBKNbTBp/2JWFl+Z57ezBPGR0F2LLHb48+poN5K1qtb+q86otFoN+5XwihSDtgIbm8u+7LhRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c+KgcuPk; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708687985; x=1740223985;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=a2/sWvjONKNTR/WqUBkhrunN18P7D63UFgDsvKVgKGo=;
  b=c+KgcuPk1ubyAm9fVh1voF6s1Ko5j5BhbdNQ2dyFlfmEFm9w87h1N5EG
   kcvuPbZTZGOKQKzadwoWTSl7IQY1i2oKIBspt8rINaH9Hp8PPexjfGhi9
   d6MWhhz/9qM6Qk8YTbQDzoO1uNohGLspPsUTzEdA+FU1888xxv7gKtVAD
   pQZIZcle52nshO4vTgp8PI6ZXHrA2nZ2bCeii+YQwwAMGuPLAuv3YrqEc
   E2XObfsAO2eRIxn+lln2VQtwliHMeo1rPJ12jRoLrjy+0+01bq8ZtpoBy
   cZsmGRdN0p9W880rG4D7Sr1L1xQ7yxP8mxuNqQ1ClLWxQSMRzcx87kyFv
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10992"; a="6783685"
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="6783685"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2024 03:33:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10992"; a="937024665"
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="937024665"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 23 Feb 2024 03:33:02 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 4A2A41FD; Fri, 23 Feb 2024 13:33:01 +0200 (EET)
Date: Fri, 23 Feb 2024 13:33:01 +0200
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Dave Hansen <dave.hansen@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, pbonzini@redhat.com, tglx@linutronix.de, 
	x86@kernel.org, bp@alien8.de
Subject: Re: [RFC][PATCH 11/34] x86/cpu/intel: Prepare MKTME for "address
 configuration" infrastructure
Message-ID: <z52bbgqxtr7wpa3yqqgbwurb6vx6i7gpddae2rrbxkjasuhnuk@7zsudlb4tw6s>
References: <20240222183926.517AFCD2@davehans-spike.ostc.intel.com>
 <20240222183941.7CB634A5@davehans-spike.ostc.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240222183941.7CB634A5@davehans-spike.ostc.intel.com>

On Thu, Feb 22, 2024 at 10:39:41AM -0800, Dave Hansen wrote:
> 
> From: Dave Hansen <dave.hansen@linux.intel.com>
> 
> Intel also does memory encryption and also fiddles with the physical
> address bits.  This is currently called for *each* CPU, but practically
> only done on the boot CPU because of 'mktme_status'.
> 
> Move it from the "each CPU" ->c_init() function to ->c_bsp_init() where
> the whole thing only gets called once ever.  This also necessitates moving
> detect_tme() and its entourage around in the file.

The state machine around mktme_state doesn't make sense if we only call it
on boot CPU, so detect_tme() can be drastically simplified. I can do it on
top of the patchset.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov


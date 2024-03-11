Return-Path: <linux-kernel+bounces-98785-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D33F877F63
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 13:00:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0902828210F
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 12:00:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A40F3BB2A;
	Mon, 11 Mar 2024 12:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ze6S4hcy"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E30A22C69A
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 12:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710158424; cv=none; b=h4uhCDBsJkkNjQRZIPagfz7L35ZBxkdio2o2f+PqZHvepTDSKEg7Fn7XWKhKbK0ZMtSiePFhDQNia2374WV8nUvurQGNGrc6kDvx/mZkmSaEL4ddEgcRS5mcIhZ316g5xfUOKvVWfjjn7fNXctWsmPGp28SFttaWf7P/M3mUczM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710158424; c=relaxed/simple;
	bh=Zoo+kmO8gOCw/amHg5IRps+Jg843WR/XJP/RNCtFdBo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aMAi65VLYwq8/to304njMlLZHycI03PCfzDuPSRPNRpNd+TX3VNd3ucvhrgfITIMiw0gDzEqqJ1vs9DC2I012BF4YAerdmdCXgyihiN8DLT6xRWWtGqgPNRcZVZQSM9jlkjyyUEYHtP044GI+m1gt3bdv/ir2YvVJKHHvJNgRp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ze6S4hcy; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710158423; x=1741694423;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Zoo+kmO8gOCw/amHg5IRps+Jg843WR/XJP/RNCtFdBo=;
  b=Ze6S4hcyeRcdSsYkygNlnzHayKYUxqv2C/Kg87fytraWNmWOIlZkhu1O
   +YQDKG7E7rhpfSq8x5rBXJv3QvJ1+yvvVWS+rlk/KLx4GeJNQfouQhCmU
   Q96uNB2Xj3YS2xvMVvtgALPSL6ZfwatYC0ZdRC6+y97v9EDowdUVHwCdA
   z7YZL9bEwxrpqSIqlzLJLMPMe1x0WGAmtVtmLJLIoqWIw9aK6gSmn41iN
   W3/XG4Dv0n3zQRwREG+j1ItBIKUk5h22aXfkXtf6a1JfRB8V4DHwqFaS7
   EVbP8iwVixW6XfYC5RSIl6PEDPN94uRt3c81tJWD1HxiJTpT8xjB83NIP
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11009"; a="4676088"
X-IronPort-AV: E=Sophos;i="6.07,116,1708416000"; 
   d="scan'208";a="4676088"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2024 05:00:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11009"; a="937049698"
X-IronPort-AV: E=Sophos;i="6.07,116,1708416000"; 
   d="scan'208";a="937049698"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 11 Mar 2024 05:00:19 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 115F2177; Mon, 11 Mar 2024 14:00:18 +0200 (EET)
Date: Mon, 11 Mar 2024 14:00:17 +0200
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: 
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@intel.com, hpa@zytor.com, seanjc@google.com, ele.reshetova@intel.com, 
	rick.p.edgecombe@intel.com, x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] x86/tdx: Introduce tdg_vm_wr()
Message-ID: <7fyh7qsx6guodh7vxs4luxrh25gdk4ze4cwlg4q2m7ukyqt5ht@t3a7hz2pohdt>
References: <20240309210230.239045-1-kirill.shutemov@linux.intel.com>
 <20240309210230.239045-2-kirill.shutemov@linux.intel.com>
 <CAC41dw-ptOjRuOLefeu2-k_K1sigKVNxRxh+-9SHNooMfH660A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAC41dw-ptOjRuOLefeu2-k_K1sigKVNxRxh+-9SHNooMfH660A@mail.gmail.com>

On Sat, Mar 09, 2024 at 04:02:58PM -0800, Kuppuswamy Sathyanarayanan wrote:
> > +       /* Old value */
> > +       return args.r8;
> 
> Since the update failure will panic, any use for returning the old value?

I don't have any immediate users for the old value, but I can imagine
situation when you need to do something else if your write result in
actual change of setting.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov


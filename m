Return-Path: <linux-kernel+bounces-100264-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C2FC87943D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 13:36:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCCE9282C7B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 12:36:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D5FA56450;
	Tue, 12 Mar 2024 12:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Bx8msQRi"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5B2E811
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 12:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710246986; cv=none; b=mC3mVj+06Z80HLIr8625iW9oIK+wep9C+KlO+3conFQHMM4wcDpiC6lgO/DH/q4dQYmMzsmupWYlDXBSq8+kdfRnWgw35G+odm/DU4W9zI0/qPnuiGN91XDgPMPeQcv8NPKs68Gc/CUGYD3zS1iU5yrxFzvYrEtpkAczUXQy5A0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710246986; c=relaxed/simple;
	bh=Msp8CavuCxkwBzmx3Zc//1lyf8RG9ukhad+UhCA9Vfs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SOIghFCwuVT+HYsunldz2mtAZyrktQEVuj8BogIvWiiFgDyI5DplTlZVFAujNL6tNXbqiJ4g90xlspmSguzkj9dBfAnfOwaj5362ZZfZLb6JwBOk7/b8CaTpoEerItQZTV9K6O5kmAQeCSeb1127up2OuUPkiSJ/Z2j4ZGCcGQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Bx8msQRi; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710246985; x=1741782985;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Msp8CavuCxkwBzmx3Zc//1lyf8RG9ukhad+UhCA9Vfs=;
  b=Bx8msQRiltwUzIBSTne23+gPG0ncSDBHURMp3yCZ4TdrzO2CdOi1L3sT
   IpwFVfegxPD4PPLr//viLWksMeZhQuFNuzKwEdS/vUszFzBMazx5EKEPH
   /ZxUpExQhBnc51AViDDv2M1vASBOuuoL5uoJ7/G3GAJRWfZ82iuJt3qqC
   NvZOh+qUVr4Q0F21VKTGe8DGFlVL+Z+WjpRf0fy70OghXIcwRX7c2uSha
   Avhzgy46Mj/2hzFYN8aYO3JK1Qjco8+lm+Hy95Dv0j24PosM+Yr4skwDV
   TvXVx1eWEqJwiaNPoJ/ZaOwU8FX8PD2wO/BcLcycfMR8ZM8f4HYCi2o/f
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11010"; a="4824019"
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; 
   d="scan'208";a="4824019"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2024 05:36:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11010"; a="937051835"
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; 
   d="scan'208";a="937051835"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 12 Mar 2024 05:36:20 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id A604C27D; Tue, 12 Mar 2024 14:36:19 +0200 (EET)
Date: Tue, 12 Mar 2024 14:36:19 +0200
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Yosry Ahmed <yosryahmed@google.com>
Cc: x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] x86/mm: Cleanup prctl_enable_tagged_addr() nr_bits
 error checking
Message-ID: <jnpv2ijtmiq4ubnimt7ofgq7pjbygyq3ggqsppgqcqvwigdnpr@urnckuntqx2i>
References: <20240312035951.3535980-1-yosryahmed@google.com>
 <20240312035951.3535980-3-yosryahmed@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240312035951.3535980-3-yosryahmed@google.com>

On Tue, Mar 12, 2024 at 03:59:51AM +0000, Yosry Ahmed wrote:
> There are two separate checks in prctl_enable_tagged_addr() that nr_bits
> is in the correct range. The checks are arranged such the correct case
> is sandwiched between both error cases, which do exactly the same thing.
> 
> Simplify the if condition and pull the correct case outside with the
> rest of the success code path.
> 
> Signed-off-by: Yosry Ahmed <yosryahmed@google.com>

Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

-- 
  Kiryl Shutsemau / Kirill A. Shutemov


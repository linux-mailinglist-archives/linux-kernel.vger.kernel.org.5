Return-Path: <linux-kernel+bounces-61123-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF2F3850DB7
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 08:07:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04542282FA3
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 07:07:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44F1B6FCC;
	Mon, 12 Feb 2024 07:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aXSzU+/I"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE02F3C15
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 07:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707721664; cv=none; b=PBly9+k7g60odT+1pKVeUvEkuXw69pgKQw78CJfoGu0EWSSZdEC8ZqI6grwGb+nOkIgmd1mJhuPXWiRUFGcjDp6Laf3Qr5VKW10rIHlilRoATEvpkDB5e7SZSwsGH8JeLQOkFoff43+tNU0ATPE71YA3OpY9Nl+QCBP1EJtrcwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707721664; c=relaxed/simple;
	bh=RCdOiggCm0l00XC8KnOXtFiS/o7OVO9sEQ1asC4jtCM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=daoPJxHe2mAAuryVIZv9OG5HJnbWdcbZIJU87NNgry6SkNrZbgmchc5ofDJCPjXlOsEjhUdR03zXDOqqdXpvw4ey46nidsRas/GYRxzH0sCMQrFvxbY2+V84l2JqtQU5ISDggHn47HDDT7qDLi4/g6wwJsXhcgiq0tdsnCy6PnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aXSzU+/I; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707721663; x=1739257663;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RCdOiggCm0l00XC8KnOXtFiS/o7OVO9sEQ1asC4jtCM=;
  b=aXSzU+/IkpWWgGF82tz6btsNw+uy72ho47TOqVdrMXi1wgL3gZBRAlH+
   bgpaplGz65sEX//d21oDUJjTVT5ylW9ERnF1pmCXc6T4JaovsK+l2b75s
   JIPaM98Zh2jOUYjpTVGqS/sbSMDsxZ16bQUNvmhxTv9Fyti4ZXfihm9Sj
   f13c0YpNTAyVvqrxy6d4QYxbkohqu20L16P8dkqFxFNzQVXCbETpbITrw
   dUNSXAYTnqcT5+uhHiOg6LZUysJs+SHheKHiEKLdPqOgJu5qx4RSCoOGo
   m/D5H7dIYGGeXXX7vQFNZM+O25b0JqLr4zFL9YnqXei/KY1hOeAPkSIyW
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10981"; a="12412233"
X-IronPort-AV: E=Sophos;i="6.05,262,1701158400"; 
   d="scan'208";a="12412233"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2024 23:07:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,262,1701158400"; 
   d="scan'208";a="2518876"
Received: from tassilo.jf.intel.com (HELO tassilo) ([10.54.38.190])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2024 23:07:41 -0800
Date: Sun, 11 Feb 2024 23:07:40 -0800
From: Andi Kleen <ak@linux.intel.com>
To: Bagas Sanjaya <bagasdotme@gmail.com>
Cc: hapter@420blaze.it, mingo@redhat.com, tglx@linutronix.de, bp@alien8.de,
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
	Andrew Morton <akpm@linux-foundation.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Memory Management List <linux-mm@kvack.org>
Subject: Re: arch/x86/kernel/sys_x86_64.c: rationale for 0x40000000 for
 MAP_32BIT's start address?
Message-ID: <ZcnDvPxwd8ELjbtb@tassilo>
References: <a5c2f06ba401cdf13bc87749341b1605@420blaze.it>
 <ZcmF3SrTACMULEPb@archie.me>
 <dc60d456-3f02-4076-8adf-4688cfa03aeb@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dc60d456-3f02-4076-8adf-4688cfa03aeb@gmail.com>

> >> Unfortunately this does not supply a rationale for starting from 0x40000000,
> >> which seems very arbitrary, and the git commit has been there since the
> >> beginning of time (i.e. as far the the git history goes), so the git blame
> >> has not helped much to clarify it. I was also not able to find who "AK" was.
> > 
> > That was from commit 717db2f9f36805 ("[PATCH] x86-64 updates for 2.5.54")
> > in tglx/history.git repo [1], authored by Andi Kleen. Cc'ing him.
> > 
> 
> [1]: https://git.kernel.org/pub/scm/linux/kernel/git/tglx/history.git/commit/arch/x86_64/kernel/sys_x86_64.c?id=717db2f9f36805d85c695771ea7d712812896aa7

I thought the comment was clear? The 1GB start is to avoid conflicts with the brk heap,
which grows up.

The flag is really obsolete, if you want limited relocations there are
better ways to do it that don't limit ASLR. 

It was originally because the custom module loader in X.org didn't support a PLT.


-Andi


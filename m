Return-Path: <linux-kernel+bounces-100483-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B5A4879870
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 16:58:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D799E1F22EC7
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 15:58:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 707AD7D404;
	Tue, 12 Mar 2024 15:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aUMAXtpg"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 511A77D069
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 15:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710259039; cv=none; b=oam5VM9iTkpGTtqowLDIhNjbn8vrg+4F6G3qViu0X6ElgNlFwi9kS1klFM1226Ovlx4vxc7aGIkWeRkmW8N0+OFuRQ/pcglYIc5qYqHLJgMzBtkdv1W31QhQjRnDu5WxQKwUK6G/dGUPkZySEEuhGx33II64Hh32prEpQg0Qd5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710259039; c=relaxed/simple;
	bh=mNMHK1T1QnXwQ0bnvHui2hdAh/gJvX+CqXtKZELLAzU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tg16yP5DYZpgpNNrmk9hSpLOXnKuYl3/nD8ll+sspo/O97odM/FwhwwjqTb3vQUCaMct6xFaxnqwgW2dQm5p0w+pRREc+rnxac1rveNCW8fqkMATitOATXpYXvGmjnrXPN4M0qPSIXbgvX8yHe325LcDCjTmmffdu/V9uQeUfOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aUMAXtpg; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710259038; x=1741795038;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mNMHK1T1QnXwQ0bnvHui2hdAh/gJvX+CqXtKZELLAzU=;
  b=aUMAXtpgXuilFYtqyFV2sdDYJRTjJOxxbuWMTWEG9q4UTDlq15MkHFZX
   0gafHrxn2DXGHNDhZ/RTf0nixVmJpqwtD1+BR05BkpfJG4e8+PbNad6U1
   K42ZzLOMUomgbMz9oA2IJK+kEjyeKK1SLDQH7NSvRHGTBNU1zYcyZZnNi
   ckq1UnmLgObkzS75zFLaewbI1axkdOooA2VTBriKNSxV7p3PWOVqo7OMv
   J5f6lPIgpYcpxFYg5yCPYjQ7+bmCZPQVBNOwUalEuGX+FOmwYtbnd2Av2
   +jOETPMFyulQ4V7pT2YBDnYQBdCC0OzUR3b2+/yYcQ2LqmTHfu3LJU6x8
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11011"; a="15531075"
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; 
   d="scan'208";a="15531075"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2024 08:57:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11011"; a="937051909"
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; 
   d="scan'208";a="937051909"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 12 Mar 2024 08:57:08 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 97E3C2B7; Tue, 12 Mar 2024 17:57:07 +0200 (EET)
Date: Tue, 12 Mar 2024 17:57:07 +0200
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	akpm@linux-foundation.org, x86@kernel.org, bp@alien8.de, brauner@kernel.org, 
	bristot@redhat.com, bsegall@google.com, dave.hansen@linux.intel.com, 
	dianders@chromium.org, dietmar.eggemann@arm.com, eric.devolder@oracle.com, 
	hca@linux.ibm.com, hch@infradead.org, hpa@zytor.com, jacob.jun.pan@linux.intel.com, 
	jgg@ziepe.ca, jpoimboe@kernel.org, jroedel@suse.de, juri.lelli@redhat.com, 
	kent.overstreet@linux.dev, kinseyho@google.com, lstoakes@gmail.com, luto@kernel.org, 
	mgorman@suse.de, mic@digikod.net, michael.christie@oracle.com, mingo@redhat.com, 
	mjguzik@gmail.com, mst@redhat.com, npiggin@gmail.com, peterz@infradead.org, 
	pmladek@suse.com, rick.p.edgecombe@intel.com, rostedt@goodmis.org, 
	surenb@google.com, tglx@linutronix.de, urezki@gmail.com, vincent.guittot@linaro.org, 
	vschneid@redhat.com
Subject: Re: [RFC 05/14] fork: check charging success before zeroing stack
Message-ID: <n7fm2gtlnj76hnlbpmednqpq2nfdrb7lii5gpughsey5omvnxs@mponlekek6ne>
References: <20240311164638.2015063-1-pasha.tatashin@soleen.com>
 <20240311164638.2015063-6-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240311164638.2015063-6-pasha.tatashin@soleen.com>

On Mon, Mar 11, 2024 at 04:46:29PM +0000, Pasha Tatashin wrote:
> No need to do zero cahced stack if memcg charge fails, so move the

Typo.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov


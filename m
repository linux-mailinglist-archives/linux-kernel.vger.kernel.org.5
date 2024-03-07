Return-Path: <linux-kernel+bounces-95940-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 709B4875528
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 18:29:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 896EE1C20965
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 17:29:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61AB1130AF7;
	Thu,  7 Mar 2024 17:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ARi9oqRh"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E5D11DA27
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 17:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709832586; cv=none; b=t/Bfu2v3YRIJ5q+khkBszXCsFFVXjuua5/8l7+LV9GyTSzYKgASFd2A6UV6i12kW9aj7qC/gv7SLQnTjZIDY0eWZ11Q7vey5PYY9anF8lrDe3FNc8PZURRNyw0QJstH9YNZc3jQuLNUZe4SQr56QZA1nldYXJY1UEwZag25K72o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709832586; c=relaxed/simple;
	bh=uxUbV0oMd2fQbX5ovQlDJR2DtR8unKq0norIZwYBo1s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hsW0HaE0CF17ZdMS55BrIsd4t2sxdu9QnnaCWXBaU1cC6x+ainwmO3LOqV/QLLV0a0aGUDOXezYjKeqjNq4Lp24tx+Rsw2HifWudzmGtNK8lDR6tF3m+bmrXrikTN6RtgS/Fpxzqck3wjGI9KdSkIhZRqbDDcMrHktHVIQd9+cY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ARi9oqRh; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709832585; x=1741368585;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=uxUbV0oMd2fQbX5ovQlDJR2DtR8unKq0norIZwYBo1s=;
  b=ARi9oqRhA1CwV+uNwHciehYKt85X1wcvGyVGfQ1nEfIDec9PDyqGC2mR
   3gkQPkfODFH05AGMzHwYhXvK/rXXJjRJjekCjdyTXKzWJP5kmm8PTeqDF
   bgwOWyqHOH18VZUZEGxtCcn8UaY4zo5sge2DEWt0F1qxC4fI7/tjbDHL2
   Ypkk4sFYv2gFe5IJSOUkVGBcigIrqiF2XuFnXmoMzFlQBNPpvkoc0On8f
   WJMt4JZgHGdQh/T2cUleBtaBAjnUte844b0zqOJWMrbWIH66bmYYPVVxT
   +b9P0+Z/gz57OhfkprYw0c3Uc9Eho/ytstk+FncG+sc52GmQBaZeuTTxz
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11006"; a="26987009"
X-IronPort-AV: E=Sophos;i="6.07,107,1708416000"; 
   d="scan'208";a="26987009"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2024 09:29:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11006"; a="937046426"
X-IronPort-AV: E=Sophos;i="6.07,107,1708416000"; 
   d="scan'208";a="937046426"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 07 Mar 2024 09:29:41 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id B9D68128; Thu,  7 Mar 2024 19:29:40 +0200 (EET)
Date: Thu, 7 Mar 2024 19:29:40 +0200
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Andy Lutomirski <luto@kernel.org>, x86@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 2/3] x86/mm: make sure LAM is up-to-date during
 context switching
Message-ID: <tvbgstojgmb5jerhrdwbhknuhhbwmq2pqkb4lxyo3htdynioee@poos2yt52xg2>
References: <20240307133916.3782068-1-yosryahmed@google.com>
 <20240307133916.3782068-3-yosryahmed@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240307133916.3782068-3-yosryahmed@google.com>

On Thu, Mar 07, 2024 at 01:39:15PM +0000, Yosry Ahmed wrote:
> During context switching, if we are not switching to new mm and no TLB
> flush is needed, we do not write CR3. However, it is possible that a
> user thread enables LAM while a kthread is running on a different CPU
> with the old LAM CR3 mask. If the kthread context switches into any
> thread of that user process, it may not write CR3 with the new LAM mask,
> which would cause the user thread to run with a misconfigured CR3 that
> disables LAM on the CPU.

I don't think it is possible. As I said we can only enable LAM when the
process has single thread. If it enables LAM concurrently with kernel
thread and kernel thread gets control on the same CPU after the userspace
thread of the same process LAM is already going to be enabled. No need in
special handling.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov


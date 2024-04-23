Return-Path: <linux-kernel+bounces-155743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FC108AF680
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 20:27:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8D4F0B227C0
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 18:27:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83CFB13E89B;
	Tue, 23 Apr 2024 18:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EOX2r18C"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7637B13CAA0
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 18:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713896833; cv=none; b=PQHs6oG78wjsRd+dpuwQhs2ALGLHTcvqLTKBsXiaoXVSJ0Z+WFJfZBGQ4bfXUKtEPHdWhv5ZrWUTx0JxxP8GkFSG7pOKAt/BSQH3KGCDFu7CYf9F/iYOnhI9hNkFX6CB86KKeFZNjSZDYQ3NQ90ynfYaNmcSws9oFAbb7X1eBws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713896833; c=relaxed/simple;
	bh=Lk7VycwmGvCZjbAAwt/L6renm7YzvX/n9HKi03awkdo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DYtR4ohwpt/jjqAdQ9zDKcXZEExYTHdn1x92FhZv3F7MjJmnA+b7VlnbtzNFY5x7Fg1xN3WPS/XrddrYJSYTNWl5hJVF/47BK4PEehdTBcBj6uT5sYAU0eDas4RQn7tvIguBJkEklhA2GqbsRjSFpcx61wml6M6an0pgkVToD0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EOX2r18C; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713896832; x=1745432832;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Lk7VycwmGvCZjbAAwt/L6renm7YzvX/n9HKi03awkdo=;
  b=EOX2r18C2916cfMc+YJ/ioykeTKON4rfrTxT4SAlRANKp9xvNWmRRA0H
   IrmYEL7/+6bdegJQYWCyO09nnHOkZ8ydbfXFt8SbRUeEV/2CzBtX3vvGx
   EgLUativ7oyXzVLriYFEnhHN3a7FSoLzL56Tahu4l/XIx7IEIhaGfd/zU
   7pQKW3WuaIgfLF1iwmP06su2yvlPHEkl8Z8IYqom3PeKtlXn9kMHdZ+Uk
   DLJOIzihiVsinPhT4CqG3gYSr+eZMNnd+wnef5G5YpyQrs3E6pwflXqI2
   K5PZ98fmH/qTjHH/ZpeHWJF8rArH0QIkoz2D/acLAqqDoXYMaSHn5ixOn
   g==;
X-CSE-ConnectionGUID: pSE5Mab4Rp2TmnC7JfH2bA==
X-CSE-MsgGUID: oZs2JnfPRpGuaXtagL5dYg==
X-IronPort-AV: E=McAfee;i="6600,9927,11053"; a="9350890"
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="9350890"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2024 11:27:11 -0700
X-CSE-ConnectionGUID: C3h4PbPBT92bOWbiY3yfFA==
X-CSE-MsgGUID: YT3HDgReQn+PXP80GhgySw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="29255465"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2024 11:27:10 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rzKrD-00000000QuI-39qS;
	Tue, 23 Apr 2024 21:27:07 +0300
Date: Tue, 23 Apr 2024 21:27:07 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [PATCH v2 1/1] mm: page_alloc: Avoid defining unused function
Message-ID: <Zif9e5ByqBKJ9rgQ@smile.fi.intel.com>
References: <20240423161506.2637177-1-andriy.shevchenko@linux.intel.com>
 <20240423111000.aaf74252a07d7e7fd56d7e12@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240423111000.aaf74252a07d7e7fd56d7e12@linux-foundation.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Apr 23, 2024 at 11:10:00AM -0700, Andrew Morton wrote:
> On Tue, 23 Apr 2024 19:14:43 +0300 Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> > In some configurations I got
> > mm/page_alloc.c:656:20: warning: unused function 'add_to_free_list' [-Wunused-function]
> > Becuase the only user is guarged with a certain ifdeffery,
> > do the same for add_to_free_list().

..

> Thanks, I'll queue this as a fix against "mm: page_alloc: consolidate
> free page accounting".

Thank you!

> Please do tell us the config when fixing these things.  That way I can
> do a little bisect to ensure that I correctly identified the offending
> patch.

Hmm... You mean defconfig? I can share it.

I built this with `make W=1`, probably that one helps, but the MM parts of
the defconfig have not been altered by me from the x86_64_defconfig.

-- 
With Best Regards,
Andy Shevchenko




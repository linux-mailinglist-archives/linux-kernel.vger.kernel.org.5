Return-Path: <linux-kernel+bounces-87529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 249DF86D589
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 22:04:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A819428B1A4
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 21:04:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4577614AD38;
	Thu, 29 Feb 2024 20:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ecOb5mCy"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D9F7142917
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 20:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709239839; cv=none; b=W8RjrjP0FUULn4ihJb8G3bYMQ6uEQ67w0eDIYjxnzYzV0M2etnFgbXINHgbvQLxm9rnyebgDuEn2wk/5DZQ/PubXA5dBPUzcj/7yMm/C9/HsurxXrs5T6NgjCHVwOUI3E5Zcm0CHrv7QMFGomN1D7vwycEbfrQCa4S1avNt6Z/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709239839; c=relaxed/simple;
	bh=LDvZGP2eIEAhCo/R5eCwLiAcCNWPo9oUUoKt+eK+OZ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o4B3tEkM4dzkJ8qQJZX68i2kvuNpUO+CRGgNZxtiw8PeGaG8O7Z1EYZ+y/awR7NSOKaMdlTS2TL2sQVW7D3umhvK34GwGUrrXALp/7K3FFg/A09llEYDTFZXUE5gMxBGH3FOKHE5gNFyalOTg6mUOwjzXBm20F3W2FtVO7SnlqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ecOb5mCy; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709239838; x=1740775838;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LDvZGP2eIEAhCo/R5eCwLiAcCNWPo9oUUoKt+eK+OZ4=;
  b=ecOb5mCysc+hHn+2uM30Nt1igfmTJHgCKRIozEHeNIYrE65LKArS1pj+
   ug2+Yg0NHTp5pT9+knFLli/9YMFtmvVz7fUT3GnZuWGeAvEtIYsAx3UmW
   edaD40aVQJxo/BX20VEuZXE7qqXunEmiZjkaBhFQie3AqjeBV6mL40woH
   0nSGRcr3XhKbh64rNFwFFH9kmRhi6RG8S6S/yV/GVeI1GWSbtCzhB4XPW
   rLsHEzgRL1I+VOt1HU4l9d5f+WW64AnyF6OBrybqWu89JJaqmLAvdkLDe
   1XrYFQ+Tnw7P8BPLi4Vl0eN7QfCkG9uIiOnsbp03oIKqYDc+Z68C8b+an
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10999"; a="26211064"
X-IronPort-AV: E=Sophos;i="6.06,194,1705392000"; 
   d="scan'208";a="26211064"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Feb 2024 12:50:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10999"; a="913992307"
X-IronPort-AV: E=Sophos;i="6.06,194,1705392000"; 
   d="scan'208";a="913992307"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Feb 2024 12:50:35 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rfnMP-00000008n8b-057O;
	Thu, 29 Feb 2024 22:50:33 +0200
Date: Thu, 29 Feb 2024 22:50:32 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Philipp Stanner <pstanner@redhat.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: [PATCH v2 2/2] devres: Don't use "proxy" headers
Message-ID: <ZeDuGOqsaIZJyLit@smile.fi.intel.com>
References: <20240229155507.3853059-1-andriy.shevchenko@linux.intel.com>
 <20240229155507.3853059-3-andriy.shevchenko@linux.intel.com>
 <d9b2ce52569b2c6a745ca3efa678fa83adfe0fac.camel@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d9b2ce52569b2c6a745ca3efa678fa83adfe0fac.camel@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Feb 29, 2024 at 09:21:43PM +0100, Philipp Stanner wrote:
> On Thu, 2024-02-29 at 17:53 +0200, Andy Shevchenko wrote:
> > Update header inclusions to follow IWYU (Include What You Use)
> > principle.
> 
> Hm, what tree is this based on?

Linux next. Seems like I need to rebase on top of driver core.
Thanks for catching this!

-- 
With Best Regards,
Andy Shevchenko




Return-Path: <linux-kernel+bounces-74725-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2002B85D842
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 13:50:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50B5E1C22585
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 12:50:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A30936994A;
	Wed, 21 Feb 2024 12:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a6u3/TAS"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DBF33C493;
	Wed, 21 Feb 2024 12:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708519802; cv=none; b=ol0DLSYBHg45TjCqNJgNTj5KdtTej+H6xgExeVMl79b7cS1QamfN78KXSCkz4X23fwuz1qusxtBuRURrPCUXJ9IL6KV9S13IhQW9VqFbpyAV+pfVn0aHtbUmTAsGOvNYtNRij+yPbZABpIf1cNsxJsoIyiiQK3+mo0m8x8VqZiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708519802; c=relaxed/simple;
	bh=U9EwuQOPyEZ1QW2UV093xXq9ku/ZVhR3UVuOoJ00P1k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OkIt9xtcHA/WrsKbLLN03DycJJE5gLBJJb/yRh7v/0x2oYL7OH5UuKKWnzaIHd5dp9ShsWkOwOA6VjlUUFgmKBVXooalDb74l9suz7wLmAYfKehmVqBrGHEGC8eqD2RdVuUECrcDB8C1GYhkzbZH/c9U0SwUHZ5MzxD63rmpuXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a6u3/TAS; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708519800; x=1740055800;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=U9EwuQOPyEZ1QW2UV093xXq9ku/ZVhR3UVuOoJ00P1k=;
  b=a6u3/TASci0BN7MM+yWmUUSnD9zFRS4mY2XKCIprJdjipiM61KDb1YNo
   DahTfQnPrwiPjjHXf9xMp8EztfJ0G+vPkzJ2+ja72N06KDUUx4xo0ZXN9
   7plTBYJEb3yCcQLGTCAZ7qw39T1dNqcxTapEPtQ4OCn9AsllbWQNTCWD1
   HBq0P3lrHEOQbp3lca0ul7NYCOO0WJw0QvzCzgjsYZEpGDbXVH3jHCtMQ
   mns/++ZaFeRolFkG7qLBYKqdfl5snhVnOuy0nwLvX06p4B2VeiDor9wYV
   Yv/DIBf9L6rArH7TreJ9CZ1MOwO+BXtsZnsefZ9hP5NSgaIVgUsmThkue
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10990"; a="2825232"
X-IronPort-AV: E=Sophos;i="6.06,175,1705392000"; 
   d="scan'208";a="2825232"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2024 04:49:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10990"; a="913299426"
X-IronPort-AV: E=Sophos;i="6.06,175,1705392000"; 
   d="scan'208";a="913299426"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2024 04:49:57 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rcm2s-00000006Lku-2Rys;
	Wed, 21 Feb 2024 14:49:54 +0200
Date: Wed, 21 Feb 2024 14:49:54 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Len Brown <lenb@kernel.org>, Saravana Kannan <saravanak@google.com>
Subject: Re: [PATCH v1 1/1] driver core: Move fw_devlink stuff to where it
 belongs
Message-ID: <ZdXxci3JXY-dV-eD@smile.fi.intel.com>
References: <20240220161002.2983334-1-andriy.shevchenko@linux.intel.com>
 <ZdWqodFSRBZ1NAco@kekkonen.localdomain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZdWqodFSRBZ1NAco@kekkonen.localdomain>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Feb 21, 2024 at 07:47:45AM +0000, Sakari Ailus wrote:
> On Tue, Feb 20, 2024 at 06:10:02PM +0200, Andy Shevchenko wrote:
> > A few APIs that belong specifically to the fw_devlink APIs
> > - are exposed to others without need
> > - prevents device property code to be cleaned up in the future
> > 
> > Resolve this mess by moving fw_devlink code to where it belongs
> > and hide from others.

> Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>

Thank you!

-- 
With Best Regards,
Andy Shevchenko




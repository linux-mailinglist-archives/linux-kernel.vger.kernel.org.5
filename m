Return-Path: <linux-kernel+bounces-74723-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 796FD85D83D
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 13:49:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F0461F22E7E
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 12:49:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE3456995B;
	Wed, 21 Feb 2024 12:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H4WI1xJ3"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C38F13EA7A;
	Wed, 21 Feb 2024 12:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708519740; cv=none; b=oQCyulOuPhN0pbYlYfA9Vmsi5hItIb+PXdt+PENwitVbq7La7bwb0A3l5nVL8kHFoDQEhRKIxFRbF0v3dQcNsQ/nnd9M1AyMR1vBpTxwpMdjgy0AmaEjuS9kDkMEbpiZCvoVKl7noToUH0UmfT9a23QKcBmQaVr9oy41uhUw/pE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708519740; c=relaxed/simple;
	bh=zbWgkYpyr9O5go8YkZPd6KPZqk67zT5vwJTY6PBzfiI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Oe52DV2TAlQTPFn8g0Fqp1brBfB/p6BTfMl7M49Xyfn8w3Rvz/DTpW8VNK3xMQHiVi0E+404SsTOqClH7AgTFIcheoOojDTo4YFOrDjmKI0wUB44VeJEWRyYDJ1QcFoXBMT2n4Er/jQVg7ufROpwmoPhuoTeWGeESW5ButWCS6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H4WI1xJ3; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708519738; x=1740055738;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=zbWgkYpyr9O5go8YkZPd6KPZqk67zT5vwJTY6PBzfiI=;
  b=H4WI1xJ3fDQNIS/SoGixxbGf3Dlo/6Kuav5GrYxa99mJXl6fwP6NsnF5
   aFBfxU5mGYg4Xj+XftaLkpjaM9rltixqOMhJM51Nm7ra2O+C7Z/nTsP2/
   nOWOPJjt6RAxjR2jtc4uUD/unF2j0qUv1nhL7EF8cpU/dTW1fW2ihyWFS
   yLR1aSAhgxQ6LK04wI/5jSJXtG7f9gJESMM6ucPDhgLhqu4FEx9eeYg/S
   Slak86S2tcq3Ay4FfPkTAHVn+LSDeKFf0mTQ38gKn4bqAEeAmjeu+p4UC
   PuAQ38+vyp/7IVvhC0efA3mPqnxkPbdoNCC1rhcvSggy+xUAW23UkdYIg
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10990"; a="2825168"
X-IronPort-AV: E=Sophos;i="6.06,175,1705392000"; 
   d="scan'208";a="2825168"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2024 04:48:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10990"; a="913299328"
X-IronPort-AV: E=Sophos;i="6.06,175,1705392000"; 
   d="scan'208";a="913299328"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2024 04:48:55 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rcm1s-00000006Lk3-3ETO;
	Wed, 21 Feb 2024 14:48:52 +0200
Date: Wed, 21 Feb 2024 14:48:52 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Saravana Kannan <saravanak@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Len Brown <lenb@kernel.org>
Subject: Re: [PATCH v1 1/1] driver core: Move fw_devlink stuff to where it
 belongs
Message-ID: <ZdXxNFB8bMMFPoki@smile.fi.intel.com>
References: <20240220161002.2983334-1-andriy.shevchenko@linux.intel.com>
 <CAGETcx8hzYzjKWPz4ACgS=XrVXqg46QHB4hTpP5bDTY9=WFK+Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGETcx8hzYzjKWPz4ACgS=XrVXqg46QHB4hTpP5bDTY9=WFK+Q@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Feb 20, 2024 at 06:08:56PM -0800, Saravana Kannan wrote:
> On Tue, Feb 20, 2024 at 8:10 AM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> >
> > A few APIs that belong specifically to the fw_devlink APIs
> > - are exposed to others without need
> > - prevents device property code to be cleaned up in the future
> >
> > Resolve this mess by moving fw_devlink code to where it belongs
> > and hide from others.

..

> The rest of the functions here are related to parents and children of
> a fwnode. So, why is this function considered to be in the wrong
> place?

When devlink was added it made a few fields in struct fwnode_handle.
These fields have no common grounds with device properties. In particular
struct device pointer is solely for devlinks and shouldn't be used with
them. Hence this patch. TL;DR: they semantically do _not_ belong to
the device property APIs.

-- 
With Best Regards,
Andy Shevchenko




Return-Path: <linux-kernel+bounces-121423-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 139C388E7C4
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 16:04:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36DBA2A5EA7
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 15:04:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C52DE1465BB;
	Wed, 27 Mar 2024 14:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Zip2nYae"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0B8914535D
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 14:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711549413; cv=none; b=qdeUgcYH2iEEOUhqTFULIPWD55syW6RPSvRu3b4yiu5G6CUY8lLWDhTw5EtmjQJ3qVUUoEpEmRMy787KOQnvWPe4PYtQoFRfVtMZEAyHHHQmCjlm7smAA1rlmbdVe03renYv0il/eMSHC8bwil1OXpFbJMZjuzHFWeOgNAPsapg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711549413; c=relaxed/simple;
	bh=978Ys2NHTIo9kyqZglKr1qHAlExbEvvvunWm5NCUUPM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qqG/9ZRPVmrs7JOrB0amC71piAiMokKL/zSpzjlGXFhL9qOH6MoYMusyvyBVjySRNlNO13fBK1YbM4WnGevhG5R4npS9R7E7hv8rbBmdQ8kLBW6VDErfqMDNEo1og1qCCzZVyTs9whgWfQBxAW1NiQbPuf/vYZdeaEpVt7WK+bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Zip2nYae; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711549411; x=1743085411;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=978Ys2NHTIo9kyqZglKr1qHAlExbEvvvunWm5NCUUPM=;
  b=Zip2nYaejpXEOWT9CKj3OF42dWY7Lti70jw2KMrWuPzBkW36oqVyQuJ7
   XbCUN+JaaHBBkoAKZ3CRgVLqaDZplI7sgS1SN54FSWYX/3I/+XUiF2trZ
   ++E0Yi44E77UM4Dses7Y83qSjPb6Mz0b16u5hc+Ld9SgRLlO39T3AMBRg
   J5USh26T5Ngr/bSf7IzRfpMD60xWnyDQ7u4zAupRBYZsSC60g+az/P5Fz
   vJSNruwEVF1mtm71gk5i39ankEpfnFsQSiPAT8YwiSSU2afS7UZcDgFnv
   DxsweivVTLuvl1nYAwwYrE22pJB4iUtsYG54WQ6Cea1tLbYiN5OnrTlbb
   Q==;
X-CSE-ConnectionGUID: X0JcHqL7T52fKyhnL0m6gg==
X-CSE-MsgGUID: gNrCzXBDTVSmSv6mvotsNg==
X-IronPort-AV: E=McAfee;i="6600,9927,11026"; a="6592562"
X-IronPort-AV: E=Sophos;i="6.07,159,1708416000"; 
   d="scan'208";a="6592562"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2024 07:23:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11026"; a="914914548"
X-IronPort-AV: E=Sophos;i="6.07,159,1708416000"; 
   d="scan'208";a="914914548"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2024 07:23:29 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rpUBb-0000000Geo3-13as;
	Wed, 27 Mar 2024 16:23:27 +0200
Date: Wed, 27 Mar 2024 16:23:26 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Lee Jones <lee@kernel.org>
Cc: Mateusz K <mateusz.kaduk@gmail.com>, Bjorn Helgaas <helgaas@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] mfd: intel-lpss: Switch over to MSI interrupts
Message-ID: <ZgQr3sU_BIYv-Ynv@smile.fi.intel.com>
References: <20240312165905.1764507-1-andriy.shevchenko@linux.intel.com>
 <20240325211915.GA1449994@bhelgaas>
 <CAPf=4Rc2vQrWqcs=-ND3iOZFJyKE7FdPoqU9w6DKjoSaJo6KaQ@mail.gmail.com>
 <ZgLefFQanbq-ozKM@smile.fi.intel.com>
 <ZgLooJa1JVKEMOtf@smile.fi.intel.com>
 <20240327131711.GR13211@google.com>
 <ZgQeKfsFy9i0h4Kj@smile.fi.intel.com>
 <20240327141229.GS13211@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240327141229.GS13211@google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Mar 27, 2024 at 02:12:29PM +0000, Lee Jones wrote:
> On Wed, 27 Mar 2024, Andy Shevchenko wrote:
> > On Wed, Mar 27, 2024 at 01:17:11PM +0000, Lee Jones wrote:
> > > On Tue, 26 Mar 2024, Andy Shevchenko wrote:
> > > > On Tue, Mar 26, 2024 at 04:41:01PM +0200, Andy Shevchenko wrote:

..

> > > > Hold on, but IIUC this is the report about new hardware that never had
> > > > a support by Linux before.
> > > 
> > > So a revert is no longer required?
> > 
> > No, it seems an old issue unrelated to this patch.
> 
> Very well, consider it *not* done. :)

Thank you!

-- 
With Best Regards,
Andy Shevchenko




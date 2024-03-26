Return-Path: <linux-kernel+bounces-119447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 39E1A88C8E9
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 17:22:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF3561F285E1
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 16:22:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B99513C9D0;
	Tue, 26 Mar 2024 16:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a7R0NFhf"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEC6413C9A2
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 16:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711470113; cv=none; b=O4Qw1ZozfwKWI23fMLSplTPYHzsB5BpTQnU11XdxHbQmrgA7mBCfBfPm3s6pIqvcXDzhpXsY4iH6YTAgHfVkI96isuCp/nlo9XV1cm7QQ4TDagEA4C7T2/ODNEL0aDmsOHsQyp8fZH9GXgcAFpwpXvR5hspGDByWdwxcggUPCXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711470113; c=relaxed/simple;
	bh=Dq+9CYtx3LJfiw7savOtTlRY7jQtx6ZUqVime/PaRcg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SeOEeRyczjdbOPyibHk6nh+oGT7kR4MlyGXqGhTYog9a/8QSVWDKWlYVBIqhvUWvKvvIBX//IxfzoosW7ZfTWL98T4DEYkDKINZJv3GO7EGVmcbbrzrXFXEuEJX4myRxk35VNxAHomd4FM9452+TFt99lEQ8OA39L99a3xOK1dQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a7R0NFhf; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711470112; x=1743006112;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Dq+9CYtx3LJfiw7savOtTlRY7jQtx6ZUqVime/PaRcg=;
  b=a7R0NFhfwukkElZ6iLKkIGUF3H2JjH0LaM272nS063R6IHmfvz4mXXZD
   Fkc/bc4VEYFfWDzhO/9/YoxBxARv8UTmbBJM84OjvJb5Aft+k167xdC1y
   wPI91wtH16A+4hDbuCuULSv9nX4vTHRYac+nAc45nB3a2EtxPOSWYOXz9
   dWA286SCu1eEm2ZlDDRwUF8rcEECYcSIl6UH3JwvDvm5Za3uaXKqMiYAJ
   0K4sYKnEGu/SxGFbfS3Rx3UpqOtCM8I1xrz82qDbGEn0WbQgnd+Ee/FuS
   CN1v93cffdD/HGayn/GQ8K8Fy/JRQqK2dh524A4DT3C0UhQJazv5NbxUA
   Q==;
X-CSE-ConnectionGUID: C7oJw58zSFeVSG/+ZMPHmw==
X-CSE-MsgGUID: WtHtO3BLQxGOnpYRgeihIw==
X-IronPort-AV: E=McAfee;i="6600,9927,11025"; a="10313322"
X-IronPort-AV: E=Sophos;i="6.07,156,1708416000"; 
   d="scan'208";a="10313322"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2024 09:21:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11025"; a="914884406"
X-IronPort-AV: E=Sophos;i="6.07,156,1708416000"; 
   d="scan'208";a="914884406"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2024 09:21:50 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rp9YZ-0000000GLnX-3p9g;
	Tue, 26 Mar 2024 18:21:47 +0200
Date: Tue, 26 Mar 2024 18:21:47 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Lee Jones <lee@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] mfd: intel-lpss: Switch over to MSI interrupts
Message-ID: <ZgL2G4ItkFlQ7cqS@smile.fi.intel.com>
References: <20240312165905.1764507-1-andriy.shevchenko@linux.intel.com>
 <20240325211915.GA1449994@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240325211915.GA1449994@bhelgaas>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Mar 25, 2024 at 04:19:15PM -0500, Bjorn Helgaas wrote:
> On Tue, Mar 12, 2024 at 06:59:05PM +0200, Andy Shevchenko wrote:

..

> > -	ret = pci_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_LEGACY);
> > +	ret = pci_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_ALL_TYPES);
> >  	if (ret < 0)
> >  		return ret;
> 
> I guess at least some of these devices do support INTx, since we
> always used INTx previously, right?
> 
> There are a bunch of bug reports complaining about a lack of _PRT
> entries for them, e.g., these from
> https://bugzilla.kernel.org/show_bug.cgi?id=212261#c24:

But this is not related to my patch, and the mentioned bug report seems about
all AMD and Intel platforms.

Can you, please, elaborate what the relation to my patch?

-- 
With Best Regards,
Andy Shevchenko




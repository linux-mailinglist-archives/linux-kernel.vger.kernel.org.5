Return-Path: <linux-kernel+bounces-116772-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7453E88AF45
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 20:05:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9017FB27A8D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 14:10:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B3E617C6BB;
	Mon, 25 Mar 2024 10:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EkD5WEvt"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9ED7140E3D
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 10:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711362613; cv=none; b=N/idPQLiZdZONOgrC0k8zWcZgWc8VeMNT3H20ZNITSHzWfOgVoxzC6t6XlLEynT+gQPKAc/DDS2eUU0H3nMy3V8gcZJd47dLUqIhpmtxOAUBFPZLCbD6zUEZHF5TA3Hm7odCs5kwpReTEL1lDR6KI3t+h7CeZFEonPl0k0LPEgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711362613; c=relaxed/simple;
	bh=ntCNgzdQGJ3LvOfVZ4wL1NBn0gVZep3S69fBAzBNNrc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y4c2W5mYvjBTE9O90t+dyV7ieFqOxYmDRTkdbFKl65r3Iz3soikMXmrklbpcGErfXIGZdc1/IoE3vVDeMJ9Hmr7DTrtpIeFjXe84lPqtDBFEgOq7zkqfG5PnLDbuvm7XjAv3w3Gg1ULlFe1HmQykOmLW7iFxIgmBR6QxcfZw2Ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EkD5WEvt; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711362612; x=1742898612;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ntCNgzdQGJ3LvOfVZ4wL1NBn0gVZep3S69fBAzBNNrc=;
  b=EkD5WEvtl6bEE2SoOfHNdbtETqtBO+GgLwUifpQkooi3rr5+nkxP1Ckq
   ljqAzKFbQ3HANcPwGnEdSzTHv6Iv3b1VWLqP5YDN/idBxMsKwXMBsIZVe
   EbPA8HhSYNrSX9dhUNFensc79bUhYpJ7cVP1xsf2GYNFBEBFTE71lcs8+
   MON+EjI/I88yr7I+pQnS9OWnuQtPY9PL8Cv0pfHgsWhFZaKjIsBBwI08Y
   pFbZsYhaKo3uooz0Js3rO8SyZYMR0B7DjhQkcU0Bj9bSaqANLwwvK4SyZ
   fVMvcQpC2WC7nUBchFiVRX1XSrB6BLIBaIQQA5dsl7H9oGS4wH5CV84D5
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11023"; a="6470445"
X-IronPort-AV: E=Sophos;i="6.07,152,1708416000"; 
   d="scan'208";a="6470445"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2024 03:30:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11023"; a="914839103"
X-IronPort-AV: E=Sophos;i="6.07,152,1708416000"; 
   d="scan'208";a="914839103"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2024 03:30:08 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1rohaf-0000000Fx35-2a2n;
	Mon, 25 Mar 2024 12:30:05 +0200
Date: Mon, 25 Mar 2024 12:30:05 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Denis Arefev <arefev@swemel.ru>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org, trufanov@swemel.ru, vfh@swemel.ru
Subject: Re: [PATCH] mtd: partitions: redboot: Added conversion of operands
 to a larger type
Message-ID: <ZgFSLY_uQkfbyyRG@smile.fi.intel.com>
References: <20240315093758.20790-1-arefev@swemel.ru>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240315093758.20790-1-arefev@swemel.ru>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Mar 15, 2024 at 12:37:58PM +0300, Denis Arefev wrote:
> The value of an arithmetic expression directory * master->erasesize is
> subject to overflow due to a failure to cast operands to a larger data
> type before perfroming arithmetic

..

> -		offset = directory * master->erasesize;
> +		offset = (unsigned long) directory * master->erasesize;

Usage of explicit casting can be avoided by using size_mul() from overflow.h.
Usually explicit castings are prone to subtle errors.

-- 
With Best Regards,
Andy Shevchenko




Return-Path: <linux-kernel+bounces-93989-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6815A8737E0
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 14:39:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99FDC1C21A91
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 13:39:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B344C131744;
	Wed,  6 Mar 2024 13:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O+u1Gi+F"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACECA131729;
	Wed,  6 Mar 2024 13:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709732299; cv=none; b=pPy8WUcoydaWwWHFYemxCedzIHCsCUo5ZCL+MWVGBqHmM1uAO0SyJDR5FOQpW1X1AWTwtknDwLg+lpileXPyZroeiN3tCZlkqfaRAI2aTbi6Klb9x/eWjD5tB2Ee7aIwmYTCCgX3/pmfSVa4jTUkYhIIO/AvGCzu8px7hspRBYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709732299; c=relaxed/simple;
	bh=G2rmJ+Q2gQEQNdkWWv7W1eo2pFGNMfvC8toDVdsvsyM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Aa0VModZ9X/78Xeji863swgKlvbpMmgEjPAth6bZMV/pW0Ji4IPah0jZ/DUGAnk/08jkKNmTRu1+rxw5H3aonf7+4xMm7efviUmTt4bYY887pPoq/aU6WNXufxVd/BcdseNE5VprlSVFpSu5bWgjUskX/qiVojxEgrugRa8aD8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O+u1Gi+F; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709732298; x=1741268298;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=G2rmJ+Q2gQEQNdkWWv7W1eo2pFGNMfvC8toDVdsvsyM=;
  b=O+u1Gi+FbLxbzEb23bS2Xs0edNtHqaMwqn8VedIyHCNaKZK9LmfOvgXm
   NGO8JjtRx81OiuFG4mz2ecQ2fdTigdbZcpB+BsqK3b6eJjk4mi7gLYktV
   w5pudmxZSPkR8u5bSvYJBDeq1ZCTPXXSgwJC5K+B2zT2dqRovCXzJO76n
   Fp33ceSgbHz14RbY4MZcQyMiJvOjRpKqNJh4fd+XSKFx3QHxPC0sDbDkS
   EY6WHngKmLuoUXXrNHRd6flZO+GHxN4CmrnWuB3cbfkl8SVN3fYmZ/e/I
   URQEXfsd/5/yOPXaHZGhJEyMNCFehoIrNtLSzcjp/+pEHNj7WZGTjdGxS
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11004"; a="4207656"
X-IronPort-AV: E=Sophos;i="6.06,208,1705392000"; 
   d="scan'208";a="4207656"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2024 05:38:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11004"; a="914178599"
X-IronPort-AV: E=Sophos;i="6.06,208,1705392000"; 
   d="scan'208";a="914178599"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2024 05:38:13 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rhrTG-0000000AHH6-1kPA;
	Wed, 06 Mar 2024 15:38:10 +0200
Date: Wed, 6 Mar 2024 15:38:10 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Yury Norov <yury.norov@gmail.com>
Cc: Herve Codina <herve.codina@bootlin.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, Andrew Lunn <andrew@lunn.ch>,
	Mark Brown <broonie@kernel.org>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v6 1/5] net: wan: Add support for QMC HDLC
Message-ID: <Zehxwo2wCLkZBQzc@smile.fi.intel.com>
References: <20240306080726.167338-1-herve.codina@bootlin.com>
 <20240306080726.167338-2-herve.codina@bootlin.com>
 <ZehvV6kCD3RCumAL@yury-ThinkPad>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZehvV6kCD3RCumAL@yury-ThinkPad>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Mar 06, 2024 at 05:27:51AM -0800, Yury Norov wrote:
> On Wed, Mar 06, 2024 at 09:07:17AM +0100, Herve Codina wrote:

..

> It's minor, but you can avoid conditionals doing something like:
> 
> 		netdev->stats.rx_over_errors += !!(flags & QMC_RX_FLAG_HDLC_OVF);

This is harder to read. And IIUC net subsystem dislikes the proposed one
(I tried to submit a patch to clarify some boolean types vs. integer ones
 and it was rejected because of the reason I have mentioned).

-- 
With Best Regards,
Andy Shevchenko




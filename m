Return-Path: <linux-kernel+bounces-103279-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 450D287BD65
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 14:14:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF8C0288F8E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 13:14:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 160B95B666;
	Thu, 14 Mar 2024 13:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DqlQUhNV"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCF445811C;
	Thu, 14 Mar 2024 13:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710422074; cv=none; b=UkjaRkRLYQXwf66ls8xdZUE017vqklHoDkNz5ucap7gqmfZ7Di+QLXcmWMRpaULip7DKzItBmOym/8Sgu93g1IcUsr3q7H2xPhUqPMyNx8oD3VgumRyEFixlNhi09YI+Dh7AeXocP383hhW0dz9hxETcXNWV+2iw/nNDgz4Rl48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710422074; c=relaxed/simple;
	bh=ls6jWfFVn1f6a6G663eqfhnPbJnOovwyt1uTsjUn2HE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eIp67a0lMPa3aFPr658kBXKOMvgjyj7ATqxeib+F6JWaoqtpr7Pik1dWKVGAyIlqmkqiG4uKDDkP4IKGTJiHP9BsagjzF1rqoYUpjlvfcqZtf/EKchqLk/EI5/lYLjMRSOC2jOjGE1zGDvlqPEp643VyJT5btSMIjNLxGeAzHgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DqlQUhNV; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710422073; x=1741958073;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ls6jWfFVn1f6a6G663eqfhnPbJnOovwyt1uTsjUn2HE=;
  b=DqlQUhNVh9UDprC9pWhltZjEFTnARcz/DKInx1T6kFGMAcdjGMkIynda
   mu2VIuIprC29QWM/2xmGOz7usz3V7lLvGe6WueggT8+1Lxtw7vHOvNYio
   qfqlFdRycJxcM0GGhfpf8wQ/NBnrEKCDd1h4XlfV900m9KzvKE00/BVJ5
   l1Cw6olXqg3JcDQQBqq/aVhUs8Af8TPbKHC65CQlDwJOSqH34cr3SCuPH
   zOphRE2lHh72macahI0zm1+mnZwCBXqCYNBvHOpcPoSg+rnDZ47sWQmsc
   44PhdvyeYrrm5eEVx+wi+luYWS2Pszv0eLefK1Kx213QdGEdK+3XzZVSc
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11012"; a="5091392"
X-IronPort-AV: E=Sophos;i="6.07,125,1708416000"; 
   d="scan'208";a="5091392"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2024 06:14:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11012"; a="914460070"
X-IronPort-AV: E=Sophos;i="6.07,125,1708416000"; 
   d="scan'208";a="914460070"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2024 06:14:29 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rkkug-0000000CWJh-1N2z;
	Thu, 14 Mar 2024 15:14:26 +0200
Date: Thu, 14 Mar 2024 15:14:26 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Herve Codina <herve.codina@bootlin.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Yury Norov <yury.norov@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v2] lib/bitmap: Fix bitmap_scatter() and bitmap_gather()
 kernel doc
Message-ID: <ZfL4Mnd3VrHoAwQW@smile.fi.intel.com>
References: <20240314120006.458580-1-herve.codina@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240314120006.458580-1-herve.codina@bootlin.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Mar 14, 2024 at 01:00:06PM +0100, Herve Codina wrote:
> The make htmldoc command failed with the following error
>   ... include/linux/bitmap.h:524: ERROR: Unexpected indentation.
>   ... include/linux/bitmap.h:524: CRITICAL: Unexpected section title or transition.
> 
> Move the visual representation to a literal block.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko




Return-Path: <linux-kernel+bounces-55174-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42CF084B8FC
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 16:12:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B6B90B2B1E9
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 15:08:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9756A133407;
	Tue,  6 Feb 2024 15:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aeyuFkSf"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0F531E866;
	Tue,  6 Feb 2024 15:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707232065; cv=none; b=TLk1dBfHd340oCt7xuUDGFEu1cx80XQ7hq8A1U2R6cn4Rwuy/jHpOnkuPDfKVXQz11OIexd2aFYcz/uebMV6iXno3UrZKpCVY1Q7jty9Z6HglVJr/sFyiAaaV8jE8n6XebsqLsWbuCyfNEK7Lt/VgVukcNNxwdDDicK6e537EDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707232065; c=relaxed/simple;
	bh=xHfs6v4q9Cn/MM6C3D51On1JjdwuprUsJ7h22brXSIw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uZGhuRQp9AVxN7QfPFzeceWwMBJwoyoxwTjmGuHSdbft0L+SPQW7EVgRW6cW53VOzzla/ZR+McKEWT3Rq+T3TWuWFK/xoWxT1FpZxyqB/mWSgD3zXgTSc8kf3AimNpxh04FcIaReH96sRctXx2/lsz7gquaMlpghTB4eY76Vank=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aeyuFkSf; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707232064; x=1738768064;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xHfs6v4q9Cn/MM6C3D51On1JjdwuprUsJ7h22brXSIw=;
  b=aeyuFkSfeXzmau6v9pePMa3PzP+TVL0cP7eRDm39ue7JyRvMsA0Zw2Wf
   QZ/bm6HavAHphyBVLW7QaCjC4DBPQNmHQ6ykGRJtEMlt0fSbZJn/7xCSd
   sRfeFS0dYsvtqP0pbhLU/43W9oTYNwvM4hq5f6sPYB+4kjc9b+mBqVRSk
   CDCNHzU2uPvhDmoAl3I3FnpoDnWHP3iEQ3kVDVAgquLv0g65olY1r/qKN
   h6gwj+ZmPafPzX+ufZy0tFSPqpkvubYy35PwbmCF22NbsCW+Xy5gg9bD3
   u9CBFojpaehSl2ayyDhAPHRIXSoQGXz39oAR/Zo0B2Oc7GjFX6oq/C9f4
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10976"; a="11410884"
X-IronPort-AV: E=Sophos;i="6.05,247,1701158400"; 
   d="scan'208";a="11410884"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2024 07:07:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10976"; a="909661991"
X-IronPort-AV: E=Sophos;i="6.05,247,1701158400"; 
   d="scan'208";a="909661991"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2024 07:07:39 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rXN2u-00000002N1u-3OMM;
	Tue, 06 Feb 2024 17:07:36 +0200
Date: Tue, 6 Feb 2024 17:07:36 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Mike Looijmans <mike.looijmans@topic.nl>
Cc: devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Liam Beguin <liambeguin@gmail.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Maksim Kiselev <bigunclemax@gmail.com>,
	Marcus Folkesson <marcus.folkesson@gmail.com>,
	Marius Cristea <marius.cristea@microchip.com>,
	Mark Brown <broonie@kernel.org>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Okan Sahin <okan.sahin@analog.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] iio: adc: ti-ads1298: Add driver
Message-ID: <ZcJLOC7FenCecRMm@smile.fi.intel.com>
References: <20240206065818.2016910-1-mike.looijmans@topic.nl>
 <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.fd628a1a-a926-426e-a239-bfd8c9858b94@emailsignatures365.codetwo.com>
 <20240206065818.2016910-2-mike.looijmans@topic.nl>
 <ZcIsuiuisQjTIxJv@smile.fi.intel.com>
 <4c6654f5-2d9e-4c1b-a5de-7bdeacf5e99f@topic.nl>
 <ZcI5PoWojKRrdpVl@smile.fi.intel.com>
 <67387cf4-1065-4313-b4c6-054128ba8f3a@topic.nl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67387cf4-1065-4313-b4c6-054128ba8f3a@topic.nl>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Feb 06, 2024 at 03:25:30PM +0100, Mike Looijmans wrote:
> On 06-02-2024 14:50, Andy Shevchenko wrote:
> > On Tue, Feb 06, 2024 at 02:33:47PM +0100, Mike Looijmans wrote:
> > > On 06-02-2024 13:57, Andy Shevchenko wrote:
> > > > On Tue, Feb 06, 2024 at 07:58:18AM +0100, Mike Looijmans wrote:

..

> > You never know what may go wrong in the future :-) That said, I prefer robust
> > code against non-robust.
> 
> Maybe: BUG_ON(!priv->rdata_xfer_busy)

Definitely not. Linus T. will scream at us on this.

-- 
With Best Regards,
Andy Shevchenko




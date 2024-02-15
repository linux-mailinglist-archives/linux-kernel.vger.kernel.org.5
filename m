Return-Path: <linux-kernel+bounces-66932-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6A5E8563BC
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 13:54:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72EAE282F8B
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 12:54:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B23EA12F384;
	Thu, 15 Feb 2024 12:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XvJjiTHY"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41DE313FF5;
	Thu, 15 Feb 2024 12:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708001632; cv=none; b=ThG54LdfTo9TGRJIPQFBTrsoAK2+2xNj+JRG/hoka+92teQctMfxj02IKFa67yfOwEaNyGVXAV9hQ5a2reiMSJM6wT+/LdpBdt4xYXXX1M3dbyrclqCKVXYLeNfLroEBzHdLw/h2BSFauFDMzWuTS4pDeubdUIffR8JDFrtclUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708001632; c=relaxed/simple;
	bh=o1XNb9vQplsipvw7ar7izvrCSvgKiiHgtlUB4fVOVYM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vFd/ctkqY8NqjJcQh4DOZB6liEQZHL9uyezjTh4juk2j8I7LOVFjt8f5P2N/fPAYexNyhlhOwW3iMkTM+zgZicRUNTHjUqrfm+jwhqo7pj5W9+KxXBH0byBxPKPfR6/igBynHau9DlklQ9YKB7hV74gVTeyGZFRZhImdRtmeqos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XvJjiTHY; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708001630; x=1739537630;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=o1XNb9vQplsipvw7ar7izvrCSvgKiiHgtlUB4fVOVYM=;
  b=XvJjiTHYHVjIqmzHt4IbHXy3NXAuiF+izIKgzndBW8bu4SuG/Xks7mmE
   Ws90kTWy1p1YvBQoQd6/tJea9FIMe9Lb0KtiQkaQRYNUihzBAJvhtMY2T
   +RuN2mlFaNMRGMV4iBs6+QNVONc3YZAFXauB8IaxkvE5qrA8ZNEiIvkFZ
   UfCWuFJxr0/Lr12FpazaQ8vFebMK4yXzdp7rUAPgSHGS/PXuxC+N4TCha
   q3lQTBSDr1MExQs4FlGBovcaW7+5Zhjb4YoclN4caGn/mfAyihWuB3GZK
   Oxjbq7OFsTj8EE//UtgV+MJTInr11fqlJ133VWJbKfiQHn6tXNEJQvnbX
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10984"; a="1960980"
X-IronPort-AV: E=Sophos;i="6.06,161,1705392000"; 
   d="scan'208";a="1960980"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2024 04:53:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,161,1705392000"; 
   d="scan'208";a="8226597"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2024 04:53:48 -0800
Received: from kekkonen.localdomain (localhost [127.0.0.1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id 2416511F8E7;
	Thu, 15 Feb 2024 14:53:45 +0200 (EET)
Date: Thu, 15 Feb 2024 12:53:45 +0000
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Umang Jain <umang.jain@ideasonboard.com>
Cc: linux-media@vger.kernel.org,
	Kieran Bingham <kieran.bingham@ideasonboard.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/5] media: imx335: Use v4l2_link_freq_to_bitmap helper
Message-ID: <Zc4JWdjXyR2J6z_G@kekkonen.localdomain>
References: <20240131055208.170934-1-umang.jain@ideasonboard.com>
 <20240131055208.170934-3-umang.jain@ideasonboard.com>
 <Zc4Ix32Ld_bCD-LO@kekkonen.localdomain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zc4Ix32Ld_bCD-LO@kekkonen.localdomain>

On Thu, Feb 15, 2024 at 12:51:19PM +0000, Sakari Ailus wrote:
> >  /* CSI2 HW configuration */
> > -#define IMX335_LINK_FREQ	594000000
> > +#define IMX335_LINK_FREQ	594000000LL
> 
> If you change this, please make it ULL---it's unsigned.

Ok, the control will be s64 so please ignore this.

-- 
Sakari Ailus


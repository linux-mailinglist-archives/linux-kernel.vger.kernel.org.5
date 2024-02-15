Return-Path: <linux-kernel+bounces-66937-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F37C185641A
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 14:13:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 651DFB27294
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 12:59:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C7DF12F586;
	Thu, 15 Feb 2024 12:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iefFi7C0"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D02B12B162;
	Thu, 15 Feb 2024 12:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708001956; cv=none; b=KW+VAk/dnG+3RgI5uhEtjX5O6X/UH0azEYtvJjfwDLqvsEZbyKB0frChkZJnWKTdO2vTS8+uME7lVwqyc2DhaBij/KbnDZEK6NkcMyaweYWzBqXVLNKIqj9Xs6/Xalp2O/52jPVb29UNQ9KkQA+606TeKO4JxxSCtPNW3pR1thU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708001956; c=relaxed/simple;
	bh=t2wWwdv8gsHGUFU9xSsq2sd3TsOFW6DhmUhaco8Iz/k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uS8DTLWv3KOFXU0z7ZSLDOaUYLl8se5mFkENhcnJrk0cNTt4fi617OIolhsBAMCzjbH3Hi4/UuVQm+A/hGeNNo66XlcbFL8Bz2+yJaxDG84Vwduy2f1+zh60lyz6PPS8jpHxlVBwTOzqQvQplBIsjFyiOOF6IHLaOdDutTPWzBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iefFi7C0; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708001955; x=1739537955;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=t2wWwdv8gsHGUFU9xSsq2sd3TsOFW6DhmUhaco8Iz/k=;
  b=iefFi7C0MRtreJf89kqJ06Rd5laIHk1eVTRl3MFQ5lH/w5YvGjq20BuF
   v/uC+xXHS2xbosdBnLqhO+jkO5AGQ7W9SWkObwrx3hu1/wfakz3WqFBwm
   jg8E0l2AsXQk4o0MHr9kCST4IKBWI9OU4IELuv9zKBSifp+7qV+QGlo04
   x18UTaepxfuleSjSxOVr3lWFNcTxVgP1joCwwftnbNLO2LIqAGpZyFQ0c
   2+e4o0P8zpX72HtiuIZv7+tCoEUBueypBcQ/Pm9GwuIF4BOgTrHP0PquC
   t9qxZJQmNkAsMJpOq0PNqYZ+ZVcZNglv92Xucx8YMUkMdyJIbWLS3fThI
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10984"; a="1961394"
X-IronPort-AV: E=Sophos;i="6.06,161,1705392000"; 
   d="scan'208";a="1961394"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2024 04:59:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,161,1705392000"; 
   d="scan'208";a="8227918"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2024 04:59:12 -0800
Received: from kekkonen.localdomain (localhost [127.0.0.1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id 0535111F871;
	Thu, 15 Feb 2024 14:53:09 +0200 (EET)
Date: Thu, 15 Feb 2024 12:53:09 +0000
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Umang Jain <umang.jain@ideasonboard.com>
Cc: linux-media@vger.kernel.org,
	Kieran Bingham <kieran.bingham@ideasonboard.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 3/5] media: i2c: imx335: Support multiple link
 frequency
Message-ID: <Zc4JNYxvLCfkyQKb@kekkonen.localdomain>
References: <20240131055208.170934-1-umang.jain@ideasonboard.com>
 <20240131055208.170934-4-umang.jain@ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240131055208.170934-4-umang.jain@ideasonboard.com>

Hi Umang,

On Wed, Jan 31, 2024 at 11:22:06AM +0530, Umang Jain wrote:
> Support link frequency of 445MHz in addition to 594MHz.
> Break out the register set specific to each data lane rate and also add
> the general timing register set corresponding to the each data
> lane rate.
> 
> Signed-off-by: Umang Jain <umang.jain@ideasonboard.com>

Please use the same subject line prefix (i.e. without "i2c: ").

-- 
Regards,

Sakari Ailus


Return-Path: <linux-kernel+bounces-158364-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 287E38B1ED3
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 12:11:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2CC428176F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 10:11:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4837F8595B;
	Thu, 25 Apr 2024 10:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jq3A6XvG"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 033C184FA9;
	Thu, 25 Apr 2024 10:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714039857; cv=none; b=epfFjI4S7OB3RR8Hs933kT8OmzTBSQs9flXUg/Nc6oajhdCMV3oVqmQWmm4ScAYYYsRqYCmgzpPWEpBVu54GfAjI3sDJgSrOfbqW/dLqUNKdmpqu5F/ruO+4AJyIVvFEKgFck2s4hFd2tEck8wsji/D+ezcnwTzhNv77CT1ldFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714039857; c=relaxed/simple;
	bh=L7gfZ8lIsNqHvElkF3mICY3AOCzqo++EFJD0Mwx9Wzk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ggJRC1Zh15dmZhSCCkmN4gj6iGimgLlPewOg48mrv+npPHTj2oj5Z/UBh0O+v+BmT9AwFN3frfG6myJ7Mgpp+35aunT/HaNCqJ61cAyd57xzTpJK7SnvZhl8+tfhilcYc6qWiJOgm9Oz40X/20JCP8ZNS8xWe+7shBwGREhtCbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jq3A6XvG; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714039856; x=1745575856;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=L7gfZ8lIsNqHvElkF3mICY3AOCzqo++EFJD0Mwx9Wzk=;
  b=jq3A6XvGTd6A7tlnZJB4qMWnnqoaF4HLwC0dtNukYIx+1Z/c48WgI9kD
   VgW+hYP9JCVFHG6XoN2GLwS6ba0xyLRMc9Fn9u+SSQGReWDyRZoyEsswp
   6I9IJ4iuvcNUS2QCoMVHcQ9YLpBzgu1AxqFl4T+UQ6B+zJxTIyl3UY+SO
   nNaE08oDsH9xEMobFXdHl1Qb0GPjQPfPE1SYsjvTgr90HBYy7aeKT9Ehr
   VEZdSl3OESXO6unDC/zs1Qnt4+pFufAHNuhuosbMOWIjzC3+ZrBHp6TAH
   7gRXHAzbyL5PsR04aOBH1Ky+TX4gdfMb3dJcBh3kn0CUKqOpTe09IeUmw
   Q==;
X-CSE-ConnectionGUID: zpeJUnMMQTyW1QU6H7C9bQ==
X-CSE-MsgGUID: BQRxHfl4QSKxEN3KhOHCqw==
X-IronPort-AV: E=McAfee;i="6600,9927,11054"; a="35110637"
X-IronPort-AV: E=Sophos;i="6.07,229,1708416000"; 
   d="scan'208";a="35110637"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2024 03:10:55 -0700
X-CSE-ConnectionGUID: VqgUXFggQEuuqzUpAV9zZw==
X-CSE-MsgGUID: qsDexwY5QCqH4lPrdARv7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,229,1708416000"; 
   d="scan'208";a="25113808"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmviesa010.fm.intel.com with SMTP; 25 Apr 2024 03:10:51 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Thu, 25 Apr 2024 13:10:50 +0300
Date: Thu, 25 Apr 2024 13:10:50 +0300
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: sundar <prosunofficial@gmail.com>
Cc: gregkh@linuxfoundation.org, neil.armstrong@linaro.org,
	dmitry.baryshkov@linaro.org, u.kleine-koenig@pengutronix.de,
	christophe.jaillet@wanadoo.fr, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
	javier.carrasco.cruz@gmail.com
Subject: Re: [PATCH v4 linux-next] usb:typec:mux: remove indentation for
 common path
Message-ID: <ZiosKjYjMG3my5FY@kuha.fi.intel.com>
References: <20240424172716.3407-1-prosunofficial@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240424172716.3407-1-prosunofficial@gmail.com>

On Wed, Apr 24, 2024 at 10:57:16PM +0530, sundar wrote:
> Nitpick, Mostly common path will not be indented.  so rewritten this 
> function to check device_node pointer is null and removed common path 
> indentation.
> 
> Signed-off-by: sundar <prosunofficial@gmail.com>

I don't think that is your full name, or is it?

thanks,

-- 
heikki


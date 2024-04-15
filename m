Return-Path: <linux-kernel+bounces-144672-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B6E98A490A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 09:29:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7558B1C22833
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 07:29:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 477A7241E1;
	Mon, 15 Apr 2024 07:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IYJgU3uZ"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70776225DA;
	Mon, 15 Apr 2024 07:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713166187; cv=none; b=UyOt48iATpAo9aime8EwgLKHC+//mE2g83HCiAPgoU1uv9KQ1XlpWqo97QWhxU5pxTrvzMaVMvQ7hBMfsEuLL7IvTXuloszWhVd9lqUS/JmXsElLc09b/EU/l4bK67+xstc9YFheF/mEA6XqbFAwC3QLghAHyZ39h7Ly7xk1g8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713166187; c=relaxed/simple;
	bh=pNT+Wb97jz0djjk250DiFv0ubERcVS2s71OhTbkpiK0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EauGUsJN0QOSmWq69GnzwSkDQIflhrlgWFFeXly7Zc2qgS3urOxPvd+ajltx33jFYLSUd6WuMODv7KqN1RpoZODrTtD2PgtnyMhqeF1DdQVd5ivsPaMPwRVL/4ax0qTcChUQTVmX8anYQCi8X8ZIjQGjGCFinzV+AFRecWmoRFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IYJgU3uZ; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713166187; x=1744702187;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=pNT+Wb97jz0djjk250DiFv0ubERcVS2s71OhTbkpiK0=;
  b=IYJgU3uZ3Cud/6uY1EEoPEGqehNrF6z13xV+gZpOvWgj8rWHiECny7+/
   ft19pCrnQOaJmbE8oy4gEvi2vlD68U2OKm3rRkqlvWFnJVtRhdLk5OcNM
   xOetbuDziDQBowyBvowaYmPiGUDkdRqrwHC/uO7TJ3vcUu09XVQa7N1hM
   0GnJTKabiOuzeza+FX67kgMq5GdW/AQx+Egh6I+xdGlUzJXdn1S4Csy2K
   rTblYlJ6+HR0kt8mAuD6Xe3yxaAp/wlqr1eieBmzKkLi2frSAyTpZ1pQ+
   kQtDz9t2wWi89u4ZwVpBCEx4SVUcp+45M/xixaPBlMAfYmyPHIh1OMTTy
   A==;
X-CSE-ConnectionGUID: yLmgyO5ISsGgyz6NcDLjiQ==
X-CSE-MsgGUID: uOy8ixJvTbuOYgG2Y2R99g==
X-IronPort-AV: E=McAfee;i="6600,9927,11044"; a="19687963"
X-IronPort-AV: E=Sophos;i="6.07,202,1708416000"; 
   d="scan'208";a="19687963"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2024 00:29:46 -0700
X-CSE-ConnectionGUID: 8vrFKyI5Qg6H6yjpzR9dig==
X-CSE-MsgGUID: A4aD3a0QSHSmY85TlJuscw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,202,1708416000"; 
   d="scan'208";a="21824858"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2024 00:29:43 -0700
Received: from kekkonen.localdomain (localhost [127.0.0.1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id 17A4B11F8AF;
	Mon, 15 Apr 2024 10:29:41 +0300 (EEST)
Date: Mon, 15 Apr 2024 07:29:41 +0000
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: linux-media@vger.kernel.org, tomi.valkeinen@ideasonboard.com,
	Hans de Goede <hdegoede@redhat.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Hans Verkuil <hverkuil@xs4all.nl>,
	Umang Jain <umang.jain@ideasonboard.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] media: v4l: Don't turn on privacy LED if streamon
 fails
Message-ID: <ZhzXZUyY4Rc4z71y@kekkonen.localdomain>
References: <20240410114712.661186-1-sakari.ailus@linux.intel.com>
 <20240412174621.GA5444@pendragon.ideasonboard.com>
 <ZhzUHs7lpdeMa22l@kekkonen.localdomain>
 <20240415071812.GA25078@pendragon.ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240415071812.GA25078@pendragon.ideasonboard.com>

On Mon, Apr 15, 2024 at 10:18:12AM +0300, Laurent Pinchart wrote:
> > Maybe because a large majority is GPIO-controlled?
> 
> GPIOs can fail, in particular when they're on I2C GPIO expanders.

Sure, but gpiod_set_value() return type is also void.

It just works... right?

-- 
Sakari Ailus


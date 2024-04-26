Return-Path: <linux-kernel+bounces-160007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3D778B3796
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 14:58:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D4C828311B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 12:58:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4858C1474C5;
	Fri, 26 Apr 2024 12:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Mfb9w51F"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E553913D500;
	Fri, 26 Apr 2024 12:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714136269; cv=none; b=QP6vXkkBOk27QXQ2E0NYjaQhqN8KLM3DtXerZWV6WxQhmBND9fLPlrbBcHmjhhDpLLDMP9avDlFzP5ampNq3SIQ2tOmGZ1THfFLIg6orc3a7I+qYM3Bip20g8MeG9AVRUpfrYS8ktdqOu1BqSkMIkFu06XxlESTtThCcynB/QUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714136269; c=relaxed/simple;
	bh=I3ZG8y7fA2Lhx6DNfKVH+A49A5Z4HgvhRMHnPvNoxSU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LV0caks60G4pwUaQUSHtJMK2j8HwVOtSaMSty0ljoq+pMIwP1rPSNdYJmnixgKdG8J7T9GTAl3zE2qqvoh7LXwh4j8eUhMtabot9I3q582KSmLkRjc1/xs5YostjZLud4bhwSrZVs66Wzj6VF3WQVmd3zBkWl/1McFdy9LXpoy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Mfb9w51F; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714136268; x=1745672268;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=I3ZG8y7fA2Lhx6DNfKVH+A49A5Z4HgvhRMHnPvNoxSU=;
  b=Mfb9w51Fce76OVjNvZrsxTWBaAS/0zAPzmMPNEmmB8lWUdVrnS2ZGaCO
   hUM/5iM3HawKah2REQf3qExzqBDYGZpbOA2Q1RzQge3TEUIhFamHDN/5N
   sy14VVnWMEVjoEDexWDTadxGFYYbgOTaUpRgYn6nTVC4/e4Pd1e/dX/Qh
   Lc1sPlIw76BVQENNhZDUV6F7ubgv9fGS9xFblrim+idJpH84LsfCXMXoJ
   ZPNuVUY5fcWnACcRQ1sVmabjh/iclLzk99pnzUbBjr0OVoAATY9AEK8gx
   KcmmqtGUfT0pa88ZKNWDeG2KfaPgRfIBij/x5v9K2RheqWbKAlDiLxzJh
   w==;
X-CSE-ConnectionGUID: 3oIBSAdvQaKjsrMeIqBFpA==
X-CSE-MsgGUID: pZCDKMdeS7akrdUzb/aJVA==
X-IronPort-AV: E=McAfee;i="6600,9927,11056"; a="10401661"
X-IronPort-AV: E=Sophos;i="6.07,232,1708416000"; 
   d="scan'208";a="10401661"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2024 05:57:47 -0700
X-CSE-ConnectionGUID: J6LPJxnJScaK+/LJIy+XRg==
X-CSE-MsgGUID: wseyEKgqQ0OUjLem7PYgPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,232,1708416000"; 
   d="scan'208";a="56578801"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmviesa001.fm.intel.com with SMTP; 26 Apr 2024 05:57:43 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Fri, 26 Apr 2024 15:57:42 +0300
Date: Fri, 26 Apr 2024 15:57:42 +0300
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: sundar <prosunofficial@gmail.com>
Cc: gregkh@linuxfoundation.org, neil.armstrong@linaro.org,
	dmitry.baryshkov@linaro.org, u.kleine-koenig@pengutronix.de,
	christophe.jaillet@wanadoo.fr, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
	javier.carrasco.cruz@gmail.com
Subject: Re: [PATCH v4 linux-next] usb:typec:mux: remove indentation for
 common path
Message-ID: <ZiukxoDxkLsIVG+Q@kuha.fi.intel.com>
References: <20240424172716.3407-1-prosunofficial@gmail.com>
 <ZiosKjYjMG3my5FY@kuha.fi.intel.com>
 <5326cb96-e736-4455-abcf-921576b15be7@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5326cb96-e736-4455-abcf-921576b15be7@gmail.com>

On Thu, Apr 25, 2024 at 08:15:04PM +0530, sundar wrote:
> On 25/04/24 15:40, Heikki Krogerus wrote:
> > On Wed, Apr 24, 2024 at 10:57:16PM +0530, sundar wrote:
> > > Nitpick, Mostly common path will not be indented.  so rewritten this
> > > function to check device_node pointer is null and removed common path
> > > indentation.
> > > 
> > > Signed-off-by: sundar <prosunofficial@gmail.com>
> > 
> > I don't think that is your full name, or is it?
> > 
> > thanks,
> > 
> Hi Heikki,
> 
> Sundar is my full name.
> Previously, I wrote my name in caps.after changing to small,  conflict
> arises.now I fixed it.


You need to use your real, full name - what ever your name is in your
passport. I find it a bit hard to believe you don't have a family (or
given?) name.

Your email returns couple of commits where you're name is "R SUNDAR".
What does the "R" stand for?

thanks,

-- 
heikki


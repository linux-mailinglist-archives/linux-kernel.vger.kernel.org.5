Return-Path: <linux-kernel+bounces-63935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71819853690
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 17:49:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A450F1C2420F
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 16:49:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D93B6025E;
	Tue, 13 Feb 2024 16:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="atNoYoBw"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0F995FF08
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 16:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707842860; cv=none; b=uWd0WR/caeAETkfi5xhRKuhlejZLRSeD28vbj0JGfxzp3sOcQa5t1iNwTSOaDuV8FjLCZfUkezIydWxngeiMS4RkfVj/tT0MSp7cSaUxM3rRA5RBQqfOsIk/n8MHMD+d05KrUOaiMG223EYxYh7ZRsFNEtiyPUDz+VQTPd3nGU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707842860; c=relaxed/simple;
	bh=ElKTNlIuQPudvJiFcN+N/woy8qoA+pviJFvwMDbhHmA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JtiEOdEuwykWhaZpCJQzwU9+4jU8CH2luGbE4uEyl72GG+CzT7SKu3pjTcqDxupOWCEmmPCExUMtUEv9v4l7l0ot5nphgZRazeep2H3T7jtX++HJtOD2BPJLgoAHZfDhtUAc2pFu+hUgwODq5A399eeS9Cf/6aM4YTHC7dbf/sE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=atNoYoBw; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707842859; x=1739378859;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ElKTNlIuQPudvJiFcN+N/woy8qoA+pviJFvwMDbhHmA=;
  b=atNoYoBwwhlD1t7cNbrye9iFQ23nQ+r9QaklzZQ60vWLXW8/U5k8Gr88
   qmOglovsCtMSr7fKtvgpOe/TTYuFXg4WUOH8xPm/N0bJrKG67LAfVR3CB
   giwkLP0R0SNXOXmv3buv7XgylisEyizbSL+01nl3C5NdqfRa4Hm1uEdvs
   tR40B+5MkQCuDFgipPW09wYXppWmLwvIahZAW/Mjt8qaSCYy+oyRnd9Vh
   Uj8e6d+2NTCj7j4OitW+Cyj1FREtscG5l2bAoe34oEvXbZ8KJTwovNMk8
   gqQbA7sAzpJ3/RZ6c7xJKve0/vQytRl+BqxUXtDk/QVy3mu/HX2WH4wp3
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="4827115"
X-IronPort-AV: E=Sophos;i="6.06,157,1705392000"; 
   d="scan'208";a="4827115"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2024 08:47:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="911833156"
X-IronPort-AV: E=Sophos;i="6.06,157,1705392000"; 
   d="scan'208";a="911833156"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2024 08:47:36 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rZvwU-00000004Giw-1noo;
	Tue, 13 Feb 2024 18:47:34 +0200
Date: Tue, 13 Feb 2024 18:47:34 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, linux-kernel@vger.kernel.org
Cc: Miguel Ojeda <ojeda@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v2 0/3] auxdisplay: Refresh MAINTAINERS for the subsystem
Message-ID: <ZcudJl-H_PrJM_8D@smile.fi.intel.com>
References: <20240212132515.2660837-2-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240212132515.2660837-2-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Feb 12, 2024 at 03:23:52PM +0200, Andy Shevchenko wrote:
> Update MAINTAINERS for AUXDISPLAY subsystem in accordance to the last
> (administrative) changes.
> 
> In v2:
> - included Geert as Reviewer and added Git tree 
> - added two more patches that are related to MAINTAINERS

Pushed to my tree, thanks!

-- 
With Best Regards,
Andy Shevchenko




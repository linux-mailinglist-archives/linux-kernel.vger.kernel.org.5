Return-Path: <linux-kernel+bounces-65237-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A1B428549D5
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 13:59:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10871282918
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 12:59:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDCA052F95;
	Wed, 14 Feb 2024 12:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b1B7k+ZW"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A834C52F65;
	Wed, 14 Feb 2024 12:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707915535; cv=none; b=It55N63yZ/orNvlf98N5upGjsdltNNhQ8JGbTgfuEkfQamqP3YCTMyEyyPSE9tvA7JqyImwDwlxMtUDo6YoKvrH/9+58eA5fkOxD7GUNEb6t9idxr9AFPgKS2p57qaBDO0RxPe1/DiFpdc9g7eXNa6PhH28RsQQPAn8nWK3vVrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707915535; c=relaxed/simple;
	bh=pfBCiDW/HUqg87yPhC+EEiL6OaPUWEyVoSibStQrFzg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dGGcFRfspFtKGYs1TsXLeCs5/5am6oWlWWrESUDOmrkYvv6corotPRFc4OuJ5ldT9LIWjd7oROXf0xWcnkpl+qYKltkQDIVoSWmQPv/4UdIoBAYeI4m9AfJOUeTmEx5Rm1x9p3jKalSCxiUjaIMndAhMWyKjjg6bzuMcXXMVpvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=b1B7k+ZW; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707915533; x=1739451533;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=pfBCiDW/HUqg87yPhC+EEiL6OaPUWEyVoSibStQrFzg=;
  b=b1B7k+ZWA3fEfbvlY+l69dbxb2FXauZcDMdqHbeuUx28B/2A7j874+Ht
   r4KNOKhRgB6ey2xykx0v/RaNNRc5OkcHt3FHMqq8PIckxv6P03HksPfSr
   MpxP4qN6qmfOp815GnmJdfUkTF5iQRlWg6ii2W+xCbgSC3HwbYQnaPiYn
   rHVjhWZFPqd8teJrzfwQoku0oO6veR341zR2mToA/1eI41z31A+scxg5Q
   rGGKfevxn8aoaH9JrpgHvymRjq4UbNVhO60vvh+JsqtVZbJdAfwPgURRh
   QFWK/ZoNxWnqTweVMA4iRAo8MnWCWJeKBqn7IKeKBXZXI5D3xlBADWD4D
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="1810306"
X-IronPort-AV: E=Sophos;i="6.06,159,1705392000"; 
   d="scan'208";a="1810306"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2024 04:58:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="912084094"
X-IronPort-AV: E=Sophos;i="6.06,159,1705392000"; 
   d="scan'208";a="912084094"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2024 04:58:50 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1raEqe-00000004Uen-35NU;
	Wed, 14 Feb 2024 14:58:48 +0200
Date: Wed, 14 Feb 2024 14:58:48 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Jiri Slaby <jirislaby@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rengarajan S <rengarajan.s@microchip.com>,
	linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
	Kumaravel Thiagarajan <kumaravel.thiagarajan@microchip.com>,
	Tharun Kumar P <tharunkumar.pasumarthi@microchip.com>
Subject: Re: [PATCH v1 1/1] serial: 8250_pci1xxxx: Don't use "proxy" headers
Message-ID: <Zcy5CI6FfpyZNb4e@smile.fi.intel.com>
References: <20240213193827.3207353-1-andriy.shevchenko@linux.intel.com>
 <faf36cd9-00c3-4f47-acb7-64881f25d6d9@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <faf36cd9-00c3-4f47-acb7-64881f25d6d9@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Feb 14, 2024 at 10:15:10AM +0100, Jiri Slaby wrote:
> On 13. 02. 24, 20:38, Andy Shevchenko wrote:
> > Update header inclusions to follow IWYU (Include What You Use)
> > principle.
> > 
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> Looks good, but hard to tell if it is correct :P.
> 
> I like this qt-creator feature: "this header is not directly used, remove?".
> Maybe we could extend it to the kernel somehow (as it uses clang to decide,
> I suppose). As was shown recently, removing the inclusion hell can decrease
> the build time significantly…

Yes, that's what Ingo's gigantic patch series targeted, but seems no-one is
interested enough to get it through. clang people also wanted to have a tool
like checkpatch for the inclusions or even like coccinelle to just fix the
code, but it's a project with no deadline or milestones AFAIK.

> Reviewed-by: Jiri Slaby <jirislaby@kernel.org>

Thank you!

-- 
With Best Regards,
Andy Shevchenko




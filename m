Return-Path: <linux-kernel+bounces-61747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C885851661
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 15:03:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AE842B2ADD0
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 13:56:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5452A3FE4B;
	Mon, 12 Feb 2024 13:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LkKqoUkp"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D56079CB
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 13:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707745551; cv=none; b=N7DwQOOHsdoB6qeLFxL05xLbg4ugMbN/chdOZbOTid8f63exbParZd2jbamlWbn/0nLnqQxGOlEqjpc3yQJ+6lH9SaM/ozsGD+3RYpuyonSXecj1vMgV6d9RDQ+2tJXZBZDmc2Q6at4x1NbCSrQNqjsCV8J1lwStvERmBeDBrMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707745551; c=relaxed/simple;
	bh=xz5RlHhbe6hX3f0UqVuu4t4BRNTzj4Pce+pF8zkUWTU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t8k8yHogxVMMxPymTtGzfjds7gY7P+VEGk1CbvoL3b7BrCGVbQaRVDVEZo57OGfNPcKCtfzLqor3Wp8CW0E7dtGMrwVVFsfa9JAD36i4+IYkGzn3CS5BOV2llZPoRekRNkaeymUihN0DGcI7LThGqUNb/mw7tF0fkvVkV9hBuaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LkKqoUkp; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707745550; x=1739281550;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=xz5RlHhbe6hX3f0UqVuu4t4BRNTzj4Pce+pF8zkUWTU=;
  b=LkKqoUkp1Mnw0Fmy1blr2mxUCm/ti5S4k68SpYOT9Xofy2o/8STjkKx5
   3CnQWyaBoY/BGf0jw6cWo5XNI8mW3Se0mT5ZS0VpYLjLlJI8mnZgx3OSI
   6caagh7Xkc3dgp3z4pafWHRgQFSoUd277RYKOmpRMxAm9jVSuy8IUYRfp
   1WyLZHcON23lqMKCkbLsKNEjRCGR5nOMHXWC6UMNCPPUlFjur7T3vKhLe
   4bCMUH8bcR/gTo2egANQfx5knPueLPz9XkE09hZYx4p46wSEBEbeqAjUs
   eJ3hTcQQd/LtAyyxLWO7yjn9EXRgSV+VGfXJxuEG0TCT8Ez+cZiZUuexQ
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10981"; a="5534048"
X-IronPort-AV: E=Sophos;i="6.06,264,1705392000"; 
   d="scan'208";a="5534048"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2024 05:45:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10981"; a="911485407"
X-IronPort-AV: E=Sophos;i="6.06,264,1705392000"; 
   d="scan'208";a="911485407"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2024 05:45:48 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rZWcz-00000003uTK-1XI1;
	Mon, 12 Feb 2024 15:45:45 +0200
Date: Mon, 12 Feb 2024 15:45:45 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: linux-kernel@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: Re: [PATCH v1 1/1] auxdisplay: Take over maintainership, but in Odd
 Fixes mode
Message-ID: <ZcohCa23JfFfrJ4d@smile.fi.intel.com>
References: <20240212113653.2625776-1-andriy.shevchenko@linux.intel.com>
 <CANiq72k-oqVqDGyxqR1pZzwUqpQcFvx=T68BrmLEGDFMY4L3Vw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANiq72k-oqVqDGyxqR1pZzwUqpQcFvx=T68BrmLEGDFMY4L3Vw@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Feb 12, 2024 at 02:35:48PM +0100, Miguel Ojeda wrote:
> On Mon, Feb 12, 2024 at 12:37 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> >
> > I have no time for this, but since it looks like I'm the main
> > contributor for the last few years to the subsystem, I'll take
> > it for now. Let's see how it will go...
> 
> Thanks Andy, I appreciate it -- with Geert added as reviewer as
> discussed privately:
> 
> Acked-by: Miguel Ojeda <ojeda@kernel.org>
> 
> if you want to already take it yourself :)
> 
> Otherwise I can pick it up.

I'll take it, just tag the v2 series.

-- 
With Best Regards,
Andy Shevchenko




Return-Path: <linux-kernel+bounces-39037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 45E4683C9F7
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 18:28:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 783201C2467A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 17:28:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22187130E59;
	Thu, 25 Jan 2024 17:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EooUQ7IT"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D814745FB;
	Thu, 25 Jan 2024 17:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706203688; cv=none; b=PyGRFND7z0Rt6REmh1NETpk/7dgrHHOtWTsaHruwVZ5E+1uA7npdTu763qdQb+2Dz6j0JveLB5lQHBvMhrQd4Ql7vAkWfEyWqO57gGg48xLBrMA6ZeWqeDxhWu26xYGlR1B/zTrbrxio7y4bv3BTLRpdtcWp8wwtFcVMjWBNq2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706203688; c=relaxed/simple;
	bh=QLw4KD6PQ5fl40pFofPxjDmfj4IUupg8g7Wsx1wiWaY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SWsYJK0aelcoqVtAibRa24cDZxguDM0agvDDtfkXspym03q+mvMo+sT58ijlOYIPdfieQSoeUmUdIws/rnUQSmeg5xj8jNkJE1AlPFEZCdmIEGRrzUxrqTGIwWh5aHC0iZUkbW9YsU7T3+0+Oku6kKWVvmAdM3+BIB3dQFbXVsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EooUQ7IT; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706203687; x=1737739687;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=QLw4KD6PQ5fl40pFofPxjDmfj4IUupg8g7Wsx1wiWaY=;
  b=EooUQ7IT/91wZ/O0t8zb2XzDIbMD2QbqhUg+1tpFaCL7GPBYObXb7HDQ
   S/uAZYEfV42uPkpjmBNc6+HMObJn9nNQawkkxvUr7cWAqgxlW/QR0//G4
   dCfhTCy0DEqs04Wun/6JjqSFGEv/ZMNdtfeVhMe9s18xxHxOpaZqSou6V
   N2VWX/HDJdi7U5s/Hxi1Dru3p7nGutPqsC0DmOUHn/hiwNiBmvd6Ina4e
   hmFUkCdVwrdbAszTIaq9Ft4idPfIedrFCAlGL6PrZP5lzKubYHrZ5SnbW
   Un3rbFS50E7R2exUIu6QMVffDzylcVx7UTs0sxrZkIBFMEcSCPSBwoei8
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="9612950"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="9612950"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2024 09:28:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="930069977"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="930069977"
Received: from sgruszka-mobl.ger.corp.intel.com (HELO localhost) ([10.252.42.166])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2024 09:28:02 -0800
Date: Thu, 25 Jan 2024 18:28:00 +0100
From: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Linux PM <linux-pm@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v1 05/12] PM: sleep: stats: Use step_failures[0] as a
 counter of successful cycles
Message-ID: <ZbKaIHWK0LlUMJCV@linux.intel.com>
References: <5760158.DvuYhMxLoT@kreacher>
 <3290637.44csPzL39Z@kreacher>
 <ZbITTlBwu390dwT5@linux.intel.com>
 <CAJZ5v0iNEuZ3ebpWdETC12Jeq3pTnaTzG-gfQTwLQDGtwvphdQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0iNEuZ3ebpWdETC12Jeq3pTnaTzG-gfQTwLQDGtwvphdQ@mail.gmail.com>

On Thu, Jan 25, 2024 at 04:11:08PM +0100, Rafael J. Wysocki wrote:
> On Thu, Jan 25, 2024 at 8:52 AM Stanislaw Gruszka
> <stanislaw.gruszka@linux.intel.com> wrote:
> >
> > On Mon, Jan 22, 2024 at 12:29:11PM +0100, Rafael J. Wysocki wrote:
> > > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > >
> > > The first (index 0) cell of the step_failures[] array in struct
> > > suspend_stats introduced previously can be used as a counter of
> > > successful suspend-resume cycles instead of the separate "success"
> > > field in it, so do that.
> > >
> > > While at it, change the type of the "fail" field in struct
> > > suspend_stats to unsigned int, because it cannot be negative.
> > >
> > > No intentional functional impact.
> > >
> > > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > ---
> > >  include/linux/suspend.h |    3 +--
> > >  kernel/power/main.c     |    9 +++++----
> > >  kernel/power/suspend.c  |    2 +-
> > >  3 files changed, 7 insertions(+), 7 deletions(-)
> > >
> > > Index: linux-pm/include/linux/suspend.h
> > > ===================================================================
> > > --- linux-pm.orig/include/linux/suspend.h
> > > +++ linux-pm/include/linux/suspend.h
> > > @@ -55,8 +55,7 @@ enum suspend_stat_step {
> > >
> > >  struct suspend_stats {
> > >       unsigned int step_failures[SUSPEND_NR_STEPS];
> > > -     int     success;
> > <snip>
> > > -                suspend_stats.success, suspend_stats.fail);
> > > +     seq_printf(s, "success: %u\nfail: %u\n",
> > > +                suspend_stats.step_failures[SUSPEND_NONE],
> > > +                suspend_stats.fail);
> > >
> > >       for (step = SUSPEND_FREEZE; step < SUSPEND_NR_STEPS; step++)
> > >               seq_printf(s, "failed_%s: %u\n", suspend_step_names[step],
> > > Index: linux-pm/kernel/power/suspend.c
> > > ===================================================================
> > > --- linux-pm.orig/kernel/power/suspend.c
> > > +++ linux-pm/kernel/power/suspend.c
> > > @@ -620,7 +620,7 @@ int pm_suspend(suspend_state_t state)
> > >               suspend_stats.fail++;
> > >               dpm_save_failed_errno(error);
> > >       } else {
> > > -             suspend_stats.success++;
> > > +             suspend_stats.step_failures[SUSPEND_NONE]++;
> >
> > This looks confusing for me. I think would be better keep
> > success field and just remove SUSPEND_NONE from the
> > suspend_stat_step and suspend_stat_names. Actually do
> > not introduce it, SUSPEND_NONE does not seems to be necessary
> > (SUSPEND_FREEZE can be 0).
> 
> OK
> 
> I'll need to rearrange the series for that somewhat except for the
> first two patches.

I wouldn't mind to skip this change and just remove SUSPEND_NONE
in separate patch.

> I guess it's OK to retain the R-by tags?

Yes, is OK.
 
Regards
Stanislaw


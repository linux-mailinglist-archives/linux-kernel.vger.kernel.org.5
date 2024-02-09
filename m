Return-Path: <linux-kernel+bounces-59493-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5850E84F7EC
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 15:52:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C1F29B2168E
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 14:52:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 815BB6BB4A;
	Fri,  9 Feb 2024 14:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EN6/0V13"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E8124EB3E;
	Fri,  9 Feb 2024 14:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707490320; cv=none; b=gByArhX3zxuRlnbyt3eg1gEgM99E9hTo3bjlKARe+1nfMH5EcO9Sk7ujTeKmCU7oXRV+gTlYksoQRPCawQMrnsqd1A+3JAjs4cAjy34cjEihalZguK+noDDQS3TX0KRLKgbV5syuqdmV8GvN5nc8X3ZpfLggP8Zh1XeNGRjcrek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707490320; c=relaxed/simple;
	bh=Xu2NTH+sj2xaNNkHf92WqNMoNmO6d7I+wEi7f2JMgBI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mg6qAnbjDz74eZnIAvTsh/LU2DDA+nO5BYPZbXioC98oypoPmw5AmIQVHtqf6cMFCtJtiMCsVfq8Le2r6bwXHVxLDffZS5e54l9pLMrjcHiqTeVYaZ2M5nbVUyseEg7r0ZHGKx9XnYvD0eXNKFVztWndABvG+bR2tGHLWQScPCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EN6/0V13; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707490319; x=1739026319;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=Xu2NTH+sj2xaNNkHf92WqNMoNmO6d7I+wEi7f2JMgBI=;
  b=EN6/0V13rCOmdgbCN+kJ69L85NyVZyZ280TS9aRE8KDzuUXCU9lBQ8xj
   nInEfw1hB8gaQNOHhLUfMuywS9kI/NwSVKNmSm0RyBNmPn2BAD0NRHpL2
   Zt9nv9T80lUk/2ZKY5TVdcV921M7aS/DL7wQ60hl+T22XO+HxrZA1Ylhn
   Assch99ayZbFWvq0mOSWKTAOl8InSUsS/HaPsrcl46EAwBlxlqw+ILjvf
   oe66GLw1ZLYDCvwiyxHW0DJTNzV61vzYEmgmcNXZHboX6dVcwW62akYZK
   ju39ADJvVO2GMUOaqCwbUXprHS4fT2T6I2OgrZAqIeklzKTGLWFTgvXyy
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10979"; a="5233510"
X-IronPort-AV: E=Sophos;i="6.05,257,1701158400"; 
   d="scan'208";a="5233510"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2024 06:51:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10979"; a="910729409"
X-IronPort-AV: E=Sophos;i="6.05,257,1701158400"; 
   d="scan'208";a="910729409"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2024 06:51:56 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rYSEL-00000003B4I-166a;
	Fri, 09 Feb 2024 16:51:53 +0200
Date: Fri, 9 Feb 2024 16:51:52 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Lee Jones <lee@kernel.org>
Cc: Flavio Suligoi <f.suligoi@asem.it>, dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Daniel Thompson <daniel.thompson@linaro.org>,
	Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>
Subject: Re: [PATCH v2 0/3] backlight: mp3309c: Allow to use on non-OF
 platforms
Message-ID: <ZcY8CDnUZn7SuK8-@smile.fi.intel.com>
References: <20240201151537.367218-1-andriy.shevchenko@linux.intel.com>
 <20240208113425.GK689448@google.com>
 <ZcUMMyV_vBTNw8Rz@smile.fi.intel.com>
 <20240208173946.GX689448@google.com>
 <ZcUYZRDVmHhKQu9j@smile.fi.intel.com>
 <20240208181455.GA689448@google.com>
 <ZcUcRlcQmQG4s42k@smile.fi.intel.com>
 <20240209075052.GB689448@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240209075052.GB689448@google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Feb 09, 2024 at 07:50:52AM +0000, Lee Jones wrote:
> On Thu, 08 Feb 2024, Andy Shevchenko wrote:
> > On Thu, Feb 08, 2024 at 06:14:55PM +0000, Lee Jones wrote:
> > > On Thu, 08 Feb 2024, Andy Shevchenko wrote:
> > > > On Thu, Feb 08, 2024 at 05:39:46PM +0000, Lee Jones wrote:
> > > > > On Thu, 08 Feb 2024, Andy Shevchenko wrote:
> > > > > > On Thu, Feb 08, 2024 at 11:34:25AM +0000, Lee Jones wrote:
> > > > > > > On Thu, 01 Feb 2024, Andy Shevchenko wrote:

..

> > > > > > > >   backlight: mp3309c: Utilise temporary variable for struct device
> > > > > > 
> > > > > > (1)
> > > > > > 
> > > > > > > Set no longer applies.  Please rebase, thanks.
> > > > > > 
> > > > > > I got a contradictory messages:
> > > > > > 1) email that says that all had been applied;
> > > > > > 2) this email (that tells the complete opposite);
> > > > > > 3) the repository where the first two were applied.
> > > > > > 
> > > > > > While you can amend your scripts, I think I need to rebase only the last patch
> > > > > 
> > > > > This is what I assume happened:
> > > > > 
> > > > > 1. Attempted to apply the set (as a set)
> > > > > 2. 2 commits applied cleanly
> > > > > 3. The final commit conflicted
> > > > 
> > > > Which is really strange. I have just applied (with b4) on top of your changes
> > > > and no complains so far.
> > > > 
> > > > $ git am ./v2_20240201_andriy_shevchenko_backlight_mp3309c_allow_to_use_on_non_of_platforms.mbx
> > > > Applying: backlight: mp3309c: Make use of device properties
> > > > Applying: backlight: mp3309c: use dev_err_probe() instead of dev_err()
> > > > Applying: backlight: mp3309c: Utilise temporary variable for struct device
> > > > 
> > > > Can you show what b4 tells you about this?
> > > 
> > > Fetching patch(es)
> > > Analyzing 14 messages in the thread
> > > Checking attestation on all messages, may take a moment...
> > > ---
> > >   ✓ [PATCH v2 1/3] backlight: mp3309c: Make use of device properties
> > >     + Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org> (✓ DKIM/linaro.org)
> > >     + Link: https://lore.kernel.org/r/20240201151537.367218-2-andriy.shevchenko@linux.intel.com
> > >     + Signed-off-by: Lee Jones <lee@kernel.org>
> > >   ✓ [PATCH v2 2/3] backlight: mp3309c: use dev_err_probe() instead of dev_err()
> > >     + Tested-by: Flavio Suligoi <f.suligoi@asem.it> (✗ DKIM/asem.it)
> > >     + Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org> (✓ DKIM/linaro.org)
> > >     + Link: https://lore.kernel.org/r/20240201151537.367218-3-andriy.shevchenko@linux.intel.com
> > >     + Signed-off-by: Lee Jones <lee@kernel.org>
> > >   ✓ [PATCH v2 3/3] backlight: mp3309c: Utilise temporary variable for struct device
> > >     + Link: https://lore.kernel.org/r/20240201151537.367218-4-andriy.shevchenko@linux.intel.com
> > >     + Signed-off-by: Lee Jones <lee@kernel.org>
> > >   ---
> > >   ✓ Signed: DKIM/intel.com (From: andriy.shevchenko@linux.intel.com)
> > > ---
> > > Total patches: 3
> > > Prepared a fake commit range for 3-way merge (672ecc5199b5..d507b9f4c5b9)
> > > ---
> > >  Link: https://lore.kernel.org/r/20240201151537.367218-1-andriy.shevchenko@linux.intel.com
> > >  Base: not specified
> > > 
> > > Running through checkpatch.pl
> > > total: 0 errors, 0 warnings, 103 lines checked
> > > 
> > > "[PATCH v2 1/3] backlight: mp3309c: Make use of device properties" has no obvious style problems and is ready for submission.
> > > total: 0 errors, 0 warnings, 41 lines checked
> > > 
> > > "[PATCH v2 2/3] backlight: mp3309c: use dev_err_probe() instead of" has no obvious style problems and is ready for submission.
> > > total: 0 errors, 0 warnings, 81 lines checked
> > > 
> > > "[PATCH v2 3/3] backlight: mp3309c: Utilise temporary variable for" has no obvious style problems and is ready for submission.
> > > 
> > > Check the results (hit return to continue or Ctrl+c to exit)
> > > 
> > > 
> > > Applying patch(es)
> > > Applying: backlight: mp3309c: Make use of device properties
> > > Applying: backlight: mp3309c: use dev_err_probe() instead of dev_err()
> > > Applying: backlight: mp3309c: Utilise temporary variable for struct device
> > > Using index info to reconstruct a base tree...
> > > M	drivers/video/backlight/mp3309c.c
> > > Checking patch drivers/video/backlight/mp3309c.c...
> > > Applied patch drivers/video/backlight/mp3309c.c cleanly.
> > > Falling back to patching base and 3-way merge...
> > > error: Your local changes to the following files would be overwritten by merge:
> > > 	drivers/video/backlight/mp3309c.c
> > > Please commit your changes or stash them before you merge.
> > > Aborting
> > > error: Failed to merge in the changes.
> > > Patch failed at 0003 backlight: mp3309c: Utilise temporary variable for struct device
> > > hint: Use 'git am --show-current-patch=diff' to see the failed patch
> > > When you have resolved this problem, run "git am --continue".
> > > If you prefer to skip this patch, run "git am --skip" instead.
> > > To restore the original branch and stop patching, run "git am --abort".
> > 
> > Thank you!
> > 
> > It seems I have reduced context, so if you do `git am -C2 ...` it should apply.
> > Never mind, I'll send a new version which should work with -C3.
> 
> I just use the default matching context lines.
> 
> Do you have a special config that reduces you context in patches?

No special config, but can be done via aliasing (through function)
E.g.,
	git() {
		if [ "$1" = 'am' ]; then
			shift
			/usr/bin/git am -C1 "$@"
		else
			/usr/bin/git "$@"
		fi
	}

-- 
With Best Regards,
Andy Shevchenko




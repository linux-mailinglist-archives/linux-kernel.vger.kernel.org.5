Return-Path: <linux-kernel+bounces-90368-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D14EA86FE40
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 11:02:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7D15DB23C0F
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 10:02:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 023B5224C7;
	Mon,  4 Mar 2024 10:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EqLTiH2d"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7A5A18EAD;
	Mon,  4 Mar 2024 10:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709546512; cv=none; b=tg3anIJUUbNp1iAyKTx0K4GQl3TIseT5ZKTMMob6phZXDgKZu8D/516OcJ6TfNHJdTbhdRKhuSdEPAxjqGjFP3F+jtAQ5CkkXOsyITyLS4XQqYCV+2Luz3V0GK4DqIHUxZPhNHQswPYEZDyDIGrQ/MrnHhXvOH6GLWoIAMXNUW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709546512; c=relaxed/simple;
	bh=jQFmwXYrCiO+fSgyXF1439DdxKJeLh5hmRnQ7FNWVbk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dhGDSqoePEGXtoALXvrdFSSkahTedqCRXRBxF+vS8qlikdBbnTdM/EzhbXPGHs3A/fzRl3FYm6vt4kqXxsZuqZ8j4RaS5NC3Sp+OnPtAqh9P3Z4XFPX54WEnaUx2aTxnzbG6T9p3oYL/Wrj9k+VYycjbSrOrSj2L7LWIBjiDAnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EqLTiH2d; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709546511; x=1741082511;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=jQFmwXYrCiO+fSgyXF1439DdxKJeLh5hmRnQ7FNWVbk=;
  b=EqLTiH2dfAebQEIj5iR9/aKyA2uDORH7Gxtp2c4jXEzFn3DYCtonj/s3
   JIUikIYeQFQUVyB2wtb3tAEPLqbQqWXeDnyfOZN23EnVGY6CMnGMj4g1g
   CYtbx2cdQUeGPM1YNRSizdoy/LaZpgBSY0V96EJmluMFNm4kKY2SEYNzu
   ADI0DLgaAfCc6toPpw6+kg1e/IQoMk3bfcPSG2YV0lvN1xl4G1fHq8fxg
   jTCltwAyCbovPfeOqqR6QCX71QuTAgZ+ZEREfsfrnpylKBKOATGfeMfMp
   nmvWN9AjWJV2iO+wXsEDMpejf6t2LgO2Nxmfs4kC3hOf/jXplAQi0HYQT
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11002"; a="7799978"
X-IronPort-AV: E=Sophos;i="6.06,203,1705392000"; 
   d="scan'208";a="7799978"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2024 02:01:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,203,1705392000"; 
   d="scan'208";a="39935146"
Received: from syakovle-mobl1.ger.corp.intel.com (HELO localhost) ([10.252.51.3])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2024 02:01:42 -0800
From: Jani Nikula <jani.nikula@intel.com>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org
Cc: dri-devel@lists.freedesktop.org, lkft-triage@lists.linaro.org,
 linux-kernel@vger.kernel.org, Naresh
 Kamboju <naresh.kamboju@linaro.org>, Thomas Zimmermann
 <tzimmermann@suse.de>, Helge Deller <deller@gmx.de>,
 linux-fbdev@vger.kernel.org
Subject: Re: [PATCH] powerpc: include linux/backlight.h from asm/backlight.h
In-Reply-To: <20240304095512.742348-1-jani.nikula@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <CA+G9fYsAk5TbqqxFC2W4oHLGA0CbTHMxbeq8QayFXTU75YiueA@mail.gmail.com>
 <20240304095512.742348-1-jani.nikula@intel.com>
Date: Mon, 04 Mar 2024 12:01:30 +0200
Message-ID: <87bk7u5n9h.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, 04 Mar 2024, Jani Nikula <jani.nikula@intel.com> wrote:
> Removal of the backlight include from fb.h uncovered an implicit
> dependency in powerpc asm/backlight.h. Add the explicit include.
>
> Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
> Closes: https://lore.kernel.org/r/CA+G9fYsAk5TbqqxFC2W4oHLGA0CbTHMxbeq8QayFXTU75YiueA@mail.gmail.com
> Fixes: 11b4eedfc87d ("fbdev: Do not include <linux/backlight.h> in header")
> Cc: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: Helge Deller <deller@gmx.de>
> Cc: linux-fbdev@vger.kernel.org
> Signed-off-by: Jani Nikula <jani.nikula@intel.com>
>
> ---
>
> Not even compile tested!

Naresh, please try this patch!

Michael, if this is fine by you, ack to merge via the drm subsystem
along with the regressing commit?

BR,
Jani.

> ---
>  arch/powerpc/include/asm/backlight.h | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/powerpc/include/asm/backlight.h b/arch/powerpc/include/asm/backlight.h
> index 1b5eab62ed04..275d5bb9aa04 100644
> --- a/arch/powerpc/include/asm/backlight.h
> +++ b/arch/powerpc/include/asm/backlight.h
> @@ -10,6 +10,7 @@
>  #define __ASM_POWERPC_BACKLIGHT_H
>  #ifdef __KERNEL__
>  
> +#include <linux/backlight.h>
>  #include <linux/fb.h>
>  #include <linux/mutex.h>

-- 
Jani Nikula, Intel


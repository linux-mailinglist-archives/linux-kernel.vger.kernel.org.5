Return-Path: <linux-kernel+bounces-35462-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F02A83918F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 15:39:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BD555B23647
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 14:39:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75AED5C5FF;
	Tue, 23 Jan 2024 14:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iXqW0xhR"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A1B756755
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 14:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.55.52.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706020752; cv=none; b=qP6PJYMgoUnEIeBJso2HlAJMv4FLdnFROdwZR07aX+tWeiIUgeWLZ3o5V7F+MalWeLIaJbOvZy5H/zoQv5YzyBKFeHcdnIHi/3qVoyg9K94Xa4CPSDwJJ/r7XvaZVXBNskYbOT2C5e/Kt4e+Zgd6b3bPzH4vQth3U6/pWv+K/sA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706020752; c=relaxed/simple;
	bh=90efiydoJUFwFSGiHQI4dQGybhe96j9FBwZwRp774Eg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RAan/JSMtyxHL6Z1aLte0bOmD2Mxl6XheftphihcAkhdVAlwL9EuV9i2pirDEsDTfTzkI/w1MWr2Xe64saMzG8YeS/bYK2V9oyx2grunX0TxmRt/S32N5R7VUGLnyjbzwEU9Z4ariVmlo9iy05kmUNJwP3ESejIxUBfW8+rF04k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iXqW0xhR; arc=none smtp.client-ip=192.55.52.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706020751; x=1737556751;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=90efiydoJUFwFSGiHQI4dQGybhe96j9FBwZwRp774Eg=;
  b=iXqW0xhRDMkzz1cUUGsfxHt5uBqOp3AOhaZaA+YiuudJWlcHrmo0X4fK
   cizAZzR21lUHqiB2Q3OqSO7kUSMz05RDiX92qEBDqR4wkxyFHdFJn/A5L
   hyFRZwIAKvPeuCA1dNqtHQIil65OUYyU1Bu1xxmC8dhw2BZhK4O3yCKOU
   QHzA7f7dGCi/KlwcdlSQqAEkTdDdn2yBhLckdDAoWqoGQLoLC4dk2UH8h
   0OeBQfbQxj+sZkjet2nqimO+FYGxEvIdaF+Ex0GlHYSqydQEidWfzXx9k
   cWWsVgvrWuDxYeg0P0GlSm0IGBbIKaqnLG2AvGXlmoSkqzpYrw5uZNanK
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="400401583"
X-IronPort-AV: E=Sophos;i="6.05,214,1701158400"; 
   d="scan'208";a="400401583"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2024 06:39:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="1117272579"
X-IronPort-AV: E=Sophos;i="6.05,214,1701158400"; 
   d="scan'208";a="1117272579"
Received: from pzsolt-mobl1.ger.corp.intel.com (HELO localhost) ([10.252.40.183])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2024 06:39:04 -0800
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, javierm@redhat.com,
 chenhuacai@kernel.org
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, Thomas
 Zimmermann <tzimmermann@suse.de>, Jaak Ristioja <jaak@ristioja.ee>, Huacai
 Chen <chenhuacai@loongson.cn>, Thorsten Leemhuis
 <regressions@leemhuis.info>
Subject: Re: [PATCH] Revert "drivers/firmware: Move sysfb_init() from
 device_initcall to subsys_initcall_sync"
In-Reply-To: <20240123120937.27736-1-tzimmermann@suse.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20240123120937.27736-1-tzimmermann@suse.de>
Date: Tue, 23 Jan 2024 16:39:02 +0200
Message-ID: <874jf4nmgp.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, 23 Jan 2024, Thomas Zimmermann <tzimmermann@suse.de> wrote:
> This reverts commit 60aebc9559492cea6a9625f514a8041717e3a2e4.
>
> Commit 60aebc9559492cea ("drivers/firmware: Move sysfb_init() from
> device_initcall to subsys_initcall_sync") messes up initialization order
> of the graphics drivers and leads to blank displays on some systems. So
> revert the commit.
>
> To make the display drivers fully independent from initialization
> order requires to track framebuffer memory by device and independently
> from the loaded drivers. The kernel currently lacks the infrastructure
> to do so.
>
> Reported-by: Jaak Ristioja <jaak@ristioja.ee>
> Closes: https://lore.kernel.org/dri-devel/ZUnNi3q3yB3zZfTl@P70.localdomain/T/#t
> Reported-by: Huacai Chen <chenhuacai@loongson.cn>
> Closes: https://lore.kernel.org/dri-devel/20231108024613.2898921-1-chenhuacai@loongson.cn/
> Closes: https://gitlab.freedesktop.org/drm/intel/-/issues/10133

FWIW,

Acked-by: Jani Nikula <jani.nikula@intel.com>

but would be great to get a Tested-by from Jaak or from the gitlab issue
reporter.

Thanks.


> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: Javier Martinez Canillas <javierm@redhat.com>
> Cc: Thorsten Leemhuis <regressions@leemhuis.info>
> Cc: Jani Nikula <jani.nikula@linux.intel.com>
> ---
>  drivers/firmware/sysfb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/firmware/sysfb.c b/drivers/firmware/sysfb.c
> index 82fcfd29bc4d2..3c197db42c9d9 100644
> --- a/drivers/firmware/sysfb.c
> +++ b/drivers/firmware/sysfb.c
> @@ -128,4 +128,4 @@ static __init int sysfb_init(void)
>  }
>  
>  /* must execute after PCI subsystem for EFI quirks */
> -subsys_initcall_sync(sysfb_init);
> +device_initcall(sysfb_init);

-- 
Jani Nikula, Intel


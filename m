Return-Path: <linux-kernel+bounces-107521-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 16CE087FD99
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 13:32:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF2421F2320A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 12:32:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AAE080021;
	Tue, 19 Mar 2024 12:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eQmoZWZ7"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E940254BDA;
	Tue, 19 Mar 2024 12:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710851506; cv=none; b=a1BbXxFzdh/bOaT0tDc3mAC5jVHIkwLpO+RDyrCV2KVxgk963/6hNQ1zf2Xxg+cEJtmVqfhbtNNlLRSuo65+a31sZsudhG/37eQprG07bqoO7uV2CDNzmjrBwUfIQq7VG+CgnXvnMikeWj9zpHmnnQkAHalDMpDksAZdQk8OPwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710851506; c=relaxed/simple;
	bh=dpUPLrqHwakMnlL6jbNOapLyjpMQqdiCfAGidRZmjgI=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=lMD+I57yUaneqdZQUCndgCtQCoj8sU4Lbp2KOiihyTPzlXqK1KGy/XgXUyDqZtSzc+hVDgyZbh9x9VzDD4xC29NSqQdDrBbuCPutdqEA/pYYCJHhrQR2JUneC+fYPv6SXW35+NfHZE/xNiOEJ6Y23JwXabalHhjoqXmGuzkh0uQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eQmoZWZ7; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710851505; x=1742387505;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=dpUPLrqHwakMnlL6jbNOapLyjpMQqdiCfAGidRZmjgI=;
  b=eQmoZWZ7g3BzcE1hRYQkn/AwzXZeNgA8hRAwXYCORSKX1eb3hk6gnawy
   jhWRJG4HqxNCZj4HIJ5Dn5YLn6AuA0nVW0bhiP7UC62Xc7PXBR5mNbrsp
   Fn7m34FaOzdTyxZ1rnvBmIpywJM6deA8RFKHlxq5XAfVsMB46h3OQsIL0
   fCh/tqAkmw0kIGoNiVPK7lFJYAE7fSiP5zb8lBWDcabOX9YVzJIHUscGb
   lFGLOC+XgcURdSr6ks2a6OUFhA2tZtd0UVAdrsBdcrNoRWVhvqoWzfD6p
   iqVGVH5vBvoabT4eqf/2bynXoD4GN4bWGgRbk3/S4GtsBS8gB+SWFDa03
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11017"; a="5583057"
X-IronPort-AV: E=Sophos;i="6.07,136,1708416000"; 
   d="scan'208";a="5583057"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2024 05:31:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,136,1708416000"; 
   d="scan'208";a="18250218"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.12])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2024 05:31:42 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 19 Mar 2024 14:31:38 +0200 (EET)
To: "Luke D. Jones" <luke@ljones.dev>
cc: platform-driver-x86@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, 
    LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 1/1] platform/x86: asus-wmi: add support variant of
 TUF RGB
In-Reply-To: <20240310055750.13160-2-luke@ljones.dev>
Message-ID: <42f1c0d5-e7ac-4efb-fef7-75d07ad2ffaa@linux.intel.com>
References: <20240310055750.13160-1-luke@ljones.dev> <20240310055750.13160-2-luke@ljones.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Sun, 10 Mar 2024, Luke D. Jones wrote:

> Adds support for a second TUF RGB wmi call that some versions of the TUF
> laptop come with. Also adjusts existing support to select whichever is
> available.
> 
> Signed-off-by: Luke D. Jones <luke@ljones.dev>
> ---
>  drivers/platform/x86/asus-wmi.c            | 12 +++++++++++-
>  include/linux/platform_data/x86/asus-wmi.h |  1 +
>  2 files changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
> index 2cf695289655..ca8c73c15fcc 100644
> --- a/drivers/platform/x86/asus-wmi.c
> +++ b/drivers/platform/x86/asus-wmi.c
> @@ -280,6 +280,7 @@ struct asus_wmi {
>  	bool nv_temp_tgt_available;
>  
>  	bool kbd_rgb_mode_available;
> +	u32 kbd_rgb_dev;
>  	bool kbd_rgb_state_available;
>  
>  	bool throttle_thermal_policy_available;
> @@ -870,6 +871,7 @@ static ssize_t kbd_rgb_mode_store(struct device *dev,
>  				 struct device_attribute *attr,
>  				 const char *buf, size_t count)
>  {
> +	struct asus_wmi *asus = dev_get_drvdata(dev);
>  	u32 cmd, mode, r, g, b, speed;
>  	int err;
>  
> @@ -906,7 +908,7 @@ static ssize_t kbd_rgb_mode_store(struct device *dev,
>  		speed = 0xeb;
>  	}
>  
> -	err = asus_wmi_evaluate_method3(ASUS_WMI_METHODID_DEVS, ASUS_WMI_DEVID_TUF_RGB_MODE,
> +	err = asus_wmi_evaluate_method3(ASUS_WMI_METHODID_DEVS, asus->kbd_rgb_dev,
>  			cmd | (mode << 8) | (r << 16) | (g << 24), b | (speed << 8), NULL);
>  	if (err)
>  		return err;
> @@ -4537,6 +4539,14 @@ static int asus_wmi_add(struct platform_device *pdev)
>  		asus->gpu_mux_dev = ASUS_WMI_DEVID_GPU_MUX_VIVO;
>  	}
>  
> +	if (asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_TUF_RGB_MODE)) {
> +		asus->kbd_rgb_mode_available = true;
> +		asus->kbd_rgb_dev = ASUS_WMI_DEVID_TUF_RGB_MODE;
> +	} else if (asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_TUF_RGB_MODE2)) {
> +		asus->kbd_rgb_mode_available = true;
> +		asus->kbd_rgb_dev = ASUS_WMI_DEVID_TUF_RGB_MODE2;
> +	}

Hi,

Why are you leaving this line there (unlike in the GPU MUX patch where 
you replaced it with the similar if()s as above):

	asus->kbd_rgb_mode_available = asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_TUF_RGB_MODE);

?

-- 
 i.



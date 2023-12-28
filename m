Return-Path: <linux-kernel+bounces-12785-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42E1D81FA0A
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 17:51:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 740EE1C22666
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 16:51:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32128F519;
	Thu, 28 Dec 2023 16:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XjY3XksU"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8F99F4EC
	for <linux-kernel@vger.kernel.org>; Thu, 28 Dec 2023 16:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703782278; x=1735318278;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XYOTYJ77YKnUFrVlaJSxWr2I93Md1Ed7ac29wDvu4Fg=;
  b=XjY3XksUTn12S+n8xcjUpru1jnLXPYoxRNT7Nu23x51x+i1cCCjzVXhy
   LkwsNAEAwf76U1xOsc7u88BaoKFd0xCKb290HKrLSWPWMOG6uhxCc0y67
   sRTspJqyA1pI0WmJorqA5eOEKqqIv3bU6RGBXA+KjTXKatgbXu3seSc+0
   Ul8TuO0DEd3JztLMjevpC6uSkwVr8Aueq+u/Vqwd77NOEZbc0LCIIYjWf
   RpIoHAtAk24M9nxAAAjQ05nMfPB8t/r5HYuG6rtYVZDLhYsnPiAb9UF/L
   S6HeKjxTCdw2L9QknUxomETMLh48x9YOGCIr2ShPkqPB0nYM0yh4U7hQe
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10937"; a="395455929"
X-IronPort-AV: E=Sophos;i="6.04,312,1695711600"; 
   d="scan'208";a="395455929"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Dec 2023 08:51:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10937"; a="848987390"
X-IronPort-AV: E=Sophos;i="6.04,312,1695711600"; 
   d="scan'208";a="848987390"
Received: from noblecat-mobl.ger.corp.intel.com (HELO localhost) ([10.252.35.63])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Dec 2023 08:51:15 -0800
Date: Thu, 28 Dec 2023 15:04:37 +0100
From: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
To: Yaxiong Tian <iambestgod@outlook.com>
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org,
	tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch,
	linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
	Yaxiong Tian <tianyaxiong@kylinos.cn>
Subject: Re: [PATCH] drm/debugfs: fix memory leak in
 drm_debugfs_remove_files()
Message-ID: <ZY2AdV1DP6YnSh6g@linux.intel.com>
References: <PUZPR01MB4775A8F67AE31D6A4927E6B7D59EA@PUZPR01MB4775.apcprd01.prod.exchangelabs.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PUZPR01MB4775A8F67AE31D6A4927E6B7D59EA@PUZPR01MB4775.apcprd01.prod.exchangelabs.com>

On Thu, Dec 28, 2023 at 04:07:40PM +0800, Yaxiong Tian wrote:
> From: Yaxiong Tian <tianyaxiong@kylinos.cn>
> 
> The dentry returned by debugfs_lookup() needs to be released by calling
> dput() which is missing in drm_debugfs_remove_files(). Fix this by adding
> dput().
> 
> Signed-off-by: Yaxiong Tian <tianyaxiong@kylinos.cn>
Reviewed-by: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>

> ---
>  drivers/gpu/drm/drm_debugfs.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/drm_debugfs.c b/drivers/gpu/drm/drm_debugfs.c
> index f4715a67e340..4d299152c302 100644
> --- a/drivers/gpu/drm/drm_debugfs.c
> +++ b/drivers/gpu/drm/drm_debugfs.c
> @@ -277,6 +277,7 @@ int drm_debugfs_remove_files(const struct drm_info_list *files, int count,
>  
>  		drmm_kfree(minor->dev, d_inode(dent)->i_private);
>  		debugfs_remove(dent);
> +		dput(dent);
>  	}
>  	return 0;
>  }
> -- 
> 2.25.1
> 


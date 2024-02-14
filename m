Return-Path: <linux-kernel+bounces-65096-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 278A78547B6
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 12:05:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 206A9B2501E
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 11:05:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 424E218EAD;
	Wed, 14 Feb 2024 11:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Bu55+Q1N"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F06418638;
	Wed, 14 Feb 2024 11:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707908724; cv=none; b=HYv+jvHjueF9+7CzBkG9zNroX3Mlt/r1WPLgOQ8bPuIDHqqY4Vs5PBvom3NxmMM2D+KcjJqNY/ngaT5QJiWN6rgKFpcocalKO+49Ur9rxT57ybj2zsa3RdLfxEBzvJPnqGhILC2vb7Xd0amNDlngfocJVCeB85CF1eSqaaAUnC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707908724; c=relaxed/simple;
	bh=leNWJYh69CV7bQ1lqnd7BjWIi97NaiPuvMnUCm+KwVA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LPlN5BFsvfg+jRYsdZv47oXuIjFHiOPjE/pBiZbckzg+0AZUldiG3NnOJumbv8MQx/++tWm9ASrWy0JoqxH7mEXz1oB+wr9nC09mt7tjHTKb2/SWO6M5KpKFIKF1wGfBL087/akDTYC/i3CVLliEneYrlJpEPezaIym9fCLwCys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Bu55+Q1N; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707908723; x=1739444723;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=leNWJYh69CV7bQ1lqnd7BjWIi97NaiPuvMnUCm+KwVA=;
  b=Bu55+Q1NxFgFJ5W5IAcJVrZ9trvJowb9yIqCwri1xY3wHVAU/AfArXgf
   pahKP8AKmz6yTSPY6FcQRwG3T9th+hD6KLvCrgtUU+8aNFUKk0XaFbIVu
   yfT8mrP9KAb95cSpv8vLv+Tgfgxi+QP54qdvBQizVrf5FNIyMZt2Tr6uL
   eYzOnEkd+jCOsNylOrKEeY6+KHSFBg7/oj4IRLAg4uKH3iZGqizVXgOb3
   3cADWHw55biaFjlYNe2VoC5egNE+6th0Dkdc6bNER8LG3SROnlpqmiu6q
   4tVDhV5Lns7TH+7jNZNfluYLPYZ5JE3habUnQ6UjBoWeFgCkXVel8s+vn
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="2069860"
X-IronPort-AV: E=Sophos;i="6.06,159,1705392000"; 
   d="scan'208";a="2069860"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2024 03:05:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,159,1705392000"; 
   d="scan'208";a="3511208"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2024 03:05:20 -0800
Received: from kekkonen.localdomain (localhost [127.0.0.1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id ECCE111F86A;
	Wed, 14 Feb 2024 13:05:16 +0200 (EET)
Date: Wed, 14 Feb 2024 11:05:16 +0000
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Youssef Quaisse <yquaisse@gmail.com>
Cc: bingbu.cao@intel.com, tian.shu.qiu@intel.com, mchehab@kernel.org,
	gregkh@linuxfoundation.org, skhan@linuxfoundation.org,
	linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-media@vger.kernel.org
Subject: Re: [PATCH] Fix three warnings when running `make htmldocs`
Message-ID: <ZcyebKY86sAJDhr4@kekkonen.localdomain>
References: <20240210221451.27769-1-yquaisse@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240210221451.27769-1-yquaisse@gmail.com>

Hi Youssef,

On Sat, Feb 10, 2024 at 10:14:38PM +0000, Youssef Quaisse wrote:
> Running `make htmldocs` generates warnings for file
> drivers/staging/media/ipu3/include/uapi/intel-ipu3.h.
> 
> Fix was to remove the "excess" definitions.
> 
> Warnings in question:
> 
> ```
> ./drivers/staging/media/ipu3/include/uapi/intel-ipu3.h:2522: warning: Excess struct member 'reserved1' description in 'ipu3_uapi_acc_param'
> ./drivers/staging/media/ipu3/include/uapi/intel-ipu3.h:2522: warning: Excess struct member 'reserved2' description in 'ipu3_uapi_acc_param'
> ./drivers/staging/media/ipu3/include/uapi/intel-ipu3.h:2778: warning: Excess struct member '__acc_osys' description in 'ipu3_uapi_flags'
> ```
> 
> Signed-off-by: Youssef Quaisse <yquaisse@gmail.com>

Thanks for the patch. These have been already addressed by commit
dcef3ed5b0d79f89018e31d55cf09f2c2f81392b .

> ---
>  drivers/staging/media/ipu3/include/uapi/intel-ipu3.h | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/staging/media/ipu3/include/uapi/intel-ipu3.h b/drivers/staging/media/ipu3/include/uapi/intel-ipu3.h
> index caa358e0bae4..4aa2797f5e3c 100644
> --- a/drivers/staging/media/ipu3/include/uapi/intel-ipu3.h
> +++ b/drivers/staging/media/ipu3/include/uapi/intel-ipu3.h
> @@ -2485,11 +2485,9 @@ struct ipu3_uapi_anr_config {
>   *		&ipu3_uapi_yuvp1_y_ee_nr_config
>   * @yds:	y down scaler config. See &ipu3_uapi_yuvp1_yds_config
>   * @chnr:	chroma noise reduction config. See &ipu3_uapi_yuvp1_chnr_config
> - * @reserved1: reserved
>   * @yds2:	y channel down scaler config. See &ipu3_uapi_yuvp1_yds_config
>   * @tcc:	total color correction config as defined in struct
>   *		&ipu3_uapi_yuvp2_tcc_static_config
> - * @reserved2: reserved
>   * @anr:	advanced noise reduction config.See &ipu3_uapi_anr_config
>   * @awb_fr:	AWB filter response config. See ipu3_uapi_awb_fr_config
>   * @ae:	auto exposure config  As specified by &ipu3_uapi_ae_config
> @@ -2724,7 +2722,6 @@ struct ipu3_uapi_obgrid_param {
>   * @acc_ae: 0 = no update, 1 = update.
>   * @acc_af: 0 = no update, 1 = update.
>   * @acc_awb: 0 = no update, 1 = update.
> - * @__acc_osys: 0 = no update, 1 = update.
>   * @reserved3: Not used.
>   * @lin_vmem_params: 0 = no update, 1 = update.
>   * @tnr3_vmem_params: 0 = no update, 1 = update.

-- 
Kind regards,

Sakari Ailus


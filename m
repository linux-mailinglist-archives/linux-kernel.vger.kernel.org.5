Return-Path: <linux-kernel+bounces-102716-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1458087B66D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 03:32:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 379C41C212B4
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 02:32:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EFC6211C;
	Thu, 14 Mar 2024 02:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HbljAmu3"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 468C5A55
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 02:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710383544; cv=none; b=GSFGe01YqbDuCwP8zkWcers5rdkH88HKi3i+JI/SYPdeCgiQiQhWvbv5ymEgs0NnWwjdvGDj2ii1XAn8fzRWMnQjqP4UEA1sHkocGt2f13/oC0Rp6hrnqptz7nJa+g5PnXqGmP7FYNMYPrwfVWUtrDAb2zTGtbW5oSOaz2Pfb9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710383544; c=relaxed/simple;
	bh=pe3erww6iGV5Z2CHt+wZW7sosEJYvm2NBU6QR6tsMb0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FOIS8YbxuTchOrF8PKLqU1h9sXaTNN7jNCnockZzrtXX4hsFpPZWH8mw6wZVnvc7vCJ8IMzZLKQWqeg1S42J2bzapV9vwziiM/Cyw89vOax0AitUIKhk9K9ZSrmrSkHfvS/4a1G7CiT/V2tC4/IKDQq+XGPMh590fUqRmXul2Rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HbljAmu3; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710383543; x=1741919543;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=pe3erww6iGV5Z2CHt+wZW7sosEJYvm2NBU6QR6tsMb0=;
  b=HbljAmu3wQ2HM+MI9ad453a6LkPoIKj42nMdOR2rhm/LsrY3vLHhUGhB
   4WQFoD1HeuEXdUsF2o0kbHjn7K81aZucLqhBGVdTQTSugjXartrvhABxU
   efS9cyn0rYRIY+h1MUOu0VTK/DA750u0p6qF2+MK7QY8xTEZRKXsLpUBP
   PmJpIxTEwPBzD5VhSDFXGz4t+QQed/RpCK7CZgwfMP5G1HPX1QR+RudJj
   QWZE3Mq5egIIXkuKCqBwYwnaRTSbk5kf2QURPJKh2PMlZ7EPKT6EWtWLM
   f4Rs360FT5Q1FqwlEFqmzJxSutD+CKwFfjqMrzzz/4DSrYMYoirUHEjjw
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11012"; a="15826132"
X-IronPort-AV: E=Sophos;i="6.07,124,1708416000"; 
   d="scan'208";a="15826132"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2024 19:32:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,124,1708416000"; 
   d="scan'208";a="12545220"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.209.86.131])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2024 19:32:22 -0700
Date: Wed, 13 Mar 2024 19:32:20 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Ayush Tiwari <ayushtiw0110@gmail.com>
Cc: Larry.Finger@lwfinger.net, florian.c.schilhabel@googlemail.com,
	gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev, outreachy@lists.linux.dev
Subject: Re: [PATCH] staging: greybus: add comment for mutex
Message-ID: <ZfJhtBrsL3elRve8@aschofie-mobl2>
References: <ZfHuokO3pQXMOxcC@ayush-HP-Pavilion-Gaming-Laptop-15-ec0xxx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZfHuokO3pQXMOxcC@ayush-HP-Pavilion-Gaming-Laptop-15-ec0xxx>

On Wed, Mar 13, 2024 at 11:51:22PM +0530, Ayush Tiwari wrote:
> This patch adds descriptive comment to mutex within the struct
> gbaudio_codec_info to clarify its intended use and to address
> checkpatch checks.

Hi Ayush-

You may be right, but you need to convince your patch reviewers
why your comment accurately describes this mutex.

That's always the ask with this kind of patch.

BTW - Don't start your commit log with 'This patch...'.

Alison

> 
> Signed-off-by: Ayush Tiwari <ayushtiw0110@gmail.com>
> ---
>  drivers/staging/greybus/audio_codec.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/staging/greybus/audio_codec.h b/drivers/staging/greybus/audio_codec.h
> index f3f7a7ec6be4..1f97d4fb16cd 100644
> --- a/drivers/staging/greybus/audio_codec.h
> +++ b/drivers/staging/greybus/audio_codec.h
> @@ -71,6 +71,7 @@ struct gbaudio_codec_info {
>  	/* to maintain runtime stream params for each DAI */
>  	struct list_head dai_list;
>  	struct mutex lock;
> +	/* Lock to protect register access */
>  	struct mutex register_mutex;
>  };
>  
> -- 
> 2.40.1
> 
> 


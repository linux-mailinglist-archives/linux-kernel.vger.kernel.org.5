Return-Path: <linux-kernel+bounces-118074-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E197888B622
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 01:34:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6BCBCB2AC28
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 22:01:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E65B770CB4;
	Mon, 25 Mar 2024 22:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PI9ESCe8"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B969A6FE2B;
	Mon, 25 Mar 2024 22:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711404082; cv=none; b=PfG+xVdrVDdete/h5ciKdRNwsBaYHog/Ua0NfMXy6hHzks20RNqJmg12X9Dm4QVKwvJ2iiCrpdUw9+RRaVytbXQaO1p6auMPobdJGgRcdhFm052K9yV4slUiLPFlQ35m2Sq2BcTPudmd5Jw4nZ/w7fPi3wV1YPSGkS6Qhg4yxFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711404082; c=relaxed/simple;
	bh=a8ojaLzDl4GFJujvayJ70jYfCqO9SVCGKM0gEiJ//B0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C/Y7SmZacFSds3NE2qx2lzPa5ERz1Lw+gTKeY5gbhMTmRzKwAfoOwAjqRva+X3cAxfJBXB6XNfgUd1BHhkTy/VSwPviVUnqjH4K2ZM3kGERHM9pr/TX0gp8WXKkfBBqK4mNgJzk7NvMRghU0xVIAkpIRFuD3g7eXaW6KEqp0qpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PI9ESCe8; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711404081; x=1742940081;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=a8ojaLzDl4GFJujvayJ70jYfCqO9SVCGKM0gEiJ//B0=;
  b=PI9ESCe8Y/5OaUZpUqgMT2ILPXWvM9whxrb1sC5IJbA8gEdJ59X1Dd90
   FB3qFHkI1axrcMDaW5P9zIeygmfZ+PsJEDfQzC+DMtY4zI+mDVeFOinJU
   s1Y7aIJOIDCFdbAxNKGaGqzvDUJZGaT3gImoQUNUgGQyebSSHYNy3q4D1
   iF5vFRFcAFznB7ai89r+00af06eWiVcPT1cSeG6Mro2JITSQwi/uRAczr
   EjpEfiWZkm2kF3bpw+Sc+MSojK6G0Qp/+j6gHFk6WTNa+xAx0PyHgY9Ww
   igUuOJ/rWIAkCynDbEEkYazRapagxDCgYRB4IkHAPGMVEExWexlVWpaYS
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11024"; a="17827860"
X-IronPort-AV: E=Sophos;i="6.07,154,1708416000"; 
   d="scan'208";a="17827860"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2024 15:01:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,154,1708416000"; 
   d="scan'208";a="15619103"
Received: from jaimbres-mobl2.amr.corp.intel.com (HELO [10.212.98.109]) ([10.212.98.109])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2024 15:01:19 -0700
Message-ID: <377e0f33-697c-4baf-ac48-baff6199dd53@linux.intel.com>
Date: Mon, 25 Mar 2024 17:01:18 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] ALSA: hda/tas2781: add debug statements to kcontrols
Content-Language: en-US
To: Gergo Koteles <soyer@irl.hu>, Shenghao Ding <shenghao-ding@ti.com>,
 Kevin Lu <kevin-lu@ti.com>, Baojun Xu <baojun.xu@ti.com>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org, linux-sound@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <cover.1711401621.git.soyer@irl.hu>
 <cbdc337b911bee0f80f805b936041fd59c1db54a.1711401621.git.soyer@irl.hu>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <cbdc337b911bee0f80f805b936041fd59c1db54a.1711401621.git.soyer@irl.hu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit




> +++ b/sound/pci/hda/tas2781_hda_i2c.c
> @@ -189,6 +189,9 @@ static int tasdevice_get_profile_id(struct snd_kcontrol *kcontrol,
>  
>  	ucontrol->value.integer.value[0] = tas_priv->rcabin.profile_cfg_id;
>  
> +	dev_dbg(tas_priv->dev, "%s: %d\n", __func__,

Nit-pick: you don't need to add __func__ to dev_dbg logs, the user can
add the information with the dyndbg parameter, e.g.

options snd_intel_dspcfg dyndbg=+pmf

dev_err/warn don't have this functionality though so in those cases
there's no replacement for __func__




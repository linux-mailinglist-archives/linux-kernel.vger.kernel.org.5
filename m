Return-Path: <linux-kernel+bounces-34911-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C79DE83891B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 09:36:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D7391F26BF1
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 08:36:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 359BF5812D;
	Tue, 23 Jan 2024 08:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Yuje2f7b"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B914856B99;
	Tue, 23 Jan 2024 08:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.55.52.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705998849; cv=none; b=SX+bhMv0mvu95RtpK88d2j2NcZ9dhHI3CVoNgGDaXcJBKqm4Zroam5AxN5MGBrd3cj4QjzcAtmE0lXfFKkKHbrmFWdgW8N3e7MYKvkvvbVYDALEKhzAc6GaW6uBPCbh6RUAPGRjGKI8usM/VWfp4FU9SA6TQjec3qhYYCe5nlk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705998849; c=relaxed/simple;
	bh=ZWGRlXBFfPFOmCTbF8+Gg5VQTsULZlZZ5aaqessVmL4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mAdqjxOoOWDSrfasRfTl1mzsTSeJMfiwTlnxqjYAEFp2WIrZMr2bjqY/2M5TCRhP04Bw9B8dv1SXaVfsWvGtPVJ31zWHcuIhRsJD3WrHwJ9PcSOxYePxdFVsqbmk3q7eDYchhmHN9FZUhKWKkvf+VNAyFuA31F1PeM0We8TJw90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Yuje2f7b; arc=none smtp.client-ip=192.55.52.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705998847; x=1737534847;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ZWGRlXBFfPFOmCTbF8+Gg5VQTsULZlZZ5aaqessVmL4=;
  b=Yuje2f7bNfQ1iarhJO7JoQE5ijuTSQmV3PVhsvMmWPy4GpiNNAeiTqmR
   Stsk4wLVk4z9qBsQQTrtg3B3ifW4mn/UpnLoWp9BiNHigrDPwhNFHS0w2
   mN+EmMB3FTn0di2v+riXF3qFWmv1MyTDB+tBbyXVfaiFC2bSJcwOMlJHD
   z1Ro860h+15/lSgG8n5cmLLImPPsLIgaUT32BGqa/QSWIBSq89oESHcRX
   mF31zFDTzwpIn81KFQJyH1oyQm51B/Eyci/5069Gq0I41JsREVxb7YpJE
   5keFzw0SnY3uEVuztBR5lcbZSilPqAcYfbbFANqDhN5Xkyy7SY+lSAmV4
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10961"; a="398604198"
X-IronPort-AV: E=Sophos;i="6.05,213,1701158400"; 
   d="scan'208";a="398604198"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2024 00:34:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10961"; a="909223366"
X-IronPort-AV: E=Sophos;i="6.05,213,1701158400"; 
   d="scan'208";a="909223366"
Received: from hle1-mobl.amr.corp.intel.com (HELO [10.254.116.113]) ([10.254.116.113])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2024 00:34:02 -0800
Message-ID: <30f022a5-7ab1-4b2d-b4c1-5a209ec67c5b@linux.intel.com>
Date: Tue, 23 Jan 2024 09:34:00 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ASoC: Intel: mtl-match: Add cs42l43_l0 cs35l56_l23 for
 MTL
Content-Language: en-US
To: Maciej Strozek <mstrozek@opensource.cirrus.com>,
 Mark Brown <broonie@kernel.org>
Cc: Cezary Rojewski <cezary.rojewski@intel.com>,
 Liam Girdwood <lgirdwood@gmail.com>,
 Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
 Bard Liao <yung-chuan.liao@linux.intel.com>,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>, alsa-devel@alsa-project.org,
 patches@opensource.cirrus.com, linux-sound@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240122151545.69437-1-mstrozek@opensource.cirrus.com>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20240122151545.69437-1-mstrozek@opensource.cirrus.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/22/24 16:15, Maciej Strozek wrote:

It wouldn't hurt to add a brief commit message describing what the
hardware layout is, specifically how the mics are handled.

It's also best to submit the corresponding machine driver updates at the
same time to check for consistency.


>  	},
> +	{
> +		.link_mask = BIT(0) | BIT(2) | BIT(3),
> +		.links = cs42l43_link0_cs35l56_link2_link3,
> +		.drv_name = "sof_sdw",
> +		.sof_tplg_filename = "sof-mtl-cs42l43-l0-cs35l56-l23.tplg",

was this topology submitted to the SOF tree? I don't see it, usually we
review topology/acpi/machine stuff together to avoid disconnects.

> +	},
>  	{
>  		.link_mask = GENMASK(2, 0),
>  		.links = mtl_cs42l43_cs35l56,
> --
> 2.34.1
> 


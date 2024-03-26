Return-Path: <linux-kernel+bounces-119280-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2084D88C68B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 16:15:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B51151F649C9
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 15:15:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2223613C907;
	Tue, 26 Mar 2024 15:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fW6P99nA"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 067EC13C813
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 15:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711466014; cv=none; b=r08ZS+gAOPQmvSFPlkjdlhdaqI+xmK9jhk6582GmnxPByet5ffgKbvBD6VOWmaqEETawZQwyxD8KVgzP2/y1wu6ZuiHUZNWfAv/ILN/gnADcNCPsDrCVPGGGaRnlVDHBW9N9eE0dfsVQajM2Yw/WPqxtGHawr+63o+D4ieh6EYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711466014; c=relaxed/simple;
	bh=14LLqfHRDImCwD3vmt3ns5M9+uGf0q9+6XiG8CQ/IWQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Bl9w2Ppv8zCwiq0MVKFHVB0Y1JOPWaPhcDjuPPs+/ryP77OOc8JxwxpDbTkZsk0vSuqMMQOtavKqdW6ubKcoSXahr4S7b5fwJJLpLXxY1oREPawiFGw8BVfAvhUCPzQZMcRHF6YQ5bUpPOPgqT4vVkXT2J19U/KFxA+iguXUuDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fW6P99nA; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711466013; x=1743002013;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=14LLqfHRDImCwD3vmt3ns5M9+uGf0q9+6XiG8CQ/IWQ=;
  b=fW6P99nAWg6XXZFu9gPCurbu1C5kOySWqcoqMjk5eacvXrpTIfWwsboJ
   x1OFOV746OUppWEhNAPWox7yn0DIlSdGjM/Z7engrKof30JVIPWEAEPNG
   6oH3ORvYh7dvKoQFlTeeVQoG4OS5RC74PwTzuQu3DgnZbxAyf25TZ6a5M
   WXkFHw7wq8QDTq7D6qmV/Zqbemhmra7psHJ/8VzyuTuWCreNdUF6L5MqR
   Hn2RMDWGR39SvM5t3tuhUbIc2eJoNiL0NrAjbmTRTkSJQTw1t075Q8MMN
   Fz6yses6iXOTVltCsln1xq6pmrEUk0mbuP2XQxbySoMzS6ydekpTOOFK/
   Q==;
X-CSE-ConnectionGUID: tk5rF5R3Sc6sjII9s+RmCg==
X-CSE-MsgGUID: GjpRcpKhQ0SBH5dzNZ/N4A==
X-IronPort-AV: E=McAfee;i="6600,9927,11025"; a="9489037"
X-IronPort-AV: E=Sophos;i="6.07,156,1708416000"; 
   d="scan'208";a="9489037"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2024 08:13:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,156,1708416000"; 
   d="scan'208";a="15862594"
Received: from bhubbert-mobl.amr.corp.intel.com (HELO [10.212.65.108]) ([10.212.65.108])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2024 08:13:30 -0700
Message-ID: <b4c5fb89-a43c-4c40-b729-a49a537f6179@linux.intel.com>
Date: Tue, 26 Mar 2024 10:05:20 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 6/8] ALSA: hda/tas2781: Add tas2781 SPI-based driver
Content-Language: en-US
To: Baojun Xu <baojun.xu@ti.com>, tiwai@suse.de
Cc: robh+dt@kernel.org, andriy.shevchenko@linux.intel.com,
 lgirdwood@gmail.com, perex@perex.cz, kevin-lu@ti.com, 13916275206@139.com,
 alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
 liam.r.girdwood@intel.com, yung-chuan.liao@linux.intel.com,
 broonie@kernel.org, soyer@irl.hu
References: <20240326010905.2147-1-baojun.xu@ti.com>
 <20240326010905.2147-6-baojun.xu@ti.com>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20240326010905.2147-6-baojun.xu@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


> +enum device_catlog_id {

catalog?

> +	HP = 0,
> +	OTHERS
> +};

Is there not a better way to identify solutions?
You have ACPI IDs, no?



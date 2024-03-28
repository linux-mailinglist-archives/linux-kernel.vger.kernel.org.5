Return-Path: <linux-kernel+bounces-122359-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF0D888F5A0
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 03:55:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0A9F1C2A061
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 02:55:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5521A25761;
	Thu, 28 Mar 2024 02:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kAax2PXh"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A870518C05;
	Thu, 28 Mar 2024 02:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711594499; cv=none; b=U6lO90fiSfvz3trOisujsiY/d8AuddM4LrBSfN6i2Lf//lCP0m2IibMUpAVMLjXSJRONkmNjQ7LRIn/TXcboCQQpwKhhXyrcbjhxcjP1I5E/CKnKTcmpAb6NvUfb/cTczj3tHG+r31oiYO2e39/YPBDtTY7rlFN8Nggd4ocJ1iE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711594499; c=relaxed/simple;
	bh=1sp0hV8RqkPQBJq2mREzMqDKTGMCyFnpZV5/Fxer8SM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ml/28SfOLhoKru/2ONZdwrTrYXn+mljz/+YNvJN2R5/xszDX9PT0Y32S/CLloVYT2bWZIFk3v+yFd9wk4JiBmeFSkMflHTiixK5CKeqe/ZH5NAs0tUMfL2t0ZjG2rQISMfNyaiyV0gJpmiomuUqj+R0EYakho+atGky9cYZ3CL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kAax2PXh; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711594498; x=1743130498;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=1sp0hV8RqkPQBJq2mREzMqDKTGMCyFnpZV5/Fxer8SM=;
  b=kAax2PXhetNuDSIrbNoJWNtY2AahNvA15Ea81k716BzldOc8jKRLS9pf
   fw10ebwbDvwGMIKDNNClM1M3f411nyTVnK2OeKPy69lEhyoHENLSzLG1l
   BVzKJxtfCdAvRQaf/3r3Cv+BGjbyTRhULTjpmRriBlG/ZiqbH0djtF1Tx
   jqywQu3jBviLsAqUixdvRKQTsxnijKe/ae9T3sPFvwTv558hh7gB6i3/6
   PjjUmnfbRPqmXVEL7YNJfXYOMDnw0WmTOQttUlnGJGXqZ4Vl1+zq4PL01
   3zYoMJYZOVScyOBX53Jn0vuLJ82gkI23pRHxd0T4gDHach8KUHoKWlKu3
   Q==;
X-CSE-ConnectionGUID: TWthrbFzSGiclSWCCD7PJw==
X-CSE-MsgGUID: P0Qsj4d1TpiWeu0tuqhE1w==
X-IronPort-AV: E=McAfee;i="6600,9927,11026"; a="6593661"
X-IronPort-AV: E=Sophos;i="6.07,160,1708416000"; 
   d="scan'208";a="6593661"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2024 19:54:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,160,1708416000"; 
   d="scan'208";a="21183097"
Received: from soralee-mobl1.amr.corp.intel.com (HELO [10.255.228.178]) ([10.255.228.178])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2024 19:54:57 -0700
Message-ID: <f1f0518a-b9e5-4c27-9820-3b9531639f1d@linux.intel.com>
Date: Wed, 27 Mar 2024 19:54:56 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] platform/x86: wmi: Mark simple WMI drivers as
 legacy-free
Content-Language: en-US
To: Armin Wolf <W_Armin@gmx.de>, hdegoede@redhat.com,
 ilpo.jarvinen@linux.intel.com
Cc: corbet@lwn.net, linux-doc@vger.kernel.org,
 platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240328012336.145612-1-W_Armin@gmx.de>
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20240328012336.145612-1-W_Armin@gmx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 3/27/24 6:23 PM, Armin Wolf wrote:
> The inspur_platform_profile driver and the xiaomi-wmi driver both
> meet the requirements for modern WMI drivers, as they both do not
> use the legacy GUID-based interface and can be safely instantiated
> multiple times.
>
> Mark them both as legacy-free using the no_singleton flag.
>
> Compile-tested only.
>
> Signed-off-by: Armin Wolf <W_Armin@gmx.de>
> ---
LGTM

Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
>  drivers/platform/x86/inspur_platform_profile.c | 1 +
>  drivers/platform/x86/xiaomi-wmi.c              | 1 +
>  2 files changed, 2 insertions(+)
>
> diff --git a/drivers/platform/x86/inspur_platform_profile.c b/drivers/platform/x86/inspur_platform_profile.c
> index 743705bddda3..8440defa6788 100644
> --- a/drivers/platform/x86/inspur_platform_profile.c
> +++ b/drivers/platform/x86/inspur_platform_profile.c
> @@ -207,6 +207,7 @@ static struct wmi_driver inspur_wmi_driver = {
>  	.id_table = inspur_wmi_id_table,
>  	.probe = inspur_wmi_probe,
>  	.remove = inspur_wmi_remove,
> +	.no_singleton = true,
>  };
>
>  module_wmi_driver(inspur_wmi_driver);
> diff --git a/drivers/platform/x86/xiaomi-wmi.c b/drivers/platform/x86/xiaomi-wmi.c
> index 54a2546bb93b..1f5f108d87c0 100644
> --- a/drivers/platform/x86/xiaomi-wmi.c
> +++ b/drivers/platform/x86/xiaomi-wmi.c
> @@ -83,6 +83,7 @@ static struct wmi_driver xiaomi_wmi_driver = {
>  	.id_table = xiaomi_wmi_id_table,
>  	.probe = xiaomi_wmi_probe,
>  	.notify = xiaomi_wmi_notify,
> +	.no_singleton = true,
>  };
>  module_wmi_driver(xiaomi_wmi_driver);
>
> --
> 2.39.2
>
>
-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer



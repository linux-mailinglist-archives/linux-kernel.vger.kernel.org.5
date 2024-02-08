Return-Path: <linux-kernel+bounces-58251-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C7C484E382
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 15:53:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D8DE1C27554
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 14:53:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E88947B3C5;
	Thu,  8 Feb 2024 14:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iFR1XY0B"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54C3B7995D;
	Thu,  8 Feb 2024 14:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707403986; cv=none; b=Rt3k6gH85cE/y6vJSOkrCBG/IlWMqyCIXFBYhOraI5CFKQBaKmeLW85NaE0aXVOXxR95NBMzweZjf8SZQjmMwEyXFruhdkc5+b+rXIYRfZrwQVIBMqdEypyZ2eLysamuHW57KpsH47ZtG+MBio/9ofdtgBGYICXmtgRYm7YE6nI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707403986; c=relaxed/simple;
	bh=2fMEyyKJRcrOmxoY0/lT0uNbd0529gjTYxA9DzWBnnw=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=InXFqw/t02dYdUHlLT+srKW0n5gjuy7JhOEXFmQ9OKbCMGSpkpaHvn/wwwF+CFsOfCduQT+VPGuRShXvBS4LTgQkNB2w6Q0SYyT0U33UZ0Ga/3+OXMkvc6RSFnbO4Ci51kW16GYWEABgU6H8muRPxkQwXcI9xVxkpaQVoKu0zOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iFR1XY0B; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707403984; x=1738939984;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=2fMEyyKJRcrOmxoY0/lT0uNbd0529gjTYxA9DzWBnnw=;
  b=iFR1XY0B+Eq/7fD9cCpZKiF77GFcyuk86U24dYPmdDo2wDANnyi91H+z
   0b83Kp2QBK/RMCq/HYON4xIamSm7yl63ouvkXX+va7NOVTyRlmex707Tu
   6/J74y6MhcjCfF+Sc4zLxwaVw2O6Ndx9fSWBCuPzVz7umo5qmBaZD1bry
   T6mDjl8XZQmJYkrXPj58aeiUVaPm9wSwLelquq5E+1LD+e1WeUrUXtkja
   ZKxJiRxzsS+7+0czn9I3Nciaqu8MSuGpyIelibjCYcji827vmrNEaSv78
   h9zaO30tjXzUl+eci+boCVb99iQPDPcXrB6NbJ3HbzSmrAW8/U/DgCJf8
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10978"; a="1098741"
X-IronPort-AV: E=Sophos;i="6.05,254,1701158400"; 
   d="scan'208";a="1098741"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 06:53:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,254,1701158400"; 
   d="scan'208";a="6285544"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.246.52.95])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 06:53:01 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 8 Feb 2024 16:52:58 +0200 (EET)
To: "David E. Box" <david.e.box@linux.intel.com>
cc: Netdev <netdev@vger.kernel.org>, 
    sathyanarayanan.kuppuswamy@linux.intel.com, 
    LKML <linux-kernel@vger.kernel.org>, platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH 8/8] tools: intel_sdsi: Add current meter support
In-Reply-To: <20240201010747.471141-9-david.e.box@linux.intel.com>
Message-ID: <ffdd7e28-9ed1-9380-7666-a7b108d84949@linux.intel.com>
References: <20240201010747.471141-1-david.e.box@linux.intel.com> <20240201010747.471141-9-david.e.box@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 31 Jan 2024, David E. Box wrote:

> Add support to read the 'meter_current' file. The display is the same as
> the 'meter_certificate', but will show the current snapshot of the
> counters.
> 
> Signed-off-by: David E. Box <david.e.box@linux.intel.com>
> ---
>  tools/arch/x86/intel_sdsi/intel_sdsi.c | 48 +++++++++++++++++---------
>  1 file changed, 31 insertions(+), 17 deletions(-)
> 
> diff --git a/tools/arch/x86/intel_sdsi/intel_sdsi.c b/tools/arch/x86/intel_sdsi/intel_sdsi.c
> index a8fb6d17405f..c9b3e457885d 100644
> --- a/tools/arch/x86/intel_sdsi/intel_sdsi.c
> +++ b/tools/arch/x86/intel_sdsi/intel_sdsi.c
> @@ -182,6 +182,7 @@ struct sdsi_dev {
>  enum command {
>  	CMD_SOCKET_INFO,
>  	CMD_METER_CERT,
> +	CMD_METER_CURRENT_CERT,
>  	CMD_STATE_CERT,
>  	CMD_PROV_AKC,
>  	CMD_PROV_CAP,
> @@ -329,7 +330,7 @@ static void get_feature(uint32_t encoding, char *feature)
>  	feature[0] = name[3];
>  }
>  
> -static int sdsi_meter_cert_show(struct sdsi_dev *s)
> +static int sdsi_meter_cert_show(struct sdsi_dev *s, bool show_current)
>  {
>  	char buf[METER_CERT_MAX_SIZE] = {0};
>  	struct bundle_encoding_counter *bec;
> @@ -360,7 +361,11 @@ static int sdsi_meter_cert_show(struct sdsi_dev *s)
>  		return ret;
>  	}
>  
> -	cert_ptr = fopen("meter_certificate", "r");
> +	if (!show_current)
> +		cert_ptr = fopen("meter_certificate", "r");
> +	else
> +		cert_ptr = fopen("meter_current", "r");

Please calculate the filename only once:

	cert_fname = show_current ? "meter_current" : "meter_certificate";
	cert_ptr = fopen(cert_fname, "r");

> +
>  	if (!cert_ptr) {
>  		perror("Could not open 'meter_certificate' file");

This line still has 'meter_certificate' so you need to convert it to 
fprintf() + strerror().

>  		return -1;
> @@ -368,7 +373,8 @@ static int sdsi_meter_cert_show(struct sdsi_dev *s)
>  
>  	size = fread(buf, 1, sizeof(buf), cert_ptr);
>  	if (!size) {
> -		fprintf(stderr, "Could not read 'meter_certificate' file\n");
> +		fprintf(stderr, "Could not read '%s' file\n",
> +			show_current ? "meter_current" : "meter_certificate");

Use the local variable from above.

-- 
 i.


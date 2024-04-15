Return-Path: <linux-kernel+bounces-144612-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 670228A4866
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 08:53:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21C88281BAE
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 06:53:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0CD6200D2;
	Mon, 15 Apr 2024 06:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YtJZCmX4"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F9DF1EB30;
	Mon, 15 Apr 2024 06:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713163996; cv=none; b=UKXrZZSbiMrzY6WdzlzO85VDdhpwszv6HjdF+Rem8A7W7+FLhPoQa9dMjIE+K16iex2fJLpCNWwYoDrtHBYxcNXPQYuclFTUmgmcnCK55AcWzoUmW51tOs6n/yPTw4O4fXRaK3jqG1XEsG41sOHBXCkbXJvMrhVzZIdd6N/uRdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713163996; c=relaxed/simple;
	bh=9Soc2Qo07sCZ8eMWp3+CQGUdGqKuLqNVP7Qq79vmnQc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=alhRzQM6lLIOAQe5oiGpcctAOebSVF+l5yOFrseyguBvtSKx9/w7iHHK1EmDxsLNU4eXw21pjxjL/cqmHcg4Ts7LKGLmgKNkbTA1kgMd+HDPnM/5xt/Avrzbn3BzbZU4iJef7cXsU69cAGeQZ/MQDvFDCYWHUq2Rj3Mvoc/DMr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YtJZCmX4; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713163995; x=1744699995;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9Soc2Qo07sCZ8eMWp3+CQGUdGqKuLqNVP7Qq79vmnQc=;
  b=YtJZCmX4C8CJQPQBheS28pbm/Y9dyKCKu2a+8QSchXozREGlLDolMoNi
   8FBjhNRiYMv/b6TFH5Jq1Hv5hNnugHan2XyddeRVPM4m6ooLMmNKLmpZu
   PabeFRz+7cc0ljcspQVU9jpoN9iw929f2ovVSOa138sgyIw8SLedLp/Xf
   Q6g4dQ93M+5ldIN9A6wl2ZcMuzoApbK/nPXWOdY7Gs11rD3floPe3XDbn
   eBUvGHGitmVDLmFmdlm13nppDcT2bMGQj2zS/hU2nC43pZLG6T4mmfRDp
   VJ4cJJ+2fP7wFIoDD4zDXJDiYr2kCFysw/14H3e+oDsOriOC+czvt8n39
   w==;
X-CSE-ConnectionGUID: Nd36ad9VQXGT2c+VE8af1A==
X-CSE-MsgGUID: h/iqeO82SjmlMH5ubC7T0Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11044"; a="12381350"
X-IronPort-AV: E=Sophos;i="6.07,202,1708416000"; 
   d="scan'208";a="12381350"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2024 23:53:15 -0700
X-CSE-ConnectionGUID: fLzT8YWXS2e79o7jH8xqmQ==
X-CSE-MsgGUID: pkQyKVBiSoKT56q5LbaPYw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,202,1708416000"; 
   d="scan'208";a="21806539"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmviesa010.fm.intel.com with SMTP; 14 Apr 2024 23:53:12 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 15 Apr 2024 09:53:10 +0300
Date: Mon, 15 Apr 2024 09:53:10 +0300
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: gregkh@linuxfoundation.org, dmitry.baryshkov@linaro.org,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel@collabora.com
Subject: Re: [PATCH] usb: typec: mux: it5205: Fix ChipID value typo
Message-ID: <ZhzOx2oQZMnyTgb/@kuha.fi.intel.com>
References: <20240409113646.305105-1-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240409113646.305105-1-angelogioacchino.delregno@collabora.com>

On Tue, Apr 09, 2024 at 01:36:46PM +0200, AngeloGioacchino Del Regno wrote:
> The ChipID bytes are read in inverse order: invert the ChipID value
> defined as IT5205FN_CHIP_ID and used for validating the same.
> 
> Fixes: 41fe9ea1696c ("usb: typec: mux: Add ITE IT5205 Alternate Mode Passive MUX driver")
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/mux/it5205.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/typec/mux/it5205.c b/drivers/usb/typec/mux/it5205.c
> index 5535932e42cd..4357cc67a867 100644
> --- a/drivers/usb/typec/mux/it5205.c
> +++ b/drivers/usb/typec/mux/it5205.c
> @@ -22,7 +22,7 @@
>  #include <linux/usb/typec_mux.h>
>  
>  #define IT5205_REG_CHIP_ID(x)	(0x4 + (x))
> -#define IT5205FN_CHIP_ID	0x35323035 /* "5205" */
> +#define IT5205FN_CHIP_ID	0x35303235 /* "5025" -> "5205" */
>  
>  /* MUX power down register */
>  #define IT5205_REG_MUXPDR        0x10
> -- 
> 2.44.0

-- 
heikki


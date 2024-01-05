Return-Path: <linux-kernel+bounces-17834-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6680D825364
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 13:36:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94F3D1C23044
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 12:36:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87A192D04A;
	Fri,  5 Jan 2024 12:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZhiWwE3E"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E7B12D056;
	Fri,  5 Jan 2024 12:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704458185; x=1735994185;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JLekH6LfdH1XcYg0zsP8rHQamQXBAPOrmRtK5D1F5i4=;
  b=ZhiWwE3E3uWJmUfcG0AWopTAUvEdfd5PZa4iAqMsBiTc0Sij1gdXVVwT
   dHLs6viEroUixC/f8RUWLYtz90pR7FOEj5w2Pi0oGi/puBrTX9wgx4QTg
   ix3OvLcfuSYuKyCpxhsu2Q751j+JpMWBvhYjANkHwNYwuNyVNTxkUykL3
   E4LR8MxljI6aS/1R0K1sgmrXqj9LAX+gU1Getp6/G5lQYaTAkkgKEL13h
   KAyd8/9Q24w/iAjZ+IjXPaJLGAH7MOkBlLAmgzZJUFL6MaNDZjWy0/rRK
   k0Gq7nh0/IqLp3kJjRBsluo62ESrTR/lbRNHUddmVA2LEneogaCRLMJX3
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10943"; a="376987681"
X-IronPort-AV: E=Sophos;i="6.04,333,1695711600"; 
   d="scan'208";a="376987681"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2024 04:36:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10943"; a="730467578"
X-IronPort-AV: E=Sophos;i="6.04,333,1695711600"; 
   d="scan'208";a="730467578"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by orsmga003.jf.intel.com with SMTP; 05 Jan 2024 04:36:21 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Fri, 05 Jan 2024 14:36:20 +0200
Date: Fri, 5 Jan 2024 14:36:20 +0200
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Roger Quadros <rogerq@kernel.org>,
	Javier Carrasco <javier.carrasco@wolfvision.net>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: typec: tipd: fix use of device-specific init
 function
Message-ID: <ZZf2lhtRdmIHmlBq@kuha.fi.intel.com>
References: <20240104-dev_spec_init-v1-1-1a57e7fd8cc8@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240104-dev_spec_init-v1-1-1a57e7fd8cc8@gmail.com>

On Thu, Jan 04, 2024 at 06:07:12PM +0100, Javier Carrasco wrote:
> The current implementation supports device-pecific callbacks for the
> init function with a function pointer. The patch that introduced this
> feature did not update one call to the tps25750 init function to turn it
> into a call with the new pointer in the resume function.
> 
> Fixes: d49f90822015 ("usb: typec: tipd: add init and reset functions to tipd_data")
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>

This was suggested by Roger, no?

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/tipd/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/typec/tipd/core.c b/drivers/usb/typec/tipd/core.c
> index a956eb976906..8a7cdfee27a1 100644
> --- a/drivers/usb/typec/tipd/core.c
> +++ b/drivers/usb/typec/tipd/core.c
> @@ -1495,7 +1495,7 @@ static int __maybe_unused tps6598x_resume(struct device *dev)
>  		return ret;
>  
>  	if (ret == TPS_MODE_PTCH) {
> -		ret = tps25750_init(tps);
> +		ret = tps->data->init(tps);
>  		if (ret)
>  			return ret;
>  	}

thans,

-- 
heikki


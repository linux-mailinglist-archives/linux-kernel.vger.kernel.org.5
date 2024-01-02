Return-Path: <linux-kernel+bounces-14249-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F72C8219EA
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 11:34:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 20490B21B96
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 10:34:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6660E544;
	Tue,  2 Jan 2024 10:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iVOxUp91"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D1B6DF53;
	Tue,  2 Jan 2024 10:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704191637; x=1735727637;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=vB30yYGhwiF7Ge0e4dg2cDuBshxg1ewUhro0i0ydFFU=;
  b=iVOxUp91TQXjYjY47NtLVioGFkpXbDOkX0EBeeBd0sTPZMLrb+BE2CtU
   NvUndqlBndhkeYG2kMTjbo4Q5aW2cNLpiH0LRVFd6mr5CILO0fZZWrFcF
   6ScPp2RJ+ik01OzBjAAM6vsNQhF29EUyww4YObn8kXA0m7xHGZc9gt5H+
   nuqP0XUeNF5A4rosGDiSifrAj7iXfNXuzIHiNu9fykb9Gff5KbU5Ez+Xh
   Q4sZxykWFCXLihuWKT/D8U42ZwwXA5veG/x7gGT/XSly0R5GqhZnXv7yO
   Ceevf+VnSywk0c5I1ignVFGgHEWxWDKULWe5+PnSh/T2jzgVHVhBuiLV3
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10940"; a="483049338"
X-IronPort-AV: E=Sophos;i="6.04,324,1695711600"; 
   d="scan'208";a="483049338"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jan 2024 02:33:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10940"; a="898486157"
X-IronPort-AV: E=Sophos;i="6.04,324,1695711600"; 
   d="scan'208";a="898486157"
Received: from mandrei-mobl.ger.corp.intel.com ([10.251.210.252])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jan 2024 02:33:54 -0800
Date: Tue, 2 Jan 2024 12:33:48 +0200 (EET)
From: =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Raag Jadav <raag.jadav@intel.com>
cc: Mika Westerberg <mika.westerberg@linux.intel.com>, 
    Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
    Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    Jiri Slaby <jirislaby@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
    linux-serial <linux-serial@vger.kernel.org>
Subject: Re: [PATCH v1] serial: 8250_lpss: copy dma_param using
 devm_kmemdup()
In-Reply-To: <20240102055006.27256-1-raag.jadav@intel.com>
Message-ID: <a676fff0-1c44-57a7-f7fe-899530c08bc7@linux.intel.com>
References: <20240102055006.27256-1-raag.jadav@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-934630736-1704191636=:2225"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-934630736-1704191636=:2225
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

On Tue, 2 Jan 2024, Raag Jadav wrote:

> Use devm_kmemdup() helper to copy dma_param instead of doing it manually.
> 
> Signed-off-by: Raag Jadav <raag.jadav@intel.com>
> ---
>  drivers/tty/serial/8250/8250_lpss.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_lpss.c b/drivers/tty/serial/8250/8250_lpss.c
> index 0e43bdfb7459..776ec1ef29d6 100644
> --- a/drivers/tty/serial/8250/8250_lpss.c
> +++ b/drivers/tty/serial/8250/8250_lpss.c
> @@ -287,17 +287,14 @@ static int lpss8250_dma_setup(struct lpss8250 *lpss, struct uart_8250_port *port
>  		return 0;
>  	}
>  
> -	rx_param = devm_kzalloc(dev, sizeof(*rx_param), GFP_KERNEL);
> +	rx_param = devm_kmemdup(dev, &lpss->dma_param, sizeof(*rx_param), GFP_KERNEL);
>  	if (!rx_param)
>  		return -ENOMEM;
>  
> -	tx_param = devm_kzalloc(dev, sizeof(*tx_param), GFP_KERNEL);
> +	tx_param = devm_kmemdup(dev, &lpss->dma_param, sizeof(*tx_param), GFP_KERNEL);
>  	if (!tx_param)
>  		return -ENOMEM;
>  
> -	*rx_param = lpss->dma_param;
> -	*tx_param = lpss->dma_param;
> -
>  	dma->fn = lpss8250_dma_filter;
>  	dma->rx_param = rx_param;
>  	dma->tx_param = tx_param;
> 

Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

-- 
 i.

--8323329-934630736-1704191636=:2225--


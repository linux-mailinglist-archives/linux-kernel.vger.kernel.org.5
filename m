Return-Path: <linux-kernel+bounces-34632-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12CD483856E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 03:41:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 463CC1C2A357
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 02:41:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A7365392;
	Tue, 23 Jan 2024 02:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="goO5vUZ4"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 757DF2570;
	Tue, 23 Jan 2024 02:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705976630; cv=none; b=dsLgyBQb3xTqJCdphOqIuul87XQN2B6Ppm3aCkjq30Vmz/i54qhSceo3nK71sKeswo3rVG3zy6vk0d1f8YiOvK68WVg6sG+uQu/DO/3W1sIrU06CRjhvXGpDJnqpWBiktaAZ0MkS4v+uZpJVOK6lWk0YjlWVDuaE9osCxIerKYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705976630; c=relaxed/simple;
	bh=JeB4i+pR0KhtpVTA4opmZxB6zloih/QMQdza1YMB5Sk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ozTBd5be3op9yIBavyCKChjjm9W3a0mNumQTjzibVK1Novf//NAfrwO8Gv+Sor/FmMl88oNmz03Vo+SHOPSzKE5kg5BB0DPhuJJ4C0epZfAtqA4sDj8ff3oj8UDvJApXDxPUrhNCuk+EfVynid02ZCIWanzlS7bYRPvEXWOeTrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=goO5vUZ4; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705976629; x=1737512629;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JeB4i+pR0KhtpVTA4opmZxB6zloih/QMQdza1YMB5Sk=;
  b=goO5vUZ4S/LftCGbsM8qOix7k+tT6udCc3oFolYGAAReVzNYglNnCyBW
   d3oGW5JL/mxR23w8pXQjwS0s7xCRwVJndeDtwht26VWZKpuTaob+iErNp
   EuLJF+z9a9m/SCoKWTBKHAotrwZ8sPkKX9A8k/sbKqJ5Ixr6Hhnxi0ytY
   2sUAlX4RIVL6fsAbOkTCli5ynHpymDK4WkEk0xVC8W2QVBtQUZE6Ypplw
   Tyt6S7qXhmtanCfTT7eP7qwo6m4NR05Zjq3DWy6muruOSk4l9Ac9C6NlS
   A3aSqbunnJ9SXfVL1A6WKeIPqGJrHZRfGldyh27qnMf7dJMUw/3ApPT+0
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10961"; a="1272591"
X-IronPort-AV: E=Sophos;i="6.05,213,1701158400"; 
   d="scan'208";a="1272591"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2024 18:23:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,213,1701158400"; 
   d="scan'208";a="1431375"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmviesa003.fm.intel.com with ESMTP; 22 Jan 2024 18:23:45 -0800
Date: Tue, 23 Jan 2024 10:20:29 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Matthew Gerlach <matthew.gerlach@linux.intel.com>
Cc: hao.wu@intel.com, trix@redhat.com, mdf@kernel.org, yilun.xu@intel.com,
	linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fpga: dfl: afu: update initialization of port_hdr driver
Message-ID: <Za8ibeJc82Xkbpct@yilunxu-OptiPlex-7050>
References: <20240122172433.537525-1-matthew.gerlach@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240122172433.537525-1-matthew.gerlach@linux.intel.com>

On Mon, Jan 22, 2024 at 09:24:33AM -0800, Matthew Gerlach wrote:
> Revision 2 of the Device Feature List (DFL) Port feature has
> slightly different requirements than revision 1. Revision 2
> does not need the port to reset at driver startup. In fact,

Please help illustrate what's the difference between Revision 1 & 2, and
why revision 2 needs not.

> performing a port reset during driver initialization can cause
> driver race conditions when the port is connected to a different

Please reorganize this part, in this description there seems be a
software racing bug and the patch is a workaround. But the fact is port
reset shouldn't been done for a new HW.

BTW: Is there a way to tell whether the port is connected to a different
PF? Any guarantee that revision 3, 4 ... would need a port reset or not?

Thanks,
Yilun

> PCIe Physical Function (PF) than the management PF performing
> the actual port reset.
> 
> Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> ---
>  drivers/fpga/dfl-afu-main.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/fpga/dfl-afu-main.c b/drivers/fpga/dfl-afu-main.c
> index c0a75ca360d6..7d7f80cd264f 100644
> --- a/drivers/fpga/dfl-afu-main.c
> +++ b/drivers/fpga/dfl-afu-main.c
> @@ -417,7 +417,18 @@ static const struct attribute_group port_hdr_group = {
>  static int port_hdr_init(struct platform_device *pdev,
>  			 struct dfl_feature *feature)
>  {
> -	port_reset(pdev);
> +	void __iomem *base;
> +	u8 rev;
> +
> +	base = dfl_get_feature_ioaddr_by_id(&pdev->dev, PORT_FEATURE_ID_HEADER);
> +
> +	rev = dfl_feature_revision(base);
> +
> +	if (rev < 2)
> +		port_reset(pdev);
> +
> +	if (rev > 2)
> +		dev_info(&pdev->dev, "unexpected port feature revision, %u\n", rev);

Remove the print. It is indicating an error but the function returns OK.

Thanks,
Yilun

>  
>  	return 0;
>  }
> -- 
> 2.34.1
> 
> 


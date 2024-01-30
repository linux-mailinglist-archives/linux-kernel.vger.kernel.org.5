Return-Path: <linux-kernel+bounces-44337-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5452F84206B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 11:02:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84DE81C244C7
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 10:02:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C719367E71;
	Tue, 30 Jan 2024 09:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ge9fH80I"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D9EE67A04;
	Tue, 30 Jan 2024 09:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706608746; cv=none; b=VkjdOwuEanzc/M1FeL9qj65fKE5ylNqdH4+irtAmCVywH45jhVHBJq9CMYA8p5R3gXL3USoB17jcv0ID73k5gIO3AQlIoraTefiofaxmUzbDisgqqzORDQWmNy9N1H3sMAg5LPirAZuBtcU3wcJSrX0BLegxChqmeyLNFdJrFWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706608746; c=relaxed/simple;
	bh=NLufhWI/HuTT3DCLkEBOo/5dp1Sv2l5FbL/NzMCPhxI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FXE7zBLikr4Lc/1+FX4goAHBMrvnju+yM5oJWQ4fDc289anacWFvISaXYMETjQo8OG9YbH1CSqxzYvoEb341xzpxPAXJZNeVdBk9epU1VgBie5K1AsHStkeSJrBbqM8+B3V0FrRAbUGCNP7xlWq/AVWCGCvh9Cu+kDhbr3T/Vfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ge9fH80I; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706608745; x=1738144745;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NLufhWI/HuTT3DCLkEBOo/5dp1Sv2l5FbL/NzMCPhxI=;
  b=Ge9fH80IP7rIRmkxnW0+PgeJdc1mG/0nlJkTHVvhUGDBL/iSnJ3nd87V
   Hpc/h+kifprX8UtM2+HA8P6u6IltPUC8tUeqiEmyAWv5O4+K2ZDloRWFj
   rA/vdlyF1wMeHT2nc++EG91c8lN2k3trq/IDnnwIOnYaSYLCYtlkx6LON
   gmDWG8YSKop+OnfjwwgsBG1zK4Hjed7qtiR5klpDg0AuhZ/DwzzGP/S2d
   sX6Q7U/injysfCWs+7D5nbFdAjB1Lk/7KOBOZ6f76HQdZc2R3Wd9uA6vq
   FcxH2Yt2Ya70DglWECmBxrRiGrHQL7bwn7XFtOSYETiShnkt6v9XYcrX0
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10968"; a="10334359"
X-IronPort-AV: E=Sophos;i="6.05,707,1701158400"; 
   d="scan'208";a="10334359"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2024 01:59:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10968"; a="737720407"
X-IronPort-AV: E=Sophos;i="6.05,707,1701158400"; 
   d="scan'208";a="737720407"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orsmga003.jf.intel.com with ESMTP; 30 Jan 2024 01:59:00 -0800
Date: Tue, 30 Jan 2024 17:55:35 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Matthew Gerlach <matthew.gerlach@linux.intel.com>
Cc: hao.wu@intel.com, trix@redhat.com, mdf@kernel.org, yilun.xu@intel.com,
	linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] fpga: dfl: afu: support Rev 2 of DFL Port feature
Message-ID: <ZbjHl8ptQG5FdHvC@yilunxu-OptiPlex-7050>
References: <20240125233715.861883-1-matthew.gerlach@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240125233715.861883-1-matthew.gerlach@linux.intel.com>

On Thu, Jan 25, 2024 at 03:37:15PM -0800, Matthew Gerlach wrote:
> Revision 2 of the Device Feature List (DFL) Port feature
> adds support for connecting the contents of the port to
> multiple PCIe Physical Functions (PF).
> 
> This new functionality requires changing the port reset
> behavior during FPGA and software initialization from
> revision 1 of the port feature. With revision 1, the initial
> state of the logic inside the port was not guaranteed to
> be valid until a port reset was performed by software during
> driver initialization. With revision 2, the initial state
> of the logic inside the port is guaranteed to be valid,
> and a port reset is not required during driver initialization.
> 
> This change in port reset behavior avoids a potential race
> condition during PCI enumeration when a port is connected to
> multiple PFs. Problems can occur if the driver attached to
> the PF managing the port asserts reset in its probe function
> when a driver attached to another PF accesses the port in its
> own probe function. The potential problems include failed or hung

Only racing during probe functions? I assume any time port_reset()
would fail TLPs for the other PF. And port_reset() could be triggered
at runtime by ioctl().

Thanks,
Yilun

> transaction layer packet (TLP) transactions and invalid data
> being returned.
> 
> Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> 
> ---
> v2:
> - Update commit message for clarity
> - Remove potentially confusing dev_info message.
> ---
>  drivers/fpga/dfl-afu-main.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/fpga/dfl-afu-main.c b/drivers/fpga/dfl-afu-main.c
> index c0a75ca360d6..42fe27660ab7 100644
> --- a/drivers/fpga/dfl-afu-main.c
> +++ b/drivers/fpga/dfl-afu-main.c
> @@ -417,7 +417,15 @@ static const struct attribute_group port_hdr_group = {
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
>  
>  	return 0;
>  }
> -- 
> 2.34.1
> 
> 


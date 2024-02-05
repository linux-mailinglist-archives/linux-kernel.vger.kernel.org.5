Return-Path: <linux-kernel+bounces-54019-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5A9384A94D
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 23:32:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61F9328D279
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 22:32:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A0071DA23;
	Mon,  5 Feb 2024 22:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BzfM1utn"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B8D11DA52;
	Mon,  5 Feb 2024 22:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707172332; cv=none; b=eh70pmrzdpSUO4jxeTQ9g1aC8Ywy1dkL3aYK25tdmN6BvEBPYkBQFMw6j5hX4z/3wya3+vNg559/9pcQCdv0woT7dFTwgjB9dFYe+QoEr4yJ9WZl8Wr/R8FZgGqpXGW/JrofAtLuhgmL00IzFvHmZaETvQWLmkGfNQzCYCcvMjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707172332; c=relaxed/simple;
	bh=1GRjONb0JN7LdL608UodAvZ1FzBKJdGuR1pJnSGAlR0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lJiKdK0FVgHPCoF9lB3BQpmOyMn+u8c7nB+o6htFi0FfSUcWOPomeo1y4QnhQ7PCHwQ4/9kkyEo9BheB8/ucs0RhwB8QqBWp9H57B2Xb3I+1cPSAMZVcQzlPMqZcVLb5f6a/FVdNbY4iCNKlUnfg0AiaaRk+MTucDSqStFMMn6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BzfM1utn; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707172331; x=1738708331;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=1GRjONb0JN7LdL608UodAvZ1FzBKJdGuR1pJnSGAlR0=;
  b=BzfM1utn9oRwqGEO2uBzh1S0TD3bJatQObkmDE+3SLYmZcgSFCBPWECE
   dB+F1C8YAupDaT5MoNRwWGngtsYUbiN7oAZegq4mlz8qxYJujClPLEBSF
   uVo/wKRI+RDT/nWMdM37z2pY6aZAl3lMTiYstrvPl6D7SQL21Eh3TY40o
   bR5kEdvh5b2G6jtfiXz8r/qeq7YB08sDtMdJikldWWM1izQNXSWYB5aZx
   svv7cbtvYQfNWxYg6xsoc1cgKhSrVr9gFrPeYdqqIj8Jp8LdR3URw9QK0
   picnGU4sruKnn2wwPfm4b7bNu+U2c8Phzj7eysdneRdOzPPCB3bsWSFLv
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10975"; a="768801"
X-IronPort-AV: E=Sophos;i="6.05,245,1701158400"; 
   d="scan'208";a="768801"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 14:32:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10975"; a="933275442"
X-IronPort-AV: E=Sophos;i="6.05,245,1701158400"; 
   d="scan'208";a="933275442"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.246.112.181]) ([10.246.112.181])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 14:32:09 -0800
Message-ID: <7bb19ffd-0262-42bc-8123-c91e8d5b14e5@intel.com>
Date: Mon, 5 Feb 2024 15:32:09 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] device-dax: make dax_bus_type const
Content-Language: en-US
To: "Ricardo B. Marliere" <ricardo@marliere.net>,
 Dan Williams <dan.j.williams@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>
Cc: nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org,
 linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20240204-bus_cleanup-dax-v1-1-69a6e4a8553b@marliere.net>
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20240204-bus_cleanup-dax-v1-1-69a6e4a8553b@marliere.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/4/24 9:07 AM, Ricardo B. Marliere wrote:
> Now that the driver core can properly handle constant struct bus_type,
> move the dax_bus_type variable to be a constant structure as well,
> placing it into read-only memory which can not be modified at runtime.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/dax/bus.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/dax/bus.c b/drivers/dax/bus.c
> index 1659b787b65f..fe0a415c854d 100644
> --- a/drivers/dax/bus.c
> +++ b/drivers/dax/bus.c
> @@ -222,7 +222,7 @@ static void dax_bus_remove(struct device *dev)
>  		dax_drv->remove(dev_dax);
>  }
>  
> -static struct bus_type dax_bus_type = {
> +static const struct bus_type dax_bus_type = {
>  	.name = "dax",
>  	.uevent = dax_bus_uevent,
>  	.match = dax_bus_match,
> 
> ---
> base-commit: 73bf93edeeea866b0b6efbc8d2595bdaaba7f1a5
> change-id: 20240204-bus_cleanup-dax-52c34f72615f
> 
> Best regards,


Return-Path: <linux-kernel+bounces-53093-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0336284A097
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 18:24:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1C962827D6
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 17:24:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 818D944C9B;
	Mon,  5 Feb 2024 17:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CaG5thgW"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B17F44C67
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 17:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707153807; cv=none; b=Lb2lNIg0nZf1sj50sgUVkRgqK9m3jxT80WXBQLcdt+K2ga9sKvY/UR35xy7suLFUPiD7/itrgLzer6I8uo0DnoepPPW2NrhU8bmkOVCwxtLZaPTYWpwAElYZZUIUA91eDxWOCXViZgVel9+iBZQltEwE0untm5z8vICOksgGN38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707153807; c=relaxed/simple;
	bh=pvhRBveZIxmIvXofDZgkcTjrT0DCrv+aueCyX37D5vo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OFl5vBwfCpHcuOcKHxT9gu4dOAi+Z25LPsiEXtaTG7ebsKhKMZFk8SIaKNw8P0TCweXxepX25eVjgA+m6C3q2JCIl3xYeE3DxDWjTHePINV1bQRbtb4+zUZggtLmBSTdDJvbajLyxuHTvwbZUqnC+MAlOVjY9xrXLDLquuqymOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CaG5thgW; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707153806; x=1738689806;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=pvhRBveZIxmIvXofDZgkcTjrT0DCrv+aueCyX37D5vo=;
  b=CaG5thgWdJlTTJ9G2mXx9RNwzvoOqyiXxWqwINbKboJ462qnyDxVV8o9
   TyupEDinJOaVBdPgiGm0bGs3dunhcm3RNqcYjXUvJVXuqqmrA+uT2xud8
   eu3MroH990Xfnkdj9gG/UkvO6Nmk16ovV/z6LJAh7FHEcWbhSke3tAaeJ
   n8JMnLPD9PcVRrCLvuE1r/ITL1vkWIe9iG/6M4W3ZR5VJF0uSxuQYfWHw
   ePNh3CN+vDDxKLYBFbq3HSvXV0m/IXeyxWZyEevQ6MI2G85MD04Z/YdB5
   S93/PIBFP0Brgtp+RIjkorzpywN6UD5rOlMWxjQP0NeOIATZAvWFzjcp9
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10975"; a="11304161"
X-IronPort-AV: E=Sophos;i="6.05,245,1701158400"; 
   d="scan'208";a="11304161"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 09:23:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,245,1701158400"; 
   d="scan'208";a="5390987"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.246.112.181]) ([10.246.112.181])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 09:23:25 -0800
Message-ID: <98ff5cce-a0bb-4ee6-839f-ce64589ffee6@intel.com>
Date: Mon, 5 Feb 2024 10:23:24 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] ntb: ntb_transport: make ntb_transport_bus const
Content-Language: en-US
To: "Ricardo B. Marliere" <ricardo@marliere.net>, Jon Mason
 <jdmason@kudzu.us>, Allen Hubbe <allenbh@gmail.com>
Cc: ntb@lists.linux.dev, linux-kernel@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20240204-bus_cleanup-ntb-v1-0-155184f60d5f@marliere.net>
 <20240204-bus_cleanup-ntb-v1-1-155184f60d5f@marliere.net>
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20240204-bus_cleanup-ntb-v1-1-155184f60d5f@marliere.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/4/24 9:22 AM, Ricardo B. Marliere wrote:
> Now that the driver core can properly handle constant struct bus_type,
> move the ntb_transport_bus variable to be a constant structure as well,
> placing it into read-only memory which can not be modified at runtime.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/ntb/ntb_transport.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
> index f9e7847a378e..0291d80611dc 100644
> --- a/drivers/ntb/ntb_transport.c
> +++ b/drivers/ntb/ntb_transport.c
> @@ -314,7 +314,7 @@ static void ntb_transport_bus_remove(struct device *dev)
>  	put_device(dev);
>  }
>  
> -static struct bus_type ntb_transport_bus = {
> +static const struct bus_type ntb_transport_bus = {
>  	.name = "ntb_transport",
>  	.match = ntb_transport_bus_match,
>  	.probe = ntb_transport_bus_probe,
> 


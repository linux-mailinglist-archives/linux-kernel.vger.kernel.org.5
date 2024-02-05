Return-Path: <linux-kernel+bounces-53094-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BBD0A84A099
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 18:24:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F0CB283642
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 17:24:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E6193D98E;
	Mon,  5 Feb 2024 17:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j1SLCU4b"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA51D3FE5B
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 17:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707153850; cv=none; b=VoHGGCxk6r7Wzqv7mTeaCPP9nUpIhDeWZqWZ2lA+fSx5eraG1uCPKf4LsOYUtfFNecu1TLyH6QORu2PC+QG7vD8hUVkrixeWlUO8shW9Axr3Xso3YPA9zW/j9MtqafWoM7OSXNwf49pPFs+5QB58sh0oJLc+hw/DXLrLxlwcWvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707153850; c=relaxed/simple;
	bh=sopnj/yEtbs+QAK7lhST6HyHux4gyYacZ32KJZMZj2c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SbAiEzmbyjZoqGbbEr0yzcJ7ShphkcW6sPjy2ojNyFZMA/yFt0MO1q+BYaOhCcLFdUtuUhCxbgerRanh1D4dsyYEpCUUfdfp8kvjqib0d+EQnQ8KjprdoCc2UDQ7E5w1LbPI/i16Vcy5K5R2ZMd7liJjsUeunMaruh4c2r26XlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j1SLCU4b; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707153846; x=1738689846;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=sopnj/yEtbs+QAK7lhST6HyHux4gyYacZ32KJZMZj2c=;
  b=j1SLCU4bKVq9lxX3xUaxe7VCTLDzqQAs+JrSyLzig9qiAiw1Vmy+sgVC
   bPSyGWjQAaAQl2qZI+fUpUeiLeJIUngG5gAxiBt+sbQN7lFsJTy8S7wcu
   xgYuI9d67UkqJFxd8XxARQ0JUneEXo1wT4s7fd4iUYE6C0mEWbkNWURnb
   9YRVzk9K84nV90cbZOi8QVU1EaLUvF/PWp0pUK/mDJ+iFLYXCgnanlcna
   xhdqNPZyezpbY6x1/jR7Z8Ua2idp7H1GwlBvSJbCXoWjRgt/Adxiv6I3r
   ZCX5+N+vP+mwQ2XfZUXa4lXWJ9PoGS4KO/98RGrlIhF3inYlSwquOAO4o
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10975"; a="11304228"
X-IronPort-AV: E=Sophos;i="6.05,245,1701158400"; 
   d="scan'208";a="11304228"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 09:24:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,245,1701158400"; 
   d="scan'208";a="5391174"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.246.112.181]) ([10.246.112.181])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 09:24:02 -0800
Message-ID: <62e2f525-4178-432e-9732-b886e0fcf65c@intel.com>
Date: Mon, 5 Feb 2024 10:24:02 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] ntb: core: make ntb_bus const
Content-Language: en-US
To: "Ricardo B. Marliere" <ricardo@marliere.net>, Jon Mason
 <jdmason@kudzu.us>, Allen Hubbe <allenbh@gmail.com>
Cc: ntb@lists.linux.dev, linux-kernel@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20240204-bus_cleanup-ntb-v1-0-155184f60d5f@marliere.net>
 <20240204-bus_cleanup-ntb-v1-2-155184f60d5f@marliere.net>
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20240204-bus_cleanup-ntb-v1-2-155184f60d5f@marliere.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/4/24 9:22 AM, Ricardo B. Marliere wrote:
> Now that the driver core can properly handle constant struct bus_type,
> move the ntb_bus variable to be a constant structure as well,
> placing it into read-only memory which can not be modified at runtime.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>  drivers/ntb/core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/ntb/core.c b/drivers/ntb/core.c
> index 27dd93deff6e..f32b77c7e00d 100644
> --- a/drivers/ntb/core.c
> +++ b/drivers/ntb/core.c
> @@ -72,7 +72,7 @@ MODULE_VERSION(DRIVER_VERSION);
>  MODULE_AUTHOR(DRIVER_AUTHOR);
>  MODULE_DESCRIPTION(DRIVER_DESCRIPTION);
>  
> -static struct bus_type ntb_bus;
> +static const struct bus_type ntb_bus;
>  static void ntb_dev_release(struct device *dev);
>  
>  int __ntb_register_client(struct ntb_client *client, struct module *mod,
> @@ -292,7 +292,7 @@ static void ntb_dev_release(struct device *dev)
>  	complete(&ntb->released);
>  }
>  
> -static struct bus_type ntb_bus = {
> +static const struct bus_type ntb_bus = {
>  	.name = "ntb",
>  	.probe = ntb_probe,
>  	.remove = ntb_remove,
> 


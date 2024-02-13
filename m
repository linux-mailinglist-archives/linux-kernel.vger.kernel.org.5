Return-Path: <linux-kernel+bounces-63822-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C38458534E0
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 16:38:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0245C1C22B8E
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 15:38:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 727245EE78;
	Tue, 13 Feb 2024 15:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Pi9nctyd"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E21AE58126;
	Tue, 13 Feb 2024 15:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.55.52.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707838725; cv=none; b=BeGTBBeDCcja6XD2HWByEM1ESHhHtHgQvasp8nwY9LA0THptCqGmPuzK8LwdOZgoYh/8/efRzMekSHUKq3yoxAyrkPrUYhaL1nn2vANIakj/1fjHyW1jLpZOgL9KEojawJQz4i4QzUI8CbhRrx6XtyqDeftsaewT63V9SR4WXdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707838725; c=relaxed/simple;
	bh=/FixN+a+D9YVgQbr68SUh51x3iwYkCOi2fOrW6oV/Qs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lUG/uyCfLivi2osimmW/57JdnLs4jvj+G1wNfbBTkKdaqWobsBAGfSgCa2hmOKHxjYt1KrtTSfTs2LeM20vGiRZTNzAm44ZA+FRuTJ0fxHaTcHszzCke1OSV1qeFJWXmcM91sRICHJhJh0ceSwTMMgiWw+k4JrrJtmHY9BkeXNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Pi9nctyd; arc=none smtp.client-ip=192.55.52.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707838723; x=1739374723;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=/FixN+a+D9YVgQbr68SUh51x3iwYkCOi2fOrW6oV/Qs=;
  b=Pi9nctydhHzC3Clwpg+k8T7sZdfcviDs3DWD/9ZyTJZOU2ZDQNq4CCZf
   FWTl2CXkkVxU3FRJOgomX7YOHZHXon5L7vPLwzvvLTpASCuySmepf1aHh
   w1j8+J9w2JG6nvuB+AHbSf8wNWBAoLUgdCMcHSdd0VkNzvRRNEDx0Rve0
   mmEj0S2p2dgJFjtvZuAzd8DVpjn6aieUy8JpxcqqEufsq8SQDxK/qwMrH
   tUIfVhw4DIRw7HAXJkhDd3Y0+4bY3fJsdCJiV9Z/O/6mzD2S/XTSoYhMg
   VW/kDkK2XtJp1mOdzBMlLGhjBSYO7CUNddKEbntQfDqZmCV6o2q08IJ7z
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="436996881"
X-IronPort-AV: E=Sophos;i="6.06,157,1705392000"; 
   d="scan'208";a="436996881"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2024 07:38:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="935369945"
X-IronPort-AV: E=Sophos;i="6.06,157,1705392000"; 
   d="scan'208";a="935369945"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.246.113.145]) ([10.246.113.145])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2024 07:38:40 -0800
Message-ID: <3896f0ec-59c1-4e2a-80f3-1081a8282a34@intel.com>
Date: Tue, 13 Feb 2024 08:38:39 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cxl/port: make cxl_bus_type const
Content-Language: en-US
To: "Ricardo B. Marliere" <ricardo@marliere.net>,
 Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20240213-bus_cleanup-cxl-v1-1-a601adabb391@marliere.net>
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20240213-bus_cleanup-cxl-v1-1-a601adabb391@marliere.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/13/24 7:46 AM, Ricardo B. Marliere wrote:
> Since commit d492cc2573a0 ("driver core: device.h: make struct
> bus_type a const *"), the driver core can properly handle constant
> struct bus_type, move the cxl_bus_type  variable to be a constant
> structure as well, placing it into read-only memory which can not be
> modified at runtime.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/cxl/core/port.c | 2 +-
>  drivers/cxl/cxl.h       | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index e59d9d37aa65..a73c1d1dd4c4 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -2197,7 +2197,7 @@ static const struct attribute_group *cxl_bus_attribute_groups[] = {
>  	NULL,
>  };
>  
> -struct bus_type cxl_bus_type = {
> +const struct bus_type cxl_bus_type = {
>  	.name = "cxl",
>  	.uevent = cxl_bus_uevent,
>  	.match = cxl_bus_match,
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index b6017c0c57b4..122015f7a558 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -803,7 +803,7 @@ int cxl_dvsec_rr_decode(struct device *dev, int dvsec,
>  
>  bool is_cxl_region(struct device *dev);
>  
> -extern struct bus_type cxl_bus_type;
> +extern const struct bus_type cxl_bus_type;
>  
>  struct cxl_driver {
>  	const char *name;
> 
> ---
> base-commit: 716f4aaa7b48a55c73d632d0657b35342b1fefd7
> change-id: 20240213-bus_cleanup-cxl-ce6b8a16eb0b
> 
> Best regards,


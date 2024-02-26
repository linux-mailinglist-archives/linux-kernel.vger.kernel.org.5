Return-Path: <linux-kernel+bounces-80962-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4639866E6D
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 10:29:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E655A1C24132
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 09:29:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A716A5FDD5;
	Mon, 26 Feb 2024 08:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HpB7g5hz"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BD575FBB8;
	Mon, 26 Feb 2024 08:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708937329; cv=none; b=IfZhaiqxKqwpRsH9EVXaKLvwwPKi/Me1IDkdgDXr2LTZb0OQCsDRR80IeKkjAzZ/xxYn15KJKl68a1V7ulE6o8sC6mdEPlDxNzY7OHmMTyPU3DDRGROuH4CP6ukRl6z7YT6pv4k+SS27Bcw/+lhbF/e+H4kzp8zfDAhkD3NA3CI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708937329; c=relaxed/simple;
	bh=PheRjvk280i0sCgbgnxoEOvf9uZatel4oU6XXDdLpHA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kU0PNy/v1unhMh1mL2TJ41E/5htl/O4ecDZf4Z1OQODuU/1167TL55C5K5XYeF+yMJBSYUpw9Hjes5dHbNT/GqUarkEwXNZMxIfjPZ9rbRkGZ8NQe7KwoLfqGvhWaXD7etUkNuICBjs1yr7MA//sxT6/H8zZYzoxZVqhQr+3Dkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HpB7g5hz; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708937327; x=1740473327;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PheRjvk280i0sCgbgnxoEOvf9uZatel4oU6XXDdLpHA=;
  b=HpB7g5hzmezWkTBBWst1uYKy3HffB73LM+rbT4AmPcGagvA13KLdu/Eu
   Pj4/c/eRLqOKh9AOBEJQVRAhWi+qIQStcdfvvKgv4SjBhMpREx/TVPjH/
   7k2ORYeCMvMrS9ONWSQnXy15XbeA5lZLUup8DMNlhY1VPWuhreV2zLeEV
   XI+5r7fOoPulZDEQupxBYzBsE3UnECqkIwuqMJEqGmyJeaYH4fUIPsU8n
   a38Ia04+qzno2/oRE1IfnECnXwiyAPNLuxvRS/jxQAqTxaFo3B2LxmJmw
   VcjBrpoglMQ4FQZV9ymXHEm7pMVxp0m/WAUzZlHfVGPMXWTQLHNhAkNom
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10995"; a="6996018"
X-IronPort-AV: E=Sophos;i="6.06,185,1705392000"; 
   d="scan'208";a="6996018"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2024 00:48:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10995"; a="937029556"
X-IronPort-AV: E=Sophos;i="6.06,185,1705392000"; 
   d="scan'208";a="937029556"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 26 Feb 2024 00:48:42 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 26 Feb 2024 10:48:41 +0200
Date: Mon, 26 Feb 2024 10:48:41 +0200
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Jameson Thies <jthies@google.com>
Cc: linux-usb@vger.kernel.org, pmalani@chromium.org, bleung@google.com,
	abhishekpandit@chromium.org, andersson@kernel.org,
	dmitry.baryshkov@linaro.org, fabrice.gasnier@foss.st.com,
	gregkh@linuxfoundation.org, hdegoede@redhat.com,
	neil.armstrong@linaro.org, rajaram.regupathy@intel.com,
	saranya.gopal@intel.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] usb: typec: ucsi: Clean up UCSI_CABLE_PROP macros
Message-ID: <ZdxQaTmhF9q7A4p3@kuha.fi.intel.com>
References: <20240223010328.2826774-1-jthies@google.com>
 <20240223010328.2826774-2-jthies@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240223010328.2826774-2-jthies@google.com>

On Fri, Feb 23, 2024 at 01:03:25AM +0000, Jameson Thies wrote:
> Clean up UCSI_CABLE_PROP macros by fixing a bitmask shifting error for
> plug type and updating the modal support macro for consistent naming.
> 
> Fixes: 3cf657f07918 ("usb: typec: ucsi: Remove all bit-fields")
> Signed-off-by: Jameson Thies <jthies@google.com>

This is missing CC stable.

> ---
> Tested by building v6.6 kernel.
> 
>  drivers/usb/typec/ucsi/ucsi.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/typec/ucsi/ucsi.h b/drivers/usb/typec/ucsi/ucsi.h
> index 7e35ffbe0a6f..469a2baf472e 100644
> --- a/drivers/usb/typec/ucsi/ucsi.h
> +++ b/drivers/usb/typec/ucsi/ucsi.h
> @@ -259,12 +259,12 @@ struct ucsi_cable_property {
>  #define UCSI_CABLE_PROP_FLAG_VBUS_IN_CABLE	BIT(0)
>  #define UCSI_CABLE_PROP_FLAG_ACTIVE_CABLE	BIT(1)
>  #define UCSI_CABLE_PROP_FLAG_DIRECTIONALITY	BIT(2)
> -#define UCSI_CABLE_PROP_FLAG_PLUG_TYPE(_f_)	((_f_) & GENMASK(3, 0))
> +#define UCSI_CABLE_PROP_FLAG_PLUG_TYPE(_f_)	(((_f_) & GENMASK(4, 3)) >> 3)
>  #define   UCSI_CABLE_PROPERTY_PLUG_TYPE_A	0
>  #define   UCSI_CABLE_PROPERTY_PLUG_TYPE_B	1
>  #define   UCSI_CABLE_PROPERTY_PLUG_TYPE_C	2
>  #define   UCSI_CABLE_PROPERTY_PLUG_OTHER	3
> -#define UCSI_CABLE_PROP_MODE_SUPPORT		BIT(5)
> +#define UCSI_CABLE_PROP_FLAG_MODE_SUPPORT	BIT(5)
>  	u8 latency;
>  } __packed;
>  
> -- 
> 2.44.0.rc0.258.g7320e95886-goog

-- 
heikki


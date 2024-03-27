Return-Path: <linux-kernel+bounces-120733-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D94F88DC49
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 12:15:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 496FA2A49B3
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 11:15:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 720E55674F;
	Wed, 27 Mar 2024 11:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iz0XLuMf"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04F555646F;
	Wed, 27 Mar 2024 11:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711538095; cv=none; b=BSWv/gkNzhSH7jT+DtT9AdzXfJ3IgBJMAvKhNSU/72oySyJXcpp9NYmkXWMLBnoLU/mGysqwPlfbgc9FxLCRQ1WB3z2Bc7DZjjqTAkucuCnyg8vzp+9J8Pt3lqefFYeQtsyLICIyRcLlCa3BrUWQNj2Ww7W4q/gc3XYa3cevZuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711538095; c=relaxed/simple;
	bh=q4gszzZYJLNZEfEoFqtWr9/nMZ0ApDNP/vg6qiy0tds=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=leEtMQ8ws3zSMgYxEhKTqfnSu3oIRUE4S2lX+qOc21OcvPJDCm8yhpKg5+LgLtFTioBuugUOW34l8FLphcCYJ4yi+9ApD2JYVpgLhI9FoFYDNSCdDqogSjXEvI7N9pK9ku7qOzCGsqFCXctETVOu0WiSluysD6SvxlMfm+6tgqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iz0XLuMf; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711538094; x=1743074094;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=q4gszzZYJLNZEfEoFqtWr9/nMZ0ApDNP/vg6qiy0tds=;
  b=iz0XLuMfBjPe8yw9bzUxu0zR3+NXQJzKvWKjmsA0ZPzrapWt1CG9lRYx
   jy/khMDhmGMQMEd/ucAJ/Ws8UZZRYwxm+h0opbUeFuB39Dx6wqN13orU9
   1rEyzMARZ50LwRGkcL7EN+fFFnmekzC00GdmUDqRVxFLgeR/O6zSD8J8J
   mrEAHem8+izeG4+2fdL7p/7lepWtp1/Uxj1DZAZa1oxuFYeCaitHU46tz
   DJXVBCuEZW/mI8BzWoNA7esn0N0YLaOh66SJDKOOnhzghOry6AgI79qgg
   J/DsT3mmmNJS5w5OHTudy2inQzW3qtSqUN0vNDdtqp2IjWaLbLosFdU+R
   A==;
X-CSE-ConnectionGUID: wSuO6eRsQWquyiYALEYe+w==
X-CSE-MsgGUID: RmqamZp6RumAfXUdxSAPtg==
X-IronPort-AV: E=McAfee;i="6600,9927,11025"; a="17361283"
X-IronPort-AV: E=Sophos;i="6.07,158,1708416000"; 
   d="scan'208";a="17361283"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2024 04:14:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11025"; a="937074462"
X-IronPort-AV: E=Sophos;i="6.07,158,1708416000"; 
   d="scan'208";a="937074462"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 27 Mar 2024 04:14:48 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Wed, 27 Mar 2024 13:14:48 +0200
Date: Wed, 27 Mar 2024 13:14:47 +0200
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Jameson Thies <jthies@google.com>
Cc: linux-usb@vger.kernel.org, pmalani@chromium.org, bleung@google.com,
	abhishekpandit@chromium.org, andersson@kernel.org,
	dmitry.baryshkov@linaro.org, fabrice.gasnier@foss.st.com,
	gregkh@linuxfoundation.org, hdegoede@redhat.com,
	neil.armstrong@linaro.org, rajaram.regupathy@intel.com,
	saranya.gopal@intel.com, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, Benson Leung <bleung@chromium.org>
Subject: Re: [PATCH v4 1/4] usb: typec: ucsi: Clean up UCSI_CABLE_PROP macros
Message-ID: <ZgP/p2Lx4QKl5zjH@kuha.fi.intel.com>
References: <20240305025804.1290919-1-jthies@google.com>
 <20240305025804.1290919-2-jthies@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240305025804.1290919-2-jthies@google.com>

On Tue, Mar 05, 2024 at 02:58:01AM +0000, Jameson Thies wrote:
> Clean up UCSI_CABLE_PROP macros by fixing a bitmask shifting error for
> plug type and updating the modal support macro for consistent naming.
> 
> Fixes: 3cf657f07918 ("usb: typec: ucsi: Remove all bit-fields")
> Cc: stable@vger.kernel.org
> Reviewed-by: Benson Leung <bleung@chromium.org>
> Reviewed-by: Prashant Malani <pmalani@chromium.org>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Signed-off-by: Jameson Thies <jthies@google.com>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
> Changes in v4:
> - None.
> 
> Changes in v3:
> - Fixed CC stable.
> 
> Changes in v2:
> - Tested on usb-testing branch merged with chromeOS 6.8-rc2 kernel.
> 
>  drivers/usb/typec/ucsi/ucsi.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/typec/ucsi/ucsi.h b/drivers/usb/typec/ucsi/ucsi.h
> index 7e35ffbe0a6f2..469a2baf472e4 100644
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
> 2.44.0.rc1.240.g4c46232300-goog

-- 
heikki


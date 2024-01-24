Return-Path: <linux-kernel+bounces-37092-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DCC9C83AB70
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 15:14:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EDD6292443
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 14:14:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 878DC7A73F;
	Wed, 24 Jan 2024 14:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PTpM7b4B"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED1E17A728;
	Wed, 24 Jan 2024 14:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706105657; cv=none; b=D7i+b/1JL5rC5ZlXm13aQJvESsT/UEYlzEPOPn867TuTDYcUbkEk3nl6/54b76VrPdNbnuj3JvOIBtR3G4mah/raVmgxjatJwiVoh/bKsN0JrqR4CqwHpzfz2Xzwo+dO4doVOD6Kkz/3MoAkOVl4UUMxJsLtA0NkPCYIzYtT59I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706105657; c=relaxed/simple;
	bh=1WwHCAFVV2NPEEod/8TMiSCLMQEPAuQYnS/MCqWE71s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ez6ZyBb5ghfFQP+7Ab/I6W9JpSa9ikDqmzEFjeYGmlse6KRlcZbtsWzq8s9HXLvCGip45RcgqJaAccbOFRf9kIgfFnHbq8/BV/0ZNuibbX/VGhB+kz7OWY8kzEd+TCBrMcZ5pHCftPediMmBncs6uOBYQbzTLa+qo3krPtGNBsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PTpM7b4B; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706105657; x=1737641657;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1WwHCAFVV2NPEEod/8TMiSCLMQEPAuQYnS/MCqWE71s=;
  b=PTpM7b4B/TO+B9dlLqazbFGHDluU3mhbG04PvroppKlatU2MAcxHlyRT
   JpqbImgTbSyV9G8bA+smylfknE2yEoZfPdPmH2E0e7hD8+3A2FflJtC9Y
   /fpR6PHmdZpbiXbfieRIB0qpQHZnlZ4wVC4E8GN5iR7QlURAcJynNTYxl
   72x0JxU4+BXrcR6/1IAPWXVt+Xa3uSWga70lcEK6th0nDsZferbesfxjZ
   xH0ap6vPUYXgpLUc3IUSS0vfTfRJzEaVGYGRwisr0CEwUrD/2AgjsVcxL
   izssAaX7SQmRWw6/6IQwAQ/5D5XIA+VmTR8luGpOEWBv6D0Qyx9kOIBlJ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="15200454"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="15200454"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2024 06:14:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="929694783"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="929694783"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 24 Jan 2024 06:14:10 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Wed, 24 Jan 2024 16:14:10 +0200
Date: Wed, 24 Jan 2024 16:14:10 +0200
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Abhishek Pandit-Subedi <abhishekpandit@google.com>
Cc: linux-usb@vger.kernel.org, pmalani@chromium.org, jthies@google.com,
	Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Saranya Gopal <saranya.gopal@intel.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/3] usb: typec: ucsi: Update connector cap and status
Message-ID: <ZbEbMvzSr4JR3s/9@kuha.fi.intel.com>
References: <20240123223039.1471557-1-abhishekpandit@google.com>
 <20240123143026.v1.2.I3d909e3c9a200621e3034686f068a3307945fd87@changeid>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240123143026.v1.2.I3d909e3c9a200621e3034686f068a3307945fd87@changeid>

On Tue, Jan 23, 2024 at 02:30:35PM -0800, Abhishek Pandit-Subedi wrote:
> From: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
> 
> Update the data structures for ucsi_connector_capability and
> ucsi_connector_status to UCSIv3.
> 
> Signed-off-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
> ---
> Connector status has several unaligned bitfields (16-bit) that result in
> difficult to maintain macros. It may be better if we simply re-define
> these structs as u8[] and add bit range macros to access and cast these
> values.
> 
> i.e.
> struct ucsi_connector_status {
>   u8 raw_data[18];
> 
> ...
> \#define UCSI_CONSTAT_CONNECTOR_STATUS          FIELD(u16, 15, 0)
> \#define UCSI_CONSTAT_BCD_PD_VER_OPER_MODE      FIELD(u16, 85, 70)
> }
> 
> GET_UCSI_FIELD(con->status, UCSI_CONSTAT_CONNECTOR_STATUS);
> SET_UCSI_FIELD(con->status, UCSI_CONSTAT_CONNECTOR_STATUS, 0);
> 
> I didn't find a clear example of an existing mechanism to do this. Would
> love some pointers here if it already exists and some feedback from the
> maintainer if this is a direction you want to go.

I'll ask around if anybody has any ideas on our side, but I think we
can go forward with this in any case. We can always fine tune these
later.

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

>  drivers/usb/typec/ucsi/ucsi.h | 50 ++++++++++++++++++++++++++++++++---
>  1 file changed, 46 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/usb/typec/ucsi/ucsi.h b/drivers/usb/typec/ucsi/ucsi.h
> index bec920fa6b8a..94b373378f63 100644
> --- a/drivers/usb/typec/ucsi/ucsi.h
> +++ b/drivers/usb/typec/ucsi/ucsi.h
> @@ -3,6 +3,7 @@
>  #ifndef __DRIVER_USB_TYPEC_UCSI_H
>  #define __DRIVER_USB_TYPEC_UCSI_H
>  
> +#include <asm-generic/unaligned.h>
>  #include <linux/bitops.h>
>  #include <linux/device.h>
>  #include <linux/power_supply.h>
> @@ -214,9 +215,29 @@ struct ucsi_connector_capability {
>  #define UCSI_CONCAP_OPMODE_USB2			BIT(5)
>  #define UCSI_CONCAP_OPMODE_USB3			BIT(6)
>  #define UCSI_CONCAP_OPMODE_ALT_MODE		BIT(7)
> -	u8 flags;
> +	u32 flags;
>  #define UCSI_CONCAP_FLAG_PROVIDER		BIT(0)
>  #define UCSI_CONCAP_FLAG_CONSUMER		BIT(1)
> +#define UCSI_CONCAP_FLAG_SWAP_TO_DFP		BIT(2)
> +#define UCSI_CONCAP_FLAG_SWAP_TO_UFP		BIT(3)
> +#define UCSI_CONCAP_FLAG_SWAP_TO_SRC		BIT(4)
> +#define UCSI_CONCAP_FLAG_SWAP_TO_SINK		BIT(5)
> +#define UCSI_CONCAP_FLAG_EX_OP_MODE(_f_) \
> +	(((_f_) & GENMASK(13, 6)) >> 6)
> +#define   UCSI_CONCAP_EX_OP_MODE_USB4_GEN2	BIT(0)
> +#define   UCSI_CONCAP_EX_OP_MODE_EPR_SRC	BIT(1)
> +#define   UCSI_CONCAP_EX_OP_MODE_EPR_SINK	BIT(2)
> +#define   UCSI_CONCAP_EX_OP_MODE_USB4_GEN3	BIT(3)
> +#define   UCSI_CONCAP_EX_OP_MODE_USB4_GEN4	BIT(4)
> +#define UCSI_CONCAP_FLAG_MISC_CAPS(_f_) \
> +	(((_f_) & GENMASK(17, 14)) >> 14)
> +#define   UCSI_CONCAP_MISC_CAP_FW_UPDATE	BIT(0)
> +#define   UCSI_CONCAP_MISC_CAP_SECURITY		BIT(1)
> +#define UCSI_CONCAP_FLAG_REV_CURR_PROT_SUPPORT	BIT(18)
> +#define UCSI_CONCAP_FLAG_PARTNER_PD_MAJOR_REV(_f_) \
> +	(((_f_) & GENMASK(20, 19)) >> 19)
> +#define UCSI_CONCAP_FLAG_PARTNER_PD_MAJOR_REV_AS_BCD(_f_) \
> +	(UCSI_CONCAP_FLAG_PARTNER_PD_MAJOR_REV(_f_) << 8)
>  } __packed;
>  
>  struct ucsi_altmode {
> @@ -276,15 +297,36 @@ struct ucsi_connector_status {
>  #define   UCSI_CONSTAT_PARTNER_TYPE_DEBUG	5
>  #define   UCSI_CONSTAT_PARTNER_TYPE_AUDIO	6
>  	u32 request_data_obj;
> -	u8 pwr_status;
> -#define UCSI_CONSTAT_BC_STATUS(_p_)		((_p_) & GENMASK(2, 0))
> +
> +	u8 pwr_status[3];
> +#define UCSI_CONSTAT_BC_STATUS(_p_)		((_p_[0]) & GENMASK(1, 0))
>  #define   UCSI_CONSTAT_BC_NOT_CHARGING		0
>  #define   UCSI_CONSTAT_BC_NOMINAL_CHARGING	1
>  #define   UCSI_CONSTAT_BC_SLOW_CHARGING		2
>  #define   UCSI_CONSTAT_BC_TRICKLE_CHARGING	3
> -#define UCSI_CONSTAT_PROVIDER_CAP_LIMIT(_p_)	(((_p_) & GENMASK(6, 3)) >> 3)
> +#define UCSI_CONSTAT_PROVIDER_CAP_LIMIT(_p_)	(((_p_[0]) & GENMASK(5, 2)) >> 2)
>  #define   UCSI_CONSTAT_CAP_PWR_LOWERED		0
>  #define   UCSI_CONSTAT_CAP_PWR_BUDGET_LIMIT	1
> +#define UCSI_CONSTAT_PROVIDER_PD_VERSION_OPER_MODE(_p_)	\
> +	((get_unaligned_le32(_p_) & GENMASK(21, 6)) >> 6)
> +#define UCSI_CONSTAT_ORIENTATION(_p_)		(((_p_[2]) & GENMASK(6, 6)) >> 6)
> +#define   UCSI_CONSTAT_ORIENTATION_DIRECT	0
> +#define   UCSI_CONSTAT_ORIENTATION_FLIPPED	1
> +#define UCSI_CONSTAT_SINK_PATH_STATUS(_p_)	(((_p_[2]) & GENMASK(7, 7)) >> 7)
> +#define   UCSI_CONSTAT_SINK_PATH_DISABLED	0
> +#define   UCSI_CONSTAT_SINK_PATH_ENABLED	1
> +	u8 pwr_readings[9];
> +#define UCSI_CONSTAT_REV_CURR_PROT_STATUS(_p_)	((_p_[0]) & 0x1)
> +#define UCSI_CONSTAT_PWR_READING_VALID(_p_)	(((_p_[0]) & GENMASK(1, 1)) >> 1)
> +#define UCSI_CONSTAT_CURRENT_SCALE(_p_)		(((_p_[0]) & GENMASK(4, 2)) >> 2)
> +#define UCSI_CONSTAT_PEAK_CURRENT(_p_) \
> +	((get_unaligned_le32(_p_) & GENMASK(20, 5)) >> 5)
> +#define UCSI_CONSTAT_AVG_CURRENT(_p_) \
> +	((get_unaligned_le32(&(_p_)[2]) & GENMASK(20, 5)) >> 5)
> +#define UCSI_CONSTAT_VOLTAGE_SCALE(_p_) \
> +	((get_unaligned_le16(&(_p_)[4]) & GENMASK(8, 5)) >> 5)
> +#define UCSI_CONSTAT_VOLTAGE_READING(_p_) \
> +	((get_unaligned_le32(&(_p_)[5]) & GENMASK(16, 1)) >> 1)
>  } __packed;
>  
>  /* -------------------------------------------------------------------------- */
> -- 
> 2.43.0.429.g432eaa2c6b-goog

-- 
heikki


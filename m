Return-Path: <linux-kernel+bounces-44737-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 133228426C0
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 15:18:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95B801F21B9A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 14:17:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7C0C6DD06;
	Tue, 30 Jan 2024 14:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eutrJ9VT"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CBCD6BB3C;
	Tue, 30 Jan 2024 14:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706624268; cv=none; b=PkbtuAw6nK6AJAzn4ThVRG507dvQtKbsrdL17EVqgxGs8D3+TtPoau1QuDGLUnqk04ntUoUI/OEaRKQVqONIGkQaTI8PGwRo03XqN9dYU8uB031GQFZh6IgqF+hvKSuezupT5o0fcUppM7XYGmy/KZyKdb4QllwLqqg5GshV7dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706624268; c=relaxed/simple;
	bh=BKv3glAjOg6Q4H2MBrW6sZkbCud0cq8QJMaJ/dDBBjs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DvmflRMQoc96Nyb+hykgMzfb0I8JXl0rZV5b0h6krEO86NKy5jYf+TfLd+yV+3SLJQU1/ISuBjrYz3tuSVfq4tD1zuwDIuzd2TH/vFNL9z0vGZWQaxKpiqOBXawK+sv/b8XOUwK9f1IVwade5syVKyOfeKUyC0t/jeIYM+RC/cA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eutrJ9VT; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706624267; x=1738160267;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=BKv3glAjOg6Q4H2MBrW6sZkbCud0cq8QJMaJ/dDBBjs=;
  b=eutrJ9VT1+FEJt4h7BxczyOBescFT7VivMQRVoOY6XrwqCGTGPL1kS3C
   ta4H6QxwLTe2/Hxkz5mc357Pqf4iAb0le35IRMn8CgJMxZD9De88zK8Qm
   Th2d5rJ6dSfs0mes9G756HRucwX8hKYjfZAbJRLrekNiIjZJd7wu74AMk
   QZBTnDxnH1VReTOlncwis+pI74aP8Bb0jlDLzvBT0EybaBI0divDfHeJC
   eEL5tk5jDv4eopb/h/v2pseDCMWQaovD5+bMzAOSIxFK7Ha2POf7hA1lx
   WfEc/475w5rl3/augdooMpWLDSLWZVeHMSQgzQFGlVickEzcsScEV0diA
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10968"; a="21809560"
X-IronPort-AV: E=Sophos;i="6.05,707,1701158400"; 
   d="scan'208";a="21809560"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2024 06:17:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10968"; a="931463981"
X-IronPort-AV: E=Sophos;i="6.05,707,1701158400"; 
   d="scan'208";a="931463981"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 30 Jan 2024 06:17:41 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 30 Jan 2024 16:17:40 +0200
Date: Tue, 30 Jan 2024 16:17:40 +0200
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Cc: linux-usb@vger.kernel.org, pmalani@chromium.org, jthies@google.com,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rajaram Regupathy <rajaram.regupathy@intel.com>,
	Saranya Gopal <saranya.gopal@intel.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/3] usb: typec: ucsi: Update connector cap and status
Message-ID: <ZbkFBHs1pZ+BXGIb@kuha.fi.intel.com>
References: <20240126183930.1170845-1-abhishekpandit@chromium.org>
 <20240126103859.v3.2.I3d909e3c9a200621e3034686f068a3307945fd87@changeid>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240126103859.v3.2.I3d909e3c9a200621e3034686f068a3307945fd87@changeid>

On Fri, Jan 26, 2024 at 10:39:08AM -0800, Abhishek Pandit-Subedi wrote:
> Update the data structures for ucsi_connector_capability and
> ucsi_connector_status to UCSIv3.
> 
> Signed-off-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

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
> 
> 
> Changes in v3:
>   - Change include to asm/unaligned.h and reorder include.
> 
>  drivers/usb/typec/ucsi/ucsi.h | 50 ++++++++++++++++++++++++++++++++---
>  1 file changed, 46 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/usb/typec/ucsi/ucsi.h b/drivers/usb/typec/ucsi/ucsi.h
> index bec920fa6b8a..1bae4cf8ecdc 100644
> --- a/drivers/usb/typec/ucsi/ucsi.h
> +++ b/drivers/usb/typec/ucsi/ucsi.h
> @@ -10,6 +10,7 @@
>  #include <linux/usb/typec.h>
>  #include <linux/usb/pd.h>
>  #include <linux/usb/role.h>
> +#include <asm/unaligned.h>
>  
>  /* -------------------------------------------------------------------------- */
>  
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


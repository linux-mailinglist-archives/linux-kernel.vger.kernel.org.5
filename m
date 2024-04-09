Return-Path: <linux-kernel+bounces-136331-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 105BE89D2C4
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 08:58:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 879091F2361C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 06:58:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BCC077F32;
	Tue,  9 Apr 2024 06:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MDyIUb7f"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DDD542046;
	Tue,  9 Apr 2024 06:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712645916; cv=none; b=ed9QeQHfuNDqEaZ46fIgic9Ku2bXiDvOkErUK+bAnGjasGh7XzVo/LpcATJp1opFEfcxW5vyMMGwuZ5dLLgZmgRK6HRWluGjqgPjf1MjLbrUKmC2EqqbvEu/r44JfUqt0+8mrY0+sBIrSoNtqEobotqkCIZwCmN/RpKBbWnW+nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712645916; c=relaxed/simple;
	bh=RNDQ/WAShIYxQ56ytQsVbdot0whnV2CuqsOaiBNW8ws=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sgVnRRzdAIORv0a1YjwHu2h5R2/Pn8PnZ6/lmuAs4r6ZHPkcZVEYGhKht+fr1wW70S/42eC+eBIfoO8sfmxKAKO+imsXfkmEzwVFVONIZYJqTWhTSadXSPERzUBr6yaELf1n9eZz6EJe9kJDwb4VeIqUaUmbohgp37AmexJ49zI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MDyIUb7f; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712645915; x=1744181915;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RNDQ/WAShIYxQ56ytQsVbdot0whnV2CuqsOaiBNW8ws=;
  b=MDyIUb7foURLaC/W5B/KUhZkIKmm6JZzqY+a+cfTx4nda32Qkd8QZyZx
   XP4t4SmTZcRH2p1P776ODn1LOWQUx1z6yQMyH4flzmI5DGkXvcVuZA4fr
   QiDAI3NRiajRGZ3BurQOEqzXCn59FLVZAGPMjYAesBHaw9VpgoPJWgQXc
   +RdZAXDWXk39MiKOMjmxNOg5P9ccsiW1v+ztoUPRIQaIaoxTF/7RPvU5+
   K1mrvKm9RY5D4djM7PxI1pqWOoh5MS1Tu+Nk1wEUbskh9ZB/z19czod+n
   CVA0NMgtnmO4NCFufIO2XCm+f/nSLNFPz9sapqtb+V1Hg5TciYf5Efma1
   g==;
X-CSE-ConnectionGUID: Yz0MeUhDTVqWFykSLjh5vA==
X-CSE-MsgGUID: IDYoI1rdSHCHaN/E2mChrQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11038"; a="8071295"
X-IronPort-AV: E=Sophos;i="6.07,188,1708416000"; 
   d="scan'208";a="8071295"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2024 23:58:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11038"; a="937093086"
X-IronPort-AV: E=Sophos;i="6.07,188,1708416000"; 
   d="scan'208";a="937093086"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 08 Apr 2024 23:58:31 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 09 Apr 2024 09:58:30 +0300
Date: Tue, 9 Apr 2024 09:58:30 +0300
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	linux-usb@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] usb: typec: ucsi: add callback for connector status
 updates
Message-ID: <ZhTnFq4yuUHK83eM@kuha.fi.intel.com>
References: <20240408-ucsi-orient-aware-v1-0-95a74a163a10@linaro.org>
 <20240408-ucsi-orient-aware-v1-1-95a74a163a10@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240408-ucsi-orient-aware-v1-1-95a74a163a10@linaro.org>

On Mon, Apr 08, 2024 at 07:30:49AM +0300, Dmitry Baryshkov wrote:
> Allow UCSI glue driver to perform addtional work to update connector
> status. For example, it might check the cable orientation.  This call is
> performed after reading new connector statatus, so the platform driver
> can peek at new connection status bits.
> 
> The callback is called both when registering the port and when the
> connector change event is being handled.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>  drivers/usb/typec/ucsi/ucsi.c | 6 ++++++
>  drivers/usb/typec/ucsi/ucsi.h | 3 +++
>  2 files changed, 9 insertions(+)
> 
> diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
> index 3106e69050cd..7ad544c968e4 100644
> --- a/drivers/usb/typec/ucsi/ucsi.c
> +++ b/drivers/usb/typec/ucsi/ucsi.c
> @@ -1199,6 +1199,9 @@ static void ucsi_handle_connector_change(struct work_struct *work)
>  
>  	trace_ucsi_connector_change(con->num, &con->status);
>  
> +	if (ucsi->ops->connector_status)
> +		ucsi->ops->connector_status(con);
> +
>  	role = !!(con->status.flags & UCSI_CONSTAT_PWR_DIR);
>  
>  	if (con->status.change & UCSI_CONSTAT_POWER_DIR_CHANGE) {
> @@ -1588,6 +1591,9 @@ static int ucsi_register_port(struct ucsi *ucsi, struct ucsi_connector *con)
>  	}
>  	ret = 0; /* ucsi_send_command() returns length on success */
>  
> +	if (ucsi->ops->connector_status)
> +		ucsi->ops->connector_status(con);
> +
>  	switch (UCSI_CONSTAT_PARTNER_TYPE(con->status.flags)) {
>  	case UCSI_CONSTAT_PARTNER_TYPE_UFP:
>  	case UCSI_CONSTAT_PARTNER_TYPE_CABLE_AND_UFP:
> diff --git a/drivers/usb/typec/ucsi/ucsi.h b/drivers/usb/typec/ucsi/ucsi.h
> index 2caf2969668c..6599fbd09bee 100644
> --- a/drivers/usb/typec/ucsi/ucsi.h
> +++ b/drivers/usb/typec/ucsi/ucsi.h
> @@ -53,12 +53,14 @@ struct dentry;
>  #define UCSI_CCI_ERROR			BIT(30)
>  #define UCSI_CCI_COMMAND_COMPLETE	BIT(31)
>  
> +struct ucsi_connector;

Let's keep the forward declarations in one place. Please move that to
the beginning of the file where the other forward declarations are.

thanks,

>  /**
>   * struct ucsi_operations - UCSI I/O operations
>   * @read: Read operation
>   * @sync_write: Blocking write operation
>   * @async_write: Non-blocking write operation
>   * @update_altmodes: Squashes duplicate DP altmodes
> + * @connector_status: Updates connector status, called holding connector lock
>   *
>   * Read and write routines for UCSI interface. @sync_write must wait for the
>   * Command Completion Event from the PPM before returning, and @async_write must
> @@ -73,6 +75,7 @@ struct ucsi_operations {
>  			   const void *val, size_t val_len);
>  	bool (*update_altmodes)(struct ucsi *ucsi, struct ucsi_altmode *orig,
>  				struct ucsi_altmode *updated);
> +	void (*connector_status)(struct ucsi_connector *con);
>  };
>  
>  struct ucsi *ucsi_create(struct device *dev, const struct ucsi_operations *ops);

-- 
heikki


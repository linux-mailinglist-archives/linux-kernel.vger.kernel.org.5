Return-Path: <linux-kernel+bounces-48591-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EE1E845E8A
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 18:31:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 806D61C237F9
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 17:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA81E5C023;
	Thu,  1 Feb 2024 17:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DjJxIHWQ"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA2B963C90;
	Thu,  1 Feb 2024 17:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706808695; cv=none; b=p6UB9XsJrRnbbI5QKtu1wBWV0EaNJj5tS5DerFKpt+PYoyqUdO2cykHFkTqrZRq9qHIuGLjOEkXbU+YtImDPPdtCnFYkTyrtUIwMZRRApGpS6L8rTBDhJ1NasOiR6MKYvDFlsJc1Mim7s0rPnbCUTs/99qRQeZSkAEuHv5OJjT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706808695; c=relaxed/simple;
	bh=heWzdfpbzi3J60PDEobakECsbGBJAkX3ElnHxfAmHKg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H1iRiXe3dMz5njTyc5GVlqskZDq5hm5qSL5dIs2RPUq7ghoDKGd5BR3Zn0sfMCMfhnXDYAT5gdV9wQar+mzqOlMLRQ1igIC/k4Jt5kuZwH3sTL4JwUaGYsZVYNMemKKf297vqb295YYlc86lt7Uq5dCPCFqwCIEkK5eWqoBvEzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DjJxIHWQ; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706808693; x=1738344693;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=heWzdfpbzi3J60PDEobakECsbGBJAkX3ElnHxfAmHKg=;
  b=DjJxIHWQbufi2CFLyzKRK/arkUmiJz2A/0uh2R1EjPaWsuI7IjhBG8n/
   27a8bmvWc+RYz56hPCTlhbMpDEIoASvAtObKipQrb7++nf803MU+frcc2
   y2915zASIkXDhJaVyvBZv5fbCVCYZbxxnWEmtlccSpwGK9/cW4ANNkgFS
   NzC7qBa8Ah4DocR4zr8mLz35QcgqOSEhnRLttuV96d0CKCLcAjXvF07mU
   915RTHH0pS+zxny9aTCDL7aiR2VBd6Hv/atWSp6TRhjNwb7B7jpB68s2d
   +vfwtSow2iMfy6k1sC/0DRjslobm9whIYMkyRqUAbVeTHoLRXmkRXn5Ej
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="11054732"
X-IronPort-AV: E=Sophos;i="6.05,234,1701158400"; 
   d="scan'208";a="11054732"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2024 09:31:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,234,1701158400"; 
   d="scan'208";a="37359"
Received: from cacasing-mobl1.amr.corp.intel.com (HELO [10.209.102.228]) ([10.209.102.228])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2024 09:31:31 -0800
Message-ID: <6ee06c50-3782-4d50-9a01-f332d181d3fc@linux.intel.com>
Date: Thu, 1 Feb 2024 09:31:30 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/8] platform/x86/intel/sdsi: Combine read and write
 mailbox flows
Content-Language: en-US
To: "David E. Box" <david.e.box@linux.intel.com>, netdev@vger.kernel.org,
 ilpo.jarvinen@linux.intel.com
Cc: linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
References: <20240201010747.471141-1-david.e.box@linux.intel.com>
 <20240201010747.471141-3-david.e.box@linux.intel.com>
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20240201010747.471141-3-david.e.box@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 1/31/24 5:07 PM, David E. Box wrote:
> The current mailbox commands are either read-only or write-only and the
> flow is different for each. New commands will need to send and receive
> data. In preparation for these commands, create a common polling function
> to handle sending data and receiving in the same transaction.
>
> Signed-off-by: David E. Box <david.e.box@linux.intel.com>
> ---
>  drivers/platform/x86/intel/sdsi.c | 79 +++++++++++++++++--------------
>  1 file changed, 44 insertions(+), 35 deletions(-)
>
> diff --git a/drivers/platform/x86/intel/sdsi.c b/drivers/platform/x86/intel/sdsi.c
> index a70c071de6e2..05a35f2f85b6 100644
> --- a/drivers/platform/x86/intel/sdsi.c
> +++ b/drivers/platform/x86/intel/sdsi.c
> @@ -15,6 +15,7 @@
>  #include <linux/iopoll.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
> +#include <linux/overflow.h>
>  #include <linux/pci.h>
>  #include <linux/slab.h>
>  #include <linux/sysfs.h>
> @@ -156,8 +157,8 @@ static int sdsi_status_to_errno(u32 status)
>  	}
>  }
>  
> -static int sdsi_mbox_cmd_read(struct sdsi_priv *priv, struct sdsi_mbox_info *info,
> -			      size_t *data_size)
> +static int sdsi_mbox_poll(struct sdsi_priv *priv, struct sdsi_mbox_info *info,
> +			  size_t *data_size)
>  {
>  	struct device *dev = priv->dev;
>  	u32 total, loop, eom, status, message_size;
> @@ -166,18 +167,10 @@ static int sdsi_mbox_cmd_read(struct sdsi_priv *priv, struct sdsi_mbox_info *inf
>  
>  	lockdep_assert_held(&priv->mb_lock);
>  
> -	/* Format and send the read command */
> -	control = FIELD_PREP(CTRL_EOM, 1) |
> -		  FIELD_PREP(CTRL_SOM, 1) |
> -		  FIELD_PREP(CTRL_RUN_BUSY, 1) |
> -		  FIELD_PREP(CTRL_PACKET_SIZE, info->size);
> -	writeq(control, priv->control_addr);
> -
>  	/* For reads, data sizes that are larger than the mailbox size are read in packets. */
>  	total = 0;
>  	loop = 0;
>  	do {
> -		void *buf = info->buffer + (SDSI_SIZE_MAILBOX * loop);
>  		u32 packet_size;
>  
>  		/* Poll on ready bit */
> @@ -195,6 +188,11 @@ static int sdsi_mbox_cmd_read(struct sdsi_priv *priv, struct sdsi_mbox_info *inf
>  		if (ret)
>  			break;
>  
> +		if (!packet_size) {
> +			sdsi_complete_transaction(priv);
> +			break;
> +		}
> +

It seems to be a generic check. Is this related to converting to a read/write function or
a common fix you added together in this patch.

>  		/* Only the last packet can be less than the mailbox size. */
>  		if (!eom && packet_size != SDSI_SIZE_MAILBOX) {
>  			dev_err(dev, "Invalid packet size\n");
> @@ -208,9 +206,13 @@ static int sdsi_mbox_cmd_read(struct sdsi_priv *priv, struct sdsi_mbox_info *inf
>  			break;
>  		}
>  
> -		sdsi_memcpy64_fromio(buf, priv->mbox_addr, round_up(packet_size, SDSI_SIZE_CMD));
> +		if (packet_size && info->buffer) {
> +			void *buf = info->buffer + array_size(SDSI_SIZE_MAILBOX, loop);
>  
> -		total += packet_size;
> +			sdsi_memcpy64_fromio(buf, priv->mbox_addr,
> +					     round_up(packet_size, SDSI_SIZE_CMD));
> +			total += packet_size;
> +		}
>  
>  		sdsi_complete_transaction(priv);
>  	} while (!eom && ++loop < MBOX_MAX_PACKETS);
> @@ -230,16 +232,33 @@ static int sdsi_mbox_cmd_read(struct sdsi_priv *priv, struct sdsi_mbox_info *inf
>  		dev_warn(dev, "Read count %u differs from expected count %u\n",
>  			 total, message_size);
>  
> -	*data_size = total;
> +	if (data_size)
> +		*data_size = total;
>  
>  	return 0;
>  }
>  
> -static int sdsi_mbox_cmd_write(struct sdsi_priv *priv, struct sdsi_mbox_info *info)
> +static int sdsi_mbox_cmd_read(struct sdsi_priv *priv, struct sdsi_mbox_info *info,
> +			      size_t *data_size)
> +{
> +	u64 control;
> +
> +	lockdep_assert_held(&priv->mb_lock);
> +
> +	/* Format and send the read command */
> +	control = FIELD_PREP(CTRL_EOM, 1) |
> +		  FIELD_PREP(CTRL_SOM, 1) |
> +		  FIELD_PREP(CTRL_RUN_BUSY, 1) |
> +		  FIELD_PREP(CTRL_PACKET_SIZE, info->size);
> +	writeq(control, priv->control_addr);
> +
> +	return sdsi_mbox_poll(priv, info, data_size);
> +}
> +
> +static int sdsi_mbox_cmd_write(struct sdsi_priv *priv, struct sdsi_mbox_info *info,
> +			       size_t *data_size)
>  {
>  	u64 control;
> -	u32 status;
> -	int ret;
>  
>  	lockdep_assert_held(&priv->mb_lock);
>  
> @@ -256,20 +275,7 @@ static int sdsi_mbox_cmd_write(struct sdsi_priv *priv, struct sdsi_mbox_info *in
>  		  FIELD_PREP(CTRL_PACKET_SIZE, info->size);
>  	writeq(control, priv->control_addr);
>  
> -	/* Poll on ready bit */
> -	ret = readq_poll_timeout(priv->control_addr, control, control & CTRL_READY,
> -				 MBOX_POLLING_PERIOD_US, MBOX_TIMEOUT_US);
> -
> -	if (ret)
> -		goto release_mbox;
> -
> -	status = FIELD_GET(CTRL_STATUS, control);
> -	ret = sdsi_status_to_errno(status);
> -
> -release_mbox:
> -	sdsi_complete_transaction(priv);
> -
> -	return ret;
> +	return sdsi_mbox_poll(priv, info, data_size);
>  }
>  
>  static int sdsi_mbox_acquire(struct sdsi_priv *priv, struct sdsi_mbox_info *info)
> @@ -313,7 +319,8 @@ static int sdsi_mbox_acquire(struct sdsi_priv *priv, struct sdsi_mbox_info *info
>  	return ret;
>  }
>  
> -static int sdsi_mbox_write(struct sdsi_priv *priv, struct sdsi_mbox_info *info)
> +static int sdsi_mbox_write(struct sdsi_priv *priv, struct sdsi_mbox_info *info,
> +			   size_t *data_size)
>  {
>  	int ret;
>  
> @@ -323,7 +330,7 @@ static int sdsi_mbox_write(struct sdsi_priv *priv, struct sdsi_mbox_info *info)
>  	if (ret)
>  		return ret;
>  
> -	return sdsi_mbox_cmd_write(priv, info);
> +	return sdsi_mbox_cmd_write(priv, info, data_size);
>  }
>  
>  static int sdsi_mbox_read(struct sdsi_priv *priv, struct sdsi_mbox_info *info, size_t *data_size)
> @@ -342,7 +349,7 @@ static int sdsi_mbox_read(struct sdsi_priv *priv, struct sdsi_mbox_info *info, s
>  static ssize_t sdsi_provision(struct sdsi_priv *priv, char *buf, size_t count,
>  			      enum sdsi_command command)
>  {
> -	struct sdsi_mbox_info info;
> +	struct sdsi_mbox_info info = {};

This change also looks like an independent fix. Is this related to common function usage
you mentioned in the commit log.

>  	int ret;
>  
>  	if (count > (SDSI_SIZE_WRITE_MSG - SDSI_SIZE_CMD))
> @@ -364,7 +371,9 @@ static ssize_t sdsi_provision(struct sdsi_priv *priv, char *buf, size_t count,
>  	ret = mutex_lock_interruptible(&priv->mb_lock);
>  	if (ret)
>  		goto free_payload;
> -	ret = sdsi_mbox_write(priv, &info);
> +
> +	ret = sdsi_mbox_write(priv, &info, NULL);
> +
>  	mutex_unlock(&priv->mb_lock);
>  
>  free_payload:
> @@ -408,7 +417,7 @@ static ssize_t
>  certificate_read(u64 command, struct sdsi_priv *priv, char *buf, loff_t off,
>  		 size_t count)
>  {
> -	struct sdsi_mbox_info info;
> +	struct sdsi_mbox_info info = {};
>  	size_t size;
>  	int ret;
>  

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer



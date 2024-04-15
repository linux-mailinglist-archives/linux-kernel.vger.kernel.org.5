Return-Path: <linux-kernel+bounces-144629-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 171AB8A4890
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 08:59:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1B09283DD0
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 06:59:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94CF522339;
	Mon, 15 Apr 2024 06:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NAgybvLs"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E829208D0;
	Mon, 15 Apr 2024 06:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713164324; cv=none; b=u/Z2TjprkZ0HQzgIKzggDBmR1PxWLnFih1+pdeinNxn/13SHhcrwO8p998pBwOeOot+DqnLG+RGz+5JlZ0m+et47pHUBKAJ3uuDZ0cZiYQPubPUk6cO5/lwA0XgL295PoPhaRGmW/XEStMgePOickmlDc0PFJEhD+t+guGlyZ34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713164324; c=relaxed/simple;
	bh=zfww0Wo2P7sSM8KWNzZdQqLcfyZOloB9r7adpSfjsko=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oKZiOoPUMA7g2TmZDd9YNv3Ly6fxUR44crPSgzeJP7mk4fSmOn8RtgRAqeHe1re324iiaEU9l2ScU858gvhWi7D4XcalN6vYOFlKAPMZwFCZOdO+cUHgjjfGx9L2B77lYiOelm4iKujlBDPhigRn9YtS8LYBjywE1zhNdqyZvFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NAgybvLs; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713164324; x=1744700324;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zfww0Wo2P7sSM8KWNzZdQqLcfyZOloB9r7adpSfjsko=;
  b=NAgybvLsiBH+P5YS6FcnFsnN2UTqNJgGhc4cvYcptP5vAgoQQ4m/LWfu
   8ecutUvHTvaPzX5iYAsenYmEvdTOGJctfuVPlpPMlOLf4lepP9XyeqD9g
   7TCsqPWVpoCg+q0x6DKf2HCgiYernpFk83VaOlfRXi6JFEO6OmK/utlDm
   m/hPF0NH1K31eI/uw7CWsjpXngm9vr9DLypy/kitLhqcQBMQIbFRLSjXT
   eFaEg3TYYFbGmxBML1Q9ysMRYk1xPuIAx03WIYenU9z1V0uH1EqopE/Fu
   19MXan4csmdjRAqjEGeg8zuMtYFvxSnQN4si8WNAbFKFCaP6wm3yQpMTN
   w==;
X-CSE-ConnectionGUID: U6Q9E9ZuT2K7Z1QKeB/WCQ==
X-CSE-MsgGUID: 7arF35L4Q2u5xPUgIK3/Qw==
X-IronPort-AV: E=McAfee;i="6600,9927,11044"; a="8393078"
X-IronPort-AV: E=Sophos;i="6.07,202,1708416000"; 
   d="scan'208";a="8393078"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2024 23:58:43 -0700
X-CSE-ConnectionGUID: LFv7NqOrS8+x5/7bu+fpaw==
X-CSE-MsgGUID: zoJdnraxStG3XzXTvNfKNA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,202,1708416000"; 
   d="scan'208";a="26494139"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by orviesa003.jf.intel.com with SMTP; 14 Apr 2024 23:58:39 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 15 Apr 2024 09:58:38 +0300
Date: Mon, 15 Apr 2024 09:58:38 +0300
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	linux-usb@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Krishna Kurapati <quic_kriskura@quicinc.com>
Subject: Re: [PATCH v2 2/5] usb: typec: ucsi: glink: move GPIO reading into
 connector_status callback
Message-ID: <ZhzQHoJLJzska3fd@kuha.fi.intel.com>
References: <20240411-ucsi-orient-aware-v2-0-d4b1cb22a33f@linaro.org>
 <20240411-ucsi-orient-aware-v2-2-d4b1cb22a33f@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240411-ucsi-orient-aware-v2-2-d4b1cb22a33f@linaro.org>

On Thu, Apr 11, 2024 at 07:49:54AM +0300, Dmitry Baryshkov wrote:
> To simplify the platform code move Type-C orientation handling into the
> connector_status callback. As it is called both during connector
> registration and on connector change events, duplicated code from
> pmic_glink_ucsi_register() can be dropped.
> 
> Also this moves operations that can sleep into a worker thread,
> removing the only sleeping operation from pmic_glink_ucsi_notify().
> 
> Tested-by: Krishna Kurapati <quic_kriskura@quicinc.com>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

Reviewed-by: Heikki Krogerus <heikki.krogeurs@linux.intel.com>

> ---
>  drivers/usb/typec/ucsi/ucsi_glink.c | 48 ++++++++++++++++---------------------
>  1 file changed, 20 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/usb/typec/ucsi/ucsi_glink.c b/drivers/usb/typec/ucsi/ucsi_glink.c
> index b91d2d15d7d9..d21f8cd2fe35 100644
> --- a/drivers/usb/typec/ucsi/ucsi_glink.c
> +++ b/drivers/usb/typec/ucsi/ucsi_glink.c
> @@ -187,10 +187,28 @@ static int pmic_glink_ucsi_sync_write(struct ucsi *__ucsi, unsigned int offset,
>  	return ret;
>  }
>  
> +static void pmic_glink_ucsi_connector_status(struct ucsi_connector *con)
> +{
> +	struct pmic_glink_ucsi *ucsi = ucsi_get_drvdata(con->ucsi);
> +	int orientation;
> +
> +	if (con->num >= PMIC_GLINK_MAX_PORTS ||
> +	    !ucsi->port_orientation[con->num - 1])
> +		return;
> +
> +	orientation = gpiod_get_value(ucsi->port_orientation[con->num - 1]);
> +	if (orientation >= 0) {
> +		typec_switch_set(ucsi->port_switch[con->num - 1],
> +				 orientation ? TYPEC_ORIENTATION_REVERSE
> +				 : TYPEC_ORIENTATION_NORMAL);
> +	}
> +}
> +
>  static const struct ucsi_operations pmic_glink_ucsi_ops = {
>  	.read = pmic_glink_ucsi_read,
>  	.sync_write = pmic_glink_ucsi_sync_write,
> -	.async_write = pmic_glink_ucsi_async_write
> +	.async_write = pmic_glink_ucsi_async_write,
> +	.connector_status = pmic_glink_ucsi_connector_status,
>  };
>  
>  static void pmic_glink_ucsi_read_ack(struct pmic_glink_ucsi *ucsi, const void *data, int len)
> @@ -229,20 +247,8 @@ static void pmic_glink_ucsi_notify(struct work_struct *work)
>  	}
>  
>  	con_num = UCSI_CCI_CONNECTOR(cci);
> -	if (con_num) {
> -		if (con_num <= PMIC_GLINK_MAX_PORTS &&
> -		    ucsi->port_orientation[con_num - 1]) {
> -			int orientation = gpiod_get_value(ucsi->port_orientation[con_num - 1]);
> -
> -			if (orientation >= 0) {
> -				typec_switch_set(ucsi->port_switch[con_num - 1],
> -						 orientation ? TYPEC_ORIENTATION_REVERSE
> -							     : TYPEC_ORIENTATION_NORMAL);
> -			}
> -		}
> -
> +	if (con_num)
>  		ucsi_connector_change(ucsi->ucsi, con_num);
> -	}
>  
>  	if (ucsi->sync_pending &&
>  		   (cci & (UCSI_CCI_ACK_COMPLETE | UCSI_CCI_COMMAND_COMPLETE))) {
> @@ -253,20 +259,6 @@ static void pmic_glink_ucsi_notify(struct work_struct *work)
>  static void pmic_glink_ucsi_register(struct work_struct *work)
>  {
>  	struct pmic_glink_ucsi *ucsi = container_of(work, struct pmic_glink_ucsi, register_work);
> -	int orientation;
> -	int i;
> -
> -	for (i = 0; i < PMIC_GLINK_MAX_PORTS; i++) {
> -		if (!ucsi->port_orientation[i])
> -			continue;
> -		orientation = gpiod_get_value(ucsi->port_orientation[i]);
> -
> -		if (orientation >= 0) {
> -			typec_switch_set(ucsi->port_switch[i],
> -					 orientation ? TYPEC_ORIENTATION_REVERSE
> -					     : TYPEC_ORIENTATION_NORMAL);
> -		}
> -	}
>  
>  	ucsi_register(ucsi->ucsi);
>  }
> 
> -- 
> 2.39.2

-- 
heikki


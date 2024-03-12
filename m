Return-Path: <linux-kernel+bounces-99989-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB79A87905E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 10:06:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85E3E284F3A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 09:06:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 313DF77F3C;
	Tue, 12 Mar 2024 09:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AfLpJMkF"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7191077A03;
	Tue, 12 Mar 2024 09:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710234389; cv=none; b=envz9VZ5SC9a4PBIgL0GdQe0R2e5PzRFDVIhnCvg4/5zshoHLVRPnAlwEob4riL4u8F/A7TraPfawepK+rWiY9uiK3eb2wKng5ZrnDgSxc/s8OLKpkm8mvu0WQKvCFtZTyunxx/8Ic+sVWymFhqWpHv++6GKGzabYXUonbumUaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710234389; c=relaxed/simple;
	bh=CdCjIk0bgMmKT5rhRO2SSXtQNGEFBKH06lI9dt9QC9o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jkEDiM8hbDg1m+M8+QUtoBnS15roCjF/vOoECXNns0Rb1WUYig3NzpZEsKvvyE7UEjJrlOTXmcRgeCqXBK5cNkows04FAhwHEYOv8QIKH3tA3RDyjQSSijrTBfmwvuGV/wUz6GZzIy/AYuHhwk7RcT85FqVJaCHYGCLvWrIMaYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AfLpJMkF; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710234388; x=1741770388;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=CdCjIk0bgMmKT5rhRO2SSXtQNGEFBKH06lI9dt9QC9o=;
  b=AfLpJMkFDvf4zkGWTNwEomoUZIbr6mQEeUSnDkp9vXPwK783PSCTQqfx
   JDfU41mzi6qDAWfcqr33A15djELq07FsvxYSJgRe2Qq00fMFm6fQXTeBJ
   DkbwWeazRknt3CB7D7ISShOyp8g/i3zO0SEeY9PyrNysW1suRXAyVJb1M
   QWAwrlLGHwonCKqJZn2Z75ByKTEW6+tk7Ntg0Ut32Ng8LpY07R/TiqCbM
   pTxj+8cpP9I56KgOnn5n83Ox3Sl2s/go9meD3PrHzG9FmlD283NeZaB8C
   Pw1UkMwqU2qyHVgH19nIrTnkHAWCHjVWlmLVZmxM8UyA26OeX7MfKKwyS
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11010"; a="4783119"
X-IronPort-AV: E=Sophos;i="6.07,118,1708416000"; 
   d="scan'208";a="4783119"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2024 02:06:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11010"; a="937051516"
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; 
   d="scan'208";a="937051516"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 12 Mar 2024 02:06:24 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 12 Mar 2024 11:06:23 +0200
Date: Tue, 12 Mar 2024 11:06:23 +0200
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: RD Babiera <rdbabiera@google.com>
Cc: gregkh@linuxfoundation.org, badhri@google.com,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v3] usb: typec: altmodes/displayport: create sysfs nodes
 as driver's default device attribute group
Message-ID: <ZfAbDxq1yGfUdHo/@kuha.fi.intel.com>
References: <20240229001101.3889432-2-rdbabiera@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240229001101.3889432-2-rdbabiera@google.com>

On Thu, Feb 29, 2024 at 12:11:02AM +0000, RD Babiera wrote:
> The DisplayPort driver's sysfs nodes may be present to the userspace before
> typec_altmode_set_drvdata() completes in dp_altmode_probe. This means that
> a sysfs read can trigger a NULL pointer error by deferencing dp->hpd in
> hpd_show or dp->lock in pin_assignment_show, as dev_get_drvdata() returns
> NULL in those cases.
> 
> Remove manual sysfs node creation in favor of adding attribute group as
> default for devices bound to the driver. The ATTRIBUTE_GROUPS() macro is
> not used here otherwise the path to the sysfs nodes is no longer compliant
> with the ABI.
> 
> Fixes: 0e3bb7d6894d ("usb: typec: Add driver for DisplayPort alternate mode")
> Cc: stable@vger.kernel.org
> Signed-off-by: RD Babiera <rdbabiera@google.com>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
> Changes from v1:
> * Moved sysfs node creation instead of NULL checking dev_get_drvdata().
> Changes from v2:
> * Removed manual sysfs node creation, now added as default device group in
> driver.
> ---
>  drivers/usb/typec/altmodes/displayport.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/us<F16>b/typec/altmodes/displayport.c b/drivers/usb/typec/altmodes/displayport.c
> index 5a80776c7255..94e1b43a862d 100644
> --- a/drivers/usb/typec/altmodes/displayport.c
> +++ b/drivers/usb/typec/altmodes/displayport.c
> @@ -702,16 +702,21 @@ static ssize_t hpd_show(struct device *dev, struct device_attribute *attr, char
>  }
>  static DEVICE_ATTR_RO(hpd);
>  
> -static struct attribute *dp_altmode_attrs[] = {
> +static struct attribute *displayport_attrs[] = {
>  	&dev_attr_configuration.attr,
>  	&dev_attr_pin_assignment.attr,
>  	&dev_attr_hpd.attr,
>  	NULL
>  };
>  
> -static const struct attribute_group dp_altmode_group = {
> +static const struct attribute_group displayport_group = {
>  	.name = "displayport",
> -	.attrs = dp_altmode_attrs,
> +	.attrs = displayport_attrs,
> +};
> +
> +static const struct attribute_group *displayport_groups[] = {
> +	&displayport_group,
> +	NULL,
>  };
>  
>  int dp_altmode_probe(struct typec_altmode *alt)
> @@ -720,7 +725,6 @@ int dp_altmode_probe(struct typec_altmode *alt)
>  	struct typec_altmode *plug = typec_altmode_get_plug(alt, TYPEC_PLUG_SOP_P);
>  	struct fwnode_handle *fwnode;
>  	struct dp_altmode *dp;
> -	int ret;
>  
>  	/* FIXME: Port can only be DFP_U. */
>  
> @@ -731,10 +735,6 @@ int dp_altmode_probe(struct typec_altmode *alt)
>  	      DP_CAP_PIN_ASSIGN_DFP_D(alt->vdo)))
>  		return -ENODEV;
>  
> -	ret = sysfs_create_group(&alt->dev.kobj, &dp_altmode_group);
> -	if (ret)
> -		return ret;
> -
>  	dp = devm_kzalloc(&alt->dev, sizeof(*dp), GFP_KERNEL);
>  	if (!dp)
>  		return -ENOMEM;
> @@ -777,7 +777,6 @@ void dp_altmode_remove(struct typec_altmode *alt)
>  {
>  	struct dp_altmode *dp = typec_altmode_get_drvdata(alt);
>  
> -	sysfs_remove_group(&alt->dev.kobj, &dp_altmode_group);
>  	cancel_work_sync(&dp->work);
>  	typec_altmode_put_plug(dp->plug_prime);
>  
> @@ -803,6 +802,7 @@ static struct typec_altmode_driver dp_altmode_driver = {
>  	.driver = {
>  		.name = "typec_displayport",
>  		.owner = THIS_MODULE,
> +		.dev_groups = displayport_groups,
>  	},
>  };
>  module_typec_altmode_driver(dp_altmode_driver);
> 
> base-commit: a560a5672826fc1e057068bda93b3d4c98d037a2
> -- 
> 2.44.0.rc1.240.g4c46232300-goog

-- 
heikki


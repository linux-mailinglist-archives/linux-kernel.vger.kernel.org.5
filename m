Return-Path: <linux-kernel+bounces-80720-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA68A866BAD
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 09:03:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB8421C218CA
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 08:03:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C23A1C6A4;
	Mon, 26 Feb 2024 08:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f8OJ5cOB"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C43571CA81;
	Mon, 26 Feb 2024 08:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708934618; cv=none; b=Zcy41NQkkf4fwydcLEdXnnEprQuOEQ9RTZxtNxaRsqcLtqbFRVSr1Cd1fymAUZ8iVc7iB811Y1UPodkp/745LrtCfavdYFmVJfC0bgJUr0RH9tD0Sv2dZmJx6cmRKZFM6wwr0xLMTdbtPMRnIKTJ7h9I9s63BkVy8bKP0udomGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708934618; c=relaxed/simple;
	bh=lKCJAGB8b/UhlOF810+HmhG2QMowiBaclTzfZnZ3Rek=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eBgNbB0lQRQz9baGhKFcvjPvNNQm8AL03SZZxlk4Vemn5wjczymwn7TNJdiy14HqTXfa5dxu5rda1vlqNHijnvHKvf1Brqg67IRaEK1miqE7EKGBN3bldi0PEhOjHNWuAFboEtchITTdYqaoL3JCMozLggIU1L0YS3oJ9tY9LHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f8OJ5cOB; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708934617; x=1740470617;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=lKCJAGB8b/UhlOF810+HmhG2QMowiBaclTzfZnZ3Rek=;
  b=f8OJ5cOB4oXDe7fEC6jABrWbgoBekqZpkUm+XsHOfzKirAfl+roFRCFe
   Sj4MKbtT1mB24tAIELdPFnHURVfIhw//RCKh7Mg0B1bH19EDPFNuNI4qt
   anAg0/Pvh2h8oTOVNRNgvQn/WzFLI07nkjP2KFtLsEO7ld0mon/Ii3j/E
   GZSODn+2CUrNVV9qiFwlF5t6MiT6iMok0hx0J3O+OLDzELn/O254YEKkI
   M70gpSJ4Wy6v4bs5jlGVZFmbGTdPbQ6Xl8HMHVIToMiDp+NeSSQBZdm5l
   O9JFgnF3fFZzFGsf3tR/8xRO/paCz0XhsShh1J3Z/f43FLyLQHJjtH6Km
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10995"; a="14335908"
X-IronPort-AV: E=Sophos;i="6.06,185,1705392000"; 
   d="scan'208";a="14335908"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2024 00:03:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10995"; a="937029451"
X-IronPort-AV: E=Sophos;i="6.06,185,1705392000"; 
   d="scan'208";a="937029451"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 26 Feb 2024 00:03:31 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 26 Feb 2024 10:03:30 +0200
Date: Mon, 26 Feb 2024 10:03:30 +0200
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Marco Felsch <m.felsch@pengutronix.de>
Cc: gregkh@linuxfoundation.org, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	linux@roeck-us.net, jun.li@nxp.com, devicetree@vger.kernel.org,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel@pengutronix.de
Subject: Re: [PATCH v3 3/4] usb: typec: tcpm: add support to set tcpc
 connector orientatition
Message-ID: <ZdxF0rARWTjIIDnz@kuha.fi.intel.com>
References: <20240222210903.208901-1-m.felsch@pengutronix.de>
 <20240222210903.208901-4-m.felsch@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240222210903.208901-4-m.felsch@pengutronix.de>

On Thu, Feb 22, 2024 at 10:09:02PM +0100, Marco Felsch wrote:
> This adds the support to set the connector orientation value
> accordingly. This is part of the optional CONFIG_STANDARD_OUTPUT
> register 0x18, specified within the USB port controller spsicification
> rev. 2.0 [1].
> 
> [1] https://www.usb.org/sites/default/files/documents/usb-port_controller_specification_rev2.0_v1.0_0.pdf
> 
> Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
> v3:
> - no changes
> v2:
> - no changes
> 
>  drivers/usb/typec/tcpm/tcpm.c | 6 ++++++
>  include/linux/usb/tcpm.h      | 2 ++
>  2 files changed, 8 insertions(+)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
> index 5945e3a2b0f7..85ca26687324 100644
> --- a/drivers/usb/typec/tcpm/tcpm.c
> +++ b/drivers/usb/typec/tcpm/tcpm.c
> @@ -1099,6 +1099,12 @@ static int tcpm_set_roles(struct tcpm_port *port, bool attached,
>  	if (ret < 0)
>  		return ret;
>  
> +	if (port->tcpc->set_orientation) {
> +		ret = port->tcpc->set_orientation(port->tcpc, orientation);
> +		if (ret < 0)
> +			return ret;
> +	}
> +
>  	port->pwr_role = role;
>  	port->data_role = data;
>  	typec_set_data_role(port->typec_port, data);
> diff --git a/include/linux/usb/tcpm.h b/include/linux/usb/tcpm.h
> index 65fac5e1f317..93b681ff3ef9 100644
> --- a/include/linux/usb/tcpm.h
> +++ b/include/linux/usb/tcpm.h
> @@ -133,6 +133,8 @@ struct tcpc_dev {
>  		      enum typec_cc_status *cc2);
>  	int (*set_polarity)(struct tcpc_dev *dev,
>  			    enum typec_cc_polarity polarity);
> +	int (*set_orientation)(struct tcpc_dev *dev,
> +			       enum typec_orientation orientation);
>  	int (*set_vconn)(struct tcpc_dev *dev, bool on);
>  	int (*set_vbus)(struct tcpc_dev *dev, bool on, bool charge);
>  	int (*set_current_limit)(struct tcpc_dev *dev, u32 max_ma, u32 mv);
> -- 
> 2.39.2

-- 
heikki


Return-Path: <linux-kernel+bounces-25769-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B40D782D585
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 10:05:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51DFA1F21C16
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 09:05:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9722C14E;
	Mon, 15 Jan 2024 09:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JBYMn6Ok"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29C204428;
	Mon, 15 Jan 2024 09:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705309542; x=1736845542;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SL8v6t1ojU7KNNC4hLj7h3r8VvNn6mhy2xS3hOYvnnY=;
  b=JBYMn6OkZYurI7Hrq3IFQD2zSh1kPRalznzWz3I+Cs7ruFp0InosM+yK
   xkMkn2m50b8LkRk27v75gZTkUGp4hIuCAz1nYatoPDoN08CSiTyt9lyCi
   B3XtiYwT9DtnXjNUxRUz0J1fJVkd4WKffAPeZtIHYId6hohj1XOnAdALo
   XTFaLjC4jqobial8O/Cz0j24hg2HkKH6N2O0r1933QFW6ytu1/RTR+DEs
   Ak5PIvLRcXoE6fxTa89JKMIZSNiNU/gxIIdLErzev/HkcQY8962F0QB0X
   yDGetJbr4T+Pto8a9R+2QWmDzFB5EM/YvaGT4cPp1GrYHqR2et+rNlztY
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10953"; a="485730529"
X-IronPort-AV: E=Sophos;i="6.04,196,1695711600"; 
   d="scan'208";a="485730529"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2024 01:05:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10953"; a="927063221"
X-IronPort-AV: E=Sophos;i="6.04,196,1695711600"; 
   d="scan'208";a="927063221"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 15 Jan 2024 01:05:37 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 15 Jan 2024 11:05:36 +0200
Date: Mon, 15 Jan 2024 11:05:36 +0200
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: "Christian A. Ehrhardt" <lk@c--e.de>
Cc: linux-usb@vger.kernel.org, Dell.Client.Kernel@dell.com,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Hans de Goede <hdegoede@redhat.com>,
	Jack Pham <quic_jackp@quicinc.com>,
	Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
	Samuel =?utf-8?B?xIxhdm9q?= <samuel@cavoj.net>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] usb: ucsi: Apply UCSI_ACK_CONNECTOR_CHANGE_ACK_CMD
 to Dell systems
Message-ID: <ZaTp5rQLu4rh3Xhm@kuha.fi.intel.com>
References: <20240107001701.130535-1-lk@c--e.de>
 <20240107001701.130535-5-lk@c--e.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240107001701.130535-5-lk@c--e.de>

Hi Christian,

On Sun, Jan 07, 2024 at 01:17:01AM +0100, Christian A. Ehrhardt wrote:
> Apply the UCSI_ACK_CONNECTOR_CHANGE_ACK_CMD to all Dell systems.
> 
> There are various reports that ucsi does not work on Dell systems
> with "GET_CONNECTOR_STATUS failed". At least some of these are
> most likely due to the need for this quirk.
> 
> If the logic is wrong users can still use the new quirk override
> for the typec_ucsi module to disable the quirk.
> 
> Signed-off-by: Christian A. Ehrhardt <lk@c--e.de>
> ---
>  drivers/usb/typec/ucsi/ucsi_acpi.c | 36 +++++++++++++++++++++++++-----
>  1 file changed, 31 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/usb/typec/ucsi/ucsi_acpi.c b/drivers/usb/typec/ucsi/ucsi_acpi.c
> index 78a0d13584ad..690d5e55bdc4 100644
> --- a/drivers/usb/typec/ucsi/ucsi_acpi.c
> +++ b/drivers/usb/typec/ucsi/ucsi_acpi.c
> @@ -27,6 +27,11 @@ struct ucsi_acpi {
>  	u64 cmd;
>  };
>  
> +struct ucsi_acpi_attach_data {
> +	const struct ucsi_operations *ops;
> +	unsigned int quirks;
> +};
> +
>  static int ucsi_acpi_dsm(struct ucsi_acpi *ua, int func)
>  {
>  	union acpi_object *obj;
> @@ -121,12 +126,30 @@ static const struct ucsi_operations ucsi_zenbook_ops = {
>  	.async_write = ucsi_acpi_async_write
>  };
>  
> -static const struct dmi_system_id zenbook_dmi_id[] = {
> +static const struct ucsi_acpi_attach_data ucsi_acpi_default_attach_data = {
> +	.ops = &ucsi_acpi_ops,
> +	.quirks = 0
> +};
> +
> +static const struct dmi_system_id ucsi_acpi_quirks[] = {
>  	{
>  		.matches = {
>  			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
>  			DMI_MATCH(DMI_PRODUCT_NAME, "ZenBook UX325UA_UM325UA"),
>  		},
> +		.driver_data = &(struct ucsi_acpi_attach_data) {
> +			.ops = &ucsi_zenbook_ops,
> +			.quirks = 0
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
> +		},
> +		.driver_data = &(struct ucsi_acpi_attach_data) {
> +			.ops = &ucsi_acpi_ops,
> +			.quirks = UCSI_ACK_CONNECTOR_CHANGE_ACK_CMD

Please don't add any more quirk flags like that for single user (you
may never have more than the one user for it). Let's just first handle
this with only Dell's like I proposed.

If there are other platforms that need the same quirk, then we can
start looking at how to share the quirk.

thanks,

-- 
heikki


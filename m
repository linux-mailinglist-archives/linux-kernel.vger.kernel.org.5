Return-Path: <linux-kernel+bounces-25697-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B23882D4B4
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 08:53:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F1991F2178D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 07:53:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C986E5253;
	Mon, 15 Jan 2024 07:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eC/acpCm"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E43B163AA;
	Mon, 15 Jan 2024 07:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705305200; x=1736841200;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zHlir3XfdsSMz2r6HDC4X+LUzUxt8NpAEvDxhpvgZBw=;
  b=eC/acpCmGITJb4Lchw3vp1G9Cmu83HU1HW5sOk7s2B2efmJ8sN62aVGm
   t+XPw+wY4vBXcI9Re67Rz4ZRBkSR3gbiSBPCqUwZ6+rZ38N3a7V5kdWQG
   y+OcSdw2EbZSQpirvHAe1JNZchwwtYOfdsx/0nwVR0m/sZUTTLH2kuA8T
   qTbpj0qWwYaOtjmn9qpnoMmJon90+aE79/ypfw7eOXbQDdXdDuVAnBPa5
   KPPSfpasjwTJ4Z4stQ6s3OfC1jR4AEQr/nhPJcvkZAXtOc+UAAUDS8f6p
   o+P1Rpeydx2qz74u4TNqmcPzRK6eszY59Vz3Klflom5jAaAFHZzxyUvYu
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10953"; a="6650794"
X-IronPort-AV: E=Sophos;i="6.04,196,1695711600"; 
   d="scan'208";a="6650794"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2024 23:53:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10953"; a="733229991"
X-IronPort-AV: E=Sophos;i="6.04,196,1695711600"; 
   d="scan'208";a="733229991"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by orsmga003.jf.intel.com with SMTP; 14 Jan 2024 23:53:14 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 15 Jan 2024 09:53:13 +0200
Date: Mon, 15 Jan 2024 09:53:13 +0200
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
Subject: Re: [PATCH 2/4] usb: ucsi: Add quirk infrastructure
Message-ID: <ZaTkaf/OmhvEr7ZI@kuha.fi.intel.com>
References: <20240107001701.130535-1-lk@c--e.de>
 <20240107001701.130535-3-lk@c--e.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240107001701.130535-3-lk@c--e.de>

On Sun, Jan 07, 2024 at 01:16:59AM +0100, Christian A. Ehrhardt wrote:
> Allow bus drivers to specify quirks for the UCSI core on
> attach. Allow the user to override the quirks on the command
> line.
> 
> Signed-off-by: Christian A. Ehrhardt <lk@c--e.de>
> ---
>  Documentation/admin-guide/kernel-parameters.txt |  5 +++++
>  drivers/usb/typec/ucsi/ucsi.c                   | 12 +++++++++++-
>  drivers/usb/typec/ucsi/ucsi.h                   |  6 +++++-
>  drivers/usb/typec/ucsi/ucsi_acpi.c              |  2 +-
>  drivers/usb/typec/ucsi/ucsi_ccg.c               |  2 +-
>  drivers/usb/typec/ucsi/ucsi_glink.c             |  2 +-
>  drivers/usb/typec/ucsi/ucsi_stm32g0.c           |  2 +-
>  7 files changed, 25 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 0a6a4b7f7a3b..fd8152dd4450 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -6783,6 +6783,11 @@
>  			<port#>,<js1>,<js2>,<js3>,<js4>,<js5>,<js6>,<js7>
>  			See also Documentation/input/devices/joystick-parport.rst
>  
> +	typec_ucsi.quirks=	[USB]
> +			A hex value specifying the quirks to enable for
> +			the USB Type-C connector system software interface
> +			driver. This overrides auto detected quirks.

New module parameters are not going to be accepted.

Please just fix the issue with Dell's first like I proposed, and then
you can start thinking about the infra for the quirks.

thanks,


-- 
heikki


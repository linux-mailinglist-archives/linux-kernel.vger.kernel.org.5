Return-Path: <linux-kernel+bounces-44715-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C1AE8842664
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 14:48:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BECAE1C24922
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 13:48:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 961D76D1C4;
	Tue, 30 Jan 2024 13:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HrxWPEpJ"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1818E6D1B3;
	Tue, 30 Jan 2024 13:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706622485; cv=none; b=NvEV7+fP9f780h6n2wpDG4fTTqHF9yo5c+DrmK1BBCclChNICf8ORoGrNs0wtg5LcUkAD6kK3CCquXmg6TwCpsGoWH/ZrSIehggSVUjfh8JQ6VuS6QelmvXq3us/fySWXo0Rc1d4MOzN8sMDlpFaVuV8VJN3RTT6viiKnn4lCUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706622485; c=relaxed/simple;
	bh=vPXRD0kobbKQ6/PiogGfGv7VlWsXztmXcP6TwDaNEpY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iyb/xs1YHVWtMhx3DgB+VWFhVVfiqBP/NxMXNfEmV1yYNwuvjqSXX3qeDZ0Twcx1PYejovlSj8yI8Ad4wABOwbjc7Q0Obg7/aux7eAD4Zse6pUz2T6/u+o+q/CBZJ3qkrpYSBchaxOgpM3mGdNIWNFbunqulDRNi9jhuuTkURpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HrxWPEpJ; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706622484; x=1738158484;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vPXRD0kobbKQ6/PiogGfGv7VlWsXztmXcP6TwDaNEpY=;
  b=HrxWPEpJOhN2/U9hEIpV9YHIriBDRAdkmhuHAuw50AKU0ws4KQqm/LUC
   D0wI0Tl5pVQ8IePI2UkmDw4+P0zpVcwW++3L4BwGVezFUsNkmuCuD4NtO
   WaVNnPES3tykgfJVhMHKcTdgLEuDfGxBhzQo1+wEIDPwxiOvRipfFPF6o
   oNrJiMy5d1+UY2h/SK+eAQcqX5lglo/XW5fkQGu4iCkYjv207N88as8SM
   a8oci3uBwx1/+HEZp2a44+r7DJgMN09Hb5MGrKE47aUZDYs0JcP1S+4Wq
   4isUrw7Hjx1Vey9BZzJj9+Kxd+DAPUQHTRWvR0llsZ6OYe3BB+6VqGg14
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10968"; a="24757088"
X-IronPort-AV: E=Sophos;i="6.05,707,1701158400"; 
   d="scan'208";a="24757088"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2024 05:48:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10968"; a="931459987"
X-IronPort-AV: E=Sophos;i="6.05,707,1701158400"; 
   d="scan'208";a="931459987"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 30 Jan 2024 05:47:58 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 30 Jan 2024 15:47:58 +0200
Date: Tue, 30 Jan 2024 15:47:57 +0200
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Cc: linux-usb@vger.kernel.org, pmalani@chromium.org, jthies@google.com,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Hans de Goede <hdegoede@redhat.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Prashanth K <quic_prashk@quicinc.com>,
	Rajaram Regupathy <rajaram.regupathy@intel.com>,
	Saranya Gopal <saranya.gopal@intel.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/3] usb: typec: ucsi: Limit read size on v1.2
Message-ID: <Zbj+DWzfMURLKnLn@kuha.fi.intel.com>
References: <20240126183930.1170845-1-abhishekpandit@chromium.org>
 <20240126103859.v3.1.Iacf5570a66b82b73ef03daa6557e2fc0db10266a@changeid>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240126103859.v3.1.Iacf5570a66b82b73ef03daa6557e2fc0db10266a@changeid>

On Fri, Jan 26, 2024 at 10:39:07AM -0800, Abhishek Pandit-Subedi wrote:
> Between UCSI 1.2 and UCSI 2.0, the size of the MESSAGE_IN region was
> increased from 16 to 256. In order to avoid overflowing reads for older
> systems, add a mechanism to use the read UCSI version to truncate read
> sizes on UCSI v1.2.
> 
> Signed-off-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
> Tested on 6.6 kernel. Dmesg output from this change:
> [  105.058162] ucsi_um_test ucsi_um_test_device.0: Registered UCSI
> interface with version 3.0.0
> 
> 
> (no changes since v2)
> 
> Changes in v2:
>   - Changed log message to DEBUG
> 
>  drivers/usb/typec/ucsi/ucsi.c | 26 ++++++++++++++++++++++++--
>  drivers/usb/typec/ucsi/ucsi.h | 11 +++++++++++
>  2 files changed, 35 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
> index 5392ec698959..a35056ee3e96 100644
> --- a/drivers/usb/typec/ucsi/ucsi.c
> +++ b/drivers/usb/typec/ucsi/ucsi.c
> @@ -36,6 +36,19 @@
>   */
>  #define UCSI_SWAP_TIMEOUT_MS	5000
>  
> +static int ucsi_read_message_in(struct ucsi *ucsi, void *buf,
> +					  size_t buf_size)
> +{
> +	/*
> +	 * Below UCSI 2.0, MESSAGE_IN was limited to 16 bytes. Truncate the
> +	 * reads here.
> +	 */
> +	if (ucsi->version <= UCSI_VERSION_1_2)
> +		buf_size = min_t(size_t, 16, buf_size);
> +
> +	return ucsi->ops->read(ucsi, UCSI_MESSAGE_IN, buf, buf_size);
> +}
> +
>  static int ucsi_acknowledge_command(struct ucsi *ucsi)
>  {
>  	u64 ctrl;
> @@ -72,7 +85,7 @@ static int ucsi_read_error(struct ucsi *ucsi)
>  	if (ret < 0)
>  		return ret;
>  
> -	ret = ucsi->ops->read(ucsi, UCSI_MESSAGE_IN, &error, sizeof(error));
> +	ret = ucsi_read_message_in(ucsi, &error, sizeof(error));
>  	if (ret)
>  		return ret;
>  
> @@ -170,7 +183,7 @@ int ucsi_send_command(struct ucsi *ucsi, u64 command,
>  	length = ret;
>  
>  	if (data) {
> -		ret = ucsi->ops->read(ucsi, UCSI_MESSAGE_IN, data, size);
> +		ret = ucsi_read_message_in(ucsi, data, size);
>  		if (ret)
>  			goto out;
>  	}
> @@ -1556,6 +1569,15 @@ int ucsi_register(struct ucsi *ucsi)
>  	if (!ucsi->version)
>  		return -ENODEV;
>  
> +	/*
> +	 * Version format is JJ.M.N (JJ = Major version, M = Minor version,
> +	 * N = sub-minor version).
> +	 */
> +	dev_dbg(ucsi->dev, "Registered UCSI interface with version %x.%x.%x",
> +		UCSI_BCD_GET_MAJOR(ucsi->version),
> +		UCSI_BCD_GET_MINOR(ucsi->version),
> +		UCSI_BCD_GET_SUBMINOR(ucsi->version));
> +
>  	queue_delayed_work(system_long_wq, &ucsi->work, 0);
>  
>  	ucsi_debugfs_register(ucsi);
> diff --git a/drivers/usb/typec/ucsi/ucsi.h b/drivers/usb/typec/ucsi/ucsi.h
> index 6478016d5cb8..bec920fa6b8a 100644
> --- a/drivers/usb/typec/ucsi/ucsi.h
> +++ b/drivers/usb/typec/ucsi/ucsi.h
> @@ -23,6 +23,17 @@ struct dentry;
>  #define UCSI_CONTROL			8
>  #define UCSI_MESSAGE_IN			16
>  #define UCSI_MESSAGE_OUT		32
> +#define UCSIv2_MESSAGE_OUT		272
> +
> +/* UCSI versions */
> +#define UCSI_VERSION_1_2	0x0120
> +#define UCSI_VERSION_2_0	0x0200
> +#define UCSI_VERSION_2_1	0x0210
> +#define UCSI_VERSION_3_0	0x0300
> +
> +#define UCSI_BCD_GET_MAJOR(_v_)		(((_v_) >> 8) & 0xFF)
> +#define UCSI_BCD_GET_MINOR(_v_)		(((_v_) >> 4) & 0x0F)
> +#define UCSI_BCD_GET_SUBMINOR(_v_)	((_v_) & 0x0F)
>  
>  /* Command Status and Connector Change Indication (CCI) bits */
>  #define UCSI_CCI_CONNECTOR(_c_)		(((_c_) & GENMASK(7, 1)) >> 1)
> -- 
> 2.43.0.429.g432eaa2c6b-goog

-- 
heikki


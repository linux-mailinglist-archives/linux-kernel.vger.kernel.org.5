Return-Path: <linux-kernel+bounces-5256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BCE2381889C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 14:25:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4974B1F24A59
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 13:25:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0694A199C1;
	Tue, 19 Dec 2023 13:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="imawoa0p"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA73E1BDCF;
	Tue, 19 Dec 2023 13:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702992263; x=1734528263;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=sLfQr7K/6lkB4sfYpnczLFAY0nxv5j1xWKyojn3KSik=;
  b=imawoa0pv++2RCdjOO4yqBNQb0iu/B6oJl6mA6wIG8wSOBGA97Dapmoh
   JAI3uEC6ZOLM80oBsbfdUZxLgi8GXhSYz6KaQv/qmZFcptGTYXYMffvUe
   hEE7KUEXzGa1i8cFgiyy+oLtGm7pXAQ2Xef8/A4hRd+2iwkWtpVZ1qm8Y
   5iF7nfWOQx7OI+ORR4oZsfl4ylFU67SVMH77s7RJUaUct1gwtNLbpkNne
   NzUlpWysr21xnUg6m7r0ZRCMMrNWUFg1nf9dv3KQzTbdU/K9JrLH7HSHH
   BONRR0XVqzbkwLf/NGdpmVc3eO19FZZgxHc5FX0hoV3t/yIhcpbvWi14J
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10928"; a="2884982"
X-IronPort-AV: E=Sophos;i="6.04,288,1695711600"; 
   d="scan'208";a="2884982"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2023 05:24:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10928"; a="949167343"
X-IronPort-AV: E=Sophos;i="6.04,288,1695711600"; 
   d="scan'208";a="949167343"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by orsmga005.jf.intel.com with SMTP; 19 Dec 2023 05:24:19 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 19 Dec 2023 15:24:18 +0200
Date: Tue, 19 Dec 2023 15:24:18 +0200
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Javier Carrasco <javier.carrasco@wolfvision.net>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/4] usb: typec: tipd: add patch update support for
 tps6598x
Message-ID: <ZYGGC4sraG6akqPd@kuha.fi.intel.com>
References: <20231207-tps6598x_update-v2-0-f3cfcde6d890@wolfvision.net>
 <20231207-tps6598x_update-v2-4-f3cfcde6d890@wolfvision.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231207-tps6598x_update-v2-4-f3cfcde6d890@wolfvision.net>

On Thu, Dec 14, 2023 at 05:29:12PM +0100, Javier Carrasco wrote:
> The TPS6598x PD controller supports firmware updates that can be loaded
> either from an external flash memory or a host using the device's I2C
> host interface. This patch implements the second approach, which is
> especially relevant if no flash memory is available.
> 
> In order to make patch bundle updates, a series of tasks (special
> commands) must be sent to the device as it is documented in the
> TPS65987DDH and TPS65988DH Host Interface Technical Reference Manual[1],
> section 4.11 (Patch Bundle Update Tasks).
> 
> The update sequence is as follows:
> 1. PTCs - Start Patch Load Sequence: the proposed approach includes
>    device and application configuration data.
> 2. PTCd - Patch Download: 64-byte data chunks must be sent until the end
>    of the firmware file is reached (the last chunk may be shorter).
> 3. PTCc - Patch Data Transfer Complete: ends the patch loading sequence.
> 
> After this sequence and if no errors occurred, the device will change
> its mode to 'APP' after SETUP_MS milliseconds, and then it will be ready
> for normal operation.
> 
> [1] https://www.ti.com/lit/ug/slvubh2b/slvubh2b.pdf?ts=1697623299919&ref_url=https%253A%252F%252Fwww.ti.com%252Fproduct%252FTPS65987D
> 
> Signed-off-by: Javier Carrasco <javier.carrasco@wolfvision.net>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/tipd/core.c     | 68 ++++++++++++++++++++++++++++++++++++++-
>  drivers/usb/typec/tipd/tps6598x.h | 18 +++++++++++
>  2 files changed, 85 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/typec/tipd/core.c b/drivers/usb/typec/tipd/core.c
> index 7f4bbc0629b0..a956eb976906 100644
> --- a/drivers/usb/typec/tipd/core.c
> +++ b/drivers/usb/typec/tipd/core.c
> @@ -1125,6 +1125,71 @@ static int tps25750_apply_patch(struct tps6598x *tps)
>  	return 0;
>  };
>  
> +static int tps6598x_apply_patch(struct tps6598x *tps)
> +{
> +	u8 in = TPS_PTCS_CONTENT_DEV | TPS_PTCS_CONTENT_APP;
> +	u8 out[TPS_MAX_LEN] = {0};
> +	size_t in_len = sizeof(in);
> +	size_t copied_bytes = 0;
> +	size_t bytes_left;
> +	const struct firmware *fw;
> +	const char *firmware_name;
> +	int ret;
> +
> +	ret = device_property_read_string(tps->dev, "firmware-name",
> +					  &firmware_name);
> +	if (ret)
> +		return ret;
> +
> +	ret = tps_request_firmware(tps, &fw);
> +	if (ret)
> +		return ret;
> +
> +	ret = tps6598x_exec_cmd(tps, "PTCs", in_len, &in,
> +				TPS_PTCS_OUT_BYTES, out);
> +	if (ret || out[TPS_PTCS_STATUS] == TPS_PTCS_STATUS_FAIL) {
> +		if (!ret)
> +			ret = -EBUSY;
> +		dev_err(tps->dev, "Update start failed (%d)\n", ret);
> +		goto release_fw;
> +	}
> +
> +	bytes_left = fw->size;
> +	while (bytes_left) {
> +		if (bytes_left < TPS_MAX_LEN)
> +			in_len = bytes_left;
> +		else
> +			in_len = TPS_MAX_LEN;
> +		ret = tps6598x_exec_cmd(tps, "PTCd", in_len,
> +					fw->data + copied_bytes,
> +					TPS_PTCD_OUT_BYTES, out);
> +		if (ret || out[TPS_PTCD_TRANSFER_STATUS] ||
> +		    out[TPS_PTCD_LOADING_STATE] == TPS_PTCD_LOAD_ERR) {
> +			if (!ret)
> +				ret = -EBUSY;
> +			dev_err(tps->dev, "Patch download failed (%d)\n", ret);
> +			goto release_fw;
> +		}
> +		copied_bytes += in_len;
> +		bytes_left -= in_len;
> +	}
> +
> +	ret = tps6598x_exec_cmd(tps, "PTCc", 0, NULL, TPS_PTCC_OUT_BYTES, out);
> +	if (ret || out[TPS_PTCC_DEV] || out[TPS_PTCC_APP]) {
> +		if (!ret)
> +			ret = -EBUSY;
> +		dev_err(tps->dev, "Update completion failed (%d)\n", ret);
> +		goto release_fw;
> +	}
> +	msleep(TPS_SETUP_MS);
> +	dev_info(tps->dev, "Firmware update succeeded\n");
> +
> +release_fw:
> +	release_firmware(fw);
> +
> +	return ret;
> +};
> +
>  static int cd321x_init(struct tps6598x *tps)
>  {
>  	return 0;
> @@ -1150,7 +1215,7 @@ static int tps25750_init(struct tps6598x *tps)
>  
>  static int tps6598x_init(struct tps6598x *tps)
>  {
> -	return 0;
> +	return tps->data->apply_patch(tps);
>  }
>  
>  static int cd321x_reset(struct tps6598x *tps)
> @@ -1468,6 +1533,7 @@ static const struct tipd_data tps6598x_data = {
>  	.register_port = tps6598x_register_port,
>  	.trace_power_status = trace_tps6598x_power_status,
>  	.trace_status = trace_tps6598x_status,
> +	.apply_patch = tps6598x_apply_patch,
>  	.init = tps6598x_init,
>  	.reset = tps6598x_reset,
>  };
> diff --git a/drivers/usb/typec/tipd/tps6598x.h b/drivers/usb/typec/tipd/tps6598x.h
> index 01609bf509e4..89b24519463a 100644
> --- a/drivers/usb/typec/tipd/tps6598x.h
> +++ b/drivers/usb/typec/tipd/tps6598x.h
> @@ -235,4 +235,22 @@
>  /* SLEEP CONF REG */
>  #define TPS_SLEEP_CONF_SLEEP_MODE_ALLOWED	BIT(0)
>  
> +/* Start Patch Download Sequence */
> +#define TPS_PTCS_CONTENT_APP			BIT(0)
> +#define TPS_PTCS_CONTENT_DEV			BIT(1)
> +#define TPS_PTCS_OUT_BYTES			4
> +#define TPS_PTCS_STATUS				1
> +
> +#define TPS_PTCS_STATUS_FAIL			0x80
> +/* Patch Download */
> +#define TPS_PTCD_OUT_BYTES			10
> +#define TPS_PTCD_TRANSFER_STATUS		1
> +#define TPS_PTCD_LOADING_STATE			2
> +
> +#define TPS_PTCD_LOAD_ERR			0x09
> +/* Patch Download Complete */
> +#define TPS_PTCC_OUT_BYTES			4
> +#define TPS_PTCC_DEV				2
> +#define TPS_PTCC_APP				3
> +
>  #endif /* __TPS6598X_H__ */
> 
> -- 
> 2.39.2

-- 
heikki


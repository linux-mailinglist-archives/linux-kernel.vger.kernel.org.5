Return-Path: <linux-kernel+bounces-80735-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2947B866BDE
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 09:13:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3EE73B227E9
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 08:13:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A4961CA97;
	Mon, 26 Feb 2024 08:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XN6VyXmP"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C16D61C6B0;
	Mon, 26 Feb 2024 08:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708935211; cv=none; b=hvZiJj1XvVemK/QYCpi6FUT3BhiOtsbdCNrItqe/RjlC4NviSfVPhtoQ6iVd/huj+kNNbGDvKAPvpFqjEdzwupU46+Zo0B1HsZkulj/+Pn3z2S97G1N1XMrUSbeUm+8umMQiNoK32oSjfCfYuUvQyfqjeqO1rvxkoQFuWXwVXSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708935211; c=relaxed/simple;
	bh=0vtzk69dbjKH3PT00ztg+h1Ul0IyzUgBMCZJECKZeiI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nvx/A2eD9uMDYPUa6PqL4lbzTPBjLFr/QSSxFNdNbinK9853v38uoZwBr3ULFqhXU0Lx/g0SdsLCGQRHQa7aJ3On06rxtZ2/cq3pwYswI2Kx7iS6V9zcxLIamtqtDSzYFhfLijzChPuHiviL4f012fUeeZcMRcTy6vtn3b+WZbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XN6VyXmP; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708935210; x=1740471210;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0vtzk69dbjKH3PT00ztg+h1Ul0IyzUgBMCZJECKZeiI=;
  b=XN6VyXmPhgNm42nr0dqlluHLGvTz1KE8bYO5CTlbj7TKHDVIOE5XrPAz
   ooR6kCs030SKbhCKyFttGvqyf8LW4urXHeL4zEKEaXfogF0EcsM7Yv2hA
   KXzfyA7aPZjt+wbA7iCXEtxmFFButOk3ZNMDahz2fATLP4KbowDgT0+dP
   eN5tvhVNwZ6aRCevpwl6I66lctiJa/mCHbsPmnuvMZSLrYgZRnFoD4W2c
   BEl19zwawG1pd02i7cf2+vfOn6lul3LrZkPkphdo6kPh3+tZWuD/HPSm7
   kMnxNHguW9i8mCBBB+ZohF6tVGwQMfe2Iakn+eLezkBKo4qL0LvYdM7lR
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10995"; a="14336679"
X-IronPort-AV: E=Sophos;i="6.06,185,1705392000"; 
   d="scan'208";a="14336679"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2024 00:13:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10995"; a="937029470"
X-IronPort-AV: E=Sophos;i="6.06,185,1705392000"; 
   d="scan'208";a="937029470"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 26 Feb 2024 00:13:24 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 26 Feb 2024 10:13:23 +0200
Date: Mon, 26 Feb 2024 10:13:23 +0200
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Marco Felsch <m.felsch@pengutronix.de>
Cc: gregkh@linuxfoundation.org, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	linux@roeck-us.net, jun.li@nxp.com, devicetree@vger.kernel.org,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel@pengutronix.de
Subject: Re: [PATCH v3 4/4] usb: typec: tcpci: add support to set connector
 orientation
Message-ID: <ZdxII9W/CBx76Xai@kuha.fi.intel.com>
References: <20240222210903.208901-1-m.felsch@pengutronix.de>
 <20240222210903.208901-5-m.felsch@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240222210903.208901-5-m.felsch@pengutronix.de>

On Thu, Feb 22, 2024 at 10:09:03PM +0100, Marco Felsch wrote:
> This add the support to set the optional connector orientation bit which
> is part of the optional CONFIG_STANDARD_OUTPUT register 0x18 [1]. This
> allows system designers to connect the tcpc orientation pin directly to
> the 2:1 ss-mux.
> 
> [1] https://www.usb.org/sites/default/files/documents/usb-port_controller_specification_rev2.0_v1.0_0.pdf
> 
> Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
> ---
> v3:
> - no changes
> v2:
> - Make use of fallthrough 
> 
>  drivers/usb/typec/tcpm/tcpci.c | 44 ++++++++++++++++++++++++++++++++++
>  include/linux/usb/tcpci.h      |  8 +++++++
>  2 files changed, 52 insertions(+)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpci.c b/drivers/usb/typec/tcpm/tcpci.c
> index 7118551827f6..73a52e7f95c2 100644
> --- a/drivers/usb/typec/tcpm/tcpci.c
> +++ b/drivers/usb/typec/tcpm/tcpci.c
> @@ -67,6 +67,18 @@ static int tcpci_write16(struct tcpci *tcpci, unsigned int reg, u16 val)
>  	return regmap_raw_write(tcpci->regmap, reg, &val, sizeof(u16));
>  }
>  
> +static bool tcpci_check_std_output_cap(struct regmap *regmap, u8 mask)
> +{
> +	unsigned int reg;
> +	int ret;
> +
> +	ret = regmap_read(regmap, TCPC_STD_OUTPUT_CAP, &reg);
> +	if (ret < 0)
> +		return ret;
> +
> +	return (reg & mask) == mask;
> +}
> +
>  static int tcpci_set_cc(struct tcpc_dev *tcpc, enum typec_cc_status cc)
>  {
>  	struct tcpci *tcpci = tcpc_to_tcpci(tcpc);
> @@ -301,6 +313,28 @@ static int tcpci_set_polarity(struct tcpc_dev *tcpc,
>  			   TCPC_TCPC_CTRL_ORIENTATION : 0);
>  }
>  
> +static int tcpci_set_orientation(struct tcpc_dev *tcpc,
> +				 enum typec_orientation orientation)
> +{
> +	struct tcpci *tcpci = tcpc_to_tcpci(tcpc);
> +	unsigned int reg;
> +
> +	switch (orientation) {
> +	case TYPEC_ORIENTATION_NONE:
> +		/* We can't put a single output into high impedance */
> +		fallthrough;
> +	case TYPEC_ORIENTATION_NORMAL:
> +		reg = TCPC_CONFIG_STD_OUTPUT_ORIENTATION_NORMAL;
> +		break;
> +	case TYPEC_ORIENTATION_REVERSE:
> +		reg = TCPC_CONFIG_STD_OUTPUT_ORIENTATION_FLIPPED;
> +		break;
> +	}
> +
> +	return regmap_update_bits(tcpci->regmap, TCPC_CONFIG_STD_OUTPUT,
> +				  TCPC_CONFIG_STD_OUTPUT_ORIENTATION_MASK, reg);
> +}
> +
>  static void tcpci_set_partner_usb_comm_capable(struct tcpc_dev *tcpc, bool capable)
>  {
>  	struct tcpci *tcpci = tcpc_to_tcpci(tcpc);
> @@ -808,6 +842,9 @@ struct tcpci *tcpci_register_port(struct device *dev, struct tcpci_data *data)
>  	if (tcpci->data->vbus_vsafe0v)
>  		tcpci->tcpc.is_vbus_vsafe0v = tcpci_is_vbus_vsafe0v;
>  
> +	if (tcpci->data->set_orientation)
> +		tcpci->tcpc.set_orientation = tcpci_set_orientation;

I don't think that flag is needed - not yet at least. Please just call
tcpci_check_std_output_cap() directly from here.

>  	err = tcpci_parse_config(tcpci);
>  	if (err < 0)
>  		return ERR_PTR(err);
> @@ -851,6 +888,13 @@ static int tcpci_probe(struct i2c_client *client)
>  	if (err < 0)
>  		return err;
>  
> +	err = tcpci_check_std_output_cap(chip->data.regmap,
> +					 TCPC_STD_OUTPUT_CAP_ORIENTATION);
> +	if (err < 0)
> +		return err;
> +
> +	chip->data.set_orientation = err;
> +
>  	chip->tcpci = tcpci_register_port(&client->dev, &chip->data);
>  	if (IS_ERR(chip->tcpci))
>  		return PTR_ERR(chip->tcpci);
> diff --git a/include/linux/usb/tcpci.h b/include/linux/usb/tcpci.h
> index 467e8045e9f8..f2bfb4250366 100644
> --- a/include/linux/usb/tcpci.h
> +++ b/include/linux/usb/tcpci.h
> @@ -47,6 +47,9 @@
>  #define TCPC_SINK_FAST_ROLE_SWAP	BIT(0)
>  
>  #define TCPC_CONFIG_STD_OUTPUT		0x18
> +#define TCPC_CONFIG_STD_OUTPUT_ORIENTATION_MASK		BIT(0)
> +#define TCPC_CONFIG_STD_OUTPUT_ORIENTATION_NORMAL	0
> +#define TCPC_CONFIG_STD_OUTPUT_ORIENTATION_FLIPPED	1
>  
>  #define TCPC_TCPC_CTRL			0x19
>  #define TCPC_TCPC_CTRL_ORIENTATION	BIT(0)
> @@ -127,6 +130,7 @@
>  #define TCPC_DEV_CAP_2			0x26
>  #define TCPC_STD_INPUT_CAP		0x28
>  #define TCPC_STD_OUTPUT_CAP		0x29
> +#define TCPC_STD_OUTPUT_CAP_ORIENTATION	BIT(0)
>  
>  #define TCPC_MSG_HDR_INFO		0x2e
>  #define TCPC_MSG_HDR_INFO_DATA_ROLE	BIT(3)
> @@ -198,12 +202,16 @@ struct tcpci;
>   *		Chip level drivers are expected to check for contaminant and call
>   *		tcpm_clean_port when the port is clean to put the port back into
>   *		toggling state.
> + * @set_orientation:
> + *		Optional; Enable setting the connector orientation
> + *		CONFIG_STANDARD_OUTPUT (0x18) bit0.
>   */
>  struct tcpci_data {
>  	struct regmap *regmap;
>  	unsigned char TX_BUF_BYTE_x_hidden:1;
>  	unsigned char auto_discharge_disconnect:1;
>  	unsigned char vbus_vsafe0v:1;
> +	unsigned char set_orientation:1;
>  
>  	int (*init)(struct tcpci *tcpci, struct tcpci_data *data);
>  	int (*set_vconn)(struct tcpci *tcpci, struct tcpci_data *data,
> -- 
> 2.39.2

-- 
heikki


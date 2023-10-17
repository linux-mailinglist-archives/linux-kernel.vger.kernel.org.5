Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 433677CBE4C
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 11:01:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234741AbjJQJBU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 05:01:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234147AbjJQJBT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 05:01:19 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D64EB0;
        Tue, 17 Oct 2023 02:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697533277; x=1729069277;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Ycdmn1yRnmUMNTHqsn5gHRBcw7LLPquXwlkEsT2ze3g=;
  b=Wa4GYMuI6JT60yalyY6kyE6K8kEeO9oQFm1bkTtBew+BZEAbQbj8Zhq2
   aoFSwrMiaqr/AaQtX2o46sAHHJ/DTivb6zuz6S37CK7tN3Yj0bXFYvw1L
   SbwCJUxRbd8MeUEOBxI+4r/a1a6U7DvoE4uUXk28N7DUoE7WlMbjJ6A94
   jx7EGqIXZdKgE2XC+n289sE6zh9mr7gjC1+0STdKjzIHv2Io3SIsOAeGH
   fk2vqAh80KSRTUTT+3MFKtpNP7TjP3My7neCEpOVSkMUxDW/nuOO3mfms
   Z+LIXztV8CtzN8dH/sIwiI7d0hhzQjK/Tq0F9btb9uC50FZEglPo1dZaT
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="7296588"
X-IronPort-AV: E=Sophos;i="6.03,231,1694761200"; 
   d="scan'208";a="7296588"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2023 02:01:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="705923313"
X-IronPort-AV: E=Sophos;i="6.03,231,1694761200"; 
   d="scan'208";a="705923313"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by orsmga003.jf.intel.com with SMTP; 17 Oct 2023 02:01:12 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 17 Oct 2023 12:01:11 +0300
Date:   Tue, 17 Oct 2023 12:01:11 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Luca Weiss <luca.weiss@fairphone.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 2/3] usb: typec: fsa4480: Add support to swap SBU
 orientation
Message-ID: <ZS5NV43MhD3YNeDX@kuha.fi.intel.com>
References: <20231013-fsa4480-swap-v1-0-b877f62046cc@fairphone.com>
 <20231013-fsa4480-swap-v1-2-b877f62046cc@fairphone.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231013-fsa4480-swap-v1-2-b877f62046cc@fairphone.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Luca,

On Fri, Oct 13, 2023 at 01:38:06PM +0200, Luca Weiss wrote:
> On some hardware designs the AUX+/- lanes are connected reversed to
> SBU1/2 compared to the expected design by FSA4480.
> 
> Made more complicated, the otherwise compatible Orient-Chip OCP96011
> expects the lanes to be connected reversed compared to FSA4480.
> 
> * FSA4480 block diagram shows AUX+ connected to SBU2 and AUX- to SBU1.
> * OCP96011 block diagram shows AUX+ connected to SBU1 and AUX- to SBU2.
> 
> So if OCP96011 is used as drop-in for FSA4480 then the orientation
> handling in the driver needs to be reversed to match the expectation of
> the OCP96011 hardware.
> 
> Support parsing the data-lanes parameter in the endpoint node to swap
> this in the driver.
> 
> The parse_data_lanes_mapping function is mostly taken from nb7vpq904m.c.
> 
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---
>  drivers/usb/typec/mux/fsa4480.c | 81 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 81 insertions(+)
> 
> diff --git a/drivers/usb/typec/mux/fsa4480.c b/drivers/usb/typec/mux/fsa4480.c
> index e0ee1f621abb..6ee467c96fb6 100644
> --- a/drivers/usb/typec/mux/fsa4480.c
> +++ b/drivers/usb/typec/mux/fsa4480.c
> @@ -9,6 +9,7 @@
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/mutex.h>
> +#include <linux/of_graph.h>

If you don't mind, let's keep this driver ready for ACPI, just in
case...

>  #include <linux/regmap.h>
>  #include <linux/usb/typec_dp.h>
>  #include <linux/usb/typec_mux.h>
> @@ -60,6 +61,7 @@ struct fsa4480 {
>  	unsigned int svid;
>  
>  	u8 cur_enable;
> +	bool swap_sbu_lanes;
>  };
>  
>  static const struct regmap_config fsa4480_regmap_config = {
> @@ -76,6 +78,9 @@ static int fsa4480_set(struct fsa4480 *fsa)
>  	u8 enable = FSA4480_ENABLE_DEVICE;
>  	u8 sel = 0;
>  
> +	if (fsa->swap_sbu_lanes)
> +		reverse = !reverse;
> +
>  	/* USB Mode */
>  	if (fsa->mode < TYPEC_STATE_MODAL ||
>  	    (!fsa->svid && (fsa->mode == TYPEC_MODE_USB2 ||
> @@ -179,12 +184,84 @@ static int fsa4480_mux_set(struct typec_mux_dev *mux, struct typec_mux_state *st
>  	return ret;
>  }
>  
> +enum {
> +	NORMAL_LANE_MAPPING,
> +	INVERT_LANE_MAPPING,
> +};
> +
> +#define DATA_LANES_COUNT	2
> +
> +static const int supported_data_lane_mapping[][DATA_LANES_COUNT] = {
> +	[NORMAL_LANE_MAPPING] = { 0, 1 },
> +	[INVERT_LANE_MAPPING] = { 1, 0 },
> +};
> +
> +static int fsa4480_parse_data_lanes_mapping(struct fsa4480 *fsa)
> +{
> +	struct device_node *ep;

        struct fwnode_handle *ep;

> +	u32 data_lanes[DATA_LANES_COUNT];
> +	int ret, i, j;
> +
> +	ep = of_graph_get_next_endpoint(fsa->client->dev.of_node, NULL);

Shouldn't you loop through the endpoints? In any case:

        ep = fwnode_graph_get_next_endpoint(dev_fwnode(&fsa->client->dev, NULL));

> +	if (!ep)
> +		return 0;
> +
> +	ret = of_property_count_u32_elems(ep, "data-lanes");

        ret = fwnode_property_count_u32(ep, "data-lanes");

But is this necessary at all in this case - why not just read the
array since you expect a fixed size for it (if the read fails it fails)?

> +	if (ret == -EINVAL)
> +		/* Property isn't here, consider default mapping */
> +		goto out_done;
> +	if (ret < 0)
> +		goto out_error;
> +
> +	if (ret != DATA_LANES_COUNT) {
> +		dev_err(&fsa->client->dev, "expected 2 data lanes\n");
> +		ret = -EINVAL;
> +		goto out_error;
> +	}
> +
> +	ret = of_property_read_u32_array(ep, "data-lanes", data_lanes, DATA_LANES_COUNT);

        ret = fwnode_property_read_u32_array(ep, "data-lanes", data_lanes, DATA_LANES_COUNT);

> +	if (ret)
> +		goto out_error;
> +
> +	for (i = 0; i < ARRAY_SIZE(supported_data_lane_mapping); i++) {
> +		for (j = 0; j < DATA_LANES_COUNT; j++) {
> +			if (data_lanes[j] != supported_data_lane_mapping[i][j])
> +				break;
> +		}
> +
> +		if (j == DATA_LANES_COUNT)
> +			break;
> +	}
> +
> +	switch (i) {
> +	case NORMAL_LANE_MAPPING:
> +		break;
> +	case INVERT_LANE_MAPPING:
> +		fsa->swap_sbu_lanes = true;
> +		dev_info(&fsa->client->dev, "using inverted data lanes mapping\n");

That is just noise. Please drop it.

> +		break;
> +	default:
> +		dev_err(&fsa->client->dev, "invalid data lanes mapping\n");
> +		ret = -EINVAL;
> +		goto out_error;
> +	}
> +
> +out_done:
> +	ret = 0;
> +
> +out_error:
> +	of_node_put(ep);
> +
> +	return ret;
> +}
> +
>  static int fsa4480_probe(struct i2c_client *client)
>  {
>  	struct device *dev = &client->dev;
>  	struct typec_switch_desc sw_desc = { };
>  	struct typec_mux_desc mux_desc = { };
>  	struct fsa4480 *fsa;
> +	int ret;
>  
>  	fsa = devm_kzalloc(dev, sizeof(*fsa), GFP_KERNEL);
>  	if (!fsa)
> @@ -193,6 +270,10 @@ static int fsa4480_probe(struct i2c_client *client)
>  	fsa->client = client;
>  	mutex_init(&fsa->lock);
>  
> +	ret = fsa4480_parse_data_lanes_mapping(fsa);
> +	if (ret)
> +		return ret;
> +
>  	fsa->regmap = devm_regmap_init_i2c(client, &fsa4480_regmap_config);
>  	if (IS_ERR(fsa->regmap))
>  		return dev_err_probe(dev, PTR_ERR(fsa->regmap), "failed to initialize regmap\n");
> 
> -- 
> 2.42.0

-- 
heikki

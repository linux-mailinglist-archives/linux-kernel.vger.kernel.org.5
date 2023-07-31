Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C64ED76974E
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 15:16:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232876AbjGaNQg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 09:16:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbjGaNQ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 09:16:29 -0400
Received: from mgamail.intel.com (unknown [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69719E75;
        Mon, 31 Jul 2023 06:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690809388; x=1722345388;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=i2O+ffUC3QkRd8lfDmc9uuiKSy0hOGcWGfhz9xoZCAQ=;
  b=LDJazHXwfy48TJMetdVS6zx+dom4vEeJ8sYkmrrPKS4BkXKTaYmA7NXI
   U5CBf961taMnn8Yl3y66DWQuZsBqksKW+7yoFzlzkVVYoQvqSt3o6pWAd
   RGDpMbGwm5wQEIz36ewLJCeIwczsmp4a5GW08ZVAjD92qvQXOCDm3eDip
   UFQKY5u8yh9UVaPrV2i+N0Vm9UQDgOlBtfTiip1Lg8P3Kcv19g6WwayJJ
   L94CzzQk/nwv0MpbQvi9nksFOdcACYcyn8udc52/O9BrzMAHPnuEdEazb
   7/51rNhPkLWCN4NldIF+JvQK8UqmoxTFRsxVsyGPCbguXrbvoBI+CVH2e
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10788"; a="366497449"
X-IronPort-AV: E=Sophos;i="6.01,244,1684825200"; 
   d="scan'208";a="366497449"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2023 06:16:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="871671819"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 31 Jul 2023 06:16:27 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 31 Jul 2023 16:16:24 +0300
Date:   Mon, 31 Jul 2023 16:16:24 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH] usb: typec: nb7vpq904m: Add an error handling path in
 nb7vpq904m_probe()
Message-ID: <ZMe0KBvJIpagVOXD@kuha.fi.intel.com>
References: <9118954765821ea9f1179883602b4eca63e91749.1689716381.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9118954765821ea9f1179883602b4eca63e91749.1689716381.git.christophe.jaillet@wanadoo.fr>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 18, 2023 at 11:40:05PM +0200, Christophe JAILLET wrote:
> In case of error in the nb7vpq904m_probe() probe function, some resources
> need to be freed, as already done in the remove function.
> 
> Add the missing error handling path and adjust code accordingly.
> 
> Fixes: 88d8f3ac9c67 ("usb: typec: add support for the nb7vpq904m Type-C Linear Redriver")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
> This changes the order with some devm_ allocated resources. I hope this is
> fine. At least it is consistent with the remove function.
> ---
>  drivers/usb/typec/mux/nb7vpq904m.c | 25 ++++++++++++++++++-------
>  1 file changed, 18 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/usb/typec/mux/nb7vpq904m.c b/drivers/usb/typec/mux/nb7vpq904m.c
> index 80e580d50129..4d1122d95013 100644
> --- a/drivers/usb/typec/mux/nb7vpq904m.c
> +++ b/drivers/usb/typec/mux/nb7vpq904m.c
> @@ -463,16 +463,18 @@ static int nb7vpq904m_probe(struct i2c_client *client)
>  
>  	ret = nb7vpq904m_register_bridge(nb7);
>  	if (ret)
> -		return ret;
> +		goto err_disable_gpio;
>  
>  	sw_desc.drvdata = nb7;
>  	sw_desc.fwnode = dev->fwnode;
>  	sw_desc.set = nb7vpq904m_sw_set;
>  
>  	nb7->sw = typec_switch_register(dev, &sw_desc);
> -	if (IS_ERR(nb7->sw))
> -		return dev_err_probe(dev, PTR_ERR(nb7->sw),
> -				     "Error registering typec switch\n");
> +	if (IS_ERR(nb7->sw)) {
> +		ret = dev_err_probe(dev, PTR_ERR(nb7->sw),
> +				    "Error registering typec switch\n");
> +		goto err_disable_gpio;
> +	}
>  
>  	retimer_desc.drvdata = nb7;
>  	retimer_desc.fwnode = dev->fwnode;
> @@ -480,12 +482,21 @@ static int nb7vpq904m_probe(struct i2c_client *client)
>  
>  	nb7->retimer = typec_retimer_register(dev, &retimer_desc);
>  	if (IS_ERR(nb7->retimer)) {
> -		typec_switch_unregister(nb7->sw);
> -		return dev_err_probe(dev, PTR_ERR(nb7->retimer),
> -				     "Error registering typec retimer\n");
> +		ret = dev_err_probe(dev, PTR_ERR(nb7->retimer),
> +				    "Error registering typec retimer\n");
> +		goto err_switch_unregister;
>  	}
>  
>  	return 0;
> +
> +err_switch_unregister:
> +	typec_switch_unregister(nb7->sw);
> +
> +err_disable_gpio:
> +	gpiod_set_value(nb7->enable_gpio, 0);
> +	regulator_disable(nb7->vcc_supply);
> +
> +	return ret;
>  }
>  
>  static void nb7vpq904m_remove(struct i2c_client *client)
> -- 
> 2.34.1

-- 
heikki

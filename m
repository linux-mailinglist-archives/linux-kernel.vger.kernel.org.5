Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97C7576CB5E
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 12:58:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232789AbjHBK6l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 06:58:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbjHBK6i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 06:58:38 -0400
Received: from mgamail.intel.com (unknown [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4B3B10FB;
        Wed,  2 Aug 2023 03:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690973916; x=1722509916;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0x3PqFN8vR6V6CBYZpKBG5JyJgFHJ4SC4adq3Kp3M/E=;
  b=TqbBzfvv5aF0VmVS0iLtM826gQrNxPewfKPlpT4zVyIPS4MjKxF8nXtR
   bw8bgk33rsS4jxKZHZEvn7NwKyxvEk+wLbDadAkk0DTyGV4YWWi/LPHAg
   DWp+0STEtdOeUR2J9DgNKQORLpNUt7VXhsgjyvVHMxzozzXI2om5clt8n
   emZfmVn2fRE9X4Sb1aLIVXX8XF6GLykSIfWoNvyLeRkkVSZ50DcRKHxi2
   9hW2m4A/S+Puh7K/3dzRI0c+i///KjN6rDayTIAo8iAYNp698zPgvOYQn
   vh3ak8AFP8V96PDDMGuqMf/IbsXY2/fn+luL0C5eTMg3zKyLVeTrGDwKr
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10789"; a="455916619"
X-IronPort-AV: E=Sophos;i="6.01,249,1684825200"; 
   d="scan'208";a="455916619"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2023 03:58:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="872437459"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 02 Aug 2023 03:58:36 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Wed, 02 Aug 2023 13:58:33 +0300
Date:   Wed, 2 Aug 2023 13:58:33 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Prashanth K <quic_prashk@quicinc.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        "# 5 . 4" <stable@vger.kernel.org>
Subject: Re: [PATCH v3] usb: common: usb-conn-gpio: Prevent bailing out if
 initial role is none
Message-ID: <ZMo22WHrkpLLJE/V@kuha.fi.intel.com>
References: <1690880632-12588-1-git-send-email-quic_prashk@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1690880632-12588-1-git-send-email-quic_prashk@quicinc.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 01, 2023 at 02:33:52PM +0530, Prashanth K wrote:
> Currently if we bootup a device without cable connected, then
> usb-conn-gpio won't call set_role() because last_role is same
> as current role. This happens since last_role gets initialised
> to zero during the probe.
> 
> To avoid this, add a new flag initial_detection into struct
> usb_conn_info, which prevents bailing out during initial
> detection.
> 
> Cc: <stable@vger.kernel.org> # 5.4
> Fixes: 4602f3bff266 ("usb: common: add USB GPIO based connection detection driver")
> Signed-off-by: Prashanth K <quic_prashk@quicinc.com>

FWIW:

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
> v3: Added cc tag as suggested by the patch-bot.
> v2: Updated the bool name to initial_detection.
> 
>  drivers/usb/common/usb-conn-gpio.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/common/usb-conn-gpio.c b/drivers/usb/common/usb-conn-gpio.c
> index 766005d..501e8bc9 100644
> --- a/drivers/usb/common/usb-conn-gpio.c
> +++ b/drivers/usb/common/usb-conn-gpio.c
> @@ -42,6 +42,7 @@ struct usb_conn_info {
>  
>  	struct power_supply_desc desc;
>  	struct power_supply *charger;
> +	bool initial_detection;
>  };
>  
>  /*
> @@ -86,11 +87,13 @@ static void usb_conn_detect_cable(struct work_struct *work)
>  	dev_dbg(info->dev, "role %s -> %s, gpios: id %d, vbus %d\n",
>  		usb_role_string(info->last_role), usb_role_string(role), id, vbus);
>  
> -	if (info->last_role == role) {
> +	if (!info->initial_detection && info->last_role == role) {
>  		dev_warn(info->dev, "repeated role: %s\n", usb_role_string(role));
>  		return;
>  	}
>  
> +	info->initial_detection = false;
> +
>  	if (info->last_role == USB_ROLE_HOST && info->vbus)
>  		regulator_disable(info->vbus);
>  
> @@ -258,6 +261,7 @@ static int usb_conn_probe(struct platform_device *pdev)
>  	device_set_wakeup_capable(&pdev->dev, true);
>  
>  	/* Perform initial detection */
> +	info->initial_detection = true;
>  	usb_conn_queue_dwork(info, 0);
>  
>  	return 0;
> -- 
> 2.7.4

thanks,

-- 
heikki

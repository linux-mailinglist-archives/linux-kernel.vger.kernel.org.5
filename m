Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AB747AB000
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 12:54:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233453AbjIVKxy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 06:53:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbjIVKxv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 06:53:51 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96106C2;
        Fri, 22 Sep 2023 03:53:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695380025; x=1726916025;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gh+iGFfn3Us/xv2NrPwWywq7/uM80gChhhpRj60ApIg=;
  b=a9DZ3MoD/Fhw8+cmY1UThm1F736A59GBCwCzjh6pxrPovR5TmpaW00zS
   +OOvlgGnpvT1X9tL/Jo/MUMQudz3nySeHjswvO8mlOD8Twrz4INST4Sj8
   /U6dmBCICHYMJkVtIL83QXQM/UajIbTWXSIYNXyyR6SnvW0vy32WRHIJN
   gI9ULaoBoNFuIPDsJdJKfIKAm45mHZ8DDRohKyGg+Kleug/G4TWJnVpnR
   uiD8JUiI5ctmHsUOsZ78gCTL4BdjRnfk5Ytihm0tdrk6FSoAT6tmnw/s1
   dMOvFYYUg9lKPuvrSnmt2WutWPumkAWdRurpZc+oNc9+Xxr5qLppE319K
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10840"; a="384633962"
X-IronPort-AV: E=Sophos;i="6.03,167,1694761200"; 
   d="scan'208";a="384633962"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2023 03:53:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10840"; a="871207597"
X-IronPort-AV: E=Sophos;i="6.03,167,1694761200"; 
   d="scan'208";a="871207597"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by orsmga004.jf.intel.com with SMTP; 22 Sep 2023 03:53:42 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Fri, 22 Sep 2023 13:53:41 +0300
Date:   Fri, 22 Sep 2023 13:53:41 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Michael Wu <michael@allwinnertech.com>
Cc:     linux@roeck-us.net, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RESEND v2] usb:typec:tcpm:support double Rp to Vbus cable as
 sink
Message-ID: <ZQ1yNX6b9QEUfLuG@kuha.fi.intel.com>
References: <20230920063030.66312-1-michael@allwinnertech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230920063030.66312-1-michael@allwinnertech.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 20, 2023 at 02:30:30PM +0800, Michael Wu wrote:
> The USB Type-C Cable and Connector Specification defines the wire
> connections for the USB Type-C to USB 2.0 Standard-A cable assembly
> (Release 2.2, Chapter 3.5.2).
> The Notes says that Pin A5 (CC) of the USB Type-C plug shall be connected
> to Vbus through a resister Rp.
> However, there is a large amount of such double Rp connected to Vbus
> non-standard cables which produced by UGREEN circulating on the market, and
> it can affects the normal operations of the state machine easily,
> especially to CC1 and CC2 be pulled up at the same time.
> In fact, we can regard those cables as sink to avoid abnormal state.
> 
> Message as follow:
> [   58.900212] VBUS on
> [   59.265433] CC1: 0 -> 3, CC2: 0 -> 3 [state TOGGLING, polarity 0, connected]
> [   62.623308] CC1: 3 -> 0, CC2: 3 -> 0 [state TOGGLING, polarity 0, disconnected]
> [   62.625006] VBUS off
> [   62.625012] VBUS VSAFE0V
> 
> Signed-off-by: Michael Wu <michael@allwinnertech.com>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
> v1 -> v2: Simplify expression and add a comment to the code.
> 
>  drivers/usb/typec/tcpm/tcpm.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> Signed-off-by: Michael Wu <michael@allwinnertech.com>
> ---
>  drivers/usb/typec/tcpm/tcpm.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
> index d962f67c95ae6..6e843c511b856 100644
> --- a/drivers/usb/typec/tcpm/tcpm.c
> +++ b/drivers/usb/typec/tcpm/tcpm.c
> @@ -517,9 +517,9 @@ static const char * const pd_rev[] = {
>  	((cc) == TYPEC_CC_RP_DEF || (cc) == TYPEC_CC_RP_1_5 || \
>  	 (cc) == TYPEC_CC_RP_3_0)
>  
> +/* As long as cc is pulled up, we can consider it as sink. */
>  #define tcpm_port_is_sink(port) \
> -	((tcpm_cc_is_sink((port)->cc1) && !tcpm_cc_is_sink((port)->cc2)) || \
> -	 (tcpm_cc_is_sink((port)->cc2) && !tcpm_cc_is_sink((port)->cc1)))
> +	(tcpm_cc_is_sink((port)->cc1) || tcpm_cc_is_sink((port)->cc2))
>  
>  #define tcpm_cc_is_source(cc) ((cc) == TYPEC_CC_RD)
>  #define tcpm_cc_is_audio(cc) ((cc) == TYPEC_CC_RA)
> -- 
> 2.29.0

-- 
heikki

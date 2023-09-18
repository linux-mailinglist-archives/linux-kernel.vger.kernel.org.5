Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11C767A470D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 12:32:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241257AbjIRKb5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 06:31:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241248AbjIRKbe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 06:31:34 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75F81D9;
        Mon, 18 Sep 2023 03:31:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695033088; x=1726569088;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MdFmQamjzg5uG3QQj1WFkrbL/ippuubUhgQZmGyME44=;
  b=MomIUwP/LikLmhP+HSh7JOR38xLye4bvicFoQL17BZ2DwsCbqYIlIZil
   exaUsH7A+221ZgxOGM8osDtu334y1hMOENMDQ58JHA3B5YbsomI9aGheZ
   rWqDqeITO/wzEGQ145lUK5YaVCM0j5YvDVGBHtAQgPYF3T/c52keZHYA4
   Jp/2zDdDTrnhAbJT0v2VDJoH0tM5hLbwrTFr7K/fRp8kwXdKqa9/65x4Z
   B4hywHnIBe0kDWb0Q1lpv6Jh2WEXDr1AI7S9anO3JKa2NE7g7gf1AuZ/F
   b84UN07KTMqegVa/EQppuYlqL7qMiHnezHYYHn4aGErBIgYIPI55fOI09
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10836"; a="359036235"
X-IronPort-AV: E=Sophos;i="6.02,156,1688454000"; 
   d="scan'208";a="359036235"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2023 03:31:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10836"; a="835970674"
X-IronPort-AV: E=Sophos;i="6.02,156,1688454000"; 
   d="scan'208";a="835970674"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by FMSMGA003.fm.intel.com with SMTP; 18 Sep 2023 03:31:25 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 18 Sep 2023 13:31:24 +0300
Date:   Mon, 18 Sep 2023 13:31:24 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Michael Wu <michael@allwinnertech.com>
Cc:     linux@roeck-us.net, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb:typec:tcpm:support double Rp to Vbus cable as sink
Message-ID: <ZQgm/Lb4iZtWrWbs@kuha.fi.intel.com>
References: <20230914003154.27977-1-michael@allwinnertech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230914003154.27977-1-michael@allwinnertech.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 14, 2023 at 08:31:54AM +0800, Michael Wu wrote:
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
> ---
>  drivers/usb/typec/tcpm/tcpm.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
> index d962f67c95ae6..beb7143128667 100644
> --- a/drivers/usb/typec/tcpm/tcpm.c
> +++ b/drivers/usb/typec/tcpm/tcpm.c
> @@ -519,7 +519,8 @@ static const char * const pd_rev[] = {
>  
>  #define tcpm_port_is_sink(port) \
>  	((tcpm_cc_is_sink((port)->cc1) && !tcpm_cc_is_sink((port)->cc2)) || \
> -	 (tcpm_cc_is_sink((port)->cc2) && !tcpm_cc_is_sink((port)->cc1)))
> +	 (tcpm_cc_is_sink((port)->cc2) && !tcpm_cc_is_sink((port)->cc1)) || \
> +	 (tcpm_cc_is_sink((port)->cc1) && tcpm_cc_is_sink((port)->cc2)))
>  
>  #define tcpm_cc_is_source(cc) ((cc) == TYPEC_CC_RD)
>  #define tcpm_cc_is_audio(cc) ((cc) == TYPEC_CC_RA)

This look OK to me, but I would still like to wait for comments from
Guenter - just in case.

thanks,

-- 
heikki

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 352787F3079
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 15:16:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234275AbjKUOQG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 09:16:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233912AbjKUOQD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 09:16:03 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DE8F10E9;
        Tue, 21 Nov 2023 06:15:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700576160; x=1732112160;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xQgVwAbHsU1vIB6WJDcMNKCuymgxW0pjQWc+1BIVk7Q=;
  b=KIGrSUqLXKt2il7mfH+t2PVMaMm0QGfIDPXr/Asg2Zj7JZt+D70j3MtW
   dJdqAmONs1yHm8WyTq5DkZF4Ssyhxt8FMct4k2X6ZaTZNOOqmlJAOy61F
   x/AeGogUED+r8cOaGcb/K253KpFHLTt9Fmh6oDUBvBabhfLtfHel+Ga6o
   erOjh7iwyhC7n0ICBmsgXzhMeP10On3h8CVWcqzRGLcMfjWDFY6Vc3V7A
   YYuAaWo2pmKmFlJqses/0x1T2aH+2XlCcFHKG1VhbgwlbdVzngQ0Y2M6+
   +giIw0qAU5vA8Y6sxSpmGY3dvXvTBMnCjNLDrMPC8bt7rf835jfzOmiI2
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10901"; a="5040917"
X-IronPort-AV: E=Sophos;i="6.04,215,1695711600"; 
   d="scan'208";a="5040917"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2023 06:15:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10901"; a="832659372"
X-IronPort-AV: E=Sophos;i="6.04,215,1695711600"; 
   d="scan'208";a="832659372"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga008.fm.intel.com with SMTP; 21 Nov 2023 06:15:54 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 21 Nov 2023 16:15:53 +0200
Date:   Tue, 21 Nov 2023 16:15:53 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Guan-Yu Lin <guanyulin@google.com>
Cc:     linux@roeck-us.net, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        badhri@google.com, kyletso@google.com, albertccwang@google.com
Subject: Re: [PATCH] usb: typec: tcpm: skip checking port->send_discover in
 PD3.0
Message-ID: <ZVy7mW1tJVifh/65@kuha.fi.intel.com>
References: <20231116083221.1201892-1-guanyulin@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231116083221.1201892-1-guanyulin@google.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 16, 2023 at 04:32:16PM +0800, Guan-Yu Lin wrote:
> The original Collison Avoidance mechanism, port->send_discover, avoids
> the conflict when port partners start AMS almost the same time. However,
> this mechanism is replaced by SINK_TX_OK and SINK_TX_NG. Skip the check
> in PD3.0 to avoid the deadlock when source is requesting DR_SWAP where
> sink is requesting DISCOVER_IDENTITY.
> 
> Signed-off-by: Guan-Yu Lin <guanyulin@google.com>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/tcpm/tcpm.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
> index 058d5b853b57..ff3c171a3a75 100644
> --- a/drivers/usb/typec/tcpm/tcpm.c
> +++ b/drivers/usb/typec/tcpm/tcpm.c
> @@ -2847,7 +2847,7 @@ static void tcpm_pd_ctrl_request(struct tcpm_port *port,
>  					   PD_MSG_CTRL_NOT_SUPP,
>  					   NONE_AMS);
>  		} else {
> -			if (port->send_discover) {
> +			if (port->send_discover && port->negotiated_rev < PD_REV30) {
>  				tcpm_queue_message(port, PD_MSG_CTRL_WAIT);
>  				break;
>  			}
> @@ -2863,7 +2863,7 @@ static void tcpm_pd_ctrl_request(struct tcpm_port *port,
>  					   PD_MSG_CTRL_NOT_SUPP,
>  					   NONE_AMS);
>  		} else {
> -			if (port->send_discover) {
> +			if (port->send_discover && port->negotiated_rev < PD_REV30) {
>  				tcpm_queue_message(port, PD_MSG_CTRL_WAIT);
>  				break;
>  			}
> @@ -2872,7 +2872,7 @@ static void tcpm_pd_ctrl_request(struct tcpm_port *port,
>  		}
>  		break;
>  	case PD_CTRL_VCONN_SWAP:
> -		if (port->send_discover) {
> +		if (port->send_discover && port->negotiated_rev < PD_REV30) {
>  			tcpm_queue_message(port, PD_MSG_CTRL_WAIT);
>  			break;
>  		}
> -- 
> 2.43.0.rc0.421.g78406f8d94-goog

-- 
heikki

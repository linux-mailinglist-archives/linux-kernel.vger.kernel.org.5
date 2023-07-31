Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59E4776943F
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 13:08:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232132AbjGaLIc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 07:08:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231516AbjGaLIa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 07:08:30 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF2E3E78;
        Mon, 31 Jul 2023 04:08:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690801708; x=1722337708;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qgnwtWhbjFgSb/5GdbOTZT6iLncUhLzvzU+UhREi7mA=;
  b=YXspNeg6G8Lgipgnzri93Mb+AhSSYT02Ldfc8iXpHeOwag/foH3vH+Fm
   5XKjyka8kCd/xCDGaI6g03N5Di/AvPSInsaybGL1JxfUGP5UXcjW2xgRC
   J0ZSggVO2g1YkdT6bBOHDZmq4Akb3MTWqNCxGzXPx2oUPvTUmOaOwWkq0
   HsyJ9WaD4PUx7cZu7QSXG65dqZhF9YXZ9YM9VygLUQQOXIWAZ1B/qA43F
   gKPZsUzrke57sdlGRC8/NSOBH0+ML5RpcDBgZHlusR6dg1rmoPC/sz1Lw
   G2dnxoU3GAEgCpLX9ruTg5DEZtzyJD3r0EEqr3ZbeEflwdQN6v0+Cx5DN
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10787"; a="399936113"
X-IronPort-AV: E=Sophos;i="6.01,244,1684825200"; 
   d="scan'208";a="399936113"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2023 04:08:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="871644682"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 31 Jul 2023 04:08:27 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 31 Jul 2023 14:08:24 +0300
Date:   Mon, 31 Jul 2023 14:08:24 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Badhri Jagan Sridharan <badhri@google.com>
Cc:     gregkh@linuxfoundation.org, linux@roeck-us.net, kyletso@google.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH v1] usb: typec: tcpm: Fix response to vsafe0V event
Message-ID: <ZMeWKDi99T6tBRg8@kuha.fi.intel.com>
References: <20230712085722.1414743-1-badhri@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230712085722.1414743-1-badhri@google.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm sorry to keep you waiting.

On Wed, Jul 12, 2023 at 08:57:22AM +0000, Badhri Jagan Sridharan wrote:
> Do not transition to SNK_UNATTACHED state when receiving vsafe0v event
> while in SNK_HARD_RESET_WAIT_VBUS. Ignore VBUS off events as well as
> in some platforms VBUS off can be signalled more than once.
> 
> [143515.364753] Requesting mux state 1, usb-role 2, orientation 2
> [143515.365520] pending state change SNK_HARD_RESET_SINK_OFF -> SNK_HARD_RESET_SINK_ON @ 650 ms [rev3 HARD_RESET]
> [143515.632281] CC1: 0 -> 0, CC2: 3 -> 0 [state SNK_HARD_RESET_SINK_OFF, polarity 1, disconnected]
> [143515.637214] VBUS on
> [143515.664985] VBUS off
> [143515.664992] state change SNK_HARD_RESET_SINK_OFF -> SNK_HARD_RESET_WAIT_VBUS [rev3 HARD_RESET]
> [143515.665564] VBUS VSAFE0V
> [143515.665566] state change SNK_HARD_RESET_WAIT_VBUS -> SNK_UNATTACHED [rev3 HARD_RESET]
> 
> Fixes: 28b43d3d746b ("usb: typec: tcpm: Introduce vsafe0v for vbus")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>

Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/tcpm/tcpm.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
> index 829d75ebab42..cc1d83926497 100644
> --- a/drivers/usb/typec/tcpm/tcpm.c
> +++ b/drivers/usb/typec/tcpm/tcpm.c
> @@ -5349,6 +5349,10 @@ static void _tcpm_pd_vbus_off(struct tcpm_port *port)
>  		/* Do nothing, vbus drop expected */
>  		break;
>  
> +	case SNK_HARD_RESET_WAIT_VBUS:
> +		/* Do nothing, its OK to receive vbus off events */
> +		break;
> +
>  	default:
>  		if (port->pwr_role == TYPEC_SINK && port->attached)
>  			tcpm_set_state(port, SNK_UNATTACHED, tcpm_wait_for_discharge(port));
> @@ -5395,6 +5399,9 @@ static void _tcpm_pd_vbus_vsafe0v(struct tcpm_port *port)
>  	case SNK_DEBOUNCED:
>  		/*Do nothing, still waiting for VSAFE5V for connect */
>  		break;
> +	case SNK_HARD_RESET_WAIT_VBUS:
> +		/* Do nothing, its OK to receive vbus off events */
> +		break;
>  	default:
>  		if (port->pwr_role == TYPEC_SINK && port->auto_vbus_discharge_enabled)
>  			tcpm_set_state(port, SNK_UNATTACHED, 0);
> 
> base-commit: 06c2afb862f9da8dc5efa4b6076a0e48c3fbaaa5
> -- 
> 2.41.0.255.g8b1d071c50-goog

-- 
heikki

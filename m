Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 411527E510B
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 08:33:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235072AbjKHHde (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 02:33:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232425AbjKHHde (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 02:33:34 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA9CC12B;
        Tue,  7 Nov 2023 23:33:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699428812; x=1730964812;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xYo4FkY3orhcLQh8jJvOeDqIVSyWwopf5oOTy9TpkEo=;
  b=mmRNkUL8Zwtm10TgrYXeMabu+I9tzfNPanZd6VPxEQqlKA56vZJyAZfV
   K6xvmWAhqug5QbIE4C2deEO2nqNNMuafofq+aYJ60u80KSVxqT+YMpDea
   sZZ2k84z77f8qJg3nO8cEqJAtb8Xadxx70TVzqVVAenZ9mNvIDhZ6BTWH
   cgUm09k46gv6v72GC98yME0x1dQ173sKT5yMrby2zCGKB1UnFTXMHPVnU
   Ocv/tE5yvxDaAhjBdnrYJ9vYmz4VNqb2lQT/T5c758Zhm+ufcKBBTWT1k
   5eZuL2pJc4URPAM/XeHfstt54wKmUFtDcWUgXaFNAaTe7zzg2my3iygWZ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10887"; a="2649922"
X-IronPort-AV: E=Sophos;i="6.03,285,1694761200"; 
   d="scan'208";a="2649922"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2023 23:33:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10887"; a="712853254"
X-IronPort-AV: E=Sophos;i="6.03,285,1694761200"; 
   d="scan'208";a="712853254"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by orsmga003.jf.intel.com with SMTP; 07 Nov 2023 23:33:27 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Wed, 08 Nov 2023 09:33:26 +0200
Date:   Wed, 8 Nov 2023 09:33:26 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Badhri Jagan Sridharan <badhri@google.com>
Cc:     gregkh@linuxfoundation.org, linux@roeck-us.net, kyletso@google.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        rdbabiera@google.com, amitsd@google.com, stable@vger.kernel.org
Subject: Re: [PATCH v1] usb: typec: tcpm: Skip hard reset when in error
 recovery
Message-ID: <ZUs5xlX5NUulRunC@kuha.fi.intel.com>
References: <20231101021909.2962679-1-badhri@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231101021909.2962679-1-badhri@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 01, 2023 at 02:19:09AM +0000, Badhri Jagan Sridharan wrote:
> Hard reset queued prior to error recovery (or) received during
> error recovery will make TCPM to prematurely exit error recovery
> sequence. Ignore hard resets received during error recovery (or)
> port reset sequence.
> 
> ```
> [46505.459688] state change SNK_READY -> ERROR_RECOVERY [rev3 NONE_AMS]
> [46505.459706] state change ERROR_RECOVERY -> PORT_RESET [rev3 NONE_AMS]
> [46505.460433] disable vbus discharge ret:0
> [46505.461226] Setting usb_comm capable false
> [46505.467244] Setting voltage/current limit 0 mV 0 mA
> [46505.467262] polarity 0
> [46505.470695] Requesting mux state 0, usb-role 0, orientation 0
> [46505.475621] cc:=0
> [46505.476012] pending state change PORT_RESET -> PORT_RESET_WAIT_OFF @ 100 ms [rev3 NONE_AMS]
> [46505.476020] Received hard reset
> [46505.476024] state change PORT_RESET -> HARD_RESET_START [rev3 HARD_RESET]
> ```
> 
> Cc: stable@vger.kernel.org
> Fixes: f0690a25a140 ("staging: typec: USB Type-C Port Manager (tcpm)")
> Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>

Acked-by: Heikki Krogeus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/tcpm/tcpm.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
> index 058d5b853b57..b386102f7a3a 100644
> --- a/drivers/usb/typec/tcpm/tcpm.c
> +++ b/drivers/usb/typec/tcpm/tcpm.c
> @@ -5391,6 +5391,15 @@ static void _tcpm_pd_hard_reset(struct tcpm_port *port)
>  	if (port->bist_request == BDO_MODE_TESTDATA && port->tcpc->set_bist_data)
>  		port->tcpc->set_bist_data(port->tcpc, false);
>  
> +	switch (port->state) {
> +	case ERROR_RECOVERY:
> +	case PORT_RESET:
> +	case PORT_RESET_WAIT_OFF:
> +		return;
> +	default:
> +		break;
> +	}
> +
>  	if (port->ams != NONE_AMS)
>  		port->ams = NONE_AMS;
>  	if (port->hard_reset_count < PD_N_HARD_RESET_COUNT)
> 
> base-commit: c70793fb7632a153862ee9060e6d48131469a29c
> -- 
> 2.42.0.820.g83a721a137-goog

-- 
heikki

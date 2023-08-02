Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27BCB76CB54
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 12:56:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233797AbjHBK4y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 06:56:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231818AbjHBK4t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 06:56:49 -0400
Received: from mgamail.intel.com (unknown [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 944F51B6;
        Wed,  2 Aug 2023 03:56:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690973807; x=1722509807;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=f/xYrOLx2w51HM69DIX1kodjgkEAXnjBk61J3pc7woQ=;
  b=Kh/1wN+OtVNaF1pPK7EUK7Sxex3bABV0t5gBJZ+S/eTMqfaqMTogUJ2O
   6SFVXdCXAA18K9ykPFpjiaFQpeQeDKn822vXW3gbi658zyYCScV0F8BUR
   itSmbE0YbXq1mCkKRgL0K66LX5NvX3BNGvgXcQaS6JQ/OB5aCkuIOyBnD
   4P2wVCLv4tNaKqEvS1A3j8+cJvPyeSQcWh3bQiiUtaunfx5YUeQpPVMcN
   XQkoj2x4QwpGqHtLzh4WoemUNqr68KkN70QMIp0piWGfJRjvvqp1S5bDu
   kzy1l5BpRmTNGzXpsf4tUVmj0UNzkOr8W3VjAuYQ7QL7V2DUDoMBHzLER
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10789"; a="455916160"
X-IronPort-AV: E=Sophos;i="6.01,249,1684825200"; 
   d="scan'208";a="455916160"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2023 03:56:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="872436393"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 02 Aug 2023 03:56:39 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Wed, 02 Aug 2023 13:56:36 +0300
Date:   Wed, 2 Aug 2023 13:56:36 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Kyle Tso <kyletso@google.com>
Cc:     linux@roeck-us.net, gregkh@linuxfoundation.org, badhri@google.com,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH] usb: typec: tcpm: Refactor the PPS APDO selection
Message-ID: <ZMo2ZDJ7bJH4fbGW@kuha.fi.intel.com>
References: <20230731162159.19483-1-kyletso@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230731162159.19483-1-kyletso@google.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 01, 2023 at 12:21:59AM +0800, Kyle Tso wrote:
> In current design of the PPS APDO selection, TCPM power supply only
> accepts the requested voltage which is inside the range of the selected
> PPS profile. To extend the flexibility and usability, remove the checks
> about the voltage range in current profile. And try to search all PPS
> APDOs of the Source that fit the requested voltage.
> 
> Also remove some redundant checks in tcpm_pd_build_pps_request.
> 
> Signed-off-by: Kyle Tso <kyletso@google.com>

Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/tcpm/tcpm.c | 122 ++++++----------------------------
>  1 file changed, 21 insertions(+), 101 deletions(-)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
> index 829d75ebab42..9c496b8302b4 100644
> --- a/drivers/usb/typec/tcpm/tcpm.c
> +++ b/drivers/usb/typec/tcpm/tcpm.c
> @@ -3253,23 +3253,12 @@ static int tcpm_pd_select_pdo(struct tcpm_port *port, int *sink_pdo,
>  	return ret;
>  }
>  
> -#define min_pps_apdo_current(x, y)	\
> -	min(pdo_pps_apdo_max_current(x), pdo_pps_apdo_max_current(y))
> -
>  static unsigned int tcpm_pd_select_pps_apdo(struct tcpm_port *port)
>  {
> -	unsigned int i, j, max_mw = 0, max_mv = 0;
> -	unsigned int min_src_mv, max_src_mv, src_ma, src_mw;
> -	unsigned int min_snk_mv, max_snk_mv;
> -	unsigned int max_op_mv;
> -	u32 pdo, src, snk;
> -	unsigned int src_pdo = 0, snk_pdo = 0;
> +	unsigned int i, src_ma, max_temp_mw = 0, max_op_ma, op_mw;
> +	unsigned int src_pdo = 0;
> +	u32 pdo, src;
>  
> -	/*
> -	 * Select the source PPS APDO providing the most power while staying
> -	 * within the board's limits. We skip the first PDO as this is always
> -	 * 5V 3A.
> -	 */
>  	for (i = 1; i < port->nr_source_caps; ++i) {
>  		pdo = port->source_caps[i];
>  
> @@ -3280,54 +3269,17 @@ static unsigned int tcpm_pd_select_pps_apdo(struct tcpm_port *port)
>  				continue;
>  			}
>  
> -			min_src_mv = pdo_pps_apdo_min_voltage(pdo);
> -			max_src_mv = pdo_pps_apdo_max_voltage(pdo);
> -			src_ma = pdo_pps_apdo_max_current(pdo);
> -			src_mw = (src_ma * max_src_mv) / 1000;
> -
> -			/*
> -			 * Now search through the sink PDOs to find a matching
> -			 * PPS APDO. Again skip the first sink PDO as this will
> -			 * always be 5V 3A.
> -			 */
> -			for (j = 1; j < port->nr_snk_pdo; j++) {
> -				pdo = port->snk_pdo[j];
> -
> -				switch (pdo_type(pdo)) {
> -				case PDO_TYPE_APDO:
> -					if (pdo_apdo_type(pdo) != APDO_TYPE_PPS) {
> -						tcpm_log(port,
> -							 "Not PPS APDO (sink), ignoring");
> -						continue;
> -					}
> -
> -					min_snk_mv =
> -						pdo_pps_apdo_min_voltage(pdo);
> -					max_snk_mv =
> -						pdo_pps_apdo_max_voltage(pdo);
> -					break;
> -				default:
> -					tcpm_log(port,
> -						 "Not APDO type (sink), ignoring");
> -					continue;
> -				}
> +			if (port->pps_data.req_out_volt > pdo_pps_apdo_max_voltage(pdo) ||
> +			    port->pps_data.req_out_volt < pdo_pps_apdo_min_voltage(pdo))
> +				continue;
>  
> -				if (min_src_mv <= max_snk_mv &&
> -				    max_src_mv >= min_snk_mv) {
> -					max_op_mv = min(max_src_mv, max_snk_mv);
> -					src_mw = (max_op_mv * src_ma) / 1000;
> -					/* Prefer higher voltages if available */
> -					if ((src_mw == max_mw &&
> -					     max_op_mv > max_mv) ||
> -					    src_mw > max_mw) {
> -						src_pdo = i;
> -						snk_pdo = j;
> -						max_mw = src_mw;
> -						max_mv = max_op_mv;
> -					}
> -				}
> +			src_ma = pdo_pps_apdo_max_current(pdo);
> +			max_op_ma = min(src_ma, port->pps_data.req_op_curr);
> +			op_mw = max_op_ma * port->pps_data.req_out_volt / 1000;
> +			if (op_mw > max_temp_mw) {
> +				src_pdo = i;
> +				max_temp_mw = op_mw;
>  			}
> -
>  			break;
>  		default:
>  			tcpm_log(port, "Not APDO type (source), ignoring");
> @@ -3337,16 +3289,10 @@ static unsigned int tcpm_pd_select_pps_apdo(struct tcpm_port *port)
>  
>  	if (src_pdo) {
>  		src = port->source_caps[src_pdo];
> -		snk = port->snk_pdo[snk_pdo];
> -
> -		port->pps_data.req_min_volt = max(pdo_pps_apdo_min_voltage(src),
> -						  pdo_pps_apdo_min_voltage(snk));
> -		port->pps_data.req_max_volt = min(pdo_pps_apdo_max_voltage(src),
> -						  pdo_pps_apdo_max_voltage(snk));
> -		port->pps_data.req_max_curr = min_pps_apdo_current(src, snk);
> -		port->pps_data.req_out_volt = min(port->pps_data.req_max_volt,
> -						  max(port->pps_data.req_min_volt,
> -						      port->pps_data.req_out_volt));
> +
> +		port->pps_data.req_min_volt = pdo_pps_apdo_min_voltage(src);
> +		port->pps_data.req_max_volt = pdo_pps_apdo_max_voltage(src);
> +		port->pps_data.req_max_curr = pdo_pps_apdo_max_current(src);
>  		port->pps_data.req_op_curr = min(port->pps_data.req_max_curr,
>  						 port->pps_data.req_op_curr);
>  	}
> @@ -3464,32 +3410,16 @@ static int tcpm_pd_send_request(struct tcpm_port *port)
>  static int tcpm_pd_build_pps_request(struct tcpm_port *port, u32 *rdo)
>  {
>  	unsigned int out_mv, op_ma, op_mw, max_mv, max_ma, flags;
> -	enum pd_pdo_type type;
>  	unsigned int src_pdo_index;
> -	u32 pdo;
>  
>  	src_pdo_index = tcpm_pd_select_pps_apdo(port);
>  	if (!src_pdo_index)
>  		return -EOPNOTSUPP;
>  
> -	pdo = port->source_caps[src_pdo_index];
> -	type = pdo_type(pdo);
> -
> -	switch (type) {
> -	case PDO_TYPE_APDO:
> -		if (pdo_apdo_type(pdo) != APDO_TYPE_PPS) {
> -			tcpm_log(port, "Invalid APDO selected!");
> -			return -EINVAL;
> -		}
> -		max_mv = port->pps_data.req_max_volt;
> -		max_ma = port->pps_data.req_max_curr;
> -		out_mv = port->pps_data.req_out_volt;
> -		op_ma = port->pps_data.req_op_curr;
> -		break;
> -	default:
> -		tcpm_log(port, "Invalid PDO selected!");
> -		return -EINVAL;
> -	}
> +	max_mv = port->pps_data.req_max_volt;
> +	max_ma = port->pps_data.req_max_curr;
> +	out_mv = port->pps_data.req_out_volt;
> +	op_ma = port->pps_data.req_op_curr;
>  
>  	flags = RDO_USB_COMM | RDO_NO_SUSPEND;
>  
> @@ -5882,12 +5812,6 @@ static int tcpm_pps_set_out_volt(struct tcpm_port *port, u16 req_out_volt)
>  		goto port_unlock;
>  	}
>  
> -	if (req_out_volt < port->pps_data.min_volt ||
> -	    req_out_volt > port->pps_data.max_volt) {
> -		ret = -EINVAL;
> -		goto port_unlock;
> -	}
> -
>  	target_mw = (port->current_limit * req_out_volt) / 1000;
>  	if (target_mw < port->operating_snk_mw) {
>  		ret = -EINVAL;
> @@ -6440,11 +6364,7 @@ static int tcpm_psy_set_prop(struct power_supply *psy,
>  		ret = tcpm_psy_set_online(port, val);
>  		break;
>  	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
> -		if (val->intval < port->pps_data.min_volt * 1000 ||
> -		    val->intval > port->pps_data.max_volt * 1000)
> -			ret = -EINVAL;
> -		else
> -			ret = tcpm_pps_set_out_volt(port, val->intval / 1000);
> +		ret = tcpm_pps_set_out_volt(port, val->intval / 1000);
>  		break;
>  	case POWER_SUPPLY_PROP_CURRENT_NOW:
>  		if (val->intval > port->pps_data.max_curr * 1000)
> -- 
> 2.41.0.487.g6d72f3e995-goog

-- 
heikki

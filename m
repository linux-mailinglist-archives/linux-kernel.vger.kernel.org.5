Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94CD080A4D2
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 14:53:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573917AbjLHNw5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 08:52:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573881AbjLHNwr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 08:52:47 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9221A198C;
        Fri,  8 Dec 2023 05:52:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702043560; x=1733579560;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WZ4Xf9dWOy5IZ//fizYpQ6RRGOorDCF699W81k/I0MI=;
  b=nMdyNC5DrnTDhYFJOvyR3L9jkWnFsi6xtnraLur9H2iWuyQnwvZp8Kl/
   UAup5hJ0XdlTCBqirSNJ2UsYjG1WI32S6KNcR7/9LHWxyE+WhsIBnsUil
   V/Ok1jncXFL5tOQDuWsmE4IQfPrQ3ehOFa2+BBDJZIZQhxf5PqH6SZuan
   W9VN5tLH6lf8iW3v0hRSdcZV4NqeczqGXibNxwqbABVW7YFzRU0jnKdTe
   joenGT4uknYoC/UheTO6q56zmHhJWsXQryIc95ciI4hYxD9kp39kg7yyr
   8RPvDROTuLoTbNg6sH1fCHOrN8QXVr1M8bRqUhYm/Ez0yYzebduqmBZ8F
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10917"; a="384811099"
X-IronPort-AV: E=Sophos;i="6.04,261,1695711600"; 
   d="scan'208";a="384811099"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2023 05:52:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10917"; a="721871594"
X-IronPort-AV: E=Sophos;i="6.04,261,1695711600"; 
   d="scan'208";a="721871594"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by orsmga003.jf.intel.com with SMTP; 08 Dec 2023 05:52:37 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Fri, 08 Dec 2023 15:52:36 +0200
Date:   Fri, 8 Dec 2023 15:52:36 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Kyle Tso <kyletso@google.com>
Cc:     linux@roeck-us.net, gregkh@linuxfoundation.org, badhri@google.com,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH v1] usb: typec: tcpm: Query Source partner for FRS
 capability only if it is DRP
Message-ID: <ZXMfpPgSY1sSCHK/@kuha.fi.intel.com>
References: <20231205074747.1821297-1-kyletso@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231205074747.1821297-1-kyletso@google.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 05, 2023 at 03:47:46PM +0800, Kyle Tso wrote:
> Source-only port partner will always respond NOT_SUPPORTED to
> GET_SINK_CAP. Avoid this redundant AMS by bailing out querying the FRS
> capability if the Source port partner is not DRP.
> 
> Signed-off-by: Kyle Tso <kyletso@google.com>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/tcpm/tcpm.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
> index 50cbc52386b3..192c103e0d10 100644
> --- a/drivers/usb/typec/tcpm/tcpm.c
> +++ b/drivers/usb/typec/tcpm/tcpm.c
> @@ -4401,7 +4401,8 @@ static void run_state_machine(struct tcpm_port *port)
>  			tcpm_set_current_limit(port, tcpm_get_current_limit(port), 5000);
>  		tcpm_swap_complete(port, 0);
>  		tcpm_typec_connect(port);
> -		mod_enable_frs_delayed_work(port, 0);
> +		if (port->pd_capable && port->source_caps[0] & PDO_FIXED_DUAL_ROLE)
> +			mod_enable_frs_delayed_work(port, 0);
>  		tcpm_pps_complete(port, port->pps_status);
>  
>  		if (port->ams != NONE_AMS)
> -- 
> 2.43.0.472.g3155946c3a-goog

-- 
heikki

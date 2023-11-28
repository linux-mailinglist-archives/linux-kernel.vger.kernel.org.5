Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C7E47FB363
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 08:57:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343956AbjK1H5X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 02:57:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234625AbjK1H5U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 02:57:20 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B37FB6;
        Mon, 27 Nov 2023 23:57:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701158246; x=1732694246;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4pTOr0kLyZ8iwib8Ous/I90Y8o+1IZ42hC+2YkZN1PM=;
  b=dqwHMTYrCxpAe86aOOA6jiDh6zuHkFQnAZmJs7ZGbl/OLITKooR7WU1e
   1a/1tE8GLbEwip2JHBxJf4N29s+3l4JhBl/8rUn9jHVn87r+Xv4AV+TYX
   UByUKXhLafAek6F6C9uJUGyLADFjgBjzFQgw56wnROMh2XMW0Xwg91V/Y
   EIQpGaz1A5+uUwq26Tz1y5iJabIbgKl5CiPvMrezRQwnrc6l6OxgDD/mZ
   i/JTidhhcWMvQiklx2memgWObZXtPKg/dqECPoPazu1uBqrIqak765jXJ
   VAYUEgVExa+IjYjyAwVzi15tlqb9wOSeBX4xE+PlFr3dJ2KVfgX/TAITJ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10907"; a="391745045"
X-IronPort-AV: E=Sophos;i="6.04,233,1695711600"; 
   d="scan'208";a="391745045"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2023 23:57:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10907"; a="772225256"
X-IronPort-AV: E=Sophos;i="6.04,233,1695711600"; 
   d="scan'208";a="772225256"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga007.fm.intel.com with SMTP; 27 Nov 2023 23:57:23 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 28 Nov 2023 09:57:22 +0200
Date:   Tue, 28 Nov 2023 09:57:22 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     RD Babiera <rdbabiera@google.com>
Cc:     linux@roeck-us.net, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        badhri@google.com
Subject: Re: [PATCH v1 1/2] usb: typec: tcpm: add tcpm_port_error_recovery
 symbol
Message-ID: <ZWWdYg+Iu4vJjS3/@kuha.fi.intel.com>
References: <20231121203845.170234-4-rdbabiera@google.com>
 <20231121203845.170234-5-rdbabiera@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231121203845.170234-5-rdbabiera@google.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 21, 2023 at 08:38:47PM +0000, RD Babiera wrote:
> Add tcpm_port_error_recovery symbol and corresponding event that runs in
> tcpm_pd_event handler to set the port to the ERROR_RECOVERY state. tcpci
> drivers can use the symbol to reset the port when tcpc faults affect port
> functionality.
> 
> Signed-off-by: RD Babiera <rdbabiera@google.com>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/tcpm/tcpm.c | 14 ++++++++++++++
>  include/linux/usb/tcpm.h      |  1 +
>  2 files changed, 15 insertions(+)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
> index 058d5b853b57..2e553dc63619 100644
> --- a/drivers/usb/typec/tcpm/tcpm.c
> +++ b/drivers/usb/typec/tcpm/tcpm.c
> @@ -251,6 +251,7 @@ enum frs_typec_current {
>  #define TCPM_FRS_EVENT		BIT(3)
>  #define TCPM_SOURCING_VBUS	BIT(4)
>  #define TCPM_PORT_CLEAN		BIT(5)
> +#define TCPM_PORT_ERROR		BIT(6)
>  
>  #define LOG_BUFFER_ENTRIES	1024
>  #define LOG_BUFFER_ENTRY_SIZE	128
> @@ -5477,6 +5478,10 @@ static void tcpm_pd_event_handler(struct kthread_work *work)
>  					tcpm_set_state(port, tcpm_default_state(port), 0);
>  			}
>  		}
> +		if (events & TCPM_PORT_ERROR) {
> +			tcpm_log(port, "port triggering error recovery");
> +			tcpm_set_state(port, ERROR_RECOVERY, 0);
> +		}
>  
>  		spin_lock(&port->pd_event_lock);
>  	}
> @@ -5544,6 +5549,15 @@ bool tcpm_port_is_toggling(struct tcpm_port *port)
>  }
>  EXPORT_SYMBOL_GPL(tcpm_port_is_toggling);
>  
> +void tcpm_port_error_recovery(struct tcpm_port *port)
> +{
> +	spin_lock(&port->pd_event_lock);
> +	port->pd_events |= TCPM_PORT_ERROR;
> +	spin_unlock(&port->pd_event_lock);
> +	kthread_queue_work(port->wq, &port->event_work);
> +}
> +EXPORT_SYMBOL_GPL(tcpm_port_error_recovery);
> +
>  static void tcpm_enable_frs_work(struct kthread_work *work)
>  {
>  	struct tcpm_port *port = container_of(work, struct tcpm_port, enable_frs);
> diff --git a/include/linux/usb/tcpm.h b/include/linux/usb/tcpm.h
> index ab7ca872950b..65fac5e1f317 100644
> --- a/include/linux/usb/tcpm.h
> +++ b/include/linux/usb/tcpm.h
> @@ -173,5 +173,6 @@ void tcpm_pd_hard_reset(struct tcpm_port *port);
>  void tcpm_tcpc_reset(struct tcpm_port *port);
>  void tcpm_port_clean(struct tcpm_port *port);
>  bool tcpm_port_is_toggling(struct tcpm_port *port);
> +void tcpm_port_error_recovery(struct tcpm_port *port);
>  
>  #endif /* __LINUX_USB_TCPM_H */
> -- 
> 2.43.0.rc1.413.gea7ed67945-goog

-- 
heikki

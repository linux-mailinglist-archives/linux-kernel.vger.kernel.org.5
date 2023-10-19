Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94A0A7CF209
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 10:09:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232897AbjJSIJM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 04:09:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231948AbjJSIJL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 04:09:11 -0400
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D4A111F;
        Thu, 19 Oct 2023 01:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697702950; x=1729238950;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zieDz8mNVXN9EfjoP5z7KgDOFeY9VzEa+XusEh5hE+s=;
  b=iM9neSlhJOW64guO1jRbnybUNIuWhKB2j84yo6oyaX1BzR7PvuP8Ngkj
   Al0QMk1xoRF7tbUokj4OdNUFK1w1mAk7fcaG5Gq+buC8P98MpsY+8b2wE
   dLe1qiw4QMc0vhPVHMbPepyZgdY0VdJfGfeIBo7PUry663Rp2NqcuFM4p
   TSZIT2l0bCsxCvVsi5RV6sqHi1bhhbY851qvrk1/JEZuG3InrmDdC3Hz1
   2hg80PofpFMa7TnSBxcsbRH514haKcPJcyfQ66z6+HvAdCvc/Wxh6U9ty
   +DGnZDzCPLr+8Aw73LRFwGng17aGld5LOZpPUwI55uIGhTOyesmGJeA1z
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10867"; a="4791793"
X-IronPort-AV: E=Sophos;i="6.03,236,1694761200"; 
   d="scan'208";a="4791793"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2023 01:09:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10867"; a="760551539"
X-IronPort-AV: E=Sophos;i="6.03,236,1694761200"; 
   d="scan'208";a="760551539"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga007.fm.intel.com with SMTP; 19 Oct 2023 01:09:05 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Thu, 19 Oct 2023 11:09:04 +0300
Date:   Thu, 19 Oct 2023 11:09:04 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     RD Babiera <rdbabiera@google.com>
Cc:     gregkh@linuxfoundation.org, linux@roeck-us.net,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        badhri@google.com, stable@vger.kernel.org
Subject: Re: [PATCH v1] usb: typec: tcpm: only discover modes the port
 supports svids for
Message-ID: <ZTDkIGLmjmL9HwJP@kuha.fi.intel.com>
References: <20231016232816.3355132-2-rdbabiera@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231016232816.3355132-2-rdbabiera@google.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Oct 16, 2023 at 11:28:17PM +0000, RD Babiera wrote:
> DisplayPort Alt Mode CTS test 10.3.1 verifies that the device can
> recognize the DP SVID in arbitrary locations within the Discover SVIDs
> response message. The test expects that the TCPM sends Discover Modes for
> the DisplayPort SVID first, but fails because the TCPM sends
> Discover Modes for all SVIDs regardless of whether or not the port
> supports them.
> 
> After discovering the port partner's SVIDs, skip to the first SVID
> supported by the device when preparing the Discover Modes request. If
> other modes need to be discovered after the first Discover Modes message
> is returned, skip over SVIDs not supported by the device.

I'm confused here. Is the device here the port or partner (or both)?
Why are you skipping the first SVID?

Please note that the Type-C specification puts priority on TBT over DP.
Is this in conflict with that?

> Fixes: f0690a25a140 ("staging: typec: USB Type-C Port Manager (tcpm)")

I think that's wrong commit (perhaps you want 8afe9a3548f9d instead?).

Right now I'm not convinced that this should be considered as a fix at
all. I don't know anything about the test you are talking about, but
if this patch is just about making it pass, then there is something
seriously wrong.

If you need the modes to be discovered in some specific order, then we
need the framework to allow you to do that. So perhaps the tcpci
drivers should be able to supply the preferred order to the tcpm?

But as such, unless I'm mistaken, this patch will change the logic so
that only the partner alt modes that the port supports get registered,
and that way are exposed to the user. You can't do that - right now
it's the only way we can inform the user about them. All partner
alternate modes (at least the SVIDs) must be exposed to the user one
way or the other, regardless does the port support them or not.


> Cc: stable@vger.kernel.org
> Signed-off-by: RD Babiera <rdbabiera@google.com>
> ---
>  drivers/usb/typec/tcpm/tcpm.c | 46 +++++++++++++++++++++++++++++++----
>  1 file changed, 41 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
> index 6e843c511b85..96636a6f1f7c 100644
> --- a/drivers/usb/typec/tcpm/tcpm.c
> +++ b/drivers/usb/typec/tcpm/tcpm.c
> @@ -1543,6 +1543,38 @@ static bool svdm_consume_svids(struct tcpm_port *port, const u32 *p, int cnt)
>  	return false;
>  }
>  
> +static bool svdm_port_supports_svid(struct tcpm_port *port, u16 svid)
> +{
> +	int i;
> +
> +	for (i = 0; i < ALTMODE_DISCOVERY_MAX; i++) {
> +		struct typec_altmode *altmode = port->port_altmode[i];
> +
> +		if (!altmode)
> +			return false;
> +		if (altmode->svid == svid)
> +			return true;
> +	}
> +	return false;
> +}
> +
> +/*
> + * This helper will continue to return the next supported SVID that the port
> + * needs to send DISCOVER_MODES to until the pmdata->svid_index is incremented after
> + * svdm_consume_modes() in tcpm_pd_svdm().
> + */
> +static int svdm_get_next_supported_svid(struct tcpm_port *port, struct pd_mode_data *pmdata)
> +{
> +	while (pmdata->svid_index < pmdata->nsvids) {
> +		u16 svid = pmdata->svids[pmdata->svid_index];
> +
> +		if (svdm_port_supports_svid(port, svid))
> +			return svid;
> +		pmdata->svid_index++;
> +	}
> +	return 0;
> +}
> +
>  static void svdm_consume_modes(struct tcpm_port *port, const u32 *p, int cnt)
>  {
>  	struct pd_mode_data *pmdata = &port->mode_data;
> @@ -1705,9 +1737,11 @@ static int tcpm_pd_svdm(struct tcpm_port *port, struct typec_altmode *adev,
>  			if (svdm_consume_svids(port, p, cnt)) {
>  				response[0] = VDO(USB_SID_PD, 1, svdm_version, CMD_DISCOVER_SVID);
>  				rlen = 1;
> -			} else if (modep->nsvids && supports_modal(port)) {
> -				response[0] = VDO(modep->svids[0], 1, svdm_version,
> -						  CMD_DISCOVER_MODES);
> +			} else if (modep->nsvids && supports_modal(port) &&
> +				   svdm_get_next_supported_svid(port, modep)) {
> +				u16 svid = svdm_get_next_supported_svid(port, modep);
> +
> +				response[0] = VDO(svid, 1, svdm_version, CMD_DISCOVER_MODES);
>  				rlen = 1;
>  			}
>  			break;
> @@ -1715,8 +1749,10 @@ static int tcpm_pd_svdm(struct tcpm_port *port, struct typec_altmode *adev,
>  			/* 6.4.4.3.3 */
>  			svdm_consume_modes(port, p, cnt);
>  			modep->svid_index++;
> -			if (modep->svid_index < modep->nsvids) {
> -				u16 svid = modep->svids[modep->svid_index];
> +			if (modep->svid_index < modep->nsvids &&
> +			    svdm_get_next_supported_svid(port, modep)) {
> +				u16 svid = svdm_get_next_supported_svid(port, modep);
> +
>  				response[0] = VDO(svid, 1, svdm_version, CMD_DISCOVER_MODES);
>  				rlen = 1;
>  			} else {
> 
> base-commit: d0d27ef87e1ca974ed93ed4f7d3c123cbd392ba6
> -- 
> 2.42.0.655.g421f12c284-goog

-- 
heikki

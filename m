Return-Path: <linux-kernel+bounces-80741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB1AC866BE9
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 09:16:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 228B71F23411
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 08:16:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 315D91CAA4;
	Mon, 26 Feb 2024 08:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hoZ/igJy"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B30E21CAAE;
	Mon, 26 Feb 2024 08:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708935369; cv=none; b=dzgFgHUxQ6rysZTGNIgGX3rrJuGaKo3kJACcWGvNS5vRHDa1s6H1hAB6bPlIrUI2E5LUxR1lM/63BZaVyKZyCa3fJqZ3/o3o558lGFrATv+W+HLQWm+QYJGjFTpBYopRQpO0d4Qo2Mgq3CJb8TrT240BipTkdg+3gI1l6wUM5MY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708935369; c=relaxed/simple;
	bh=FtOOCfXzizLmWXgElgop85mmc1HTLKJDPRDYSNRnr4w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LZNhunRHlJk3Avp+q3fpxmQlb4qPdGpoGyEvI9Rb5g+HwpWRhOQJJtmH3vxqKnPKfIoTKI2RtsNmDNLyMMgeVkDQzYD04ucfp+PLVkdoLh4N8uV7jlNOvIPwhhkHoMg1skI8DpzkXtsLO6XELTd7gVJahT6ZVy/ZU50PZowhHqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hoZ/igJy; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708935367; x=1740471367;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FtOOCfXzizLmWXgElgop85mmc1HTLKJDPRDYSNRnr4w=;
  b=hoZ/igJys+Z1kqFqjlUDkjyGmtidNz7MC6oINgItd5UTGrvYZ9rJorAN
   xpnnDGzAgNHaC050yvLVtBwjpP7bNpR2v1VVeCmNM2a8pKqDxLJcP8ed9
   wmcKIBnZSOSBOG21SSW37YSlBPiL6FYA6gM/nEwGYWXNLnWic7ciRATYb
   I3y2E8ErzNVdhpKfpr3o4K/ix8EoOLIF/wQr2Ism71eGnc9vcGRkAeJhw
   QmPlCt4zjIKjNahPhyZ36R6kxA+Nxjc6SZZ4UY8ZSbNEgCAMF06AIEZ+j
   IJn8a50pOyKKjR8ktgAxeKhNdp7rtWPf8s4btH1tJqwAkRgp5xvLixi3x
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10995"; a="6992102"
X-IronPort-AV: E=Sophos;i="6.06,185,1705392000"; 
   d="scan'208";a="6992102"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2024 00:16:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10995"; a="937029489"
X-IronPort-AV: E=Sophos;i="6.06,185,1705392000"; 
   d="scan'208";a="937029489"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 26 Feb 2024 00:16:02 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 26 Feb 2024 10:16:01 +0200
Date: Mon, 26 Feb 2024 10:16:01 +0200
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: RD Babiera <rdbabiera@google.com>
Cc: linux@roeck-us.net, gregkh@linuxfoundation.org, badhri@google.com,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	Dan Carpenter <dan.carpenter@linaro.org>
Subject: Re: [PATCH v1] usb: typec: tcpm: fix SOP' sequences in tcpm_pd_svdm
Message-ID: <ZdxIwdIs+CgxpnVD@kuha.fi.intel.com>
References: <20240223002233.3936275-2-rdbabiera@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240223002233.3936275-2-rdbabiera@google.com>

On Fri, Feb 23, 2024 at 12:22:34AM +0000, RD Babiera wrote:
> The Smatch checker flags svdm_version being uninitialized for Discover
> Identity Messages within tcpm_pd_svdm for the CMDT_INIT case. Cable plugs
> cannot initialize SVDM commands, however a port partner that isn't allowed
> to communicate over SOP' could, which would result in the CMDT_INIT block
> running for a received SOP' message.
> 
> First, initialize svdm_version for the TCPC_TX_SOP_PRIME case. If the
> svdm_version returns as an error, we expect the received svdm to be the
> result of Discover Identity that updates the value accordingly.
> 
> Next, drop all SOP' messages of type CMDT_INIT within tcpm_pd_svdm.
> 
> Finally, remove redundant call that assigns modep and pdev. Smatch will
> raise an uninitialized symbol error over modep_prime and pdev_prime, but
> both the assignment and use of these variables are guarded behind
> a check for rx_sop_type == TCPC_TX_SOP_PRIME.
> 
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Closes: https://lore.kernel.org/all/a432603b-b801-4001-b309-247dded707d3@moroto.mountain/
> Fixes: fb7ff25ae433 ("usb: typec: tcpm: add discover identity support for SOP'")
> Signed-off-by: RD Babiera <rdbabiera@google.com>

Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/tcpm/tcpm.c | 26 ++++++++++++++++----------
>  1 file changed, 16 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
> index d975fc525eac..55c438c62203 100644
> --- a/drivers/usb/typec/tcpm/tcpm.c
> +++ b/drivers/usb/typec/tcpm/tcpm.c
> @@ -1878,11 +1878,6 @@ static int tcpm_pd_svdm(struct tcpm_port *port, struct typec_altmode *adev,
>  	tcpm_log(port, "Rx VDM cmd 0x%x type %d cmd %d len %d",
>  		 p[0], cmd_type, cmd, cnt);
>  
> -	modep = &port->mode_data;
> -
> -	pdev = typec_match_altmode(port->partner_altmode, ALTMODE_DISCOVERY_MAX,
> -				   PD_VDO_VID(p[0]), PD_VDO_OPOS(p[0]));
> -
>  	switch (rx_sop_type) {
>  	case TCPC_TX_SOP_PRIME:
>  		modep_prime = &port->mode_data_prime;
> @@ -1890,11 +1885,13 @@ static int tcpm_pd_svdm(struct tcpm_port *port, struct typec_altmode *adev,
>  						 ALTMODE_DISCOVERY_MAX,
>  						 PD_VDO_VID(p[0]),
>  						 PD_VDO_OPOS(p[0]));
> -		if (!IS_ERR_OR_NULL(port->cable)) {
> -			svdm_version = typec_get_cable_svdm_version(typec);
> -			if (PD_VDO_SVDM_VER(p[0]) < svdm_version)
> -				typec_cable_set_svdm_version(port->cable, svdm_version);
> -		}
> +		svdm_version = typec_get_cable_svdm_version(typec);
> +		/*
> +		 * Update SVDM version if cable was discovered before port partner.
> +		 */
> +		if (!IS_ERR_OR_NULL(port->cable) &&
> +		    PD_VDO_SVDM_VER(p[0]) < svdm_version)
> +			typec_cable_set_svdm_version(port->cable, svdm_version);
>  		break;
>  	case TCPC_TX_SOP:
>  		modep = &port->mode_data;
> @@ -1920,6 +1917,15 @@ static int tcpm_pd_svdm(struct tcpm_port *port, struct typec_altmode *adev,
>  
>  	switch (cmd_type) {
>  	case CMDT_INIT:
> +		/*
> +		 * Only the port or port partner is allowed to initialize SVDM
> +		 * commands over SOP'. In case the port partner initializes a
> +		 * sequence when it is not allowed to send SOP' messages, drop
> +		 * the message should the TCPM port try to process it.
> +		 */
> +		if (rx_sop_type == TCPC_TX_SOP_PRIME)
> +			return 0;
> +
>  		switch (cmd) {
>  		case CMD_DISCOVER_IDENT:
>  			if (PD_VDO_VID(p[0]) != USB_SID_PD)
> 
> base-commit: 3bf0514dc6f36f81ee11b1becd977cb87b4c90c6
> -- 
> 2.44.0.rc0.258.g7320e95886-goog

-- 
heikki


Return-Path: <linux-kernel+bounces-99985-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 07DAF879045
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 10:04:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B15D1F2226C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 09:04:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A5BA77F2F;
	Tue, 12 Mar 2024 09:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jviAa95p"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0A6077F11;
	Tue, 12 Mar 2024 09:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710234240; cv=none; b=nQqBoJgydakRRnJhWh92ygs03qtSLwo1DWD1jnfBDR5qwzDRG43gnH5TkCVNtJQFEwwFHNMt8TDfRk2PnBeI041Blv3nsXgEo5PQH+diNSkISKH/wCle/71zvUIfqBlOXQ7z54yHIb5BKLhtHJAHY6Oe8dEChIO+relhGg4DuEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710234240; c=relaxed/simple;
	bh=W4G5BhdxZmlJ41Wnqy5XXt4T0CHK1owb8sqTcX8e2nM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Uwrmxo/n8cF6ES8BI0iM+y2icxW7It43dd2O1xwcxBLYC4q1hHGdREGkJ4tlh9zDYVLwImRrCxpr9/0UZhU0+D2h8hSuHgPtHhQ7lmkgHCU3zjKK/meabrGIA0htpA/QfuTw2Q65Qzh4Y+MXpyQi8PNIrtkF6EOmPwWGzVxZi5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jviAa95p; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710234239; x=1741770239;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=W4G5BhdxZmlJ41Wnqy5XXt4T0CHK1owb8sqTcX8e2nM=;
  b=jviAa95p/3SuASUx4a5hRBF1Mvz0y3IqK/Z2KpCm6NFBXQoYOTZPXbSt
   bSYXOYjKDzZUfWQ+o7L32AHpS4VMV5WqOsYBqtiTvHqu5gJ9ATGYHqNtk
   0Yzju4IKCOR+nav3ZGaZTIphwEkJmFKUw7tlD8dbAzoV1mKMe969XegrG
   v1SQHXzxXo2t+GCbad490i5GdFTnuWqb/uUJh9GH4C+JIBkfB0jqzDMWV
   40HQiBUrjopj/q0ChOs1lt46HpGeuFBZYwyifTY0q4P7UxFMSpSg5lCEE
   zlyycoWZqNbpecySHhYMyKSo6/fsSICooBJybzvyoUAfC6oaXUrYi0qWy
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11010"; a="4782826"
X-IronPort-AV: E=Sophos;i="6.07,118,1708416000"; 
   d="scan'208";a="4782826"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2024 02:03:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11010"; a="937051515"
X-IronPort-AV: E=Sophos;i="6.07,118,1708416000"; 
   d="scan'208";a="937051515"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 12 Mar 2024 02:03:54 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 12 Mar 2024 11:03:53 +0200
Date: Tue, 12 Mar 2024 11:03:53 +0200
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Badhri Jagan Sridharan <badhri@google.com>
Cc: gregkh@linuxfoundation.org, linux@roeck-us.net, kyletso@google.com,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	rdbabiera@google.com, amitsd@google.com, stable@vger.kernel.org,
	frank.wang@rock-chips.com, broonie@kernel.org
Subject: Re: [PATCH v2] usb: typec: tpcm: Fix PORT_RESET behavior for self
 powered devices
Message-ID: <ZfAaea3+HJ0P2zXn@kuha.fi.intel.com>
References: <20240228000512.746252-1-badhri@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240228000512.746252-1-badhri@google.com>

On Wed, Feb 28, 2024 at 12:05:12AM +0000, Badhri Jagan Sridharan wrote:
> While commit 69f89168b310 ("usb: typec: tpcm: Fix issues with power being
> removed during reset") fixes the boot issues for bus powered devices such
> as LibreTech Renegade Elite/Firefly, it trades off the CC pins NOT being
> Hi-Zed during errory recovery (i.e PORT_RESET) for devices which are NOT
> bus powered(a.k.a self powered). This change Hi-Zs the CC pins only for
> self powered devices, thus preventing brown out for bus powered devices
> 
> Adhering to spec is gaining more importance due to the Common charger
> initiative enforced by the European Union.
> 
> Quoting from the spec:
>     4.5.2.2.2.1 ErrorRecovery State Requirements
>     The port shall not drive VBUS or VCONN, and shall present a
>     high-impedance to ground (above zOPEN) on its CC1 and CC2 pins.
> 
> Hi-Zing the CC pins is the inteded behavior for PORT_RESET.
> CC pins are set to default state after tErrorRecovery in
> PORT_RESET_WAIT_OFF.
> 
>     4.5.2.2.2.2 Exiting From ErrorRecovery State
>     A Sink shall transition to Unattached.SNK after tErrorRecovery.
>     A Source shall transition to Unattached.SRC after tErrorRecovery.
> 
> Fixes: 69f89168b310 ("usb: typec: tpcm: Fix issues with power being removed during reset")
> Cc: stable@vger.kernel.org
> Cc: Mark Brown <broonie@kernel.org>
> Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>

Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
> Changes since V1:
> * Fix CC for linux stable
> ---
>  drivers/usb/typec/tcpm/tcpm.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
> index c9a78f55ca48..bbe1381232eb 100644
> --- a/drivers/usb/typec/tcpm/tcpm.c
> +++ b/drivers/usb/typec/tcpm/tcpm.c
> @@ -5593,8 +5593,11 @@ static void run_state_machine(struct tcpm_port *port)
>  		break;
>  	case PORT_RESET:
>  		tcpm_reset_port(port);
> -		tcpm_set_cc(port, tcpm_default_state(port) == SNK_UNATTACHED ?
> -			    TYPEC_CC_RD : tcpm_rp_cc(port));
> +		if (port->self_powered)
> +			tcpm_set_cc(port, TYPEC_CC_OPEN);
> +		else
> +			tcpm_set_cc(port, tcpm_default_state(port) == SNK_UNATTACHED ?
> +				    TYPEC_CC_RD : tcpm_rp_cc(port));
>  		tcpm_set_state(port, PORT_RESET_WAIT_OFF,
>  			       PD_T_ERROR_RECOVERY);
>  		break;
> 
> base-commit: a560a5672826fc1e057068bda93b3d4c98d037a2
> -- 
> 2.44.0.rc1.240.g4c46232300-goog

-- 
heikki


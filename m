Return-Path: <linux-kernel+bounces-100158-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5159A8792BA
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 12:08:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E793A1F217ED
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 11:08:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F373479B6D;
	Tue, 12 Mar 2024 11:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Fqp1vIrb"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BA4E7993A;
	Tue, 12 Mar 2024 11:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710241687; cv=none; b=uVmmvrF5oMyXeCj5Mrmd10gvIPm8KvlUfQwcMbPbOqETo+hQczfUTUaZpeq/hsUhQfCbw2K9Iz8gbceZ0iqvBkp+Q997wPpMih2WaYDbXcFZ8Lfolm2DRzsLctE49s/PzMjsSXO/rwi3Z3FGRpIseTT0+5UAHHi04FKe7QtjUiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710241687; c=relaxed/simple;
	bh=gy+C3KqRUOKk7iMhwdgz6Nj8AE8jLwwNIVN5icJq1as=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YTlCZneBD3yuSmyFDt+8KcNPF7RfyTzWnO5E5CCC3mDKSh7BntXNL4fPEv01mVDMy7If6um4UDZ2WbeIvjmdW9IgylhDezEui59wXX8Y0vA6uKczuVlWb+uPMBFDbGROoSIljcfqgNqrpVB1Lw2Z+lCaUpGeKIchAWw5k5DVxZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Fqp1vIrb; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710241685; x=1741777685;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gy+C3KqRUOKk7iMhwdgz6Nj8AE8jLwwNIVN5icJq1as=;
  b=Fqp1vIrb22RaM8wJVIzYR4oD5NhtgbwedNIkjjtsZrS36VXQD11yK4rN
   S3ySUiKSAS2ts+SrTH8PEcUvbiVtuKBhZ4CsEJo15SciUO9lgexuN6wdM
   tZtuSlgoTLDlQQ5He8WrzuKaezxZOzMA5i3yB+7b6Pdac8ZK/f+c8x59K
   IGkD4NVDgtyipclvE4SYGBQHDejrlngwSiBOz+1lglarTneES5zpNIuna
   s0dWionIPKpsqT6MNBH7OPZuEu1ZfOPklCBwFMFFeUxXTYWkISMp5Ar8l
   9ZxNm9rRNIWghDveknwAQe114W56YIdAmMOZrS3eRO4aRxvNtm/sa57zo
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11010"; a="30382055"
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; 
   d="scan'208";a="30382055"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2024 04:08:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11010"; a="937051685"
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; 
   d="scan'208";a="937051685"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 12 Mar 2024 04:07:59 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 12 Mar 2024 13:07:59 +0200
Date: Tue, 12 Mar 2024 13:07:59 +0200
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Michael Wu <michael@allwinnertech.com>
Cc: gregkh@linuxfoundation.org, linux@roeck-us.net, badhri@google.com,
	kyletso@google.com, frank.wang@rock-chips.com, rdbabiera@google.com,
	xu.yang_2@nxp.com, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: typec: tcpm: support sink port for debounce
Message-ID: <ZfA3jzTqn8jNIsLZ@kuha.fi.intel.com>
References: <20240312011300.75081-1-michael@allwinnertech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240312011300.75081-1-michael@allwinnertech.com>

On Tue, Mar 12, 2024 at 09:13:00AM +0800, Michael Wu wrote:
> When both CC1 and CC2 pins are simultaneously pulled up, it often leads
> to the double Rp to Vbus cable being stuck in the SNK_ATTACH_WAIT state.
> And the state machine fails to transition to the SNK_ATTACHED state.
> 
> Therefore, it is recommended to focus on transitioning the sink port to
> the SNK_DEBOUNCED state instead. By doing so, the desired outcome can be
> achieved more effectively.

Recommended by whom (or what)?

> [  134.525750] VBUS on
> [  134.713240] CC1: 0 -> 3, CC2: 0 -> 3 [state TOGGLING, polarity 0, connected]
> [  134.713249] state change TOGGLING -> SNK_ATTACH_WAIT [rev3 NONE_AMS]
> 
> Signed-off-by: Michael Wu <michael@allwinnertech.com>
> ---
>  drivers/usb/typec/tcpm/tcpm.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
> index 0965972310275..9228dbd78bf2b 100644
> --- a/drivers/usb/typec/tcpm/tcpm.c
> +++ b/drivers/usb/typec/tcpm/tcpm.c
> @@ -4197,6 +4197,8 @@ static void run_state_machine(struct tcpm_port *port)
>  		else if (tcpm_port_is_disconnected(port))
>  			tcpm_set_state(port, SNK_UNATTACHED,
>  				       PD_T_PD_DEBOUNCE);
> +		else if (tcpm_port_is_sink(port))
> +			tcpm_set_state(port, SNK_DEBOUNCED, 0);
>  		break;
>  	case SNK_DEBOUNCED:
>  		if (tcpm_port_is_disconnected(port))
> -- 
> 2.29.0

-- 
heikki


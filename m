Return-Path: <linux-kernel+bounces-36614-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C5F483A3C7
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 09:10:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1BCC1C29291
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 08:10:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6973B17571;
	Wed, 24 Jan 2024 08:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AKYBfcHd"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 486D717542;
	Wed, 24 Jan 2024 08:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.55.52.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706083831; cv=none; b=rKbCMRQmb5AOaom/Jgo6YxERXUExFurgNM3g0x0YbSc8PyNkFM8zRW1kQuYHDz9Nq0QU0myr8lFyKMuC4h2FogOvkO1EMmkRbcRZOm6aluQ5mX9+wbzxb7UTXH0LkOTWAyFL944DzDhJ7SYbQwhLXAllfwG5rrixHx1CPKdzcbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706083831; c=relaxed/simple;
	bh=/q2imODtehh+YW9i6WnWA85GhPWtHs+dotAgSxrBN1Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Idda0uT7yAfgiNdCO+AUIx6Raih/9VGapg8ay6bDea0JqRTowvqCt0rkxUsAWN4192vTLV8nI/z3wbfnSs4b4PXe3zfZCxLSDIW7HaKz1K3izliTGzjqXk8eRqZy9fh2WQN8KG1uNSDXyOdRLjkcXUnA6P2JOAbpMaDu1fvHqdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AKYBfcHd; arc=none smtp.client-ip=192.55.52.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706083829; x=1737619829;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/q2imODtehh+YW9i6WnWA85GhPWtHs+dotAgSxrBN1Q=;
  b=AKYBfcHdOpHxNnAmyuOe/TNB+wL0mbhY4QOd2sbHVIdiS7D51kasLZ1i
   rqWGymlXGcbKf2jyGkH8nJ9Vfek/ootoy8NIqM0PEV9RwDVsagm6wJkKN
   7GtXIoORWp5oVc/oJrY42br+9LBxKP1QNZnlLKC3Mw4/ESCW0Ys5FeHay
   7WAUhO7InbRWVbFDR4yafG8gOUU9kU1FAGU8U4MMRKQUeGO+ripjpWTfO
   QRrb/3yFtwlV8bWbVo/okrcGSIfne35PyTCJ/Oaj8h+9ElhYKZ7v2PtDN
   VghswXjo2svJuf50jfyJIkti0aIiMY+X8vvpn7swpmCX09M17oOxJZfjh
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="398929617"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="398929617"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2024 00:10:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="929594546"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="929594546"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 24 Jan 2024 00:10:24 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Wed, 24 Jan 2024 10:10:24 +0200
Date: Wed, 24 Jan 2024 10:10:24 +0200
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: "Christian A. Ehrhardt" <lk@c--e.de>
Cc: linux-usb@vger.kernel.org, Dell.Client.Kernel@dell.com,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Hans de Goede <hdegoede@redhat.com>,
	Jack Pham <quic_jackp@quicinc.com>,
	Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
	Samuel =?utf-8?B?xIxhdm9q?= <samuel@cavoj.net>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/3] usb: ucsi_acpi: Fix command completion handling
Message-ID: <ZbDF8BZDBbFZRcgD@kuha.fi.intel.com>
References: <20240121204123.275441-1-lk@c--e.de>
 <20240121204123.275441-3-lk@c--e.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240121204123.275441-3-lk@c--e.de>

On Sun, Jan 21, 2024 at 09:41:22PM +0100, Christian A. Ehrhardt wrote:
> In case of a spurious or otherwise delayed notification it is
> possible that CCI still reports the previous completion. The
> UCSI spec is aware of this and provides two completion bits in
> CCI, one for normal commands and one for acks. As acks and commands
> alternate the notification handler can determine if the completion
> bit is from the current command.
> 
> The initial UCSI code correctly handled this but the distinction
> between the two completion bits was lost with the introduction of
> the new API.
> 
> To fix this revive the ACK_PENDING bit for ucsi_acpi and only complete
> commands if the completion bit matches.
> 
> Fixes: f56de278e8ec ("usb: typec: ucsi: acpi: Move to the new API")
> Cc: stable@vger.kernel.org
> Signed-off-by: Christian A. Ehrhardt <lk@c--e.de>

Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/ucsi/ucsi_acpi.c | 17 +++++++++++++----
>  1 file changed, 13 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/usb/typec/ucsi/ucsi_acpi.c b/drivers/usb/typec/ucsi/ucsi_acpi.c
> index 6bbf490ac401..fa222080887d 100644
> --- a/drivers/usb/typec/ucsi/ucsi_acpi.c
> +++ b/drivers/usb/typec/ucsi/ucsi_acpi.c
> @@ -73,9 +73,13 @@ static int ucsi_acpi_sync_write(struct ucsi *ucsi, unsigned int offset,
>  				const void *val, size_t val_len)
>  {
>  	struct ucsi_acpi *ua = ucsi_get_drvdata(ucsi);
> +	bool ack = UCSI_COMMAND(*(u64 *)val) == UCSI_ACK_CC_CI;
>  	int ret;
>  
> -	set_bit(COMMAND_PENDING, &ua->flags);
> +	if (ack)
> +		set_bit(ACK_PENDING, &ua->flags);
> +	else
> +		set_bit(COMMAND_PENDING, &ua->flags);
>  
>  	ret = ucsi_acpi_async_write(ucsi, offset, val, val_len);
>  	if (ret)
> @@ -85,7 +89,10 @@ static int ucsi_acpi_sync_write(struct ucsi *ucsi, unsigned int offset,
>  		ret = -ETIMEDOUT;
>  
>  out_clear_bit:
> -	clear_bit(COMMAND_PENDING, &ua->flags);
> +	if (ack)
> +		clear_bit(ACK_PENDING, &ua->flags);
> +	else
> +		clear_bit(COMMAND_PENDING, &ua->flags);
>  
>  	return ret;
>  }
> @@ -142,8 +149,10 @@ static void ucsi_acpi_notify(acpi_handle handle, u32 event, void *data)
>  	if (UCSI_CCI_CONNECTOR(cci))
>  		ucsi_connector_change(ua->ucsi, UCSI_CCI_CONNECTOR(cci));
>  
> -	if (test_bit(COMMAND_PENDING, &ua->flags) &&
> -	    cci & (UCSI_CCI_ACK_COMPLETE | UCSI_CCI_COMMAND_COMPLETE))
> +	if (cci & UCSI_CCI_ACK_COMPLETE && test_bit(ACK_PENDING, &ua->flags))
> +		complete(&ua->complete);
> +	if (cci & UCSI_CCI_COMMAND_COMPLETE &&
> +	    test_bit(COMMAND_PENDING, &ua->flags))
>  		complete(&ua->complete);
>  }
>  
> -- 
> 2.40.1

-- 
heikki


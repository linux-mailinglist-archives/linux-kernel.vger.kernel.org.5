Return-Path: <linux-kernel+bounces-111262-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 744908869D9
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 11:01:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2A312848BF
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 10:01:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9CE32E648;
	Fri, 22 Mar 2024 10:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AT8F/9F8"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A71320DDB;
	Fri, 22 Mar 2024 10:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711101654; cv=none; b=tFv0TIx0zxaYEVHN1QnwXrbDVOccOVsLd+NxW2TFeAGbNDUoWm8iUaI3v1B8kK41A88uX4kd+qM0AQr6wrCM4+miL2cdogGZDM0BO39IWoBD7vHdG3nR4Y/JjTZWfPGsZRnxfWVxZ98yP7tlb5vntBC46Dayy1Ct9V5mM03gFzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711101654; c=relaxed/simple;
	bh=E3/bnKuL7Mpe+LB8PMDjQvpGmrTvcJ6XAYO5VXcHSTk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DQVkn2PO76YoaVQkqBdR/9PlV8XF+zBUrOqdd+DwFdTzJ+xaAQcK6/XMXW6tACpCDrUuj/Ptfo2N/eTDe0pRSZd5YeXN2ipe8FBDECP6StvCITdordxnY46sDoBrC09aIC03ZUKccyEhsyDhKZXyBcbimj9dYqwkIwXExmtcxRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AT8F/9F8; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711101652; x=1742637652;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=E3/bnKuL7Mpe+LB8PMDjQvpGmrTvcJ6XAYO5VXcHSTk=;
  b=AT8F/9F8oPpHjKPL0cQsRvZ4xLyiqTpx4ovOON2X+NiZAYGD/siJH530
   wuLYEoSc6br08IRB8yIQht6a02l0M5aYiJPCZb/N3ZbhLYtuoda3qnU+N
   vZnQ+lstQPq4gUqI9BZJgzPTIr/12k5WqC2a4g3a25h9bSxS0qQyK4Win
   uQqNK4g9XlKUfLS1JeY0EIEOJtwDLWiJA25QFkU3e2YarANqe1171UWly
   VEnfHO35H8gcb2yjil8pMz6lEeqELOiAFkcVYh4C2cBbezDVtgjbg3ava
   K+YfYaAgop+FiupO+KZi9vju4nNM03LsCxfnYXUZyqvg/amqYaTmHjOTd
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11020"; a="6266801"
X-IronPort-AV: E=Sophos;i="6.07,145,1708416000"; 
   d="scan'208";a="6266801"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2024 03:00:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11020"; a="937066511"
X-IronPort-AV: E=Sophos;i="6.07,145,1708416000"; 
   d="scan'208";a="937066511"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 22 Mar 2024 03:00:47 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Fri, 22 Mar 2024 12:00:47 +0200
Date: Fri, 22 Mar 2024 12:00:47 +0200
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: "Christian A. Ehrhardt" <lk@c--e.de>
Cc: linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Prashant Malani <pmalani@chromium.org>,
	Jameson Thies <jthies@google.com>,
	Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	Samuel =?utf-8?B?xIxhdm9q?= <samuel@cavoj.net>,
	linux-usb@vger.kernel.org, Kenneth Crudup <kenny@panix.com>
Subject: Re: [PATCH 4/5] usb: typec: ucsi_acpi: Refactor and fix DELL quirk
Message-ID: <Zf1Wz5veKzKgm18H@kuha.fi.intel.com>
References: <20240320073927.1641788-1-lk@c--e.de>
 <20240320073927.1641788-5-lk@c--e.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240320073927.1641788-5-lk@c--e.de>

On Wed, Mar 20, 2024 at 08:39:25AM +0100, Christian A. Ehrhardt wrote:
> Some DELL systems don't like UCSI_ACK_CC_CI commands with the
> UCSI_ACK_CONNECTOR_CHANGE but not the UCSI_ACK_COMMAND_COMPLETE
> bit set. The current quirk still leaves room for races because
> it requires two consecutive ACK commands to be sent.
> 
> Refactor and significantly simplify the quirk to fix this:
> Send a dummy command and bundle the connector change ack with the
> command completion ack in a single UCSI_ACK_CC_CI command.
> This removes the need to probe for the quirk.
> 
> While there define flag bits for struct ucsi_acpi->flags in ucsi_acpi.c
> and don't re-use definitions from ucsi.h for struct ucsi->flags.
> 
> Fixes: f3be347ea42d ("usb: ucsi_acpi: Quirk to ack a connector change ack cmd")
> Cc: stable@vger.kernel.org
> Signed-off-by: Christian A. Ehrhardt <lk@c--e.de>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/ucsi/ucsi_acpi.c | 75 +++++++++++++-----------------
>  1 file changed, 33 insertions(+), 42 deletions(-)
> 
> diff --git a/drivers/usb/typec/ucsi/ucsi_acpi.c b/drivers/usb/typec/ucsi/ucsi_acpi.c
> index 928eacbeb21a..7b3ac133ef86 100644
> --- a/drivers/usb/typec/ucsi/ucsi_acpi.c
> +++ b/drivers/usb/typec/ucsi/ucsi_acpi.c
> @@ -23,10 +23,11 @@ struct ucsi_acpi {
>  	void *base;
>  	struct completion complete;
>  	unsigned long flags;
> +#define UCSI_ACPI_SUPPRESS_EVENT	0
> +#define UCSI_ACPI_COMMAND_PENDING	1
> +#define UCSI_ACPI_ACK_PENDING		2
>  	guid_t guid;
>  	u64 cmd;
> -	bool dell_quirk_probed;
> -	bool dell_quirk_active;
>  };
>  
>  static int ucsi_acpi_dsm(struct ucsi_acpi *ua, int func)
> @@ -79,9 +80,9 @@ static int ucsi_acpi_sync_write(struct ucsi *ucsi, unsigned int offset,
>  	int ret;
>  
>  	if (ack)
> -		set_bit(ACK_PENDING, &ua->flags);
> +		set_bit(UCSI_ACPI_ACK_PENDING, &ua->flags);
>  	else
> -		set_bit(COMMAND_PENDING, &ua->flags);
> +		set_bit(UCSI_ACPI_COMMAND_PENDING, &ua->flags);
>  
>  	ret = ucsi_acpi_async_write(ucsi, offset, val, val_len);
>  	if (ret)
> @@ -92,9 +93,9 @@ static int ucsi_acpi_sync_write(struct ucsi *ucsi, unsigned int offset,
>  
>  out_clear_bit:
>  	if (ack)
> -		clear_bit(ACK_PENDING, &ua->flags);
> +		clear_bit(UCSI_ACPI_ACK_PENDING, &ua->flags);
>  	else
> -		clear_bit(COMMAND_PENDING, &ua->flags);
> +		clear_bit(UCSI_ACPI_COMMAND_PENDING, &ua->flags);
>  
>  	return ret;
>  }
> @@ -129,51 +130,40 @@ static const struct ucsi_operations ucsi_zenbook_ops = {
>  };
>  
>  /*
> - * Some Dell laptops expect that an ACK command with the
> - * UCSI_ACK_CONNECTOR_CHANGE bit set is followed by a (separate)
> - * ACK command that only has the UCSI_ACK_COMMAND_COMPLETE bit set.
> - * If this is not done events are not delivered to OSPM and
> - * subsequent commands will timeout.
> + * Some Dell laptops don't like ACK commands with the
> + * UCSI_ACK_CONNECTOR_CHANGE but not the UCSI_ACK_COMMAND_COMPLETE
> + * bit set. To work around this send a dummy command and bundle the
> + * UCSI_ACK_CONNECTOR_CHANGE with the UCSI_ACK_COMMAND_COMPLETE
> + * for the dummy command.
>   */
>  static int
>  ucsi_dell_sync_write(struct ucsi *ucsi, unsigned int offset,
>  		     const void *val, size_t val_len)
>  {
>  	struct ucsi_acpi *ua = ucsi_get_drvdata(ucsi);
> -	u64 cmd = *(u64 *)val, ack = 0;
> +	u64 cmd = *(u64 *)val;
> +	u64 dummycmd = UCSI_GET_CAPABILITY;
>  	int ret;
>  
> -	if (UCSI_COMMAND(cmd) == UCSI_ACK_CC_CI &&
> -	    cmd & UCSI_ACK_CONNECTOR_CHANGE)
> -		ack = UCSI_ACK_CC_CI | UCSI_ACK_COMMAND_COMPLETE;
> -
> -	ret = ucsi_acpi_sync_write(ucsi, offset, val, val_len);
> -	if (ret != 0)
> -		return ret;
> -	if (ack == 0)
> -		return ret;
> -
> -	if (!ua->dell_quirk_probed) {
> -		ua->dell_quirk_probed = true;
> -
> -		cmd = UCSI_GET_CAPABILITY;
> -		ret = ucsi_acpi_sync_write(ucsi, UCSI_CONTROL, &cmd,
> -					   sizeof(cmd));
> -		if (ret == 0)
> -			return ucsi_acpi_sync_write(ucsi, UCSI_CONTROL,
> -						    &ack, sizeof(ack));
> -		if (ret != -ETIMEDOUT)
> +	if (cmd == (UCSI_ACK_CC_CI | UCSI_ACK_CONNECTOR_CHANGE)) {
> +		cmd |= UCSI_ACK_COMMAND_COMPLETE;
> +
> +		/*
> +		 * The UCSI core thinks it is sending a connector change ack
> +		 * and will accept new connector change events. We don't want
> +		 * this to happen for the dummy command as its response will
> +		 * still report the very event that the core is trying to clear.
> +		 */
> +		set_bit(UCSI_ACPI_SUPPRESS_EVENT, &ua->flags);
> +		ret = ucsi_acpi_sync_write(ucsi, UCSI_CONTROL, &dummycmd,
> +					   sizeof(dummycmd));
> +		clear_bit(UCSI_ACPI_SUPPRESS_EVENT, &ua->flags);
> +
> +		if (ret < 0)
>  			return ret;
> -
> -		ua->dell_quirk_active = true;
> -		dev_err(ua->dev, "Firmware bug: Additional ACK required after ACKing a connector change.\n");
> -		dev_err(ua->dev, "Firmware bug: Enabling workaround\n");
>  	}
>  
> -	if (!ua->dell_quirk_active)
> -		return ret;
> -
> -	return ucsi_acpi_sync_write(ucsi, UCSI_CONTROL, &ack, sizeof(ack));
> +	return ucsi_acpi_sync_write(ucsi, UCSI_CONTROL, &cmd, sizeof(cmd));
>  }
>  
>  static const struct ucsi_operations ucsi_dell_ops = {
> @@ -209,13 +199,14 @@ static void ucsi_acpi_notify(acpi_handle handle, u32 event, void *data)
>  	if (ret)
>  		return;
>  
> -	if (UCSI_CCI_CONNECTOR(cci))
> +	if (UCSI_CCI_CONNECTOR(cci) &&
> +	    !test_bit(UCSI_ACPI_SUPPRESS_EVENT, &ua->flags))
>  		ucsi_connector_change(ua->ucsi, UCSI_CCI_CONNECTOR(cci));
>  
>  	if (cci & UCSI_CCI_ACK_COMPLETE && test_bit(ACK_PENDING, &ua->flags))
>  		complete(&ua->complete);
>  	if (cci & UCSI_CCI_COMMAND_COMPLETE &&
> -	    test_bit(COMMAND_PENDING, &ua->flags))
> +	    test_bit(UCSI_ACPI_COMMAND_PENDING, &ua->flags))
>  		complete(&ua->complete);
>  }
>  
> -- 
> 2.40.1

-- 
heikki


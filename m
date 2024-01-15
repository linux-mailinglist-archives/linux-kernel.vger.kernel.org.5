Return-Path: <linux-kernel+bounces-26421-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C8B682E060
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 19:57:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CDA8283A26
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 18:57:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13EC018E2D;
	Mon, 15 Jan 2024 18:55:24 +0000 (UTC)
Received: from cae.in-ulm.de (cae.in-ulm.de [217.10.14.231])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B0E118E1F;
	Mon, 15 Jan 2024 18:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c--e.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=c--e.de
Received: by cae.in-ulm.de (Postfix, from userid 1000)
	id EBB1314035E; Mon, 15 Jan 2024 19:55:15 +0100 (CET)
Date: Mon, 15 Jan 2024 19:55:15 +0100
From: "Christian A. Ehrhardt" <lk@c--e.de>
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: linux-usb@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Hans de Goede <hdegoede@redhat.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Saranya Gopal <saranya.gopal@intel.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC] Fix stuck UCSI controller on DELL
Message-ID: <ZaV/kwuh2MBNY5d2@cae.in-ulm.de>
References: <20240103100635.57099-1-lk@c--e.de>
 <ZZadhlh3q9ZInxvU@kuha.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZZadhlh3q9ZInxvU@kuha.fi.intel.com>


Hi Heikki,

sorry to bother you again with this but I'm afraid there's
a misunderstanding wrt. the nature of the quirk. See below:

On Thu, Jan 04, 2024 at 01:59:02PM +0200, Heikki Krogerus wrote:
> Hi Christian,
> 
> On Wed, Jan 03, 2024 at 11:06:35AM +0100, Christian A. Ehrhardt wrote:
> > I have a DELL Latitude 5431 where typec only works somewhat.
> > After the first plug/unplug event the PPM seems to be stuck and
> > commands end with a timeout (GET_CONNECTOR_STATUS failed (-110)).
> > 
> > This patch fixes it for me but according to my reading it is in
> > violation of the UCSI spec. On the other hand searching through
> > the net it appears that many DELL models seem to have timeout problems
> > with UCSI.
> > 
> > Do we want some kind of quirk here? There does not seem to be a quirk
> > framework for this part of the code, yet. Or is it ok to just send the
> > additional ACK in all cases and hope that the PPM will do the right
> > thing?
> 
> We can use DMI quirks. Something like the attached diff (not tested).
> 
> thanks,
> 
> -- 
> heikki

> diff --git a/drivers/usb/typec/ucsi/ucsi_acpi.c b/drivers/usb/typec/ucsi/ucsi_acpi.c
> index 6bbf490ac401..7e8b1fcfa024 100644
> --- a/drivers/usb/typec/ucsi/ucsi_acpi.c
> +++ b/drivers/usb/typec/ucsi/ucsi_acpi.c
> @@ -113,18 +113,44 @@ ucsi_zenbook_read(struct ucsi *ucsi, unsigned int offset, void *val, size_t val_
>  	return 0;
>  }
>  
> -static const struct ucsi_operations ucsi_zenbook_ops = {
> -	.read = ucsi_zenbook_read,
> -	.sync_write = ucsi_acpi_sync_write,
> -	.async_write = ucsi_acpi_async_write
> -};
> +static int ucsi_dell_sync_write(struct ucsi *ucsi, unsigned int offset,
> +				const void *val, size_t val_len)
> +{
> +	u64 ctrl = *(u64 *)val;
> +	int ret;
> +
> +	ret = ucsi_acpi_sync_write(ucsi, offset, val, val_len);
> +	if (ret && (ctrl & (UCSI_ACK_CC_CI | UCSI_ACK_CONNECTOR_CHANGE))) {
> +		ctrl= UCSI_ACK_CC_CI | UCSI_ACK_COMMAND_COMPLETE;
> +
> +		dev_dbg(ucsi->dev->parent, "%s: ACK failed\n", __func__);
> +		ret = ucsi_acpi_sync_write(ucsi, UCSI_CONTROL, &ctrl, sizeof(ctrl));
> +	}

Unfortunately, this has the logic reversed. The quirk (i.e. the
additional UCSI_ACK_COMMAND_COMPLETE) is required after a _successful_
UCSI_ACK_CONNECTOR_CHANGE. Otherwise, _subsequent_ commands will timeout
(usually the next GET_CONNECTOR_CHANGE).

This means the quirk must be applied _before_ we detect any failure.
Consequently, the quirk has the potential to break working systems.

Sorry, if that wasn't clear from my original mail. Please let me know
if this changes how you want the quirks handled.

     Thanks    Christian



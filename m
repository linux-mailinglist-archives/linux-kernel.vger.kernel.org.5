Return-Path: <linux-kernel+bounces-45447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E7C558430E5
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 00:08:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A37CD28582D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 23:08:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C49B762D6;
	Tue, 30 Jan 2024 23:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QvUXX6Zx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4709E383BA;
	Tue, 30 Jan 2024 23:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706656127; cv=none; b=YlAdIW0Brwq/tebSbS+bdG2o2NpUHP1lhmykmZFjJ0IUEwhjAuyGSsTYB1DLN8/DuSPQtzCrjLvjRu0Ez2E4wg6PEDjksh3S2zNqXGQYNpbqqQJI2Op8P7bEwhExpr5ykZNWcEIoqSZHRiW/sdmEVOOcm2n7WuNs4QV8JxS8HSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706656127; c=relaxed/simple;
	bh=ZuQDweNpKH6gLGI/RyP5iCz3jdyHptIwQkI1NjhPexA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q0998wpS6D3KEOVETT78fz3HN4DD1vAW7+rxmAEE0adLYtLGRPpgqUlpMZ5Tf+NmWsN9GldTJkW2P0iHt1ufi47tGBrmsOd/fPGOZCdxIXWhhzuZHpsa7GxkyhyftfzCY/qbOTTdxj6ztx1G9ePw5R1gDVblJlr2xl2VN3tb7NE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QvUXX6Zx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B34DDC433F1;
	Tue, 30 Jan 2024 23:08:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706656126;
	bh=ZuQDweNpKH6gLGI/RyP5iCz3jdyHptIwQkI1NjhPexA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QvUXX6ZxDC+UENo5Yrq+HW6yTcoIkn5tHxkqZfvZrWNroIs366EOc66JjBuVfVbWQ
	 aZX8rg62qgwete7aAblzwe7ZKg9JIqnSgf8jpXZx/fr2GrR8WfyjIGXk/cDaF3HQFI
	 OPrvaTmjAQ6QNLt/ou5Jhq5Kt+o+dRA7ua0n8UaY=
Date: Tue, 30 Jan 2024 15:08:45 -0800
From: Greg KH <gregkh@linuxfoundation.org>
To: RD Babiera <rdbabiera@google.com>
Cc: heikki.krogerus@linux.intel.com, badhri@google.com,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v1] usb: typec: altmodes/displayport: add null pointer
 check for sysfs nodes
Message-ID: <2024013021-fetal-nifty-38d4@gregkh>
References: <20240130192638.3557409-2-rdbabiera@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240130192638.3557409-2-rdbabiera@google.com>

On Tue, Jan 30, 2024 at 07:26:39PM +0000, RD Babiera wrote:
> The DisplayPort driver's sysfs nodes may be present to the userspace before
> typec_altmode_set_drvdata() completes in dp_altmode_probe. This means that
> a sysfs read can trigger a NULL pointer error by deferencing dp->hpd in
> hpd_show or dp->lock in pin_assignment_show, as dev_get_drvdata() returns
> NULL in those cases.
> 
> Verify dp drvdata is present in sysfs reads and writes before proceeding.

Why not populate the sysfs nodes after the assigment happens?  That's
the normal way to do this, otherwise your change looks odd because:

> 
> Fixes: 0e3bb7d6894d ("usb: typec: Add driver for DisplayPort alternate mode")
> Cc: stable@vger.kernel.org
> Signed-off-by: RD Babiera <rdbabiera@google.com>
> ---
>  drivers/usb/typec/altmodes/displayport.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/drivers/usb/typec/altmodes/displayport.c b/drivers/usb/typec/altmodes/displayport.c
> index 5a80776c7255..0423326219d8 100644
> --- a/drivers/usb/typec/altmodes/displayport.c
> +++ b/drivers/usb/typec/altmodes/displayport.c
> @@ -518,6 +518,9 @@ configuration_store(struct device *dev, struct device_attribute *attr,
>  	int con;
>  	int ret = 0;
>  
> +	if (!dp)
> +		return -ENODEV;
> +
>  	con = sysfs_match_string(configurations, buf);

there's nothing keeping dp from being an invalid pointer right after you
check it.  Really that might not happen, but it's hard to tell that
here.

thanks,

greg k-h


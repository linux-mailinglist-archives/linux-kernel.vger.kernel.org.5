Return-Path: <linux-kernel+bounces-66819-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A66DF8561DB
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 12:39:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D95671C23313
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 11:39:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06C5E12AADD;
	Thu, 15 Feb 2024 11:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LaozV3M4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3136453369;
	Thu, 15 Feb 2024 11:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707997096; cv=none; b=lRLm8QMQS8UBL+fDq0J43bwX6/l1zL1/SgHWK76LeNPg6pJelY3s9j46TExm57H3zNzQs5eMvRsN1D97px8iown0ICmi2NCAR9JKhJ/S5OMDo3HGSF0Kfvj/uZGfcyhpL6yZbLqBfMW39gmF8P47BoliHNAtLmnm1KZ6OoDCnj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707997096; c=relaxed/simple;
	bh=GHH9ntFOqYLSat0txojsoaErPiI8laz9hfdGKYUor94=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ovNk9vsPNQucqC1fHKJy6MqR9rIvAwqol9vgq9eygO/RHC9ifNSDWWOohHQxalLxJdTzEy2//fOOasMhJNAjCU5xCFyFuVClr7N3xrVRFdEGGsJ/q/mdviy2zOHbt3nFNLmBIVAXWyAfejbfn0pSH0z1WCQzRXaAFDcESM7Wuzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LaozV3M4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E029FC433F1;
	Thu, 15 Feb 2024 11:38:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707997095;
	bh=GHH9ntFOqYLSat0txojsoaErPiI8laz9hfdGKYUor94=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LaozV3M4YiMgodRpBYvswUKFz6DkpGvwSHgf4E5Fubt5d2kQB+UhNqZOi9w/kYwi6
	 n1nauzXdaiHepF4M0LgzfIxns9OZNYLb6DkaNCG47b9VykIZ0zSEOm5+ZNMbodeza6
	 PxLU5KX4vzvF6NVjX3jvj9vmJ+v9IrDCSWrRjsus=
Date: Thu, 15 Feb 2024 12:38:12 +0100
From: 'Greg KH' <gregkh@linuxfoundation.org>
To: =?utf-8?B?7J207Iq57Z2s?= <sh043.lee@samsung.com>
Cc: 'Ulf Hansson' <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org, avri.altman@wdc.com,
	grant.jung@samsung.com, jt77.jang@samsung.com,
	dh0421.hwang@samsung.com, junwoo80.lee@samsung.com,
	jangsub.yi@samsung.com, cw9316.lee@samsung.com,
	sh8267.baek@samsung.com, wkon.kim@samsung.com
Subject: Re: [PATCH] mmc: sd: Add a variable to check a faulty device
Message-ID: <2024021531-speech-lifting-89f6@gregkh>
References: <CGME20240213051332epcas1p1f45d02dc34d1b95ea5608ab779d6b6cc@epcas1p1.samsung.com>
 <20240213051716.6596-1-sh043.lee@samsung.com>
 <CAPDyKFrjZ4jRHAfXsvrEvezuHTxbA3SAniF8CuObyLuW=AUoeA@mail.gmail.com>
 <000001da5faa$d34e1600$79ea4200$@samsung.com>
 <2024021528-fretted-sustainer-2ebc@gregkh>
 <000001da6000$527c8650$f77592f0$@samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <000001da6000$527c8650$f77592f0$@samsung.com>

On Thu, Feb 15, 2024 at 08:15:45PM +0900, 이승희 wrote:
> > -----Original Message-----
> > From: Greg KH <gregkh@linuxfoundation.org>
> > Sent: Thursday, February 15, 2024 5:07 PM
> > To: 이승희 <sh043.lee@samsung.com>
> > Cc: 'Ulf Hansson' <ulf.hansson@linaro.org>; linux-mmc@vger.kernel.org;
> > linux-kernel@vger.kernel.org; avri.altman@wdc.com; grant.jung@samsung.com;
> > jt77.jang@samsung.com; dh0421.hwang@samsung.com; junwoo80.lee@samsung.com;
> > jangsub.yi@samsung.com; cw9316.lee@samsung.com; sh8267.baek@samsung.com;
> > wkon.kim@samsung.com
> > Subject: Re: [PATCH] mmc: sd: Add a variable to check a faulty device

Does this really belong in the body of the email?  You might want a
nicer email client :)

> > > The variable's usage is expected to be used through the sysfs node in
> > the vendor module.
> > 
> > What "vendor module"?  You need to include all of the needed code here
> > please.
> > 
> > thanks,
> > 
> > greg k-h
> 
> This only purpose of this variable is to identify a faulty card on host side.
> 
> In the past, we can identify that the card is inserted or not with reading get_cd() function.
> But now, most mobile devices use hybrid type of SD card tray.
> If the tray is inserted, the return value of get_cd is the same whatever the SD card is inserted or not.
> It can help us diagonose the status of a SD card as well.
> 
> Here is the example of usage.
> 
> static ssize_t status_show(struct device *dev,
>                 struct device_attribute *attr, char *buf)
> {
>         struct mmc_host *host = dev_get_drvdata(dev);
>         struct mmc_card *card = host->card;
>         char *status = NULL;
> 
>         if (card)
>                 status = mmc_card_readonly(card) ? "PERMWP" : "NORMAL";
>         else
>                 status = host->init_failed ? "INITFAIL" : "NOCARD";
> 
>         return sysfs_emit(buf, "%s\n", status);
> }

What will userspace do with this information?

And why isn't this part of the patch you submitted?

> As for the sysfs node, it should keep the path of node with or without the SD card.
> That's why I mention the vendor module.

What vendor module?  What do you mean by vendor module?  You know we
can't add code to the kernel that is only used by code that is NOT in
our kernel tree.  You don't want us to take stuff like that, so why is
it being proposed here?

confused,

greg k-h


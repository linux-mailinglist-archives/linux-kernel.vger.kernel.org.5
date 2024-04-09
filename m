Return-Path: <linux-kernel+bounces-137226-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BD43689E001
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 18:07:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E8DF3B31F1E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 15:32:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76C0313B2A5;
	Tue,  9 Apr 2024 15:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OLNfYIny"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B73FD132810;
	Tue,  9 Apr 2024 15:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712676552; cv=none; b=XLQDJVt/KTLA7Q/QHWTXiRvMPdsu+Jz5s+ePUyrP0qWAP2kuk0pFJujV0TZT//s59IpvXdozOzggDC6hwUrjHwKg60DchOcnKhOrIlim6F/us9oDFD4ReA0JE6xWJTbEy4rpeZm+CK4BjgcQoDlQBpF3Q67bgl7mWzLESZA/LbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712676552; c=relaxed/simple;
	bh=Ovk2lUwjKUquZfwSJWiaIX5okILvbbqLtD2JU+sKtBU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DWiY4efN/4drZ41XveJCtpXZi+9uNlTYMfaIKGaF0dJcVTezRasdtrIlMC4DXjKtNRcBKc1/2DjujI+1Aa3+x4gsK+0MC8Ib/dPnyKjE6MaMzsly6tFUYYt9Lu9LOz2Qzw6nB/hMCW3cUAEAz/BimzM5MsA79ibHQYglhoZ3z1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=OLNfYIny; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F00B7C433B2;
	Tue,  9 Apr 2024 15:29:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712676552;
	bh=Ovk2lUwjKUquZfwSJWiaIX5okILvbbqLtD2JU+sKtBU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OLNfYInyzbhsqmRMj/3UG1QI0lozVIA4uWkNe/Hi2oZGow6UfdzOXiclixq2ehR9Y
	 qovYUtwIkplTpxtXhZFvsqFHakOxeax2VoKXgcATs1A0fEted1/KJF3AUD6BrEqlk3
	 P0hANRCvsCu+YKxyZ+c2PT6prHysJrynCz9VQg3M=
Date: Tue, 9 Apr 2024 17:29:09 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Fabio Estevam <festevam@gmail.com>
Cc: mka@chromium.org, frieder.schrempf@kontron.de,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	Fabio Estevam <festevam@denx.de>
Subject: Re: [PATCH] usb: misc: onboard_usb_hub: Disable the USB hub clock on
 failure
Message-ID: <2024040940-resume-polygraph-5800@gregkh>
References: <20240408151700.1761009-1-festevam@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240408151700.1761009-1-festevam@gmail.com>

On Mon, Apr 08, 2024 at 12:17:00PM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <festevam@denx.de>
> 
> In case regulator_bulk_enable() fails, the previously enabled USB hub
> clock should be disabled.
> 
> Fix it accordingly.
> 
> Fixes: 65e62b8a955a ("usb: misc: onboard_usb_hub: Add support for clock input")
> Signed-off-by: Fabio Estevam <festevam@denx.de>
> ---
>  drivers/usb/misc/onboard_usb_dev.c | 6 +++++-

This file is not in the tree for 6.9-rc2, can you please fix this up and
resend?

thanks,

greg k-h


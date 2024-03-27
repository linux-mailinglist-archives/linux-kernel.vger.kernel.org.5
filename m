Return-Path: <linux-kernel+bounces-120348-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 786C988D61A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 06:54:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24CEF2A6D09
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 05:54:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 519571CA9C;
	Wed, 27 Mar 2024 05:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JfDBQGop"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1928518036;
	Wed, 27 Mar 2024 05:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711518833; cv=none; b=MyS5qZohiTD2c198WOghR9rcgrrJccX4k5vCL5BTAMsu/K97IPcxGfS35vSFau+5aanULQ0IX2kuuAFC0ZsMbOm4L4In0302TU6yxvWO232GNSBCKXFGxNvEteTAT+QvCjCtgtwTNoCheIBX31H6k/ea0HeNCSKCKkdgVA0pJxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711518833; c=relaxed/simple;
	bh=jm8w/V3SRkIIXkR8cniqTifgycQ08yMrZo71mqWFRWo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BKFg3UOY+O/0eCOwM/aHHJD8x9AHfMTZcOX5etXfXZ05MWJA1qsVB/4/Oe1XCeJuvLVbzMxZojXF5Cp9+RfoxLS0Sqm1WEGVbRoU1B1wRfWsKO/EsVNWL7Z5QFaBKz6ERXuSk43agbY2F9unzJmCMVjEN0Xq1XNBr+g7O2gFW4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JfDBQGop; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DE97C433C7;
	Wed, 27 Mar 2024 05:53:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711518832;
	bh=jm8w/V3SRkIIXkR8cniqTifgycQ08yMrZo71mqWFRWo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JfDBQGop0i5Qj1l/7QiqKbUALQQMlEedhujs5sQDWjSNg3ANUNlMUYGWKJV74Og5y
	 LLyXGDqXCMz7YALV6zZ/uU96L1B0RVc9nCkirA39PVWNwhe8A8mz3S5DqscI5usDFD
	 b8aPUEmL7q70UILQhWUZfQtqGb0o4nqE7JJg2y1Q=
Date: Wed, 27 Mar 2024 06:53:49 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Norihiko Hama <Norihiko.Hama@alpsalpine.com>
Cc: stern@rowland.harvard.edu, linux-usb@vger.kernel.org,
	usb-storage@lists.one-eyed-alien.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb-storage: Optimize scan delay more precisely
Message-ID: <2024032757-surcharge-grime-d3dd@gregkh>
References: <20240327055130.43206-1-Norihiko.Hama@alpsalpine.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240327055130.43206-1-Norihiko.Hama@alpsalpine.com>

On Wed, Mar 27, 2024 at 02:51:30PM +0900, Norihiko Hama wrote:
> Current storage scan delay is reduced by the following old commit.
> 
> a4a47bc03fe5 ("Lower USB storage settling delay to something more reasonable")
> 
> It means that delay is at least 'one second', or zero with delay_use=0.
> 'one second' is still long delay especially for embedded system but
> when delay_use is set to 0 (no delay), error still observed on some USB drives.
> 
> So delay_use should not be set to 0 but 'one second' is quite long.
> 
> This patch optimizes scan delay more precisely
> to minimize delay time but not to have any problems on USB drives
> by adding module parameter 'delay_scale' of delay-time divisor.
> By default, delay time is 'one second' for backward compatibility.
> For example, it seems to be good by changing delay_scale=100,
> that is 100 millisecond delay.
> 
> Signed-off-by: Norihiko Hama <Norihiko.Hama@alpsalpine.com>
> ---
>  drivers/usb/storage/usb.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/storage/usb.c b/drivers/usb/storage/usb.c
> index 90aa9c12ffac..f4a755e364da 100644
> --- a/drivers/usb/storage/usb.c
> +++ b/drivers/usb/storage/usb.c
> @@ -70,6 +70,9 @@ MODULE_LICENSE("GPL");
>  static unsigned int delay_use = 1;
>  module_param(delay_use, uint, S_IRUGO | S_IWUSR);
>  MODULE_PARM_DESC(delay_use, "seconds to delay before using a new device");
> +static unsigned int delay_scale = MSEC_PER_SEC;
> +module_param(delay_scale, uint, 0644);
> +MODULE_PARM_DESC(delay_scale, "time scale of delay_use");

Sorry, but module parameters are from the 1990's, we will not go back to
that if at all possible as it's not easy to maintain and will not work
properly for multiple devices.

I can understand wanting something between 1 and 0 seconds, but adding
yet-another-option isn't probably the best way, sorry.

thanks,

greg k-h


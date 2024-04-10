Return-Path: <linux-kernel+bounces-138737-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 261FB89F9E5
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 16:30:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 00BB3B29075
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 14:20:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BCB315EFD6;
	Wed, 10 Apr 2024 14:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="V14ElEy3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A51915EFAE;
	Wed, 10 Apr 2024 14:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712758813; cv=none; b=pAyMVkTz9gM2Aa6Q2XvLJuMtS7flPqUxy6VQVNAQlWK3LtehYonLY9fYXzNt3f3Ac4HHzocTKqFuLQoAkhCshRv18H2RX7sAYS22UWcuKtb6uUZAYqG5EA0tl4pTKn/Z1CUEG1TQQ1YozfFOKGRupFCFsiEsbbMX+OFW339GItM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712758813; c=relaxed/simple;
	bh=aeP7or6lM7mKmoKfVa+tvVtPe1gqG6DJYSTUfqq5iCY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fKaEd96erBOSUKVk/osfjOLjh/2O6mJOhuyrsxwk81m+quqXhDsp2p+ocGVlUhBJRuGCMJjmmcFxkwRTI4Utc4Dr/ay+Hvq451fcS1hCcwFs9KhdXID5KskNdH+lSaJreCebu8T8fx13LA0y5788b1PDshnDGCKpFxBbWOrg558=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=V14ElEy3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B867CC433C7;
	Wed, 10 Apr 2024 14:20:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712758813;
	bh=aeP7or6lM7mKmoKfVa+tvVtPe1gqG6DJYSTUfqq5iCY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=V14ElEy3imRCM6wPDNr6fG76/Bjb5MyTwpjhStw/BupEwW+jkAvbrGYllvVPF7jV8
	 wq3sRO1Eqg8bqsFQ7Bv1kBP0ijgZ14Z8Yuq+4Fsu+41G67xeVc0HZcRtCWwnQCs0ux
	 5JLlSyTxvIa8EN8Xn9s4XdScI3Xlg5k0s9sjY2pk=
Date: Wed, 10 Apr 2024 16:20:10 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH v1 1/1] serial: max3100: Convert to_max3100_port() to be
 static inline
Message-ID: <2024041057-angles-flatware-b7ba@gregkh>
References: <20240410141135.1378948-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240410141135.1378948-1-andriy.shevchenko@linux.intel.com>

On Wed, Apr 10, 2024 at 05:11:35PM +0300, Andy Shevchenko wrote:
> As Jiri rightfully pointed out the current to_max3100_port() macro
> implementation is fragile in a sense that it expects the variable
> name to be port, otherwise it blow up the build.
> 
> Change this to be static inline to prevent bad compilation.

Is there a problem today?  If not, this line isn't needed, as it sounds
like you are fixing a problem here, when all you are doing is making it
"nicer", right?

> Suggested-by: Jiri Slaby <jirislaby@kernel.org>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/tty/serial/max3100.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/max3100.c b/drivers/tty/serial/max3100.c
> index 1e6b5763ce3f..07ee001640bb 100644
> --- a/drivers/tty/serial/max3100.c
> +++ b/drivers/tty/serial/max3100.c
> @@ -111,7 +111,10 @@ struct max3100_port {
>  	struct timer_list	timer;
>  };
>  
> -#define to_max3100_port(port)	container_of(port, struct max3100_port, port)
> +static inline struct max3100_port *to_max3100_port(struct uart_port *port)
> +{
> +	return container_of(port, struct max3100_port, port);

Note, the one reason you might want to do this as a #define is if you
use container_of_const() which has to be a #define.  So the fact that
this was a define to start with is normal and not really a big deal.

thanks,

greg k-h


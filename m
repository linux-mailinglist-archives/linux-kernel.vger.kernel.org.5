Return-Path: <linux-kernel+bounces-90465-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 14E9C86FF98
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 11:56:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A48DD1F24408
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 10:56:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1C25381B4;
	Mon,  4 Mar 2024 10:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b="Nei2I58y"
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 660B538DDD;
	Mon,  4 Mar 2024 10:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.134.164.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709549800; cv=none; b=XOoFiTVHrxkVkc0L8FuJhxrq/O/jxYtZpRT0qdj1yQyVie+Q8da6MGqIa7WQ+Q9qu2PpM2IZXgb0OvIrCOR7uX5Hxzaz+FHsyLoCHZOZdS/ZnGFpZUXwqXstfYamkqeD05XKSNp2kLPeW7ZRE5YMc87sI1v54NGKfNPqwxj2KTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709549800; c=relaxed/simple;
	bh=24Wt4baQz9Fe57w/o1XeNPq06hI45Sc0xGbmnFC7+Js=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=ZX8svERORf4O109Uf9qnLZ6eodhnK/x7eQy3qL4AWUtA9ZBLnGaVaD7Y3UqwH1JHqqw0IWebS6FJAFZwyTdxWWJ8f4DIkBRi8mMBW5tFfPOdaDOKBwj+ijkzJr6XqAvWmNwq0ctBqHFNmAqRtigyHBQTptWQGMB7KDSNljTIqGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr; spf=pass smtp.mailfrom=inria.fr; dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b=Nei2I58y; arc=none smtp.client-ip=192.134.164.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inria.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=AsaY1BGuEP7x4VKORfviVFJfoqV+zfnSfsG0OgmTAfI=;
  b=Nei2I58yJdspuHmu1GK0f6Tq9JvoRwbqBsa/879VDpcWRjnl1ohIflZ1
   JAJE7QuiHr5zDABDSfDqRmv64HL9qXRlcj6f7CySt9NcGQ2Hbgvs5LZE1
   FLh4ruWWA7hoZpoU3pLimakxt6kGOqgD4gzJ0DA+YVqCRnLPdrs/DETz2
   M=;
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.06,203,1705359600"; 
   d="scan'208";a="81213033"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2024 11:55:24 +0100
Date: Mon, 4 Mar 2024 11:55:23 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
To: Markus Elfring <Markus.Elfring@web.de>
cc: linux-input@vger.kernel.org, kernel-janitors@vger.kernel.org, 
    Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
    Jeff LaBundy <jeff@labundy.com>, Rob Herring <robh@kernel.org>, 
    =?ISO-8859-15?Q?Uwe_Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>, 
    LKML <linux-kernel@vger.kernel.org>, 
    Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v2] Input: iqs626a - Use scope-based resource management
 in iqs626_parse_events()
In-Reply-To: <e8a2b63f-4f9a-463b-b419-c5f673191111@web.de>
Message-ID: <b91fe21-fe2-eac8-d1ee-ea8922a08861@inria.fr>
References: <8a7607f8-d634-415e-8269-e26dcc0f9fdc@web.de> <ZeU8ENmnPj3sKxAv@nixie71> <ZeVOPSt0L1D4BxuZ@google.com> <e8a2b63f-4f9a-463b-b419-c5f673191111@web.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-544120387-1709549724=:3479"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-544120387-1709549724=:3479
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Mon, 4 Mar 2024, Markus Elfring wrote:

> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Mon, 4 Mar 2024 11:40:04 +0100
>
> Scope-based resource management became supported also for this software
> area by contributions of Jonathan Cameron on 2024-02-17.
>
> device property: Add cleanup.h based fwnode_handle_put() scope based cleanup.
> https://lore.kernel.org/r/20240217164249.921878-3-jic23@kernel.org
>
>
> * Thus use the attribute “__free(fwnode_handle)”.
>
> * Reduce the scope for the local variable “ev_node” into a for loop.
>
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>
> v2:
> An other cleanup technique was applied as requested by Dmitry Torokhov
> and Jeff LaBundy.
>
>
>  drivers/input/misc/iqs626a.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/input/misc/iqs626a.c b/drivers/input/misc/iqs626a.c
> index 0dab54d3a060..86fcb5134f45 100644
> --- a/drivers/input/misc/iqs626a.c
> +++ b/drivers/input/misc/iqs626a.c
> @@ -462,7 +462,6 @@ iqs626_parse_events(struct iqs626_private *iqs626,
>  {
>  	struct iqs626_sys_reg *sys_reg = &iqs626->sys_reg;
>  	struct i2c_client *client = iqs626->client;
> -	struct fwnode_handle *ev_node;
>  	const char *ev_name;
>  	u8 *thresh, *hyst;
>  	unsigned int val;
> @@ -501,6 +500,8 @@ iqs626_parse_events(struct iqs626_private *iqs626,
>  		if (!iqs626_channels[ch_id].events[i])
>  			continue;
>
> +		struct fwnode_handle *ev_node __free(fwnode_handle);

Doesn't this need to be initialized?

julia


> +
>  		if (ch_id == IQS626_CH_TP_2 || ch_id == IQS626_CH_TP_3) {
>  			/*
>  			 * Trackpad touch events are simply described under the
> @@ -530,7 +531,6 @@ iqs626_parse_events(struct iqs626_private *iqs626,
>  					dev_err(&client->dev,
>  						"Invalid input type: %u\n",
>  						val);
> -					fwnode_handle_put(ev_node);
>  					return -EINVAL;
>  				}
>
> @@ -545,7 +545,6 @@ iqs626_parse_events(struct iqs626_private *iqs626,
>  				dev_err(&client->dev,
>  					"Invalid %s channel hysteresis: %u\n",
>  					fwnode_get_name(ch_node), val);
> -				fwnode_handle_put(ev_node);
>  				return -EINVAL;
>  			}
>
> @@ -566,7 +565,6 @@ iqs626_parse_events(struct iqs626_private *iqs626,
>  				dev_err(&client->dev,
>  					"Invalid %s channel threshold: %u\n",
>  					fwnode_get_name(ch_node), val);
> -				fwnode_handle_put(ev_node);
>  				return -EINVAL;
>  			}
>
> @@ -575,8 +573,6 @@ iqs626_parse_events(struct iqs626_private *iqs626,
>  			else
>  				*(thresh + iqs626_events[i].th_offs) = val;
>  		}
> -
> -		fwnode_handle_put(ev_node);
>  	}
>
>  	return 0;
> --
> 2.44.0
>
>
>
--8323329-544120387-1709549724=:3479--


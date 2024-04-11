Return-Path: <linux-kernel+bounces-140422-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BCFA8A143F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 14:18:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0B4B0B23327
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 12:18:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3756814B09C;
	Thu, 11 Apr 2024 12:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Up2S5vyT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EB7413FD66;
	Thu, 11 Apr 2024 12:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712837875; cv=none; b=fV2CC96ADniB8us5yhEZetyeBWEQleKq8hwsVs1VCK5Ow+HsaqMwySUpJXnOMKerejdo7lvR9NG4jMtMrwWwA5Mt9CqZIfnu+5TmqpixAfS1Va9PxVQsYKXEZNosl19Y6XuO50ZKKJr0mSwQtUzmjyHvFzrZuoqkRGOcshDZEU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712837875; c=relaxed/simple;
	bh=CJIv4oRxOBKnXrHgsXENyaWyrZKNluxWnSAwnqjAx78=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AfQiAUiKjCxVtACVcrQWHblOBWMCMj0e4P1XbnClx340ADZp9+Lk3CEsfGT4c8Qe1HlqJb/qkfsxN7tLNAvYcx0gs2xGUURycrPn1gNDDrwLOb+Z02DaFEdmJTOIZ/HCcm0hTl/19qFJTJacog+C7AQ7sWT4EwsmBn6ia0A/8As=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Up2S5vyT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A113EC433F1;
	Thu, 11 Apr 2024 12:17:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712837875;
	bh=CJIv4oRxOBKnXrHgsXENyaWyrZKNluxWnSAwnqjAx78=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Up2S5vyTujpP/gwFJ2aTXbKNJ9q0SXzXNkFbNMVI7SFBN7lCjDVAtmWsRROZeWLra
	 Rp7D8IlQ06CeJev8NhLtz4BKP87aSzYAcgTZPkDZBVsh3aMv/R/iW7OISITjuS+eBN
	 8Ara3bMcTMTAj7c7K5EaQmYGXUKuBbayWXVZ9IP8=
Date: Thu, 11 Apr 2024 14:17:52 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: R SUNDAR <prosunofficial@gmail.com>
Cc: heikki.krogerus@linux.intel.com, dmitry.baryshkov@linaro.org,
	neil.armstrong@linaro.org, christophe.jaillet@wanadoo.fr,
	u.kleine-koenig@pengutronix.de, skhan@linuxfoundation.org,
	javier.carrasco.cruz@gmail.com, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, Julia Lawall <julia.lawall@inria.fr>
Subject: Re: [PATCH] usb: typec: mux: replace of_node_put() with __free
 [linux-next]
Message-ID: <2024041103-doornail-professor-7c1e@gregkh>
References: <20240410165222.5192-1-prosunofficial@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240410165222.5192-1-prosunofficial@gmail.com>

On Wed, Apr 10, 2024 at 10:22:22PM +0530, R SUNDAR wrote:
> use the new cleanup magic to replace of_node_put() with
> __free(device_node) marking to auto release and to simplify the error
> paths.
> 
> Suggested-by: Julia Lawall <julia.lawall@inria.fr>
> Signed-off-by: R SUNDAR <prosunofficial@gmail.com>

All CAPS for your name?  Is that how it is written on documents (for
some countries this is normal, but usually not, so I have to ask.)

> ---
>  drivers/usb/typec/mux/nb7vpq904m.c | 25 ++++++++-----------------
>  1 file changed, 8 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/usb/typec/mux/nb7vpq904m.c b/drivers/usb/typec/mux/nb7vpq904m.c
> index b17826713753..72ec9ef3ac58 100644
> --- a/drivers/usb/typec/mux/nb7vpq904m.c
> +++ b/drivers/usb/typec/mux/nb7vpq904m.c
> @@ -315,29 +315,27 @@ static const int supported_data_lane_mapping[][DATA_LANES_COUNT] = {
>  
>  static int nb7vpq904m_parse_data_lanes_mapping(struct nb7vpq904m *nb7)
>  {
> -	struct device_node *ep;
>  	u32 data_lanes[4];
>  	int ret, i, j;
> -
> -	ep = of_graph_get_endpoint_by_regs(nb7->client->dev.of_node, 1, 0);
> +	struct device_node *ep __free(device_node) =

This use of __free() for device_node would be the first one in the tree
(outside of a macro in a .h file.)  Is this really what the OF
maintainer wants to have happen here for this type of pattern?

And if so, why this random USB driver being the first one?  Have you
tested this?


> +		of_graph_get_endpoint_by_regs(nb7->client->dev.of_node, 1, 0);
>  
>  	if (ep) {

Nit, this function should be rewritten to not work like this, the
"common" path should not be indented, but only the exception (i.e. bail
if ep is not allocated properly.)

thanks,

greg k-h


Return-Path: <linux-kernel+bounces-52026-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 794018492FE
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 05:43:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACD0E1C21223
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 04:43:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B165B645;
	Mon,  5 Feb 2024 04:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cFoaRlo1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46AFBAD35;
	Mon,  5 Feb 2024 04:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707108191; cv=none; b=Z3mUgsmO6EvKu2IVw3wCH0QkM+2aLrq92xRMHiObW8hKJQ9Nj/gPuVe5raJEoyVqFVtbMTzFcwd5rm9MUr68bKX/Zybaor7pipUEcspLpMuHdrnliNkqQSr25+HEDYLpv3YDgI/vYKblYfGWtSNv1kqOeRym6BWwFGd8mcQXkII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707108191; c=relaxed/simple;
	bh=RazI1DUzXrPjybeXX8DdkT1uiCDNG+C8ylGopmTebKk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FCZ0Pv9/xrAZj5K5btOj2BhR6mgUBPfbmxsCsoX6muLreZHnnH4nZVOWADPRinOHeP7N6IaZAYT/rcY5sey/FMI0Dp06OilwVZzxewwwKkbQNDXIyu4gvhFuzKT1y8tZGoUm63lLQ5Lkd+tXjXL1aYwx1CxUH4Wvst9oAkBXIPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cFoaRlo1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CC1FC433C7;
	Mon,  5 Feb 2024 04:43:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707108190;
	bh=RazI1DUzXrPjybeXX8DdkT1uiCDNG+C8ylGopmTebKk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cFoaRlo1JzPeUewJM1lz8X+vuOgB84K/ZlRuV1/+ocDyDxGnj33JJj8+KRacsr37/
	 K3Kea32+/lvE0xo+mfooBPR6UePCIQs/rlxSOwt5d7Jrn4i28BPJDMrzVJbmA49ZpK
	 rwPjmLADwmUj/3FY55VEq+uWF78xQBYpu7JsJvI858B+Z5mcnQl3Ggh26zXMSJqCYy
	 5Ftf4uLhYjUwpIOxAn+K0wMZbQw3ncIXWRGtdkgQSy3cOTQNa/4IxAAiEeAQ34FzkE
	 XZCunPqbatmsjWicgrdbQgHu5cPHn5pwRPp0rVJ/6w/p4Urq8Sy2dw/BnK5JXLRWbT
	 ai2maeCvL58UA==
Date: Mon, 5 Feb 2024 12:43:00 +0800
From: Peter Chen <peter.chen@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: rogerq@kernel.org, felipe.balbi@linux.intel.com,
	gregkh@linuxfoundation.org, imx@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
	pawell@cadence.com
Subject: Re: [PATCH v2 1/2] usb: cdns3: fixed memory use after free at
 cdns3_gadget_ep_disable()
Message-ID: <20240205044300.GC1200221@nchen-desktop>
References: <20240202154217.661867-1-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240202154217.661867-1-Frank.Li@nxp.com>

On 24-02-02 10:42:16, Frank Li wrote:
>   ...
>   cdns3_gadget_ep_free_request(&priv_ep->endpoint, &priv_req->request);
>   list_del_init(&priv_req->list);
>   ...
> 
> 'priv_req' actually free at cdns3_gadget_ep_free_request(). But
> list_del_init() use priv_req->list after it.
> 
> [ 1542.642868][  T534] BUG: KFENCE: use-after-free read in __list_del_entry_valid+0x10/0xd4
> [ 1542.642868][  T534]
> [ 1542.653162][  T534] Use-after-free read at 0x000000009ed0ba99 (in kfence-#3):
> [ 1542.660311][  T534]  __list_del_entry_valid+0x10/0xd4
> [ 1542.665375][  T534]  cdns3_gadget_ep_disable+0x1f8/0x388 [cdns3]
> [ 1542.671571][  T534]  usb_ep_disable+0x44/0xe4
> [ 1542.675948][  T534]  ffs_func_eps_disable+0x64/0xc8
> [ 1542.680839][  T534]  ffs_func_set_alt+0x74/0x368
> [ 1542.685478][  T534]  ffs_func_disable+0x18/0x28
> 
> Move list_del_init() before cdns3_gadget_ep_free_request() to resolve this
> problem.
> 
> Cc: <stable@vger.kernel.org>
> Fixes: 7733f6c32e36 ("usb: cdns3: Add Cadence USB3 DRD Driver")
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> Reviewed-by: Roger Quadros <rogerq@kernel.org>

Acked-by: Peter Chen <peter.chen@kernel.org>

> ---
>  drivers/usb/cdns3/cdns3-gadget.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/cdns3/cdns3-gadget.c b/drivers/usb/cdns3/cdns3-gadget.c
> index aeca902ab6cc4..d6723d31fc6e2 100644
> --- a/drivers/usb/cdns3/cdns3-gadget.c
> +++ b/drivers/usb/cdns3/cdns3-gadget.c
> @@ -2540,11 +2540,11 @@ static int cdns3_gadget_ep_disable(struct usb_ep *ep)
>  
>  	while (!list_empty(&priv_ep->wa2_descmiss_req_list)) {
>  		priv_req = cdns3_next_priv_request(&priv_ep->wa2_descmiss_req_list);
> +		list_del_init(&priv_req->list);
>  
>  		kfree(priv_req->request.buf);
>  		cdns3_gadget_ep_free_request(&priv_ep->endpoint,
>  					     &priv_req->request);
> -		list_del_init(&priv_req->list);
>  		--priv_ep->wa2_counter;
>  	}
>  
> -- 
> 2.34.1
> 

-- 

Thanks,
Peter Chen


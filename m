Return-Path: <linux-kernel+bounces-118693-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CF50888BE1D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 10:42:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3355B1F62CE8
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 09:42:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BC178665B;
	Tue, 26 Mar 2024 09:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XSho6UBJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFA8A44393;
	Tue, 26 Mar 2024 09:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711445803; cv=none; b=ZGEiowBSBMgTHcSUMXuqjZGvLqLcGsw6OZ7gJe5dHoMkeI46vvmQhTJWjZKasNwNnpnsb5Enwxic16eUbDjn4/gQoktwu2BDgZlgWa4H1QoHxEQeBzICpS//08XQfDvqWl/eWKALrVFibR6twyyQeZ+HZ4H2hQ+7GcelT5RW04k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711445803; c=relaxed/simple;
	bh=bUSotWxJh0g3WPBp7fnN4CIuL+eIbn21aAkgwOWp/Y0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WpbJsNT1+yurtwSH9N6/E84MhU+e08sKBphv+UFOkpDhxpMG6VOr74a7STK0B6wk2n5URGpzXXqZTWyf83ZE/8WtfDhLcOm3i5FAdGYSoEtjCv3QKHiQiSXkS0KNQ4Y85IU+zc6NFdSSmGqhIFLGRkM1PYBrkZ+C+sM05HxBO0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XSho6UBJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD3B0C43390;
	Tue, 26 Mar 2024 09:36:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711445803;
	bh=bUSotWxJh0g3WPBp7fnN4CIuL+eIbn21aAkgwOWp/Y0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XSho6UBJdX0LbqGaq0TZGNX6OiSvXoXgTs/JZBWDK93ssuiYxJJcInEqEKBtrqxIu
	 sBqtNPhQpymGmVZLyY29ldGb4hEoiMhPjjsgvKXQ6abDQzfR2MzVnSdRv756ztAWBt
	 OOUgjq8fjignsRkSO1IiLDCGROIUVHk6ZWFtAJD8=
Date: Tue, 26 Mar 2024 10:36:40 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Norihiko Hama <Norihiko.Hama@alpsalpine.com>
Cc: balbi@kernel.org, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: gadget: f_ncm: Fix UAF ncm object at re-bind after
 usb ep transport error
Message-ID: <2024032629-frolic-obtain-ad55@gregkh>
References: <20240325094543.5362-1-Norihiko.Hama@alpsalpine.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240325094543.5362-1-Norihiko.Hama@alpsalpine.com>

On Mon, Mar 25, 2024 at 06:45:43PM +0900, Norihiko Hama wrote:
> When ncm function is working and then stop usb0 interface for link down,
> eth_stop() is called. At this piont, accidentally if usb transport error
> should happen in usb_ep_enable(), 'in_ep' and/or 'out_ep' may not be enabled.
> 
> After that, ncm_disable() is called to disable for ncm unbind
> but gether_disconnect() is never called since 'in_ep' is not enabled.
> 
> As the result, ncm object is released in ncm unbind
> but 'dev->port_usb' associated to 'ncm->port' is not NULL.
> 
> And when ncm bind again to recover netdev, ncm object is reallocated
> but usb0 interface is already associated to previous released ncm object.
> 
> Therefore, once usb0 interface is up and eth_start_xmit() is called,
> released ncm object is dereferrenced and it might cause use-after-free memory.
> 
> [function unlink via configfs]
> usb0: eth_stop dev->port_usb=ffffff9b179c3200
> --> error happens in usb_ep_enable().
> NCM: ncm_disable: ncm=ffffff9b179c3200
> --> no gether_disconnect() since ncm->port.in_ep->enabled is false.
> NCM: ncm_unbind: ncm unbind ncm=ffffff9b179c3200
> NCM: ncm_free: ncm free ncm=ffffff9b179c3200   <-- released ncm
> 
> [function link via configfs]
> NCM: ncm_alloc: ncm alloc ncm=ffffff9ac4f8a000
> NCM: ncm_bind: ncm bind ncm=ffffff9ac4f8a000
> NCM: ncm_set_alt: ncm=ffffff9ac4f8a000 alt=0
> usb0: eth_open dev->port_usb=ffffff9b179c3200  <-- previous released ncm
> usb0: eth_start dev->port_usb=ffffff9b179c3200 <--
> 
> Unable to handle kernel paging request at virtual address dead00000000014f
> 
> This patch addresses the issue by checking if 'ncm->netdev' is not NULL at
> ncm_disable() to call gether_disconnect() to deassociate 'dev->port_usb'.
> It's more reasonable to check 'ncm->netdev' to call gether_connect/disconnect
> rather than check 'ncm->port.in_ep->enabled' since it might not be enabled
> but the gether connection might be established.
> 
> Signed-off-by: Norihiko Hama <Norihiko.Hama@alpsalpine.com>
> ---
>  drivers/usb/gadget/function/f_ncm.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/gadget/function/f_ncm.c b/drivers/usb/gadget/function/f_ncm.c
> index bd095ae569ed..23960cd16463 100644
> --- a/drivers/usb/gadget/function/f_ncm.c
> +++ b/drivers/usb/gadget/function/f_ncm.c
> @@ -888,7 +888,7 @@ static int ncm_set_alt(struct usb_function *f, unsigned intf, unsigned alt)
>  		if (alt > 1)
>  			goto fail;
>  
> -		if (ncm->port.in_ep->enabled) {
> +		if (ncm->netdev) {
>  			DBG(cdev, "reset ncm\n");
>  			ncm->netdev = NULL;
>  			gether_disconnect(&ncm->port);
> @@ -1365,7 +1365,7 @@ static void ncm_disable(struct usb_function *f)
>  
>  	DBG(cdev, "ncm deactivated\n");
>  
> -	if (ncm->port.in_ep->enabled) {
> +	if (ncm->netdev) {
>  		ncm->netdev = NULL;
>  		gether_disconnect(&ncm->port);
>  	}
> -- 
> 2.17.1
> 

What commit id does this change fix?

thanks,

greg k-h


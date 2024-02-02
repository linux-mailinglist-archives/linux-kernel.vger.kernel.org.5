Return-Path: <linux-kernel+bounces-49781-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37DD2846F53
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 12:46:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 86BA0B2D07C
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 11:45:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD31913E22A;
	Fri,  2 Feb 2024 11:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ctT7EKOE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F19AF1386C0;
	Fri,  2 Feb 2024 11:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706874129; cv=none; b=BvPCuASpF1vAH88+FzPZe53mp4xLKd1LgE8GCgwCpvJlBTA6V/zTGzUbMv76/3Z/yDCq5aagXyFIMjK9meTVakFWaaL7R4V4GnRjR0BzIM0Q1sv79CrNSzh7edadMiZd+UMqmtZn32NXlN0bqMAWXF22D/vt+sNNhMnGJ30RSdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706874129; c=relaxed/simple;
	bh=ipIq/9Sdl32FU9KpYVyKP01VDNrIW6SGHhtprIgqsEo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ibc7D2uZl7aHpfXNilmk4CFmf6UAued77mb1mAYemKb7YisJ2DLwyPV0cEB4+JrHRfzQeIdag/8muTEJ9QtlC56o2WVUEJ9/+CY4BpyE1EhMQKfWsdwSLtEzZ0j6n28DGVog2WCKoA0cidtp9JTbaAI0umE34AH6kI4JXqu5u7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ctT7EKOE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56D43C433F1;
	Fri,  2 Feb 2024 11:42:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706874128;
	bh=ipIq/9Sdl32FU9KpYVyKP01VDNrIW6SGHhtprIgqsEo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ctT7EKOEMg1nl41CFM5Gc2kOvf3qcxf6XtlItksRthxndXzOEQRmmReHCbajuKM4N
	 F1aA5YTXeU7zB1XdJZRqr1LoyFlVpPHSXA11q6QWG3RXKLGCJI+xQnJTbPjYPlY9fk
	 dOgfNqpW+iPgY702CwmOIaPUjXwh2g+eyRABYHaAIhSvIh/oAyJsHnMUutJ5IDS7Fh
	 O7DuMLdDphvWlFLMOkc7LxvUnUegk/SlzKrDB2RoxQRXUj7chmKh5RoRvost7Us0M9
	 caewRdsz6uhfoMEsribDI2iO3MjsmeG6R9JweIY6OgAcC63aLkDPsfytHr5BSAUtha
	 lNKPMVMwiwmzg==
Message-ID: <b81a5ec5-4f71-4926-bd0e-0300477b721b@kernel.org>
Date: Fri, 2 Feb 2024 13:42:05 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] usb: cdns3: fix memory double free when handle zero
 package
Content-Language: en-US
To: Frank Li <Frank.Li@nxp.com>, Peter Chen <peter.chen@kernel.org>,
 Pawel Laszczak <pawell@cadence.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Felipe Balbi <felipe.balbi@linux.intel.com>,
 "open list:CADENCE USB3 DRD IP DRIVER" <linux-usb@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>
Cc: imx@lists.linux.dev
References: <20240202051829.623273-1-Frank.Li@nxp.com>
 <20240202051829.623273-2-Frank.Li@nxp.com>
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20240202051829.623273-2-Frank.Li@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hello Frank,

On 02/02/2024 07:18, Frank Li wrote:
> 829  if (request->complete) {
> 830          spin_unlock(&priv_dev->lock);
> 831          usb_gadget_giveback_request(&priv_ep->endpoint,
> 832                                    request);
> 833          spin_lock(&priv_dev->lock);
> 834  }
> 835
> 836  if (request->buf == priv_dev->zlp_buf)
> 837      cdns3_gadget_ep_free_request(&priv_ep->endpoint, request);
> 
> Driver append an additional zero package request when queue a package,
> which length mod max package size is 0. When transfer complete, run to
> line 831, usb_gadget_giveback_request() will free this requestion. 836
> condition is true, so cdns3_gadget_ep_free_request() free this request
> again.

Please replace "package" with "packet" in subject and description.

> 
> Log:
> 
> [ 1920.140696][  T150] BUG: KFENCE: use-after-free read in cdns3_gadget_giveback+0x134/0x2c0 [cdns3]
> [ 1920.140696][  T150]
> [ 1920.151837][  T150] Use-after-free read at 0x000000003d1cd10b (in kfence-#36):
> [ 1920.159082][  T150]  cdns3_gadget_giveback+0x134/0x2c0 [cdns3]
> [ 1920.164988][  T150]  cdns3_transfer_completed+0x438/0x5f8 [cdns3]
> 
> Add check at line 829, skip call usb_gadget_giveback_request() if it is
> additional zero length package request. Needn't call
> usb_gadget_giveback_request() because it is allocated in this driver.
> 
> Cc: <stable@vger.kernel.org>
> Fixes: 7733f6c32e36 ("usb: cdns3: Add Cadence USB3 DRD Driver")
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  drivers/usb/cdns3/cdns3-gadget.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/cdns3/cdns3-gadget.c b/drivers/usb/cdns3/cdns3-gadget.c
> index d6723d31fc6e2..fd1beb10bba72 100644
> --- a/drivers/usb/cdns3/cdns3-gadget.c
> +++ b/drivers/usb/cdns3/cdns3-gadget.c
> @@ -828,7 +828,11 @@ void cdns3_gadget_giveback(struct cdns3_endpoint *priv_ep,
>  			return;
>  	}
>  
> -	if (request->complete) {
> +	/*
> +	 * zlp request is appended by driver, needn't call usb_gadget_giveback_request() to notify
> +	 * gadget composite driver.
> +	 */
> +	if (request->complete && request->buf != priv_dev->zlp_buf) {
>  		spin_unlock(&priv_dev->lock);
>  		usb_gadget_giveback_request(&priv_ep->endpoint,
>  					    request);

-- 
cheers,
-roger


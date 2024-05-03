Return-Path: <linux-kernel+bounces-167706-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B46F88BADBC
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 15:30:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFB4F1C22885
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 13:30:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02B26153BD4;
	Fri,  3 May 2024 13:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QvhTzU7m"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B96215383F;
	Fri,  3 May 2024 13:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714743043; cv=none; b=b58mU+XymrKywELvCAZr0Wngn4K9lMvxnaSA7drSgx9P6AyKRxTYMTA86MrekvlPnBL8OP3/DyAl2rIc/wy0Omfbu9veK1+F+rN0Al7kUrsofatU7Ne5xT8BvUmL0abVWs4nvQxe0d7krp2j4QJXdTr+i4ueUQd94bE2mQMcJFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714743043; c=relaxed/simple;
	bh=A7dzyePxuFRV9t0HZbbsE57jhBBAmttYWYl3rdnPMI0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TBewXaK6+olItUvngghHSnfi2nA/nilDF42Ve/KNCWwmGsgTlTghGBPLjjrSQ7XjRfLZCF52Z66VKwjFTQPe1Dfki27wzPwY+bBzljsrP3nn1Np5nXqlZc9ZfiRyCMaeeDkQ4wrwiB6ughIAr5H+sVrCmNnf0zUFs1jWK5r6W+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QvhTzU7m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 240C3C2BBFC;
	Fri,  3 May 2024 13:30:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1714743042;
	bh=A7dzyePxuFRV9t0HZbbsE57jhBBAmttYWYl3rdnPMI0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QvhTzU7m/riWYaloVcIJAcV7kqeW6FBOCokBVjYbFqDfHlSfpX8XWqq/Qv8ywnD/n
	 0wyeYej37U/WtHfT0tXtrJ7rv2+6PJ73GqYWp4dJ/TNOa5jTmrxDMvWu2VdHAW7T1+
	 cSy6KJS8K+7W9i288JHBMXHbJDBMdZyC2qz1GiMY=
Date: Fri, 3 May 2024 15:30:36 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Lu Dai <dai.lu@exordes.com>
Cc: npiggin@gmail.com, christophe.leroy@csgroup.eu,
	naveen.n.rao@linux.ibm.com, mpe@ellerman.id.au,
	jirislaby@kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	javier.carrasco.cruz@gmail.com, shuah@kernel.org
Subject: Re: [PATCH] tty: hvc: hvc_opal: eliminate uses of of_node_put()
Message-ID: <2024050313-lustrous-handcraft-0b84@gregkh>
References: <20240503114330.221764-1-dai.lu@exordes.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240503114330.221764-1-dai.lu@exordes.com>

On Fri, May 03, 2024 at 02:43:30PM +0300, Lu Dai wrote:
> Make use of the __free() cleanup handler to automatically free nodes
> when they get out of scope.
> 
> Removes the need for a 'goto' as an effect.
> 
> Signed-off-by: Lu Dai <dai.lu@exordes.com>
> ---
>  drivers/tty/hvc/hvc_opal.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/tty/hvc/hvc_opal.c b/drivers/tty/hvc/hvc_opal.c
> index 095c33ad10f8..67e90fa993a3 100644
> --- a/drivers/tty/hvc/hvc_opal.c
> +++ b/drivers/tty/hvc/hvc_opal.c
> @@ -327,14 +327,14 @@ static void udbg_init_opal_common(void)
>  
>  void __init hvc_opal_init_early(void)
>  {
> -	struct device_node *stdout_node = of_node_get(of_stdout);
> +	struct device_node *stdout_node __free(device_node) = of_node_get(of_stdout);
>  	const __be32 *termno;
>  	const struct hv_ops *ops;
>  	u32 index;
>  
>  	/* If the console wasn't in /chosen, try /ibm,opal */
>  	if (!stdout_node) {
> -		struct device_node *opal, *np;
> +		struct device_node *opal __free(device_node), *np;

*np needs to be on a separate line, right?

thanks,

greg k-h


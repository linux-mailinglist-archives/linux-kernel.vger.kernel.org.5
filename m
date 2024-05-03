Return-Path: <linux-kernel+bounces-167738-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CB3A98BAE4A
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 15:58:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0F7B7B20AA4
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 13:58:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6836E15445B;
	Fri,  3 May 2024 13:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="eriCLFAj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A557E154438;
	Fri,  3 May 2024 13:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714744707; cv=none; b=Yck0MUsahEOlOLUUHsBUiZPsiB/2K0KtWi7aAkCpSgQL6FdjjcTapQXb7aGpgRHJlEljgAM8Ipns1WyjcNowvn8vwzfE2w9quRRlJYH5inP2Vxq7ph7m+sHNDPshPipaN1BWWEgf5H7RTiR7uBhuJY5+AjzFzVEdc04qQ/kHqi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714744707; c=relaxed/simple;
	bh=WzFfg1kS46JwrrD3AsGCRdBrv1G5fLFP0RllVqgXFlM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f51Zhfv83FMj76yKcxSvNiETEvAtPKBvEVo2zndPWKiXDAClbiMi2PJiCgsrA6aDjLl1e6xBUaPOM85PfV7arFiFwcGonV2RNAWl2Y9ipiC4gfQJPKky4DNswLuVqkUPBW5kT0WnKLk+AF0WmxGklPNGJnsHKLRS7wG1Qc6vcOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=eriCLFAj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46BC3C4AF1B;
	Fri,  3 May 2024 13:58:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1714744707;
	bh=WzFfg1kS46JwrrD3AsGCRdBrv1G5fLFP0RllVqgXFlM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eriCLFAjR4CU2Svcvv4rN6thMNhl7a2QivV4+KPGR50VeBL8O5vN9DJaExXnA4Sd+
	 PZD4Agdo8PPydio2BbPnFXaVCjVEd6Yjb3FkDObKRoUUpiswSFaQJTTh5u0FyabXiN
	 vLHwmdBwaS0nXuTC9rkaJGaFv6Esmh8Ajfqfu0r4=
Date: Fri, 3 May 2024 15:58:13 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Lu Dai <dai.lu@exordes.com>
Cc: npiggin@gmail.com, christophe.leroy@csgroup.eu,
	naveen.n.rao@linux.ibm.com, mpe@ellerman.id.au,
	jirislaby@kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	javier.carrasco.cruz@gmail.com, shuah@kernel.org,
	julia.lawall@inria.fr
Subject: Re: [PATCH V2] tty: hvc: hvc_opal: eliminate uses of of_node_put()
Message-ID: <2024050323-rhyme-upchuck-4c4c@gregkh>
References: <20240503135215.252635-1-dai.lu@exordes.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240503135215.252635-1-dai.lu@exordes.com>

On Fri, May 03, 2024 at 04:52:15PM +0300, Lu Dai wrote:
> Make use of the __free() cleanup handler to automatically free nodes
> when they get out of scope.
> 
> Remove the need for a 'goto' as an effect.
> 
> Signed-off-by: Lu Dai <dai.lu@exordes.com>
> ---
> Changes since v1:
> Move the assignment of 'opal' to its declaration
> Seperate the declaration of 'np'
> 
>  drivers/tty/hvc/hvc_opal.c | 13 +++++--------
>  1 file changed, 5 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/tty/hvc/hvc_opal.c b/drivers/tty/hvc/hvc_opal.c
> index 095c33ad10f8..c17e8343ea60 100644
> --- a/drivers/tty/hvc/hvc_opal.c
> +++ b/drivers/tty/hvc/hvc_opal.c
> @@ -327,19 +327,18 @@ static void udbg_init_opal_common(void)
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
> -
>  		/* Current OPAL takeover doesn't provide the stdout
>  		 * path, so we hard wire it
>  		 */
> -		opal = of_find_node_by_path("/ibm,opal/consoles");
> +		struct device_node *opal __free(device_node) =
> +			of_find_node_by_path("/ibm,opal/consoles");
>  		if (opal) {

No blank line?

>  			pr_devel("hvc_opal: Found consoles in new location\n");
>  		} else {
> @@ -350,13 +349,13 @@ void __init hvc_opal_init_early(void)
>  		}
>  		if (!opal)
>  			return;
> +		struct device_node *np;
>  		for_each_child_of_node(opal, np) {

Ick, no, don't do that please.  Take some time and become more familiar
with kernel coding style and issues, perhaps work in drivers/staging/
first, before attempting to do stuff like this that is not correct.

thanks,

greg k-h


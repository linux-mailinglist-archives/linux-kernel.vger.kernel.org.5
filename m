Return-Path: <linux-kernel+bounces-42381-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B25584008E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 09:46:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E71B1C221BC
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 08:46:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE3F954BD4;
	Mon, 29 Jan 2024 08:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JaW41u9q"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 193DB524D5;
	Mon, 29 Jan 2024 08:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706517957; cv=none; b=kiJoudats0yP6NU6ElMDPVwLQzz60svKN1MMxfRhNvNOS1t4MN1JkFDquZNeqIoVPpZK5IBVEMQ8WrGStjS0OrxgKF97G/WtrJWK+p8RP5NGiwIs+KIZTJtDvf1pI4oHQftfpfp+PVruBJb5pRTVIwl5ExQqCWbPa54HFrosTew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706517957; c=relaxed/simple;
	bh=h+w67Av4j/ZtT+FxipGw15DHMifwDMi67xcC7YTpOW4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A/tFhlMGkQ7bp+fZ/T3g7QswckeWIpCU3Zfg/yzD7Xxwyv+j059XWGlh28BmnKDwVM4LEuYuUEXnutc/DTq/ol2SpbXQnKbqZbFwMm3Ym8Ts9pShDxR0P3Ivk7xGshH+XW4bKPOct/ixoa01zGsuSMSciR6nIf1qbZMSRaCEZn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JaW41u9q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F08EBC433F1;
	Mon, 29 Jan 2024 08:45:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706517956;
	bh=h+w67Av4j/ZtT+FxipGw15DHMifwDMi67xcC7YTpOW4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JaW41u9q07rH9eLkLikVQ03Zi2vIlErkRPCy26x/LqPtHUw3clevjCrngCsngOnIa
	 5GA9xPvgWjjwP9g110+WAM6mGjJiY6rHTuAH/tBaf65VkKsR6P5FM4N9mohyvJs1EP
	 Wu0jzL7St53u0V+mxvSwBvnMZVMb0pPKidIpwARr66BAoDilG+A2ogtZWjv1nhyoqD
	 Vb8KE4l3o4BdzL5UaLKMJ1iDVUX0TBXbECCf6keFcP6eU0Xpj+3SJQYyUN5kFRv/AI
	 fgBkOsUW8Vdp9ThjMc81YMKT2lX3hQ1YICJqFmwh1CVzvLBwbjA5cGO8OiYE8EhTyP
	 6I8opYtF3UM0g==
Date: Mon, 29 Jan 2024 09:45:52 +0100
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
To: Marc Zyngier <maz@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Thomas Gleixner <tglx@linutronix.de>, yuzenghui@huawei.com,
	stable@vger.kernel.org
Subject: Re: [PATCH] irqchip/gic-v3-its: Restore quirk probing for ACPI-based
 systems
Message-ID: <ZbdlwKow22QNkWS/@lpieralisi>
References: <20240127110702.4068488-1-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240127110702.4068488-1-maz@kernel.org>

On Sat, Jan 27, 2024 at 11:07:02AM +0000, Marc Zyngier wrote:
> While refactoring the way the ITSs are probed, the handling of
> quirks applicable to ACPI-based platforms was lost. As a result,
> systems such as HIP07 lose their GICv4 functionnality, and some

Just noticed: s/functionnality/functionality

> other may even fail to boot, unless they are configured to boot
> with DT.
> 
> Move the enabling of quirks into its_probe_one(), making it
> common to all firmware implementations.
> 
> Fixes: 9585a495ac93 ("irqchip/gic-v3-its: Split allocation from initialisation of its_node")
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> Cc: stable@vger.kernel.org
> ---
>  drivers/irqchip/irq-gic-v3-its.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

I obviously tested it with ACPI with platforms not neededing
its quirks, apologies.

Reviewed-by: Lorenzo Pieralisi <lpieralisi@kernel.org>

> diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
> index fec1b58470df..250b4562f308 100644
> --- a/drivers/irqchip/irq-gic-v3-its.c
> +++ b/drivers/irqchip/irq-gic-v3-its.c
> @@ -5091,6 +5091,8 @@ static int __init its_probe_one(struct its_node *its)
>  	u32 ctlr;
>  	int err;
>  
> +	its_enable_quirks(its);
> +
>  	if (is_v4(its)) {
>  		if (!(its->typer & GITS_TYPER_VMOVP)) {
>  			err = its_compute_its_list_map(its);
> @@ -5442,7 +5444,6 @@ static int __init its_of_probe(struct device_node *node)
>  		if (!its)
>  			return -ENOMEM;
>  
> -		its_enable_quirks(its);
>  		err = its_probe_one(its);
>  		if (err)  {
>  			its_node_destroy(its);
> -- 
> 2.39.2
> 


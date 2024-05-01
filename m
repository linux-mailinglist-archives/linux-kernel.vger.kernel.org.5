Return-Path: <linux-kernel+bounces-165206-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F113B8B897E
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 13:56:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2DBD21C216CE
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 11:56:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85CA082498;
	Wed,  1 May 2024 11:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b="tXgRllry"
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BC617C082
	for <linux-kernel@vger.kernel.org>; Wed,  1 May 2024 11:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.134.164.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714564568; cv=none; b=j8K86Jg/gg4yAISJC5w2gvIJUs5sesJ973p5cO6ZXaGIsb4hiJNZrVMG65TL/zJ/GDdOTyiih3PAGgcqZGfTDTHETKkpyUxZhh2L+1XlZfYZmpbEmHMTUOnhjiZGINnCRyT2chhHGtofg+J8H2eTvkz/UIa55x6dHYr/VIOj99E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714564568; c=relaxed/simple;
	bh=cKNzn1s8a9SYJT2nlDlwGGXNLaZCx/FBbDmlKkWkTPQ=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=pj/7K+n4Ara3OyIf/pThNgh/7Art9FXoZ+p5Q2dIO4ZUJwTyY9W89dQX88sTCLjHi+rD5HZCfRRhSTFwLE/en2d5IGx9kQN6asiSjSMvXFLnqfZE1i5kitwfE6sudnwA8HD4XSu2B+UnGC0U9ftioqknHdpNVPEAdaJw/o/n8ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr; spf=pass smtp.mailfrom=inria.fr; dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b=tXgRllry; arc=none smtp.client-ip=192.134.164.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inria.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=ES8+uZdQuIC4h4krwNG6xP2GbtVLZjjoE+7amz2RWV0=;
  b=tXgRllryf0zp5PUoUzlw0YxI+D+l8E6hj+nEvqVYM3FoREdjfxL8QdiM
   +SG9o3p9Uk/OUZi4Q56Wgqc7YQ3eXvXUcvWgGE1JQJZ9uV4TkJCp2y6IE
   bbpy7qHHLy9aGPWNF/SyvKI3caC1MlcGRnepHqKwI4YGuWSRZKC31Kp9I
   8=;
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.07,245,1708383600"; 
   d="scan'208";a="86149003"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2024 13:56:01 +0200
Date: Wed, 1 May 2024 13:56:00 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Sudeep Holla <sudeep.holla@arm.com>
cc: Vincenzo Mezzela <vincenzo.mezzela@gmail.com>, gregkh@linuxfoundation.org, 
    javier.carrasco.cruz@gmail.com, julia.lawall@inria.fr, 
    linux-kernel@vger.kernel.org, rafael@kernel.org, skhan@linuxfoundation.org
Subject: Re: [PATCH 2/2 v3] drivers: use __free attribute instead of
 of_node_put()
In-Reply-To: <ZjIivZOzGCNNG5QE@bogus>
Message-ID: <alpine.DEB.2.22.394.2405011355430.3278@hadrien>
References: <20240424125401.oxvt5n64d7a57ge3@bogus> <20240501094313.407820-1-vincenzo.mezzela@gmail.com> <20240501094313.407820-3-vincenzo.mezzela@gmail.com> <ZjIivZOzGCNNG5QE@bogus>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII



On Wed, 1 May 2024, Sudeep Holla wrote:

> As mentioned in 1/2, please fix the subject to be more precise.
>
> On Wed, May 01, 2024 at 11:43:13AM +0200, Vincenzo Mezzela wrote:
> > Introduce the __free attribute for scope-based resource management.
> > Resources allocated with __free are automatically released at the end of
> > the scope. This enhancement aims to mitigate memory management issues
> > associated with forgetting to release resources by utilizing __free
> > instead of of_node_put().
> >
> > The declaration of the device_node used within the do-while loops is
> > moved directly within the loop so that the resource is automatically
> > freed at the end of each iteration.
> >
> > Suggested-by: Julia Lawall <julia.lawall@inria.fr>
> > Signed-off-by: Vincenzo Mezzela <vincenzo.mezzela@gmail.com>
> > ---
> >  drivers/base/arch_topology.c | 51 +++++++++++++++---------------------
> >  1 file changed, 21 insertions(+), 30 deletions(-)
> >
> > diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
> > index ea8836f0bb4b..eef26e304018 100644
> > --- a/drivers/base/arch_topology.c
> > +++ b/drivers/base/arch_topology.c
> > @@ -8,6 +8,7 @@
> >
> >  #include <linux/acpi.h>
> >  #include <linux/cacheinfo.h>
> > +#include <linux/cleanup.h>
> >  #include <linux/cpu.h>
> >  #include <linux/cpufreq.h>
> >  #include <linux/device.h>
> > @@ -513,10 +514,10 @@ core_initcall(free_raw_capacity);
> >   */
> >  static int __init get_cpu_for_node(struct device_node *node)
> >  {
> > -	struct device_node *cpu_node;
> >  	int cpu;
> >
> > -	cpu_node = of_parse_phandle(node, "cpu", 0);
> > +	struct device_node *cpu_node __free(device_node) =
> > +		of_parse_phandle(node, "cpu", 0);
>
> Prefer a blank line after this, applies to all the place where you are
> introducing this style.

There should also be no blank line before it.

julia


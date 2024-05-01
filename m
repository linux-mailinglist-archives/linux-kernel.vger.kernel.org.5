Return-Path: <linux-kernel+bounces-165365-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F091B8B8BC7
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 16:19:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB115283E19
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 14:19:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74E4412F36F;
	Wed,  1 May 2024 14:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b="m0kGQ34T"
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C4C312EBEE;
	Wed,  1 May 2024 14:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.134.164.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714573189; cv=none; b=OfBLOE3x8/5oytuGG+2W47tSOWi68N8llV6/xLlTY1KRPTY3XuvXDpZh7W398XGGFWLNXv3jEzKoqPLzcQT0HmXtRc7S/ylodT2zwxBlaRd+kZY3lwYFk2EvX4lqzFCFLaoHoj9DYow4t7qPFBFMseec2DpZNoijFINVll/fvNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714573189; c=relaxed/simple;
	bh=k3SWeRnxAXa2TO+tWpwkxrtkHOTZjCVdqWoasShV9vU=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=B0u1EFnjyWVOvj8Q3wgYEB1bTE2kK1yNHNCGMIRYiCmWR9Lsd3yLfsEihxJMVwwXF2oaxEFX584f/uGdCfSGf8zvRA2oJRdKpyx/o3JrfL9b/hfxGofY8Eu2ylUKb/cN/sMfro3oxFDMuxRCbx0ZkdenNl4s7WyAruPlUPqnaMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr; spf=pass smtp.mailfrom=inria.fr; dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b=m0kGQ34T; arc=none smtp.client-ip=192.134.164.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inria.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=zJzS+8XGm8C4eeKbbvynEhybHsCB9GY4MtQsheFW4g8=;
  b=m0kGQ34TqXJluxRVGGNrLA09V6Txt+Z9ku33c1j23Q36O/8vdp6BLV9y
   ExfPtsxkkKdiQ6xw9uzfJA0Yb37xhPCWtQDS6YVdQM0CugOOM3qCmngJn
   jOefRpTslor9tZeeajd/64gCoIZ9w3AWnWVoHcZLUyw7UHMLvz+7j/Ejt
   A=;
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.07,245,1708383600"; 
   d="scan'208";a="86154178"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2024 16:19:43 +0200
Date: Wed, 1 May 2024 16:19:42 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Daniel Thompson <daniel.thompson@linaro.org>
cc: R Sundar <prosunofficial@gmail.com>, Lee Jones <lee@kernel.org>, 
    Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>, 
    dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, 
    linux-kernel@vger.kernel.org, skhan@linuxfoundation.org, 
    javier.carrasco.cruz@gmail.com, Julia Lawall <julia.lawall@inria.fr>, 
    Shresth Prasad <shresthprasad7@gmail.com>
Subject: Re: [PATCH] backlight: sky81452-backlight: replace of_node_put with
 __free
In-Reply-To: <20240501140144.GA10180@aspen.lan>
Message-ID: <alpine.DEB.2.22.394.2405011618351.3278@hadrien>
References: <20240501125146.33648-1-prosunofficial@gmail.com> <20240501140144.GA10180@aspen.lan>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII



On Wed, 1 May 2024, Daniel Thompson wrote:

> On Wed, May 01, 2024 at 06:21:46PM +0530, R Sundar wrote:
> > Use the new cleanup magic to replace of_node_put() with
> > __free(device_node) marking to auto release when they get out of scope.
> >
> > Suggested-by: Julia Lawall <julia.lawall@inria.fr>
> > Signed-off-by: R Sundar <prosunofficial@gmail.com>
>
> Thanks for the patch but I think this one is a more appropriate
> solution to this issue:
> https://lore.kernel.org/all/20240421104916.312588-2-shresthprasad7@gmail.com/

Maybe neither one is perfect?  The one I see at that link has:

 	if (!pdata) {
-		of_node_put(np);
 		return ERR_PTR(-ENOMEM);
 	}

which has unneeded {}

julia


>
>
> Daniel.
>


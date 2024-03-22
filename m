Return-Path: <linux-kernel+bounces-111696-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62FBB886FBF
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 16:24:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95F511C216C7
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 15:24:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AC15535A8;
	Fri, 22 Mar 2024 15:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="phXk55he"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDAF451C4F;
	Fri, 22 Mar 2024 15:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711121018; cv=none; b=MtPgn5gPNhexZVCfKr4SKiQX1mtmUspzG5ko7vNfuQmRu5vAKWZ/4ruKyzD2U3m3N/WykUixupO0mPmPq9MSUkKS0ThG2ZjmGe7Sy6NRkL7rVRDutz7Q+lyVuAwNTQUPLs/wFO+i1r+FPTP902O4RXy3d+z9joA080pBixbT6e4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711121018; c=relaxed/simple;
	bh=2jKs8iXhSIhZoCfrPfcc8CMFgCUmi/F0p3tI20DDC8s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jhrmYzgu8ingXa7HVpwys+Bed79hj1j2hc54AvCx6N7gkrCq+cT6gpkFX4pwJ3G30BC8Ah+VW4c5+iwvZLGTW9iDxgu5HOdXLZRfzqjGZi4f9y156ob6sEH52CthOqZpVJiVMXbZpgmpslvsKn4kcRDbZd7cGUQzwd7NlaYymi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=phXk55he; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCE20C433F1;
	Fri, 22 Mar 2024 15:23:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711121018;
	bh=2jKs8iXhSIhZoCfrPfcc8CMFgCUmi/F0p3tI20DDC8s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=phXk55hei4tv1d33xGsvZp2FCn8mCM1trm3kDZfQZdICDrEPJDLhK13MkrfHTJ3F+
	 bgnkYMAXoZsVDL0KFaNrewQEizN9ZhjUIakwhcOqCu9h7AtLMmYPmstvKhReuXKU6A
	 PNYisq/fQ0BFHUMNi4Vt8/1EWLXcjYeasaFYl2FKLaDuaBJhEIiSuNGBMxfu13fovx
	 B/ul9ZNN5Buz40ja9e+w+KnF57OBIjoKx4QmjCgZLBwHhmQOkAp4hd8HYzf80xaoi3
	 ZhAFHXouRrw3NeaETACnYVW3/DkQqpnuW1+UuopVNDj4REwqeESiG0E0KfnEuvLu1a
	 A1jG1pzvo5rFg==
Date: Fri, 22 Mar 2024 08:23:36 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Jeff Johnson <quic_jjohnson@quicinc.com>, Kalle Valo <kvalo@kernel.org>,
 Jeff Johnson <jjohnson@kernel.org>, keescook@chromium.org, "open
 list:NETWORKING DRIVERS (WIRELESS)" <linux-wireless@vger.kernel.org>, "open
 list:QUALCOMM ATHEROS ATH10K WIRELESS DRIVER" <ath10k@lists.infradead.org>,
 open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ath10k: allocate dummy net_device dynamically
Message-ID: <20240322082336.49f110cc@kernel.org>
In-Reply-To: <Zf2ceu2O47lLbKU3@gmail.com>
References: <20240319104754.2535294-1-leitao@debian.org>
	<9fcdb857-da62-4832-ae11-043fe993e4ad@quicinc.com>
	<20240321072821.59f56757@kernel.org>
	<5039256c-03eb-4cda-8d11-49e4561cf1ef@quicinc.com>
	<20240321151744.246ce2d0@kernel.org>
	<Zf2ceu2O47lLbKU3@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 22 Mar 2024 07:58:02 -0700 Breno Leitao wrote:
> > Looks like init_dummy_netdev wipes the netdev structure clean, so I
> > don't think we can use it directly as the setup function, Breno :(  
> 
> Before my patch,  init_dummy_netdev was being also used. The patch was
> basically replacing the init_dummy_netdev by alloc_netdev() with will
> call "setup(dev);" later. 
> 
> -               init_dummy_netdev(&irq_grp->napi_ndev);
> +               irq_grp->napi_ndev = alloc_netdev(0, "dummy", NET_NAME_UNKNOWN,
> +                                                 init_dummy_netdev);
> 
> I am wondering if alloc_netdev() is messing with something instead of
> init_dummy_netdev().

alloc_netdev() allocates some memory and initializes lists which
free_netdev() wants to free, basically. But init_dummy_netdev() does:

	/* Clear everything. Note we don't initialize spinlocks
	 * are they aren't supposed to be taken by any of the
	 * NAPI code and this dummy netdev is supposed to be
	 * only ever used for NAPI polls
	 */
	memset(dev, 0, sizeof(struct net_device));

so all those pointers and init alloc_netdev() did before calling setup
will get wiped.

> Also, Kalle's crash is during rmmod, and not during initialization.
> getting NULL after free_netdev() is called.
> 
> > Maybe we should add a new helper to "alloc dummy netdev" which can
> > call alloc_netdev() with right arguments and do necessary init?  
> 
> What are the right arguments in this case?

I'm not sure we have a noop setup() callback today. If you define a
wrapper to allocate a dummy netdev you can define a new empty function
next to it and pass that as init? Hope I got the question right.


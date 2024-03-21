Return-Path: <linux-kernel+bounces-110147-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7672C885AA2
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 15:26:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1628E1F2271F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 14:26:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA0F38528B;
	Thu, 21 Mar 2024 14:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O9c+rvX8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04B8985274;
	Thu, 21 Mar 2024 14:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711031175; cv=none; b=Sg09+/+wr51JgRWgZs4tTIZA19i0hCObl6425ynnT4KI9seSs4J02C9MwASIg88frb+vNPZrR/sy7H+S52WX7i7XifGnsK1P3dwJ4Egwd+PFCu+y8eEnmLmIYAhPa7hMFjR8bjQ6pxtpthZlAv+8OmhTQED72AiQpAfLmxVx+54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711031175; c=relaxed/simple;
	bh=VmkGFNifUtWmSip+krIO7T42x5hHDlDV33XxA8/204k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DCyHcz+gYKNw429XyQ/ADk4ogYiV03xcyzv0fOhn2I4+0XqChS+j0GhvEOqO5/zhHF+I7WLxs5Sa/YLHJp1EYNx1bD+Wa5jCQbdMjIcngNEvkYFhJRAqLRAkEI+KlsJwso1mVvSCr27lqUG0KelX6X3J9Fx9/E8xw0pLCNuVDqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O9c+rvX8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 351DDC433C7;
	Thu, 21 Mar 2024 14:26:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711031174;
	bh=VmkGFNifUtWmSip+krIO7T42x5hHDlDV33XxA8/204k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=O9c+rvX8i4il61QRCvQZZIAiCk8lK6SIcYkVxy8tvu8VVBa7Vxh3vIkSosuIIrzbx
	 bQuomSoRPhCETV48+mILsD6OlGTXpRlTGtmWPLF8gCGNOTrheMvrvJ8F1de5P3tZBg
	 KqOe3RMDdhE2z81ls9sa6N0IaYoR79yShQ7AniqyB9joJefWrsfdNx+zD55kh34Atp
	 Ome4EhWb6agk3vxKuMuKa/X7HHwRFbYbt8MxBP3KrSCo8tHes35diAzPqR1n53LpQH
	 rsaIIw2LEQ8olXaPHT84Ki8mRv3EOkHeeTgoRBExiYTSLXLyJDwp2/XQWs5DN1rWA4
	 fbsTNlQruF4tQ==
Date: Thu, 21 Mar 2024 07:26:13 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: Breno Leitao <leitao@debian.org>, Kalle Valo <kvalo@kernel.org>, Jeff
 Johnson <jjohnson@kernel.org>, keescook@chromium.org, "open list:NETWORKING
 DRIVERS (WIRELESS)" <linux-wireless@vger.kernel.org>, "open list:QUALCOMM
 ATHEROS ATH11K WIRELESS DRIVER" <ath11k@lists.infradead.org>, open list
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] wifi: ath11k: allocate dummy net_device dynamically
Message-ID: <20240321072613.67466168@kernel.org>
In-Reply-To: <a44f21e3-1773-4b56-b1f0-c03a6462a7c1@gmail.com>
References: <20240319185735.1268980-1-leitao@debian.org>
	<a44f21e3-1773-4b56-b1f0-c03a6462a7c1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 20 Mar 2024 07:05:42 -0700 Florian Fainelli wrote:
> > @@ -533,8 +534,11 @@ static int ath11k_ahb_config_ext_irq(struct ath11k_base *ab)
> >   
> >   		irq_grp->ab = ab;
> >   		irq_grp->grp_id = i;
> > -		init_dummy_netdev(&irq_grp->napi_ndev);
> > -		netif_napi_add(&irq_grp->napi_ndev, &irq_grp->napi,
> > +		irq_grp->napi_ndev = alloc_netdev(0, "dummy", NET_NAME_UNKNOWN,
> > +						  init_dummy_netdev);  
> 
> Is not this going to be a problem with multiple network device drivers 
> loaded in a given system and all using "dummy" here? While 
> NET_NAME_UNKNOWN ensures that this is not exposed to user-space, there 
> is still this part of alloc_netdev_mqs() which is going to be non-unique:
> 
>          ref_tracker_dir_init(&dev->refcnt_tracker, 128, name);

Names are allocated are registration time, I think, so basically all
devices will get an non-uniquely named ref tracker dir. For ethernet
it will be unconverted "eth%d". The name only shows up in some prints,
AFAICT, so not very important?


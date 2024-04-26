Return-Path: <linux-kernel+bounces-160762-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C62268B427B
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 01:06:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 02C15B21C2D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 23:06:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 373833B79C;
	Fri, 26 Apr 2024 23:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uorwIqEI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7980C39FC5;
	Fri, 26 Apr 2024 23:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714172759; cv=none; b=LxrsmZv6VKHauEISkGyMsvEpXNgUpONK9oHGMWUhaxEBLQV/WegKxkOAVj7HDlbFlskt0VVPnaO9BbcSo3iUnCX7xFxqH64pfYAj1X7gIfHU/auNUVO0JPDc8X1aDMWrGP8mzjZDgh/QQc/PSDu8ExPx3AUu1ojUf4EXYfRG6bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714172759; c=relaxed/simple;
	bh=cz81g8dRd8WGS4FfF7yHOLy1Rtt7gsfw9coHC3cgGw4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B1GWyjRfTi5YQlrQFs7jiPgFuUeRtMniu0Ja78KpUhbo3a3J1b8XFrtqllODQK9rvOlxz+MvNzYjfiCNSy3q2/2k03SUOPxVQXS2MYHu7pRUUUsi5nZcUxF1gXNiMWjCkzsz7gqfT1bHuMIpeYgXmHuAh6ru1gMGji3iHhtSNIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uorwIqEI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95794C113CD;
	Fri, 26 Apr 2024 23:05:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714172759;
	bh=cz81g8dRd8WGS4FfF7yHOLy1Rtt7gsfw9coHC3cgGw4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=uorwIqEI92m1Q3QTYmc59i0meAi6h5Xwcn0yC4tWv48cgnTDHGurA6BMF/mJQk2Wu
	 OYrq5jAWsEX5XlWtlbBIesUiuVtAU/XKNa0N5lRudKKCMtLGCub5hl9ZBOM9t8eFgZ
	 2oUt64s/xDej+8hf32ZrLtfDOKZXey+INgy/VBSVN/mVYd7s87pg47GvKGMp6V0FZ9
	 tIhdz3bjYtVAcCwU86vtD4dqfTD6GUEl/BcvY0YV5Ncin3srxySNWz52IGG+N0VmOS
	 z1Mve9M4fbuzSDdVUpn3AswiA6k0zcwjAXrA91zTyWnQdEpa/w+UNTuWMuc4nqaTnt
	 ovIzbbRIujwNQ==
Date: Fri, 26 Apr 2024 16:05:57 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: "almasrymina@google.com" <almasrymina@google.com>, "davem@davemloft.net"
 <davem@davemloft.net>, "pabeni@redhat.com" <pabeni@redhat.com>,
 "ilias.apalodimas@linaro.org" <ilias.apalodimas@linaro.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "jacob.e.keller@intel.com" <jacob.e.keller@intel.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Jianbo Liu
 <jianbol@nvidia.com>, "edumazet@google.com" <edumazet@google.com>
Subject: Re: [RFC PATCH] net: Fix one page_pool page leak from
 skb_frag_unref
Message-ID: <20240426160557.51de91f9@kernel.org>
In-Reply-To: <4c20b500c2ed615aba424c0f3c7a79f5f5a04171.camel@nvidia.com>
References: <20240424165646.1625690-2-dtatulea@nvidia.com>
	<4ba023709249e11d97c78a98ac7db3b37f419960.camel@nvidia.com>
	<CAHS8izMbAJHatnM6SvsZVLPY+N7LgGJg03pSdNfSRFCufGh9Zg@mail.gmail.com>
	<4c20b500c2ed615aba424c0f3c7a79f5f5a04171.camel@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 25 Apr 2024 08:17:28 +0000 Dragos Tatulea wrote:
> >  The unref path always dropped a regular page
> > ref, thanks to this commit as you point out:
> > 
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=2cc3aeb5ecccec0d266813172fcd82b4b5fa5803
> > 
> > AFAICT the correct fix is to actually revert commit 2cc3aeb5eccc
> > ("skbuff: Fix a potential race while recycling page_pool packets").
> > The reason is that now that skb_frag_ref() can grab page-pool refs, we
> > don't need to make sure there is only 1 SKB that triggers the recycle
> > path anymore. All the skb and its clones can obtain page-pool refs,
> > and in the unref path we drop the page-pool refs. page_pool_put_page()
> > detects correctly that the last page-pool ref is put and recycles the
> > page only then.
> >   
> I don't think this is a good way forward. For example, skb->pp_recycle is used
> as a hint in skb_gro_receive to avoid coalescing skbs with different pp_recycle
> flag states. This could interfere with that.

That's a bit speculative, right? The simple invariant we are trying to
hold is that if skb->pp_recycle && skb_frag_is_pp(skb, i) then the
reference skb is holding on that frag is a pp reference, not page
reference.

skb_gro_receive() needs to maintain that invariant, if it doesn't
we need to fix it..


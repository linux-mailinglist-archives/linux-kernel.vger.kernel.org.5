Return-Path: <linux-kernel+bounces-167115-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E7BA8BA4AE
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 02:46:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 485CA1F230E9
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 00:46:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A01DC8E9;
	Fri,  3 May 2024 00:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nuJXEBmS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AF358F47;
	Fri,  3 May 2024 00:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714697180; cv=none; b=DB2UoNhrTU+GYxwuw0yMc+ZGIbhneoDtcVpt12HbMm6e3db/C428LwQXs7exk7mAv8mnJg4QBL3qBoVw1A3d9xDP+QivuvxhxR7A3KXxsgYD+rGGvGhWjJf+TwuLQfQ7zrxInjWziUTPf+yizzS3DRurjpOITFO9/c53D59Sckc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714697180; c=relaxed/simple;
	bh=9gGS1WG9kjKboRFG4NTZO/zmtlJ0e+MxlRzL2OlV38I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GOXbW70/qGXkIE6fjjnINXeJXTYGmLkZ54jziH5eS3lv3B3O0+KYIxQKcF6fU/hq9IU94cM7K0DxLbvVFHuSULKzBYfGWuhRnmsXyNBuFtVxeCaVnDjGPRi97bgH8wkBRWKg19EQ6ke2dlHBQXbl3ztQIiQExYO3/Al2OED/G/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nuJXEBmS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25AD0C113CC;
	Fri,  3 May 2024 00:46:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714697179;
	bh=9gGS1WG9kjKboRFG4NTZO/zmtlJ0e+MxlRzL2OlV38I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nuJXEBmS1uju/RFoF2dhT0/QOueo7ZN4MJCLLrX8Zapl5GRBEqosYoepz9/nLuk3W
	 qwUBAwe0bqZ3SGXmk6IOrqIgPsDMMtNz9ryQpLWKJv+X3CmfDNbo5ZsC8inItzzgdR
	 4BKbWj6RxCLaTj8Fksa30xeEeG89gLXHERzVi6KSF0x1iZMjPgMv8fssR7mEpCLp27
	 erwH3OUbTeI+5Gdil9h1/QKpXphcKFutAfhYzwNtPf/gPTPPt22TkLTyEhtFymUGVP
	 pcf6ZIXo5VxrDNPSpv47yJK3IYhLDonXfy1pPyuUxeAnweG693V85unAv2cKXT8kJ+
	 VASU61CmuyhIQ==
Date: Thu, 2 May 2024 17:46:18 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Mina Almasry <almasrymina@google.com>
Cc: Dragos Tatulea <dtatulea@nvidia.com>, "davem@davemloft.net"
 <davem@davemloft.net>, "pabeni@redhat.com" <pabeni@redhat.com>,
 "ilias.apalodimas@linaro.org" <ilias.apalodimas@linaro.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "jacob.e.keller@intel.com" <jacob.e.keller@intel.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Jianbo Liu
 <jianbol@nvidia.com>, "edumazet@google.com" <edumazet@google.com>
Subject: Re: [RFC PATCH] net: Fix one page_pool page leak from
 skb_frag_unref
Message-ID: <20240502174618.47c28727@kernel.org>
In-Reply-To: <CAHS8izPBhZ1USvSoDdR-Xwg3jNL5ppRXTzc3FEM9gjx6B1fJAw@mail.gmail.com>
References: <20240424165646.1625690-2-dtatulea@nvidia.com>
	<4ba023709249e11d97c78a98ac7db3b37f419960.camel@nvidia.com>
	<CAHS8izMbAJHatnM6SvsZVLPY+N7LgGJg03pSdNfSRFCufGh9Zg@mail.gmail.com>
	<4c20b500c2ed615aba424c0f3c7a79f5f5a04171.camel@nvidia.com>
	<CAHS8izPkRJyLctmyj+Ppc5j3Qq5O1u3aPe5h9mnFNHDU2OxA=A@mail.gmail.com>
	<20240426160859.0d85908e@kernel.org>
	<CAHS8izNs-LV=6FE39sjF3V7qVfveOsOAOJ_X62TSzWpvamsS0Q@mail.gmail.com>
	<20240429080022.214a9df9@kernel.org>
	<CAHS8izPBhZ1USvSoDdR-Xwg3jNL5ppRXTzc3FEM9gjx6B1fJAw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 2 May 2024 13:08:23 -0700 Mina Almasry wrote:
> OK, this is where I'm not sure anymore. The diff you're replying to
> attempts to enforce the invariant: "if anyone wants a reference on an
> skb_frag, skb_frag_ref will be a pp ref on pp frags
> (is_pp_page==true), and page refs on non-pp frags
> (is_pp_page==false)".
> 
> Additionally the page doesn't transition from pp to non-pp and vice
> versa while anyone is holding a pp ref, because
> page_pool_set_pp_info() is called right after the page is obtained
> from the buddy allocator (before released from the page pool) and
> page_pool_clear_pp_info() is called only after all the pp refs are
> dropped.
> 
> So:
> 
> 1. We know the caller has a ref (otherwise get_page() wouldn't be safe
> in the non-pp case).
> 2. We know that the page has not transitioned from pp to non-pp or
> vice versa since the caller obtained the ref (from code inspection, pp

How do we know that?

> info is not changed until all the refs are dropped for pp pages).
> 3. AFAICT, it follows that if the page is pp, then the caller has a pp
> ref, and if the page is non-pp, then the caller has a page ref.

If that's true we have nothing to worry about.

> 4. So, if is_pp_page==true, then the caller has a pp ref, then
> napi_pp_get_page() should be concurrently safe.
> 
> AFAICT the only way my mental model is broken is if there is code
> doing a raw get_page() rather than a skb_frag_ref() in core net stack.

Not just. We also get pages fed from the outside, which may be PP pages.
Right now it'd be okay because "from outside" pages would end up in Tx.
Tx always allocates skbs with ->pp_recycle = 0, so we'll hold full refs.

> I would like to get rid of these call sites if they exist. They would
> not interact well with devmem I think (but could be made to work with
> some effort).

Maybe if we convert more code to operate on netmem_ref it will become
clearer where raw pages get fed in, and therefore were we have to be
very careful?


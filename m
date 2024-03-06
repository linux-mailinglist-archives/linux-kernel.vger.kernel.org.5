Return-Path: <linux-kernel+bounces-94232-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 143B3873BBC
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 17:09:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45EA81C21625
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 16:09:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EEF91361D3;
	Wed,  6 Mar 2024 16:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q8Ep8tS4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E06C134435;
	Wed,  6 Mar 2024 16:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709741373; cv=none; b=RWbMoeBH8jdlsZZ4E4AAzl/18yo8HALsLTexBZ2AgJutqtdZ/lZG+GEBKmH7DoWRVKcF/Jma7JeiGp6gnyHhcl+0nhvHkiSRcRv/MRjjzrKVFvGLNDBYl7pHc2NRiQhOt/jSZC1Ap/34KLuf0cKd+Fa8nk7pAyPb0A+zkY5GF3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709741373; c=relaxed/simple;
	bh=hNWD+Zmz9092UXBeYAgMkfvemRul5fkYSRm6vD9xmnQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O41pFBVE0fwLiZzaow4nHRYn1AcHYsiz1sGR2CIdqVSfztdC3v4oQ9xK4GHOyyGydGPGl5vXYyd5VPZwU1vXE4Rsb41VX2IWLaKjnzPluf4LlMKLqfF07/KM6CrLovj0IQ84dl7hfuP1h5igIVuBSRZvUi/uLzqvUnPKdS30B1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q8Ep8tS4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54F6BC433C7;
	Wed,  6 Mar 2024 16:09:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709741372;
	bh=hNWD+Zmz9092UXBeYAgMkfvemRul5fkYSRm6vD9xmnQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=q8Ep8tS4wMTRZBk2LczwIkh160VwpnRxIQTpZI9ZQPDIKmjD8QgWdgZ6gDwCGswnr
	 ud5/Y9+05pVZAbCVwOhyQXjIS3EhgYU0ySyne5/b3G7MLaKeFzhXLtkrS1doE8gRSM
	 97zKmfabFDZ1/P8/EMfvgaFU4xFkyaBOfOMFir7qUu7OzmMRhcdja7RnAwkY2f6xGo
	 +ZVXlYt2k7DnBoE0rO8v6Fflrkls9HMLMJ70IgKIIIvZZ+KF8RHQh8FyHOUjysiDzW
	 c9zzKJEQCqBzzc/b36ZMEyArgz7H3OQB0W9Xi+oPnLNGPfUyTUta8ao/Vchl37rOAk
	 3eZ5A32Ir31TQ==
Date: Wed, 6 Mar 2024 08:09:31 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: "davem@davemloft.net" <davem@davemloft.net>,
 "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
 "dsahern@kernel.org" <dsahern@kernel.org>, Gal Pressman <gal@nvidia.com>,
 "steffen.klassert@secunet.com" <steffen.klassert@secunet.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Leon
 Romanovsky <leonro@nvidia.com>, "pabeni@redhat.com" <pabeni@redhat.com>,
 "edumazet@google.com" <edumazet@google.com>, "almasrymina@google.com"
 <almasrymina@google.com>, "Anatoli.Chechelnickiy@m.interpipe.biz"
 <Anatoli.Chechelnickiy@m.interpipe.biz>, "ian.kumlien@gmail.com"
 <ian.kumlien@gmail.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [RFC] net: esp: fix bad handling of pages from page_pool
Message-ID: <20240306080931.2e24101b@kernel.org>
In-Reply-To: <320ef2399e48ba0a8a11a3b258b7ad88384f42fb.camel@nvidia.com>
References: <20240304094950.761233-1-dtatulea@nvidia.com>
	<20240305190427.757b92b8@kernel.org>
	<7fc334b847dc4d90af796f84a8663de9f43ede5d.camel@nvidia.com>
	<20240306072225.4a61e57c@kernel.org>
	<320ef2399e48ba0a8a11a3b258b7ad88384f42fb.camel@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 6 Mar 2024 16:00:46 +0000 Dragos Tatulea wrote:
> > Hm, that's a judgment call.
> > Part of me wants to put it next to napi_frag_unref(), since we
> > basically need to factor out the insides of this function.
> > When you post the patch the page pool crowd will give us
> > their opinions.
>
> Why not have napi_pp_put_page simply return false if CONFIG_PAGE_POOL is not
> set?

Without LTO it may still be a function call.
Plus, subjectively, I think that it's a bit too much logic to encode in
the caller (you must also check skb->pp_recycle, AFAIU)
Maybe we should make skb_pp_recycle() take struct page and move it to
skbuff.h ? Rename it to skb_page_unref() ?

> Regarding stable would I need to send a separate fix that does the raw pp page
> check without the API?

You can put them in one patch, I reckon.


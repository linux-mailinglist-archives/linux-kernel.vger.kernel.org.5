Return-Path: <linux-kernel+bounces-125834-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCCA9892CE3
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 21:12:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7886F282E0B
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 20:12:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3931E433D7;
	Sat, 30 Mar 2024 20:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lGKCKruL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77C4017D2;
	Sat, 30 Mar 2024 20:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711829531; cv=none; b=cg4JXiu2TTqk7+AlLJADizVcLrT2r9jP/z4stGAlOmME3bMlCT8S1kgZIxdklNBSS32ydqTPOd5IibjSXVOS0bWOsJdN5DIV6OIZwz4ftvuyYuklWLrmOc27fhRMoDvEUWSP62jsrYZeCXf/bgi5CYZMsAjHFmdt7BOD6FZ15JI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711829531; c=relaxed/simple;
	bh=tqxZkRzpXowyo+2UpdDz8L54SoNcrugqP9rLeDhbqnk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y2PiYm0ESA8MqbYP5MlAhcWknqJirz0oAalMaN5vEBZ3ritN1ptiqqUkF2RL4fClzc8L7ZD47eNKOuyzGj9pR1GKyY1Mou0LhmBmd466RAfPuyIaooPliGM6Qtirg9TcaJzw/hUMYp6YR/G51IHHIZ/e6/d4A8ZaFgFlfcLB1ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lGKCKruL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90DE7C433F1;
	Sat, 30 Mar 2024 20:12:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711829531;
	bh=tqxZkRzpXowyo+2UpdDz8L54SoNcrugqP9rLeDhbqnk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lGKCKruLPtXkgaWsIz7Fw2HM45FO+vLF7wjrUH0QrMBHQn4GsnWBqbj4OD5nPnNyI
	 UIe98IldUxH5mHiwyyFWSYnY1mWjejEcmtd0ZoHoOyTjGzrgHmg+riHD98cttFvzn2
	 2ZV7lneQLOct9DfDvBgXiPbYiZ5omBRLk2DfgQ18yM5FfqPP9G+d8RRAzSsGSfBJNF
	 UfwV9isvp938aGXdv07PYCKodaoRrJ5dsvMrAqdIJp2FESpUdSFRLmdE2OFiOhIRv/
	 AbW3RII4d+P70G+p67rXZYDfr83Y/cWw6j5h4IdMLUTssrkW98s1LXt3IzV7Zmxt4A
	 kjdru6SwIX7/w==
Date: Sat, 30 Mar 2024 20:10:36 +0000
From: Simon Horman <horms@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Aleksandr Mishin <amishin@t-argos.ru>,
	Sunil Goutham <sgoutham@marvell.com>,
	Linu Cherian <lcherian@marvell.com>,
	Geetha sowjanya <gakula@marvell.com>,
	Jerin Jacob <jerinj@marvell.com>, hariprasad <hkelam@marvell.com>,
	Subbaraya Sundeep <sbhatta@marvell.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: Re: [PATCH] octeontx2-af: Add array index check
Message-ID: <20240330201036.GA22418@kernel.org>
References: <20240328081648.13193-1-amishin@t-argos.ru>
 <20240328112818.49c0de17@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240328112818.49c0de17@kernel.org>

On Thu, Mar 28, 2024 at 11:28:18AM -0700, Jakub Kicinski wrote:
> On Thu, 28 Mar 2024 11:16:48 +0300 Aleksandr Mishin wrote:
> > In rvu_map_cgx_lmac_pf() the 'iter', which is used as an array index, can reach
> > value (up to 14) that exceed the size (MAX_LMAC_COUNT = 8) of the array.
> > Fix this bug by adding 'iter' value check.
> 
> I'm guessing you got the 14 from:
> 
> 	hw->lmac_per_cgx = (nix_const >> 8) & 0xFULL;
> 
> Seems more reasonable to cap the size at that point than every use
> afterwards.

FWIIW, I didn't find any other locations where this overflow might occur,
but I do agree that this approach makes sense.

I also notice that rvu_map_cgx_lmac_pf() has the following check near the
top. I think the lmac_per_cgx portion can be dropped, though that could be
a follow-up.

        if (cgx_cnt_max > 0xF || rvu->hw->lmac_per_cgx > 0xF)
                return -EINVAL;


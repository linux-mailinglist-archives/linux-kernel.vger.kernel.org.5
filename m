Return-Path: <linux-kernel+bounces-59743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2655784FB26
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 18:38:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61A671C24E6A
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 17:38:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 887747EF03;
	Fri,  9 Feb 2024 17:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kerfjuN5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C740D7B3D2;
	Fri,  9 Feb 2024 17:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707500324; cv=none; b=gtcfygO0BQZ0Ezic7s7e/8JvzTbb/bdM/0B71N0Co01KquC1BaZ8UhXSiOwMHqPgsbGFWAPO7JHomuKAzE3iCzs18Dy04QAymPKgPPIEj65S8AHshX9kuWz1T9doos3q7kLnNSDVg7awW4dQhl58SF7xslZ1SqrrsSCOGTMnSKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707500324; c=relaxed/simple;
	bh=HravDwgHEdCMpMGa6CrqloF7sVySm2L8D8y1O2Do7lc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=isypjgPHSO8Y0caClEw5igS72KgWuDk5TVS3oa+U1X9ykvbXrpxQOmrDbtss3IvU97g885Eu2pnv8YOiBlE2Y2xPtdnV7SjfxcmOc9TurQSKt4cHQ/dpLas0uhk/IG67+0X7v5FoUTHn800nIqn9Tqh3VmG7hiH9MLb9VQKxz70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kerfjuN5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 712F2C433F1;
	Fri,  9 Feb 2024 17:38:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707500324;
	bh=HravDwgHEdCMpMGa6CrqloF7sVySm2L8D8y1O2Do7lc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kerfjuN5jyjh7Iq+1DOcDabahKbMAmoRDLrtb30fs4WS1zuswq4yoePYrSk7sLA5B
	 ABE3qeI81FOY0b3nQF3bBfYoTzpxXpxvOvvVZZY+tKW3Iqcb8FEurBWf8UOkQqkpsF
	 hvUcYu6Al9JHWShocndQW1QrIOYHqdhJ22jeSiZKaw/3hvAnljZJVrgVBd8SX6K6YD
	 RK+e0HrHMlpB1/dNfmnLLHbm2mKCcjaj1xBakrPbywxz1VQO0UTm+ZTBgtrKnSvQR2
	 Jv/pTzO/mhp5gmKijD4th/XDi81p8TaNWTeXTLjRptBuYqz0jb0yTQWdwi80RAKVH4
	 4AnarJn9OZzbg==
Date: Fri, 9 Feb 2024 17:38:38 +0000
From: Simon Horman <horms@kernel.org>
To: Takeru Hayasaka <hayatake396@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>, intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, mailhol.vincent@wanadoo.fr,
	vladimir.oltean@nxp.com, laforge@gnumonks.org
Subject: Re: [PATCH net-next v6] ethtool: ice: Support for RSS settings to
 GTP from ethtool
Message-ID: <20240209173838.GH1533412@kernel.org>
References: <20240131134621.1017530-1-hayatake396@gmail.com>
 <20240131131258.47c05b7e@kernel.org>
 <CADFiAc+y_SXGtVqZkLoiWw-YBArMovMkuWw3X596QDwEtdBJ2g@mail.gmail.com>
 <CADFiAcK_XjLNjzZuF+OZDWjZA4tFB8VgeYXVJHR8+N3XryGxwA@mail.gmail.com>
 <20240208072351.3a806dda@kernel.org>
 <CADFiAc+i9i29SL0PM8gzmDG6o=ARS6fSrTPKNyqh9RLmWWB78A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADFiAc+i9i29SL0PM8gzmDG6o=ARS6fSrTPKNyqh9RLmWWB78A@mail.gmail.com>

On Fri, Feb 09, 2024 at 02:25:50AM +0900, Takeru Hayasaka wrote:
> Hi Jakub-san
> 
> Thank you for your reply.
> 
> > We're expecting a v7 with the patch split into two.
> 
> I see, I had not informed you that we have released v7. My apologies.
> The split patch for v7 has already been submitted. Could you please
> check this link?
> https://patchwork.kernel.org/project/netdevbpf/patch/20240201033310.1028154-1-hayatake396@gmail.com/
> https://patchwork.kernel.org/project/netdevbpf/patch/20240201033310.1028154-2-hayatake396@gmail.com/

Hi Hayasaka-san,

It appears that the series at the link above has been marked as
"Changes Requested" in patchwork. Although I am unsure why.

I would suggest reposting it, say with the tags supplied by Marcin Szycik
as [PATCH net-next v8].

Also, please don't top-post on the Kernel MLs [1]

[1] https://www.kernel.org/doc/html/latest/process/submitting-patches.html#use-trimmed-interleaved-replies-in-email-discussions


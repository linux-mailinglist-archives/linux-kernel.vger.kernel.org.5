Return-Path: <linux-kernel+bounces-99296-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F2814878627
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 18:14:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90B811F2137B
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 17:14:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F87A4CDE5;
	Mon, 11 Mar 2024 17:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CZRm1iAL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4DA04AEE6;
	Mon, 11 Mar 2024 17:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710177264; cv=none; b=Mwil8vCH3pMOpXp4SmE1ssvFTg7lnVtiPeye6YFNC3L/TwQiVwMiD+gXz0+4ch5fibSRp4YeudIpch3byJcm8jz3HGtQ6FCQFsMaasT5pFeBlyP8HTc1ViwTDIvIXyRfV1ouiWX3jumSPTYH6O6xWSMi6irrGL4isOEEIybhY8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710177264; c=relaxed/simple;
	bh=t3vnkmWShAx/8G71252L599Ej7yx1121Mw9K2xlBgIQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U6zwn5Tr/VLRCu0pBfIWSwokivzYH9LxsxVSHYs15gyYH6rGknuyEQuh3VmCFCXUCyJNc30cE9EIhpF5Li5IBGo4cH4kNTzU/UZMI6ponQn4n1u0z1D8zDQ1WyJ6AzDPwKmS83tPnEWMpKKuRGl9EQdIHrhrv4m3eFO+dHB2eWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CZRm1iAL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 386FFC433F1;
	Mon, 11 Mar 2024 17:14:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710177263;
	bh=t3vnkmWShAx/8G71252L599Ej7yx1121Mw9K2xlBgIQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CZRm1iALCVUbGpzHr/TrYAFHOvdjAhlOux8+FJioVXZ6WWxMaghRBZL3oxAxgOhX8
	 Qy5K+8D0AST8m2f+E02ntTM/vNB8QS2PVGvz++ehiSIe6n+7LwJyjSUs8xDlQIgVke
	 A0DUHgyQOC9qy9cZF43sJFlwhmWwiah2v7hozV3GVpOqdHPlNFYGT/qvXgXL5GaQ28
	 Hs3PnkXTNl6mYdCgxnCRDQ/13SjBAs5P2zi6cMDNm9NOa5qVFQLLVs7YYFlAODWKfm
	 ztc+nspXu+qDHw0vvzk7VccrUsxlBJt2tYPb5zUn6Ul9vCkbgW4oDy7G/uFLfz3CNA
	 I9n1pqLybpZxg==
Date: Mon, 11 Mar 2024 10:14:22 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Simon Horman <horms@kernel.org>, Luiz Angelo Daros de Luca
 <luizluca@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Alvin
 =?UTF-8?B?xaBpcHJhZ2E=?= <alsi@bang-olufsen.dk>, Andrew Lunn
 <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Vladimir Oltean
 <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 2/4] net: dsa: realtek: keep default LED state
 in rtl8366rb
Message-ID: <20240311101422.2f48360e@kernel.org>
In-Reply-To: <82d38961-8792-49ea-8c9c-5214669e0ef6@kernel.org>
References: <20240310-realtek-led-v1-0-4d9813ce938e@gmail.com>
	<20240310-realtek-led-v1-2-4d9813ce938e@gmail.com>
	<388b435f-13c5-446f-b265-6da98ccfd313@kernel.org>
	<20240310113738.GA1623@kernel.org>
	<09793a72-bfe5-4cb5-a6da-ffee565e6956@kernel.org>
	<20240311091111.53191e08@kernel.org>
	<82d38961-8792-49ea-8c9c-5214669e0ef6@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 11 Mar 2024 17:19:59 +0100 Krzysztof Kozlowski wrote:
> No, it does not reset the version number, because RFC->PATCH does not
> mean that suddenly there were no reviews or changes. We all count in
> brains from 1, so whatever we see - RFC, RFT, RFkisses or hugs - is the
> first version we see. Then next one, whatever it is called PATCH,
> RF-non-comments, RFmorekisses, is v2.

I'm describing what I see as the prevalent interpretation on netdev,
more than expressing an opinion. It's not based on any guidance from
us, people just seem to think that they should reset when they post
a PATCH.

Whether we want to enforce a different scheme is up for a discussion,
I don't really care. But I do see how not resetting is easier for
tools, and that I think is a _bad_ reason to add rules.

> There are RFCs which go to "v4", with significant discussion and review,
> thus natural next version is "5", not "1".
> 
> It's extremely confusing for me to be involved in some sort four
> revisions of RFC and the suddenly see v1. What happened with my
> comments? Why its state should be the same as new submission state?

Well, as I said, changelog with links in the cover letter...

> Plus, people do not understand or do not have the same meaning of RFC.
> Some people send RFC with meaning "do not apply, just some
> work-in-progress" but some send as regular patch with intention to
> apply. I really, really saw exactly these two approaches.

Yeah, that I do agree with 100%. People get confused by what RFC means.
I think it's partially maintainers' fault. Without naming names, there
are some people who used to apply RFC postings, if they liked the code
:|


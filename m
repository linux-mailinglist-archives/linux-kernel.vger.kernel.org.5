Return-Path: <linux-kernel+bounces-147854-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E7208A7A89
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 04:28:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 318AC1F21D9C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 02:28:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFD846FBE;
	Wed, 17 Apr 2024 02:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fDZRSjM4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B9671878;
	Wed, 17 Apr 2024 02:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713320917; cv=none; b=gyBGhR4VbHcTTRavP4nHHG2YT871o6Jro0tX+rrEh/wkttDfmYZJ4Fmk3nfRmiXs7YlyLR9j+V5h1CcAlMs18CtBr3uV21GCUO/EffTe++H7G81wi+cUxdn6BTFSYuUcfYqbuyunpPEp2VCcI1k/U9igAMP2RSjuUZTFa5AKOg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713320917; c=relaxed/simple;
	bh=b5OJV5mTeLlWdant20509uXDPJumqjJsxb4nkrE+waQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mlSTerjwsZvpzllZ/M12akYGx0ibhyLWMZTh1vC7A7gR1mlS2o/xjsvMUPkGGL0T9e5ZDZcX5rdwTGkGPd7/fcSHgIYaoujstRMw2Q+CEzmbukQkeuRem/vNynGoq2BBVRcHf5jFW2sslpEcXSVx8bpHeYo0VgIhdytdthTh7dA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fDZRSjM4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68D7AC113CE;
	Wed, 17 Apr 2024 02:28:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713320916;
	bh=b5OJV5mTeLlWdant20509uXDPJumqjJsxb4nkrE+waQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fDZRSjM4PlSKb33n0SVThT42AqX/suE7+TV0pSpjTLYot8MPyoCs1JD9RP7YBVY4c
	 dWsojCT3G7tAi8A824Py+jPO519I7S5WtIb7Ltzq4HzAwRMpjtqgR0zcKjIagyZ6N8
	 QpD4dN/gA6V2sYyxMAD8QYGCTu8RCPwsnwS63ClWqLtG428XScnkiKaLmLozn2jwvP
	 2BFMcsLIl51IJv6EzUvE3mZ7KyTU6njg96sKxXNnZAGS001E6F+/oA0irY9fQLu13t
	 jKaIr52AMLNB91SyHbEmjYWdds8Rdsc81RJP7RYmBYSvL51x2AiLMPXGmKoEIl9qLA
	 Y1718YrNx+cog==
Date: Tue, 16 Apr 2024 19:28:34 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Jonathan Corbet
 <corbet@lwn.net>, Luis Chamberlain <mcgrof@kernel.org>, Russ Weight
 <russ.weight@linux.dev>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>, Oleksij Rempel <o.rempel@pengutronix.de>, Mark Brown
 <broonie@kernel.org>, Frank Rowand <frowand.list@gmail.com>, Andrew Lunn
 <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, devicetree@vger.kernel.org, Dent Project
 <dentproject@linuxfoundation.org>, kernel@pengutronix.de, Maxime Chevallier
 <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH net-next v8 10/17] net: pse-pd: Add support for PSE PIs
Message-ID: <20240416192834.5f16e883@kernel.org>
In-Reply-To: <20240414-feature_poe-v8-10-e4bf1e860da5@bootlin.com>
References: <20240414-feature_poe-v8-0-e4bf1e860da5@bootlin.com>
	<20240414-feature_poe-v8-10-e4bf1e860da5@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 14 Apr 2024 16:21:59 +0200 Kory Maincent wrote:
> +	pis = of_get_child_by_name(np, "pse-pis");
> +	if (!pis) {
> +		/* no description of PSE PIs */
> +		pcdev->no_of_pse_pi = true;
> +		return 0;
> +	}
> +
> +	pcdev->pi = kcalloc(pcdev->nr_lines, sizeof(*pcdev->pi), GFP_KERNEL);
> +	if (!pcdev->pi)
> +		return -ENOMEM;

leaking reference on pis here

> +
> +	for_each_child_of_node(pis, node) {
> +		struct pse_pi pi = {0};
> +		u32 id;


Return-Path: <linux-kernel+bounces-164698-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82D9B8B8133
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 22:10:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E4C628539E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 20:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 937F619DF47;
	Tue, 30 Apr 2024 20:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WImPU34v"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC259182C3;
	Tue, 30 Apr 2024 20:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714507821; cv=none; b=BAipFtDjk+jCJsVJbptCpSZhRoqbO028Jp40kTpTqcgsKGGdCYDYXNabUE4VkjbGLl4f0kAemB5diy2n8PmrID0xfxiMDQuM7lijUUeif8niIBh5w6NuelpvFip7AjC/IdoDMuoQrJeAyl5JGB+gxvMT2iI1+QLTvSLe+/vmGow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714507821; c=relaxed/simple;
	bh=58CBaYeu4exH4ljqyrgLewfHjjrJsr+lwEV4eBnRRBY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g75nd/95qxcb3wizd6G3VGiJ6SNr0k8mzVW4viBbOMPRAY3hIBo7Rpc9LL7dJMe0Ea73x5G7gtQe/83tJCQQVdDBgxQVj3aKNCEYIf8wp/XiwkyMgLazT8UuWKLeXQC9xLQrDfrZ/BnfaVIynXr96XETMy7nzCA2cq5D5CkIoZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WImPU34v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0C0CC2BBFC;
	Tue, 30 Apr 2024 20:10:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714507821;
	bh=58CBaYeu4exH4ljqyrgLewfHjjrJsr+lwEV4eBnRRBY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WImPU34vi9oog0mmRTYwMKyo1ISHKsDV6YPWI+6u3+xUXQD8qpYdkh3C/41+D6CJw
	 k6UKJmZXrLyk5BK2449OfE1cJpyzZgF9BxLmxWHNjFuDNGZudLuAXQSJKMr8FdYCQV
	 cIEig5Y9rFDOqmC2AJQLvqY3T39W804ABIfyx3tLU0gZeu1lre7MEyjzk+57HmK9OT
	 mYlEXGZh2NVuCp9T1OIwqLDSqmZV580TjPigcNNiN6CtS4oF6eVQHiZ3WNf0YPsEbu
	 W4pzjqjzlUQ7Y9m+2ZqyTh7DDtM1ly32OG7YCKWgtLAsuBKB4WT4rvc+6gb628z1ZP
	 H8aC6Gjk+siug==
Date: Tue, 30 Apr 2024 21:08:44 +0100
From: Simon Horman <horms@kernel.org>
To: Daniel Golle <daniel@makrotopia.org>
Cc: =?utf-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
	Felix Fietkau <nbd@nbd.name>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	DENG Qingfang <dqfext@gmail.com>,
	Sean Wang <sean.wang@mediatek.com>, Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Landen Chao <Landen.Chao@mediatek.com>, devicetree@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH net] net: dsa: mt7530: fix impossible MDIO address and
 issue warning
Message-ID: <20240430200844.GE2575892@kernel.org>
References: <e615351aefba25e990215845e4812e6cb8153b28.1714433716.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e615351aefba25e990215845e4812e6cb8153b28.1714433716.git.daniel@makrotopia.org>

On Tue, Apr 30, 2024 at 12:45:46AM +0100, Daniel Golle wrote:
> The MDIO address of the MT7530 and MT7531 switch ICs can be configured
> using bootstrap pins. However, there are only 4 possible options for the
> switch itself: 7, 15, 23 and 31 (ie. only 3 and 4 can be configured, bit
> 0~2 are always 111). Practically all boards known as of today use the
> default setting which is to have the switch respond to address 31, while
> the built-in switch PHYs respond to address 0~4 in this case.
> 
> However, even in MediaTek's SDK the address of the switch is wrongly
> stated in the device trees as 0 (while in reality it is 31), so warn the
> user about such broken device tree and make a good guess what was
> actually intended.
> 
> This is imporant to not break compatibility with older Device Trees as
> with commit 868ff5f4944a ("net: dsa: mt7530-mdio: read PHY address of
> switch from device tree") the address in device tree will be taken into
> account. Doing so instead of assuming the switch is always at
> address 31 which was previously hard-coded will obviously break things
> for many existing downstream device trees as they contain the wrong
> address (0) which previously didn't matter.
> 
> Fixes: b8f126a8d543 ("net-next: dsa: add dsa support for Mediatek MT7530 switch")
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>

The cited commit is present in net-next but not net.
So I think this patch should target net-next.

..


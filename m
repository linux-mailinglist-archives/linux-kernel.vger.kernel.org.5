Return-Path: <linux-kernel+bounces-15015-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCBA4822629
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 01:53:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 509D92849A8
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 00:53:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DECCE4A0B;
	Wed,  3 Jan 2024 00:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ainNOmnH"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 319EE1FBA;
	Wed,  3 Jan 2024 00:53:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EA81C433C7;
	Wed,  3 Jan 2024 00:53:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704243184;
	bh=aGZnPvr4auoaajRItapwmxnfamYJ7VBP+86V+sLoGb4=;
	h=In-Reply-To:References:Subject:From:To:Date:From;
	b=ainNOmnHtaaIJl0KzcZotI236oO9X74rU4MkN06uP8GnxgYcAfDwYGG+xHhcTDfDN
	 59Ts0/btu//SjYmKXBxs8gxnoPhq0JGXFBc8hoVJ7xbJzbn9B+CZAkkatU0yGU8qbx
	 Ru1Wdny1bVPm9nVDPWQCrksx1laTwYFp846LE05rpRZP3MB96N3mYnzHFsMcNGiPt1
	 A/QIzLXl+9QsZm7GTRR3MYuk/gfFxWDcMjVhcCmBm9pspOxL+efu2RfuJUtmEVVIND
	 bPLPuC+pCg5MmSACZXozS6mIeo/BjOTmX/26D98814JBqQXLTgwhu+RNCH1V7+gqbq
	 7xTw81vDMx09Q==
Message-ID: <d64b67fac1a9087c825bf1a86be17af7.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <3b9c65ddb08c8bedf790aacf29871af026b6f0b7.1702849494.git.daniel@makrotopia.org>
References: <27f99db432e9ccc804cc5b6501d7d17d72cae879.1702849494.git.daniel@makrotopia.org> <3b9c65ddb08c8bedf790aacf29871af026b6f0b7.1702849494.git.daniel@makrotopia.org>
Subject: Re: [PATCH v7 4/5] clk: mediatek: add pcw_chg_bit control for PLLs of MT7988
From: Stephen Boyd <sboyd@kernel.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Chen-Yu Tsai <wenst@chromium.org>, Conor Dooley <conor+dt@kernel.org>, Dan Carpenter <dan.carpenter@linaro.org>, Daniel Golle <daniel@makrotopia.org>, David S. Miller <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Frank Wunderlich <frank-w@public-files.de>, Garmin.Chang <Garmin.Chang@mediatek.com>, Jakub Kicinski <kuba@kernel.org>, James Liao <jamesjj.liao@mediatek.com>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Matthias Brugger <matthias.bgg@gmail.com>, Michael Turquette <mturquette@baylibre.com>, Paolo Abeni <pabeni@redhat.com>, Philipp Zabel <p.zabel@pengutronix.de>, Rob Herring <robh+dt@kernel.org>, Sabrina Dubroca <sd@queasysnail.net>, Sam Shih <sam.shih@mediatek.com>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
Date: Tue, 02 Jan 2024 16:53:02 -0800
User-Agent: alot/0.10

Quoting Daniel Golle (2023-12-17 13:50:07)
> From: Sam Shih <sam.shih@mediatek.com>
>=20
> Introduce pcw_chg_bit member to struct mtk_pll_data and use it instead
> of the previously hardcoded PCW_CHG_MASK macro if set.
> This will needed for clocks on the MT7988 SoC.
>=20
> Signed-off-by: Sam Shih <sam.shih@mediatek.com>
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collab=
ora.com>
> ---

Applied to clk-next


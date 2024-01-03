Return-Path: <linux-kernel+bounces-15016-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D4B282262D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 01:54:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6D6A1F222E4
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 00:54:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E040C8C0D;
	Wed,  3 Jan 2024 00:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SWGa1Atq"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31961171C4;
	Wed,  3 Jan 2024 00:53:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88358C433C8;
	Wed,  3 Jan 2024 00:53:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704243195;
	bh=hIc7vil6oQXNWIFG6TyLDS6yimIz2qi/c2PwKRpmK7E=;
	h=In-Reply-To:References:Subject:From:To:Date:From;
	b=SWGa1Atq4YkIusWtYtpoNkl5HcChw+0/A5eSXdtb8A1OjYGaU4MdVuE6ilLD7EZec
	 2gW0VoN12JDQdj1A4hEcP9+t1u5tGsD0W2PGerruosDQopLKPeO2eUYBfHPI3+GUpp
	 KC/x2uoNFjnY8yFsEr2qjANnVRwgAwvM2zsqto4TWm0UpzkSudUDe5gF4SyT5y3OLN
	 D4yS+eiI48qoSDLJzVg4HzyRFM+YNNj5mh3B2/3Sbq999WraoYZsKEu4/ygUiVJFWH
	 XKvAawQF7cR/gb1l7QepdquDnqHUdfe4wvT/Zxj3keNp+nl0N/I48/Ys6sSZF6Dy/c
	 qLCsC0035PfFg==
Message-ID: <f2ee0e96fc2467fdf44b960d0ffe94c1.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <c7574d808e2da1a530182f0fd790c1337c336e1b.1702849494.git.daniel@makrotopia.org>
References: <27f99db432e9ccc804cc5b6501d7d17d72cae879.1702849494.git.daniel@makrotopia.org> <c7574d808e2da1a530182f0fd790c1337c336e1b.1702849494.git.daniel@makrotopia.org>
Subject: Re: [PATCH v7 5/5] clk: mediatek: add drivers for MT7988 SoC
From: Stephen Boyd <sboyd@kernel.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Chen-Yu Tsai <wenst@chromium.org>, Conor Dooley <conor+dt@kernel.org>, Dan Carpenter <dan.carpenter@linaro.org>, Daniel Golle <daniel@makrotopia.org>, David S. Miller <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Frank Wunderlich <frank-w@public-files.de>, Garmin.Chang <Garmin.Chang@mediatek.com>, Jakub Kicinski <kuba@kernel.org>, James Liao <jamesjj.liao@mediatek.com>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Matthias Brugger <matthias.bgg@gmail.com>, Michael Turquette <mturquette@baylibre.com>, Paolo Abeni <pabeni@redhat.com>, Philipp Zabel <p.zabel@pengutronix.de>, Rob Herring <robh+dt@kernel.org>, Sabrina Dubroca <sd@queasysnail.net>, Sam Shih <sam.shih@mediatek.com>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
Date: Tue, 02 Jan 2024 16:53:13 -0800
User-Agent: alot/0.10

Quoting Daniel Golle (2023-12-17 13:50:15)
> From: Sam Shih <sam.shih@mediatek.com>
>=20
> Add APMIXED, ETH, INFRACFG and TOPCKGEN clock drivers which are
> typical MediaTek designs.
>=20
> Also add driver for XFIPLL clock generating the 156.25MHz clock for
> the XFI SerDes. It needs an undocumented software workaround and has
> an unknown internal design.
>=20
> Signed-off-by: Sam Shih <sam.shih@mediatek.com>
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collab=
ora.com>
> ---

Applied to clk-next


Return-Path: <linux-kernel+bounces-15008-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31D4D822611
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 01:51:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D506D284691
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 00:51:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18DF3812;
	Wed,  3 Jan 2024 00:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WxVaI969"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 675487F1;
	Wed,  3 Jan 2024 00:51:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C851DC433C8;
	Wed,  3 Jan 2024 00:51:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704243084;
	bh=LWs+wtOQwJE2KAvg5du9NptcRU9govH4f+98sicou70=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=WxVaI9694aQvo58unwJTq2noH7ZFX0/naboe8Y0fEDYRJ5cFrH5OcfVD5EugMdpVz
	 cZjjygm2a49RIB7BSTOdyvCoUlxvvotFFLH7ZpVmu/Jo2zg3t6tlkVC1zSJeavIM2t
	 l2T5YbZ3Qi2ONbciE753zohKOsDnfOrfgb8sXZfDiUg0tOpbbPQgopdIzSJYLaB1xH
	 jGuCcV1U3eSPFoUvIK8KkKmYOWNsebz95wOPBhR5sJdBMOVN+HWbYptkdcLFTQyUnz
	 bypp6ZsI+eEmAiPViaiCRYYi6r52hIC+XLWVdn5rwHlbna/pWGh7AJ0L5vS0KW5IRH
	 uwk74UZBvwJzA==
Message-ID: <616e957ebb9d6606ccfdccb822aa0c42.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20231103102533.69280-2-angelogioacchino.delregno@collabora.com>
References: <20231103102533.69280-1-angelogioacchino.delregno@collabora.com> <20231103102533.69280-2-angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH v3 1/3] clk: mediatek: clk-mux: Support custom parent indices for muxes
From: Stephen Boyd <sboyd@kernel.org>
Cc: mturquette@baylibre.com, matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com, wenst@chromium.org, msp@baylibre.com, amergnat@baylibre.com, yangyingliang@huawei.com, u.kleine-koenig@pengutronix.de, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, kernel@collabora.com
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Date: Tue, 02 Jan 2024 16:51:22 -0800
User-Agent: alot/0.10

Quoting AngeloGioacchino Del Regno (2023-11-03 03:25:31)
> Add support for customized parent indices for MediaTek muxes: this is
> necessary for the case in which we want to exclude some clocks from
> a mux's parent clocks list, where the exclusions are not from the
> very bottom of the list but either in the middle or the beginning.
>=20
> Example:
> - MUX1 (all parents)
>   - parent1; idx=3D0
>   - parent2; idx=3D1
>   - parent3; idx=3D2
>=20
> - MUX1 (wanted parents)
>   - parent1; idx=3D0
>   - parent3; idx=3D2
>=20
> To achieve that add a `parent_index` array pointer to struct mtk_mux,
> then in .set_parent(), .get_parent() callbacks check if this array
> was populated and eventually get the index from that.
>=20
> Also, to avoid updating all clock drivers for all SoCs, rename the
> "main" macro to __GATE_CLR_SET_UPD_FLAGS (so, `__` was added) and
> add the new member to it; furthermore, GATE_CLK_SET_UPD_FLAGS has
> been reintroduced as being fully compatible with the older version.
>=20
> The new parent_index can be specified with the new `_INDEXED`
> variants of the MUX_GATE_CLR_SET_UPD_xxxx macros.
>=20
> Reviewed-by: Alexandre Mergnat <amergnat@baylibre.com>
> Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@coll=
abora.com>
> ---

Applied to clk-next


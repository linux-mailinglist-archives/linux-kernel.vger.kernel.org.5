Return-Path: <linux-kernel+bounces-7023-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A39281A09A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 15:03:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D50E1C23A37
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 14:03:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 297973B1B6;
	Wed, 20 Dec 2023 14:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="02iIW6zB"
X-Original-To: linux-kernel@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF3F93B285;
	Wed, 20 Dec 2023 14:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1703080955;
	bh=KGE66kX/77SCl68GCuAYkM5Fd1OaPVPaz8BPsJaZaSU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=02iIW6zBQjbAIb+TjCYezbs9kecXN6EY5WKxdS3M7MEqckJfl8938Plvewo1ig5RN
	 QQuWzG5o5g3kRAfyvbIMfrj2RRT38xSZlzXFzX9rW/IcPkG9X7tNJP/Kl1NaBaEc0/
	 Z9tVT7KYHPalovCBu7Fw5Sbbc8rQAEbxMuv29ku8l/y9TS5xCMBF2dk+4Bm31WJnao
	 YmPdgNN/22SrkG98xRgVwbSIYHSUvwvDXm0QTqFPKwtAxW+vc8hBIOy+5Xh8qSV6LT
	 RJOKiKayyAXdt89OMl7Lf9gcLf5cQWffB4VZ5IltlcVbCnkJ7ysVPVnCHj5nEVkB4V
	 vFGSxqyo6IZqQ==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 2B9703781F8C;
	Wed, 20 Dec 2023 14:02:34 +0000 (UTC)
Message-ID: <cbbcb801-916a-445d-8b36-60d470b61d46@collabora.com>
Date: Wed, 20 Dec 2023 15:02:33 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/3] MediaTek clocks: Support mux indices list and 8195
 DP
Content-Language: en-US
To: sboyd@kernel.org
Cc: mturquette@baylibre.com, matthias.bgg@gmail.com, wenst@chromium.org,
 msp@baylibre.com, amergnat@baylibre.com, yangyingliang@huawei.com,
 u.kleine-koenig@pengutronix.de, linux-clk@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, kernel@collabora.com
References: <20231103102533.69280-1-angelogioacchino.delregno@collabora.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20231103102533.69280-1-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 03/11/23 11:25, AngeloGioacchino Del Regno ha scritto:
> Changes in v3:
>   - Rebased on next-20231025
>   - Added comment in the code explaining why the dp/edp parents lists
>     are split in one PLL per interface
>   - Added a commit performing the same reparenting on MT8188 as well
> 
> Changes in v2:
>   - Rebased on next-20231018
> 

Hello Stephen,

friendly ping for this fully reviewed/tested series :-)

Cheers,
Angelo

> This series adds support to specify custom parent indices for MediaTek
> MUX clocks, necessary to avoid setting the same parent PLL for MT8195's
> top_dp and top_edp clocks, solving DP+eDP concurrent output issues.
> 
> No fixes tags are provided as the clk-mux commit introduces new logic
> and the actual MT8195 fix depends on that.
> 
> This commit was tested on the Acer Tomato Chromebook (MT8195) with
> dual concurrent display outputs (internal eDP panel and TypeC->DP->HDMI
> adapter connected to Samsung UE40JU6400 4k TV); resolution switch on
> DP was also tested; eDP output is not paused and internal display keeps
> working as expected.
> 
> 
> After feedback on v1 of this series (effectively the same as v2, except
> for the rebase), I looked for an alternative solution with using
> clk_set_rate_exclusive() as proposed. Couldn't find any, as that still
> doesn't give any guarantee about selecting the same PLL that the driver
> was manipulating before setting the right divider MUX, hence that still
> wouldn't work correctly.
> 
> For more context, please look at the conversation at [1].
> 
> Cheers!
> 
> [1] https://lore.kernel.org/linux-arm-kernel/20230713072138.84117-1-angelogioacchino.delregno@collabora.com
> 
> AngeloGioacchino Del Regno (3):
>    clk: mediatek: clk-mux: Support custom parent indices for muxes
>    clk: mediatek: mt8195-topckgen: Refactor parents for top_dp/edp muxes
>    clk: mediatek: mt8188-topckgen: Refactor parents for top_dp/edp muxes
> 
>   drivers/clk/mediatek/clk-mt8188-topckgen.c | 27 +++++++-------
>   drivers/clk/mediatek/clk-mt8195-topckgen.c | 27 ++++++++++----
>   drivers/clk/mediatek/clk-mux.c             | 14 +++++++
>   drivers/clk/mediatek/clk-mux.h             | 43 ++++++++++++++++++++--
>   4 files changed, 86 insertions(+), 25 deletions(-)
> 





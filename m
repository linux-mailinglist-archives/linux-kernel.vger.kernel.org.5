Return-Path: <linux-kernel+bounces-14200-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5279C821904
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 10:42:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E975CB215F2
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 09:42:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39E006FB3;
	Tue,  2 Jan 2024 09:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="vwpbM4Ek"
X-Original-To: linux-kernel@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E7CDD27F;
	Tue,  2 Jan 2024 09:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1704188507;
	bh=FyLks047y5EHUM2OKY0gTkVd8p2xO2+y8kTMjKFijSg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=vwpbM4EknSe+s+iyX71PYvZayhxWo+dUMoNsHsri18wj1l3ZS3hUxt9FFhZjr6tto
	 IC/7DUykfGCRE7vgGNQfeldwcVLsSRHO9HC37m/GO7h9P9wY9RKAlcU0kaguoFaX9r
	 3N3EzQbhdspbUtxvcJL7oehKuNPcUmSMvaE519+uZ4AXEJZJ472+3cHFuBWJIgg81c
	 R+XEmQz0hJMnn8MR5aIqAMxawvkyhlKy87lz5OUv0CQsBia6AGxKyiKgcnuYM2YJya
	 iqrngmitpclR0jCLy4wsH2RWqdpcze3Wpwp5jo23rTr8I5Vx32hfDJbm/PO4s+s66F
	 DLxraCut+Yl3A==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id A82E63781433;
	Tue,  2 Jan 2024 09:41:46 +0000 (UTC)
Message-ID: <0bfa27e8-c173-4a2a-b453-9289f2eb1926@collabora.com>
Date: Tue, 2 Jan 2024 10:41:45 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] clk: mediatek: fix cppcheck error for uninitialized
 variable
Content-Language: en-US
To: mturquette@baylibre.com, sboyd@kernel.org, matthias.bgg@gmail.com,
 kishan.dudhatra@siliconsignals.io
Cc: Chen-Yu Tsai <wenst@chromium.org>, Tom Rix <trix@redhat.com>,
 linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
References: <20231225152806.3716898-1-user@falcon>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20231225152806.3716898-1-user@falcon>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 25/12/23 16:28,  ha scritto:
> From: Kishan Dudhatra <kishan.dudhatra@siliconsignals.io>
> 
> cppcheck reports below warning
> 
> clk/mediatek/clk-fhctl.c:206:27:
> error: Uninitialized variable: pll_postdiv [uninitvar]
> if (postdiv && postdiv < pll_postdiv)
> 
> This is due to uninitialization of variable pll_postdiv,
> which is now initialized as part of this patch.
> 
> Signed-off-by: Kishan Dudhatra <kishan.dudhatra@siliconsignals.io>

This is a false positive... the pll_postdiv variable is *always* used
and *only if* postdiv > 0.

P.S.: There was some problem with your email, as the From entry is empty.

Regards,
Angelo

> 
> diff --git a/drivers/clk/mediatek/clk-fhctl.c b/drivers/clk/mediatek/clk-fhctl.c
> index 33b6ad8fdc2e..b0e71e4fd938 100644
> --- a/drivers/clk/mediatek/clk-fhctl.c
> +++ b/drivers/clk/mediatek/clk-fhctl.c
> @@ -186,7 +186,7 @@ static int fhctl_hopping(struct mtk_fh *fh, unsigned int new_dds,
>   	struct fh_pll_regs *regs = &fh->regs;
>   	struct mtk_clk_pll *pll = &fh->clk_pll;
>   	spinlock_t *lock = fh->lock;
> -	unsigned int pll_postdiv;
> +	unsigned int pll_postdiv = 0;
>   	unsigned long flags = 0;
>   	int ret;
>   




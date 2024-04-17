Return-Path: <linux-kernel+bounces-149079-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 33FD38A8B8E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 20:49:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8F511F2545D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 18:49:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FA3518C05;
	Wed, 17 Apr 2024 18:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="enOe844T"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7429B18C1F;
	Wed, 17 Apr 2024 18:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713379735; cv=none; b=XhCyp0SjpzfOIT3cWQVtkZV2sw6WlA5BKeCGGFGP7poQHuE32cvD4oGhVIoE7YoP1D31KSj6IboTQTFC4ftnysKAoIGXBTV5UsdJutRVsSN5CA/BmhWKfmjBgSs3qGMyTv9yuoQorolLkjLEHbRalYl6rMSgO4lLgm7LRpMegC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713379735; c=relaxed/simple;
	bh=G8GIybraBwjNANFsfBZMgV1ID9PPWhVL2d7h1yYhQ/Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q6LlujhGsyaXDZNCzlR8t8CSwldNhIbR+DBspaGS4sRZfAbILAqkp+08AA9eakQ0H9KwPYEExt0GVeXezqRkS5N0lu2CgXUJ1Z5Muwb4xlNvHEY0xpWJ+zkevam91KeK5ocjAhwS4cN3e006+Tax0R7JlAbYjQ9u9MlVzqB1HTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=enOe844T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5CD8C072AA;
	Wed, 17 Apr 2024 18:48:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713379735;
	bh=G8GIybraBwjNANFsfBZMgV1ID9PPWhVL2d7h1yYhQ/Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=enOe844TybHefFLgLKohLJ8NrDDYN5akkxh9ac6bh3LAlfCl8o1A3zf/P7CQZ4iCl
	 Y+uAka/Zvkj6J2S1BCZbYE5BRnC8RkGuLGYaTc/ZtRfRTlOZbzTLFp0k3V02AQ7kTN
	 UgEZa7ineprrYbfbd877ByxyqDCMvyIoYw1R5cHeCufvSrD0Q6qcyvrYcMsBGJRFvC
	 n6Fsxj7qxGP3HL30LM8GbtXLKg1fh+e+RcXGdWGeNaTi6BfsLtf3fEUcNQfktXLTI6
	 8eKrrVscwbZRB3FER5avz6QhsW4Dg2dAXCn6TlApSVOydaG6xCpAXaJ2Pmo2lystO5
	 G7w5sAHxlww6Q==
Date: Wed, 17 Apr 2024 13:48:52 -0500
From: Rob Herring <robh@kernel.org>
To: Alexandre Mergnat <amergnat@baylibre.com>
Cc: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Will Deacon <will@kernel.org>, Daniel Vetter <daniel@ffwll.ch>,
	David Airlie <airlied@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	CK Hu <ck.hu@mediatek.com>, linux-arm-kernel@lists.infradead.org,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-pwm@vger.kernel.org, linux-mediatek@lists.infradead.org,
	Jitao Shi <jitao.shi@mediatek.com>, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	Chun-Kuang Hu <chunkuang.hu@kernel.org>,
	Maxime Ripard <mripard@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Michael Turquette <mturquette@baylibre.com>,
	linux-clk@vger.kernel.org
Subject: Re: [PATCH v2 12/18] dt-bindings: pwm: mediatek,pwm-disp: add
 compatible for mt8365 SoC
Message-ID: <171337963668.3079720.13585358179949689962.robh@kernel.org>
References: <20231023-display-support-v2-0-33ce8864b227@baylibre.com>
 <20231023-display-support-v2-12-33ce8864b227@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231023-display-support-v2-12-33ce8864b227@baylibre.com>


On Tue, 16 Apr 2024 17:53:13 +0200, Alexandre Mergnat wrote:
> Add a compatible string for MediaTek Genio 350 MT8365's display PWM
> block: this is the same as MT8183.
> 
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
> ---
>  Documentation/devicetree/bindings/pwm/mediatek,pwm-disp.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>



Return-Path: <linux-kernel+bounces-149069-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D16C68A8B5C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 20:43:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89411284F8A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 18:43:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4816D171A1;
	Wed, 17 Apr 2024 18:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q8axs5js"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F6E6101C8;
	Wed, 17 Apr 2024 18:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713379429; cv=none; b=ELzgjrdiW4cY0E17WjB0U2LIQ/FfoPC0KtvvnSM1I3Cml7ioYDP5bA5xevBB3wiNzX8mYz4k3wHbOGXC76VaCpKxMgYf6eQv/zS6/3aWEvStfpVZwcBgPuWmWjVdQvcn6j0U5T11bOm1fx6VCogo9VRdvALXoNExxwwPic2ZfvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713379429; c=relaxed/simple;
	bh=GoGburzh7FkizELo7yYYyqndy8Qgc/VgEIB9/YUTE2M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XESj00jJRKRinsUFWSn4OzQgN8tq0MpQURrXS7xlJeRVAS2LeLD82ueHxE+tAhRqoOCEfGiV+6NrNng9ALcsT+H+QrNoaYd2KkK5oTSlypRa4Epp+n5kBSs1scuR8/UKHWJk5tPnWkXMstkO1xdhqrh69HVHgh+loaC7f/3wBlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q8axs5js; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16B3FC072AA;
	Wed, 17 Apr 2024 18:43:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713379429;
	bh=GoGburzh7FkizELo7yYYyqndy8Qgc/VgEIB9/YUTE2M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Q8axs5jsyp6NQNvyM01T71kH7P0f0QJZ+LV7l/ImxNglfR042hbt8sGgOV2EVzD2y
	 HvkEo7+f/FI4a1BpPOkI4N//5cmxMWTBud2fgfYIOLLAiuHOGUCeoizCi9lDu8a2y0
	 X7k2e9zsheh/M5ChuNRQ1tG/Zy0okVw5zN21hVNr8bnJrbshUyRtI78R6b1XlST6+z
	 baVFDACFXcfvCj3zWIyWi32iNlwmkraiAgecgIkusovSOtGitaOZ6zttCvK8Jw7tO3
	 tyYAksQ3kqNNVVv7jyVGufKVlUDo06kWgkwaeBRXTDn+J9vD6836WVvsFydNhXfEN+
	 f7qGp3x2fhLSg==
Date: Wed, 17 Apr 2024 13:43:47 -0500
From: Rob Herring <robh@kernel.org>
To: Alexandre Mergnat <amergnat@baylibre.com>
Cc: linux-mediatek@lists.infradead.org,
	Michael Turquette <mturquette@baylibre.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	CK Hu <ck.hu@mediatek.com>, Will Deacon <will@kernel.org>,
	linux-clk@vger.kernel.org,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	linux-kernel@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
	Chun-Kuang Hu <chunkuang.hu@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, linux-pwm@vger.kernel.org,
	Maxime Ripard <mripard@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	dri-devel@lists.freedesktop.org,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Jitao Shi <jitao.shi@mediatek.com>,
	linux-arm-kernel@lists.infradead.org,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 04/18] dt-bindings: display: mediatek: dither: add
 compatible for MT8365 SoC
Message-ID: <171337930720.3072538.14983399612920659729.robh@kernel.org>
References: <20231023-display-support-v2-0-33ce8864b227@baylibre.com>
 <20231023-display-support-v2-4-33ce8864b227@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231023-display-support-v2-4-33ce8864b227@baylibre.com>


On Tue, 16 Apr 2024 17:53:05 +0200, Alexandre Mergnat wrote:
> Document the display Dither on MT8365, which is compatible
> with that of the MT8183.
> 
> Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
> ---
>  Documentation/devicetree/bindings/display/mediatek/mediatek,dither.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>



Return-Path: <linux-kernel+bounces-149075-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 599B58A8B7F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 20:48:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88B761C21ECF
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 18:48:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C21AE1CD38;
	Wed, 17 Apr 2024 18:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZPhq6wed"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 076A5182AF;
	Wed, 17 Apr 2024 18:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713379670; cv=none; b=Uepe8zN5eac6JQrPs4Xs85FiiPfQ3bPV/ilA6eff6fjTGLULNNvOGUUEEwOELpJAY7INfb8YoswbCYuXmaOlLPFIvONK9U29XcSeR3YV3SBrDsn0re7fYWFtL380Pdsr7hnz3RY3NKwU4omhdJCKTyLGft9qTFkajz/LXDUAoss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713379670; c=relaxed/simple;
	bh=c9Av6o+YhLzxWvGJbvdnDzM0A1WFzVOKqpppzIkYBew=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GIv3AOwFGVZ4ms4dEBZB8h+cE0uH27m/ijO2PJ4x98b9UH9skpiiMN3BN6CS/PcB5mLS8u6Rrb0vnIBOv12BeAYHt09iVjxWQcmtpipW1l71SUxpSb5+eRkEKUUPN9fUsU8I5fhvLEv6/N9e/zRrEox8lt/z+wR6jc224l1pkn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZPhq6wed; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AC3FC4AF09;
	Wed, 17 Apr 2024 18:47:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713379669;
	bh=c9Av6o+YhLzxWvGJbvdnDzM0A1WFzVOKqpppzIkYBew=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZPhq6wedeLHOrrwuCBotkgaK2YQvNJkASflMHQybFwz3oRVCTQ2VNF87Xk0H3mVgR
	 ZAEyYaP51ItqOxFXP22SY2c+JHzneUkXlpeeG5Aq7pSrmwVG5pkjEd0L3qhfwfsTQT
	 R/s1KIS7YafuNt7vFR9HvdvJYjjrbzpVw4tc6QVMpYesYDJ4SNZMK0J/UghzaiaXKD
	 yxQI7ZqC1Ot+26HRMyJeyd0aWKKNW7xS4reJTEaFDzezQYIjMiw9Tk/tH0+m2IfoEk
	 vFGQGoyzyFzyKyQUISfXQQNAGfPL4m0Y0CgxRaOPmi6PBsTlYaGMoodE9Odx5PuKtJ
	 4AhlKSpugNDYg==
Date: Wed, 17 Apr 2024 13:47:47 -0500
From: Rob Herring <robh@kernel.org>
To: Alexandre Mergnat <amergnat@baylibre.com>
Cc: Jitao Shi <jitao.shi@mediatek.com>, Will Deacon <will@kernel.org>,
	CK Hu <ck.hu@mediatek.com>, linux-arm-kernel@lists.infradead.org,
	linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Maxime Ripard <mripard@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Chun-Kuang Hu <chunkuang.hu@kernel.org>,
	David Airlie <airlied@gmail.com>, dri-devel@lists.freedesktop.org,
	Philipp Zabel <p.zabel@pengutronix.de>, linux-clk@vger.kernel.org,
	Daniel Vetter <daniel@ffwll.ch>, Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	linux-mediatek@lists.infradead.org,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH v2 09/18] dt-bindings: display: mediatek: ovl: add
 compatible for MT8365 SoC
Message-ID: <171337954796.3077788.17153176697074002741.robh@kernel.org>
References: <20231023-display-support-v2-0-33ce8864b227@baylibre.com>
 <20231023-display-support-v2-9-33ce8864b227@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231023-display-support-v2-9-33ce8864b227@baylibre.com>


On Tue, 16 Apr 2024 17:53:10 +0200, Alexandre Mergnat wrote:
> Document the display Overlay on MT8365, which is compatible
> with that of the MT8192.
> 
> Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
> ---
>  Documentation/devicetree/bindings/display/mediatek/mediatek,ovl.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>



Return-Path: <linux-kernel+bounces-149068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E96B8A8B57
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 20:43:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CDD40285713
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 18:43:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DA8D14293;
	Wed, 17 Apr 2024 18:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rW1Ay7cc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A34C622324;
	Wed, 17 Apr 2024 18:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713379411; cv=none; b=mFGv/9042IV7aCSvJa9YO9d7fPmYsyq1GtXxKsBlEn3YnHh3e5UM1QQWW0WwAbjIS6XRmmZbft8Y3339iF5uSMZjCeWeTuqbbdO22SISGxAU5WA3gEW2AlY8G0Gop7ROsX3+NxQBmqPPqov6jeNq/03mnNjLELq8/uHB/d1Nxzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713379411; c=relaxed/simple;
	bh=dFYWzHQ5XhOLNcLBWopk7yt+oDCScDnJkVXbAbyCzQ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y9oM+yph/1KQmwXhnPhx0lAHZa0w0i2ye6JeKUDRBHTMEc7VDx21EdXp+D2DIs6XTp7G4bfHBs5uahVaf4sQMtbRAj1OHf7gjEho57uEg8S1YKD3yOV8VKj0VhYFeq++v9go14joo8zm9Do3KjCgBqy8b9XxGCpyUs5QLQXL8/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rW1Ay7cc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E77C2C072AA;
	Wed, 17 Apr 2024 18:43:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713379411;
	bh=dFYWzHQ5XhOLNcLBWopk7yt+oDCScDnJkVXbAbyCzQ0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rW1Ay7ccX1KEO4VVvbsYKxiFm5kp1rXQq6OTSarcxSyYeD5R6JxicGVX0yM9cGnEb
	 tmUCi7sq9lwhOcyLl4KuGDQmXYcvjNe+B0uYmDWCOweZwbhosal+utYl8ydaJ7i9AB
	 ZgJ/qXnsqAqHGD5L/+vkWBlLwW1owqK0i2+6xgErjZyxEWkhdv8MbZ5PcHsh8XkWJF
	 bBIPEiF4omhN+HCw6K3LwcLFRBU5Saj37GqGZ2yDInEpNuJcEv52XYqE/9/LRYDdBH
	 VuHGuZIUHT+jIDUW8jWZYBnY8Sb2YFiqjusN9R53+z+BL2ypemRsNnNFib8NCnQm4m
	 /UalqQQPIgfMQ==
Date: Wed, 17 Apr 2024 13:43:28 -0500
From: Rob Herring <robh@kernel.org>
To: Alexandre Mergnat <amergnat@baylibre.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	linux-kernel@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	linux-clk@vger.kernel.org, Jitao Shi <jitao.shi@mediatek.com>,
	linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org,
	Matthias Brugger <matthias.bgg@gmail.com>,
	linux-mediatek@lists.infradead.org,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Chun-Kuang Hu <chunkuang.hu@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	dri-devel@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
	David Airlie <airlied@gmail.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	Conor Dooley <conor+dt@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Maxime Ripard <mripard@kernel.org>, Will Deacon <will@kernel.org>,
	CK Hu <ck.hu@mediatek.com>
Subject: Re: [PATCH v2 03/18] dt-bindings: display: mediatek: color: add
 compatible for MT8365 SoC
Message-ID: <171337929795.3072251.7033355429164409851.robh@kernel.org>
References: <20231023-display-support-v2-0-33ce8864b227@baylibre.com>
 <20231023-display-support-v2-3-33ce8864b227@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231023-display-support-v2-3-33ce8864b227@baylibre.com>


On Tue, 16 Apr 2024 17:53:04 +0200, Alexandre Mergnat wrote:
> Document the display Color on MT8365, which is compatible
> with that of the MT8173.
> 
> Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
> ---
>  Documentation/devicetree/bindings/display/mediatek/mediatek,color.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>



Return-Path: <linux-kernel+bounces-149071-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA7608A8B66
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 20:44:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86646285085
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 18:44:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABA6218C1F;
	Wed, 17 Apr 2024 18:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F7xHnyGb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E43C4101C8;
	Wed, 17 Apr 2024 18:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713379455; cv=none; b=sRQAuJtqo7e/Iu777o/IyZ2a4I3MWJ3a7bRksTn2+79mdiRqTfJYxOF5Sov7yQgZZyTiBnmDT5xuReXw+pG8Uf+WqIf/ZH5Cvg+b2tSEqoFRJTuTfs8AYy4NmJih4W8cwzi6/vPwCzfiEZr/MgM+rKugVYsdi+5ZW1grVtg3Bjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713379455; c=relaxed/simple;
	bh=2ijxgrIHFYlo+GOYxQUQaAYvtvwZmGTQ2OkkC70Xwc8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YL5rmHXoqzZbj8GlLG3R1kWwqbs5yo5DpSDrLEiHpabekq+cBpJmvrB8lnhwBhZHKKDE1ITGbfYpRIr924gydoXatHT8xNQ6sjR5ODHv0k7IXBV3Ppu0Ztu45un3whoiZyxevY7l3FLdYVpxu3EFhYpnQzG/rf2LFjwlr68beUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F7xHnyGb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3ED07C072AA;
	Wed, 17 Apr 2024 18:44:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713379454;
	bh=2ijxgrIHFYlo+GOYxQUQaAYvtvwZmGTQ2OkkC70Xwc8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=F7xHnyGbTsVvEE1N1oxm22yuvvaX5ZM3WZh1+mqGMAbi6rZ6z21Hq94xdKxHpojCB
	 kTbdwunZJUl9GiW0AmFpF5e1e/ZQVBNtX2zVBZQT9Z4iQ5loPwhgnKsD4IokktLiYf
	 1qaoJ86vGegu1OXvjV7DtU66KOCwvC1ypK8cQ7srHnCa9Kr8lMqvRsdOcBBi9P4cad
	 wSCb17RhmPC89oqDb727+mY4MrFr4KAODRKig841Mh+MamqQavjmIUGw5sbNXU7p5n
	 i56Kv4vpRBWYGZsfRv4Jyzq7UX3b/HXGt66ME7DhZG6vSj4fgNPXtHlEJrkVNtehqZ
	 P4yPrSzEuEOPA==
Date: Wed, 17 Apr 2024 13:44:12 -0500
From: Rob Herring <robh@kernel.org>
To: amergnat@baylibre.com
Cc: linux-arm-kernel@lists.infradead.org,
	Thomas Zimmermann <tzimmermann@suse.de>,
	linux-kernel@vger.kernel.org, Will Deacon <will@kernel.org>,
	linux-mediatek@lists.infradead.org,
	Chun-Kuang Hu <chunkuang.hu@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Michael Turquette <mturquette@baylibre.com>,
	David Airlie <airlied@gmail.com>, linux-pwm@vger.kernel.org,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	Stephen Boyd <sboyd@kernel.org>, Maxime Ripard <mripard@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	CK Hu <ck.hu@mediatek.com>, Conor Dooley <conor+dt@kernel.org>,
	Fabien Parent <fparent@baylibre.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Daniel Vetter <daniel@ffwll.ch>, linux-clk@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
	Jitao Shi <jitao.shi@mediatek.com>
Subject: Re: [PATCH v2 06/18] dt-bindings: display: mediatek: dpi: add
 power-domains property
Message-ID: <171337936237.3073760.2764344003363574998.robh@kernel.org>
References: <20231023-display-support-v2-0-33ce8864b227@baylibre.com>
 <20231023-display-support-v2-6-33ce8864b227@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231023-display-support-v2-6-33ce8864b227@baylibre.com>


On Tue, 16 Apr 2024 17:53:07 +0200, amergnat@baylibre.com wrote:
> From: Fabien Parent <fparent@baylibre.com>
> 
> DPI is part of the display / multimedia block in MediaTek SoCs, and
> always have a power-domain (at least in the upstream device-trees).
> Add the power-domains property to the binding documentation.
> 
> Signed-off-by: Fabien Parent <fparent@baylibre.com>
> Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
> ---
>  Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.yaml | 5 +++++
>  1 file changed, 5 insertions(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>



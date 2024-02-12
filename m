Return-Path: <linux-kernel+bounces-62529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF413852262
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 00:23:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDA921C230FC
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 23:23:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88EC94F88D;
	Mon, 12 Feb 2024 23:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jBplwNVL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBA7A4F5EA;
	Mon, 12 Feb 2024 23:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707780180; cv=none; b=P7Sn0YRydxFcb7JnMYAOdv68++sd0CFNBVwiJOe4Xg1SPCaVE+o2ZpfDnxJ4tqaWdiqRK72Cz8a/AFQL3+yPu2i/WYQTVs7HFgBIZgw7YZ93kuJOPjdNbKttatECqTq5f/3WpgarkI++D3uF1mRLTFw4aeP6QwER3ni/RrjjXws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707780180; c=relaxed/simple;
	bh=XWqdgb3L3o8wIr1+5PSvPQXWLlZ0UO8V5aBZgH2XA90=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RapgVIpVBAG3Dfc5rWMyTcNNtYfyLszLoo25He5SGSpxW8XG3cwX5D69oKLhb+UvMjO8WBajJYvd8GiUHIyWhlEY9x0VBBSR087XqZPC/w4Ea5l8ly5P9yzEllJ2B7Kr778uQIEIZbDNZ8qwaISnraPxQ3UM/qi+FAJyflC5jSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jBplwNVL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02BD0C433F1;
	Mon, 12 Feb 2024 23:23:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707780180;
	bh=XWqdgb3L3o8wIr1+5PSvPQXWLlZ0UO8V5aBZgH2XA90=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jBplwNVLpdn+QXj4vDN4+N4Yf6S7EVzb9pJH+z2MjSAFrxtMprTc24r+I0F9415Ja
	 MBfz/gJkl7h05RKSqLZbKH5gA8hmJHKeQnmxdaejUndfGaOnzxql3kQc4dIVZAKZF2
	 rVyE1QVV9+lPfDEnJOGbMhFdlJ/Obpkm3ZGD3YF6MbDi0YT1hlHpx++bsJFV3p566P
	 F2hsXLYj2fs6cGDazIeVhgUXDCLb5R9VRJeVJ2chtgbedDvSLNG5ci51zriKYy+N2x
	 vdsDbb6PTD6nur4Ac23KM6ObKOjfKaCN0SsM8LPyVHtIsTATvQ6A51exkfO6zUuS7L
	 FfxgTmasRmaew==
Received: by mercury (Postfix, from userid 1000)
	id 3A674106A041; Tue, 13 Feb 2024 00:22:57 +0100 (CET)
Date: Tue, 13 Feb 2024 00:22:57 +0100
From: Sebastian Reichel <sre@kernel.org>
To: Rob Herring <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, NXP Linux Team <linux-imx@nxp.com>, 
	Dong Aisheng <aisheng.dong@nxp.com>, Linus Walleij <linus.walleij@linaro.org>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Mark Brown <broonie@kernel.org>, 
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 02/14] dt-bindings: bus: imx-weim: convert to YAML
Message-ID: <rbhozhrww74j2hkhx5fcqc7edi6zlnjt6fg3onfn4jqumxem27@kaxyyrbbfplw>
References: <20240210012114.489102-1-sre@kernel.org>
 <20240210012114.489102-3-sre@kernel.org>
 <20240212131631.GA13910-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240212131631.GA13910-robh@kernel.org>

Hi Rob,

On Mon, Feb 12, 2024 at 07:16:31AM -0600, Rob Herring wrote:
> [...]
> > +examples:
> > +  - |
> > +    weim@21b8000 {
> 
> bus or external-bus

I used "memory-controller", which is what the other bindings in
memory-controller use.

-- Sebastian


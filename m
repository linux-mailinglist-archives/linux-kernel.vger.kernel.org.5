Return-Path: <linux-kernel+bounces-160293-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 25A658B3B82
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 17:31:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBC2A1F2260F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 15:31:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1C3614A088;
	Fri, 26 Apr 2024 15:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZBqGc7O3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1328314900B;
	Fri, 26 Apr 2024 15:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714145415; cv=none; b=PR2PL2g0lMOMh9HXWtZcVlUEaP/A1rQc2vfglVi1UJQceXj97VJ1Dk4wWf1OfXqY7mlKqc/yShrIbOnQXeMVmXiuPCrS1JIKapin6YVp1y+V7YnJW1kCyIN3G7pqeL55Z6DFu3p3nLzwZNIwF0y7xEqHyLULnXI7bYuDsI9rM+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714145415; c=relaxed/simple;
	bh=eZDyOOOoP7q4G7IjpLL4ncDtu1i7nV32WzyVZ3osXkk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TQZLabvlZyYP9uIKhad1WRLw8oMMRcTPrMdyU5Rms2Ta8cnpTL8C6D5/AC6fQS+5zY5kC38nPzIblE4UmnkGPuqT2czgaWHgtJK+jbPeAt/rEsgN56/uH75WfH86li5BTcl+qGdj/fK/jm/oL6D+WLcOI6mEpVncOyT55esLQ4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZBqGc7O3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53343C116B1;
	Fri, 26 Apr 2024 15:30:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714145414;
	bh=eZDyOOOoP7q4G7IjpLL4ncDtu1i7nV32WzyVZ3osXkk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZBqGc7O3HZH5bTPvMsxWHWOYGS6m4xLL7gji8LEsIMpSHxuCv0awqC5UoaH8CHR2x
	 sxN0TiXapJ+dqO81S7sGeg8MArTR1LVBUkEb0041NjdrXyAIqB1G/zIPpzQwiKZI+f
	 DLjFF5K4Muy1eRbNb7SUg6y+ytLxqZPke/Huila1nk6A3KLDQAWbjMnSm7Sb9sYK2Z
	 fR6LytiIOLQtAlR/gqpqoW1djNA0cjV4B3WM270At05t/RMUZjI+wDBk6Hc3mtVtJf
	 cZqg4BiFUQaEL+6Yb3fPdjIl1FNsGNW13kKjdw3U0yy95i2DLnZOs98M+bNrdwjLop
	 1pwW65v0PfoWQ==
Date: Fri, 26 Apr 2024 10:30:10 -0500
From: Rob Herring <robh@kernel.org>
To: Christophe Roullier <christophe.roullier@foss.st.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, Marek Vasut <marex@denx.de>,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 02/11] dt-bindings: net: add phy-supply property for
 stm32
Message-ID: <20240426153010.GA1910161-robh@kernel.org>
References: <20240426125707.585269-1-christophe.roullier@foss.st.com>
 <20240426125707.585269-3-christophe.roullier@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240426125707.585269-3-christophe.roullier@foss.st.com>

On Fri, Apr 26, 2024 at 02:56:58PM +0200, Christophe Roullier wrote:
> Phandle to a regulator that provides power to the PHY. This
> regulator will be managed during the PHY power on/off sequence.
> 
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Christophe Roullier <christophe.roullier@foss.st.com>
> ---
>  Documentation/devicetree/bindings/net/stm32-dwmac.yaml | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/net/stm32-dwmac.yaml b/Documentation/devicetree/bindings/net/stm32-dwmac.yaml
> index b901a432dfa9..7c3aa181abcb 100644
> --- a/Documentation/devicetree/bindings/net/stm32-dwmac.yaml
> +++ b/Documentation/devicetree/bindings/net/stm32-dwmac.yaml
> @@ -84,6 +84,9 @@ properties:
>            - description: offset of the control register
>            - description: field to set mask in register
>  
> +  phy-supply:
> +    description: PHY regulator

This is for which PHY? The serdes phy or ethernet phy? This only makes 
sense here if the phy is part of the MAC. Otherwise, it belongs in the 
phy node.

Rob


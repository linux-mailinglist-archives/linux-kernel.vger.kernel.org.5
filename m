Return-Path: <linux-kernel+bounces-43461-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB20C841432
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 21:24:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 035371C23FB7
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 20:24:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FE6C7605F;
	Mon, 29 Jan 2024 20:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EnQ7uZ34"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BCD37603D;
	Mon, 29 Jan 2024 20:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706559860; cv=none; b=rxOEK0bGBr/Pc6BmTFYwyas0BkBthfBRLAiuitbjNC8N4nMAp1FRiGXewZLCeV/0WdySQ4mSocM4u9r9kkBrpQoCb8AZomjZXGhc8YJ25FZ77odXsg0O/4II0h0NECSRHFf6JhsOEqIvzj4OeDbXO52bDp3B4nJx5PhOsjO2Pyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706559860; c=relaxed/simple;
	bh=rAnCgDX130n4Pu5xvGz9+ytgomDscbf8iqQYRZN9m/w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ze5G/Hh2K4m0/5ynRbAQe2wehOe4Lm9Lmr4R/RVvK4QO2kpPuab499hdK1UZxBPEINDZxhyZfssF/RLIeQb3DBikWDmx6LqeVhrGil0E/ZyByfQcIcWmTo7ZHTq4wjQipCy4rC0vRlg+ht2FEZ5fn0SobrlTn22ZOc4Po+pkQHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EnQ7uZ34; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEB3DC433C7;
	Mon, 29 Jan 2024 20:24:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706559859;
	bh=rAnCgDX130n4Pu5xvGz9+ytgomDscbf8iqQYRZN9m/w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=EnQ7uZ34Ob53zG2/8P4qFAZnQWAPouiVzki80qVjA3PDp+Kad4GQq8qJxCOT2sZG7
	 lfO/tIzu4Xz+mxMVoOR8Cz2oZzLI6m0bWhNjxKoCXayZS1yREWDp8O0Y4De/BX17C0
	 ybrbHX0tZk5IWnd7jUrgdWVbKLa9SJK5IStnOIh3Fba8Sqab6Sty1L2GQ1xqeKygSL
	 YOinnmVlw9QitytUiQ6Q1MccwF2tPYhUncXmaTLjK8gZ4kfiYucbE32dfJBzX2bT9l
	 1CsUmVX0nsSXgTZV2rN/uyeJR55C21tHp/yrQ8C6YR0uiPqBJjbkpjNabQ7dpv5GCM
	 sTJn7jatBtHUA==
Date: Mon, 29 Jan 2024 12:24:18 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
 <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Emil Renner Berthing <kernel@esmil.dk>, Samin Guo
 <samin.guo@starfivetech.com>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, Jose Abreu <joabreu@synopsys.com>, Maxime
 Coquelin <mcoquelin.stm32@gmail.com>, Giuseppe Cavallaro
 <peppe.cavallaro@st.com>, Andrew Lunn <andrew@lunn.ch>, Jacob Keller
 <jacob.e.keller@intel.com>, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, kernel@collabora.com
Subject: Re: [RESEND PATCH v4 1/2] dt-bindings: net: starfive,jh7110-dwmac:
 Add JH7100 SoC compatible
Message-ID: <20240129122418.173133d7@kernel.org>
In-Reply-To: <20240126192128.1210579-2-cristian.ciocaltea@collabora.com>
References: <20240126192128.1210579-1-cristian.ciocaltea@collabora.com>
	<20240126192128.1210579-2-cristian.ciocaltea@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 26 Jan 2024 21:21:25 +0200 Cristian Ciocaltea wrote:
> The Synopsys DesignWare MAC found on StarFive JH7100 SoC is mostly
> similar to the newer JH7110, but it requires only two interrupts and a
> single reset line, which is 'ahb' instead of the commonly used
> 'stmmaceth'.
> 
> Since the common binding 'snps,dwmac' allows selecting 'ahb' only in
> conjunction with 'stmmaceth', extend the logic to also permit exclusive
> usage of the 'ahb' reset name.  This ensures the following use cases are
> supported:
> 
>   JH7110: reset-names = "stmmaceth", "ahb";
>   JH7100: reset-names = "ahb";
>   other:  reset-names = "stmmaceth";
> 
> Also note the need to use a different dwmac fallback, as v5.20 applies
> to JH7110 only, while JH7100 relies on v3.7x.
> 
> Additionally, drop the reset description items from top-level binding as
> they are already provided by the included snps,dwmac schema.

Reposting review tag from:
https://lore.kernel.org/all/0a6f6dcb-18b0-48d5-8955-76bce0e1295d@linaro.org/

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


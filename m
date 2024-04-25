Return-Path: <linux-kernel+bounces-158909-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F9BE8B2691
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 18:33:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C04C3286789
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 16:33:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33C7414AD3A;
	Thu, 25 Apr 2024 16:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H9m/t2+M"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74CFC1DFEF;
	Thu, 25 Apr 2024 16:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714062796; cv=none; b=kxGx9DrxsFvBTd3OZaMVtcDLLJTeyACpjDCyUYU+S6xocgjytsHskoyXB7OOyydWsf3rD2GnBYu6JAVZC0ZYujOHW2CYZ+2j2LeXYqK1xoTjDJyk4Lf47BzrDGUOFnd+fYFZRxK+TxxcrykKIQ09Ja00nEFALI6bNobCWd2qeOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714062796; c=relaxed/simple;
	bh=unk5RWaGTgzPGQje4Y5TMYOXddYese+yJYh1sfQl5CQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sA0+ArKNoizSxNZ2yqSWXloWUvNQ+/mgJi35xrMOwEfpphVEZFpZYrnuI/wXriyx+JSx0m34i6ns75Tn2X0c9il1W8c8eE0+GFSY5kwz/OnySzZAHHGuUaTH0eJVOxF15XLei1G/E7xhylJuhogY/vy6/8N058aSamSc4nrW5Go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H9m/t2+M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B871AC113CE;
	Thu, 25 Apr 2024 16:33:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714062796;
	bh=unk5RWaGTgzPGQje4Y5TMYOXddYese+yJYh1sfQl5CQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=H9m/t2+MxKQg87LfGPAbtU4gPxmHbkTTRZPF8Nj+UeJsAQO/GCoId2DlkNsYIaNsq
	 CakBdrGiXDx3YWkIE5W9CD5oL4x3syGrOvgYtxXr4qCInmKKv560JavAewxtrCjeKB
	 v0CaP76od/AQgDrpq9rUHz6cpzv1rCMUN8RRjq2v7kdhi3XVUN4H5tiaAvyRt2gv0+
	 +qJnChUwud16RfIwHnzg1ENv0GvSvF6jxaRxFZGrvoxwgykYXro/PU+PhMi009tWmM
	 wWVaiYZTo033v1dpJkRrdYnpmO0Dz9+RI6sW+YEt67cXRDaWR762/vV64dvWj6yLSb
	 7cDVKUpUa414A==
Date: Thu, 25 Apr 2024 11:33:13 -0500
From: Rob Herring <robh@kernel.org>
To: Niko Pasaloukos <nikolaos.pasaloukos@blaize.com>
Cc: linux-kernel@vger.kernel.org, andre.przywara@arm.com,
	catalin.marinas@arm.com, geert+renesas@glider.be,
	konrad.dybcio@linaro.org, u-kumar1@ti.com, andersson@kernel.org,
	m.szyprowski@samsung.com, James Cowgill <james.cowgill@blaize.com>,
	macromorgan@hotmail.com, sre@kernel.org,
	Neil Jones <neil.jones@blaize.com>, shawnguo@kernel.org,
	hvilleneuve@dimonoff.com, nfraprado@collabora.com, arnd@arndb.de,
	conor+dt@kernel.org, will@kernel.org,
	Matt Redfearn <matthew.redfearn@blaize.com>, olof@lixom.net,
	krzysztof.kozlowski+dt@linaro.org, heiko.stuebner@cherry.de,
	rafal@milecki.pl, linus.walleij@linaro.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	neil.armstrong@linaro.org
Subject: Re: [PATCH v3 1/5] dt-bindings: Add Blaize vendor prefix
Message-ID: <171406274889.2798626.24856398780490557.robh@kernel.org>
References: <20240425091403.17483-1-nikolaos.pasaloukos@blaize.com>
 <20240425091403.17483-2-nikolaos.pasaloukos@blaize.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240425091403.17483-2-nikolaos.pasaloukos@blaize.com>


On Thu, 25 Apr 2024 09:15:03 +0000, Niko Pasaloukos wrote:
> Blaize, Inc. (www.blaize.com) is a SoC manufacturer with integrated
> programmable Graph-Streaming-Processors for AI and ML.
> 
> Signed-off-by: Nikolaos Pasaloukos <nikolaos.pasaloukos@blaize.com>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>



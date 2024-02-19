Return-Path: <linux-kernel+bounces-71894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EDE885AC3F
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 20:47:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2813B2818CA
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 19:47:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 082D257314;
	Mon, 19 Feb 2024 19:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MDk5bPv5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CE6156B81;
	Mon, 19 Feb 2024 19:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708371886; cv=none; b=lVZM9ZcSCZc1h1/NYqCxnJgiFSdgf3tcMIaXoagXsB6TNStbdhP9m4KRBy+MnBDX40Bt763BB6RhWp9U+oAzlj5oYaAOP2d2YTqoVb8kgUsbZf9ORvbmb57wth9aCvNN0m/l8CLX1FxY4KSbe2EFzs3IMLkHv9oaZT5FdDWROyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708371886; c=relaxed/simple;
	bh=ud1M5tHGoLyKMt1LKZdUby9qBHvA4AvbqrgIKz12Ak0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MZz+PJDf2KAGQOOXeFQ+3xppmqLJPujj19N2Ca+nh8ZRM0bTuq4ltBg281rMwudbk8IdVw++h0EOc2w97FhJ3qlkHCaICAAmYm/3ZlULqPqwY9G85nKj+iS+tYR72Cvr/KCFzFhZyXBWcOjmd5GSEYTV/uPYVm4bhQ1QTYmXpiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MDk5bPv5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E04BEC4166C;
	Mon, 19 Feb 2024 19:44:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708371885;
	bh=ud1M5tHGoLyKMt1LKZdUby9qBHvA4AvbqrgIKz12Ak0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MDk5bPv53i7xa4DJ/jwSYizHplgkE2DCSVVC9NNjIO38ExWaJuUUKELahXc0PWYjm
	 cp0aVB38pO2AluEL/P2pINi7OaC74oisp2H/ZB11jNIAYVhiPyY3I9IFuOTT59fhgG
	 PajJlUvCgs2vHOn9nMYjiJ5tpu3aIh2xBxkz0V5scgn5/hPMAnGUsgQyh2CZCHE3Dp
	 QC6iXPAipQZ2nh2wzDxM0M8faZxnmSF6ciyjwlLIYvvT0XjoJlMPycmP1+ObtGhLSF
	 hIsMwPSo6SK56NRyad58cJaCEEdQcGwA8uj/vtNPE8RsOctQBMQqeLpG1i/aQWrSCq
	 YWydfDpUPSw7A==
Date: Mon, 19 Feb 2024 11:44:43 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Frank Li <Frank.li@nxp.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Ulf Hansson
 <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>, Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer
 <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>, Wei
 Fang <wei.fang@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>, Clark Wang
 <xiaoning.wang@nxp.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, imx@lists.linux.dev
Subject: Re: [PATCH v2 2/4] dt-bindings: net: fec: add iommus property
Message-ID: <20240219114443.777fc3b3@kernel.org>
In-Reply-To: <668c1511-4ee6-4fad-9b7e-7783b6853988@linaro.org>
References: <20240201-8qm_smmu-v2-0-3d12a80201a3@nxp.com>
	<20240201-8qm_smmu-v2-2-3d12a80201a3@nxp.com>
	<49dbd0a2-a4b9-4c05-bb10-44f267672374@linaro.org>
	<Zc+2EitZrVzLsA03@lizhi-Precision-Tower-5810>
	<668c1511-4ee6-4fad-9b7e-7783b6853988@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 17 Feb 2024 09:18:33 +0100 Krzysztof Kozlowski wrote:
> >> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>  
> > 
> > Other 3 patches already been linux-next. Who will pick this one?  
> 
> Resend it to net-next (with proper title).

I happened to notice the discussion, let me take the v2. Thanks!


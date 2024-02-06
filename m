Return-Path: <linux-kernel+bounces-54713-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C09DB84B2CA
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 11:52:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4910FB24EDC
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 10:52:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B86485C7B;
	Tue,  6 Feb 2024 10:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="X8OVrjJk"
Received: from mail-177131.yeah.net (mail-177131.yeah.net [123.58.177.131])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A92231EB24;
	Tue,  6 Feb 2024 10:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=123.58.177.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707216751; cv=none; b=KBXR1zgIsCMCeSVP7tGIz203adSDJSs4zKjP4lAO1+UEWTY2QS4jQu5T2piepb+Mz8bMbodkvEf9e8ZdENaM+ct4ylGyYR2r2OQvbnWM46ZdZAdIbUqXIWf6pDtUvP0z+yelr0t4N48jvup6zZkYqEmHI6Fb0qxQvE4plIHmu7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707216751; c=relaxed/simple;
	bh=CnNyJAVVaeaFUmGNhrIfwMWD9WAzXcrMYWAxBqjZww0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VgJsxAImtBCanLmC7+iG5UGRWfGZr6lxciVty6p9hlsIbmfOfSFqXyneKHF4049A0Kig2n8cP10Lshhdfq4lqczhZoELIhKR789Gkz0VM2zEzaXJWyXKmx/crDDSH1T5rhTqzj4mAiZvc3xRzm25OXoxfQ8dd3lHky3B0Vi85Z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=X8OVrjJk; arc=none smtp.client-ip=123.58.177.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=MHHejNAVONdEtgJmkJVwsH6HrCDumM8nH7LqCCxZ7eQ=;
	b=X8OVrjJkddRgwxnjpFow6Anb58NYAgdX7yMrfngAqPnrWELTlxsh4PPfG9i4ac
	P4kipXRuSHqCCS7KtxXDUlgLTwxXsHUGo8DRyy3RTB2H9ZtN55OHLIACL+PsUr5r
	V+axX6J9Q18nJTDhy3a27Lqzra8qm3Il2JP/cLEYpH0pg=
Received: from dragon (unknown [183.213.196.254])
	by smtp1 (Coremail) with SMTP id ClUQrAAHBucLD8Jlqaz+Ag--.16066S3;
	Tue, 06 Feb 2024 18:50:52 +0800 (CST)
Date: Tue, 6 Feb 2024 18:50:51 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Frank Li <Frank.Li@nxp.com>, Ulf Hansson <ulf.hansson@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>, Wei Fang <wei.fang@nxp.com>,
	Shenwei Wang <shenwei.wang@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, imx@lists.linux.dev
Subject: Re: [PATCH v2 0/4] Add 8qm SMMU information
Message-ID: <ZcIPCxgO3Gxc/aXh@dragon>
References: <20240201-8qm_smmu-v2-0-3d12a80201a3@nxp.com>
 <20240202110511.135d26b7@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240202110511.135d26b7@kernel.org>
X-CM-TRANSID:ClUQrAAHBucLD8Jlqaz+Ag--.16066S3
X-Coremail-Antispam: 1Uf129KBjvdXoWrKw45uw4kJFyrWFW7ur47twb_yoWfGrbEqr
	18uFWkGw4kJFnrJayFyrsrG345GrWqkr18WanxXanrA343AF1UtFWkXws5uF18Jr4fCFWD
	Ar9Ygrs29r13KjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU8_MaUUUUUU==
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiDgx8ZVszYTExnwAAsN

On Fri, Feb 02, 2024 at 11:05:11AM -0800, Jakub Kicinski wrote:
> On Thu, 01 Feb 2024 15:22:40 -0500 Frank Li wrote:
> >       dt-bindings: mmc: fsl-imx-esdhc: add iommus property
> >       dt-bindings: net: fec: add iommus property
> >       arm64: dts: imx8qm: add smmu node
> >       arm64: dts: imx8qm: add smmu stream id information
> > 
> >  .../devicetree/bindings/mmc/fsl-imx-esdhc.yaml     |  3 ++
> >  Documentation/devicetree/bindings/net/fsl,fec.yaml |  3 ++
> >  arch/arm64/boot/dts/freescale/imx8qm-ss-conn.dtsi  |  6 ++++
> >  arch/arm64/boot/dts/freescale/imx8qm.dtsi          | 41 ++++++++++++++++++++++
> 
> Any preference on whether all these go via a platform tree,
> or should we pick up the net patch to netdev? I guess taking
> the DTB via netdev would be the usual way to handle this?

No, it's not.  Taking DTS changes through arch/platform tree is the
usual way.

Shawn



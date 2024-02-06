Return-Path: <linux-kernel+bounces-54299-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1463A84AD77
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 05:30:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8795B1F24AD8
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 04:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B880477F19;
	Tue,  6 Feb 2024 04:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="gs1Iw7Y7"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3537954661;
	Tue,  6 Feb 2024 04:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707193830; cv=none; b=fSe8ZtSBOHssCQCV9TNuwM4ETPzlDZ6k7ulcXSUYk2qrGQDYPsBpv4tBpMVcLmxjvEOEQEwMX5Xao4swwTnKLDClowFWgG//OiSaAwJzFcmuKTtHJghi2J0BY1v+TKJx4l3AV5x+b27TyTwZB6gLNMYmoZdOTK7A7aBHali+udM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707193830; c=relaxed/simple;
	bh=+yTSdGWtLUb6Bmj4drhbbSrhid0hTQfMkhPFxeYAhao=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Eq3AMBk2ZgLDbAUeblnhBt9CeCCQFwF/+DQoQ2R2wiXdiBGYYcxTVgcW81UaQaQaBY0g+qalaF9+LPI4/PrSs9VXcuWHkKAvuAWmrgUqdIJV2z91DE+6E2ETZ2iYi+N0pWtezon5iSnpNibrUBY+4OxnCGItJwxmytftIqROm+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=gs1Iw7Y7; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4164UFIU016482;
	Mon, 5 Feb 2024 22:30:15 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1707193815;
	bh=uZ+ZU7hhYwHfE4cyl59KfmHPSdTmqE1e2L/98DVRNpU=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=gs1Iw7Y7KiV2m+J4/DhnCYs/kO0JDnU7LqSkJf/hrHK+Cm2wMB+vS+xmJgWPtuSNP
	 mWcOIhentFEwYWFBMwRjdBKlIEf3grml0im9HqmA1J8NWHeG1ut3ipyZYbyje+CSYA
	 WmQrclQor6qvLtGfwPAREhXjLt30rNhcQAfk/HKY=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4164UFtC030704
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 5 Feb 2024 22:30:15 -0600
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 5
 Feb 2024 22:30:14 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 5 Feb 2024 22:30:13 -0600
Received: from uda0132425.dhcp.ti.com (uda0132425.dhcp.ti.com [172.24.227.94])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4164UAHr085511;
	Mon, 5 Feb 2024 22:30:10 -0600
From: Vignesh Raghavendra <vigneshr@ti.com>
To: <linux-arm-kernel@lists.infradead.org>,
        Sjoerd Simons
	<sjoerd@collabora.com>
CC: Vignesh Raghavendra <vigneshr@ti.com>, Roger Quadros <rogerq@kernel.org>,
        <kernel@collabora.com>, Conor Dooley <conor+dt@kernel.org>,
        Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>,
        Tero Kristo <kristo@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arm64: dts: ti: k3-am625-beagleplay: Use the builtin mdio bus
Date: Tue, 6 Feb 2024 09:59:59 +0530
Message-ID: <170719349980.2245010.17097111330669476352.b4-ty@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240112124505.2054212-1-sjoerd@collabora.com>
References: <20240112124505.2054212-1-sjoerd@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Sjoerd Simons,

On Fri, 12 Jan 2024 13:44:55 +0100, Sjoerd Simons wrote:
> The beagleplay dts was using a bit-bang gpio mdio bus as a work-around
> for errata i2329. However since commit d04807b80691 ("net: ethernet: ti:
> davinci_mdio: Add workaround for errata i2329") the mdio driver itself
> already takes care of this errata for effected silicon, which landed
> well before the beagleplay dts. So i suspect the reason for the
> workaround in upstream was simply due to copying the vendor dts.
> 
> [...]

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/1] arm64: dts: ti: k3-am625-beagleplay: Use the builtin mdio bus
      commit: 3c3f2d13d3c8e748ebdebfc6d8a72024240227e9

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent up the chain during
the next merge window (or sooner if it is a relevant bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/ti/linux.git
--
Vignesh



Return-Path: <linux-kernel+bounces-76586-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A88C385F997
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 14:23:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F128287D55
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 13:23:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C24E413473F;
	Thu, 22 Feb 2024 13:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="bNzOX7jY"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D62B3F9ED;
	Thu, 22 Feb 2024 13:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708608165; cv=none; b=oAaYvkCH/Z3vWK6OOmJ0Q34wIGsQoujYHb72mW1PdltXRM2YStsAwBn4WpClR5Ei2Y4zKvDWmXF7qafnEBGhPteNUHNIFejy2W2MZfrP3bG5/txCQhWzkrhxGQdYSsOOTQj63Kv4wVLnHZ83Y6+9AZGZhhYIS7zeu+HvupCLY/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708608165; c=relaxed/simple;
	bh=eBYXIyM7l7L2CPD4PZhB6FUIsDNqhBJx3bdqZp3tWg4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XOfzg/6ZDn9CakRQJXFcdYk8RJGp7yXqVNJU0rstMNJ1CnMI/4R1y/1/hV6xgSP8ZYw553YcxBMpQSzAxzKhl5u2oOsLlMlu9imDNiJwkfili5W4vXJhcL6VBzwh2pk4to+NBI4aPJj11/1sMv7PvUAkoSxR4A8g/XGwPgggkI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=bNzOX7jY; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41MDMZLD046755;
	Thu, 22 Feb 2024 07:22:35 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1708608155;
	bh=XgfpVgHH1tgrJ5dLNBy/JKfod6zFSg3RNVRg+hVXmEo=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=bNzOX7jYKJtuRVFz4CF/+dZ0IteuFbYrcHXSawakmYBK5KAOSW9P74YH6x/yww1wI
	 sDqR83VRj2V70Q71oDfAxcViSlNMAt8KeyE+AXzLn4hPZjCXnUAGCtldhwrmAnEhFh
	 OMi+MVtsTI2Mb8ZonCeJEVs7wPMZxB0/W2gud56M=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41MDMZmX120727
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 22 Feb 2024 07:22:35 -0600
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 22
 Feb 2024 07:22:35 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 22 Feb 2024 07:22:35 -0600
Received: from uda0132425.dhcp.ti.com (uda0132425.dhcp.ti.com [172.24.227.94])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41MDMVWF008883;
	Thu, 22 Feb 2024 07:22:32 -0600
From: Vignesh Raghavendra <vigneshr@ti.com>
To: <nm@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        Vaishnav Achath
	<vaishnav.a@ti.com>
CC: Vignesh Raghavendra <vigneshr@ti.com>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <u-kumar1@ti.com>,
        <s-vadapalli@ti.com>
Subject: Re: [PATCH v2 0/2] Add OSPI and Ethernet support on J722S EVM
Date: Thu, 22 Feb 2024 18:52:28 +0530
Message-ID: <170860805562.1966114.3015232602049266823.b4-ty@ti.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240219090435.934383-1-vaishnav.a@ti.com>
References: <20240219090435.934383-1-vaishnav.a@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Vaishnav Achath,

On Mon, 19 Feb 2024 14:34:33 +0530, Vaishnav Achath wrote:
> This series adds support for Ethernet and OSPI NOR flash on J722S EVM.
> 
> V1: https://lore.kernel.org/all/20240216135533.904130-1-vaishnav.a@ti.com/
> 
> Changelog:
> V1->V2:
>   * Update comments indicating PAD numbers.
> 
> [...]

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/2] arm64: dts: ti: k3-j722s-evm: Enable CPSW3G RGMII1
      commit: 9aa197b64df4c382763f032a31b35cad92cbce17
[2/2] arm64: dts: ti: k3-j722s-evm: Enable OSPI NOR support
      commit: 2e53b9c05a1589577565625fdb45cf918b54eb39

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



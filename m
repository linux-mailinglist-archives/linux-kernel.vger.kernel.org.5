Return-Path: <linux-kernel+bounces-66525-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 93CC7855DE8
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 10:25:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 498D91F21C58
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 09:25:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC1D71755E;
	Thu, 15 Feb 2024 09:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="aP94wqFb"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 938BBDDA5;
	Thu, 15 Feb 2024 09:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707989105; cv=none; b=TWaThs519h3FmxZ53MD8KhxNNBbECFxRt0YJe7jcdTrSCKgPK1qWd2cpgaZ1vXz4vMD9XbRgEbpEJpt6M1wvyVTmUH4B+qC3Vs8pdcE1brCGJlNE3pvc/mVALFXGXbeWcRpOlZcNhZGHS3qI9xO8eUEg1BkAEJF5YcfnJeM9Cqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707989105; c=relaxed/simple;
	bh=Tt8BCHmtbJz3x2cgOU1o7/jB7h4WOyYohMZqaQf1V7Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qBaANYykppiNpafoDnvoNOLL7FAwJoktoLd/+1uf5h0rqidKrtFfy/cXCu0mGQ8Dt+7GWXRAbFE5PbNkbfqpg23b2UggDnWZaUVf2MpT9azokbFd3KgCG2KtQL3GIhR6BvZ3yr3EjxQG3o/WYGezrFuH/e1jBke8QnP7NbhiDs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=aP94wqFb; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41F9Op96082808;
	Thu, 15 Feb 2024 03:24:51 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1707989091;
	bh=nWwyC19a93cQ/YZxeF9xsq+xSAyx/j26ftFvPq9oipU=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=aP94wqFbPSWkEW0vE2JnvjbuQQw2rilYXc0rsG0Cw9qms+8GkaN0qfsSfTCD+dDKw
	 luIo7gdt8t4woIbESihzat51WdGg3nbp/ObZJ2JUKsfkgJEvBTblRHQrhf5/sIWWep
	 eCKoL5bqAjclDktGciV34F8nCC1kYxU8SR0LXlNk=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41F9OpI4010077
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 15 Feb 2024 03:24:51 -0600
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 15
 Feb 2024 03:24:50 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 15 Feb 2024 03:24:50 -0600
Received: from uda0132425.dhcp.ti.com (uda0132425.dhcp.ti.com [172.24.227.94])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41F9Ojht098491;
	Thu, 15 Feb 2024 03:24:45 -0600
From: Vignesh Raghavendra <vigneshr@ti.com>
To: Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring
	<robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, Roger Quadros <rogerq@kernel.org>
CC: Vignesh Raghavendra <vigneshr@ti.com>, Andrew Davis <afd@ti.com>,
        "Tomi
 Valkeinen" <tomi.valkeinen@ideasonboard.com>,
        Aradhya Bhatia
	<a-bhatia1@ti.com>,
        Nikhil Devshatwar <nikhil.nd@ti.com>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <srk@ti.com>, <r-gunasekaran@ti.com>,
        "Roger
 Quadros" <rogerq@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [PATCH v2 0/3] arm64: dts: ti: am65x: Add PCIe + USB DT overlay files
Date: Thu, 15 Feb 2024 14:54:34 +0530
Message-ID: <170798904376.1504164.3974928327305600054.b4-ty@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240208-for-v6-9-am65-overlays-2-0-v2-0-70bae3e91597@kernel.org>
References: <20240208-for-v6-9-am65-overlays-2-0-v2-0-70bae3e91597@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Roger Quadros,

On Thu, 08 Feb 2024 15:51:42 +0200, Roger Quadros wrote:
> There are 2 types of (PCIe + USB) expansion cards that are provided with
> the AM654 board configurations.
> 
> 1) 2 lane PCIe + USB 2.0 card is supplied with the AM65 IDK
> configuration [1]
> 
> 2) 1 lane PCIe + USB 3.0 card is supplied with the AM65 GP EVM
> configuration [2]
> 
> [...]

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/3] arm64: dts: ti: am65x: Fix dtbs_install for Rocktech OLDI overlay
      commit: 8ada14cafc5e185c668198617cd1ab4f1d8d325a
[2/3] arm64: dts: ti: Add DT overlay for PCIe + USB2.0 SERDES personality card
      commit: aea902b9e0cb9c596aa2e70a9c8d7d7a15673e45
[3/3] arm64: dts: ti: Add DT overlay for PCIe + USB3.0 SERDES personality card
      commit: c472011e7aeef5f7a7d9f40c3c275d8ab82aa745

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



Return-Path: <linux-kernel+bounces-72301-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD29E85B1C6
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 04:58:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD26E1C2138D
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 03:58:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2D7353E3B;
	Tue, 20 Feb 2024 03:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="L60vt8Mn"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A05056B6C;
	Tue, 20 Feb 2024 03:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708401492; cv=none; b=NPrvWAP/ldwbBWOUXRyb3lGIvg+H64eyjuv4xV86xuWoGBFvKeKVXd5ekYEwmNfTw7upW0UeU6o9Zx5PAzJiIH5A1bVlWtjh6cBT6U0v8z/enxkHHWcEPNEKJcOMfbXbfkeJuvWzvUQJ8z/NMxoP7LlgxMcIbA2nGKevuschaR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708401492; c=relaxed/simple;
	bh=xY21TrYgRf9Tcfctkax8mubEdKgrpRSLNOmgJbgOMwM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AyjgT5ZKTAavsnOuzLYsbac/mJgW4eKNZR/FG5IsoXcpOD2UXHnWYUXMpOcNgN2XDHP5qjRPkXgvQIcD+0aVGwpWEEyLvisJ3BHFnUiuhTYFWt5xdUNNUBF6AAi1vnKmWjPRJoLyr40+bUSmAGiTbWABCDKUJpYS3V7I3oXj05U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=L60vt8Mn; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41K3w23R103060;
	Mon, 19 Feb 2024 21:58:02 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1708401482;
	bh=Stc6ty4USFcruP8JZ92a6Oznf8p4/NzSisP+mOwvfGo=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=L60vt8MnTZE/j6BY+y3VL125SagW7YFIhIaYAsgQOx4M4basxt8WTMXhub7T87Cki
	 luCKxeP4YJR2EqhG2pH5+GXbIh/hdZwIY87zBCLUUKBLtDx+omfb17go2impFodW+l
	 WJ/N6yZjRFD0FXJ736+MQSYpifPsZVdtumoIY2oc=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41K3w21w128680
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 19 Feb 2024 21:58:02 -0600
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 19
 Feb 2024 21:58:02 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 19 Feb 2024 21:58:02 -0600
Received: from uda0132425.dhcp.ti.com (uda0132425.dhcp.ti.com [172.24.227.94])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41K3vwaG060012;
	Mon, 19 Feb 2024 21:57:58 -0600
From: Vignesh Raghavendra <vigneshr@ti.com>
To: Nishanth Menon <nm@ti.com>, MD Danish Anwar <danishanwar@ti.com>
CC: Vignesh Raghavendra <vigneshr@ti.com>, Andrew Lunn <andrew@lunn.ch>,
        Conor
 Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        Tero Kristo <kristo@kernel.org>, <srk@ti.com>, <r-gunasekaran@ti.com>,
        Roger Quadros <rogerq@kernel.org>
Subject: Re: [PATCH v5 0/3] Add AM64x ICSSG Ethernet support
Date: Tue, 20 Feb 2024 09:27:56 +0530
Message-ID: <170834878955.3471454.4379641943483865314.b4-ty@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240215103036.2825096-1-danishanwar@ti.com>
References: <20240215103036.2825096-1-danishanwar@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi MD Danish Anwar,

On Thu, 15 Feb 2024 16:00:33 +0530, MD Danish Anwar wrote:
> This series adds support for ICSSG ethernet on AM64x.
> This series is based on the latest next-20240214 linux-next.
> 
> AM64x EVM has three ethernet ports. One is dedicated to CPSW and one is
> dedicated to ICSSG1. The remaining port is muxed between CPSW and ICSSG1
> ICSSG1 ports. The ICSSG1 node is added in the k3-am642-evm.dts. By default
> the muxed port is used by CPSW so 2nd ICSSG1 port is disabled in the
> k3-am642-evm.dts. But overlay k3-am642-evm-icssg1-dualemac.dtso can be
> applied to use muxed port as ICSSG1.
> 
> [...]

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/3] arm64: dts: ti: k3-am64-main: Add ICSSG IEP nodes
      commit: d4e8c8ad5d14ad51ed8813442d81c43019fd669d
[2/3] arm64: dts: ti: k3-am642-evm: add ICSSG1 Ethernet support
      commit: efb32a10a10d92f4bc3380106bd3b003ea790aa3
[3/3] arm64: dts: ti: k3-am642-evm: add overlay for ICSSG1 2nd port
      commit: ae0aba1218a0c67f144706c48502f534b2756491

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


